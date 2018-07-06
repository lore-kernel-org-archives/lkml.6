Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E5AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B3921480
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B3921480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933748AbeGFQiH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:38:07 -0400
Received: from foss.arm.com ([217.140.101.70]:39854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933501AbeGFQiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:38:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A02818A;
        Fri,  6 Jul 2018 09:38:05 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1ABC03F2EA;
        Fri,  6 Jul 2018 09:38:05 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A40391AE3105; Fri,  6 Jul 2018 17:38:45 +0100 (BST)
Date:   Fri, 6 Jul 2018 17:38:45 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, hch@infradead.org,
        james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCHv4 11/19] arm64: don't reload GPRs after apply_ssbd
Message-ID: <20180706163844.GB27483@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
 <20180702110415.10465-12-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702110415.10465-12-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 12:04:07PM +0100, Mark Rutland wrote:
> Now that all of the syscall logic works on the saved pt_regs, apply_ssbd
> can safely corrupt x0-x3 in the entry paths, and we no longer need to
> restore them. So let's remove the logic doing so.
> 
> With that logic gone, we can fold the branch target into the macro, so
> that callers need not deal with this. GAS provides \@, which provides a
> unique value per macro invocation, which we can use to create a unique
> label.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/entry.S | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index c41b84d06644..728bc7cc5bbb 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -130,20 +130,21 @@ alternative_else_nop_endif
>  
>  	// This macro corrupts x0-x3. It is the caller's duty
>  	// to save/restore them if required.
> -	.macro	apply_ssbd, state, targ, tmp1, tmp2
> +	.macro	apply_ssbd, state, tmp1, tmp2
>  #ifdef CONFIG_ARM64_SSBD
>  alternative_cb	arm64_enable_wa2_handling
> -	b	\targ
> +	b	skip_apply_ssbd\@
>  alternative_cb_end
>  	ldr_this_cpu	\tmp2, arm64_ssbd_callback_required, \tmp1
> -	cbz	\tmp2, \targ
> +	cbz	\tmp2, skip_apply_ssbd\@
>  	ldr	\tmp2, [tsk, #TSK_TI_FLAGS]
> -	tbnz	\tmp2, #TIF_SSBD, \targ
> +	tbnz	\tmp2, #TIF_SSBD, skip_apply_ssbd\@

Talking to Dave, he makes a good point that this is pretty fragile if a
macro expansion within the macro itself uses \@, since this would result
in an unexpected label update and everything would go wrong.

Can you default initialise an extra label argument to \@, or does that not
work?

Will
