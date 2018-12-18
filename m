Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3AEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9DC218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeLRTeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:34:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38237 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeLRTeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:34:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so4004446wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 11:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PCzgjLwpUkqadfqZi//nh5Nx/OlMm9/ZwJTnph0XhqY=;
        b=qhl4l6rskaYd2Z0tIxUIszCIfYOkJNAMCPeIazCfiKs4oPcONesX8rC2Y5z4XrbLx8
         p+OGp6oklCEJI7vx7EaErU7CBSm4URTXkeUK7HoZjDNeKKBMz+36yEpZg+heuE6qbQyq
         kxUDcqkmZyLP4byQ5C3XdC/thZ6YIZYwrmdptefI9PSNyhrIN5mTpA0CW92rZxViW+Gj
         bYoxCqHXJ9+NhrGGdUBHzfyXew3ddSKz0oV0ArzMndAUC5EcrryoNnyKqzQEz3H331UH
         XmRhvyjTD+XOB2W8wFbrTrxg/P54GZTL4ln0cGESOYBRKo3/SrGCFfb1o3DhOLIcXZ8w
         54LQ==
X-Gm-Message-State: AA+aEWZWpY7N6cgaZEw5sgsuiiXj2a6ZO02l/a//+/4Fn382J6HYcy3X
        mL3rR+Cq1KV8pylR5+DJ4ERU0g==
X-Google-Smtp-Source: AFSGD/We7X33alCzcuEnYvRIr93ayQUI9KYWva3+TeqZ60ojkxPafAQuivTPoPV1ny3SJrJ1UxKRww==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr4628020wmj.0.1545161637937;
        Tue, 18 Dec 2018 11:33:57 -0800 (PST)
Received: from t460s.bristot.redhat.com (host252-226-dynamic.249-95-r.retail.telecomitalia.it. [95.249.226.252])
        by smtp.gmail.com with ESMTPSA id l19sm3699600wme.21.2018.12.18.11.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 11:33:57 -0800 (PST)
Subject: Re: [PATCH V2 9/9] jump_label: Batch up if arch supports it
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1545149539.git.bristot@redhat.com>
 <3c212982833e3b27f8610c8389413b81ed5fb0e1.1545149539.git.bristot@redhat.com>
 <20181218123556.5257b1a7@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <d8a417e9-eb0f-d087-f0c5-7405b030e51c@redhat.com>
Date:   Tue, 18 Dec 2018 20:33:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181218123556.5257b1a7@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 6:35 PM, Steven Rostedt wrote:
> On Tue, 18 Dec 2018 17:46:38 +0100
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
> 
> I'd say add this file first, before x86 supports it. That way it's easy
> for you to test if this file is correct for other archs that do not
> support it.
> 
> When x86 supports it, the "on switch" for that should be the added
> config, just like what other architectures will do.

right!

