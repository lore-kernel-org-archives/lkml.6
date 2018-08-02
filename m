Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98834C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAD52146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUa+V5xD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAD52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeHBKYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:24:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33895 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeHBKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:24:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so1246569wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D1MkkXTobbJ3lPnTe+VJSM40AOuALeT0/zUQ4zNp6W0=;
        b=IUa+V5xDhnaNBSux9Qs5WwkQTvbV59UKH/0BmSFkeiwkY885sUcMj5fwWYjo2vYqwt
         q8t9nY4OLWC7dgvnKS2q7s/cOApPHSrUncuXI7K6AnvfIB+EY1ARSRzPVMK5wfAszj7d
         6t67DXnSW30B7V0EPn3ko0yERn3dY21MmxBS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D1MkkXTobbJ3lPnTe+VJSM40AOuALeT0/zUQ4zNp6W0=;
        b=tospisWRL9nXjTvtH3fO91/k01e6S1t2B5tWhUn4mOKGNSlaL+XqJHePWxJKtZhiT7
         8arLrJhGfh1wDHD5m6NcXI8Wqrhu0NH0Q3BpwXyprgaUclCVug1zlNrRNVsi90oAvLYI
         NfESu5E+z4NPQdrsHucJ/rPNPGmpDB9lYaEz5oXd0BGX03j9hW4wbwgnmkobRlkwqOOh
         fg0QdGwFXoJhrALCAzQlHWjgnj8OIwnQ9xxRmVFFl5kBjDCBpEo74WEJi2OYqfbFsgqX
         WINU7OLGCBXGSs5itMfB4UM4tsACoebcCsq/Pr9NYjiKo0LelW+BjZZNXjR3M3hb/MBU
         katA==
X-Gm-Message-State: AOUpUlGRaN0Wqi/slK++9YlAMDq41kyg7XgRqR3brwTn6EVIVYorg0lT
        bt4b7pbCF2NMRyWb2pCKAXAePg==
X-Google-Smtp-Source: AAOMgpezqNrZpHip3VLdmBNjLUYm0x9tlMQICN3fW50rmlnDs1ruv+vJHNNkQUe/mu9eJYSVQUwMeQ==
X-Received: by 2002:adf:9366:: with SMTP id 93-v6mr1281888wro.60.1533198833733;
        Thu, 02 Aug 2018 01:33:53 -0700 (PDT)
Received: from dell ([95.149.160.4])
        by smtp.gmail.com with ESMTPSA id 68-v6sm2154077wmi.31.2018.08.02.01.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 01:33:52 -0700 (PDT)
Date:   Thu, 2 Aug 2018 09:33:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core
Message-ID: <20180802083351.GN4662@dell>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180727121806.18209-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018, Srinivas Kandagatla wrote:

> Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
> It has mulitple blocks like Soundwire controller, codec,
> Codec processing engine, ClassH controller, interrupt mux.
> It supports both I2S/I2C and SLIMbus audio interfaces.
> 
> This patch adds support to SLIMbus audio interface.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/mfd/Kconfig                   |  18 ++
>  drivers/mfd/Makefile                  |   4 +
>  drivers/mfd/wcd9335-core.c            | 268 ++++++++++++++++
>  include/linux/mfd/wcd9335/registers.h | 580 ++++++++++++++++++++++++++++++++++
>  include/linux/mfd/wcd9335/wcd9335.h   |  42 +++
>  5 files changed, 912 insertions(+)
>  create mode 100644 drivers/mfd/wcd9335-core.c
>  create mode 100644 include/linux/mfd/wcd9335/registers.h
>  create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f3fa516011ec..6e5b5f3cfe20 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1807,6 +1807,24 @@ config MFD_WM97xx
>  	  support for the WM97xx, in order to use the actual functionaltiy of
>  	  the device other drivers must be enabled.
>  
> +config MFD_WCD9335
> +	tristate
> +	select MFD_CORE
> +	select REGMAP
> +	select REGMAP_IRQ
> +
> +config MFD_WCD9335_SLIM
> +	tristate "Qualcomm WCD9335 with SLIMbus"
> +	select MFD_WCD9335
> +	select REGMAP_SLIMBUS
> +	depends on SLIMBUS
> +	help
> +	The WCD9335 is a standalone Hi-Fi audio codec IC, supports

s/codec/CODEC/

> +	Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
> +	the MSM8996, MSM8976, and MSM8956 chipsets. It has inbuild

