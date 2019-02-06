Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A83C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F8D218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bCGyYQ5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBFVxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:53:30 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41612 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfBFVxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Db5Q+dIqE4SX/ZWDE/9M3b3NTZWzTjuyzE6HWU2j1G8=; b=bCGyYQ5hNFRGxAQhSn4q8vUwpB
        jDqXZFoe54qJR33uU8kiuAwbcB+PadU+Tu8PjicY+4+G8TrSaEn/ZPfyylzFYIjQaBOPDFCwFdIWw
        XgDWPzhXsIxSlMdp2JaZg41reV5d6DwKEVbDbj8eapw0dgUi/x5UkTaQCsQfE6T2X5kU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1grV8E-0001gh-Oo; Wed, 06 Feb 2019 22:53:22 +0100
Date:   Wed, 6 Feb 2019 22:53:22 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, colin.king@canonical.com,
        linus.walleij@linaro.org, yuehaibing@huawei.com, mcgrof@kernel.org,
        frowand.list@gmail.com, robh+dt@kernel.org,
        UNGLinuxDriver@microchip.com, woojung.huh@microchip.com,
        hkallweit1@gmail.com, davem@davemloft.net, f.fainelli@gmail.com,
        vivien.didelot@gmail.com, moritz@ettus.com, alex.williams@ni.com
Subject: Re: [RFC net-next] net: fixed_phy: Move the DT based link GPIO
 parsing to of_mdio.c
