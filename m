Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E61C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E808C20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wru/+/0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E808C20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeIKEQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:16:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43439 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeIKEQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:16:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so11214777pgb.10;
        Mon, 10 Sep 2018 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OOJY+s3WT2KjFK+1GeQkeUsqrKBj/JKdnVk5zYYLhK0=;
        b=Wru/+/0SsgBDUzQ3LLBTZPe3rFI6KmyQGc6suks1LbACFGraBNWuysQtRKDEzdJ3Cu
         qM1OgDXJV7sYIEK4osml3+M6nOKwVP0cjM+duXn2UL/RtNZlHP4raYKvFPpp8oPjbdhN
         qJxcTmZ9q3Fw75J6CZqWKdUJoU7OWfT5wa96xP/QM84XEjKs4qoWVR5+2mA/hgswEMNG
         1EtbRXRM8fbhjpEtcGWSyiTTBAQukY12urjlrlxNBFAkvsyPj+GyAq+9mrVmak1MuJFd
         p97pIX0zzTe2L0L3PFOZkNLjnlHqh5ZrVelpv4oOZog0FsDeThd2Ve6qNhnN8lnBoRuh
         gQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OOJY+s3WT2KjFK+1GeQkeUsqrKBj/JKdnVk5zYYLhK0=;
        b=uH2/HRcsfcIQAmQgXRLch3/xQ4keGh5jwcwJpu+XnCZQG9RFgZu2U8tAV7K9VUI+1A
         lClcdtxRhTNAWAfM4BEc0h/zTNuuoH8t5mcouS8hfbrjb5c/wb3qdnF/onH7nsutxg0D
         lZHsKrSmgfDPoAmp3VWzw2dZx3DBd6nmF01ZdZhjBBU2xq50EFWvqAqthoJr1nXlESO7
         IuWmX5SSrTy+mo3mZGy0YKwp6VyzJELlDDdeNWJDLwac2fPSro44J5L+NI0OsqXU2IBx
         yUw5vYWqDfSlvjz7BVvwle8E6iUY+BeTjLTVg5gOtHF7rqwrvXXu2V6lE66nGEgR1OSq
         Rf2A==
X-Gm-Message-State: APzg51AXupiIAHIwIvjFXQpNxQ2C4DPRQWCcxrpiWrJXUR2DB+x0kW3i
        txpqVqINUGNK9WbCxT2vtYM=
X-Google-Smtp-Source: ANB0VdY3+VbR79fBTIz5Z8P/qzzCPw/VyAyz2FNTAvDGx65tq/qV7kr9fK8iNOtj6CghcfRdLqD9Eg==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr25922469pgc.48.1536621621715;
        Mon, 10 Sep 2018 16:20:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b1-v6sm30097390pgi.91.2018.09.10.16.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 16:20:20 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:20:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jeremy Gebben <jgebben@sweptlaser.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: abx80x: add basic watchdog support
Message-ID: <20180910232019.GA8439@roeck-us.net>
References: <20180910213654.26059-1-jgebben@sweptlaser.com>
 <20180910213654.26059-3-jgebben@sweptlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910213654.26059-3-jgebben@sweptlaser.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 03:36:54PM -0600, Jeremy Gebben wrote:
> The abx804 and abx805 chips have support for a simple watchdog
> function that can trigger an external reset.
> 
> Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>

I am missing the "select WATCHDOG_CORE" that would normally go
with watchdog drivers. If you don't want a separate configuration
option for the watchdog, you'll still need something like

	select WATCHDOG_CORE if WATCHDOG

in the Kconfig entry for this driver.

> ---
>  drivers/rtc/rtc-abx80x.c | 132 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 128 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 9d49054a0a4a..e1ec4cce093a 100644
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
> @@ -80,23 +90,25 @@ enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
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
>  struct abx80x_priv {
>  	struct rtc_device *rtc;
>  	struct i2c_client *client;
> +	struct watchdog_device wdog;
>  };
>  
>  static int abx80x_is_rc_mode(struct i2c_client *client)
> @@ -234,6 +246,13 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
>  	if (status & ABX8XX_STATUS_AF)
>  		rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
>  
> +	/*
> +	 * It is unclear if we'll get an interrupt before the external
> +	 * reset kicks in.
> +	 */
> +	if (status & ABX8XX_STATUS_WDT)
> +		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
> +
>  	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
>  
>  	return IRQ_HANDLED;
> @@ -535,6 +554,105 @@ static void rtc_calib_remove_sysfs_group(void *_dev)
>  	sysfs_remove_group(&dev->kobj, &rtc_calib_attr_group);
>  }
>  
> +#ifdef CONFIG_WATCHDOG
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

I'll leave multi-line alignment issues to the driver maintainer.

> +{
> +	int err = __abx80x_wdog_set_timeout(wdog, new_timeout);
> +

This will unconditionally enable the watchdog, even if it is currently
disabled.

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

This is only necessary if the watchdog is running at probe,
or if it can not be stopped.

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

This suggests that the watchdog can be stopped, thus it is
unnecessary to set or clear the bit.

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

priv->wdog.parent should be set.

> +
> +	err = devm_watchdog_register_device(&priv->client->dev,
> +					    &priv->wdog);
> +	if (err)
> +		return err;
> +
> +	watchdog_set_drvdata(&priv->wdog, priv);

This is too late and racy; it must be called prior to registration.

> +	watchdog_init_timeout(&priv->wdog, ABX8XX_WDT_MAX_TIME,
> +			      &priv->client->dev);

This is quite pointless. Just set
	priv->wdog.timeout = ABX8XX_WDT_MAX_TIME;
above (prior to registration). If the idea is to be able to pick
a timeout value from devicetree, you would still set the default
value above and make the call
	watchdog_init_timeout(&priv->wdog, 0, &priv->client->dev);
but again prior to registration.

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
> @@ -629,6 +747,12 @@ static int abx80x_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, priv);
>  
> +	if (abx80x_caps[part].has_wdog) {
> +		err = abx80x_setup_watchdog(priv);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (client->irq > 0) {
>  		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
>  		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -- 
> 2.17.1
> 
