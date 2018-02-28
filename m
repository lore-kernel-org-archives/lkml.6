Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeB1Eyp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 23:54:45 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46288 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeB1Eym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 23:54:42 -0500
X-Google-Smtp-Source: AH8x227QruP3cHuLU063wyLEWjpaPYDH58S72UaxEQW2TCVCFKDC4ZcjOP4huE1FmYNEHUFqmU+pIQ==
Date: Tue, 27 Feb 2018 20:54:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [RFC 4/4] input: misc: Add Gateworks System Controller support
Message-ID: <20180228045438.GA151045@dtor-ws>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
 <1519780874-8558-5-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519780874-8558-5-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Tue, Feb 27, 2018 at 05:21:14PM -0800, Tim Harvey wrote:
> Add support for dispatching Linux Input events for the various interrupts
> the Gateworks System Controller provides.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/input/misc/Kconfig     |   6 ++
>  drivers/input/misc/Makefile    |   1 +
>  drivers/input/misc/gsc-input.c | 196 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 203 insertions(+)
>  create mode 100644 drivers/input/misc/gsc-input.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 9f082a3..3d18a0e 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -117,6 +117,12 @@ config INPUT_E3X0_BUTTON
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called e3x0_button.
>  
> +config INPUT_GSC
> +	tristate "Gateworks System Controller input support"
> +	depends on MFD_GSC
> +	help
> +	  Say Y here if you want Gateworks System Controller input support.
> +

"To compile this driver as a module..."

>  config INPUT_PCSPKR
>  	tristate "PC Speaker support"
>  	depends on PCSPKR_PLATFORM
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 4b6118d..969debe 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
>  obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
>  obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
>  obj-$(CONFIG_INPUT_GPIO_DECODER)	+= gpio_decoder.o
> +obj-$(CONFIG_INPUT_GSC)			+= gsc-input.o
>  obj-$(CONFIG_INPUT_HISI_POWERKEY)	+= hisi_powerkey.o
>  obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
>  obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
> diff --git a/drivers/input/misc/gsc-input.c b/drivers/input/misc/gsc-input.c
> new file mode 100644
> index 0000000..7cf217c
> --- /dev/null
> +++ b/drivers/input/misc/gsc-input.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Gateworks Corporation
> + */

Let's keep the same // comment block fir the copyright notice as well.
An one-line describing what this driver is would be appreciated too.

> +#define DEBUG

Please no.

