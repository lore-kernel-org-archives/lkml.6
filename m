Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeEBCbZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 22:31:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38432 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750823AbeEBCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 22:31:23 -0400
X-UUID: 914cbf84988f4b9795b1de7e2584b0f7-20180502
Message-ID: <1525228271.14792.5.camel@mtkswgap22>
Subject: Re: Re: [PATCH v2 15/17] power: reset: mt6323: add a driver for
 MT6323 power controller
From: Sean Wang <sean.wang@mediatek.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <mark.rutland@arm.com>, <a.zummo@towertech.it>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@free-electrons.com>, <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <eddie.huang@mediatek.com>,
        <lee.jones@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>
Date: Wed, 2 May 2018 10:31:11 +0800
In-Reply-To: <20180501125628.44nyx25tqsrxkvsl@earth.universe>
References: <cover.1524646231.git.sean.wang@mediatek.com>
         <51d4fbe0d6a22986ddd2df66c9db39aa1eaab74a.1524646231.git.sean.wang@mediatek.com>
         <20180501125628.44nyx25tqsrxkvsl@earth.universe>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-01 at 14:56 +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Apr 25, 2018 at 05:32:41PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > The power device is responsible for externally down or up the power
> > of the remote MediaTek SoC through the tiny circuit BBPU inside PMIC RTC.
> > 
> > Though it's a part of RTC device, it would be better to be a standalone
> > driver than to be a part of existent RTC driver so as to let us make
> > concentration on works about power-controlling topic and to obtain
> > improvements while the subsystem power/reset constantly growing.
> 
> I don't understand the above sentence. (I'm fine with adding the
> driver)

Which I was actually meaning is that taking the poweroff driver as the
standalone one and placing it under driver/reset/power seems can simply
get a help from its subsystem either for function extension or bugfix in
the future. I thought that way is better than just an embedded one
somewhere in rtc driver or other drivers.

> > Currently, the most basic functionality supported is to just power off
> > the system by writing to a special bit field in BBPU register after the
> > system has reached pm_poweroff.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/power/reset/Kconfig           | 10 ++++
> >  drivers/power/reset/Makefile          |  1 +
> >  drivers/power/reset/mt6323-poweroff.c | 97 +++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/mt6397/rtc.h        |  1 +
> >  4 files changed, 109 insertions(+)
> >  create mode 100644 drivers/power/reset/mt6323-poweroff.c
> > 
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index df58fc8..7b49d71 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -128,6 +128,16 @@ config POWER_RESET_LTC2952
> >  	  This driver supports an external powerdown trigger and board power
> >  	  down via the LTC2952. Bindings are made in the device tree.
> >  
> > +config POWER_RESET_MT6323
> > +	bool "MediaTek MT6323 power-off driver"
> > +	depends on MFD_MT6397
> > +	help
> > +	  The power-off driver is responsible for externally shutdown down
> > +	  the power of a remote MediaTek SoC MT6323 is connected to through
> > +	  controlling a tiny circuit BBPU inside MT6323 RTC.
> > +
> > +	  Say Y if you have a board where MT6323 could be found.
> > +
> >  config POWER_RESET_QNAP
> >  	bool "QNAP power-off driver"
> >  	depends on OF_GPIO && PLAT_ORION
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> > index 7778c74..8836172 100644
> > --- a/drivers/power/reset/Makefile
> > +++ b/drivers/power/reset/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
> >  obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
> >  obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
> > +obj-$(CONFIG_POWER_RESET_MT6323) += mt6323-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
> >  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
> > diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/mt6323-poweroff.c
> > new file mode 100644
> > index 0000000..c195766
> > --- /dev/null
> > +++ b/drivers/power/reset/mt6323-poweroff.c
> > @@ -0,0 +1,97 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Power off through MediaTek PMIC
> > + *
> > + * Copyright (C) 2018 MediaTek Inc.
> > + *
> > + * Author: Sean Wang <sean.wang@mediatek.com>
> > + *
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> 
> Not needed

Will be removed.

> 
> > +#include <linux/platform_device.h>
> > +#include <linux/mfd/mt6397/core.h>
> > +#include <linux/mfd/mt6397/rtc.h>
> > +
> > +struct mt6323_pwrc {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	u32 base;
> > +};
> > +
> > +static struct mt6323_pwrc *mt_pwrc;
> > +
> > +static void mt6323_do_pwroff(void)
> > +{
> > +	struct mt6323_pwrc *pwrc = mt_pwrc;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	regmap_write(pwrc->regmap, pwrc->base + RTC_BBPU, RTC_BBPU_KEY);
> > +	regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR, 1);
> > +
> > +	ret = regmap_read_poll_timeout(pwrc->regmap,
> > +				       pwrc->base + RTC_BBPU, val,
> > +				       !(val & RTC_BBPU_CBUSY),
> > +				       MTK_RTC_POLL_DELAY_US,
> > +				       MTK_RTC_POLL_TIMEOUT);
> > +	if (ret)
> > +		dev_err(pwrc->dev, "failed to write BBPU: %d\n", ret);
> > +
> > +	/* Wait some time until system down, otherwise, notice with a warn */
> > +	mdelay(1000);
> > +
> > +	WARN_ONCE(1, "Unable to power off system\n");
> > +}
> > +
> > +static int mt6323_pwrc_probe(struct platform_device *pdev)
> > +{
> > +	struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
> > +	struct mt6323_pwrc *pwrc;
> > +	struct resource *res;
> > +
> > +	pwrc = devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
> > +	if (!pwrc)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	pwrc->base = res->start;
> > +	pwrc->regmap = mt6397_chip->regmap;
> > +	pwrc->dev = &pdev->dev;
> > +	mt_pwrc = pwrc;
> > +
> > +	pm_power_off = &mt6323_do_pwroff;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mt6323_pwrc_remove(struct platform_device *pdev)
> > +{
> > +	if (pm_power_off == &mt6323_do_pwroff)
> > +		pm_power_off = NULL;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id mt6323_pwrc_dt_match[] = {
> > +	{ .compatible = "mediatek,mt6323-pwrc" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, mt6323_pwrc_dt_match);
> 
> Don't forget to remove the DT table when you respin the series for
> the requested binding changes.
> 

Thanks. This table will be removed in the next version.


> > +static struct platform_driver mt6323_pwrc_driver = {
> > +	.probe		= mt6323_pwrc_probe,
> > +	.remove		= mt6323_pwrc_remove,
> > +	.driver		= {
> > +		.name	= "mt6323-pwrc",
> > +		.of_match_table = mt6323_pwrc_dt_match,
> > +	},
> > +};
> > +
> > +module_platform_driver(mt6323_pwrc_driver);
> > +
> > +MODULE_DESCRIPTION("Poweroff driver for MT6323 PMIC");
> > +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
> > index 480977c..ac932c9 100644
> > --- a/include/linux/mfd/mt6397/rtc.h
> > +++ b/include/linux/mfd/mt6397/rtc.h
> > @@ -16,6 +16,7 @@
> >  
> >  #define RTC_BBPU		0x0000
> >  #define RTC_BBPU_CBUSY		BIT(6)
> > +#define RTC_BBPU_KEY            (0x43 << 8)
> >  
> >  #define RTC_WRTGR		0x003c
> 
> The driver looks fine otherwise.
> 

Thanks.

> -- Sebastian
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
