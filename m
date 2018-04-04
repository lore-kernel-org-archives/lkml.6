Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDDID3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:03:29 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40561 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeDDID1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:03:27 -0400
X-Google-Smtp-Source: AIpwx4+/vBvikJknbpas9UZDD0TaO/kSwV9d47fEhqD8g8UkNhE5LrsHT9WZ5HFhesuQkAp32woNQNAhlOvoYiJM9ko=
MIME-Version: 1.0
In-Reply-To: <20180328110330.y4pq5mhm73jfq6j6@dell>
References: <20180320122751.14019-1-enric.balletbo@collabora.com>
 <20180320122751.14019-6-enric.balletbo@collabora.com> <20180328110330.y4pq5mhm73jfq6j6@dell>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Wed, 4 Apr 2018 10:03:26 +0200
Message-ID: <CAFqH_53j2CwxmLwvaK8mrroEtKz7ZBEmRdr3Db6-dunWyqYw8A@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] mfd: cros_ec_dev: Register cros_ec_accel_legacy
 driver as a subdevice.
To: Lee Jones <lee.jones@linaro.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, kernel@collabora.com,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3483ams031436

Hi Lee,

2018-03-28 13:03 GMT+02:00 Lee Jones <lee.jones@linaro.org>:
> On Tue, 20 Mar 2018, Enric Balletbo i Serra wrote:
>
>> With this patch, the cros_ec_ctl driver will register the legacy
>> accelerometer driver (named cros_ec_accel_legacy) if it fails to
>> register sensors through the usual path cros_ec_sensors_register().
>> This legacy device is present on Chromebook devices with older EC
>> firmware only supporting deprecated EC commands (Glimmer based devices).
>>
>> Tested-by: Gwendal Grignou <gwendal@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>>
>> Changes in v4:
>> - [5/8] Nit: EC -> ECs (Lee Jones)
>> - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)
>>
>> Changes in v3:
>> - [5/8] Add the Reviewed-by Andy Shevchenko.
>>
>> Changes in v2:
>> - [5/8] Add the Reviewed-by Gwendal.
>>
>>  drivers/mfd/cros_ec_dev.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>
>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
>> index f60a53f11942..0d541d59d6f5 100644
>> --- a/drivers/mfd/cros_ec_dev.c
>> +++ b/drivers/mfd/cros_ec_dev.c
>> @@ -389,6 +389,73 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>>       kfree(msg);
>>  }
>>
>> +static struct cros_ec_sensor_platform sensor_platforms[] = {
>> +     {
>> +             .sensor_num = 0,
>> +     },
>> +     {
>> +             .sensor_num = 1,
>> +     }
>> +};
>
> Also no need to be so many  lines.
>
> Each one of these entries can be placed on a single line.
>
> And there's no need for a comma if there is nothing to separate.
>
>         { .sensor_num = 0 },
>         { .sensor_num = 1 }
>
> Also, this seems like a pretty pointless struct.
>
> What is the sensor_num property used for?
>
> Why does it care what sensor number it is?
>

I thought that was used but after look again I didn't see where, so
seems that you have reason and this struct is pointless. I'll remove
this and the .id in the cells, we can always send a patch later
introducing this if I am missing something. I'll send another version.

Thanks,
  Enric

>> +static const struct mfd_cell cros_ec_accel_legacy_cells[] = {
>> +     {
>> +             .name = "cros-ec-accel-legacy",
>> +             .id = 0,
>
> What are you using this for?
>
>> +             .platform_data = &sensor_platforms[0],
>> +             .pdata_size = sizeof(struct cros_ec_sensor_platform),
>> +     },
>> +     {
>> +             .name = "cros-ec-accel-legacy",
>> +             .id = 1,
>
> And this?
>
>> +             .platform_data = &sensor_platforms[1],
>> +             .pdata_size = sizeof(struct cros_ec_sensor_platform),
>> +     }
>> +};
>> +
>> +static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
>> +{
>> +     struct cros_ec_device *ec_dev = ec->ec_dev;
>> +     u8 status;
>> +     int ret;
>> +
>> +     /*
>> +      * ECs that need legacy support are the main EC, directly connected to
>> +      * the AP.
>> +      */
>> +     if (ec->cmd_offset != 0)
>> +             return;
>> +
>> +     /*
>> +      * Check if EC supports direct memory reads and if EC has
>> +      * accelerometers.
>> +      */
>> +     if (!ec_dev->cmd_readmem)
>> +             return;
>> +
>> +     ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS, 1, &status);
>> +     if (ret < 0) {
>> +             dev_warn(ec->dev, "EC does not support direct reads.\n");
>> +             return;
>> +     }
>> +
>> +     /* Check if EC has accelerometers. */
>> +     if (!(status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
>> +             dev_info(ec->dev, "EC does not have accelerometers.\n");
>> +             return;
>> +     }
>> +
>> +     /*
>> +      * Register 2 accelerometers
>> +      */
>> +     ret = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
>> +                           cros_ec_accel_legacy_cells,
>> +                           ARRAY_SIZE(cros_ec_accel_legacy_cells),
>> +                           NULL, 0, NULL);
>> +     if (ret)
>> +             dev_err(ec_dev->dev, "failed to add EC sensors\n");
>> +}
>> +
>>  static const struct mfd_cell cros_ec_rtc_cells[] = {
>>       {
>>               .name = "cros-ec-rtc",
>> @@ -442,6 +509,9 @@ static int ec_device_probe(struct platform_device *pdev)
>>       /* check whether this EC is a sensor hub. */
>>       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>>               cros_ec_sensors_register(ec);
>> +     else
>> +             /* Workaroud for older EC firmware */
>> +             cros_ec_accel_legacy_register(ec);
>>
>>       /* Check whether this EC instance has RTC host command support */
>>       if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
>
> --
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
