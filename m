Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeEQOxN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:53:13 -0400
Received: from regular1.263xmail.com ([211.150.99.136]:49231 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeEQOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:53:11 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: david.wu@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 220.200.40.10
X-LOGIN-NAME: david.wu@rock-chips.com
X-UNIQUE-TAG: <04e50bde703655b1c12559308493abc2>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH] ethernet: stmmac: dwmac-rk: Add GMAC support for px30
To: Shawn Lin <shawn.lin@rock-chips.com>, robh+dt@kernel.org
Cc: davem@davemloft.net, heiko@sntech.de, mark.rutland@arm.com,
        huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1526441925-12654-1-git-send-email-david.wu@rock-chips.com>
 <f7f67fbe-41e7-4497-cb01-a1fa2195d4b0@rock-chips.com>
From: David Wu <david.wu@rock-chips.com>
Message-ID: <4c9cdacb-4865-20f1-bad9-e9d826319bb7@rock-chips.com>
Date: Thu, 17 May 2018 22:52:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f7f67fbe-41e7-4497-cb01-a1fa2195d4b0@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Shawn,

Thanks for the suggestion, the most is okay.

在 2018年05月16日 14:34, Shawn Lin 写道:
> Hi David,
> 
> On 2018/5/16 11:38, David Wu wrote:
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c 
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> index 13133b3..4b2ab71 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> @@ -61,6 +61,7 @@ struct rk_priv_data {
>>       struct clk *mac_clk_tx;
>>       struct clk *clk_mac_ref;
>>       struct clk *clk_mac_refout;
>> +    struct clk *clk_mac_speed;
> 
> No need to do anything now but it seems you could consider doing some
> cleanup by using clk bulk APIs in the future.

The use of this may seem to be less applicable because there are many 
scenarios using different clocks.

> 
>>       struct clk *aclk_mac;
>>       struct clk *pclk_mac;
>>       struct clk *clk_phy;
>> @@ -83,6 +84,64 @@ struct rk_priv_data {
>>       (((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : 
>> soc##_GMAC_TXCLK_DLY_DISABLE) | \
>>        ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : 
>> soc##_GMAC_RXCLK_DLY_DISABLE))
>> +#define PX30_GRF_GMAC_CON1        0X0904
> 
> s/0X0904/0x0904 , since the other constants in this file follow the
> same format.
> 
>> +
>> +/* PX30_GRF_GMAC_CON1 */
>> +#define PX30_GMAC_PHY_INTF_SEL_RMII    (GRF_CLR_BIT(4) | 
>> GRF_CLR_BIT(5) | \
>> +                    GRF_BIT(6))
>> +#define PX30_GMAC_SPEED_10M        GRF_CLR_BIT(2)
>> +#define PX30_GMAC_SPEED_100M        GRF_BIT(2)
>> +
>> +static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
>> +{
>> +    struct device *dev = &bsp_priv->pdev->dev;
>> +
>> +    if (IS_ERR(bsp_priv->grf)) {
>> +        dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
>> +        return;
>> +    }
>> +
>> +    regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
>> +             PX30_GMAC_PHY_INTF_SEL_RMII);
>> +}
>> +
>> +static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int 
>> speed)
>> +{
>> +    struct device *dev = &bsp_priv->pdev->dev;
>> +    int ret;
>> +
>> +    if (IS_ERR(bsp_priv->clk_mac_speed)) {
>> +        dev_err(dev, "%s: Missing clk_mac_speed clock\n", __func__);
>> +        return;
>> +    }
>> +
>> +    if (speed == 10) {
>> +        regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
>> +                 PX30_GMAC_SPEED_10M);
>> +
>> +        ret = clk_set_rate(bsp_priv->clk_mac_speed, 2500000);
>> +        if (ret)
>> +            dev_err(dev, "%s: set clk_mac_speed rate 2500000 failed: 
>> %d\n",
>> +                __func__, ret);
>> +    } else if (speed == 100) {
>> +        regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
>> +                 PX30_GMAC_SPEED_100M);
>> +
>> +        ret = clk_set_rate(bsp_priv->clk_mac_speed, 25000000);
>> +        if (ret)
>> +            dev_err(dev, "%s: set clk_mac_speed rate 25000000 failed: 
>> %d\n",
>> +                __func__, ret);
> 
> I know it follows the existing examples, but IMHO it duplicates
> unnecessary code as all the difference is PX30_GMAC_SPEED_*
> 

i think the difference is the register offset and bits.

>> +
>> +    } else {
>> +        dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
>> +    }
>> +}
>> +
>> +static const struct rk_gmac_ops px30_ops = {
>> +    .set_to_rmii = px30_set_to_rmii,
>> +    .set_rmii_speed = px30_set_rmii_speed,
>> +};
>> +
>>   #define RK3128_GRF_MAC_CON0    0x0168
>>   #define RK3128_GRF_MAC_CON1    0x016c
>> @@ -1042,6 +1101,10 @@ static int rk_gmac_clk_init(struct 
>> plat_stmmacenet_data *plat)
>>           }
>>       }
>> +    bsp_priv->clk_mac_speed = devm_clk_get(dev, "clk_mac_speed");
> 
> Mightbe it'd be better to use "mac-speed" in DT bindings.
> 
>> +    if (IS_ERR(bsp_priv->clk_mac_speed))
>> +        dev_err(dev, "cannot get clock %s\n", "clk_mac_speed");
>> +
> 
> Would you like to handle deferred probe >

No,

>>       if (bsp_priv->clock_input) {
>>           dev_info(dev, "clock input from PHY\n");
>>       } else {
>> @@ -1424,6 +1487,7 @@ static int rk_gmac_resume(struct device *dev)
>>   static SIMPLE_DEV_PM_OPS(rk_gmac_pm_ops, rk_gmac_suspend, 
>> rk_gmac_resume);
>>   static const struct of_device_id rk_gmac_dwmac_match[] = {
>> +    { .compatible = "rockchip,px30-gmac",    .data = &px30_ops   },
>>       { .compatible = "rockchip,rk3128-gmac", .data = &rk3128_ops },
>>       { .compatible = "rockchip,rk3228-gmac", .data = &rk3228_ops },
>>       { .compatible = "rockchip,rk3288-gmac", .data = &rk3288_ops },
>>
> 
> 
> 
