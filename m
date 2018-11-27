Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD51BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C24208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eLLawHfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C24208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbeK0TsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:48:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbeK0TsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Ek1VtxsmPwT16DbqsD1NAGMF+KfWQlrlR3Nb1jUXBo=; b=eLLawHfn9QaFnpQuRFz3HFFJu
        PtV7u6FcJ3mNEr+GjKUl8dijwRWLhF+3fZC0khwxaeUNsRKmoAY43QHIVZteLyJejAz6on4T+zdBP
        TVshWgm0zdgTCcI1KWG7zAkmME2er0+HE7dxg5HSmA/7EkpEz1ZKBycKmHVtDOaqTRb7tukpYcn9x
        2XwRBjZJNg463wAzx2Xr0tvpxUhE1Q+cVBa0H/l6sCi7l1ZlPga1Noq8IdcAr9Gc2uNArf23WN/aD
        NbMBXDZT4bQ15cS+e7VHXORNvl+/m6dqiAAEqbG5piMqSctGRngr4jpRaDT3RjxtKFBa3tniTLH3p
        S3AtQ1emQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRZ55-0008VM-Ov; Tue, 27 Nov 2018 08:50:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8332A2029FD58; Tue, 27 Nov 2018 09:50:49 +0100 (CET)
Date:   Tue, 27 Nov 2018 09:50:49 +0100
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
Message-ID: <20181127085049.GE2149@hirez.programming.kicks-ass.net>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble>
 <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net>
 <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127084330.GX2113@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:43:30AM +0100, Peter Zijlstra wrote:
> Now; if I'm not mistaken, the below @site is in fact @regs->ip - 1, no?
> 
> We already patched site with INT3, which is what we just trapped on. So
> we could in fact write something like:
> 
> static void static_call_bp_handler(struct pt_regs *regs, void *data)
> {
> 	struct static_call_bp_data *scd = data;
> 
> 	switch (data->type) {
> 	case CALL_INSN: /* emulate CALL instruction */
> 		regs->sp -= sizeof(unsigned long);
> 		*(unsigned long *)regs->sp = regs->ip + CALL_INSN_SIZE - 1;
> 		regs->ip = data->func;
> 		break;
> 
> 	case JMP_INSN: /* emulate JMP instruction */
> 		regs->ip = data->func;
> 		break;
> 	}
> }

> 	handler_data = (struct static_call_bp_data){
> 		.type = IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) ? CALL_INSN : JMP_INSN,
> 		.func = func,
> 	};

Heck; check this:

static void static_call_bp_handler(struct pt_regs *regs, void *data)
{
#ifdef CONFIG_HAVE_STATIC_CALL_INLINE

	/* emulate CALL instruction */
	regs->sp -= sizeof(unsigned long);
	*(unsigned long *)regs->sp = regs->ip + CALL_INSN_SIZE - 1;
	regs->ip = data;

#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */

	/* emulate JMP instruction */
	regs->ip = data;

#endif
}


