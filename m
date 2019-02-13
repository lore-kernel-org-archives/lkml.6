Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6741C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898A6222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T+jwZrkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404955AbfBMS16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:27:58 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60012 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733194AbfBMS16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oinr/nZMnXAbbjSoiZ11SFTbgmsHT/w6g4VbGHqRuyc=; b=T+jwZrkOEIJfSRaDCHWsC9cXs
        1fd0QA7o2lTRcbjmWJofrdEGy695eiWmLAigpSsofL7to/uM7+QAed8j8XLG/jpeWyHXl4l13d/ea
        cJPPpATIPnph8GHfAgku2uViPItBKzHoABRQ4yXVmADVxiZR50ivsK+AMx1bjecpMkMyg=;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54446)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gtzGA-00068Y-IK; Wed, 13 Feb 2019 18:27:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gtzG6-00035E-KM; Wed, 13 Feb 2019 18:27:46 +0000
Date:   Wed, 13 Feb 2019 18:27:46 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     arnd@arndb.de, alexandre.torgue@st.com,
        Jason Liu <r64343@freescale.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/2] ARM: errata 814220-B-Cache maintenance by set/way
 operations can execute out of order.
Message-ID: <20190213182746.yblgx7i7fplt2chp@shell.armlinux.org.uk>
References: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
 <20190213095613.31045-2-benjamin.gaignard@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213095613.31045-2-benjamin.gaignard@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:56:12AM +0100, Benjamin Gaignard wrote:
> Description:
> The v7 ARM states that all cache and branch predictor maintenance operations
> that do not specify an address execute, relative to each other, in program
> order. However, because of this erratum, an L2 set/way cache maintenance
> operation can overtake an L1 set/way cache maintenance operation, this would
> cause the data corruption.
> 
> This ERRATA affected the Cortex-A7 and present in r0p2, r0p3, r0p4, r0p5.
> 
> This patch is the SW workaround by adding a DSB before changing cache levels as
> the ARM ERRATA: ARM/MP: 814220 told in the ARM ERRATA documentation.
> 
> Signed-off-by: Jason Liu <r64343@freescale.com>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>  arch/arm/Kconfig       | 10 ++++++++++
>  arch/arm/mm/cache-v7.S |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 664e918e2624..6f608558e22a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1227,6 +1227,16 @@ config PCI_HOST_ITE8152
>  	default y
>  	select DMABOUNCE
>  
> +config ARM_ERRATA_814220
> +	bool "ARM errata: Cache maintenance by set/way operations can execute out of order"
> +	depends on CPU_V7
> +	help
> +	  The v7 ARM states that all cache and branch predictor maintenance operations
> +	  that do not specify an address execute, relative to each other, in program order.
> +	  However, because of this erratum, an L2 set/way cache maintenance operation can
> +	  overtake an L1 set/way cache maintenance operation. This ERRATA only affected the
> +	  Cortex-A7 and present in r0p2, r0p3, r0p4, r0p5.

We generally try to keep help lines so that when edited on an 80 column
display, they do not wrap.  Please can you reformat the above to satisfy
that please?  (means breaking the lines after "maintenance" on the first
line.)

Thanks.

> +
>  endmenu
>  
>  menu "Kernel Features"
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 2149b47a0c5a..7ff7b4c197cc 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -163,6 +163,9 @@ loop2:
>  skip:
>  	add	r10, r10, #2			@ increment cache number
>  	cmp	r3, r10
> +#ifdef CONFIG_ARM_ERRATA_814220
> +	dsb
> +#endif
>  	bgt	flush_levels
>  finished:
>  	mov	r10, #0				@ switch back to cache level 0
> -- 
> 2.15.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
