Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A0EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F260D20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OJcG99cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F260D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeK0Cir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:38:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39498 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0Ciq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1DM+dmTlWTm0n9zlOsjVXVHDGYx1jlvwMsMNEHfEBQo=; b=OJcG99cvOyL/PXLgOGyL0T8/S
        471RzsiSKAGKONutVr6riulxjXHZoxTDNqgdDUcxKbPWfX2bt1sXj/d0QAQKXBMSBhpSZP6V1N/7X
        Nt0Oqlcc++dFdWmjBmrXJMhcw/blUvvIsaot5FIEge16MddMk3iLmeq/vqp0S1EaduKxodZvKww5c
        sdhxPcUEheRLr7zTv+OX9uThySXMFBtpAGsC84ioc/RAjs/tW6ZWNKT28C2YAkuyoPR9wYMMs5LLY
        tXzvzfAcGcoy783Rse+caATdanmYj3RKxEUhgtWx/E8Qpeq4mbNYKTR47VDn+lAnjFIEnzZHHm4Ol
        HZx7PZEsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRJ3F-0001a3-Ud; Mon, 26 Nov 2018 15:43:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31D9D2029FD58; Mon, 26 Nov 2018 16:43:56 +0100 (CET)
Date:   Mon, 26 Nov 2018 16:43:56 +0100
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
Subject: Re: [PATCH v2 3/4] x86/static_call: Add out-of-line static call
 implementation
Message-ID: <20181126154356.GP2113@hirez.programming.kicks-ass.net>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <00b08f2194e80241decbf206624b6580b9b8855b.1543200841.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b08f2194e80241decbf206624b6580b9b8855b.1543200841.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:54:59AM -0600, Josh Poimboeuf wrote:

> +void static_call_bp_handler(void);
> +void *bp_handler_dest;
> +
> +asm(".pushsection .text, \"ax\"						\n"
> +    ".globl static_call_bp_handler					\n"
> +    ".type static_call_bp_handler, @function				\n"
> +    "static_call_bp_handler:						\n"
> +    "ANNOTATE_RETPOLINE_SAFE						\n"
> +    "jmp *bp_handler_dest						\n"
> +    ".popsection							\n");
> +
> +void arch_static_call_transform(void *site, void *tramp, void *func)
> +{
> +	s32 dest_relative;
> +	unsigned long insn;
> +	unsigned char insn_opcode;
> +	unsigned char opcodes[CALL_INSN_SIZE];
> +
> +	insn = (unsigned long)tramp;
> +
> +	mutex_lock(&text_mutex);
> +
> +	insn_opcode = *(unsigned char *)insn;
> +	if (insn_opcode != 0xe8 && insn_opcode != 0xe9) {
> +		WARN_ONCE(1, "unexpected static call insn opcode 0x%x at %pS",
> +			  insn_opcode, (void *)insn);
> +		goto done;
> +	}
> +
> +	dest_relative = (long)(func) - (long)(insn + CALL_INSN_SIZE);
> +
> +	opcodes[0] = insn_opcode;
> +	memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
> +
> +	/* Set up the variable for the breakpoint handler: */
> +	bp_handler_dest = func;
> +
> +	/* Patch the call site: */
> +	text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,
> +		     static_call_bp_handler);

I'm confused by the whole static_call_bp_handler thing; why not jump
straight to @func ?

Also, what guarantees this other thread will have gotten from
static_call_bp_handler and executed the actual indirect JMP instruction
by the time we re-write @bp_handler_dest again?

> +done:
> +	mutex_unlock(&text_mutex);
> +}
