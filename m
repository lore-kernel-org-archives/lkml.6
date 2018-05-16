Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeEPGeg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:34:36 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:43710 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbeEPGef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:34:35 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <055b78e85cbb819b525fb1af4624a813>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: davem@davemloft.net, heiko@sntech.de, shawn.lin@rock-chips.com,
        mark.rutland@arm.com, huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ethernet: stmmac: dwmac-rk: Add GMAC support for px30
To: David Wu <david.wu@rock-chips.com>, robh+dt@kernel.org
References: <1526441925-12654-1-git-send-email-david.wu@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <f7f67fbe-41e7-4497-cb01-a1fa2195d4b0@rock-chips.com>
Date: Wed, 16 May 2018 14:34:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526441925-12654-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2018/5/16 11:38, David Wu wrote:
> Add constants and callback functions for the dwmac on px30 soc.

s/soc/SoC

> The base structure is the same, but registers and the bits in
> them moved slightly, and add the clk_mac_speed for the select

s/moved/are moved

> of mac speed.

for selecting mas speed.

> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

git log --oneline  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

shows very inconsistent format wrt. commit title, so please
follow the exsiting exsamples as possible.

> ---
>   .../devicetree/bindings/net/rockchip-dwmac.txt     |  1 +
>   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 64 ++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> index 9c16ee2..3b71da7 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt

It'd be better to split doc changes into a separate patch.

> @@ -4,6 +4,7 @@ The device node has following properties.
>   
>   Required properties:
>    - compatible: should be "rockchip,<name>-gamc"
> +   "rockchip,px30-gmac":   found on PX30 SoCs
>      "rockchip,rk3128-gmac": found on RK312x SoCs
>      "rockchip,rk3228-gmac": found on RK322x SoCs
>      "rockchip,rk3288-gmac": found on RK3288 SoCs
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 13133b3..4b2ab71 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -61,6 +61,7 @@ struct rk_priv_data {
>   	struct clk *mac_clk_tx;
>   	struct clk *clk_mac_ref;
>   	struct clk *clk_mac_refout;
> +	struct clk *clk_mac_speed;

No need to do anything now but it seems you could consider doing some
cleanup by using clk bulk APIs in the future.

>   	struct clk *aclk_mac;
>   	struct clk *pclk_mac;
>   	struct clk *clk_phy;
> @@ -83,6 +84,64 @@ struct rk_priv_data {
>   	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
>   	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
>   
> +#define PX30_GRF_GMAC_CON1		0X0904

s/0X0904/0x0904 , since the other constants in this file follow the
same format.

> +
> +/* PX30_GRF_GMAC_CON1 */
> +#define PX30_GMAC_PHY_INTF_SEL_RMII	(GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | \
> +					GRF_BIT(6))
> +#define PX30_GMAC_SPEED_10M		GRF_CLR_BIT(2)
> +#define PX30_GMAC_SPEED_100M		GRF_BIT(2)
> +
> +static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +
> +	if (IS_ERR(bsp_priv->grf)) {
> +		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
> +		return;
> +	}
> +
> +	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
> +		     PX30_GMAC_PHY_INTF_SEL_RMII);
> +}
> +
> +static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +	int ret;
> +
> +	if (IS_ERR(bsp_priv->clk_mac_speed)) {
> +		dev_err(dev, "%s: Missing clk_mac_speed clock\n", __func__);
> +		return;
> +	}
> +
> +	if (speed == 10) {
> +		regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
> +			     PX30_GMAC_SPEED_10M);
> +
> +		ret = clk_set_rate(bsp_priv->clk_mac_speed, 2500000);
> +		if (ret)
> +			dev_err(dev, "%s: set clk_mac_speed rate 2500000 failed: %d\n",
> +				__func__, ret);
> +	} else if (speed == 100) {
> +		regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
> +			     PX30_GMAC_SPEED_100M);
> +
> +		ret = clk_set_rate(bsp_priv->clk_mac_speed, 25000000);
> +		if (ret)
> +			dev_err(dev, "%s: set clk_mac_speed rate 25000000 failed: %d\n",
> +				__func__, ret);

I know it follows the existing examples, but IMHO it duplicates
unnecessary code as all the difference is PX30_GMAC_SPEED_*

> +
> +	} else {
> +		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
> +	}
> +}
> +
> +static const struct rk_gmac_ops px30_ops = {
> +	.set_to_rmii = px30_set_to_rmii,
> +	.set_rmii_speed = px30_set_rmii_speed,
> +};
> +
>   #define RK3128_GRF_MAC_CON0	0x0168
>   #define RK3128_GRF_MAC_CON1	0x016c
>   
> @@ -1042,6 +1101,10 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
>   		}
>   	}
>   
> +	bsp_priv->clk_mac_speed = devm_clk_get(dev, "clk_mac_speed");

Mightbe it'd be better to use "mac-speed" in DT bindings.

> +	if (IS_ERR(bsp_priv->clk_mac_speed))
> +		dev_err(dev, "cannot get clock %s\n", "clk_mac_speed");
> +

Would you like to handle deferred probe?

>   	if (bsp_priv->clock_input) {
>   		dev_info(dev, "clock input from PHY\n");
>   	} else {
> @@ -1424,6 +1487,7 @@ static int rk_gmac_resume(struct device *dev)
>   static SIMPLE_DEV_PM_OPS(rk_gmac_pm_ops, rk_gmac_suspend, rk_gmac_resume);
>   
>   static const struct of_device_id rk_gmac_dwmac_match[] = {
> +	{ .compatible = "rockchip,px30-gmac",	.data = &px30_ops   },
>   	{ .compatible = "rockchip,rk3128-gmac", .data = &rk3128_ops },
>   	{ .compatible = "rockchip,rk3228-gmac", .data = &rk3228_ops },
>   	{ .compatible = "rockchip,rk3288-gmac", .data = &rk3288_ops },
> 