>> If the architecture supports the batching of jump label updates, use it!
>>
>> An easy way to see the benefits of this patch is switching the
>> schedstats on and off. For instance:
>>
>> -------------------------- %< ---------------------------- 
>> #!/bin/bash
>>
>> while [ true ]; do 
>>     sysctl -w kernel.sched_schedstats=1
>>     sleep 2
>>     sysctl -w kernel.sched_schedstats=0
>>     sleep 2
>> done
>> -------------------------- >% ----------------------------  
>>
>> while watching the IPI count:
>>
>> -------------------------- %< ---------------------------- 
>> # watch -n1 "cat /proc/interrupts | grep Function"
>> -------------------------- >% ----------------------------  
>>
>> With the current mode, it is possible to see +- 168 IPIs each 2 seconds,
>> while with this patch the number of IPIs goes to 3 each 2 seconds.
>>
>> Regarding the performance impact of this patch set, I made two measurements:
>>
>>     The time to update a key (the task that is causing the change)
>>     The time to run the int3 handler (the side effect on a thread that
>>                                       hits the code being changed)
>>
>> The schedstats static key was chosen as the key to being switched on and off.
>> The reason being is that it is used in more than 56 places, in a hot path. The
>> change in the schedstats static key will be done with the following command:
>>
>> while [ true ]; do
>>     sysctl -w kernel.sched_schedstats=1
>>     usleep 500000
>>     sysctl -w kernel.sched_schedstats=0
>>     usleep 500000
>> done
>>
>> In this way, they key will be updated twice per second. To force the hit of the
>> int3 handler, the system will also run a kernel compilation with two jobs per
>> CPU. The test machine is a two nodes/24 CPUs box with an Intel Xeon processor
>> @2.27GHz.
>>
>> Regarding the update part, on average, the regular kernel takes 57 ms to update
>> the schedstats key, while the kernel with the batch updates takes just 1.4 ms
>> on average. Although it seems to be too good to be true, it makes sense: the
>> schedstats key is used in 56 places, so it was expected that it would take
>> around 56 times to update the keys with the current implementation, as the
>> IPIs are the most expensive part of the update.
>>
>> Regarding the int3 handler, the non-batch handler takes 45 ns on average, while
>> the batch version takes around 180 ns. At first glance, it seems to be a high
>> value. But it is not, considering that it is doing 56 updates, rather than one!
>> It is taking four times more, only. This gain is possible because the patch
>> uses a binary search in the vector: log2(56)=5.8. So, it was expected to have
>> an overhead within four times.
>>
>> (voice of tv propaganda) But, that is not all! As the int3 handler keeps on for
>> a shorter period (because the update part is on for a shorter time), the number
>> of hits in the int3 handler decreased by 10%.
>>
>> The question then is: Is it worth paying the price of "135 ns" more in the int3
>> handler?
>>
>> Considering that, in this test case, we are saving the handling of 53 IPIs,
>> that takes more than these 135 ns, it seems to be a meager price to be paid.
>> Moreover, the test case was forcing the hit of the int3, in practice, it
>> does not take that often. While the IPI takes place on all CPUs, hitting
>> the int3 handler or not!
>>
>> For instance, in an isolated CPU with a process running in user-space
>> (nohz_full use-case), the chances of hitting the int3 handler is barely zero,
>> while there is no way to avoid the IPIs. By bounding the IPIs, we are improving
>> a lot this scenario.
>>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>> Cc: Zhou Chengming <zhouchengming1@huawei.com>
>> Cc: Jiri Kosina <jkosina@suse.cz>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>> Cc: Chris von Recklinghausen <crecklin@redhat.com>
>> Cc: Jason Baron <jbaron@akamai.com>
>> Cc: Scott Wood <swood@redhat.com>
>> Cc: Marcelo Tosatti <mtosatti@redhat.com>
>> Cc: Clark Williams <williams@redhat.com>
>> Cc: x86@kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  include/linux/jump_label.h |  3 +++
>>  kernel/jump_label.c        | 29 +++++++++++++++++++++++++++++
>>  2 files changed, 32 insertions(+)
>>
>> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
>> index c88d903befc0..ed51ef3e1abd 100644
>> --- a/include/linux/jump_label.h
>> +++ b/include/linux/jump_label.h
>> @@ -219,6 +219,9 @@ extern void arch_jump_label_transform(struct jump_entry *entry,
>>  				      enum jump_label_type type);
>>  extern void arch_jump_label_transform_static(struct jump_entry *entry,
>>  					     enum jump_label_type type);
>> +extern int arch_jump_label_transform_queue(struct jump_entry *entry,
>> +					    enum jump_label_type type);
>> +extern void arch_jump_label_transform_apply(void);
>>  extern int jump_label_text_reserved(void *start, void *end);
>>  extern void static_key_slow_inc(struct static_key *key);
>>  extern void static_key_slow_dec(struct static_key *key);
>> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
>> index 22093b5f57c9..08ace142af0a 100644
>> --- a/kernel/jump_label.c
>> +++ b/kernel/jump_label.c
>> @@ -409,6 +409,7 @@ bool jump_label_can_update_check(struct jump_entry *entry, bool init)
>>  	return 0;
>>  }
>>  
>> +#ifndef HAVE_JUMP_LABEL_BATCH
>>  static void __jump_label_update(struct static_key *key,
>>  				struct jump_entry *entry,
>>  				struct jump_entry *stop,
>> @@ -421,6 +422,34 @@ static void __jump_label_update(struct static_key *key,
>>  		}
>>  	}
>>  }
>> +#else
>> +static void __jump_label_update(struct static_key *key,
>> +				struct jump_entry *entry,
>> +				struct jump_entry *stop,
>> +				bool init)
>> +{
>> +	for_each_label_entry(key, entry, stop) {
>> +
>> +		if (!jump_label_can_update_check(entry, init))
>> +			continue;
>> +
>> +		if (arch_jump_label_transform_queue(entry,
>> +						    jump_label_type(entry)))
>> +			continue;
>> +
>> +		/*
>> +		 * Queue's overflow: Apply the current queue, and then
>> +		 * queue again. If it stills not possible to queue, BUG!
>> +		 */
>> +		arch_jump_label_transform_apply();
>> +		if (!arch_jump_label_transform_queue(entry,
>> +						     jump_label_type(entry))) {
>> +			BUG();
> 
> Why BUG()? Do you really want to crash Linus's machine?

I am using BUG() because that is what I see in other part of jump_label code:
	If something goes wrong:
		BUG().

What I could do here is:

Add a "fallback" boll that is disabled by default.
If I hit this case:
	WARN()
	turn "fallback" on, returning to the old mode (without batch)

Sound better?

Thanks!
-- Daniel

> -- Steve
> 
>> +		}
>> +	}
>> +	arch_jump_label_transform_apply();
>> +}
>> +#endif
>>  
>>  void __init jump_label_init(void)
>>  {
> 

