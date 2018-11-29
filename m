Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF30C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B96120863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RoSdbJBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B96120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeK2UrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:47:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeK2UrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oM54E/pz6Qe+h9lX2NbLAODLiq3zUg+3MJImPEMuok4=; b=RoSdbJBTmvlACxTnC+BQk9ittb
        cV5EkQL8s0NBfkHo67U2etz2zwNW2xMwXQ8Gu7EiKR/pdE+3/zsVEy1z3vdcmRi3GXNKior0J8UM8
        Wp91mMloMPkiyIFldjJrLpzSiWXMf3yJRYFdfA6ijI2GZpIxhrBk96p5b5JfuRwJn5vbA0YIW9JCi
        Eoq2NdPyV0WExsSOSCPeJJjU4c5n0IrpaMBBsrdVV0I9TkxKzz7U3xndljz24Wv9qs0dzqI+Vp3a3
        1+9QQ75V2nFJ//bcXjwaHOxDPp8x+CF+ABmtcnHIeSvYpboKjBG5A0zzGbrB4GvZ9AXJNwIC8diwD
        /TDDHXBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSIpo-0003NN-SH; Thu, 29 Nov 2018 09:42:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BA9F2029FD58; Thu, 29 Nov 2018 10:42:10 +0100 (CET)
Date:   Thu, 29 Nov 2018 10:42:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129094210.GC2131@hirez.programming.kicks-ass.net>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble>
 <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net>
 <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net>
 <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:05:54PM -0800, Andy Lutomirski wrote:

> >> +static void static_call_bp_handler(struct pt_regs *regs, void *_data)
> >> +{
> >> +    struct static_call_bp_data *data = _data;
> >> +
> >> +    /*
> >> +     * For inline static calls, push the return address on the stack so the
> >> +     * "called" function will return to the location immediately after the
> >> +     * call site.
> >> +     *
> >> +     * NOTE: This code will need to be revisited when kernel CET gets
> >> +     *       implemented.
> >> +     */
> >> +    if (data->ret) {
> >> +        regs->sp -= sizeof(long);
> >> +        *(unsigned long *)regs->sp = data->ret;
> >> +    }
> 
> You can’t do this.  Depending on the alignment of the old RSP, which
> is not guaranteed, this overwrites regs->cs.  IRET goes boom.

I don't get it; can you spell that out?

The way I understand it is that we're at a location where a "E8 - Near
CALL" instruction should be, and thus RSP should be the regular kernel
stack, and the above simply does "PUSH ret", which is what that CALL
would've done too.


