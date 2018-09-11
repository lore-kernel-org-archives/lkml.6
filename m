Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C915C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A042086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dzmy2jB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A042086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIKUdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:33:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51514 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeIKUdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:33:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so1485799wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+A0vrHWxCMXSmgu2eUBDO0E9bh9B0KUem/+xsAFVc2M=;
        b=Dzmy2jB7QraBngY+5eCfX9BI2ajHjyPnCyFJ+IPFFArlWUXnh4L+s333nn9TqwUoaL
         4194+886AToN4KOoe8Ds09Z6tQnWc5xkqRdhiw9OZ06NG4oQKuEdA4aHTUVpoIADxh7U
         CIfO2q1fvpvaNehrmA5i6LXCM35d3Pk5uycqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+A0vrHWxCMXSmgu2eUBDO0E9bh9B0KUem/+xsAFVc2M=;
        b=lQl/e71wu2uSfav1KZ6W5vqhDI6ufXnV9y8ssHU+iDRKbOHkQ4Hmuyx3lI0yZuHigB
         zxb51ST4RmG9u9YfImBicoixb2j5t3+tEi7t3TgnYTcDLPgu3f/xBnGnp7gocJrGg+jy
         1nRAyRzhWs2UhCsrOKKE0ENJ2NyRw5fI1/EuCl9+E61xZsZqAXIaw0GQyt5So4xEWKPy
         4LDOHaOopUOr+mPWaRqwvaTkthjT+7dF33frSxBZNDylbm2QQcoQzEU8+8Xa1G4c0clF
         objew4LWd1y/WIGnaaZVbgDoW0hI0XYSSGjFeGgw/KLnwnunlJ+XDQsA1E3TOlgYxv1o
         i4dQ==
X-Gm-Message-State: APzg51AOspemvfUvwt/nFrL8iGIfLcaLIMa89bryvlTWYIEwq2sY4AMn
        rt0sL6nGVGLaZam2qIjdhNSEfg==
X-Google-Smtp-Source: ANB0VdY9cJJ8DRKqDvNnod2Oj7nfYhk/qg2gpZOccylFbuqp+y1enyuAVZKBw23s9otCwhurGviwrg==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr1778079wmd.76.1536680023104;
        Tue, 11 Sep 2018 08:33:43 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id c3-v6sm25239669wrm.56.2018.09.11.08.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 08:33:42 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:33:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
Message-ID: <20180911153340.GY4185@dell>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Sep 2018, Srinivas Kandagatla wrote:

> Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
> It has mulitple blocks like Soundwire controller, codec,
> Codec processing engine, ClassH controller, interrupt mux.
> It supports both I2S/I2C and SLIMbus audio interfaces.
> 
> This patch adds support to SLIMbus audio interface.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/mfd/Kconfig                   |  14 +
>  drivers/mfd/Makefile                  |   4 +
>  drivers/mfd/wcd9335-core.c            | 291 ++++++++++++
>  include/linux/mfd/wcd9335/registers.h | 627 ++++++++++++++++++++++++++
>  include/linux/mfd/wcd9335/wcd9335.h   |  32 ++
>  5 files changed, 968 insertions(+)
>  create mode 100644 drivers/mfd/wcd9335-core.c
>  create mode 100644 include/linux/mfd/wcd9335/registers.h
>  create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 11841f4b7b2b..f0b3eeb61d63 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1807,6 +1807,20 @@ config MFD_WM97xx
>  	  support for the WM97xx, in order to use the actual functionaltiy of
>  	  the device other drivers must be enabled.
>  
> +config MFD_WCD9335_SLIM
> +	tristate "Qualcomm WCD9335 with SLIMbus"
> +	select MFD_CORE
> +	select REGMAP_IRQ
> +	select REGMAP_SLIMBUS
> +	depends on SLIMBUS
> +	help
> +	  The WCD9335 is a standalone Hi-Fi audio CODEC IC, supports
> +	  Qualcomm Technologies, Inc. (QTI) multimedia solutions,
> +	  including the MSM8996, MSM8976, and MSM8956 chipsets.
> +	  It has in-build Soundwire controller, interrupt mux.
> +	  It supports both I2S/I2C and SLIMbus audio interfaces.
> +	  This option selects SLIMbus audio interface.

Odd line breaks here.  1 sentence per line?

>  config MFD_STW481X
>  	tristate "Support for ST Microelectronics STw481x"
>  	depends on I2C && (ARCH_NOMADIK || COMPILE_TEST)
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5856a9489cbd..9d0b98d0cb2c 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -56,6 +56,10 @@ endif
>  ifeq ($(CONFIG_MFD_CS47L24),y)
>  obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
>  endif
> +
> +obj-$(CONFIG_MFD_WCD9335_SLIM)	+= wcd9335.o
> +wcd9335-objs			:= wcd9335-core.o
> +
>  obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
>  wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
>  wm831x-objs			+= wm831x-auxadc.o
> diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
> new file mode 100644
> index 000000000000..dbfae50c28b2
> --- /dev/null
> +++ b/drivers/mfd/wcd9335-core.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include <linux/clk.h>
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/wcd9335/registers.h>
> +#include <linux/mfd/wcd9335/wcd9335.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slimbus.h>
> +
> +#define SLIM_MANF_ID_QCOM			0x217
> +#define SLIM_PROD_CODE_WCD9335			0x1a0
> +#define WCD9335_SLIM_INTERFACE_DEVICE_INDEX	0
> +
> +static const struct regmap_range_cfg wcd9335_ranges[] = {
> +	{
> +		.name = "WCD9335",
> +		.range_min =  0x0,
> +		.range_max =  WCD9335_MAX_REGISTER,
> +		.selector_reg = WCD9335_REG(0x0, 0),
> +		.selector_mask = 0xff,
> +		.selector_shift = 0,
> +		.window_start = 0x0,
> +		.window_len = 0x1000,
> +	},
> +};
> +
> +static bool wcd9335_is_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case WCD9335_INTR_PIN1_STATUS0...WCD9335_INTR_PIN2_CLEAR3:
> +	case WCD9335_ANA_MBHC_RESULT_3:
> +	case WCD9335_ANA_MBHC_RESULT_2:
> +	case WCD9335_ANA_MBHC_RESULT_1:
> +	case WCD9335_ANA_MBHC_MECH:
> +	case WCD9335_ANA_MBHC_ELECT:
> +	case WCD9335_ANA_MBHC_ZDET:
> +	case WCD9335_ANA_MICB2:
> +	case WCD9335_ANA_RCO:
> +	case WCD9335_ANA_BIAS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static struct regmap_config wcd9335_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,
> +	.max_register = WCD9335_MAX_REGISTER,
> +	.can_multi_write = true,
> +	.ranges = wcd9335_ranges,
> +	.num_ranges = ARRAY_SIZE(wcd9335_ranges),
> +	.volatile_reg = wcd9335_is_volatile_register,
> +};
> +
> +static const struct regmap_range_cfg wcd9335_ifc_ranges[] = {
> +	{
> +		.name = "WCD9335-IFC-DEV",
> +		.range_min =  0x0,
> +		.range_max = WCD9335_REG(0, 0x7ff),
> +		.selector_reg = WCD9335_REG(0, 0x0),
> +		.selector_mask = 0xff,
> +		.selector_shift = 0,
> +		.window_start = 0x0,
> +		.window_len = 0x1000,
> +	},
> +};
> +
> +static struct regmap_config wcd9335_ifc_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.can_multi_write = true,
> +	.max_register = WCD9335_REG(0, 0x7FF),
> +	.ranges = wcd9335_ifc_ranges,
> +	.num_ranges = ARRAY_SIZE(wcd9335_ifc_ranges),
> +};
> +
> +static int wcd9335_parse_dt(struct wcd9335 *wcd)

This strategy is normally used to segregate OF specific calls.  A
driver can then choose to call them depending on whether Device Tree
is in use or not.  Seeing as most of these calls aren't actually OF
specific and that you call wcd9335_parse_dt() regardless, I suggest
you move it all into probe().

> +{
> +	struct device *dev = wcd->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	wcd->reset_gpio = of_get_named_gpio(np,	"reset-gpios", 0);
> +	if (wcd->reset_gpio < 0) {
> +		dev_err(dev, "Reset GPIO missing from DT\n");
> +		return wcd->reset_gpio;
> +	}
> +
> +	wcd->mclk = devm_clk_get(dev, "mclk");
> +	if (IS_ERR(wcd->mclk)) {
> +		dev_err(dev, "mclk not found\n");
> +		return PTR_ERR(wcd->mclk);
> +	}
> +
> +	wcd->native_clk = devm_clk_get(dev, "slimbus");
> +	if (IS_ERR(wcd->native_clk)) {
> +		dev_err(dev, "slimbus clock not found\n");
> +		return PTR_ERR(wcd->native_clk);
> +	}
> +
> +	wcd->supplies[0].supply = "vdd-buck";
> +	wcd->supplies[1].supply = "vdd-buck-sido";
> +	wcd->supplies[2].supply = "vdd-tx";
> +	wcd->supplies[3].supply = "vdd-rx";
> +	wcd->supplies[4].supply = "vdd-io";
> +
> +	ret = regulator_bulk_get(dev, WCD9335_MAX_SUPPLY, wcd->supplies);
> +	if (ret) {
> +		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int wcd9335_power_on_reset(struct wcd9335 *wcd)
> +{
> +	struct device *dev = wcd->dev;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(WCD9335_MAX_SUPPLY, wcd->supplies);
> +	if (ret) {
> +		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * For WCD9335, it takes about 600us for the Vout_A and
> +	 * Vout_D to be ready after BUCK_SIDO is powered up.
> +	 * SYS_RST_N shouldn't be pulled high during this time
> +	 * Toggle the reset line to make sure the reset pulse is
> +	 * correctly applied
> +	 */
> +	usleep_range(600, 650);
> +
> +	gpio_direction_output(wcd->reset_gpio, 0);
> +	msleep(20);
> +	gpio_set_value(wcd->reset_gpio, 1);
> +	msleep(20);
> +
> +	return 0;
> +}
> +
> +static int wcd9335_bring_up(struct wcd9335 *wcd)
> +{
> +	struct regmap *rm = wcd->regmap;
> +	int val, byte0;
> +
> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_EFUSE_VAL_OUT0, &val);
> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_CHIP_ID_BYTE0, &byte0);
> +
> +	if ((val < 0) || (byte0 < 0)) {
> +		dev_err(wcd->dev, "WCD9335 CODEC version detection fail!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (byte0 == 0x1) {

What is 0x1?  I suggest you define it.

> +		dev_info(wcd->dev, "WCD9335 CODEC version is v2.0\n");
> +		wcd->version = WCD9335_VERSION_2_0;
> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x01);
> +		regmap_write(rm, WCD9335_SIDO_SIDO_TEST_2, 0x00);
> +		regmap_write(rm, WCD9335_SIDO_SIDO_CCL_8, 0x6F);
> +		regmap_write(rm, WCD9335_BIAS_VBG_FINE_ADJ, 0x65);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x5);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x7);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x3);
> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x3);

