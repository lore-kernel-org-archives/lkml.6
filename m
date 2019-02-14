Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AE52229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qjW0mNtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407066AbfBNNdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:33:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41782 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394770AbfBNNdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:33:31 -0500
Received: from zn.tnic (p200300EC2BCDFC008528D8D3AD4EA9C4.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:fc00:8528:d8d3:ad4e:a9c4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBC0A1EC01B6;
        Thu, 14 Feb 2019 14:33:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550151210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Zw2RE41LBP8lKQBVPPQFPbbzE/BqdVCdNlShQ7Ih2Uo=;
        b=qjW0mNtRphAKtl8umMQM4HJav7Dmvm0DczHwvSnF4A2BXKIAmXJgHLMwy5GyML1dnkd873
        hF1y/f3Uz5Msd0QWBMWf/JbZ/Sow6ClEb0MIQ8TNaAyQOGEZFQqsvVdP6fNW0eR65B3Sk5
        ehHaMed7Izwc8zC246k48zvYEXDu5O4=
Date:   Thu, 14 Feb 2019 14:33:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 8/9] jump_label: Batch updates if arch supports it
Message-ID: <20190214133301.GA4423@zn.tnic>
References: <cover.1549308412.git.bristot@redhat.com>
 <a36bfdbc63c5848adfaa1a466a90b62391fd2289.1549308412.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a36bfdbc63c5848adfaa1a466a90b62391fd2289.1549308412.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 08:59:01PM +0100, Daniel Bristot de Oliveira wrote:
> If the architecture supports the batching of jump label updates, use it!
> 
> An easy way to see the benefits of this patch is switching the
> schedstats on and off. For instance:
> 
> -------------------------- %< ----------------------------
> #!/bin/bash
> 
> while [ true ]; do
>     sysctl -w kernel.sched_schedstats=1
>     sleep 2
>     sysctl -w kernel.sched_schedstats=0
>     sleep 2
> done
> -------------------------- >% ----------------------------
> 
> while watching the IPI count:
> 
> -------------------------- %< ----------------------------
> # watch -n1 "cat /proc/interrupts | grep Function"
> -------------------------- >% ----------------------------
> 
> With the current mode, it is possible to see +- 168 IPIs each 2 seconds,
> while with this patch the number of IPIs goes to 3 each 2 seconds.
> 
> Regarding the performance impact of this patch set, I made two measurements:
> 
>     The time to update a key (the task that is causing the change)
>     The time to run the int3 handler (the side effect on a thread that
>                                       hits the code being changed)
> 
> The schedstats static key was chosen as the key to being switched on and off.
> The reason being is that it is used in more than 56 places, in a hot path. The
> change in the schedstats static key will be done with the following command:
> 
> while [ true ]; do
>     sysctl -w kernel.sched_schedstats=1
>     usleep 500000
>     sysctl -w kernel.sched_schedstats=0
>     usleep 500000
> done
> 
> In this way, they key will be updated twice per second. To force the hit of the
> int3 handler, the system will also run a kernel compilation with two jobs per
> CPU. The test machine is a two nodes/24 CPUs box with an Intel Xeon processor
> @2.27GHz.
> 
> Regarding the update part, on average, the regular kernel takes 57 ms to update
> the schedstats key, while the kernel with the batch updates takes just 1.4 ms
> on average. Although it seems to be too good to be true, it makes sense: the
> schedstats key is used in 56 places, so it was expected that it would take
> around 56 times to update the keys with the current implementation, as the
> IPIs are the most expensive part of the update.
> 
> Regarding the int3 handler, the non-batch handler takes 45 ns on average, while
> the batch version takes around 180 ns. At first glance, it seems to be a high
> value. But it is not, considering that it is doing 56 updates, rather than one!
> It is taking four times more, only. This gain is possible because the patch
> uses a binary search in the vector: log2(56)=5.8. So, it was expected to have
> an overhead within four times.
> 
> (voice of tv propaganda) But, that is not all! As the int3 handler keeps on for
> a shorter period (because the update part is on for a shorter time), the number
> of hits in the int3 handler decreased by 10%.
> 
> The question then is: Is it worth paying the price of "135 ns" more in the int3
> handler?
> 
> Considering that, in this test case, we are saving the handling of 53 IPIs,
> that takes more than these 135 ns, it seems to be a meager price to be paid.
> Moreover, the test case was forcing the hit of the int3, in practice, it
> does not take that often. While the IPI takes place on all CPUs, hitting
> the int3 handler or not!
> 
> For instance, in an isolated CPU with a process running in user-space
> (nohz_full use-case), the chances of hitting the int3 handler is barely zero,
> while there is no way to avoid the IPIs. By bounding the IPIs, we are improving
> a lot this scenario.

I like that commit message.

> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Chris von Recklinghausen <crecklin@redhat.com>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Scott Wood <swood@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>

What happened here? Your signing tool went nuts? :-)

> ---
>  include/linux/jump_label.h |  3 +++
>  kernel/jump_label.c        | 29 +++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index 7e91af98bbb1..b3dfce98edb7 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -215,6 +215,9 @@ extern void arch_jump_label_transform(struct jump_entry *entry,
>  				      enum jump_label_type type);
>  extern void arch_jump_label_transform_static(struct jump_entry *entry,
>  					     enum jump_label_type type);
> +extern int arch_jump_label_transform_queue(struct jump_entry *entry,
> +					    enum jump_label_type type);
> +extern void arch_jump_label_transform_apply(void);
>  extern int jump_label_text_reserved(void *start, void *end);
>  extern void static_key_slow_inc(struct static_key *key);
>  extern void static_key_slow_dec(struct static_key *key);
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 53b7c85c0b09..944c75a0b09b 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -407,6 +407,7 @@ bool jump_label_can_update_check(struct jump_entry *entry, bool init)
>  	return 0;
>  }
>  
> +#ifndef HAVE_JUMP_LABEL_BATCH
>  static void __jump_label_update(struct static_key *key,
>  				struct jump_entry *entry,
>  				struct jump_entry *stop,
> @@ -419,6 +420,34 @@ static void __jump_label_update(struct static_key *key,
>  		}
>  	}
>  }
> +#else
> +static void __jump_label_update(struct static_key *key,
> +				struct jump_entry *entry,
> +				struct jump_entry *stop,
> +				bool init)
> +{
> +	for_each_label_entry(key, entry, stop) {
> +
> +		if (!jump_label_can_update_check(entry, init))
> +			continue;
> +
> +		if (arch_jump_label_transform_queue(entry,
> +						    jump_label_type(entry)))

Let those lines stick out - better than breaking them like that.

> +			continue;
> +
> +		/*
> +		 * Queue's overflow: Apply the current queue, and then
> +		 * queue again. If it stills not possible to queue, BUG!
> +		 */
> +		arch_jump_label_transform_apply();
> +		if (!arch_jump_label_transform_queue(entry,
> +						     jump_label_type(entry))) {

Ditto.

> +			BUG();
> +		}
> +	}
> +	arch_jump_label_transform_apply();
> +}
> +#endif
>  
>  void __init jump_label_init(void)
>  {
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
