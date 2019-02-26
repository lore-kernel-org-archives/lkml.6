Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763EBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C322173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X3ZcKFFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfBZJNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:13:16 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40622 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rN/vYI1apXmqETfSu1hNaWVMxuYAyNbOc0nOn72dKrE=; b=X3ZcKFFiu4i4Bml7kvtzTrB0v
        WnQQap4Awoj4BFW6AIkqDJsCJ96WpR8uqh7E2qWGcD2OfDhRR4EF++YksSSqE1RqyotWlpzqJmDIi
        y2rvYHLwT3Wq9B2v1GVCEkpK5WENGVnw87LGJufRKok6XJLghhugFCbXp4ANtGHCUd93B+NJ104qc
        pJJzBAUip8vSuYQaYn4rKGnIsU1StJ4EsdIVQW6h7tS/zgMvu1HloBotBgaBzbCsWhqQyJ96XOibv
        y8mFB+thRs5VuEmPjQcg6WPidaDsccB4uimEIuT0mvbyas25onR2cbi8Ue8tIobpqa7GU4WlzOJT+
        AlHxV9JUQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54788)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gyYnV-0002YC-2Y; Tue, 26 Feb 2019 09:13:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gyYnU-0005ZW-6x; Tue, 26 Feb 2019 09:13:08 +0000
Date:   Tue, 26 Feb 2019 09:13:08 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     digetx@gmail.com, jhogan@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: tegra: enforce PM requirement
Message-ID: <20190226091308.ycruijz2lcziv5gt@shell.armlinux.org.uk>
References: <1551169537-17548-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551169537-17548-1-git-send-email-spujar@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 01:55:37PM +0530, Sameer Pujar wrote:
> The requirement for this came while adding runtime PM support for HDA
> driver. There were concerns about driver explicitly handling !PM case.
> In general, drivers need to handle !PM case with work arounds for
> managing clocks and power explicitly, which is not really necessary
> when PM support on tegra is in good shape. In fact ARM 64-bit Tegra
> platforms enforce PM support and there is no reason why this cannot be
> done for 32-bit.
> 
> More details with regards to above can be found in following patch,
> http://patchwork.ozlabs.org/patch/1036645/
> 
> This patch selects PM unconditionally and drivers can rely on runtime
> PM framework for clock and power management.

What if the drivers are re-used on another SoC IP?  Doesn't this lead
to unexpected failures?

If you want to do this, maybe also make those drivers depend on PM as
well?

> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/mach-tegra/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 7f3b83e..51a8fa3 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -10,6 +10,7 @@ menuconfig ARCH_TEGRA
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
>  	select PINCTRL
> +	select PM
>  	select PM_OPP
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select RESET_CONTROLLER
> -- 
> 2.7.4
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