Message-ID: <20190206215322.GC32483@lunn.ch>
References: <20190206205106.11517-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206205106.11517-1-mdf@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 12:51:06PM -0800, Moritz Fischer wrote:
> Move the DT based link GPIO parsing to of_mdio and let the places
> that register a fixed_phy pass in a GPIO descriptor or NULL.
> 
> This allows fixed_phy on non-DT platforms to have link GPIOs, too.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/net/dsa/dsa_loop.c                   |  2 +-
>  drivers/net/ethernet/broadcom/bgmac.c        |  2 +-
>  drivers/net/ethernet/broadcom/genet/bcmmii.c |  2 +-
>  drivers/net/phy/fixed_phy.c                  | 48 ++------------------
>  drivers/net/usb/lan78xx.c                    |  2 +-
>  drivers/of/of_mdio.c                         | 15 +++++-
>  include/linux/phy_fixed.h                    |  3 +-
>  7 files changed, 23 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
> index 17482ae09aa5..7f124c620092 100644
> --- a/drivers/net/dsa/dsa_loop.c
> +++ b/drivers/net/dsa/dsa_loop.c
> @@ -343,7 +343,7 @@ static int __init dsa_loop_init(void)
>  	unsigned int i;
>  
>  	for (i = 0; i < NUM_FIXED_PHYS; i++)
> -		phydevs[i] = fixed_phy_register(PHY_POLL, &status, NULL);
> +		phydevs[i] = fixed_phy_register(PHY_POLL, &status, NULL, NULL);
>  
>  	return mdio_driver_register(&dsa_loop_drv);
>  }
> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 4632dd5dbad1..bce644dec5c2 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1446,7 +1446,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
>  	struct phy_device *phy_dev;
>  	int err;
>  
> -	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> +	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL, NULL);
>  	if (!phy_dev || IS_ERR(phy_dev)) {
>  		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
>  		return -ENODEV;
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> index 51880d83131a..7cbd737aba80 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> @@ -525,7 +525,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
>  			.asym_pause = 0,
>  		};
>  
> -		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> +		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL, NULL);
>  		if (!phydev || IS_ERR(phydev)) {
>  			dev_err(kdev, "failed to register fixed PHY device\n");
>  			return -ENODEV;
> diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
> index d810f914aaa4..845bd7c2065a 100644
> --- a/drivers/net/phy/fixed_phy.c
> +++ b/drivers/net/phy/fixed_phy.c
> @@ -18,6 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/of_mdio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/seqlock.h>
>  #include <linux/idr.h>
> @@ -191,50 +192,12 @@ static void fixed_phy_del(int phy_addr)
>  	}
>  }
>  
> -#ifdef CONFIG_OF_GPIO
> -static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
> -{
> -	struct device_node *fixed_link_node;
> -	struct gpio_desc *gpiod;
> -
> -	if (!np)
> -		return NULL;
> -
> -	fixed_link_node = of_get_child_by_name(np, "fixed-link");
> -	if (!fixed_link_node)
> -		return NULL;
> -
> -	/*
> -	 * As the fixed link is just a device tree node without any
> -	 * Linux device associated with it, we simply have obtain
> -	 * the GPIO descriptor from the device tree like this.
> -	 */
> -	gpiod = gpiod_get_from_of_node(fixed_link_node, "link-gpios", 0,
> -				       GPIOD_IN, "mdio");
> -	of_node_put(fixed_link_node);
> -	if (IS_ERR(gpiod)) {
> -		if (PTR_ERR(gpiod) == -EPROBE_DEFER)
> -			return gpiod;
> -		pr_err("error getting GPIO for fixed link %pOF, proceed without\n",
> -		       fixed_link_node);
> -		gpiod = NULL;
> -	}
> -
> -	return gpiod;
> -}
> -#else
> -static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
> -{
> -	return NULL;
> -}
> -#endif
> -
>  struct phy_device *fixed_phy_register(unsigned int irq,
>  				      struct fixed_phy_status *status,
> -				      struct device_node *np)
> +				      struct device_node *np,
> +				      struct gpio_desc *gpiod)
>  {
>  	struct fixed_mdio_bus *fmb = &platform_fmb;
> -	struct gpio_desc *gpiod = NULL;
>  	struct phy_device *phy;
>  	int phy_addr;
>  	int ret;
> @@ -242,11 +205,6 @@ struct phy_device *fixed_phy_register(unsigned int irq,
>  	if (!fmb->mii_bus || fmb->mii_bus->state != MDIOBUS_REGISTERED)
>  		return ERR_PTR(-EPROBE_DEFER);
>  
> -	/* Check if we have a GPIO associated with this fixed phy */
> -	gpiod = fixed_phy_get_gpiod(np);
> -	if (IS_ERR(gpiod))
> -		return ERR_CAST(gpiod);
> -
>  	/* Get the next available PHY address, up to PHY_MAX_ADDR */
>  	phy_addr = ida_simple_get(&phy_fixed_ida, 0, PHY_MAX_ADDR, GFP_KERNEL);
>  	if (phy_addr < 0)
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 3d92ea6fcc02..bd88f0aef2fa 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2051,7 +2051,7 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
>  	phydev = phy_find_first(dev->mdiobus);
>  	if (!phydev) {
>  		netdev_dbg(dev->net, "PHY Not Found!! Registering Fixed PHY\n");
> -		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> +		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL, NULL);
>  		if (IS_ERR(phydev)) {
>  			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
>  			return NULL;
> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
> index de6157357e26..6be2120b5f03 100644
> --- a/drivers/of/of_mdio.c
> +++ b/drivers/of/of_mdio.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
>  #include <linux/module.h>
> +#include <linux/gpio/consumer.h>
>  
>  #define DEFAULT_GPIO_RESET_DELAY	10	/* in microseconds */
>  
> @@ -460,6 +461,7 @@ int of_phy_register_fixed_link(struct device_node *np)
>  {
>  	struct fixed_phy_status status = {};
>  	struct device_node *fixed_link_node;
> +	struct gpio_desc *gpiod = NULL;
>  	u32 fixed_link_prop[5];
>  	const char *managed;
>  
> @@ -483,7 +485,17 @@ int of_phy_register_fixed_link(struct device_node *np)
>  		status.pause = of_property_read_bool(fixed_link_node, "pause");
>  		status.asym_pause = of_property_read_bool(fixed_link_node,
>  							  "asym-pause");
> +
> +		gpiod = gpiod_get_from_of_node(fixed_link_node, "link-gpios", 0,
> +				       GPIOD_IN, "mdio");
>  		of_node_put(fixed_link_node);
> +		if (IS_ERR(gpiod)) {
> +			if (PTR_ERR(gpiod) == -EPROBE_DEFER)
> +				return PTR_ERR(gpiod);
> +			pr_err("error getting GPIO for fixed link %pOF, proceed without\n",
> +			       fixed_link_node);
> +			gpiod = NULL;
>  extern struct phy_device *fixed_phy_register(unsigned int irq,
>  					     struct fixed_phy_status *status,
> -					     struct device_node *np);
> +					     struct device_node *np,
> +					     struct gpio_desc *gpiod);

Hi Moritz

I think it would be better to add a 

extern struct phy_device *fixed_phy_register_gpiod(unsigned int irq,
     					     struct fixed_phy_status *status,
					     struct gpio_desc *gpiod);

If you are not using DT, the np is pointless. So lets keep the API
simple.

	Andrew
