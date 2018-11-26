Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D50C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3451320865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kBknsphJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3451320865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeK0HD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:03:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeK0HD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y3ridubM4dBF7ftT7WYOeOEUeMypENWrpCwnp1BVO+E=; b=kBknsphJkm9Flb3C5VRfJQ2LC
        ng9OHTCBA3zoW7RPmTf6Z+U9hwdvJGI+yN2QM6/bnhYmDwQHNxsaDFKT41lHSWi+5t1vuxxCjavFg
        MWsIUmO5vRdplf5mDX3YlmW7QPYsEcwmAep9Voetic6chGrHYqy6yb2y2+ObmNQSpN/+Gy0Ffhcb/
        jJAKNu5CNHWXG+aac9SacaewHW5ixx5EhVjKKg7s4LscHlAB4GI9xsVRxUsi/yBobhH2HiKfcA5ra
        pALz53BdoV0FrdF6qrN6t4lyV9VQKM8BUIPGazBw/MLfmWTfCx+GVkmmVnBETTor5MLtDM5Br4yoS
        1Ml2kwoIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRNAq-0006cb-Ga; Mon, 26 Nov 2018 20:08:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E8B92029FD58; Mon, 26 Nov 2018 21:08:01 +0100 (CET)
Date:   Mon, 26 Nov 2018 21:08:01 +0100
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
Message-ID: <20181126200801.GW2113@hirez.programming.kicks-ass.net>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble>
 <20181126175624.bruqfbkngbucpvxr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126175624.bruqfbkngbucpvxr@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:56:24AM -0600, Josh Poimboeuf wrote:
> diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> index d3869295b88d..8fd6c8556750 100644
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -7,24 +7,19 @@
>  
>  #define CALL_INSN_SIZE 5
>  
> +unsigned long bp_handler_call_return_addr;
>  
> +static void static_call_bp_handler(struct pt_regs *regs)
> +{
>  #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> +	/*
> +	 * Push the return address on the stack so the "called" function will
> +	 * return to immediately after the call site.
> +	 */
> +	regs->sp -= sizeof(long);
> +	*(unsigned long *)regs->sp = bp_handler_call_return_addr;
>  #endif
> +}
>  
>  void arch_static_call_transform(void *site, void *tramp, void *func)
>  {
> @@ -52,14 +47,12 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
>  	opcodes[0] = insn_opcode;
>  	memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
>  
>  	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
> +		bp_handler_call_return_addr = insn + CALL_INSN_SIZE;
>  
>  	/* Patch the call site: */
>  	text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,
> -		     static_call_bp_handler);
> +		     static_call_bp_handler, func);
>  
>  done:
>  	mutex_unlock(&text_mutex);


like maybe something along the lines of:

struct sc_data {
	unsigned long ret;
	unsigned long ip;
};

void sc_handler(struct pt_regs *regs, void *data)
{
	struct sc_data *scd = data;

	regs->sp -= sizeof(long);
	*(unsigned long *)regs->sp = scd->ret;
	regs->ip = scd->ip;
}

arch_static_call_transform()
{
	...

	scd = (struct sc_data){
		.ret = insn + CALL_INSN_SIZE,
		.ip = (unsigned long)func,
	};

	text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,
			sc_handler, (void *)&scd);

	...
}
