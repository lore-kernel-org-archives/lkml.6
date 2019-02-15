Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8637C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C51920836
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KfNHIL2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393958AbfBOKd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:33:56 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60094 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393897AbfBOKdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=501FzV4X16xyWDAxYR0fi7Qd3PgVMP2PGh33Rb1ybeg=; b=KfNHIL2DCI11X2i+bQ6axW+5l
        xg2W0aYmEVVRT+vo9IVR4XcvczHDeomypEHq77yHlxUSI8q7tjI6QS276cwSjWkgUpEsEVrZPD6zk
        +cIEe8GIzYDMQ7pxPs2gUHeLVw1lsGxcLGN1kDf5cyeUianoZhEPRF4zExqxP9PjKLquTPSURaPIE
        Ad1cjHGAHkdlQcSIZTfUOozHdvbpAFq8vHk67/nTHy/BiE+HpjdvjwKyVRhakbivrcQNdSDc0MxN+
        KoY42WVu1WU5a9sB7waRxAeZyAKKIq+dXi7AXQZPphbFAI51gg7UPFluH6m++0qVRruZdqoicF6ub
        01AMH4JCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51120)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1guaoY-0001rp-Vn; Fri, 15 Feb 2019 10:33:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1guaoV-0004W4-Hw; Fri, 15 Feb 2019 10:33:47 +0000
Date:   Fri, 15 Feb 2019 10:33:47 +0000
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
Message-ID: <20190215103347.nelbly5j7yibqtr3@shell.armlinux.org.uk>
References: <CGME20190214143126eucas1p126506139ef72c1685654c8dac8957b3d@eucas1p1.samsung.com>
 <20190214143114.24356-1-m.szyprowski@samsung.com>
 <20190214165807.eq34njmunqhrdvxx@shell.armlinux.org.uk>
 <7548bc35-caef-0737-be39-5ddb8e097f67@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7548bc35-caef-0737-be39-5ddb8e097f67@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:23:28AM +0100, Marek Szyprowski wrote:
> 
> On 2019-02-14 17:58, Russell King - ARM Linux admin wrote:
> > On Thu, Feb 14, 2019 at 03:31:14PM +0100, Marek Szyprowski wrote:
> >> MCPM does a soft reset of the CPUs and uses common cpu_resume() routine to
> >> perform low-level platform initialization. This results in a try to install
> >> HYP stubs for the second time for each CPU and results in false HYP/SVC
> >> mode mismatch detection. The HYP stubs are already installed at the
> >> beginning of the kernel initialization on the boot CPU (head.S) or in the
> >> secondary_startup() for other CPUs. To fix this issue MCPM code should use
> >> a cpu_resume() routine without HYP stubs installation.
> >>
> >> This change fixes HYP/SVC mode mismatch on Samsung Exynos5422-based Odroid
> >> XU3/XU4/HC1 boards.
> >>
> >> Fixes: 3721924c8154 ("ARM: 8081/1: MCPM: provide infrastructure to allow for MCPM loopback")
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >>  arch/arm/common/mcpm_entry.c   |  2 +-
> >>  arch/arm/include/asm/suspend.h |  1 +
> >>  arch/arm/kernel/sleep.S        | 11 +++++++++++
> >>  3 files changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> >> index ad574d20415c..1b1b82b37ce0 100644
> >> --- a/arch/arm/common/mcpm_entry.c
> >> +++ b/arch/arm/common/mcpm_entry.c
> >> @@ -381,7 +381,7 @@ static int __init nocache_trampoline(unsigned long _arg)
> >>  	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> >>  	phys_reset_t phys_reset;
> >>  
> >> -	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
> >> +	mcpm_set_entry_vector(cpu, cluster, cpu_resume_no_hyp);
> >>  	setup_mm_for_reboot();
> >>  
> >>  	__mcpm_cpu_going_down(cpu, cluster);
> >> diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
> >> index 452bbdcbcc83..506314265c6f 100644
> >> --- a/arch/arm/include/asm/suspend.h
> >> +++ b/arch/arm/include/asm/suspend.h
> >> @@ -10,6 +10,7 @@ struct sleep_save_sp {
> >>  };
> >>  
> >>  extern void cpu_resume(void);
> >> +extern void cpu_resume_no_hyp(void);
> >>  extern void cpu_resume_arm(void);
> >>  extern int cpu_suspend(unsigned long, int (*)(unsigned long));
> >>  
> >> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> >> index a8257fc9cf2a..b856d183691e 100644
> >> --- a/arch/arm/kernel/sleep.S
> >> +++ b/arch/arm/kernel/sleep.S
> >> @@ -122,6 +122,11 @@ ENDPROC(cpu_resume_after_mmu)
> >>  
> >>  #ifdef CONFIG_MMU
> >>  	.arm
> >> +#ifdef CONFIG_MCPM
> >> +ENTRY(cpu_resume_no_hyp)
> >> +ARM_BE8(setend be)			@ ensure we are in BE mode
> >> +	b	0f
> > What if the kernel is built for Thumb?  You'll be branching to thumb
> > code at the '0' label - don't you need to do the same that
> > cpu_resume_arm does below?
> 
> Maybe yes, but I don't get how did it work so far. Current version of
> the cpu_resume() doesn't check the CPU ARM/Thumb mode. Such version is
> used by MCPM, blSwitcher and various suspend/resume code from
> arch/arm/mach-*. The mode check is in the cpu_resume_arm(), which is
> used only by two SoC drivers in drivers/soc). Does it mean that most of
> the current cpu_resume() users are wrong?

No, it means that the current cpu_resume users are aware whether they
are calling into Thumb code or not (via bit 0 of the address.)

This is not the case for the code you are introducing.  You are adding
code prefixed by .arm, and branching to code prefixed by .thumb.  The
branch instruction does not switch between ARM and Thumb mode.

> I've didn't try building Thumb kernel so far to check that.
> 
> >> +#endif
> >>  ENTRY(cpu_resume_arm)
> >>   THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
> >>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
> >> @@ -135,6 +140,9 @@ ARM_BE8(setend be)			@ ensure we are in BE mode
> >>  	bl	__hyp_stub_install_secondary
> >>  #endif
> >>  	safe_svcmode_maskall r1
> >> +#ifdef CONFIG_MCPM
> >> +0:
> >> +#endif
> > You don't need to conditionalise this.  I'd also use a symbol rather
> > than a numeric label given that safe_svcmode_maskall is a macro that
> > also uses numeric labels.
> 
> Okay.
> 
> >>  	mov	r1, #0
> >>  	ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
> >>  	ALT_UP_B(1f)
> >> @@ -163,6 +171,9 @@ ENDPROC(cpu_resume)
> >>  
> >>  #ifdef CONFIG_MMU
> >>  ENDPROC(cpu_resume_arm)
> >> +#endif
> >> +#ifdef CONFIG_MCPM
> >> +ENDPROC(cpu_resume_no_hyp)
> >>  #endif
> >>  
> >>  	.align 2
> >> -- 
> >> 2.17.1
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
