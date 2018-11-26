Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D6DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557FD20645
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dZBp+NIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557FD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeK0C5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:57:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeK0C5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VsTCm5zE3RpQJBZbC8onKGQcf6Oja50LKgsJ8cRfa9s=; b=dZBp+NIUabKA7+eVREo8mbGie
        YZXDDkAM1OLsO1qAjFuNocVVa1l/ZMwtxkplQo/veN3oucqB+igBpLrLuxcTH2nFKNAT7butgNutn
        vVV4db7HiKga9WvXF7VRQPQDRVckWbqk+6MaAuir5AfUG7krYaFYMnU0iJNCQeBiRbv6Zs4g1AshR
        oRCbcFtgJny2BR7rHoQLEsLFqTJDbqEYlaRGFAuBd41+WwtFbzwuvlwtqMsMr8fLqDQGEebgRL6qU
        V7Rwpb0pby4Til8m4wUgvkGwB/WKSuviN1vKwXoSWNptVEReuieYWkpxoxSy7jVTbK6PlBqeRcmaV
        V9gSOdFqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRJL0-0006LU-M8; Mon, 26 Nov 2018 16:02:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12CFC2029F87F; Mon, 26 Nov 2018 17:02:17 +0100 (CET)
Date:   Mon, 26 Nov 2018 17:02:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:55:00AM -0600, Josh Poimboeuf wrote:
> diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> index 8026d176f25c..d3869295b88d 100644
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -9,13 +9,21 @@
>  
>  void static_call_bp_handler(void);
>  void *bp_handler_dest;
> +void *bp_handler_continue;
>  
>  asm(".pushsection .text, \"ax\"						\n"
>      ".globl static_call_bp_handler					\n"
>      ".type static_call_bp_handler, @function				\n"
>      "static_call_bp_handler:						\n"
> -    "ANNOTATE_RETPOLINE_SAFE						\n"
> +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> +    ANNOTATE_RETPOLINE_SAFE
> +    "call *bp_handler_dest						\n"
> +    ANNOTATE_RETPOLINE_SAFE
> +    "jmp *bp_handler_continue						\n"
> +#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
> +    ANNOTATE_RETPOLINE_SAFE
>      "jmp *bp_handler_dest						\n"
> +#endif
>      ".popsection							\n");
>  
>  void arch_static_call_transform(void *site, void *tramp, void *func)
> @@ -25,7 +33,10 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
>  	unsigned char insn_opcode;
>  	unsigned char opcodes[CALL_INSN_SIZE];
>  
> -	insn = (unsigned long)tramp;
> +	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
> +		insn = (unsigned long)site;
> +	else
> +		insn = (unsigned long)tramp;
>  
>  	mutex_lock(&text_mutex);
>  
> @@ -41,8 +52,10 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
>  	opcodes[0] = insn_opcode;
>  	memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
>  
> -	/* Set up the variable for the breakpoint handler: */
> +	/* Set up the variables for the breakpoint handler: */
>  	bp_handler_dest = func;
> +	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
> +		bp_handler_continue = (void *)(insn + CALL_INSN_SIZE);
>  
>  	/* Patch the call site: */
>  	text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,

OK, so this is where that static_call_bp_handler comes from; you need
that CALL to frob the stack.

But I still think it is broken; consider:

	CPU0				CPU1

	bp_handler = ponies;

	text_poke_bp(, &static_call_bp_handler)
	  text_poke(&int3);
	  on_each_cpu(sync)
	  				<IPI>
					  ...
					</IPI>

	  text_poke(/* all but first bytes */)
	  on_each_cpu(sync)
	  				<IPI>
					  ...
					</IPI>

	  				<int3>
					  pt_regs->ip = &static_call_bp_handler
					</int3>

					// VCPU takes a nap...
	  text_poke(/* first byte */)
	  on_each_cpu(sync)
	  				<IPI>
					  ...
					</IPI>

					// VCPU sleeps more
	bp_handler = unicorn;

					CALL unicorn

*whoops*

Now, granted, that is all rather 'unlikely', but that never stopped
Murphy.
