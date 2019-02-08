Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A073BC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7011121919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBHAP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:15:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfBHAP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:15:56 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A7432085A;
        Fri,  8 Feb 2019 00:15:54 +0000 (UTC)
Date:   Thu, 7 Feb 2019 19:15:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 5/9] x86/alternative: Split text_poke_bp() into tree
 steps
Message-ID: <20190207191552.0782a29d@gandalf.local.home>
In-Reply-To: <cf7096ad15708be48f3ea62b4e903f6ef29e2838.1549308412.git.bristot@redhat.com>
References: <cover.1549308412.git.bristot@redhat.com>
        <cf7096ad15708be48f3ea62b4e903f6ef29e2838.1549308412.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Feb 2019 20:58:58 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

>  
> +static void text_poke_bp_set_handler(void *addr, void *handler,
> +				     unsigned char int3)
> +{
> +	bp_int3_handler = handler;
> +	bp_int3_addr = (u8 *)addr + sizeof(int3);
> +	text_poke(addr, &int3, sizeof(int3));
> +}
> +

> +
> +static void patch_first_byte(void *addr, const void *opcode, unsigned char int3)
> +{
> +	/* patch the first byte */
> +	text_poke(addr, opcode, sizeof(int3));
> +}

Hmm, perhaps get rid of the first function entirely, and just do...
(although why have the "int3" here anyway?)

> +
>  /**
>   * text_poke_bp() -- update instructions on live kernel on SMP
>   * @addr:	address to patch
> @@ -791,27 +814,21 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>  {
>  	unsigned char int3 = 0xcc;
>  
> -	bp_int3_handler = handler;
> -	bp_int3_addr = (u8 *)addr + sizeof(int3);
> -	bp_patching_in_progress = true;
> -
>  	lockdep_assert_held(&text_mutex);
>  
> +	bp_patching_in_progress = true;
>  	/*
>  	 * Corresponding read barrier in int3 notifier for making sure the
>  	 * in_progress and handler are correctly ordered wrt. patching.
>  	 */
>  	smp_wmb();
>  
> -	text_poke(addr, &int3, sizeof(int3));
> +	text_poke_bp_set_handler(addr, handler, int3);

	patch_first_byte(addr, &int3, int3);

Which could be just:

	patch_first_byte(addr, &int3);

if we remove passing in int3 (for its size?).

-- Steve

>  
>  	on_each_cpu(do_sync_core, NULL, 1);
>  
>  	if (len - sizeof(int3) > 0) {
> -		/* patch all but the first byte */
> -		text_poke((char *)addr + sizeof(int3),
> -			  (const char *) opcode + sizeof(int3),
> -			  len - sizeof(int3));
> +		patch_all_but_first_byte(addr, opcode, len, int3);
>  		/*
>  		 * According to Intel, this core syncing is very likely
>  		 * not necessary and we'd be safe even without it. But
> @@ -820,8 +837,7 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>  		on_each_cpu(do_sync_core, NULL, 1);
>  	}
>  
> -	/* patch the first byte */
> -	text_poke(addr, opcode, sizeof(int3));
> +	patch_first_byte(addr, opcode, int3);
>  
>  	on_each_cpu(do_sync_core, NULL, 1);
>  	/*

