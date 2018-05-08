Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754971AbeEHLuD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:50:03 -0400
Received: from gloria.sntech.de ([95.129.55.99]:37762 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754954AbeEHLuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:50:01 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: djw@t-chip.com.cn, linux-gpio@vger.kernel.org,
        Wayne Chou <zxf@t-chip.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 1/2] gpio: syscon: Add gpio-syscon for rk3328
Date: Tue, 08 May 2018 13:49:46 +0200
Message-ID: <2356128.gufDZceMBS@phil>
In-Reply-To: <1525747704-8537-2-git-send-email-djw@t-chip.com.cn>
References: <1525747704-8537-1-git-send-email-djw@t-chip.com.cn> <1525747704-8537-2-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2893046.DzjenlKqZX"
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2893046.DzjenlKqZX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Levin,

Am Dienstag, 8. Mai 2018, 04:48:23 CEST schrieb djw@t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> In Rockchip RK3328 Soc, there's a output only gpio pin labeled
> `gpiomut_pmuio_iout`, which can be set by bit[1] of GRF_SOC_CON10.
> (bit[0] controls the enable state of the pin and defaults to enabled.)
> 
> This pin is used by the roc-rk3328-cc board to switch sdmmc io signal
> voltage between 1.8V and 3.3V, which is essential to the SD card UHS
> support.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

Thanks for investigating that special pin.

Please also add a devicetree-binding document under
Documentation/devicetree/bindings/gpio.

And I do have some more suggestions below.


> ---
> 
>  drivers/gpio/gpio-syscon.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
> index 537cec7..b69f65f 100644
> --- a/drivers/gpio/gpio-syscon.c
> +++ b/drivers/gpio/gpio-syscon.c
> @@ -135,6 +135,34 @@ static const struct syscon_gpio_data clps711x_mctrl_gpio = {
>  	.dat_bit_offset	= 0x40 * 8 + 8,
>  };
>  
> +static void rockchip_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +			      int val)
> +{
> +	struct syscon_gpio_priv *priv = gpiochip_get_data(chip);
> +	unsigned int offs;
> +	u8 bit;
> +	u32 data;
> +	int ret;
> +
> +	offs = priv->dreg_offset + priv->data->dat_bit_offset + offset;
> +	bit = offs % SYSCON_REG_BITS;
> +	data = (val ? BIT(bit) : 0) | BIT(bit + 16);
> +	ret = regmap_write(priv->syscon,
> +			   (offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE,
> +			   data);
> +	if (ret < 0)
> +		dev_err(chip->parent, "gpio write failed ret(%d)\n", ret);
> +}
> +
> +static const struct syscon_gpio_data rk3328_gpio_syscon10 = {
> +	/* Rockchip RK3328 GRF_SOC_CON10 Bits 0-1 */
> +	.compatible	= "rockchip,rk3328-grf",

please drop the compatible above, include the attached patch before
this one and follow the things I'll will outline in the devicetree patch
shortly :-)

Patch for getting the syscon frome the parent is compile-tested only
so please double-check that I didn't mess up anything.


> +	.flags		= GPIO_SYSCON_FEAT_OUT,
> +	.bit_count	= 2,
> +	.dat_bit_offset	= 0x0428 * 8,
> +	.set		= rockchip_gpio_set,
> +};
> +
>  #define KEYSTONE_LOCK_BIT BIT(0)
>  
>  static void keystone_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
> @@ -175,6 +203,10 @@ static const struct of_device_id syscon_gpio_ids[] = {
>  		.compatible	= "ti,keystone-dsp-gpio",
>  		.data		= &keystone_dsp_gpio,
>  	},
> +	{
> +		.compatible	= "rockchip,rk3328-gpio-syscon10",

rockchip,rk3328-gpio-mute [the naming from the TRM] could
be a more suitable naming?


Heiko
--nextPart2893046.DzjenlKqZX
Content-Disposition: attachment; filename="0001-gpio-syscon-allow-fetching-syscon-from-parent-node.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-gpio-syscon-allow-fetching-syscon-from-parent-node.patch"

>From 8894fdd9fc4ad90abec32336cc2e528d49abf887 Mon Sep 17 00:00:00 2001
From: Heiko Stuebner <heiko@sntech.de>
Date: Tue, 8 May 2018 13:33:37 +0200
Subject: [PATCH] gpio: syscon: allow fetching syscon from parent node

Syscon nodes can be a simple-mfd and the syscon-users then be declared
as children of this node. That way the parent-child structure can be
better represented for devices that are fully embedded in the syscon.

Therefore allow getting the syscon from the parent if neither
a special compatible nor a gpio,syscon-dev property is defined.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpio/gpio-syscon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 537cec7583fc..7325b864f52a 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -205,6 +205,8 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 	} else {
 		priv->syscon =
 			syscon_regmap_lookup_by_phandle(np, "gpio,syscon-dev");
+		if (IS_ERR(priv->syscon) && np->parent)
+			priv->syscon = syscon_node_to_regmap(np->parent);
 		if (IS_ERR(priv->syscon))
 			return PTR_ERR(priv->syscon);
 
-- 
2.16.2


--nextPart2893046.DzjenlKqZX--
