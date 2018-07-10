Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146EBC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CDD20846
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CDD20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbeGJSsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:48:47 -0400
Received: from foss.arm.com ([217.140.101.70]:52226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733312AbeGJSsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:48:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06B5519F6;
        Tue, 10 Jul 2018 10:32:37 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C91353F589;
        Tue, 10 Jul 2018 10:32:36 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 990131AE53F3; Tue, 10 Jul 2018 18:33:18 +0100 (BST)
Date:   Tue, 10 Jul 2018 18:33:18 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        James Morse <James.Morse@arm.com>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCHv4 11/19] arm64: don't reload GPRs after apply_ssbd
Message-ID: <20180710173317.GC10177@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
 <20180702110415.10465-12-mark.rutland@arm.com>
 <20180706163844.GB27483@arm.com>
 <20180709142159.tsxgwhjm3qziymym@lakrids.cambridge.arm.com>
 <20180710103722.GH9486@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710103722.GH9486@e103592.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 11:37:24AM +0100, Dave Martin wrote:
> On Mon, Jul 09, 2018 at 03:21:59PM +0100, Mark Rutland wrote:
> > On Fri, Jul 06, 2018 at 05:38:45PM +0100, Will Deacon wrote:
> > > On Mon, Jul 02, 2018 at 12:04:07PM +0100, Mark Rutland wrote:
> > > > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > > > index c41b84d06644..728bc7cc5bbb 100644
> > > > --- a/arch/arm64/kernel/entry.S
> > > > +++ b/arch/arm64/kernel/entry.S
> > > > @@ -130,20 +130,21 @@ alternative_else_nop_endif
> > > >  
> > > >  	// This macro corrupts x0-x3. It is the caller's duty
> > > >  	// to save/restore them if required.
> > > > -	.macro	apply_ssbd, state, targ, tmp1, tmp2
> > > > +	.macro	apply_ssbd, state, tmp1, tmp2
> > > >  #ifdef CONFIG_ARM64_SSBD
> > > >  alternative_cb	arm64_enable_wa2_handling
> > > > -	b	\targ
> > > > +	b	skip_apply_ssbd\@
> > > >  alternative_cb_end
> > > >  	ldr_this_cpu	\tmp2, arm64_ssbd_callback_required, \tmp1
> > > > -	cbz	\tmp2, \targ
> > > > +	cbz	\tmp2, skip_apply_ssbd\@
> > > >  	ldr	\tmp2, [tsk, #TSK_TI_FLAGS]
> > > > -	tbnz	\tmp2, #TIF_SSBD, \targ
> > > > +	tbnz	\tmp2, #TIF_SSBD, skip_apply_ssbd\@
> > > 
> > > Talking to Dave, he makes a good point that this is pretty fragile if a
> > > macro expansion within the macro itself uses \@, since this would result
> > > in an unexpected label update and everything would go wrong.
> > 
> > I don't believe that's a problem; \@ is handled as-if it's a named
> > argument to the macro, and is not incremented within the scope of a
> > single macro expansion.
> 
> From
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gas/macro.c
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gas/read.c
> 
> it looks like the \@ counter (macro_number) is only incremented at the
> end expansion of a whole macro body before gas reads the expansion
> output (including recursive macro expansions).
> 
> So, your conclusion looks right for gas today.  The code implementing
> this looks crufty enough to be pretty old.
> 
> Can you throw a bug into https://sourceware.org/bugzilla/ to get this
> properly documented?  The current wording is ambiguous.  It would be
> nice to get gas properly committed to behaving this way.
> 
> 
> For the kernel, I suggest using a .L prefix so that the generated
> symbols don't bloat the vmlinux symbol table (similar to numbered local
> labels) -- unless you really want the symbols retained.
> 
> Having a common prefix for all "unique" assembler symbols may help us
> to avoid namespace collisions, say
> 
> .L__asm__foo_\@
> .L__asm__bar_\@

Hmm, yes, and that would allow us to replace the open-coded labels in
our assembler.h macros as well, wouldn't it?

Will
