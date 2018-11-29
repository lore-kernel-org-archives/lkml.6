Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE0CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603B320863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603B320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbeK3Dci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:32:38 -0500
Received: from foss.arm.com ([217.140.101.70]:38562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbeK3Dci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:32:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845EAA78;
        Thu, 29 Nov 2018 08:26:43 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7A953F59C;
        Thu, 29 Nov 2018 08:26:41 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:26:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, daniel.thompson@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
        james.morse@arm.com, joel@joelfernandes.org
Subject: Re: [PATCH v6 01/24] arm64: Remove unused daif related
 functions/macros
Message-ID: <20181129162638.gth6epspauks3a4i@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-2-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542023835-21446-2-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:56:52AM +0000, Julien Thierry wrote:
> There are some helpers to modify PSR.[DAIF] bits that are not referenced
> anywhere. The less these bits are available outside of local_irq_*
> functions the better.
> 
> Get rid of those unused helpers.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/assembler.h | 10 +---------
>  arch/arm64/include/asm/daifflags.h | 10 ----------
>  2 files changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 6142402..6e76c8e 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -60,16 +60,8 @@
>  	.endm
>  
>  /*
> - * Enable and disable interrupts.
> + * Save/restore interrupts.
>   */
> -	.macro	disable_irq
> -	msr	daifset, #2
> -	.endm
> -
> -	.macro	enable_irq
> -	msr	daifclr, #2
> -	.endm
> -
>  	.macro	save_and_disable_irq, flags
>  	mrs	\flags, daif
>  	msr	daifset, #2
> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
> index 8d91f22..546bc39 100644
> --- a/arch/arm64/include/asm/daifflags.h
> +++ b/arch/arm64/include/asm/daifflags.h
> @@ -43,16 +43,6 @@ static inline unsigned long local_daif_save(void)
>  	return flags;
>  }
>  
> -static inline void local_daif_unmask(void)
> -{
> -	trace_hardirqs_on();
> -	asm volatile(
> -		"msr	daifclr, #0xf		// local_daif_unmask"
> -		:
> -		:
> -		: "memory");
> -}
> -
>  static inline void local_daif_restore(unsigned long flags)
>  {
>  	if (!arch_irqs_disabled_flags(flags))
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
