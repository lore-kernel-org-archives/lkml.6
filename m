Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63215C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224BA2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wxFkiMi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224BA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeK0TlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:41:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbeK0TlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V8bhydS6YDUmlxMP2XNvIqFN+duJaM+kEI92hRbpoxA=; b=wxFkiMi7RdDrJx9f8rAxP/2ED
        bYg7xOLDyqUg5Ld2dmWBLfgnvT8uI63UP+doHK/s+p81nHEx5F7fKJeK/mcN9BdybKAlw7e5+yg/o
        SKrnLuRNBWV/5hL1VQEJLid+laKdZgoXc5QOKwLQS71Nm7P/jYTa6P6dOrOvEeNka6kTt+tPWHPpW
        cQF6MlTn9y0Hckka1+TrD8Hy3K1txFPEkiasFfJiduabvWWz8pJg7uQVff2BWOMDx3tfWHY56BkXp
        2LIO6/AqKkV+HCWQYenv+9pBm3uE+ds3g3zWOJRf0UIU3JdU3XbzIt0E2BkcwVX5cb9ffpo8eOfmI
        M/L/hHrvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRYy3-0008QK-La; Tue, 27 Nov 2018 08:43:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD1B92029FD58; Tue, 27 Nov 2018 09:43:30 +0100 (CET)
Date:   Tue, 27 Nov 2018 09:43:30 +0100
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
Message-ID: <20181127084330.GX2113@hirez.programming.kicks-ass.net>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble>
 <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net>
 <20181126212628.4apztfazichxnt7r@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126212628.4apztfazichxnt7r@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 03:26:28PM -0600, Josh Poimboeuf wrote:

> Yeah, that's probably better.  I assume you also mean that we would have
> all text_poke_bp() users create a handler callback?  That way the
> interface is clear and consistent for everybody.  Like:

Can do, it does indeed make the interface less like a hack. It is not
like there are too many users.

> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index aac0c1f7e354..d4b0abe4912d 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -37,6 +37,11 @@ static void bug_at(unsigned char *ip, int line)
>  	BUG();
>  }
>  
> +static inline void jump_label_bp_handler(struct pt_regs *regs, void *data)
> +{
> +	regs->ip += JUMP_LABEL_NOP_SIZE - 1;
> +}
> +
>  static void __ref __jump_label_transform(struct jump_entry *entry,
>  					 enum jump_label_type type,
>  					 void *(*poker)(void *, const void *, size_t),
> @@ -91,7 +96,7 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
>  	}
>  
>  	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE,
> -		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
> +		     jump_label_bp_handler, NULL);
>  }
>  
>  void arch_jump_label_transform(struct jump_entry *entry,

Per that example..

> diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> index d3869295b88d..e05ebc6d4db5 100644
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -7,24 +7,30 @@
>  
>  #define CALL_INSN_SIZE 5
>  
> +struct static_call_bp_data {
> +	unsigned long func, ret;
> +};
> +
> +static void static_call_bp_handler(struct pt_regs *regs, void *_data)
> +{
> +	struct static_call_bp_data *data = _data;
> +
> +	/*
> +	 * For inline static calls, push the return address on the stack so the
> +	 * "called" function will return to the location immediately after the
> +	 * call site.
> +	 *
> +	 * NOTE: This code will need to be revisited when kernel CET gets
> +	 *       implemented.
> +	 */
> +	if (data->ret) {
> +		regs->sp -= sizeof(long);
> +		*(unsigned long *)regs->sp = data->ret;
> +	}
> +
> +	/* The exception handler will 'return' to the destination function. */
> +	regs->ip = data->func;
> +}

Now; if I'm not mistaken, the below @site is in fact @regs->ip - 1, no?

We already patched site with INT3, which is what we just trapped on. So
we could in fact write something like:

static void static_call_bp_handler(struct pt_regs *regs, void *data)
{
	struct static_call_bp_data *scd = data;

	switch (data->type) {
	case CALL_INSN: /* emulate CALL instruction */
		regs->sp -= sizeof(unsigned long);
		*(unsigned long *)regs->sp = regs->ip + CALL_INSN_SIZE - 1;
		regs->ip = data->func;
		break;

	case JMP_INSN: /* emulate JMP instruction */
		regs->ip = data->func;
		break;
	}
}

>  void arch_static_call_transform(void *site, void *tramp, void *func)
>  {
> @@ -32,11 +38,17 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
>  	unsigned long insn;
>  	unsigned char insn_opcode;
>  	unsigned char opcodes[CALL_INSN_SIZE];
> +	struct static_call_bp_data handler_data;
> +
> +	handler_data.func = (unsigned long)func;
>  
> -	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
> +	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE)) {
>  		insn = (unsigned long)site;
> +		handler_data.ret = insn + CALL_INSN_SIZE;
> +	} else {
>  		insn = (unsigned long)tramp;
> +		handler_data.ret = 0;
> +	}

	handler_data = (struct static_call_bp_data){
		.type = IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) ? CALL_INSN : JMP_INSN,
		.func = func,
	};

>  	mutex_lock(&text_mutex);
>  
> @@ -52,14 +64,9 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
>  	opcodes[0] = insn_opcode;
>  	memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
>  
>  	/* Patch the call site: */
>  	text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,
> +		     static_call_bp_handler, &handler_data);
>  
>  done:
>  	mutex_unlock(&text_mutex);
