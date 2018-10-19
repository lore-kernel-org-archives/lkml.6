Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71464ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C89021479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfAMX05c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C89021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJSVyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:54:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41989 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJSVyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:54:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id j46-v6so38290952qtc.9;
        Fri, 19 Oct 2018 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xK9YTAE9DGhx2VC74aytfUA6OTknMViBhk/qS3zmqw=;
        b=IfAMX05cbC6iYcjiXztLpVCqMks5h8yuflY2Z1YicL5Tw51jVlItqfoTdFKgcJpBqR
         NYgIBZrIkO0/jrX8DerBqOpF/heWoQjO4ESgulWWxTLwuf6r8ub/yClPH3HXVoxDiNRG
         LHUUankFM3cVtM7kkz+oeKrjLff1qQ1eNfUfS9K6CUIMHXSVh9afs4XlL17hPS7w5fZd
         NoZsLFDirmuhIJgQm3xEswBdwZHcQwZjKyKWtIXWiH4LxpGy/YhGDAwuQ+655AnHDzaW
         Cxycephnb0fBAKuDVTaiFAtcQlzY8OwCYCcgMQMF0l3Rpua73cMa6WxEJEB4Nym8uSih
         u/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xK9YTAE9DGhx2VC74aytfUA6OTknMViBhk/qS3zmqw=;
        b=icP5k0KqWcSaHQD1NVxDh3Js1zyN48jf+Iqx47QKWZTg83tBTElc4EDusWCkyl8Ww+
         ryUrG0tvncTMwyfTqpqkX9lVgZ4tlslFkR5tbqtqRzJSUktKteJMdnl/FMHNdj0b8W7h
         RmQF63w7bqvUvpaNFmgQE8Jo/fOrR0RR1ag6sBugCoJ7Q6NrMpwfwOAcyL99g4L214hj
         aLya8uOYcCQ4dCNzU2BEu9pkkmjGh25jw9cp48+YYsIsK7fFj8eQIS/IL/xm6hm0EQP5
         wviRfGath4OpXPsFNnJo/rKt1tKdIsUXXxMUMyW2HCuucfXws99tCYY/oa/Bwobgu9HU
         h9kw==
X-Gm-Message-State: ABuFfohPyf9/GBUguP633AsCKzEQQVPkkmOIQ3Z3D0fxoy19//kukbmr
        2jbRR3IQDFVqoImJOMxer787B3HqfpT0cUzV9c0=
X-Google-Smtp-Source: ACcGV63lEVgKUbmageLxOBlDCBBo6Cv2w8K78UQDs24uufVLjcV8l/vCvtNzpy9rZR5HgSuwlX+rl4wQPpy/lQ3Bl/U=
X-Received: by 2002:a0c:819c:: with SMTP id 28mr35209820qvd.7.1539956897371;
 Fri, 19 Oct 2018 06:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-14-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-14-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:48:06 +0300
Message-ID: <CAHp75VfDHFVHbxfdQp_Ug9SCx9d0=Rd9vBQYK0kYnok9B_kqrg@mail.gmail.com>
Subject: Re: [PATCH 13/15] power: supply: olpc_battery: Move priv data to a struct
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:24 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The global variables for private data are not too nice. I'd like some
> more, and that would clutter the global name space even further.
>

