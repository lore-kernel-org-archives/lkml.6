Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8BFC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B4820899
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYbxRnLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B4820899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeGYLi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbeGYLi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:38:28 -0400
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D170020890;
        Wed, 25 Jul 2018 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532514445;
        bh=I9yVjWBN29vSV8Om7OfqtIbGBpqvoqCF4fGdtTn4xc4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=UYbxRnLze8adnrUKmwpLPmCkhJAlQUKkxCRkz6mHGLCxr3nwnhVcQglCIXzW7SVrg
         JtcBqqYOLVh1JeG5SjVmSsHzktwIpBqUDhgnyfy41bfmxySNZkR4UlXvIjjbmS0fKW
         4j5tJtSp1XGZCKHn9WwODByjm6XFdSeAULABcfHI=
Received: by mail-wm0-f52.google.com with SMTP id s14-v6so5487213wmc.1;
        Wed, 25 Jul 2018 03:27:24 -0700 (PDT)
X-Gm-Message-State: AOUpUlFHVzw4/j8t7DJviSjojDqZjV/C5qUa8fotrbhSTz76JtQ/87fM
        hIRE0YkywtyC7h3vEKjdvyN7vz1ZYbsFY7ZzId8=
X-Google-Smtp-Source: AAOMgpeeVX+9IXpmt8BqOibRUyu2sbPCROPTzAeSIjpBzX/9vPF1qgrAXDKYkYFTfXxvJuu1CEi8Z0cO79/YxyYDUjg=
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr4001042wmd.135.1532514443304;
 Wed, 25 Jul 2018 03:27:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 03:27:22
 -0700 (PDT)
In-Reply-To: <20180723040816.19455-2-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br> <20180723040816.19455-2-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 25 Jul 2018 12:27:22 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeWq9hohuLSKMopWjHAgm+DX2YXCxqhpK+5N5nySzYpDg@mail.gmail.com>
Message-ID: <CAJKOXPeWq9hohuLSKMopWjHAgm+DX2YXCxqhpK+5N5nySzYpDg@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: supply: max17040: Add IRQ handler for low SOC alert
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 July 2018 at 06:08, Matheus Castello <matheus@castello.eng.br> wrote:
> According datasheet max17040 has a pin for alert host for low SOC.
> This pin can be used as external interrupt, so we need to check for
> interrupts assigned for device and handle it.
>
> In hadler we are checking and storing fuel gauge registers values
> and send an uevent to notificate user space, so user space can decide
> save work or turn off since the alert demonstrate that the battery may
> no have the power to keep the system turned on for much longer.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 51 +++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 33c40f79d23d..6e54e58814a9 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -17,6 +17,7 @@
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
> +#include <linux/interrupt.h>
>  #include <linux/power_supply.h>
>  #include <linux/max17040_battery.h>
>  #include <linux/slab.h>
> @@ -179,6 +180,24 @@ static void max17040_work(struct work_struct *work)
>                            MAX17040_DELAY);
>  }
>
> +static irqreturn_t max17040_thread_handler(int id, void *dev)
> +{
> +       struct max17040_chip *chip = dev;
> +       struct i2c_client *client = chip->client;
> +
> +       dev_warn(&client->dev, "IRQ: Alert battery low level");
> +       /* read registers */
> +       max17040_get_vcell(chip->client);

You just stored chip->client in client...

> +       max17040_get_soc(chip->client);
> +       max17040_get_online(chip->client);
> +       max17040_get_status(chip->client);

This duplicates max17040_work(). Can you split common part?

> +
> +       /* send uevent */
> +       power_supply_changed(chip->battery);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  static enum power_supply_property max17040_battery_props[] = {
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_ONLINE,
> @@ -200,6 +219,8 @@ static int max17040_probe(struct i2c_client *client,
>         struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
>         struct power_supply_config psy_cfg = {};
>         struct max17040_chip *chip;
> +       int ret;
> +       unsigned int flags;

Define them in scope using them.

>
>         if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
>                 return -EIO;
> @@ -221,6 +242,24 @@ static int max17040_probe(struct i2c_client *client,
>                 return PTR_ERR(chip->battery);
>         }
>
> +       /* check interrupt */
> +       if (client->irq) {
> +               dev_info(&client->dev, "IRQ: enabled\n");
> +               flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> +
> +               ret = devm_request_threaded_irq(&client->dev, client->irq,
> +                                               NULL,
> +                                               max17040_thread_handler, flags,
> +                                               chip->battery->desc->name,
> +                                               chip);

Please indent it to parenthesis.

> +               if (ret) {
> +                       client->irq = 0;
> +                       if (ret != -EBUSY)
> +                               dev_warn(&client->dev,
> +                                       "Failed to get IRQ err %d \n", ret);
> +               }
> +       }
> +
>         max17040_reset(client);
>         max17040_get_version(client);
>
> @@ -248,6 +287,12 @@ static int max17040_suspend(struct device *dev)
>         struct max17040_chip *chip = i2c_get_clientdata(client);
>
>         cancel_delayed_work(&chip->work);
> +
> +       if (chip->client->irq) {

I think this should use device wakeup properties (e.g.
device_init_wakeup(), device_may_wakeup()) coming from pdata.

It would be nice to CC users of this driver. We have it on some of
boards. Unfortunately get_maintainer will not point it automatically
so:
scripts/get_maintainer.pl -f drivers/mfd/max14577.c

Best regards,
Krzysztof

> +               disable_irq(chip->client->irq);
> +               enable_irq_wake(chip->client->irq);
> +       }
> +
>         return 0;
>  }
>
> @@ -258,6 +303,12 @@ static int max17040_resume(struct device *dev)
>
>         queue_delayed_work(system_power_efficient_wq, &chip->work,
>                            MAX17040_DELAY);
> +
> +       if (chip->client->irq) {
> +               disable_irq_wake(chip->client->irq);
> +               enable_irq(chip->client->irq);
> +       }
> +
>         return 0;
>  }
>
> --
> 2.13.3
>
