Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BDCC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F2C20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F2C20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbeGIOWM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:22:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932704AbeGIOWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:22:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2562ED1;
        Mon,  9 Jul 2018 07:22:03 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D442F3F589;
        Mon,  9 Jul 2018 07:22:01 -0700 (PDT)
Date:   Mon, 9 Jul 2018 15:21:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, hch@infradead.org,
        james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCHv4 11/19] arm64: don't reload GPRs after apply_ssbd
Message-ID: <20180709142159.tsxgwhjm3qziymym@lakrids.cambridge.arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
 <20180702110415.10465-12-mark.rutland@arm.com>
 <20180706163844.GB27483@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706163844.GB27483@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 05:38:45PM +0100, Will Deacon wrote:
> On Mon, Jul 02, 2018 at 12:04:07PM +0100, Mark Rutland wrote:
> > Now that all of the syscall logic works on the saved pt_regs, apply_ssbd
> > can safely corrupt x0-x3 in the entry paths, and we no longer need to
> > restore them. So let's remove the logic doing so.
> > 
> > With that logic gone, we can fold the branch target into the macro, so
> > that callers need not deal with this. GAS provides \@, which provides a
> > unique value per macro invocation, which we can use to create a unique
> > label.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/entry.S | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index c41b84d06644..728bc7cc5bbb 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -130,20 +130,21 @@ alternative_else_nop_endif
> >  
> >  	// This macro corrupts x0-x3. It is the caller's duty
> >  	// to save/restore them if required.
> > -	.macro	apply_ssbd, state, targ, tmp1, tmp2
> > +	.macro	apply_ssbd, state, tmp1, tmp2
> >  #ifdef CONFIG_ARM64_SSBD
> >  alternative_cb	arm64_enable_wa2_handling
> > -	b	\targ
> > +	b	skip_apply_ssbd\@
> >  alternative_cb_end
> >  	ldr_this_cpu	\tmp2, arm64_ssbd_callback_required, \tmp1
> > -	cbz	\tmp2, \targ
> > +	cbz	\tmp2, skip_apply_ssbd\@
> >  	ldr	\tmp2, [tsk, #TSK_TI_FLAGS]
> > -	tbnz	\tmp2, #TIF_SSBD, \targ
> > +	tbnz	\tmp2, #TIF_SSBD, skip_apply_ssbd\@
> 
> Talking to Dave, he makes a good point that this is pretty fragile if a
> macro expansion within the macro itself uses \@, since this would result
> in an unexpected label update and everything would go wrong.

I don't believe that's a problem; \@ is handled as-if it's a named
argument to the macro, and is not incremented within the scope of a
single macro expansion.

e.g. if I assemble:

----
.macro nop_macro
.endm

.macro a n
        a_pre_\n\()_\@:
        .quad   0
        a_post_\n\()_\@:
        .quad   0
.endm

.macro b n
        b_pre_\n\()_\@:
        .quad   0

        a \n

        b_post_\n\()_\@:
        .quad   0
.endm

.macro c n
        c_pre_\n\()_\@:
        .quad   0

        b \n

        c_post_\n\()_\@:
        .quad   0
.endm

.data

        a 0

        b 1

        c 2
----

... then objdump -D gives me:

----
Disassembly of section .data:

0000000000000000 <a_pre_0_0>:
        ...

0000000000000008 <a_post_0_0>:
        ...

0000000000000010 <b_pre_1_1>:
        ...

0000000000000018 <a_pre_1_2>:
        ...

0000000000000020 <a_post_1_2>:
        ...

0000000000000028 <b_post_1_1>:
        ...

0000000000000030 <c_pre_2_3>:
        ...

0000000000000038 <b_pre_2_4>:
        ...

0000000000000040 <a_pre_2_5>:
        ...

0000000000000048 <a_post_2_5>:
        ...

0000000000000050 <b_post_2_4>:
        ...

0000000000000058 <c_post_2_3>:
        ...

----

... where things are obviously nesting just fine.

Thanks,
Mark.
