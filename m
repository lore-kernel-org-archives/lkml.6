Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE26CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977D9222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lDrEQKFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503012AbfBNQ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:58:17 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48052 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392616AbfBNQ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0e+gB6fIsqwUb8MPCklC+SrhwwbaVqLzW/0+KOgy6Lk=; b=lDrEQKFetYDhLqis2bOf2jFAQ
        iLmL5yJE57/0O8I0DCH+zYouyAMr6XjtHrArX/L3XSUXgiWYG0xzy2bZXP93hI9MbX37FEWP4RCzD
        DQd8+8ta4lV1DrZw1S3Rf9rm7VjD6TRHZb0bvelOAD3/ST6tvUgF3i/1H+qQ+K7EQfAMwj/gmxrWJ
        IKEtRCJFhkzo5Ik7LmuS14OhtI+nuXpm9mgvqehNCQatmJGnglhVX41e6sd3kXHUlhFLnp5/EGMZv
        l6AczsFYRuO3ZOK8lw2cxApc+/6Smyz+vUhCULnpD5tXyA5H7UMYrlIg7qS7PI2AAC3W8bxiUHv+y
        qZlWxeHZQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54460)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1guKKx-0004xM-84; Thu, 14 Feb 2019 16:58:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1guKKt-0003sq-UA; Thu, 14 Feb 2019 16:58:07 +0000
Date:   Thu, 14 Feb 2019 16:58:07 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: Re: [PATCH] ARM: pm: fix HYP/SVC mode mismatch when MCPM is used
Message-ID: <20190214165807.eq34njmunqhrdvxx@shell.armlinux.org.uk>
References: <CGME20190214143126eucas1p126506139ef72c1685654c8dac8957b3d@eucas1p1.samsung.com>
 <20190214143114.24356-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214143114.24356-1-m.szyprowski@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:31:14PM +0100, Marek Szyprowski wrote:
> MCPM does a soft reset of the CPUs and uses common cpu_resume() routine to
> perform low-level platform initialization. This results in a try to install
> HYP stubs for the second time for each CPU and results in false HYP/SVC
> mode mismatch detection. The HYP stubs are already installed at the
> beginning of the kernel initialization on the boot CPU (head.S) or in the
> secondary_startup() for other CPUs. To fix this issue MCPM code should use
> a cpu_resume() routine without HYP stubs installation.
> 
> This change fixes HYP/SVC mode mismatch on Samsung Exynos5422-based Odroid
> XU3/XU4/HC1 boards.
> 
> Fixes: 3721924c8154 ("ARM: 8081/1: MCPM: provide infrastructure to allow for MCPM loopback")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/common/mcpm_entry.c   |  2 +-
>  arch/arm/include/asm/suspend.h |  1 +
>  arch/arm/kernel/sleep.S        | 11 +++++++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> index ad574d20415c..1b1b82b37ce0 100644
> --- a/arch/arm/common/mcpm_entry.c
> +++ b/arch/arm/common/mcpm_entry.c
> @@ -381,7 +381,7 @@ static int __init nocache_trampoline(unsigned long _arg)
>  	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>  	phys_reset_t phys_reset;
>  
> -	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
> +	mcpm_set_entry_vector(cpu, cluster, cpu_resume_no_hyp);
>  	setup_mm_for_reboot();
>  
>  	__mcpm_cpu_going_down(cpu, cluster);
> diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
> index 452bbdcbcc83..506314265c6f 100644
> --- a/arch/arm/include/asm/suspend.h
> +++ b/arch/arm/include/asm/suspend.h
> @@ -10,6 +10,7 @@ struct sleep_save_sp {
>  };
>  
>  extern void cpu_resume(void);
> +extern void cpu_resume_no_hyp(void);
>  extern void cpu_resume_arm(void);
>  extern int cpu_suspend(unsigned long, int (*)(unsigned long));
>  
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index a8257fc9cf2a..b856d183691e 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -122,6 +122,11 @@ ENDPROC(cpu_resume_after_mmu)
>  
>  #ifdef CONFIG_MMU
>  	.arm
> +#ifdef CONFIG_MCPM
> +ENTRY(cpu_resume_no_hyp)
> +ARM_BE8(setend be)			@ ensure we are in BE mode
> +	b	0f

What if the kernel is built for Thumb?  You'll be branching to thumb
code at the '0' label - don't you need to do the same that
cpu_resume_arm does below?

> +#endif
>  ENTRY(cpu_resume_arm)
>   THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
> @@ -135,6 +140,9 @@ ARM_BE8(setend be)			@ ensure we are in BE mode
>  	bl	__hyp_stub_install_secondary
>  #endif
>  	safe_svcmode_maskall r1
> +#ifdef CONFIG_MCPM
> +0:
> +#endif

You don't need to conditionalise this.  I'd also use a symbol rather
than a numeric label given that safe_svcmode_maskall is a macro that
also uses numeric labels.

>  	mov	r1, #0
>  	ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
>  	ALT_UP_B(1f)
> @@ -163,6 +171,9 @@ ENDPROC(cpu_resume)
>  
>  #ifdef CONFIG_MMU
>  ENDPROC(cpu_resume_arm)
> +#endif
> +#ifdef CONFIG_MCPM
> +ENDPROC(cpu_resume_no_hyp)
>  #endif
>  
>  	.align 2
> -- 
> 2.17.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