Good change!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/power/supply/olpc_battery.c | 73 +++++++++++++++--------------
>  1 file changed, 38 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index 540d44bf536f..2a2d7cc995f0 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -53,6 +53,12 @@
>
>  #define BAT_ADDR_MFR_TYPE      0x5F
>
> +struct olpc_battery_data {
> +       struct power_supply *olpc_ac;
> +       struct power_supply *olpc_bat;
> +       char bat_serial[17];
> +};
> +
>  /*********************************************************************
>   *             Power
>   *********************************************************************/
> @@ -91,11 +97,8 @@ static const struct power_supply_desc olpc_ac_desc = {
>         .get_property = olpc_ac_get_prop,
>  };
>
> -static struct power_supply *olpc_ac;
> -
> -static char bat_serial[17]; /* Ick */
> -
> -static int olpc_bat_get_status(union power_supply_propval *val, uint8_t ec_byte)
> +static int olpc_bat_get_status(struct olpc_battery_data *data,
> +               union power_supply_propval *val, uint8_t ec_byte)
>  {
>         if (olpc_platform_info.ecver > 0x44) {
>                 if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
> @@ -326,6 +329,7 @@ static int olpc_bat_get_property(struct power_supply *psy,
>                                  enum power_supply_property psp,
>                                  union power_supply_propval *val)
>  {
> +       struct olpc_battery_data *data = power_supply_get_drvdata(psy);
>         int ret = 0;
>         __be16 ec_word;
>         uint8_t ec_byte;
> @@ -347,7 +351,7 @@ static int olpc_bat_get_property(struct power_supply *psy,
>
>         switch (psp) {
>         case POWER_SUPPLY_PROP_STATUS:
> -               ret = olpc_bat_get_status(val, ec_byte);
> +               ret = olpc_bat_get_status(data, val, ec_byte);
>                 if (ret)
>                         return ret;
>                 break;
> @@ -450,8 +454,8 @@ static int olpc_bat_get_property(struct power_supply *psy,
>                 if (ret)
>                         return ret;
>
> -               sprintf(bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
> -               val->strval = bat_serial;
> +               sprintf(data->bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
> +               val->strval = data->bat_serial;
>                 break;
>         case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>                 ret = olpc_bat_get_voltage_max_design(val);
> @@ -579,17 +583,17 @@ static struct power_supply_desc olpc_bat_desc = {
>         .use_for_apm = 1,
>  };
>
> -static struct power_supply *olpc_bat;
> -
>  static int olpc_battery_suspend(struct platform_device *pdev,
>                                 pm_message_t state)
>  {
> -       if (device_may_wakeup(&olpc_ac->dev))
> +       struct olpc_battery_data *data = platform_get_drvdata(pdev);
> +
> +       if (device_may_wakeup(&data->olpc_ac->dev))
>                 olpc_ec_wakeup_set(EC_SCI_SRC_ACPWR);
>         else
>                 olpc_ec_wakeup_clear(EC_SCI_SRC_ACPWR);
>
> -       if (device_may_wakeup(&olpc_bat->dev))
> +       if (device_may_wakeup(&data->olpc_bat->dev))
>                 olpc_ec_wakeup_set(EC_SCI_SRC_BATTERY | EC_SCI_SRC_BATSOC
>                                    | EC_SCI_SRC_BATERR);
>         else
> @@ -601,7 +605,8 @@ static int olpc_battery_suspend(struct platform_device *pdev,
>
>  static int olpc_battery_probe(struct platform_device *pdev)
>  {
> -       int ret;
> +       struct power_supply_config psy_cfg = {};
> +       struct olpc_battery_data *data;
>         uint8_t status;
>
>         /*
> @@ -620,9 +625,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
>
>         /* Ignore the status. It doesn't actually matter */
>
> -       olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
> -       if (IS_ERR(olpc_ac))
> -               return PTR_ERR(olpc_ac);
> +       psy_cfg.of_node = pdev->dev.of_node;
> +       psy_cfg.drv_data = data;
> +
> +       data->olpc_ac = devm_power_supply_register(&pdev->dev, &olpc_ac_desc, &psy_cfg);
> +       if (IS_ERR(data->olpc_ac))
> +               return PTR_ERR(data->olpc_ac);
> +
>         if (of_property_match_string(pdev->dev.of_node, "compatible",
>                                         "olpc,xo1.5-battery") >= 0) {
>                 /* XO-1.5 */
> @@ -634,42 +643,36 @@ static int olpc_battery_probe(struct platform_device *pdev)
>                 olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
>         }
>
> -       olpc_bat = power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
> -       if (IS_ERR(olpc_bat)) {
> -               ret = PTR_ERR(olpc_bat);
> -               goto battery_failed;
> -       }
> +       data->olpc_bat = devm_power_supply_register(&pdev->dev, &olpc_bat_desc, &psy_cfg);
> +       if (IS_ERR(data->olpc_bat))
> +               return PTR_ERR(data->olpc_bat);
>
> -       ret = device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> +       ret = device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>         if (ret)
> -               goto eeprom_failed;
> +               return ret;
>
> -       ret = device_create_file(&olpc_bat->dev, &olpc_bat_error);
> +       ret = device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
>         if (ret)
>                 goto error_failed;
>
>         if (olpc_ec_wakeup_available()) {
> -               device_set_wakeup_capable(&olpc_ac->dev, true);
> -               device_set_wakeup_capable(&olpc_bat->dev, true);
> +               device_set_wakeup_capable(&data->olpc_ac->dev, true);
> +               device_set_wakeup_capable(&data->olpc_bat->dev, true);
>         }
>
>         return 0;
>
>  error_failed:
> -       device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> -eeprom_failed:
> -       power_supply_unregister(olpc_bat);
> -battery_failed:
> -       power_supply_unregister(olpc_ac);
> +       device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>         return ret;
>  }
>
>  static int olpc_battery_remove(struct platform_device *pdev)
>  {
> -       device_remove_file(&olpc_bat->dev, &olpc_bat_error);
> -       device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> -       power_supply_unregister(olpc_bat);
> -       power_supply_unregister(olpc_ac);
> +       struct olpc_battery_data *data = platform_get_drvdata(pdev);
> +
> +       device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
> +       device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>         return 0;
>  }
>
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
