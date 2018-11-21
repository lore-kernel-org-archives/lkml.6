Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59B5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D23521479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D23521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free-electrons.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeKUSfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:35:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36946 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbeKUSfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:35:33 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0968220791; Wed, 21 Nov 2018 09:02:04 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id C0B4A20510;
        Wed, 21 Nov 2018 09:02:03 +0100 (CET)
Date:   Wed, 21 Nov 2018 09:02:03 +0100
From:   Antoine Tenart <antoine.tenart@free-electrons.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v3 4/5] phy: mvebu-cp110-comphy: convert to use eth phy
 mode and submode
Message-ID: <20181121080203.GB6494@kwain>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
 <20181120012424.11802-5-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120012424.11802-5-grygorii.strashko@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grygorii,

On Mon, Nov 19, 2018 at 07:24:23PM -0600, Grygorii Strashko wrote:
> Convert mvebu-cp110-comphy PHY driver to use recently introduced
> PHY_MODE_ETHERNET and phy_set_mode_ext().
> 
> Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
> Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Thanks for the changes, this looks good. I tested this on a
MacchiatoBin.

Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>

> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 19 +-----
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c    | 90 ++++++++++++++-----------
>  2 files changed, 53 insertions(+), 56 deletions(-)
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
> index 79b52c3..2b4462a 100644
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
> @@ -116,41 +117,43 @@
>  
>  struct mvebu_comhy_conf {
>  	enum phy_mode mode;
> +	int submode;
>  	unsigned lane;
>  	unsigned port;
>  	u32 mux;
>  };
>  
> -#define MVEBU_COMPHY_CONF(_lane, _port, _mode, _mux)	\
> +#define MVEBU_COMPHY_CONF(_lane, _port, _submode, _mux)	\
>  	{						\
>  		.lane = _lane,				\
>  		.port = _port,				\
> -		.mode = _mode,				\
> +		.mode = PHY_MODE_ETHERNET,		\
> +		.submode = _submode,			\
>  		.mux = _mux,				\
>  	}
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
> @@ -163,10 +166,12 @@ struct mvebu_comphy_lane {
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
> @@ -177,7 +182,8 @@ static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
>  	for (i = 0; i < n; i++) {
>  		if (mvebu_comphy_cp110_modes[i].lane == lane &&
>  		    mvebu_comphy_cp110_modes[i].port == port &&
> -		    mvebu_comphy_cp110_modes[i].mode == mode)
> +		    mvebu_comphy_cp110_modes[i].mode == mode &&
> +		    mvebu_comphy_cp110_modes[i].submode == submode)
>  			break;
>  	}
>  
> @@ -187,8 +193,7 @@ static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
>  	return mvebu_comphy_cp110_modes[i].mux;
>  }
>  
> -static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
> -					     enum phy_mode mode)
> +static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane)
>  {
>  	struct mvebu_comphy_priv *priv = lane->priv;
>  	u32 val;
> @@ -206,14 +211,14 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
>  		 MVEBU_COMPHY_SERDES_CFG0_HALF_BUS |
>  		 MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xf) |
>  		 MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xf));
> -	if (mode == PHY_MODE_10GKR)
> +	if (lane->submode == PHY_INTERFACE_MODE_10GKR)
>  		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xe) |
>  		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xe);
> -	else if (mode == PHY_MODE_2500SGMII)
> +	else if (lane->submode == PHY_INTERFACE_MODE_2500BASEX)
>  		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x8) |
>  		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x8) |
>  		       MVEBU_COMPHY_SERDES_CFG0_HALF_BUS;
> -	else if (mode == PHY_MODE_SGMII)
> +	else if (lane->submode == PHY_INTERFACE_MODE_SGMII)
>  		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x6) |
>  		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x6) |
>  		       MVEBU_COMPHY_SERDES_CFG0_HALF_BUS;
> @@ -243,7 +248,7 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
>  	/* refclk selection */
>  	val = readl(priv->base + MVEBU_COMPHY_MISC_CTRL0(lane->id));
>  	val &= ~MVEBU_COMPHY_MISC_CTRL0_REFCLK_SEL;
> -	if (mode == PHY_MODE_10GKR)
> +	if (lane->submode == PHY_INTERFACE_MODE_10GKR)
>  		val |= MVEBU_COMPHY_MISC_CTRL0_ICP_FORCE;
>  	writel(val, priv->base + MVEBU_COMPHY_MISC_CTRL0(lane->id));
>  
> @@ -261,8 +266,7 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
>  	writel(val, priv->base + MVEBU_COMPHY_LOOPBACK(lane->id));
>  }
>  
> -static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane,
> -				  enum phy_mode mode)
> +static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane)
>  {
>  	struct mvebu_comphy_priv *priv = lane->priv;
>  	u32 val;
> @@ -303,13 +307,13 @@ static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane,
>  	return 0;
>  }
>  
> -static int mvebu_comphy_set_mode_sgmii(struct phy *phy, enum phy_mode mode)
> +static int mvebu_comphy_set_mode_sgmii(struct phy *phy)
>  {
>  	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
>  	struct mvebu_comphy_priv *priv = lane->priv;
>  	u32 val;
>  
> -	mvebu_comphy_ethernet_init_reset(lane, mode);
> +	mvebu_comphy_ethernet_init_reset(lane);
>  
>  	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
>  	val &= ~MVEBU_COMPHY_RX_CTRL1_CLK8T_EN;
> @@ -330,7 +334,7 @@ static int mvebu_comphy_set_mode_sgmii(struct phy *phy, enum phy_mode mode)
>  	val |= MVEBU_COMPHY_GEN1_S0_TX_EMPH(0x1);
>  	writel(val, priv->base + MVEBU_COMPHY_GEN1_S0(lane->id));
>  
> -	return mvebu_comphy_init_plls(lane, PHY_MODE_SGMII);
> +	return mvebu_comphy_init_plls(lane);
>  }
>  
>  static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
> @@ -339,7 +343,7 @@ static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
>  	struct mvebu_comphy_priv *priv = lane->priv;
>  	u32 val;
>  
> -	mvebu_comphy_ethernet_init_reset(lane, PHY_MODE_10GKR);
> +	mvebu_comphy_ethernet_init_reset(lane);
>  
>  	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
>  	val |= MVEBU_COMPHY_RX_CTRL1_RXCLK2X_SEL |
> @@ -469,7 +473,7 @@ static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
>  	val |= MVEBU_COMPHY_EXT_SELV_RX_SAMPL(0x1a);
>  	writel(val, priv->base + MVEBU_COMPHY_EXT_SELV(lane->id));
>  
> -	return mvebu_comphy_init_plls(lane, PHY_MODE_10GKR);
> +	return mvebu_comphy_init_plls(lane);
>  }
>  
>  static int mvebu_comphy_power_on(struct phy *phy)
> @@ -479,7 +483,8 @@ static int mvebu_comphy_power_on(struct phy *phy)
>  	int ret, mux;
>  	u32 val;
>  
> -	mux = mvebu_comphy_get_mux(lane->id, lane->port, lane->mode);
> +	mux = mvebu_comphy_get_mux(lane->id, lane->port,
> +				   lane->mode, lane->submode);
>  	if (mux < 0)
>  		return -ENOTSUPP;
>  
> @@ -492,12 +497,12 @@ static int mvebu_comphy_power_on(struct phy *phy)
>  	val |= mux << MVEBU_COMPHY_SELECTOR_PHY(lane->id);
>  	regmap_write(priv->regmap, MVEBU_COMPHY_SELECTOR, val);
>  
> -	switch (lane->mode) {
> -	case PHY_MODE_SGMII:
> -	case PHY_MODE_2500SGMII:
> -		ret = mvebu_comphy_set_mode_sgmii(phy, lane->mode);
> +	switch (lane->submode) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		ret = mvebu_comphy_set_mode_sgmii(phy);
>  		break;
> -	case PHY_MODE_10GKR:
> +	case PHY_INTERFACE_MODE_10GKR:
>  		ret = mvebu_comphy_set_mode_10gkr(phy);
>  		break;
>  	default:
> @@ -517,10 +522,17 @@ static int mvebu_comphy_set_mode(struct phy *phy,
>  {
>  	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
>  
> -	if (mvebu_comphy_get_mux(lane->id, lane->port, mode) < 0)
> +	if (mode != PHY_MODE_ETHERNET)
> +		return -EINVAL;
> +
> +	if (submode == PHY_INTERFACE_MODE_1000BASEX)
> +		submode = PHY_INTERFACE_MODE_SGMII;
> +
> +	if (mvebu_comphy_get_mux(lane->id, lane->port, mode, submode) < 0)
>  		return -EINVAL;
>  
>  	lane->mode = mode;
> +	lane->submode = submode;
>  	return 0;
>  }
>  
> -- 
> 2.10.5
> 

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
