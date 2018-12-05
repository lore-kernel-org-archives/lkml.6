Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE15C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332D52081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332D52081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeLENgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:36:48 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:54247 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLENgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:36:47 -0500
Received: from [78.40.148.180] (helo=[0.0.0.0])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gUXLz-0001Ek-5q; Wed, 05 Dec 2018 13:36:39 +0000
Subject: Re: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ccaione@baylibre.com
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk>
Date:   Wed, 5 Dec 2018 13:36:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 22:08, Martin Blumenstingl wrote:
> Add support for the RTC block on the 32-bit Amlogic Meson6, Meson8,
> Meson8b and Meson8m2 SoCs.
> 
> The RTC is split in to two parts, which are both managed by this driver:
> - the AHB front end
> - and a simple serial connection to the actual registers
> 
> The RTC_COUNTER register which holds the time is 32-bits wide.
> 
> There are four 32-bit wide (in total: 16 bytes) "regmem" registers which
> are exposed using nvmem. On Amlogic's 3.10 kernel this is used to store
> data which needs to survive a suspend / resume cycle.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [resurrected Ben's patches after 2 years]
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Just checking if the change of author is deliberate?
not sure how to do >1 author on patches like this.

> ---
>   drivers/rtc/Kconfig     |  11 ++
>   drivers/rtc/Makefile    |   1 +
>   drivers/rtc/rtc-meson.c | 409 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 421 insertions(+)
>   create mode 100644 drivers/rtc/rtc-meson.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index a819ef07b7ec..d5d0e3affdc6 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1285,6 +1285,17 @@ config RTC_DRV_IMXDI
>   	   This driver can also be built as a module, if so, the module
>   	   will be called "rtc-imxdi".
>   
> +config RTC_DRV_MESON
> +	tristate "Amlogic Meson RTC"
> +	depends on (ARM && ARCH_MESON) || COMPILE_TEST
> +	select REGMAP_MMIO
> +	help
> +	   Support for the RTC block on the Amlogic Meson6, Meson8, Meson8b
> +	   and Meson8m2 SoCs.
> +
> +	   This driver can also be built as a module, if so, the module
> +	   will be called "rtc-meson".
> +
>   config RTC_DRV_OMAP
>   	tristate "TI OMAP Real Time Clock"
>   	depends on ARCH_OMAP || ARCH_DAVINCI || COMPILE_TEST
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 290c1730fb0a..3b088e75149d 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_RTC_DRV_MAX8997)	+= rtc-max8997.o
>   obj-$(CONFIG_RTC_DRV_MAX8998)	+= rtc-max8998.o
>   obj-$(CONFIG_RTC_DRV_MC13XXX)	+= rtc-mc13xxx.o
>   obj-$(CONFIG_RTC_DRV_MCP795)	+= rtc-mcp795.o
> +obj-$(CONFIG_RTC_DRV_MESON)	+= rtc-meson.o
>   obj-$(CONFIG_RTC_DRV_MOXART)	+= rtc-moxart.o
>   obj-$(CONFIG_RTC_DRV_MPC5121)	+= rtc-mpc5121.o
>   obj-$(CONFIG_RTC_DRV_MSM6242)	+= rtc-msm6242.o
> diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
> new file mode 100644
> index 000000000000..09d6849b804a
> --- /dev/null
> +++ b/drivers/rtc/rtc-meson.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RTC driver for the interal RTC block in the Amlogic Meson6, Meson8,
> + * Meson8b and Meson8m2 SoCs.
> + *
> + * The RTC is split in to two parts, the AHB front end and a simple serial
> + * connection to the actual registers. This driver manages both parts.
> + *
> + * Copyright (c) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + * Copyright (c) 2015 Ben Dooks <ben.dooks@codethink.co.uk> for Codethink Ltd
> + * Based on origin by Carlo Caione <carlo@endlessm.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/rtc.h>
> +
> +/* registers accessed from cpu bus */
> +#define RTC_ADDR0				0x00
> +	#define RTC_ADDR0_LINE_SCLK		BIT(0)
> +	#define RTC_ADDR0_LINE_SEN		BIT(1)
> +	#define RTC_ADDR0_LINE_SDI		BIT(2)
> +	#define RTC_ADDR0_START_SER		BIT(17)
> +	#define RTC_ADDR0_WAIT_SER		BIT(22)
> +	#define RTC_ADDR0_DATA			GENMASK(31, 24)
> +
> +#define RTC_ADDR1				0x04
> +	#define RTC_ADDR1_SDO			BIT(0)
> +	#define RTC_ADDR1_S_READY		BIT(1)
> +
> +#define RTC_ADDR2				0x08
> +#define RTC_ADDR3				0x0c
> +
> +#define RTC_REG4				0x10
> +	#define RTC_REG4_STATIC_VALUE		GENMASK(7, 0)
> +
> +/* rtc registers accessed via rtc-serial interface */
> +#define RTC_COUNTER		(0)
> +#define RTC_SEC_ADJ		(2)
> +#define RTC_REGMEM_0		(4)
> +#define RTC_REGMEM_1		(5)
> +#define RTC_REGMEM_2		(6)
> +#define RTC_REGMEM_3		(7)
> +
> +#define RTC_ADDR_BITS		(3)	/* number of address bits to send */
> +#define RTC_DATA_BITS		(32)	/* number of data bits to tx/rx */
> +
> +#define MESON_STATIC_BIAS_CUR	(0x5 << 1)
> +#define MESON_STATIC_VOLTAGE	(0x3 << 11)
> +#define MESON_STATIC_DEFAULT    (MESON_STATIC_BIAS_CUR | MESON_STATIC_VOLTAGE)
> +
> +struct meson_rtc {
> +	struct rtc_device	*rtc;		/* rtc device we created */
> +	struct device		*dev;		/* device we bound from */
> +	struct reset_control	*reset;		/* reset source */
> +	struct regulator	*vdd;		/* voltage input */
> +	struct regmap		*peripheral;	/* peripheral registers */
> +	struct regmap		*serial;	/* serial registers */
> +};
> +
> +static const struct regmap_config meson_rtc_peripheral_regmap_config = {
> +	.name		= "peripheral-registers",
> +	.reg_bits	= 8,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +	.max_register	= RTC_REG4,
> +	.fast_io	= true,
> +};
> +
> +/* RTC front-end serialiser controls */
> +
> +static void meson_rtc_sclk_pulse(struct meson_rtc *rtc)
> +{
> +	udelay(5);
> +	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SCLK, 0);
> +	udelay(5);
> +	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SCLK,
> +			   RTC_ADDR0_LINE_SCLK);
> +}
> +
> +static void meson_rtc_send_bit(struct meson_rtc *rtc, unsigned int bit)
> +{
> +	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SDI,
> +			   bit ? RTC_ADDR0_LINE_SDI : 0);
> +	meson_rtc_sclk_pulse(rtc);
> +}
> +
> +static void meson_rtc_send_bits(struct meson_rtc *rtc, u32 data,
> +				unsigned int nr)
> +{
> +	u32 bit = 1 << (nr - 1);
> +
> +	while (bit) {
> +		meson_rtc_send_bit(rtc, data & bit);
> +		bit >>= 1;
> +	}
> +}
> +
> +static void meson_rtc_set_dir(struct meson_rtc *rtc, u32 mode)
> +{
> +	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SEN, 0);
> +	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SDI, 0);
> +	meson_rtc_send_bit(rtc, mode);
> +	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SDI, 0);
> +}
> +
> +static u32 meson_rtc_get_data(struct meson_rtc *rtc)
> +{
> +	u32 tmp, val = 0;
> +	int bit;
> +
> +	for (bit = 0; bit < RTC_DATA_BITS; bit++) {
> +		meson_rtc_sclk_pulse(rtc);
> +		val <<= 1;
> +
> +		regmap_read(rtc->peripheral, RTC_ADDR1, &tmp);
> +		val |= tmp & RTC_ADDR1_SDO;
> +	}
> +
> +	return val;
> +}
> +
> +static int meson_rtc_get_bus(struct meson_rtc *rtc)
> +{
> +	int ret, retries = 3;
> +	u32 val;
> +
> +	/* prepare bus for transfers, set all lines low */
> +	val = RTC_ADDR0_LINE_SDI | RTC_ADDR0_LINE_SEN | RTC_ADDR0_LINE_SCLK;
> +	regmap_update_bits(rtc->peripheral, RTC_ADDR0, val, 0);
> +
> +	for (retries = 0; retries < 3; retries++) {
> +		/* wait for the bus to be ready */
> +		if (!regmap_read_poll_timeout(rtc->peripheral, RTC_ADDR1, val,
> +					      val & RTC_ADDR1_S_READY, 10,
> +					      10000))
> +			return 0;
> +
> +		dev_warn(rtc->dev, "failed to get bus, resetting RTC\n");
> +
> +		ret = reset_control_reset(rtc->reset);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	dev_err(rtc->dev, "bus is not ready\n");
> +	return -ETIMEDOUT;
> +}
> +
> +static int meson_rtc_serial_bus_reg_read(void *context, unsigned int reg,
> +					 unsigned int *data)
> +{
> +	struct meson_rtc *rtc = context;
> +	int ret;
> +
> +	ret = meson_rtc_get_bus(rtc);
> +	if (ret)
> +		return ret;
> +
> +	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SEN,
> +			   RTC_ADDR0_LINE_SEN);
> +	meson_rtc_send_bits(rtc, reg, RTC_ADDR_BITS);
> +	meson_rtc_set_dir(rtc, 0);
> +	*data = meson_rtc_get_data(rtc);
> +
> +	return 0;
> +}
> +
> +static int meson_rtc_serial_bus_reg_write(void *context, unsigned int reg,
> +					  unsigned int data)
> +{
> +	struct meson_rtc *rtc = context;
> +	int ret;
> +
> +	ret = meson_rtc_get_bus(rtc);
> +	if (ret)
> +		return ret;
> +
> +	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SEN,
> +			   RTC_ADDR0_LINE_SEN);
> +	meson_rtc_send_bits(rtc, data, RTC_DATA_BITS);
> +	meson_rtc_send_bits(rtc, reg, RTC_ADDR_BITS);
> +	meson_rtc_set_dir(rtc, 1);
> +
> +	return 0;
> +}
> +
> +static const struct regmap_bus meson_rtc_serial_bus = {
> +	.reg_read	= meson_rtc_serial_bus_reg_read,
> +	.reg_write	= meson_rtc_serial_bus_reg_write,
> +};
> +
> +static const struct regmap_config meson_rtc_serial_regmap_config = {
> +	.name		= "serial-registers",
> +	.reg_bits	= 4,
> +	.reg_stride	= 1,
> +	.val_bits	= 32,
> +	.max_register	= RTC_REGMEM_3,
> +	.fast_io	= false,
> +};
> +
> +static int meson_rtc_write_static(struct meson_rtc *rtc, u32 data)
> +{
> +	u32 tmp;
> +
> +	regmap_write(rtc->peripheral, RTC_REG4,
> +		     FIELD_PREP(RTC_REG4_STATIC_VALUE, (data >> 8)));
> +
> +	/* write the static value and start the auto serializer */
> +	tmp = FIELD_PREP(RTC_ADDR0_DATA, (data & 0xff)) | RTC_ADDR0_START_SER;
> +	regmap_update_bits(rtc->peripheral, RTC_ADDR0,
> +			   RTC_ADDR0_DATA | RTC_ADDR0_START_SER, tmp);
> +
> +	/* wait for the auto serializer to complete */
> +	return regmap_read_poll_timeout(rtc->peripheral, RTC_REG4, tmp,
> +					!(tmp & RTC_ADDR0_WAIT_SER), 10,
> +					10000);
> +}
> +
> +/* RTC interface layer functions */
> +
> +static int meson_rtc_gettime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct meson_rtc *rtc = dev_get_drvdata(dev);
> +	u32 time;
> +	int ret;
> +
> +	ret = regmap_read(rtc->serial, RTC_COUNTER, &time);
> +	if (!ret)
> +		rtc_time64_to_tm(time, tm);
> +
> +	return ret;
> +}
> +
> +static int meson_rtc_settime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct meson_rtc *rtc = dev_get_drvdata(dev);
> +
> +	return regmap_write(rtc->serial, RTC_COUNTER, rtc_tm_to_time64(tm));
> +}
> +
> +static const struct rtc_class_ops meson_rtc_ops = {
> +	.read_time	= meson_rtc_gettime,
> +	.set_time	= meson_rtc_settime,
> +};
> +
> +/* NVMEM interface layer functions */
> +
> +static int meson_rtc_regmem_read(void *context, unsigned int offset,
> +				 void *buf, size_t bytes)
> +{
> +	struct meson_rtc *rtc = context;
> +	unsigned int read_offset, read_size;
> +
> +	read_offset = RTC_REGMEM_0 + (offset / 4);
> +	read_size = bytes / 4;
> +
> +	return regmap_bulk_read(rtc->serial, read_offset, buf, read_size);
> +}
> +
> +static int meson_rtc_regmem_write(void *context, unsigned int offset,
> +				  void *buf, size_t bytes)
> +{
> +	struct meson_rtc *rtc = context;
> +	unsigned int write_offset, write_size;
> +
> +	write_offset = RTC_REGMEM_0 + (offset / 4);
> +	write_size = bytes / 4;
> +
> +	return regmap_bulk_write(rtc->serial, write_offset, buf, write_size);
> +}
> +
> +static int meson_rtc_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config meson_rtc_nvmem_config = {
> +		.name = "meson-rtc-regmem",
> +		.word_size = 4,
> +		.stride = 4,
> +		.size = SZ_16,
> +		.reg_read = meson_rtc_regmem_read,
> +		.reg_write = meson_rtc_regmem_write,
> +	};
> +	struct device *dev = &pdev->dev;
> +	struct meson_rtc *rtc;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret;
> +	u32 tm;
> +
> +	rtc = devm_kzalloc(dev, sizeof(struct meson_rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	rtc->rtc = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(rtc->rtc))
> +		return PTR_ERR(rtc->rtc);
> +
> +	platform_set_drvdata(pdev, rtc);
> +
> +	rtc->dev = dev;
> +
> +	rtc->rtc->ops = &meson_rtc_ops;
> +	rtc->rtc->range_max = U32_MAX;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	rtc->peripheral = devm_regmap_init_mmio(dev, base,
> +					&meson_rtc_peripheral_regmap_config);
> +	if (IS_ERR(rtc->peripheral)) {
> +		dev_err(dev, "failed to create peripheral regmap\n");
> +		return PTR_ERR(rtc->peripheral);
> +	}
> +
> +	rtc->reset = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(rtc->reset)) {
> +		dev_err(dev, "missing reset line\n");
> +		return PTR_ERR(rtc->reset);
> +	}
> +
> +	rtc->vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(rtc->vdd)) {
> +		dev_err(dev, "failed to get the vdd-supply\n");
> +		return PTR_ERR(rtc->vdd);
> +	}
> +
> +	ret = regulator_enable(rtc->vdd);
> +	if (ret) {
> +		dev_err(dev, "failed to enable vdd-supply\n");
> +		return ret;
> +	}
> +
> +	ret = meson_rtc_write_static(rtc, MESON_STATIC_DEFAULT);
> +	if (ret) {
> +		dev_err(dev, "failed to set static values\n");
> +		goto out_disable_vdd;
> +	}
> +
> +	rtc->serial = devm_regmap_init(dev, &meson_rtc_serial_bus, rtc,
> +				       &meson_rtc_serial_regmap_config);
> +	if (IS_ERR(rtc->serial)) {
> +		dev_err(dev, "failed to create serial regmap\n");
> +		ret = PTR_ERR(rtc->serial);
> +		goto out_disable_vdd;
> +	}
> +
> +	/*
> +	 * check if we can read RTC counter, if not then the RTC is probably
> +	 * not functional. If it isn't probably best to not bind.
> +	 */
> +	ret = regmap_read(rtc->serial, RTC_COUNTER, &tm);
> +	if (ret) {
> +		dev_err(dev, "cannot read RTC counter, RTC not functional\n");
> +		goto out_disable_vdd;
> +	}
> +
> +	meson_rtc_nvmem_config.priv = rtc;
> +	ret = rtc_nvmem_register(rtc->rtc, &meson_rtc_nvmem_config);
> +	if (ret)
> +		goto out_disable_vdd;
> +
> +	ret = rtc_register_device(rtc->rtc);
> +	if (ret)
> +		goto out_unregister_nvmem;
> +
> +	return 0;
> +
> +out_unregister_nvmem:
> +	rtc_nvmem_unregister(rtc->rtc);
> +
> +out_disable_vdd:
> +	regulator_disable(rtc->vdd);
> +	return ret;
> +}
> +
> +static const struct of_device_id meson_rtc_dt_match[] = {
> +	{ .compatible = "amlogic,meson6-rtc", },
> +	{ .compatible = "amlogic,meson8-rtc", },
> +	{ .compatible = "amlogic,meson8b-rtc", },
> +	{ .compatible = "amlogic,meson8m2-rtc", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, meson_rtc_dt_match);
> +
> +static struct platform_driver meson_rtc_driver = {
> +	.probe		= meson_rtc_probe,
> +	.driver		= {
> +		.name	= "meson-rtc",
> +		.of_match_table	= of_match_ptr(meson_rtc_dt_match),
> +	},
> +};
> +module_platform_driver(meson_rtc_driver);
> +
> +MODULE_DESCRIPTION("Amlogic Meson RTC Driver");
> +MODULE_AUTHOR("Ben Dooks <ben.doosk@codethink.co.uk>");
> +MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:meson-rtc");
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
