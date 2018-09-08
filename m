Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C73C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3482F206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3482F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeIHT4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:56:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34864 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbeIHT4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:56:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ED26F207AD; Sat,  8 Sep 2018 17:10:07 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id B5A00204AE;
        Sat,  8 Sep 2018 17:09:57 +0200 (CEST)
Date:   Sat, 8 Sep 2018 17:09:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jeremy Gebben <jgebben@sweptlaser.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: abx80x: add basic watchdog support
Message-ID: <20180908150957.GD2598@piout.net>
References: <20180907151744.32634-1-jgebben@sweptlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907151744.32634-1-jgebben@sweptlaser.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please Cc the watchdog maintainers. Else, I have very few comments.

On 07/09/2018 09:17:43-0600, Jeremy Gebben wrote:
> The abx804 and abx805 chips have support for a simple watchdog
> function that can trigger an external reset.
> 
> Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
> ---
>  drivers/rtc/Kconfig      |  11 +++
>  drivers/rtc/rtc-abx80x.c | 160 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 159 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 7d7be60a2413..4771e3a89721 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -195,6 +195,17 @@ config RTC_DRV_ABX80X
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-abx80x.
>  
> +config RTC_DRV_ABX80X_WDT
> +	bool "Abracon ABx80x Watchdog"
> +	default y
> +	depends on RTC_DRV_ABX80X
> +	help
> +	  If you say yes here you get watchdog support for Abracon ABX804 and ABX805
> +	  clock chips. This watchdog supports timeouts up to 31 seconds with 1 second
> +	  granularity.
> +
> +          This watchdog device is part of the rtc-abx80x module.
> +

I'm not sure it is worth having a separate config option for that. You
may as well just always include the watchdog support code. However,
doesn't it need to depend on CONFIG_WATCHDOG?

>  config RTC_DRV_AC100
>  	tristate "X-Powers AC100"
>  	depends on MFD_AC100
> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 2cefa67a1132..fa558939e944 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -17,6 +17,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/rtc.h>
> +#include <linux/watchdog.h>
>  
>  #define ABX8XX_REG_HTH		0x00
>  #define ABX8XX_REG_SC		0x01
> @@ -37,6 +38,7 @@
>  
>  #define ABX8XX_REG_STATUS	0x0f
>  #define ABX8XX_STATUS_AF	BIT(2)
> +#define ABX8XX_STATUS_WDT	BIT(6)
>  
>  #define ABX8XX_REG_CTRL1	0x10
>  #define ABX8XX_CTRL_WRITE	BIT(0)
> @@ -61,6 +63,14 @@
>  #define ABX8XX_OSS_OF		BIT(1)
>  #define ABX8XX_OSS_OMODE	BIT(4)
>  
> +#define ABX8XX_REG_WDT		0x1b
> +#define ABX8XX_WDT_WDS		BIT(7)
> +#define ABX8XX_WDT_BMB_MASK	0x7c
> +#define ABX8XX_WDT_BMB_SHIFT	2
> +#define ABX8XX_WDT_MAX_TIME	(ABX8XX_WDT_BMB_MASK >> ABX8XX_WDT_BMB_SHIFT)
> +#define ABX8XX_WDT_WRB_MASK	0x03
> +#define ABX8XX_WDT_WRB_1HZ	0x02
> +
>  #define ABX8XX_REG_CFG_KEY	0x1f
>  #define ABX8XX_CFG_KEY_OSC	0xa1
>  #define ABX8XX_CFG_KEY_MISC	0x9d
> @@ -80,20 +90,27 @@ enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
>  struct abx80x_cap {
>  	u16 pn;
>  	bool has_tc;
> +	bool has_wdog;
>  };
>  
>  static struct abx80x_cap abx80x_caps[] = {
>  	[AB0801] = {.pn = 0x0801},
>  	[AB0803] = {.pn = 0x0803},
> -	[AB0804] = {.pn = 0x0804, .has_tc = true},
> -	[AB0805] = {.pn = 0x0805, .has_tc = true},
> +	[AB0804] = {.pn = 0x0804, .has_tc = true, .has_wdog = true},
> +	[AB0805] = {.pn = 0x0805, .has_tc = true, .has_wdog = true},
>  	[AB1801] = {.pn = 0x1801},
>  	[AB1803] = {.pn = 0x1803},
> -	[AB1804] = {.pn = 0x1804, .has_tc = true},
> -	[AB1805] = {.pn = 0x1805, .has_tc = true},
> +	[AB1804] = {.pn = 0x1804, .has_tc = true, .has_wdog = true},
> +	[AB1805] = {.pn = 0x1805, .has_tc = true, .has_wdog = true},
>  	[ABX80X] = {.pn = 0}
>  };
>  
> +struct abx80x_priv {
> +	struct rtc_device *rtc;
> +	struct i2c_client *client;
> +	struct watchdog_device wdog;
> +};
> +

To make the watchdog part easier to review, you could separate the
introduction of abx80x_priv in a preliminary patch and then introduce
the watchdog code.

