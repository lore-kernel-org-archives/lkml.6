Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0BB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mShR3xr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0BB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407274AbeKTDcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:32:08 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42146 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406227AbeKTDcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QMYljRBaKNs7B5Gtlcnw+OMT47WLUxvUWwotj5cDauw=; b=mShR3xr3GjetSxL7B6qiJkW76
        w5NNAEMrlFfXN4Dp0QHT0dVTOkRcWpLQRIE9+rJ6brA9fBeyuxIR2mSLRTDUcJ0df20vryezvH9e5
        7q35Q4Dj9XnTwEge+8+Aa6nIsAvGhGNOt6zZUgvPbgOvwC0pBNSvlCdtz0pghbHHoKIqE=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:45591)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gOn1O-0000w3-8r; Mon, 19 Nov 2018 17:07:38 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gOn1J-0002v3-PP; Mon, 19 Nov 2018 17:07:33 +0000
Date:   Mon, 19 Nov 2018 17:07:32 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v2 4/5] phy: mvebu-cp110-comphy: convert to use eth phy
 mode and submode
Message-ID: <20181119170732.GB30658@n2100.armlinux.org.uk>
References: <20181109234755.21687-1-grygorii.strashko@ti.com>
 <20181109234755.21687-5-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109234755.21687-5-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 05:47:54PM -0600, Grygorii Strashko wrote:
> Convert mvebu-cp110-comphy PHY driver to use recently introduced
> PHY_MODE_ETHERNET and phy_set_mode_ext().
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 19 +-----
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c    | 83 ++++++++++++++-----------
>  2 files changed, 48 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 7a37a37..731793a 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -1165,28 +1165,13 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
>   */
>  static int mvpp22_comphy_init(struct mvpp2_port *port)
>  {
> -	enum phy_mode mode;
>  	int ret;
>  
>  	if (!port->comphy)
>  		return 0;
>  
> -	switch (port->phy_interface) {
> -	case PHY_INTERFACE_MODE_SGMII:
> -	case PHY_INTERFACE_MODE_1000BASEX:
> -		mode = PHY_MODE_SGMII;
> -		break;
> -	case PHY_INTERFACE_MODE_2500BASEX:
> -		mode = PHY_MODE_2500SGMII;
> -		break;
> -	case PHY_INTERFACE_MODE_10GKR:
> -		mode = PHY_MODE_10GKR;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	ret = phy_set_mode(port->comphy, mode);
> +	ret = phy_set_mode_ext(port->comphy, PHY_MODE_ETHERNET,
> +			       port->phy_interface);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> index 79b52c3..7dee72b 100644
> --- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> +++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> @@ -9,6 +9,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/phy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -131,26 +132,26 @@ struct mvebu_comhy_conf {
>  
>  static const struct mvebu_comhy_conf mvebu_comphy_cp110_modes[] = {
>  	/* lane 0 */
> -	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_2500SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(0, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(0, 1, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>  	/* lane 1 */
> -	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_2500SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(1, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(1, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>  	/* lane 2 */
> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_2500SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_10GKR, 0x1),
> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_2500BASEX, 0x1),
> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_10GKR, 0x1),
>  	/* lane 3 */
> -	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_SGMII, 0x2),
> -	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_2500SGMII, 0x2),
> +	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_SGMII, 0x2),
> +	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_2500BASEX, 0x2),
>  	/* lane 4 */
> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_SGMII, 0x2),
> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_2500SGMII, 0x2),
> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_10GKR, 0x2),
> -	MVEBU_COMPHY_CONF(4, 1, PHY_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_SGMII, 0x2),
> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_2500BASEX, 0x2),
> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_10GKR, 0x2),
> +	MVEBU_COMPHY_CONF(4, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
>  	/* lane 5 */
> -	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_2500SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>  };
>  
>  struct mvebu_comphy_priv {
> @@ -163,10 +164,12 @@ struct mvebu_comphy_lane {
>  	struct mvebu_comphy_priv *priv;
>  	unsigned id;
>  	enum phy_mode mode;
> +	int submode;
>  	int port;
>  };
>  
> -static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
> +static int mvebu_comphy_get_mux(int lane, int port,
> +				enum phy_mode mode, int submode)
>  {
>  	int i, n = ARRAY_SIZE(mvebu_comphy_cp110_modes);
>  
> @@ -177,7 +180,7 @@ static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
>  	for (i = 0; i < n; i++) {
>  		if (mvebu_comphy_cp110_modes[i].lane == lane &&
>  		    mvebu_comphy_cp110_modes[i].port == port &&
> -		    mvebu_comphy_cp110_modes[i].mode == mode)
> +		    mvebu_comphy_cp110_modes[i].mode == submode)

This looks like it could be a future source of problems, since we
have both a "mode" and a "submode".  Is there any reason not to
rename mvebu_comphy_cp110_modes's .mode member to be .submode ?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