s/inbuild/in-built/

> +	Soundwire controller, interrupt mux. It supports both I2S/I2C and
> +	SLIMbus audio interfaces. This option selects SLIMbus audio interface.

The help should be indented.

>  config MFD_STW481X
>  	tristate "Support for ST Microelectronics STw481x"
>  	depends on I2C && (ARCH_NOMADIK || COMPILE_TEST)
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 2852a6042ecf..a4697370640b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -56,6 +56,10 @@ endif
>  ifeq ($(CONFIG_MFD_CS47L24),y)
>  obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
>  endif
> +
> +obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
> +wcd9335-objs			:= wcd9335-core.o
> +
>  obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
>  wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
>  wm831x-objs			+= wm831x-auxadc.o
> diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
> new file mode 100644
> index 000000000000..8f746901f4e9
> --- /dev/null
> +++ b/drivers/mfd/wcd9335-core.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slimbus.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/clk.h>
> +#include <linux/gpio.h>
> +#include <linux/mfd/core.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/mfd/wcd9335/wcd9335.h>
> +#include <linux/mfd/wcd9335/registers.h>

Alphabetical.

> +static const struct regmap_range_cfg wcd9335_ranges[] = {
> +	{	.name = "WCD9335",

What is that?  New line please.

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
> +static struct regmap_config wcd9335_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,
> +	.max_register = WCD9335_MAX_REGISTER,
> +	.can_multi_write = true,
> +	.ranges = wcd9335_ranges,
> +	.num_ranges = ARRAY_SIZE(wcd9335_ranges),
> +};
> +
> +static const struct regmap_range_cfg wcd9335_ifd_ranges[] = {
> +	{	.name = "WCD9335-IFD",

As above.

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
> +static struct regmap_config wcd9335_ifd_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.can_multi_write = true,
> +	.max_register = WCD9335_REG(0, 0x7FF),
> +	.ranges = wcd9335_ifd_ranges,
> +	.num_ranges = ARRAY_SIZE(wcd9335_ifd_ranges),
> +};
> +
> +static int wcd9335_parse_dt(struct wcd9335 *wcd)
> +{
> +	struct device *dev = wcd->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	wcd->reset_gpio = of_get_named_gpio(np,	"reset-gpio", 0);
> +	if (wcd->reset_gpio < 0) {
> +		dev_err(dev, "Reset gpio missing in DT\n");

s/gpio/GPIO/

s/missing in DT/missing from DT/

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
> +		dev_err(dev, "slimbus clk not found\n");

Any reason for abbreviating 'clock' in the error message?

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
> +	if (ret != 0) {

"if (ret)"

Same for all.  I won't comment on the others.

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
> +	if (ret != 0) {
> +		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * For WCD9335, it takes about 600us for the Vout_A and
> +	 * Vout_D to be ready after BUCK_SIDO is powered up.
> +	 * SYS_RST_N shouldn't be pulled high during this time
> +	 */
> +	usleep_range(600, 650);
> +
> +	gpio_direction_output(wcd->reset_gpio, 0);
> +	msleep(20);

What's this for?  Why can't you just:

  gpio_direction_output(wcd->reset_gpio, 1);

... and drop the next 2 lines?

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
> +	int ret = 0;
> +
> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_EFUSE_VAL_OUT0, &val);
> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_CHIP_ID_BYTE0, &byte0);
> +
> +	if ((val < 0) || (byte0 < 0)) {
> +		dev_err(wcd->dev, "wcd9335 codec version detection fail!\n");

s/wcd9335 codec/WCD9335 CODEC/ ?

> +		return -EINVAL;
> +	}
> +
> +	if (byte0 == 0x1) {
> +		dev_info(wcd->dev, "wcd9335 codec version is v2.0\n");
> +		wcd->version = WCD9335_VERSION_2_0;
> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x01);
> +		regmap_write(rm, WCD9335_SIDO_SIDO_TEST_2, 0x00);
> +		regmap_write(rm, WCD9335_SIDO_SIDO_CCL_8, 0x6F);
> +		regmap_write(rm, WCD9335_BIAS_VBG_FINE_ADJ, 0x65);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x5);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x7);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x3);
> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x3);
> +	} else {
> +		dev_err(wcd->dev, "wcd9335 codec version not supported\n");

As above.

> +		ret = -EINVAL;

Why not just

  return -EINVAL;

Then you can just return 0 and avoid pre-initialising ret.

> +	}
> +
> +	return ret;
> +}
> +
> +static int wcd9335_slim_probe(struct slim_device *slim)
> +{
> +	struct device *dev = &slim->dev;
> +	struct wcd9335 *wcd;
> +	int ret = 0;

Why pre-initialise?

> +	/* Interface device */
> +	if (slim->e_addr.dev_index == 0)

Is 0 the parent?  I think 0 needs defining for clarity.

> +		return 0;
> +
> +	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
> +	if (!wcd)
> +		return	-ENOMEM;
> +
> +	wcd->dev = dev;

'\n' here.

> +	ret = wcd9335_parse_dt(wcd);
> +	if (ret) {
> +		dev_err(dev, "Error parsing DT (%d)\n", ret);

This format changes from message to message.

Please pick one and stick with it.

I personally like: "<MESSAGE>: %d", ret

> +		return ret;
> +	}
> +
> +	ret = wcd9335_power_on_reset(wcd);
> +	if (ret) {
> +		dev_err(dev, "Error Powering\n");

I think this is superflouous since you already printed a message.

> +		return ret;
> +	}
> +
> +	wcd->regmap = regmap_init_slimbus(slim, &wcd9335_regmap_config);
> +	if (IS_ERR(wcd->regmap)) {
> +		ret = PTR_ERR(wcd->regmap);
> +		dev_err(dev, "Failed to allocate register map:%d\n", ret);

A different format again.  Ensure there is a ' ' after the ':'.

> +		return ret;
> +	}
> +
> +	dev_set_drvdata(dev, wcd);

Probably nicer to do this at the very end - after a '\n'.

> +	wcd->slim = slim;
> +	wcd->intf_type = WCD9335_INTERFACE_TYPE_SLIMBUS;
> +
> +	return 0;
> +}
> +
> +static const struct mfd_cell wcd9335_devices[] = {
> +	{
> +		.name = "wcd9335-codec",
> +	},
> +};

