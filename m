Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF0D23DE1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF0D23DE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbeGDHLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:11:06 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:36258 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932207AbeGDHJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:09:28 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990946AbeGDHJ0e3tPf (ORCPT <rfc822;netdev@vger.kernel.org>
        + 2 others); Wed, 4 Jul 2018 09:09:26 +0200
Date:   Wed, 4 Jul 2018 09:09:19 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
Message-ID: <20180704070919.GA14051@lenoch>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 09:39:51AM -0700, Florian Fainelli wrote:
> 
> 
> On 06/29/2018 02:40 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > On da850-evm board we can read the MAC address from MTD. It's currently
> > done in the relevant board file, but we want to get rid of all the MAC
> > reading callbacks from the board file (SPI and NAND). Move the reading
> > of the MAC address from SPI to the emac driver's probe function.
> 
> This should be made something generic to all drivers, not just something
> the davinci_emac driver does, something like this actually:
> 
> https://lkml.org/lkml/2018/3/24/312

...and that's would also make it work when MAC address is stored
in 24c08 EEPROM, which is quite common.

> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/net/ethernet/ti/davinci_emac.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> > index a1a6445b5a7e..48e6a7755811 100644
> > --- a/drivers/net/ethernet/ti/davinci_emac.c
> > +++ b/drivers/net/ethernet/ti/davinci_emac.c
> > @@ -67,7 +67,7 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/of_net.h>
> >  #include <linux/mfd/syscon.h>
> > -
> > +#include <linux/mtd/mtd.h>
> >  #include <asm/irq.h>
> >  #include <asm/page.h>
> >  
> > @@ -1783,7 +1783,10 @@ static int davinci_emac_probe(struct platform_device *pdev)
> >  	struct cpdma_params dma_params;
> >  	struct clk *emac_clk;
> >  	unsigned long emac_bus_frequency;
> > -
> > +#ifdef CONFIG_MTD
> > +	size_t mac_addr_len;
> > +	struct mtd_info *mtd;
> > +#endif /* CONFIG_MTD */
> >  
> >  	/* obtain emac clock from kernel */
> >  	emac_clk = devm_clk_get(&pdev->dev, NULL);
> > @@ -1815,6 +1818,19 @@ static int davinci_emac_probe(struct platform_device *pdev)
> >  		goto err_free_netdev;
> >  	}
> >  
> > +#ifdef CONFIG_MTD
> > +	mtd = get_mtd_device_nm("MAC-Address");
> > +	if (!IS_ERR(mtd)) {
> > +		rc = mtd_read(mtd, 0, ETH_ALEN,
> > +			      &mac_addr_len, priv->mac_addr);
> > +		if (rc == 0)
> > +			dev_info(&pdev->dev,
> > +				 "Read MAC addr from SPI Flash: %pM\n",
> > +				 priv->mac_addr);
> > +		put_mtd_device(mtd);
> > +	}
> > +#endif /* CONFIG_MTD */
> > +
> >  	/* MAC addr and PHY mask , RMII enable info from platform_data */
> >  	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
> >  	priv->phy_id = pdata->phy_id;
> > 
> 
> -- 
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