> +
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/mfd/gsc.h>
> +
> +struct gsc_irq {
> +	unsigned int irq;
> +	const char *name;
> +	unsigned int virq;
> +};
> +
> +static struct gsc_irq gsc_irqs[] = {
> +	{ GSC_IRQ_PB,		"button" },
> +	{ GSC_IRQ_KEY_ERASED,	"key-erased" },
> +	{ GSC_IRQ_EEPROM_WP,	"eeprom-wp" },
> +	{ GSC_IRQ_TAMPER,	"tamper" },
> +	{ GSC_IRQ_SWITCH_HOLD,	"button-held" },
> +};
> +
> +struct gsc_input_info {
> +	struct device *dev;
> +	struct gsc_dev *gsc;
> +	struct input_dev *input;
> +
> +	int irq;
> +	struct work_struct irq_work;
> +	struct mutex mutex;
> +};
> +
> +static void gsc_input_irq_work(struct work_struct *work)
> +{
> +	struct gsc_input_info *info = container_of(work, struct gsc_input_info,
> +						   irq_work);
> +	struct gsc_dev *gsc = info->gsc;
> +	int i, ret = 0;
> +	int key, sts;
> +	struct gsc_irq *gsc_irq = NULL;
> +
> +	dev_dbg(gsc->dev, "%s irq%d\n", __func__, info->irq);
> +	mutex_lock(&info->mutex);
> +
> +	for (i = 0; i < ARRAY_SIZE(gsc_irqs);i++)
> +		if (info->irq == gsc_irqs[i].virq)
> +			gsc_irq = &gsc_irqs[i];
> +	if (!gsc_irq) {
> +		dev_err(info->dev, "interrupt: irq%d occurred\n", info->irq);
> +		mutex_unlock(&info->mutex);
> +		return;
> +	}
> +
> +	ret = regmap_read(info->gsc->regmap, GSC_IRQ_STATUS, &sts);

Why is this needed? To clear irq? What happens if several events happen
at the same time? Do we lose one of them?

> +	if (ret) {
> +		dev_err(info->dev, "failed to read status register\n");
> +		mutex_unlock(&info->mutex);
> +		return;
> +	}
> +
> +	key = -1;
> +	switch (gsc_irq->virq) {
> +	case GSC_IRQ_PB:
> +		key = BTN_0;
> +		break;
> +	case GSC_IRQ_KEY_ERASED:
> +		key = BTN_1;
> +		break;
> +	case GSC_IRQ_EEPROM_WP:
> +		key = BTN_2;
> +		break;
> +	case GSC_IRQ_GPIO:
> +		key = BTN_3;
> +		break;
> +	case GSC_IRQ_TAMPER:
> +		key = BTN_4;
> +		break;
> +	case GSC_IRQ_SWITCH_HOLD:
> +		key = BTN_5;

Could we provide the mapping in DTS instead of hard-coding them?

> +		break;
> +	}
> +
> +	if (key != -1) {
> +		dev_dbg(&info->input->dev, "bit%d: key=0x%03x %s\n",
> +			gsc_irq->virq, key, gsc_irq->name);
> +		input_report_key(info->input, key, 1);

		input_sync();

> +		input_report_key(info->input, key, 0);
> +		input_sync(info->input);
> +	}
> +
> +	mutex_unlock(&info->mutex);
> +}
> +
> +static irqreturn_t gsc_input_irq(int irq, void *data)
> +{
> +	struct gsc_input_info *info = data;
> +
> +	dev_dbg(info->gsc->dev, "%s irq%d\n", __func__, irq);
> +	info->irq = irq;
> +	schedule_work(&info->irq_work);

Why not use threaded interrupt?

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int gsc_input_probe(struct platform_device *pdev)
> +{
> +	struct gsc_dev *gsc = dev_get_drvdata(pdev->dev.parent);
> +	struct gsc_input_info *info;
> +	struct input_dev *input;
> +	int ret, i;
> +
> +	dev_dbg(&pdev->dev, "%s\n", __func__);
> +	info = devm_kzalloc(&pdev->dev, sizeof(struct gsc_input_info),
> +			    GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +	info->dev = &pdev->dev;
> +	info->gsc = gsc;
> +
> +	/* Register input device */
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input) {
> +		dev_err(&pdev->dev, "Can't allocate input device\n");
> +		return -ENOMEM;
> +	}
> +	info->input = input;
> +
> +	input->name = KBUILD_MODNAME;
> +	input->dev.parent = &pdev->dev;

Not needed - it is set by devm_input_allocate_device().

> +
> +	input_set_capability(input, EV_KEY, BTN_0); /* button */
> +	input_set_capability(input, EV_KEY, BTN_1); /* key erased */
> +	input_set_capability(input, EV_KEY, BTN_2); /* ee wp */
> +	input_set_capability(input, EV_KEY, BTN_3); /* gpio */
> +	input_set_capability(input, EV_KEY, BTN_4); /* tamper */
> +	input_set_capability(input, EV_KEY, BTN_5); /* button held */
> +
> +	ret = input_register_device(input);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Can't register input device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, gsc);
> +	mutex_init(&info->mutex);
> +	INIT_WORK(&info->irq_work, gsc_input_irq_work);
> +
> +	/* Support irq domain */
> +	for (i = 0; i < ARRAY_SIZE(gsc_irqs); i++) {
> +		struct gsc_irq *gsc_irq = &gsc_irqs[i];
> +		int virq;
> +
> +		virq = regmap_irq_get_virq(gsc->irq_chip_data, gsc_irq->irq);
> +		if (virq <= 0)
> +			return -EINVAL;
> +		gsc_irq->virq = virq;

I'd say mapping should be done by MFD piece. You can add interrupts as
resources and fetch them here.

> +
> +		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
> +						gsc_input_irq, 0,
> +						gsc_irq->name, info);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"failed: irq request (IRQ: %d, error: %d\n)",
> +				gsc_irq->irq, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id gsc_input_dt_ids[] = {
> +	{ .compatible = "gw,gsc-input", },
> +	{}
> +};
> +
> +static struct platform_driver gsc_input_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = gsc_input_dt_ids,
> +	},
> +	.probe = gsc_input_probe,
> +};
> +
> +module_platform_driver(gsc_input_driver);
> +
> +MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
> +MODULE_DESCRIPTION("GSC input driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
