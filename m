Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CFBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EF52147D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EF52147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389680AbeIUPx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:53:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58692 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389022AbeIUPx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:53:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 765F720798; Fri, 21 Sep 2018 12:05:47 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 487F520720;
        Fri, 21 Sep 2018 12:05:47 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
        ylefloch@online.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ARM: mvebu: use dt_fixup to provide fallback for enable-method
References: <20180726034856.20743-1-chris.packham@alliedtelesis.co.nz>
Date:   Fri, 21 Sep 2018 12:05:48 +0200
In-Reply-To: <20180726034856.20743-1-chris.packham@alliedtelesis.co.nz> (Chris
        Packham's message of "Thu, 26 Jul 2018 15:48:56 +1200")
Message-ID: <8736u3jhc3.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,
 
 On jeu., juil. 26 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> We need to maintain backwards compatibility with device trees that don't
> define an enable method. At the same time we want the device tree to be
> able to specify an enable-method and have it stick.
>
> Previously by having smp assigned in the DT_MACHINE definition this
> would be picked up by setup_arch() and override whatever
> arm_dt_init_cpu_maps() had configured. Now we move the initial
> assignment of default smp_ops to a dt_fixup and let
> arm_dt_init_cpu_maps() override that if the device tree defines an
> enable-method.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

I made several tests on an Armada XP based board: OpenBlock AX3: I
modify the enable-method in the decvice tree, and I confirm that without
your patch it is not taken into account whereas with this patch the
enable-method is applied form the device tree. I also didn't see any
regression with the original dtb.

So I added my:
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

and applied on mvebu/soc

Thanks,

Gregory

> ---
> Pervious versions
>
> v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300182.html
> v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300480.html
> v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302945.html
> v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303899.html
>
> Changes since v4:
> - drop "RFC"
>
>  arch/arm/mach-mvebu/board-v7.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index ccca95173e17..5bbde5e5258e 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -145,6 +145,11 @@ static void __init mvebu_dt_init(void)
>  		i2c_quirk();
>  }
>  
> +static void __init armada_370_xp_dt_fixup(void)
> +{
> +	smp_set_ops(smp_ops(armada_xp_smp_ops));
> +}
> +
>  static const char * const armada_370_xp_dt_compat[] __initconst = {
>  	"marvell,armada-370-xp",
>  	NULL,
> @@ -153,17 +158,12 @@ static const char * const armada_370_xp_dt_compat[] __initconst = {
>  DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
>  	.l2c_aux_val	= 0,
>  	.l2c_aux_mask	= ~0,
> -/*
> - * The following field (.smp) is still needed to ensure backward
> - * compatibility with old Device Trees that were not specifying the
> - * cpus enable-method property.
> - */
> -	.smp		= smp_ops(armada_xp_smp_ops),
>  	.init_machine	= mvebu_dt_init,
>  	.init_irq       = mvebu_init_irq,
>  	.restart	= mvebu_restart,
>  	.reserve        = mvebu_memblock_reserve,
>  	.dt_compat	= armada_370_xp_dt_compat,
> +	.dt_fixup	= armada_370_xp_dt_fixup,
>  MACHINE_END
>  
>  static const char * const armada_375_dt_compat[] __initconst = {
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
