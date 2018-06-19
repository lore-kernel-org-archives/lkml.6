Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0086C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CAD20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CAD20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030386AbeFSSAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:00:23 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46841 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeFSSAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:00:22 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 143BE300002A0;
        Tue, 19 Jun 2018 20:00:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C8E4571D0E; Tue, 19 Jun 2018 20:00:19 +0200 (CEST)
Date:   Tue, 19 Jun 2018 20:00:19 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] net: ethernet: fix suspend/resume in davinci_emac
Message-ID: <20180619180019.GA25396@wunner.de>
References: <20180619160950.6283-1-brgl@bgdev.pl>
 <20180619160950.6283-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619160950.6283-2-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 06:09:48PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This patch reverts commit 3243ff2a05ec ("net: ethernet: davinci_emac:
> Deduplicate bus_find_device() by name matching") and adds a comment
> which should stop anyone from reintroducing the same "fix" in the future.
> 
> We can't use bus_find_device_by_name() here because the device name is
> not guaranteed to be 'davinci_mdio'. On some systems it can be
> 'davinci_mdio.0' so we need to use strncmp() against the first part of
> the string to correctly match it.
> 
> Fixes: 3243ff2a05ec ("net: ethernet: davinci_emac: Deduplicate bus_find_device() by name matching")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is still

Acked-by: Lukas Wunner <lukas@wunner.de>

given that my patch which is reverted here seems to have been incorrect.
Feel free to keep the ack if you respin in response to Florian Fainelli's
comments.

Thanks,

Lukas

> ---
>  drivers/net/ethernet/ti/davinci_emac.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index 06d7c9e4dcda..a1a6445b5a7e 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -1385,6 +1385,11 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
>  		return -EOPNOTSUPP;
>  }
>  
> +static int match_first_device(struct device *dev, void *data)
> +{
> +	return !strncmp(dev_name(dev), "davinci_mdio", 12);
> +}
> +
>  /**
>   * emac_dev_open - EMAC device open
>   * @ndev: The DaVinci EMAC network adapter
> @@ -1484,8 +1489,14 @@ static int emac_dev_open(struct net_device *ndev)
>  
>  	/* use the first phy on the bus if pdata did not give us a phy id */
>  	if (!phydev && !priv->phy_id) {
> -		phy = bus_find_device_by_name(&mdio_bus_type, NULL,
> -					      "davinci_mdio");
> +		/* NOTE: we can't use bus_find_device_by_name() here because
> +		 * the device name is not guaranteed to be 'davinci_mdio'. On
> +		 * some systems it can be 'davinci_mdio.0' so we need to use
> +		 * strncmp() against the first part of the string to correctly
> +		 * match it.
> +		 */
> +		phy = bus_find_device(&mdio_bus_type, NULL, NULL,
> +				      match_first_device);
>  		if (phy) {
>  			priv->phy_id = dev_name(phy);
>  			if (!priv->phy_id || !*priv->phy_id)
> -- 
> 2.17.1
> 