When are you going to add the other devices?

By the way, one line entries should be placed on one line.

> +	{ .name = "wcd9335-codec" },

> +static int wcd9335_slim_status(struct slim_device *sdev,
> +				 enum slim_device_status s)

's' is not a good variable name.  Suggest 'status'.

> +{
> +	struct device_node *ifd_np;

What's 'ifd'?

> +	struct wcd9335 *wcd;
> +	struct device *dev;
> +	int ret;
> +
> +	/* Interface device */

As previously suggested just define the device ID and drop the
comment.

> +	if (sdev->e_addr.dev_index == 0)
> +		return 0;
> +
> +	wcd = dev_get_drvdata(&sdev->dev);
> +	dev = wcd->dev;

Odd.  You do to the effort of assigning this and use 'wcd->dev' at
most call sites anyway.  I'd drop 'dev' and just use it from 'wcd'
everywhere.

> +	ifd_np = of_parse_phandle(wcd->dev->of_node, "qcom,ifd", 0);
> +	if (!ifd_np) {
> +		dev_err(wcd->dev, "No Interface device found\n");
> +		return -EINVAL;
> +	}
> +
> +	wcd->slim_ifd = of_slim_get_device(sdev->ctrl, ifd_np);
> +	if (!wcd->slim_ifd) {
> +		dev_err(wcd->dev, "Unable to get SLIM Interface device\n");
> +		return -EINVAL;
> +	}
> +
> +	wcd->ifd_regmap = regmap_init_slimbus(wcd->slim_ifd,
> +					      &wcd9335_ifd_regmap_config);
> +	if (IS_ERR(wcd->ifd_regmap)) {
> +		dev_err(dev, "Failed to allocate register map\n");
> +		return PTR_ERR(wcd->ifd_regmap);
> +	}
> +
> +	ret = wcd9335_bring_up(wcd);
> +	if (ret) {
> +		dev_err(dev, "Failed to bringup WCD9335\n");
> +		return ret;
> +	}
> +
> +	wcd->slim_ifd = wcd->slim_ifd;

Am I missing something?

> +	return mfd_add_devices(wcd->dev, 0, wcd9335_devices,
> +			       ARRAY_SIZE(wcd9335_devices), NULL, 0, NULL);

No error message if it were to fail?

> +}
> +
> +static const struct slim_device_id wcd9335_slim_id[] = {
> +	{0x217, 0x1a0, 0x1, 0x0},

Well that's just horrific.  Can't these be defined?

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

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