You really need to define all of these settings.

As a human I have no idea what just happened!

> +	} else {
> +		dev_err(wcd->dev, "WCD9335 CODEC version not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int wcd9335_slim_probe(struct slim_device *slim)
> +{
> +	struct device *dev = &slim->dev;
> +	struct wcd9335 *wcd;

Would you consider calling this ddata?

> +	int ret;
> +
> +	/* Interface device */
> +	if (slim->e_addr.dev_index == WCD9335_SLIM_INTERFACE_DEVICE_INDEX)
> +		return 0;
> +
> +	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
> +	if (!wcd)
> +		return	-ENOMEM;
> +
> +	wcd->dev = dev;
> +
> +	ret = wcd9335_parse_dt(wcd);
> +	if (ret) {
> +		dev_err(dev, "Error parsing DT: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = wcd9335_power_on_reset(wcd);
> +	if (ret)
> +		return ret;
> +
> +	wcd->slim = slim;
> +	wcd->intf_type = WCD9335_INTERFACE_TYPE_SLIMBUS;
> +
> +	dev_set_drvdata(dev, wcd);
> +
> +	return 0;
> +}
> +
> +static const struct mfd_cell wcd9335_devices[] = {
> +	{ .name = "wcd9335-codec", },
> +};

Are there more devices to come?

MFD cells are usually placed at the very top of the driver.  This
makes it easy to see which devices are supported by the MFD.

> +static int wcd9335_slim_status(struct slim_device *sdev,
> +			       enum slim_device_status status)

We usually only place PM related functions below probe().

> +{
> +	struct device_node *ifc_dev_np;

ifc isn't very forthcoming.  Any way you can improve the name?

> +	struct wcd9335 *wcd;
> +	int ret;
> +
> +	if (sdev->e_addr.dev_index == WCD9335_SLIM_INTERFACE_DEVICE_INDEX)
> +		return 0;
> +
> +	wcd = dev_get_drvdata(&sdev->dev);
> +
> +	ifc_dev_np = of_parse_phandle(wcd->dev->of_node, "slim-ifc-dev", 0);
> +	if (!ifc_dev_np) {
> +		dev_err(wcd->dev, "No Interface device found\n");
> +		return -EINVAL;
> +	}
> +
> +	wcd->slim_ifc_dev = of_slim_get_device(sdev->ctrl, ifc_dev_np);
> +	if (!wcd->slim_ifc_dev) {
> +		dev_err(wcd->dev, "Unable to get SLIM Interface device\n");
> +		return -EINVAL;
> +	}
> +
> +	wcd->regmap = regmap_init_slimbus(sdev, &wcd9335_regmap_config);
> +	if (IS_ERR(wcd->regmap)) {
> +		dev_err(wcd->dev, "Failed to allocate slim register map\n");

s/slim/SLIM/ ?

> +		return PTR_ERR(wcd->regmap);
> +	}
> +
> +	wcd->ifc_dev_regmap = regmap_init_slimbus(wcd->slim_ifc_dev,
> +						  &wcd9335_ifc_regmap_config);
> +	if (IS_ERR(wcd->ifc_dev_regmap)) {
> +		dev_err(wcd->dev, "Failed to allocate ifc register map\n");

ifc in a human readable context is not good.

> +		return PTR_ERR(wcd->ifc_dev_regmap);
> +	}
> +
> +	ret = wcd9335_bring_up(wcd);

So the device_status call-back brings up the hardware?

That sounds odd to me?

> +	if (ret) {
> +		dev_err(wcd->dev, "Failed to bringup WCD9335\n");
> +		return ret;
> +	}
> +
> +	ret = devm_mfd_add_devices(wcd->dev, 0, wcd9335_devices,
> +			       ARRAY_SIZE(wcd9335_devices), NULL, 0, NULL);
> +	if (ret < 0)

if (ret) ?

> +		dev_err(wcd->dev, "Failed to add mtd devices: %d\n", ret);

a) This is not an MTD device - typo?
b) Please use a message that end users are going to care about
   Who, in the real world knows what an MFD is?

> +	return ret;
> +}
> +
> +static const struct slim_device_id wcd9335_slim_id[] = {
> +	{SLIM_MANF_ID_QCOM, SLIM_PROD_CODE_WCD9335, 0x1, 0x0},
> +	{}
> +};
> +
> +static struct slim_driver wcd9335_slim_driver = {
> +	.driver = {
> +		.name = "wcd9335-slim",
> +	},
> +	.probe = wcd9335_slim_probe,
> +	.device_status = wcd9335_slim_status,
> +	.id_table = wcd9335_slim_id,
> +};
> +
> +module_slim_driver(wcd9335_slim_driver);
> +MODULE_DESCRIPTION("WCD9335 slim driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/wcd9335/registers.h b/include/linux/mfd/wcd9335/registers.h
> new file mode 100644
> index 000000000000..f9fa35fb536b
> --- /dev/null
> +++ b/include/linux/mfd/wcd9335/registers.h
> @@ -0,0 +1,627 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

No copyright?

> +#ifndef _WCD9335_REGISTERS_H
> +#define _WCD9335_REGISTERS_H
> +
> +/*
> + * WCD9335 register base can change according to the mode it works in
> + * in slimbus mode the reg base starts from 0x800

s/slimbus/SLIMBUS/ ?

> + * in i2s/i2c mode the reg base is 0x0
> + */
> +#define WCD9335_REG(pg, r)	((pg << 12) | (r) | 0x800)
> +#define WCD9335_REG_OFFSET(r)	(r & 0xFF)
> +#define WCD9335_PAGE_OFFSET(r)	((r >> 12) & 0xFF)
> +
> +/* Page-0 Registers */
> +#define WCD9335_PAGE0_PAGE_REGISTER		WCD9335_REG(0x00, 0x000)
> +#define WCD9335_CODEC_RPM_CLK_GATE		WCD9335_REG(0x00, 0x002)
> +#define WCD9335_CODEC_RPM_CLK_GATE_MCLK_GATE_MASK	GENMASK(1, 0)
> +#define WCD9335_CODEC_RPM_CLK_MCLK_CFG		WCD9335_REG(0x00, 0x003)
> +#define WCD9335_CODEC_RPM_CLK_MCLK_CFG_9P6MHZ	BIT(0)
> +#define WCD9335_CODEC_RPM_CLK_MCLK_CFG_12P288MHZ	BIT(0)
> +#define WCD9335_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK	GENMASK(1, 0)
> +#define WCD9335_CODEC_RPM_RST_CTL		WCD9335_REG(0x00, 0x009)
> +#define WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL	WCD9335_REG(0x00, 0x011)
> +#define WCD9335_CHIP_TIER_CTRL_CHIP_ID_BYTE0	WCD9335_REG(0x00, 0x021)
> +#define WCD9335_CHIP_TIER_CTRL_EFUSE_CTL	WCD9335_REG(0x00, 0x025)
> +#define WCD9335_CHIP_TIER_CTRL_EFUSE_SSTATE_MASK GENMASK(4, 1)
> +#define WCD9335_CHIP_TIER_CTRL_EFUSE_EN_MASK	BIT(0)
> +#define WCD9335_CHIP_TIER_CTRL_EFUSE_ENABLE	BIT(0)
> +#define WCD9335_CHIP_TIER_CTRL_EFUSE_VAL_OUT0	WCD9335_REG(0x00, 0x029)
> +#define WCD9335_CHIP_TIER_CTRL_EFUSE_STATUS	WCD9335_REG(0x00, 0x039)
> +#define WCD9335_INTR_CFG			WCD9335_REG(0x00, 0x081)
> +#define WCD9335_INTR_CLR_COMMIT			WCD9335_REG(0x00, 0x082)
> +#define WCD9335_INTR_PIN1_MASK0			WCD9335_REG(0x00, 0x089)
> +#define WCD9335_INTR_PIN1_MASK1			WCD9335_REG(0x00, 0x08a)
> +#define WCD9335_INTR_PIN1_MASK2			WCD9335_REG(0x00, 0x08b)
> +#define WCD9335_INTR_PIN1_MASK3			WCD9335_REG(0x00, 0x08c)
> +#define WCD9335_INTR_PIN1_STATUS0		WCD9335_REG(0x00, 0x091)
> +#define WCD9335_INTR_PIN1_STATUS1		WCD9335_REG(0x00, 0x092)
> +#define WCD9335_INTR_PIN1_STATUS2		WCD9335_REG(0x00, 0x093)
> +#define WCD9335_INTR_PIN1_STATUS3		WCD9335_REG(0x00, 0x094)
> +#define WCD9335_INTR_PIN1_CLEAR0		WCD9335_REG(0x00, 0x099)
> +#define WCD9335_INTR_PIN1_CLEAR1		WCD9335_REG(0x00, 0x09a)
> +#define WCD9335_INTR_PIN1_CLEAR2		WCD9335_REG(0x00, 0x09b)
> +#define WCD9335_INTR_PIN1_CLEAR3		WCD9335_REG(0x00, 0x09c)
> +#define WCD9335_INTR_PIN2_MASK0			WCD9335_REG(0x00, 0x0a1)
> +#define WCD9335_INTR_PIN2_MASK1			WCD9335_REG(0x00, 0x0a2)
> +#define WCD9335_INTR_PIN2_MASK2			WCD9335_REG(0x00, 0x0a3)
> +#define WCD9335_INTR_PIN2_MASK3			WCD9335_REG(0x00, 0x0a4)
> +#define WCD9335_INTR_PIN2_STATUS0		WCD9335_REG(0x00, 0x0a9)
> +#define WCD9335_INTR_PIN2_STATUS1		WCD9335_REG(0x00, 0x0aa)
> +#define WCD9335_INTR_PIN2_STATUS2		WCD9335_REG(0x00, 0x0ab)
> +#define WCD9335_INTR_PIN2_STATUS3		WCD9335_REG(0x00, 0x0ac)
> +#define WCD9335_INTR_PIN2_CLEAR0		WCD9335_REG(0x00, 0x0b1)
> +#define WCD9335_INTR_PIN2_CLEAR1		WCD9335_REG(0x00, 0x0b2)
> +#define WCD9335_INTR_PIN2_CLEAR2		WCD9335_REG(0x00, 0x0b3)
> +#define WCD9335_INTR_PIN2_CLEAR3		WCD9335_REG(0x00, 0x0b4)
> +#define WCD9335_INTR_LEVEL0			WCD9335_REG(0x00, 0x0e1)
> +#define WCD9335_INTR_LEVEL1			WCD9335_REG(0x00, 0x0e2)
> +#define WCD9335_INTR_LEVEL2			WCD9335_REG(0x00, 0x0e3)
> +#define WCD9335_INTR_LEVEL3			WCD9335_REG(0x00, 0x0e4)
> +
> +/* Page-1 Registers */
> +#define WCD9335_CPE_FLL_USER_CTL_0		WCD9335_REG(0x01, 0x001)
> +#define WCD9335_CPE_FLL_USER_CTL_1		WCD9335_REG(0x01, 0x002)
> +#define WCD9335_CPE_FLL_USER_CTL_2		WCD9335_REG(0x01, 0x003)
> +#define WCD9335_CPE_FLL_USER_CTL_3		WCD9335_REG(0x01, 0x004)
> +#define WCD9335_CPE_FLL_USER_CTL_4		WCD9335_REG(0x01, 0x005)
> +#define WCD9335_CPE_FLL_USER_CTL_5		WCD9335_REG(0x01, 0x006)
> +#define WCD9335_CPE_FLL_USER_CTL_6		WCD9335_REG(0x01, 0x007)
> +#define WCD9335_CPE_FLL_USER_CTL_7		WCD9335_REG(0x01, 0x008)
> +#define WCD9335_CPE_FLL_USER_CTL_8		WCD9335_REG(0x01, 0x009)
> +#define WCD9335_CPE_FLL_USER_CTL_9		WCD9335_REG(0x01, 0x00a)
> +#define WCD9335_CPE_FLL_L_VAL_CTL_0		WCD9335_REG(0x01, 0x00b)
> +#define WCD9335_CPE_FLL_L_VAL_CTL_1		WCD9335_REG(0x01, 0x00c)
> +#define WCD9335_CPE_FLL_DSM_FRAC_CTL_0		WCD9335_REG(0x01, 0x00d)
> +#define WCD9335_CPE_FLL_DSM_FRAC_CTL_1		WCD9335_REG(0x01, 0x00e)
> +#define WCD9335_CPE_FLL_CONFIG_CTL_0		WCD9335_REG(0x01, 0x00f)
> +#define WCD9335_CPE_FLL_CONFIG_CTL_1		WCD9335_REG(0x01, 0x010)
> +#define WCD9335_CPE_FLL_CONFIG_CTL_2		WCD9335_REG(0x01, 0x011)
> +#define WCD9335_CPE_FLL_CONFIG_CTL_3		WCD9335_REG(0x01, 0x012)
> +#define WCD9335_CPE_FLL_CONFIG_CTL_4		WCD9335_REG(0x01, 0x013)
> +#define WCD9335_CPE_FLL_TEST_CTL_0		WCD9335_REG(0x01, 0x014)
> +#define WCD9335_CPE_FLL_TEST_CTL_1		WCD9335_REG(0x01, 0x015)
> +#define WCD9335_CPE_FLL_TEST_CTL_2		WCD9335_REG(0x01, 0x016)
> +#define WCD9335_CPE_FLL_TEST_CTL_3		WCD9335_REG(0x01, 0x017)
> +#define WCD9335_CPE_FLL_TEST_CTL_4		WCD9335_REG(0x01, 0x018)
> +#define WCD9335_CPE_FLL_TEST_CTL_5		WCD9335_REG(0x01, 0x019)
> +#define WCD9335_CPE_FLL_TEST_CTL_6		WCD9335_REG(0x01, 0x01a)
> +#define WCD9335_CPE_FLL_TEST_CTL_7		WCD9335_REG(0x01, 0x01b)
> +#define WCD9335_CPE_FLL_FREQ_CTL_0		WCD9335_REG(0x01, 0x01c)
> +#define WCD9335_CPE_FLL_FREQ_CTL_1		WCD9335_REG(0x01, 0x01d)
> +#define WCD9335_CPE_FLL_FREQ_CTL_2		WCD9335_REG(0x01, 0x01e)
> +#define WCD9335_CPE_FLL_FREQ_CTL_3		WCD9335_REG(0x01, 0x01f)
> +#define WCD9335_CPE_FLL_SSC_CTL_0		WCD9335_REG(0x01, 0x020)
> +#define WCD9335_CPE_FLL_SSC_CTL_1		WCD9335_REG(0x01, 0x021)
> +#define WCD9335_CPE_FLL_SSC_CTL_2		WCD9335_REG(0x01, 0x022)
> +#define WCD9335_CPE_FLL_SSC_CTL_3		WCD9335_REG(0x01, 0x023)
> +#define WCD9335_CPE_FLL_FLL_MODE		WCD9335_REG(0x01, 0x024)
> +#define WCD9335_CPE_FLL_STATUS_0		WCD9335_REG(0x01, 0x025)
> +#define WCD9335_CPE_FLL_STATUS_1		WCD9335_REG(0x01, 0x026)
> +#define WCD9335_CPE_FLL_STATUS_2		WCD9335_REG(0x01, 0x027)
> +#define WCD9335_CPE_FLL_STATUS_3		WCD9335_REG(0x01, 0x028)
> +#define WCD9335_I2S_FLL_USER_CTL_0		WCD9335_REG(0x01, 0x041)
> +#define WCD9335_I2S_FLL_USER_CTL_1		WCD9335_REG(0x01, 0x042)
> +#define WCD9335_I2S_FLL_USER_CTL_2		WCD9335_REG(0x01, 0x043)
> +#define WCD9335_I2S_FLL_USER_CTL_3		WCD9335_REG(0x01, 0x044)
> +#define WCD9335_I2S_FLL_USER_CTL_4		WCD9335_REG(0x01, 0x045)
> +#define WCD9335_I2S_FLL_USER_CTL_5		WCD9335_REG(0x01, 0x046)
> +#define WCD9335_I2S_FLL_USER_CTL_6		WCD9335_REG(0x01, 0x047)
> +#define WCD9335_I2S_FLL_USER_CTL_7		WCD9335_REG(0x01, 0x048)
> +#define WCD9335_I2S_FLL_USER_CTL_8		WCD9335_REG(0x01, 0x049)
> +#define WCD9335_I2S_FLL_USER_CTL_9		WCD9335_REG(0x01, 0x04a)
> +#define WCD9335_I2S_FLL_L_VAL_CTL_0		WCD9335_REG(0x01, 0x04b)
> +#define WCD9335_I2S_FLL_L_VAL_CTL_1		WCD9335_REG(0x01, 0x04c)
> +#define WCD9335_I2S_FLL_DSM_FRAC_CTL_0		WCD9335_REG(0x01, 0x04d)
> +#define WCD9335_I2S_FLL_DSM_FRAC_CTL_1		WCD9335_REG(0x01, 0x04e)
> +#define WCD9335_I2S_FLL_CONFIG_CTL_0		WCD9335_REG(0x01, 0x04f)
> +#define WCD9335_I2S_FLL_CONFIG_CTL_1		WCD9335_REG(0x01, 0x050)
> +#define WCD9335_I2S_FLL_CONFIG_CTL_2		WCD9335_REG(0x01, 0x051)
> +#define WCD9335_I2S_FLL_CONFIG_CTL_3		WCD9335_REG(0x01, 0x052)
> +#define WCD9335_I2S_FLL_CONFIG_CTL_4		WCD9335_REG(0x01, 0x053)
> +#define WCD9335_I2S_FLL_TEST_CTL_0		WCD9335_REG(0x01, 0x054)
> +#define WCD9335_I2S_FLL_TEST_CTL_1		WCD9335_REG(0x01, 0x055)
> +#define WCD9335_I2S_FLL_TEST_CTL_2		WCD9335_REG(0x01, 0x056)
> +#define WCD9335_I2S_FLL_TEST_CTL_3		WCD9335_REG(0x01, 0x057)
> +#define WCD9335_I2S_FLL_TEST_CTL_4		WCD9335_REG(0x01, 0x058)
> +#define WCD9335_I2S_FLL_TEST_CTL_5		WCD9335_REG(0x01, 0x059)
> +#define WCD9335_I2S_FLL_TEST_CTL_6		WCD9335_REG(0x01, 0x05a)
> +#define WCD9335_I2S_FLL_TEST_CTL_7		WCD9335_REG(0x01, 0x05b)
> +#define WCD9335_I2S_FLL_FREQ_CTL_0		WCD9335_REG(0x01, 0x05c)
> +#define WCD9335_I2S_FLL_FREQ_CTL_1		WCD9335_REG(0x01, 0x05d)
> +#define WCD9335_I2S_FLL_FREQ_CTL_2		WCD9335_REG(0x01, 0x05e)
> +#define WCD9335_I2S_FLL_FREQ_CTL_3		WCD9335_REG(0x01, 0x05f)
> +#define WCD9335_I2S_FLL_SSC_CTL_0		WCD9335_REG(0x01, 0x060)
> +#define WCD9335_I2S_FLL_SSC_CTL_1		WCD9335_REG(0x01, 0x061)
> +#define WCD9335_I2S_FLL_SSC_CTL_2		WCD9335_REG(0x01, 0x062)
> +#define WCD9335_I2S_FLL_SSC_CTL_3		WCD9335_REG(0x01, 0x063)
> +#define WCD9335_I2S_FLL_FLL_MODE		WCD9335_REG(0x01, 0x064)
> +#define WCD9335_I2S_FLL_STATUS_0		WCD9335_REG(0x01, 0x065)
> +#define WCD9335_I2S_FLL_STATUS_1		WCD9335_REG(0x01, 0x066)
> +#define WCD9335_I2S_FLL_STATUS_2		WCD9335_REG(0x01, 0x067)
> +#define WCD9335_I2S_FLL_STATUS_3		WCD9335_REG(0x01, 0x068)
> +#define WCD9335_SB_FLL_USER_CTL_0		WCD9335_REG(0x01, 0x081)
> +#define WCD9335_SB_FLL_USER_CTL_1		WCD9335_REG(0x01, 0x082)
> +#define WCD9335_SB_FLL_USER_CTL_2		WCD9335_REG(0x01, 0x083)
> +#define WCD9335_SB_FLL_USER_CTL_3		WCD9335_REG(0x01, 0x084)
> +#define WCD9335_SB_FLL_USER_CTL_4		WCD9335_REG(0x01, 0x085)
> +#define WCD9335_SB_FLL_USER_CTL_5		WCD9335_REG(0x01, 0x086)
> +#define WCD9335_SB_FLL_USER_CTL_6		WCD9335_REG(0x01, 0x087)
> +#define WCD9335_SB_FLL_USER_CTL_7		WCD9335_REG(0x01, 0x088)
> +#define WCD9335_SB_FLL_USER_CTL_8		WCD9335_REG(0x01, 0x089)
> +#define WCD9335_SB_FLL_USER_CTL_9		WCD9335_REG(0x01, 0x08a)
> +#define WCD9335_SB_FLL_L_VAL_CTL_0		WCD9335_REG(0x01, 0x08b)
> +#define WCD9335_SB_FLL_L_VAL_CTL_1		WCD9335_REG(0x01, 0x08c)
> +#define WCD9335_SB_FLL_DSM_FRAC_CTL_0		WCD9335_REG(0x01, 0x08d)
> +#define WCD9335_SB_FLL_DSM_FRAC_CTL_1		WCD9335_REG(0x01, 0x08e)
> +#define WCD9335_SB_FLL_CONFIG_CTL_0		WCD9335_REG(0x01, 0x08f)
> +#define WCD9335_SB_FLL_CONFIG_CTL_1		WCD9335_REG(0x01, 0x090)
> +#define WCD9335_SB_FLL_CONFIG_CTL_2		WCD9335_REG(0x01, 0x091)
> +#define WCD9335_SB_FLL_CONFIG_CTL_3		WCD9335_REG(0x01, 0x092)
> +#define WCD9335_SB_FLL_CONFIG_CTL_4		WCD9335_REG(0x01, 0x093)
> +#define WCD9335_SB_FLL_TEST_CTL_0		WCD9335_REG(0x01, 0x094)
> +#define WCD9335_SB_FLL_TEST_CTL_1		WCD9335_REG(0x01, 0x095)
> +#define WCD9335_SB_FLL_TEST_CTL_2		WCD9335_REG(0x01, 0x096)
> +#define WCD9335_SB_FLL_TEST_CTL_3		WCD9335_REG(0x01, 0x097)
> +#define WCD9335_SB_FLL_TEST_CTL_4		WCD9335_REG(0x01, 0x098)
> +#define WCD9335_SB_FLL_TEST_CTL_5		WCD9335_REG(0x01, 0x099)
> +#define WCD9335_SB_FLL_TEST_CTL_6		WCD9335_REG(0x01, 0x09a)
> +#define WCD9335_SB_FLL_TEST_CTL_7		WCD9335_REG(0x01, 0x09b)
> +#define WCD9335_SB_FLL_FREQ_CTL_0		WCD9335_REG(0x01, 0x09c)
> +#define WCD9335_SB_FLL_FREQ_CTL_1		WCD9335_REG(0x01, 0x09d)
> +#define WCD9335_SB_FLL_FREQ_CTL_2		WCD9335_REG(0x01, 0x09e)
> +#define WCD9335_SB_FLL_FREQ_CTL_3		WCD9335_REG(0x01, 0x09f)
> +#define WCD9335_SB_FLL_SSC_CTL_0		WCD9335_REG(0x01, 0x0a0)
> +#define WCD9335_SB_FLL_SSC_CTL_1		WCD9335_REG(0x01, 0x0a1)
> +#define WCD9335_SB_FLL_SSC_CTL_2		WCD9335_REG(0x01, 0x0a2)
> +#define WCD9335_SB_FLL_SSC_CTL_3		WCD9335_REG(0x01, 0x0a3)
> +#define WCD9335_SB_FLL_FLL_MODE			WCD9335_REG(0x01, 0x0a4)
> +#define WCD9335_SB_FLL_STATUS_0			WCD9335_REG(0x01, 0x0a5)
> +#define WCD9335_SB_FLL_STATUS_1			WCD9335_REG(0x01, 0x0a6)
> +#define WCD9335_SB_FLL_STATUS_2			WCD9335_REG(0x01, 0x0a7)
> +#define WCD9335_SB_FLL_STATUS_3			WCD9335_REG(0x01, 0x0a8)
> +
> +/* Page-2 Registers */
> +#define WCD9335_PAGE2_PAGE_REGISTER		WCD9335_REG(0x02, 0x000)
> +#define WCD9335_CPE_SS_DMIC0_CTL		WCD9335_REG(0x02, 0x063)
> +#define WCD9335_CPE_SS_DMIC1_CTL		WCD9335_REG(0x02, 0x064)
> +#define WCD9335_CPE_SS_DMIC2_CTL		WCD9335_REG(0x02, 0x065)
> +#define WCD9335_CPE_SS_DMIC_CFG			WCD9335_REG(0x02, 0x066)
> +#define WCD9335_SOC_MAD_AUDIO_CTL_2		WCD9335_REG(0x02, 0x084)
> +
> +/* Page-6 Registers */
> +#define WCD9335_PAGE6_PAGE_REGISTER		WCD9335_REG(0x06, 0x000)
> +#define WCD9335_ANA_BIAS			WCD9335_REG(0x06, 0x001)
> +#define WCD9335_ANA_BIAS_EN_MASK		BIT(7)
> +#define WCD9335_ANA_BIAS_ENABLE			BIT(7)
> +#define WCD9335_ANA_BIAS_DISABLE		0
> +#define WCD9335_ANA_BIAS_PRECHRG_EN_MASK	BIT(6)
> +#define WCD9335_ANA_BIAS_PRECHRG_ENABLE		BIT(6)
> +#define WCD9335_ANA_BIAS_PRECHRG_DISABLE	0
> +#define WCD9335_ANA_BIAS_PRECHRG_CTL_MODE	BIT(5)
> +#define WCD9335_ANA_BIAS_PRECHRG_CTL_MODE_AUTO	BIT(5)
> +#define WCD9335_ANA_BIAS_PRECHRG_CTL_MODE_MANUAL	0
> +#define WCD9335_ANA_CLK_TOP			WCD9335_REG(0x06, 0x002)
> +#define WCD9335_ANA_CLK_MCLK_EN_MASK		BIT(2)
> +#define WCD9335_ANA_CLK_MCLK_ENABLE		BIT(2)
> +#define WCD9335_ANA_CLK_MCLK_DISABLE		0
> +#define WCD9335_ANA_CLK_MCLK_SRC_MASK		BIT(3)
> +#define WCD9335_ANA_CLK_MCLK_SRC_RCO		BIT(3)
> +#define WCD9335_ANA_CLK_MCLK_SRC_EXTERNAL	0
> +#define WCD9335_ANA_CLK_EXT_CLKBUF_EN_MASK	BIT(7)
> +#define WCD9335_ANA_CLK_EXT_CLKBUF_ENABLE	BIT(7)
> +#define WCD9335_ANA_CLK_EXT_CLKBUF_DISABLE	0
> +#define WCD9335_ANA_RCO				WCD9335_REG(0x06, 0x003)
> +#define WCD9335_ANA_RCO_BG_EN_MASK		BIT(7)
> +#define WCD9335_ANA_RCO_BG_ENABLE		BIT(7)
> +#define WCD9335_ANA_BUCK_VOUT_D			WCD9335_REG(0x06, 0x005)
> +#define WCD9335_ANA_BUCK_VOUT_MASK		GENMASK(7, 0)
> +#define WCD9335_ANA_BUCK_CTL			WCD9335_REG(0x06, 0x006)
> +#define WCD9335_ANA_BUCK_CTL_VOUT_D_IREF_MASK	BIT(1)
> +#define WCD9335_ANA_BUCK_CTL_VOUT_D_IREF_EXT	BIT(1)
> +#define WCD9335_ANA_BUCK_CTL_VOUT_D_IREF_INT	0
> +#define WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_MASK	BIT(2)
> +#define WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_EXT	BIT(2)
> +#define WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_INT	0
> +#define WCD9335_ANA_BUCK_CTL_RAMP_START_MASK	BIT(7)
> +#define WCD9335_ANA_BUCK_CTL_RAMP_START_ENABLE	BIT(7)
> +#define WCD9335_ANA_BUCK_CTL_RAMP_START_DISABLE	0
> +#define WCD9335_ANA_RX_SUPPLIES			WCD9335_REG(0x06, 0x008)
> +#define WCD9335_ANA_RX_BIAS_ENABLE_MASK		BIT(0)
> +#define WCD9335_ANA_RX_BIAS_ENABLE		BIT(0)
> +#define WCD9335_ANA_RX_BIAS_DISABLE		0
> +#define WCD9335_ANA_HPH				WCD9335_REG(0x06, 0x009)
> +#define WCD9335_ANA_EAR				WCD9335_REG(0x06, 0x00a)
> +#define WCD9335_ANA_LO_1_2			WCD9335_REG(0x06, 0x00b)
> +#define WCD9335_ANA_LO_3_4			WCD9335_REG(0x06, 0x00c)
> +#define WCD9335_ANA_AMIC1			WCD9335_REG(0x06, 0x00e)
> +#define WCD9335_ANA_AMIC2			WCD9335_REG(0x06, 0x00f)
> +#define WCD9335_ANA_AMIC3			WCD9335_REG(0x06, 0x010)
> +#define WCD9335_ANA_AMIC4			WCD9335_REG(0x06, 0x011)
> +#define WCD9335_ANA_AMIC5			WCD9335_REG(0x06, 0x012)
> +#define WCD9335_ANA_AMIC6			WCD9335_REG(0x06, 0x013)
> +#define WCD9335_ANA_MBHC_MECH			WCD9335_REG(0x06, 0x014)
> +#define WCD9335_MBHC_L_DET_EN_MASK		BIT(7)
> +#define WCD9335_MBHC_L_DET_EN			BIT(7)
> +#define WCD9335_MBHC_GND_DET_EN_MASK		BIT(6)
> +#define WCD9335_MBHC_MECH_DETECT_TYPE_MASK	BIT(5)
> +#define WCD9335_MBHC_MECH_DETECT_TYPE_SHIFT	5
> +#define WCD9335_MBHC_HPHL_PLUG_TYPE_MASK	BIT(4)
> +#define WCD9335_MBHC_HPHL_PLUG_TYPE_NO		BIT(4)
> +#define WCD9335_MBHC_GND_PLUG_TYPE_MASK		BIT(3)
> +#define WCD9335_MBHC_GND_PLUG_TYPE_NO		BIT(3)
> +#define WCD9335_MBHC_HSL_PULLUP_COMP_EN		BIT(2)
> +#define WCD9335_MBHC_HPHL_100K_TO_GND_EN	BIT(0)
> +
> +#define WCD9335_ANA_MBHC_ELECT			WCD9335_REG(0x06, 0x015)
> +#define WCD9335_ANA_MBHC_BD_ISRC_CTL_MASK	GENMASK(6, 4)
> +#define WCD9335_ANA_MBHC_BD_ISRC_100UA		GENMASK(5, 4)
> +#define WCD9335_ANA_MBHC_BD_ISRC_OFF		0
> +#define WCD9335_ANA_MBHC_BIAS_EN_MASK		BIT(0)
> +#define WCD9335_ANA_MBHC_BIAS_EN		BIT(0)
> +#define WCD9335_ANA_MBHC_ZDET			WCD9335_REG(0x06, 0x016)
> +#define WCD9335_ANA_MBHC_RESULT_1		WCD9335_REG(0x06, 0x017)
> +#define WCD9335_ANA_MBHC_RESULT_2		WCD9335_REG(0x06, 0x018)
> +#define WCD9335_ANA_MBHC_RESULT_3		WCD9335_REG(0x06, 0x019)
> +#define WCD9335_MBHC_BTN_RESULT_MASK		GENMASK(2, 0)
> +#define WCD9335_ANA_MBHC_BTN0			WCD9335_REG(0x06, 0x01a)
> +#define WCD9335_ANA_MBHC_BTN1			WCD9335_REG(0x06, 0x01b)
> +#define WCD9335_ANA_MBHC_BTN2			WCD9335_REG(0x06, 0x01c)
> +#define WCD9335_ANA_MBHC_BTN3			WCD9335_REG(0x06, 0x01d)
> +#define WCD9335_ANA_MBHC_BTN4			WCD9335_REG(0x06, 0x01e)
> +#define WCD9335_ANA_MBHC_BTN5			WCD9335_REG(0x06, 0x01f)
> +#define WCD9335_ANA_MBHC_BTN6			WCD9335_REG(0x06, 0x020)
> +#define WCD9335_ANA_MBHC_BTN7			WCD9335_REG(0x06, 0x021)
> +#define WCD9335_ANA_MICB1			WCD9335_REG(0x06, 0x022)
> +#define WCD9335_ANA_MICB2			WCD9335_REG(0x06, 0x023)
> +#define WCD9335_ANA_MICB2_ENABLE		BIT(6)
> +#define WCD9335_ANA_MICB2_RAMP			WCD9335_REG(0x06, 0x024)
> +#define WCD9335_ANA_MICB3			WCD9335_REG(0x06, 0x025)
> +#define WCD9335_ANA_MICB4			WCD9335_REG(0x06, 0x026)
> +#define WCD9335_ANA_VBADC			WCD9335_REG(0x06, 0x027)
> +#define WCD9335_BIAS_VBG_FINE_ADJ		WCD9335_REG(0x06, 0x029)
> +#define WCD9335_RCO_CTRL_2			WCD9335_REG(0x06, 0x02f)
> +#define WCD9335_SIDO_SIDO_CCL_2			WCD9335_REG(0x06, 0x042)
> +#define WCD9335_SIDO_SIDO_CCL_4			WCD9335_REG(0x06, 0x044)
> +#define WCD9335_SIDO_SIDO_CCL_8			WCD9335_REG(0x06, 0x048)
> +#define WCD9335_SIDO_SIDO_CCL_10		WCD9335_REG(0x06, 0x04a)
> +#define WCD9335_SIDO_SIDO_CCL_10_ICHARG_PWR_SEL_C320FF		0x2
> +/* Comparator 1 and 2 Bias current at 1P0UA with start pulse width of C320FF */
> +#define WCD9335_SIDO_SIDO_CCL_DEF_VALUE		0x6e
> +#define WCD9335_SIDO_SIDO_TEST_2		WCD9335_REG(0x06, 0x055)
> +#define WCD9335_MBHC_CTL_1			WCD9335_REG(0x06, 0x056)
> +#define WCD9335_MBHC_BTN_DBNC_MASK		GENMASK(1, 0)
> +#define WCD9335_MBHC_BTN_DBNC_T_16_MS		0x2
> +#define WCD9335_MBHC_CTL_RCO_EN_MASK		BIT(7)
> +#define WCD9335_MBHC_CTL_RCO_EN			BIT(7)
> +
> +#define WCD9335_MBHC_CTL_2			WCD9335_REG(0x06, 0x057)
> +#define WCD9335_MBHC_HS_VREF_CTL_MASK		GENMASK(1, 0)
> +#define WCD9335_MBHC_HS_VREF_1P5_V		0x1
> +#define WCD9335_MBHC_PLUG_DETECT_CTL		WCD9335_REG(0x06, 0x058)
> +#define WCD9335_MBHC_HSDET_PULLUP_CTL_MASK	GENMASK(7, 6)
> +#define WCD9335_MBHC_HSDET_PULLUP_CTL_SHIFT	6
> +#define WCD9335_MBHC_HSDET_PULLUP_CTL_1_2P0_UA	0x80
> +#define WCD9335_MBHC_DBNC_TIMER_INSREM_DBNC_T_96_MS	0x6
> +
> +#define WCD9335_MBHC_ZDET_RAMP_CTL		WCD9335_REG(0x06, 0x05a)
> +#define WCD9335_VBADC_IBIAS_FE			WCD9335_REG(0x06, 0x05e)
> +#define WCD9335_FLYBACK_CTRL_1			WCD9335_REG(0x06, 0x0b1)
> +#define WCD9335_RX_BIAS_HPH_PA			WCD9335_REG(0x06, 0x0bb)
> +#define WCD9335_RX_BIAS_HPH_PA_AMP_5_UA_MASK	GENMASK(3, 0)
> +#define WCD9335_RX_BIAS_HPH_RDACBUFF_CNP2	WCD9335_REG(0x06, 0x0bc)
> +#define WCD9335_RX_BIAS_HPH_RDAC_LDO		WCD9335_REG(0x06, 0x0bd)
> +#define WCD9335_RX_BIAS_FLYB_BUFF		WCD9335_REG(0x06, 0x0c7)
> +#define WCD9335_RX_BIAS_FLYB_VPOS_5_UA_MASK	GENMASK(3, 0)
> +#define WCD9335_RX_BIAS_FLYB_I_0P0_UA		0
> +#define WCD9335_RX_BIAS_FLYB_VNEG_5_UA_MASK	GENMASK(7, 4)
> +#define WCD9335_RX_BIAS_FLYB_MID_RST		WCD9335_REG(0x06, 0x0c8)
> +#define WCD9335_HPH_CNP_WG_CTL			WCD9335_REG(0x06, 0x0cc)
> +#define WCD9335_HPH_CNP_WG_CTL_CURR_LDIV_MASK	GENMASK(2, 0)
> +#define WCD9335_HPH_CNP_WG_CTL_CURR_LDIV_RATIO_500 0x2
> +#define WCD9335_HPH_CNP_WG_CTL_CURR_LDIV_RATIO_1000 0x3
> +#define WCD9335_HPH_OCP_CTL			WCD9335_REG(0x06, 0x0ce)
> +#define WCD9335_HPH_AUTO_CHOP			WCD9335_REG(0x06, 0x0cf)
> +#define WCD9335_HPH_AUTO_CHOP_MASK		BIT(5)
> +#define WCD9335_HPH_AUTO_CHOP_FORCE_ENABLE		BIT(5)
> +#define WCD9335_HPH_AUTO_CHOP_ENABLE_BY_CMPDR_GAIN		0
> +#define WCD9335_HPH_PA_CTL1			WCD9335_REG(0x06, 0x0d1)
> +#define WCD9335_HPH_PA_GM3_IB_SCALE_MASK		GENMASK(3, 1)
> +#define WCD9335_HPH_PA_CTL2			WCD9335_REG(0x06, 0x0d2)
> +#define WCD9335_HPH_PA_CTL2_FORCE_PSRREH_MASK	BIT(2)
> +#define WCD9335_HPH_PA_CTL2_FORCE_PSRREH_ENABLE	BIT(2)
> +#define WCD9335_HPH_PA_CTL2_FORCE_PSRREH_DISABLE 0
> +#define WCD9335_HPH_PA_CTL2_FORCE_IQCTRL_MASK	BIT(3)
> +#define WCD9335_HPH_PA_CTL2_FORCE_IQCTRL_ENABLE	BIT(3)
> +#define WCD9335_HPH_PA_CTL2_FORCE_IQCTRL_DISABLE	0
> +#define WCD9335_HPH_PA_CTL2_HPH_PSRR_ENH_MASK	BIT(5)
> +#define WCD9335_HPH_PA_CTL2_HPH_PSRR_ENABLE	BIT(5)
> +#define WCD9335_HPH_PA_CTL2_HPH_PSRR_DISABLE	0
> +#define WCD9335_HPH_L_EN			WCD9335_REG(0x06, 0x0d3)
> +#define WCD9335_HPH_CONST_SEL_L_MASK		GENMASK(7, 6)
> +#define WCD9335_HPH_CONST_SEL_L_BYPASS		0
> +#define WCD9335_HPH_CONST_SEL_L_LP_PATH		0x40
> +#define WCD9335_HPH_CONST_SEL_L_HQ_PATH		0x80
> +#define WCD9335_HPH_PA_GAIN_MASK		GENMASK(4, 0)
> +#define WCD9335_HPH_GAIN_SRC_SEL_MASK		BIT(5)
> +#define WCD9335_HPH_GAIN_SRC_SEL_COMPANDER	0
> +#define WCD9335_HPH_GAIN_SRC_SEL_REGISTER	BIT(5)
> +#define WCD9335_HPH_L_TEST			WCD9335_REG(0x06, 0x0d4)
> +#define WCD9335_HPH_R_EN			WCD9335_REG(0x06, 0x0d6)
> +#define WCD9335_HPH_R_TEST			WCD9335_REG(0x06, 0x0d7)
> +#define WCD9335_HPH_R_ATEST			WCD9335_REG(0x06, 0x0d8)
> +#define WCD9335_HPH_RDAC_LDO_CTL		WCD9335_REG(0x06, 0x0db)
> +#define WCD9335_HPH_RDAC_N1P65_LD_OUTCTL_MASK	GENMASK(2, 0)
> +#define WCD9335_HPH_RDAC_N1P65_LD_OUTCTL_V_N1P60	0x1
> +#define WCD9335_HPH_RDAC_1P65_LD_OUTCTL_MASK	GENMASK(6, 4)
> +#define WCD9335_HPH_RDAC_1P65_LD_OUTCTL_V_N1P60	0x10
> +#define WCD9335_HPH_REFBUFF_LP_CTL		WCD9335_REG(0x06, 0x0de)
> +#define WCD9335_HPH_L_DAC_CTL			WCD9335_REG(0x06, 0x0df)
> +#define WCD9335_HPH_DAC_LDO_POWERMODE_MASK	BIT(0)
> +#define WCD9335_HPH_DAC_LDO_POWERMODE_LOWPOWER	0
> +#define WCD9335_HPH_DAC_LDO_POWERMODE_UHQA	BIT(0)
> +#define WCD9335_HPH_DAC_LDO_UHQA_OV_MASK	BIT(1)
> +#define WCD9335_HPH_DAC_LDO_UHQA_OV_ENABLE	BIT(1)
> +#define WCD9335_HPH_DAC_LDO_UHQA_OV_DISABLE	0
> +
> +#define WCD9335_EAR_CMBUFF			WCD9335_REG(0x06, 0x0e2)
> +#define WCD9335_DIFF_LO_LO2_COMPANDER		WCD9335_REG(0x06, 0x0ea)
> +#define WCD9335_DIFF_LO_LO1_COMPANDER		WCD9335_REG(0x06, 0x0eb)
> +#define WCD9335_DIFF_LO_COM_SWCAP_REFBUF_FREQ	WCD9335_REG(0x06, 0x0f1)
> +#define WCD9335_DIFF_LO_COM_PA_FREQ		WCD9335_REG(0x06, 0x0f2)
> +#define WCD9335_SE_LO_LO3_GAIN			WCD9335_REG(0x06, 0x0f8)
> +#define WCD9335_SE_LO_LO3_CTRL			WCD9335_REG(0x06, 0x0f9)
> +#define WCD9335_SE_LO_LO4_GAIN			WCD9335_REG(0x06, 0x0fa)
> +
> +/* Page-10 Registers */
> +#define WCD9335_CDC_TX0_TX_PATH_CTL		WCD9335_REG(0x0a, 0x031)
> +#define WCD9335_CDC_TX_PATH_CTL_PCM_RATE_MASK	GENMASK(3, 0)
> +#define WCD9335_CDC_TX_PATH_CTL(dec)	WCD9335_REG(0xa, (0x31 + dec * 0x10))
> +#define WCD9335_CDC_TX0_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x032)
> +#define WCD9335_CDC_TX_ADC_AMIC_DMIC_SEL_MASK	BIT(7)
> +#define WCD9335_CDC_TX_ADC_DMIC_SEL		BIT(7)
> +#define WCD9335_CDC_TX_ADC_AMIC_SEL		0
> +#define WCD9335_CDC_TX0_TX_VOL_CTL		WCD9335_REG(0x0a, 0x034)
> +#define WCD9335_CDC_TX0_TX_PATH_SEC2		WCD9335_REG(0x0a, 0x039)
> +#define WCD9335_CDC_TX0_TX_PATH_SEC7		WCD9335_REG(0x0a, 0x03e)
> +#define WCD9335_CDC_TX1_TX_PATH_CTL		WCD9335_REG(0x0a, 0x041)
> +#define WCD9335_CDC_TX1_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x042)
> +#define WCD9335_CDC_TX2_TX_PATH_CTL		WCD9335_REG(0x0a, 0x051)
> +#define WCD9335_CDC_TX2_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x052)
> +#define WCD9335_CDC_TX2_TX_VOL_CTL		WCD9335_REG(0x0a, 0x054)
> +#define WCD9335_CDC_TX3_TX_PATH_CTL		WCD9335_REG(0x0a, 0x061)
> +#define WCD9335_CDC_TX3_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x062)
> +#define WCD9335_CDC_TX3_TX_VOL_CTL		WCD9335_REG(0x0a, 0x064)
> +#define WCD9335_CDC_TX4_TX_PATH_CTL		WCD9335_REG(0x0a, 0x071)
> +#define WCD9335_CDC_TX4_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x072)
> +#define WCD9335_CDC_TX4_TX_VOL_CTL		WCD9335_REG(0x0a, 0x074)
> +#define WCD9335_CDC_TX5_TX_PATH_CTL		WCD9335_REG(0x0a, 0x081)
> +#define WCD9335_CDC_TX5_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x082)
> +#define WCD9335_CDC_TX5_TX_VOL_CTL		WCD9335_REG(0x0a, 0x084)
> +#define WCD9335_CDC_TX6_TX_PATH_CTL		WCD9335_REG(0x0a, 0x091)
> +#define WCD9335_CDC_TX6_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x092)
> +#define WCD9335_CDC_TX6_TX_VOL_CTL		WCD9335_REG(0x0a, 0x094)
> +#define WCD9335_CDC_TX7_TX_PATH_CTL		WCD9335_REG(0x0a, 0x0a1)
> +#define WCD9335_CDC_TX7_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x0a2)
> +#define WCD9335_CDC_TX7_TX_VOL_CTL		WCD9335_REG(0x0a, 0x0a4)
> +#define WCD9335_CDC_TX8_TX_PATH_CTL		WCD9335_REG(0x0a, 0x0b1)
> +#define WCD9335_CDC_TX8_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x0b2)
> +#define WCD9335_CDC_TX8_TX_VOL_CTL		WCD9335_REG(0x0a, 0x0b4)
> +#define WCD9335_CDC_TX9_SPKR_PROT_PATH_CFG0	WCD9335_REG(0x0a, 0x0c3)
> +#define WCD9335_CDC_TX10_SPKR_PROT_PATH_CFG0	WCD9335_REG(0x0a, 0x0c7)
> +#define WCD9335_CDC_TX11_SPKR_PROT_PATH_CFG0	WCD9335_REG(0x0a, 0x0cb)
> +#define WCD9335_CDC_TX12_SPKR_PROT_PATH_CFG0	WCD9335_REG(0x0a, 0x0cf)
> +
> +/* Page-11 Registers */
> +#define WCD9335_PAGE11_PAGE_REGISTER		WCD9335_REG(0x0b, 0x000)
> +#define WCD9335_CDC_COMPANDER1_CTL0		WCD9335_REG(0x0b, 0x001)
> +#define WCD9335_CDC_COMPANDER1_CTL(c)	WCD9335_REG(0x0b, (0x001 + c * 0x8))
> +#define WCD9335_CDC_COMPANDER_CLK_EN_MASK	BIT(0)
> +#define WCD9335_CDC_COMPANDER_CLK_ENABLE	BIT(0)
> +#define WCD9335_CDC_COMPANDER_CLK_DISABLE	0
> +#define WCD9335_CDC_COMPANDER_SOFT_RST_MASK	BIT(1)
> +#define WCD9335_CDC_COMPANDER_SOFT_RST_ENABLE	BIT(1)
> +#define WCD9335_CDC_COMPANDER_SOFT_RST_DISABLE	0
> +#define WCD9335_CDC_COMPANDER_HALT_MASK		BIT(2)
> +#define WCD9335_CDC_COMPANDER_HALT		BIT(2)
> +#define WCD9335_CDC_COMPANDER_NOHALT		0
> +#define WCD9335_CDC_COMPANDER7_CTL3		WCD9335_REG(0x0b, 0x034)
> +#define WCD9335_CDC_COMPANDER7_CTL7		WCD9335_REG(0x0b, 0x038)
> +#define WCD9335_CDC_COMPANDER8_CTL3		WCD9335_REG(0x0b, 0x03c)
> +#define WCD9335_CDC_COMPANDER8_CTL7		WCD9335_REG(0x0b, 0x040)
> +#define WCD9335_CDC_RX0_RX_PATH_CTL		WCD9335_REG(0x0b, 0x041)
> +#define WCD9335_CDC_RX_PGA_MUTE_EN_MASK		BIT(4)
> +#define WCD9335_CDC_RX_PGA_MUTE_ENABLE		BIT(4)
> +#define WCD9335_CDC_RX_PGA_MUTE_DISABLE		0
> +#define WCD9335_CDC_RX_CLK_EN_MASK		BIT(5)
> +#define WCD9335_CDC_RX_CLK_ENABLE		BIT(5)
> +#define WCD9335_CDC_RX_CLK_DISABLE		0
> +#define WCD9335_CDC_RX_RESET_MASK		BIT(6)
> +#define WCD9335_CDC_RX_RESET_ENABLE		BIT(6)
> +#define WCD9335_CDC_RX_RESET_DISABLE		0
> +#define WCD9335_CDC_RX_PATH_CTL(rx)	WCD9335_REG(0x0b, (0x041 + rx * 0x14))
> +#define WCD9335_CDC_RX0_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x042)
> +#define WCD9335_CDC_RX0_RX_PATH_CFG1		WCD9335_REG(0x0b, 0x043)
> +#define WCD9335_CDC_RX0_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x044)
> +#define WCD9335_CDC_RX0_RX_VOL_CTL		WCD9335_REG(0x0b, 0x045)
> +#define WCD9335_CDC_RX0_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x046)
> +#define WCD9335_CDC_MIX_PCM_RATE_MASK		GENMASK(3, 0)
> +#define WCD9335_CDC_RX_PATH_MIX_CTL(rx)	WCD9335_REG(0x0b, (0x46 + rx * 0x14))
> +#define WCD9335_CDC_RX0_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x047)
> +#define WCD9335_CDC_RX0_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x048)
> +#define WCD9335_CDC_RX0_RX_PATH_SEC0		WCD9335_REG(0x0b, 0x049)
> +#define WCD9335_CDC_RX0_RX_PATH_SEC7		WCD9335_REG(0x0b, 0x050)
> +#define WCD9335_CDC_RX0_RX_PATH_MIX_SEC0	WCD9335_REG(0x0b, 0x051)
> +#define WCD9335_CDC_RX1_RX_PATH_CTL		WCD9335_REG(0x0b, 0x055)
> +#define WCD9335_CDC_RX1_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x056)
> +#define WCD9335_CDC_RX1_RX_PATH_CFG(c)	WCD9335_REG(0x0b, (0x056 + c * 0x14))
> +#define WCD9335_CDC_RX_PATH_CFG_CMP_EN_MASK	BIT(1)
> +#define WCD9335_CDC_RX_PATH_CFG_CMP_ENABLE	BIT(1)
> +#define WCD9335_CDC_RX_PATH_CFG_CMP_DISABLE	0
> +#define WCD9335_CDC_RX_PATH_CFG_HD2_EN_MASK	BIT(2)
> +#define WCD9335_CDC_RX_PATH_CFG_HD2_ENABLE	BIT(2)
> +#define WCD9335_CDC_RX_PATH_CFG_HD2_DISABLE	0
> +#define WCD9335_CDC_RX_PATH_CFG0_DLY_ZN_EN_MASK	BIT(3)
> +#define WCD9335_CDC_RX_PATH_CFG0_DLY_ZN_EN	BIT(3)
> +#define WCD9335_CDC_RX_PATH_CFG0_DLY_ZN_DISABLE	0
> +#define WCD9335_CDC_RX1_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x058)
> +#define WCD9335_CDC_RX1_RX_VOL_CTL		WCD9335_REG(0x0b, 0x059)
> +#define WCD9335_CDC_RX1_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x05a)
> +#define WCD9335_CDC_RX1_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x05b)
> +#define WCD9335_CDC_RX1_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x05c)
> +#define WCD9335_CDC_RX1_RX_PATH_SEC0		WCD9335_REG(0x0b, 0x05d)
> +#define WCD9335_CDC_RX1_RX_PATH_SEC3		WCD9335_REG(0x0b, 0x060)
> +#define WCD9335_CDC_RX_PATH_SEC_HD2_SCALE_MASK	GENMASK(1, 0)
> +#define WCD9335_CDC_RX_PATH_SEC_HD2_SCALE_2	0x1
> +#define WCD9335_CDC_RX_PATH_SEC_HD2_SCALE_1	0
> +#define WCD9335_CDC_RX_PATH_SEC_HD2_ALPHA_MASK	GENMASK(5, 2)
> +#define WCD9335_CDC_RX_PATH_SEC_HD2_ALPHA_0P2500	0x10
> +#define WCD9335_CDC_RX_PATH_SEC_HD2_ALPHA_0P0000	0
> +#define WCD9335_CDC_RX2_RX_PATH_CTL		WCD9335_REG(0x0b, 0x069)
> +#define WCD9335_CDC_RX2_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x06a)
> +#define WCD9335_CDC_RX2_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x06c)
> +#define WCD9335_CDC_RX2_RX_VOL_CTL		WCD9335_REG(0x0b, 0x06d)
> +#define WCD9335_CDC_RX2_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x06e)
> +#define WCD9335_CDC_RX2_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x06f)
> +#define WCD9335_CDC_RX2_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x070)
> +#define WCD9335_CDC_RX2_RX_PATH_SEC0		WCD9335_REG(0x0b, 0x071)
> +#define WCD9335_CDC_RX_PATH_DEM_INP_SEL_MASK	GENMASK(1, 0)
> +#define WCD9335_CDC_RX2_RX_PATH_SEC3		WCD9335_REG(0x0b, 0x074)
> +#define WCD9335_CDC_RX3_RX_PATH_CTL		WCD9335_REG(0x0b, 0x07d)
> +#define WCD9335_CDC_RX3_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x07e)
> +#define WCD9335_CDC_RX3_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x080)
> +#define WCD9335_CDC_RX3_RX_VOL_CTL		WCD9335_REG(0x0b, 0x081)
> +#define WCD9335_CDC_RX3_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x082)
> +#define WCD9335_CDC_RX3_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x083)
> +#define WCD9335_CDC_RX3_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x084)
> +#define WCD9335_CDC_RX4_RX_PATH_CTL		WCD9335_REG(0x0b, 0x091)
> +#define WCD9335_CDC_RX4_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x092)
> +#define WCD9335_CDC_RX4_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x094)
> +#define WCD9335_CDC_RX4_RX_VOL_CTL		WCD9335_REG(0x0b, 0x095)
> +#define WCD9335_CDC_RX4_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x096)
> +#define WCD9335_CDC_RX4_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x097)
> +#define WCD9335_CDC_RX4_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x098)
> +#define WCD9335_CDC_RX5_RX_PATH_CTL		WCD9335_REG(0x0b, 0x0a5)
> +#define WCD9335_CDC_RX5_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x0a6)
> +#define WCD9335_CDC_RX5_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x0a8)
> +#define WCD9335_CDC_RX5_RX_VOL_CTL		WCD9335_REG(0x0b, 0x0a9)
> +#define WCD9335_CDC_RX5_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x0aa)
> +#define WCD9335_CDC_RX5_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x0ab)
> +#define WCD9335_CDC_RX5_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x0ac)
> +#define WCD9335_CDC_RX6_RX_PATH_CTL		WCD9335_REG(0x0b, 0x0b9)
> +#define WCD9335_CDC_RX6_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x0ba)
> +#define WCD9335_CDC_RX6_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x0bc)
> +#define WCD9335_CDC_RX6_RX_VOL_CTL		WCD9335_REG(0x0b, 0x0bd)
> +#define WCD9335_CDC_RX6_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x0be)
> +#define WCD9335_CDC_RX6_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x0bf)
> +#define WCD9335_CDC_RX6_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x0c0)
> +#define WCD9335_CDC_RX7_RX_PATH_CTL		WCD9335_REG(0x0b, 0x0cd)
> +#define WCD9335_CDC_RX7_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x0ce)
> +#define WCD9335_CDC_RX7_RX_PATH_CFG1		WCD9335_REG(0x0b, 0x0cf)
> +#define WCD9335_CDC_RX7_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x0d0)
> +#define WCD9335_CDC_RX7_RX_VOL_CTL		WCD9335_REG(0x0b, 0x0d1)
> +#define WCD9335_CDC_RX7_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x0d2)
> +#define WCD9335_CDC_RX7_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x0d3)
> +#define WCD9335_CDC_RX7_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x0d4)
> +#define WCD9335_CDC_RX8_RX_PATH_CTL		WCD9335_REG(0x0b, 0x0e1)
> +#define WCD9335_CDC_RX8_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x0e2)
> +#define WCD9335_CDC_RX8_RX_PATH_CFG1		WCD9335_REG(0x0b, 0x0e3)
> +#define WCD9335_CDC_RX8_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x0e4)
> +#define WCD9335_CDC_RX8_RX_VOL_CTL		WCD9335_REG(0x0b, 0x0e5)
> +#define WCD9335_CDC_RX8_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x0e6)
> +#define WCD9335_CDC_RX8_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x0e7)
> +#define WCD9335_CDC_RX8_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x0e8)
> +
> +/* Page-12 Registers */
> +#define WCD9335_PAGE12_PAGE_REGISTER		WCD9335_REG(0x0c, 0x000)
> +#define WCD9335_CDC_CLSH_K2_MSB			WCD9335_REG(0x0c, 0x00a)
> +#define WCD9335_CDC_CLSH_K2_LSB			WCD9335_REG(0x0c, 0x00b)
> +#define WCD9335_CDC_BOOST0_BOOST_CTL		WCD9335_REG(0x0c, 0x01a)
> +#define WCD9335_CDC_BOOST0_BOOST_CFG1		WCD9335_REG(0x0c, 0x01b)
> +#define WCD9335_CDC_BOOST0_BOOST_CFG2		WCD9335_REG(0x0c, 0x01c)
> +#define WCD9335_CDC_BOOST1_BOOST_CTL		WCD9335_REG(0x0c, 0x022)
> +#define WCD9335_CDC_BOOST1_BOOST_CFG1		WCD9335_REG(0x0c, 0x023)
> +#define WCD9335_CDC_BOOST1_BOOST_CFG2		WCD9335_REG(0x0c, 0x024)
> +
> +/* Page-13 Registers */
> +#define WCD9335_PAGE13_PAGE_REGISTER		WCD9335_REG(0x0d, 0x000)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT0_CFG0	WCD9335_REG(0x0d, 0x001)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT_CFG0(i) WCD9335_REG(0xd, (0x1 + i * 0x2))
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT0_CFG1	WCD9335_REG(0xd, 0x002)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT_SEL_MASK	GENMASK(3, 0)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT_CFG1(i) WCD9335_REG(0xd, (0x2 + i * 0x2))
> +
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT1_CFG0	WCD9335_REG(0x0d, 0x003)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT1_CFG1	WCD9335_REG(0x0d, 0x004)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT2_CFG0	WCD9335_REG(0x0d, 0x005)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT2_CFG1	WCD9335_REG(0x0d, 0x006)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT3_CFG0	WCD9335_REG(0x0d, 0x007)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT3_CFG1	WCD9335_REG(0x0d, 0x008)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT4_CFG0	WCD9335_REG(0x0d, 0x009)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT4_CFG1	WCD9335_REG(0x0d, 0x00a)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT5_CFG0	WCD9335_REG(0x0d, 0x00b)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT5_CFG1	WCD9335_REG(0x0d, 0x00c)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT6_CFG0	WCD9335_REG(0x0d, 0x00d)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT6_CFG1	WCD9335_REG(0x0d, 0x00e)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT7_CFG0	WCD9335_REG(0x0d, 0x00f)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT7_CFG1	WCD9335_REG(0x0d, 0x010)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT8_CFG0	WCD9335_REG(0x0d, 0x011)
> +#define WCD9335_CDC_RX_INP_MUX_RX_INT8_CFG1	WCD9335_REG(0x0d, 0x012)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX0_CFG0	WCD9335_REG(0x0d, 0x01d)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX0_CFG1	WCD9335_REG(0x0d, 0x01e)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX1_CFG0	WCD9335_REG(0x0d, 0x01f)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX1_CFG1	WCD9335_REG(0x0d, 0x020)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX2_CFG0	WCD9335_REG(0x0d, 0x021)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX2_CFG1	WCD9335_REG(0x0d, 0x022)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX3_CFG0	WCD9335_REG(0x0d, 0x023)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX3_CFG1	WCD9335_REG(0x0d, 0x024)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX4_CFG0	WCD9335_REG(0x0d, 0x025)
> +#define WCD9335_CDC_TX_INP_MUX_SEL_AMIC	0x1
> +#define WCD9335_CDC_TX_INP_MUX_SEL_DMIC	0
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX5_CFG0	WCD9335_REG(0x0d, 0x026)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX6_CFG0	WCD9335_REG(0x0d, 0x027)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX7_CFG0	WCD9335_REG(0x0d, 0x028)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX8_CFG0	WCD9335_REG(0x0d, 0x029)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX10_CFG0	WCD9335_REG(0x0d, 0x02b)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX11_CFG0	WCD9335_REG(0x0d, 0x02c)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX12_CFG0	WCD9335_REG(0x0d, 0x02d)
> +#define WCD9335_CDC_TX_INP_MUX_ADC_MUX13_CFG0	WCD9335_REG(0x0d, 0x02e)
> +#define WCD9335_CDC_IF_ROUTER_TX_MUX_CFG0	WCD9335_REG(0x0d, 0x03a)
> +#define WCD9335_CDC_IF_ROUTER_TX_MUX_CFG1	WCD9335_REG(0x0d, 0x03b)
> +#define WCD9335_CDC_IF_ROUTER_TX_MUX_CFG2	WCD9335_REG(0x0d, 0x03c)
> +#define WCD9335_CDC_IF_ROUTER_TX_MUX_CFG3	WCD9335_REG(0x0d, 0x03d)
> +#define WCD9335_CDC_CLK_RST_CTRL_MCLK_CONTROL	WCD9335_REG(0x0d, 0x041)
> +#define WCD9335_CDC_CLK_RST_CTRL_MCLK_EN_MASK	BIT(0)
> +#define WCD9335_CDC_CLK_RST_CTRL_MCLK_ENABLE	BIT(0)
> +#define WCD9335_CDC_CLK_RST_CTRL_MCLK_DISABLE	0
> +#define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_CONTROL	WCD9335_REG(0x0d, 0x042)
> +#define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_EN_MASK	BIT(0)
> +#define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_ENABLE	BIT(0)
> +#define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_DISABLE	0
> +#define WCD9335_CDC_TOP_TOP_CFG1	WCD9335_REG(0x0d, 0x082)
> +#define WCD9335_MAX_REGISTER	WCD9335_REG(0x80, 0x0FF)
> +
> +/* SLIMBUS Slave Registers */
> +#define WCD9335_SLIM_PGD_PORT_INT_EN0	WCD9335_REG(0, 0x30)
> +#define WCD9335_SLIM_PGD_PORT_INT_STATUS_RX_0	WCD9335_REG(0, 0x34)
> +#define WCD9335_SLIM_PGD_PORT_INT_STATUS_RX_1	WCD9335_REG(0, 0x35)
> +#define WCD9335_SLIM_PGD_PORT_INT_STATUS_TX_0	WCD9335_REG(0, 0x36)
> +#define WCD9335_SLIM_PGD_PORT_INT_STATUS_TX_1	WCD9335_REG(0, 0x37)
> +#define WCD9335_SLIM_PGD_PORT_INT_CLR_RX_0	WCD9335_REG(0, 0x38)
> +#define WCD9335_SLIM_PGD_PORT_INT_CLR_RX_1	WCD9335_REG(0, 0x39)
> +#define WCD9335_SLIM_PGD_PORT_INT_CLR_TX_0	WCD9335_REG(0, 0x3A)
> +#define WCD9335_SLIM_PGD_PORT_INT_CLR_TX_1	WCD9335_REG(0, 0x3B)
> +#define WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0	WCD9335_REG(0, 0x60)
> +#define WCD9335_SLIM_PGD_PORT_INT_TX_SOURCE0	WCD9335_REG(0, 0x70)
> +#define WCD9335_SLIM_PGD_RX_PORT_CFG(p)	WCD9335_REG(0, (0x30 + p))
> +#define WCD9335_SLIM_PGD_PORT_CFG(p)	WCD9335_REG(0, (0x40 + p))
> +#define WCD9335_SLIM_PGD_TX_PORT_CFG(p)	WCD9335_REG(0, (0x50 + p))
> +#define WCD9335_SLIM_PGD_PORT_INT_SRC(p)	WCD9335_REG(0, (0x60 + p))
> +#define WCD9335_SLIM_PGD_PORT_INT_STATUS(p)	WCD9335_REG(0, (0x80 + p))
> +#define WCD9335_SLIM_PGD_TX_PORT_MULTI_CHNL_0(p) WCD9335_REG(0, (0x100 + 4 * p))
> +/* ports range from 10-16 */
> +#define WCD9335_SLIM_PGD_TX_PORT_MULTI_CHNL_1(p) WCD9335_REG(0, (0x101 + 4 * p))
> +#define WCD9335_SLIM_PGD_RX_PORT_MULTI_CHNL_0(p) WCD9335_REG(0, (0x140 + 4 * p))
> +
> +#endif
> diff --git a/include/linux/mfd/wcd9335/wcd9335.h b/include/linux/mfd/wcd9335/wcd9335.h
> new file mode 100644
> index 000000000000..b16d730aa1a4
> --- /dev/null
> +++ b/include/linux/mfd/wcd9335/wcd9335.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __WCD9335_H__
> +#define __WCD9335_H__
> +
> +#include <linux/slimbus.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define WCD9335_VERSION_2_0     2
> +#define WCD9335_MAX_SUPPLY	5
> +
> +enum wcd_interface_type {
> +	WCD9335_INTERFACE_TYPE_SLIMBUS = 1,
> +	WCD9335_INTERFACE_TYPE_I2C,
> +};
> +
> +struct wcd9335 {
> +	int version;
> +	int intr1;

What's this?  If I have to ask, it's probably not a good name.

> +	int reset_gpio;
> +	enum wcd_interface_type intf_type;
> +	struct device *dev;
> +	struct clk *mclk;
> +	struct clk *native_clk;
> +	struct slim_device *slim;
> +	struct slim_device *slim_ifc_dev;
> +	struct regmap *regmap;
> +	struct regmap *ifc_dev_regmap;
> +	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
> +};

Also, please consider using Kerneldoc format header.

> +#endif /* __WCD9335_H__ */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
