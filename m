Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EDCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55F520880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBTQSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:18:14 -0500
Received: from muru.com ([72.249.23.125]:39862 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfBTQSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:18:14 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EC7AB80E1;
        Wed, 20 Feb 2019 16:18:22 +0000 (UTC)
Date:   Wed, 20 Feb 2019 08:18:09 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel
 driver
Message-ID: <20190220161809.GR15711@atomide.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
 <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Grygorii Strashko <grygorii.strashko@ti.com> [190220 15:26]:
> Deprecate cpsw-phy-sel driver as it's been replaced with new
> TI phy-gmii-sel PHY driver.

I'm not going to pick up this one, seems that Dave can merge
this later on? That is unless Dave wants to ack this one.

Regards,

Tony

> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/ti/Kconfig | 6 +++---
>  drivers/net/ethernet/ti/cpsw.h  | 6 ++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index bb126be1eb72..8b21b40a9fe5 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -49,10 +49,11 @@ config TI_DAVINCI_CPDMA
>  	  will be called davinci_cpdma.  This is recommended.
>  
>  config TI_CPSW_PHY_SEL
> -	bool
> +	bool "TI CPSW Phy mode Selection (DEPRECATED)"
> +	default n
>  	---help---
>  	  This driver supports configuring of the phy mode connected to
> -	  the CPSW.
> +	  the CPSW. DEPRECATED: use PHY_TI_GMII_SEL.
>  
>  config TI_CPSW_ALE
>  	tristate "TI CPSW ALE Support"
> @@ -64,7 +65,6 @@ config TI_CPSW
>  	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
>  	select TI_DAVINCI_CPDMA
>  	select TI_DAVINCI_MDIO
> -	select TI_CPSW_PHY_SEL
>  	select TI_CPSW_ALE
>  	select MFD_SYSCON
>  	select REGMAP
> diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
> index cf111db3dc27..907e05fc22e4 100644
> --- a/drivers/net/ethernet/ti/cpsw.h
> +++ b/drivers/net/ethernet/ti/cpsw.h
> @@ -21,7 +21,13 @@
>  			 ((mac)[2] << 16) | ((mac)[3] << 24))
>  #define mac_lo(mac)	(((mac)[4] << 0) | ((mac)[5] << 8))
>  
> +#if IS_ENABLED(CONFIG_TI_CPSW_PHY_SEL)
>  void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave);
> +#else
> +static inline
> +void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave)
> +{}
> +#endif
>  int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr);
>  
>  #endif /* __CPSW_H__ */
> -- 
> 2.17.1
> 