>  static int abx80x_is_rc_mode(struct i2c_client *client)
>  {
>  	int flags = 0;
> @@ -218,7 +235,8 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
>  {
>  	struct i2c_client *client = dev_id;
> -	struct rtc_device *rtc = i2c_get_clientdata(client);
> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
> +	struct rtc_device *rtc = priv->rtc;
>  	int status;
>  
>  	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
> @@ -228,6 +246,13 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
>  	if (status & ABX8XX_STATUS_AF)
>  		rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
>  
> +	/*
> +	 * It is unclear if we'll get an interrupt before the external
> +	 * reset kicks in.
> +	 */
> +	if (status & ABX8XX_STATUS_WDT)
> +		dev_err(&client->dev, "watchdog timeout interrupt!\n");
> +

dev_alert maybe?

>  	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
>  
>  	return IRQ_HANDLED;
> @@ -529,11 +554,110 @@ static void rtc_calib_remove_sysfs_group(void *_dev)
>  	sysfs_remove_group(&dev->kobj, &rtc_calib_attr_group);
>  }
>  
> +#ifdef CONFIG_RTC_DRV_ABX80X_WDT
> +
> +static inline u8 timeout_bits(unsigned int timeout)
> +{
> +	return ((timeout << ABX8XX_WDT_BMB_SHIFT) & ABX8XX_WDT_BMB_MASK) |
> +		 ABX8XX_WDT_WRB_1HZ;
> +}
> +
> +static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
> +				    unsigned int timeout)
> +{
> +	struct abx80x_priv *priv = watchdog_get_drvdata(wdog);
> +	u8 val = ABX8XX_WDT_WDS | timeout_bits(timeout);
> +
> +	/*
> +	 * Writing any timeout to the WDT register resets the watchdog timer.
> +	 * Writing 0 disables it.
> +	 */
> +	return i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_WDT, val);
> +}
> +
> +static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
> +				unsigned int new_timeout)
> +{
> +	int err = __abx80x_wdog_set_timeout(wdog, new_timeout);
> +
> +	if (err)
> +		return err;
> +
> +	wdog->timeout = new_timeout;
> +	return 0;
> +}
> +
> +static int abx80x_wdog_ping(struct watchdog_device *wdog)
> +{
> +	return __abx80x_wdog_set_timeout(wdog, wdog->timeout);
> +}
> +
> +static int abx80x_wdog_start(struct watchdog_device *wdog)
> +{
> +	int err = __abx80x_wdog_set_timeout(wdog, wdog->timeout);
> +
> +	if (err)
> +		return err;
> +
> +	set_bit(WDOG_HW_RUNNING, &wdog->status);
> +	return 0;
> +}
> +
> +static int abx80x_wdog_stop(struct watchdog_device *wdog)
> +{
> +	int err = __abx80x_wdog_set_timeout(wdog, 0);
> +
> +	if (err)
> +		return err;
> +
> +	clear_bit(WDOG_HW_RUNNING, &wdog->status);
> +	return 0;
> +}
> +
> +static const struct watchdog_info abx80x_wdog_info = {
> +	.identity = "abx80x watchdog",
> +	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> +};
> +
> +static const struct watchdog_ops abx80x_wdog_ops = {
> +	.owner = THIS_MODULE,
> +	.start = abx80x_wdog_start,
> +	.stop = abx80x_wdog_stop,
> +	.ping = abx80x_wdog_ping,
> +	.set_timeout = abx80x_wdog_set_timeout,
> +};
> +
> +static int abx80x_setup_watchdog(struct abx80x_priv *priv)
> +{
> +	int err;
> +
> +	priv->wdog.ops = &abx80x_wdog_ops;
> +	priv->wdog.info = &abx80x_wdog_info;
> +	priv->wdog.min_timeout = 1;
> +	priv->wdog.max_timeout = ABX8XX_WDT_MAX_TIME;
> +
> +	err = devm_watchdog_register_device(&priv->client->dev,
> +					    &priv->wdog);
> +	if (err)
> +		return err;
> +
> +	watchdog_set_drvdata(&priv->wdog, priv);
> +	watchdog_init_timeout(&priv->wdog, ABX8XX_WDT_MAX_TIME,
> +			      &priv->client->dev);
> +	return 0;
> +}
> +#else
> +static int abx80x_setup_watchdog(struct abx80x_priv *priv)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int abx80x_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct device_node *np = client->dev.of_node;
> -	struct rtc_device *rtc;
> +	struct abx80x_priv *priv;
>  	int i, data, err, trickle_cfg = -EINVAL;
>  	char buf[7];
>  	unsigned int part = id->driver_data;
> @@ -610,13 +734,25 @@ static int abx80x_probe(struct i2c_client *client,
>  	if (err)
>  		return err;
>  
> -	rtc = devm_rtc_allocate_device(&client->dev);
> -	if (IS_ERR(rtc))
> -		return PTR_ERR(rtc);
> +	priv = devm_kzalloc(&client->dev, sizeof(struct abx80x_priv),
> +			    GFP_KERNEL);
> +	if (priv == NULL)
> +		return -ENOMEM;
> +
> +	priv->rtc = devm_rtc_allocate_device(&client->dev);
> +	if (IS_ERR(priv->rtc))
> +		return PTR_ERR(priv->rtc);
>  
> -	rtc->ops = &abx80x_rtc_ops;
> +	priv->rtc->ops = &abx80x_rtc_ops;
> +	priv->client = client;
>  
> -	i2c_set_clientdata(client, rtc);
> +	i2c_set_clientdata(client, priv);
> +
> +	if (abx80x_caps[part].has_wdog) {
> +		err = abx80x_setup_watchdog(priv);
> +		if (err)
> +			return err;
> +	}
>  
>  	if (client->irq > 0) {
>  		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
> @@ -649,7 +785,7 @@ static int abx80x_probe(struct i2c_client *client,
>  		return err;
>  	}
>  
> -	err = rtc_register_device(rtc);
> +	err = rtc_register_device(priv->rtc);
>  
>  	return err;
>  }
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
