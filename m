Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D6020652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SPAw649q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfBYQMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:12:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41370 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfBYQMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kAXirJHan+nBNQ8F28vTEzq9KBqJIjUGfyURTVLP+7E=; b=SPAw649qDF6HxWYcuJHVntApR
        VyzUVJbVQTIROYCA266Ktja9jQiK4rlnoqI+83qnXJ4WqCEP4p4tLSOZ0wZCdXiGDC/BxGDdaKGAu
        4CT3QEtEHLEW+2InPeLjRocyJoZwk+qsrCuWxzeP1BwzX7eyoZ+F0iL0VcbO+yom0phNh85kApMIo
        Gq0V+4PcKa9AUVDVlGg1mZQD/aCqjUUFhmXKOtodrmo4MFgdd2M7p9BOSPRRLVz9SuMRUVJXEuQ+2
        s2I0IzuvTHpLm1s5g9lVLXvNTdOdu7BVVKaBZmGi3qHTYndy3vGPS7RyFcFX4TeGB6G2EBJ62KJEt
        V10CalSVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyIrs-0007P7-Qe; Mon, 25 Feb 2019 16:12:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AA48203D55EE; Mon, 25 Feb 2019 17:12:34 +0100 (CET)
Date:   Mon, 25 Feb 2019 17:12:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
Message-ID: <20190225161234.GM32477@hirez.programming.kicks-ass.net>
References: <20190225124330.613028745@infradead.org>
 <20190225125232.191698923@infradead.org>
 <CALCETrW1_r=Qgbpiq8PsYYD11W7CwAS-UCAxzvvubJnMAHH2Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW1_r=Qgbpiq8PsYYD11W7CwAS-UCAxzvvubJnMAHH2Dg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 07:53:01AM -0800, Andy Lutomirski wrote:
> On Mon, Feb 25, 2019 at 4:53 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > +#define UACCESS_SAFE(func)                                             \
> > +       asm (".pushsection .discard.uaccess_safe_strtab, \"S\", @3\n\t" \
> > +            "999: .ascii \"" #func "\"\n\t"                            \
> > +            "     .byte 0\n\t"                                         \
> > +            ".popsection\n\t"                                          \
> > +            ".pushsection .discard.uaccess_safe\n\t"                   \
> > +            ".long 999b - .\n\t"                                       \
> > +            ".popsection")
> 
> Minor nit: using big numbers like 999: like this always bugs me.  It
> relies on there not being a macro nested inside or outside this that
> uses the same number.  My general preference is to do something like
> .Ldescription_\@ instead.
> 
> Otherwise this looks conceptually good :)

I seem to remember here being an issue with the \@ thing. Notably we're
not using it in nospsec-branch.h.

I'll see if I can dig up why we decided not to use it there.
