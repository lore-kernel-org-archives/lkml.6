Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECBAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1E72241B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lzcKsEvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1E72241B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeKLUhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:37:14 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50374 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeKLUhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:37:14 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wACAhG9R015867;
        Mon, 12 Nov 2018 04:43:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542019396;
        bh=D41sDvOitjinyOHrvKOoNrJ1j0fqCurOOawxwtTDbR8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lzcKsEvRUBqGsR8Mmi3fwCOg8tgSurtOR9r+XNfqQQR69t0zMmBsJp7qCjsB1kx4i
         Hl+rjXPhPxRmH12dLkRiZPrLeqWqKrvJVcinUgQVtEVXbUKaDLjqm/asNW/ju3aZ6b
         IAGFPiiPDPSHAOMsGiWFLiQfMn+teE6Dvqie1sKM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wACAhGSu126261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 04:43:16 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 12
 Nov 2018 04:43:16 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 12 Nov 2018 04:43:16 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wACAhAwS003870;
        Mon, 12 Nov 2018 04:43:10 -0600
Subject: Re: [PATCH v2 3/5] phy: ocelot-serdes: convert to use eth phy mode
 and submode
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Quentin Schulz <quentin.schulz@bootlin.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20181109234755.21687-1-grygorii.strashko@ti.com>
 <20181109234755.21687-4-grygorii.strashko@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7fbbaae0-6c6d-a813-109c-15c45e20555e@ti.com>
Date:   Mon, 12 Nov 2018 16:12:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181109234755.21687-4-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin, David Miller

Need your ACK on this patch.

Thanks
Kishon

On 10/11/18 5:17 AM, Grygorii Strashko wrote:
> Convert ocelot-serdes PHY driver to use recently introduced
> PHY_MODE_ETHERNET and phy_set_mode_ext().
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/mscc/ocelot.c   |  9 ++-------
>  drivers/phy/mscc/phy-ocelot-serdes.c | 14 ++++++++++----
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 3238b9e..3edb608 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -472,7 +472,6 @@ static int ocelot_port_open(struct net_device *dev)
>  {
>  	struct ocelot_port *port = netdev_priv(dev);
>  	struct ocelot *ocelot = port->ocelot;
> -	enum phy_mode phy_mode;
>  	int err;
>  
>  	/* Enable receiving frames on the port, and activate auto-learning of
> @@ -484,12 +483,8 @@ static int ocelot_port_open(struct net_device *dev)
>  			 ANA_PORT_PORT_CFG, port->chip_port);
>  
>  	if (port->serdes) {
> -		if (port->phy_mode == PHY_INTERFACE_MODE_SGMII)
> -			phy_mode = PHY_MODE_SGMII;
> -		else
> -			phy_mode = PHY_MODE_QSGMII;
> -
> -		err = phy_set_mode(port->serdes, phy_mode);
> +		err = phy_set_mode_ext(port->serdes, PHY_MODE_ETHERNET,
> +				       port->phy_mode);
>  		if (err) {
>  			netdev_err(dev, "Could not set mode of SerDes\n");
>  			return err;
> diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
> index c61a9890..f525a21 100644
> --- a/drivers/phy/mscc/phy-ocelot-serdes.c
> +++ b/drivers/phy/mscc/phy-ocelot-serdes.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/phy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -116,8 +117,10 @@ struct serdes_mux {
>  	.mux = _mux,						\
>  }
>  
> -#define SERDES_MUX_SGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_SGMII, m, c)
> -#define SERDES_MUX_QSGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_QSGMII, m, c)
> +#define SERDES_MUX_SGMII(i, p, m, c) \
> +	SERDES_MUX(i, p, PHY_INTERFACE_MODE_SGMII, m, c)
> +#define SERDES_MUX_QSGMII(i, p, m, c) \
> +	SERDES_MUX(i, p, PHY_INTERFACE_MODE_QSGMII, m, c)
>  
>  static const struct serdes_mux ocelot_serdes_muxes[] = {
>  	SERDES_MUX_SGMII(SERDES1G(0), 0, 0, 0),
> @@ -164,12 +167,15 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
>  	unsigned int i;
>  	int ret;
>  
> +	if (mode != PHY_MODE_ETHERNET)
> +		return -EINVAL;
> +
>  	for (i = 0; i < ARRAY_SIZE(ocelot_serdes_muxes); i++) {
>  		if (macro->idx != ocelot_serdes_muxes[i].idx ||
> -		    mode != ocelot_serdes_muxes[i].mode)
> +		    submode != ocelot_serdes_muxes[i].mode)
>  			continue;
>  
> -		if (mode != PHY_MODE_QSGMII &&
> +		if (submode != PHY_INTERFACE_MODE_QSGMII &&
>  		    macro->port != ocelot_serdes_muxes[i].port)
>  			continue;
>  
> 
