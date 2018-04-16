Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755031AbeDPNVD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:21:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37312 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbeDPNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:21:01 -0400
X-Google-Smtp-Source: AIpwx49JR5yMZRDOzsUM12SYYx5kYzqBhA6kC94Ay82mIv/HEeRx8oPIqTtdFQROU8nNGLWtpa4opA==
Date: Mon, 16 Apr 2018 14:20:55 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, kernel@collabora.com,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/8] mfd: cros_ec_dev: Register cros_ec_accel_legacy
 driver as a subdevice.
Message-ID: <20180416132055.udgkpge6poaqix3z@dell>
References: <20180320122751.14019-1-enric.balletbo@collabora.com>
 <20180320122751.14019-6-enric.balletbo@collabora.com>
 <20180328110330.y4pq5mhm73jfq6j6@dell>
 <CAFqH_53j2CwxmLwvaK8mrroEtKz7ZBEmRdr3Db6-dunWyqYw8A@mail.gmail.com>
 <CAFqH_50f-NZCd8up8U1djMBO-8znxGK7rcEuWh6ahyvypF8D+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_50f-NZCd8up8U1djMBO-8znxGK7rcEuWh6ahyvypF8D+A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Apr 2018, Enric Balletbo Serra wrote:

> Hi again,
> 
> 2018-04-04 10:03 GMT+02:00 Enric Balletbo Serra <eballetbo@gmail.com>:
> > Hi Lee,
> >
> > 2018-03-28 13:03 GMT+02:00 Lee Jones <lee.jones@linaro.org>:
> >> On Tue, 20 Mar 2018, Enric Balletbo i Serra wrote:
> >>
> >>> With this patch, the cros_ec_ctl driver will register the legacy
> >>> accelerometer driver (named cros_ec_accel_legacy) if it fails to
> >>> register sensors through the usual path cros_ec_sensors_register().
> >>> This legacy device is present on Chromebook devices with older EC
> >>> firmware only supporting deprecated EC commands (Glimmer based devices).
> >>>
> >>> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> >>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> >>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >>> ---
> >>>
> >>> Changes in v4:
> >>> - [5/8] Nit: EC -> ECs (Lee Jones)
> >>> - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)
> >>>
> >>> Changes in v3:
> >>> - [5/8] Add the Reviewed-by Andy Shevchenko.
> >>>
> >>> Changes in v2:
> >>> - [5/8] Add the Reviewed-by Gwendal.
> >>>
> >>>  drivers/mfd/cros_ec_dev.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 70 insertions(+)
> >>>
> >>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> >>> index f60a53f11942..0d541d59d6f5 100644
> >>> --- a/drivers/mfd/cros_ec_dev.c
> >>> +++ b/drivers/mfd/cros_ec_dev.c
> >>> @@ -389,6 +389,73 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> >>>       kfree(msg);
> >>>  }
> >>>
> >>> +static struct cros_ec_sensor_platform sensor_platforms[] = {
> >>> +     {
> >>> +             .sensor_num = 0,
> >>> +     },
> >>> +     {
> >>> +             .sensor_num = 1,
> >>> +     }
> >>> +};
> >>
> >> Also no need to be so many  lines.
> >>
> >> Each one of these entries can be placed on a single line.
> >>
> >> And there's no need for a comma if there is nothing to separate.
> >>
> >>         { .sensor_num = 0 },
> >>         { .sensor_num = 1 }
> >>
> >> Also, this seems like a pretty pointless struct.
> >>
> >> What is the sensor_num property used for?
> >>
> >> Why does it care what sensor number it is?
> >>
> >
> > I thought that was used but after look again I didn't see where, so
> > seems that you have reason and this struct is pointless. I'll remove
> > this and the .id in the cells, we can always send a patch later
> > introducing this if I am missing something. I'll send another version.
> >
> 
> Ok, forget what I said.
> 
> Actually, sensor_num is used by the cros_ec_legacy driver to get the
> right sensor properties from the EC and to get the sensor data from
> the EC, sensor_num is the offset passed to the EC read command.

I'm sure that it is being used, but my question is, why?

Passing a 0 and a 1 to a child driver seems like a pointless exercise
to me.  We do not usually enumerate devices like this with platform
data.  Do these values ever change, or are they simply used to
enumerate 2 devices which are always called 0 and 1?

> .id is not used but as there are two accelerometers that use the same
> driver, shouldn't we set the id (or I am missing something)?
> 
> +static const struct mfd_cell cros_ec_accel_legacy_cells[] = {
> +     { .name = "cros-ec-accel-legacy", .id = 0 },
> +     { .name = "cros-ec-accel-legacy", .id = 1 },
> + };

I think you need to understand what MFD/Platform code does with these
IDs.  Take a look at the MFD/Platform core code to enlighten
yourself.  If there's anything you then do not understand, please
ask and I'll try to fill in the gaps.

> >>> +static const struct mfd_cell cros_ec_accel_legacy_cells[] = {
> >>> +     {
> >>> +             .name = "cros-ec-accel-legacy",
> >>> +             .id = 0,
> >>
> >> What are you using this for?
> >>
> >>> +             .platform_data = &sensor_platforms[0],
> >>> +             .pdata_size = sizeof(struct cros_ec_sensor_platform),
> >>> +     },
> >>> +     {
> >>> +             .name = "cros-ec-accel-legacy",
> >>> +             .id = 1,
> >>
> >> And this?
> >>
> >>> +             .platform_data = &sensor_platforms[1],
> >>> +             .pdata_size = sizeof(struct cros_ec_sensor_platform),
> >>> +     }
> >>> +};
> >>> +
> >>> +static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
> >>> +{
> >>> +     struct cros_ec_device *ec_dev = ec->ec_dev;
> >>> +     u8 status;
> >>> +     int ret;
> >>> +
> >>> +     /*
> >>> +      * ECs that need legacy support are the main EC, directly connected to
> >>> +      * the AP.
> >>> +      */
> >>> +     if (ec->cmd_offset != 0)
> >>> +             return;
> >>> +
> >>> +     /*
> >>> +      * Check if EC supports direct memory reads and if EC has
> >>> +      * accelerometers.
> >>> +      */
> >>> +     if (!ec_dev->cmd_readmem)
> >>> +             return;
> >>> +
> >>> +     ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS, 1, &status);
> >>> +     if (ret < 0) {
> >>> +             dev_warn(ec->dev, "EC does not support direct reads.\n");
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     /* Check if EC has accelerometers. */
> >>> +     if (!(status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
> >>> +             dev_info(ec->dev, "EC does not have accelerometers.\n");
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     /*
> >>> +      * Register 2 accelerometers
> >>> +      */
> >>> +     ret = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> >>> +                           cros_ec_accel_legacy_cells,
> >>> +                           ARRAY_SIZE(cros_ec_accel_legacy_cells),
> >>> +                           NULL, 0, NULL);
> >>> +     if (ret)
> >>> +             dev_err(ec_dev->dev, "failed to add EC sensors\n");
> >>> +}
> >>> +
> >>>  static const struct mfd_cell cros_ec_rtc_cells[] = {
> >>>       {
> >>>               .name = "cros-ec-rtc",
> >>> @@ -442,6 +509,9 @@ static int ec_device_probe(struct platform_device *pdev)
> >>>       /* check whether this EC is a sensor hub. */
> >>>       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
> >>>               cros_ec_sensors_register(ec);
> >>> +     else
> >>> +             /* Workaroud for older EC firmware */
> >>> +             cros_ec_accel_legacy_register(ec);
> >>>
> >>>       /* Check whether this EC instance has RTC host command support */
> >>>       if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
> >>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
