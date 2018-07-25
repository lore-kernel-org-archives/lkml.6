Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA66C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2820844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHD2Rn25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF2820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeGYLxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbeGYLxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:53:43 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A04B920844;
        Wed, 25 Jul 2018 10:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532515356;
        bh=6cpIZ+n30VO+1BZjNBVP4mo2XiTxVNKB5N+xBBDa6RA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=OHD2Rn2518gD4t2oEZ+e4LSxEKT0k/g1V9m7pKmFaqYQbQtj9Bq9Uxoc6PNbcSfXi
         MZcJEaqyUvlp5ieEi0X+oiZcxwDKior/Xqmog7yMzNxWNGbwIYgrs8WY+96dXMhEn6
         4bUgefik1sx17XeX3Cks/uLxlF67LfuI+xUxz9BA=
Received: by mail-wr1-f44.google.com with SMTP id t13-v6so6896508wrv.12;
        Wed, 25 Jul 2018 03:42:36 -0700 (PDT)
X-Gm-Message-State: AOUpUlFzHyE9WNfmjbAlxOEIEvmVJhAQbmCxkK0ZzseczxBjgC/OVFrK
        E7cLLZqCvUdO/wNf7riis3ZJ7PPClNNC4lWwaxA=
X-Google-Smtp-Source: AAOMgpcL4NdQdRVJsfhEWnEY3I8Zfif98ao24HeQYpeX4L4kEctwvNJeN5rvh8ASmRvRH5VSEiwYb70BjM+e0VvVRd8=
X-Received: by 2002:adf:f485:: with SMTP id l5-v6mr5795223wro.259.1532515355189;
 Wed, 25 Jul 2018 03:42:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 03:42:34
 -0700 (PDT)
In-Reply-To: <20180723040816.19455-3-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br> <20180723040816.19455-3-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 25 Jul 2018 12:42:34 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd93QKfUQvruwGe3WL52_yhbCG_mPSwt74thPNqdJ7qxg@mail.gmail.com>
Message-ID: <CAJKOXPd93QKfUQvruwGe3WL52_yhbCG_mPSwt74thPNqdJ7qxg@mail.gmail.com>
Subject: Re: [PATCH 2/4] power: supply: max17040: Config alert SOC low level
 threshold from FDT
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
> For configuration of fuel gauge alert for a low level state of charge
> interrupt we add a function to config level threshold and a device tree
> binding property to set it in flatned device tree node.
>
> Now we can use "maxim,alert-soc-level" property with the values from
> 1 up to 32 to configure alert interrupt threshold.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 36 +++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

Hi Matheus,

In series, bindings describing new DT property should go before
introducing them in the driver.

>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 6e54e58814a9..3efa52d32b44 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -47,6 +47,8 @@ struct max17040_chip {
>         int soc;
>         /* State Of Charge */
>         int status;
> +       /* Alert threshold */

Threshold in what units?

> +       int alert_threshold;
>  };
>
>  static int max17040_get_property(struct power_supply *psy,
> @@ -123,6 +125,28 @@ static void max17040_get_soc(struct i2c_client *client)
>         chip->soc = (soc >> 8);
>  }
>
> +static int max17040_set_soc_threshold(struct i2c_client *client, u8 level)
> +{
> +       int ret;
> +       u16 data;
> +
> +       /* check if level is between 1% and 32% */
> +       if (level > 0 && level < 33) {
> +               /* alert threshold use LSb 5 bits from RCOMP */
> +               /* two's-complements form: 00000 = 32% and 11111 = 1% */

Please use Linux style comments.

> +               level = 32 - level;
> +               data = max17040_read_reg(client, MAX17040_RCOMP);
> +               data &= 0xFFE0;

Please define the mask.

> +               data |= level;
> +               max17040_write_reg(client, MAX17040_RCOMP, data);
> +               ret = 0;
> +       } else {
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
>  static void max17040_get_version(struct i2c_client *client)
>  {
>         u16 version;
> @@ -165,6 +189,16 @@ static void max17040_get_status(struct i2c_client *client)
>                 chip->status = POWER_SUPPLY_STATUS_FULL;
>  }
>
> +static void max17040_get_of_data(struct max17040_chip *chip)
> +{
> +       struct device *dev = &chip->client->dev;
> +       struct device_node *np = dev->of_node;
> +
> +       if (of_property_read_s32(np, "maxim,alert-soc-level",
> +                       &chip->alert_threshold))
> +               chip->alert_threshold = 4;

1. You read s32 and later cast it to u8. Either some validation of
possible values or of_property_read_u8().
2. You have hard-coded default value - please put it in some define.
There are already defines, e.g.: MAX17040_BATTERY_FULL
3. Also the bindings say something about power up value... not 4.
4, I think that  default - missing - value should mean "no interrupt warnings".

> +}
> +
>  static void max17040_work(struct work_struct *work)
>  {
>         struct max17040_chip *chip;
> @@ -231,6 +265,7 @@ static int max17040_probe(struct i2c_client *client,
>
>         chip->client = client;
>         chip->pdata = client->dev.platform_data;
> +       max17040_get_of_data(chip);
>
>         i2c_set_clientdata(client, chip);
>         psy_cfg.drv_data = chip;
> @@ -262,6 +297,7 @@ static int max17040_probe(struct i2c_client *client,
>
>         max17040_reset(client);
>         max17040_get_version(client);
> +       max17040_set_soc_threshold(client, chip->alert_threshold);

1. Return value ignored.
2. First you enable interrupts for whatever default value of alerts
and then you set the alerts threshold. You might generate false
warning in such case so this should be in reverse order.

Best regards,
Krzysztof

>
>         INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
>         queue_delayed_work(system_power_efficient_wq, &chip->work,
> --
> 2.13.3
>
