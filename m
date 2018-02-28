Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935503AbeB1Wgz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:36:55 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42952 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935364AbeB1Wgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:36:52 -0500
X-Google-Smtp-Source: AH8x226bFOBkFzcuW4Uo5LtQ0PsveB7QpxI45ebK0z7TUsBrVmedOK6mvW/SgN7nBMOroeBnNjhAdg==
Date: Wed, 28 Feb 2018 14:36:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [RFC 3/4] hwmon: add Gateworks System Controller support
Message-ID: <20180228223649.GA12887@roeck-us.net>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
 <1519780874-8558-4-git-send-email-tharvey@gateworks.com>
 <69ea679a-91a7-761d-4fa8-2ac4c351fd43@roeck-us.net>
 <CAJ+vNU3U85mwv9_U5O5Xq3o=D7k_63Dwy4xf+bbLiink7pyapQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3U85mwv9_U5O5Xq3o=D7k_63Dwy4xf+bbLiink7pyapQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 01:44:36PM -0800, Tim Harvey wrote:
> On Tue, Feb 27, 2018 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 02/27/2018 05:21 PM, Tim Harvey wrote:
> >>
> >> The Gateworks System Controller has a hwmon sub-component that exposes
> >> up to 16 ADC's, some of which are temperature sensors, others which are
> >> voltage inputs. The ADC configuration (register mapping and name) is
> >> configured via device-tree and varies board to board.
> >>
> >> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >> ---
> >>   drivers/hwmon/Kconfig     |   6 +
> >>   drivers/hwmon/Makefile    |   1 +
> >>   drivers/hwmon/gsc-hwmon.c | 299
> >> ++++++++++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 306 insertions(+)
> >>   create mode 100644 drivers/hwmon/gsc-hwmon.c
> >>
> >> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> >> index 7ad0176..9cdc3cb 100644
> >> --- a/drivers/hwmon/Kconfig
> >> +++ b/drivers/hwmon/Kconfig
> >> @@ -475,6 +475,12 @@ config SENSORS_F75375S
> >>           This driver can also be built as a module.  If so, the module
> >>           will be called f75375s.
> >>   +config SENSORS_GSC
> >> +        tristate "Gateworks System Controller ADC"
> >> +        depends on MFD_GSC
> >> +        help
> >> +          Support for the Gateworks System Controller A/D converters.
> >> +
> >>   config SENSORS_MC13783_ADC
> >>           tristate "Freescale MC13783/MC13892 ADC"
> >>           depends on MFD_MC13XXX
> >> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> >> index 0fe489f..835a536 100644
> >> --- a/drivers/hwmon/Makefile
> >> +++ b/drivers/hwmon/Makefile
> >> @@ -69,6 +69,7 @@ obj-$(CONFIG_SENSORS_G760A)   += g760a.o
> >>   obj-$(CONFIG_SENSORS_G762)    += g762.o
> >>   obj-$(CONFIG_SENSORS_GL518SM) += gl518sm.o
> >>   obj-$(CONFIG_SENSORS_GL520SM) += gl520sm.o
> >> +obj-$(CONFIG_SENSORS_GSC)      += gsc-hwmon.o
> >>   obj-$(CONFIG_SENSORS_GPIO_FAN)        += gpio-fan.o
> >>   obj-$(CONFIG_SENSORS_HIH6130) += hih6130.o
> >>   obj-$(CONFIG_SENSORS_ULTRA45) += ultra45_env.o
> >> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> >> new file mode 100644
> >> index 0000000..3e14bea
> >> --- /dev/null
> >> +++ b/drivers/hwmon/gsc-hwmon.c
> >> @@ -0,0 +1,299 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2018 Gateworks Corporation
> >> + */
> >> +#define DEBUG
> 
> Guenter,
> 
> Thanks for the review!
> 
> >
> >
> > Please no.
> 
> oops - left that in by mistake.
> 
> >
> >> +
> >> +#include <linux/hwmon.h>
> >> +#include <linux/hwmon-sysfs.h>
> >> +#include <linux/mfd/gsc.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/slab.h>
> >> +
> >> +/* map channel to channel info */
> >> +struct gsc_hwmon_ch {
> >> +       u8 reg;
> >> +       char name[32];
> >> +};
> >> +static struct gsc_hwmon_ch gsc_temp_ch[16];
> >
> >
> > 16 temperature channels ...
> 
> It has 16x ADC channels where some can be temperatures and others can
> be voltage inputs (based on device tree).
> 
That was just to point out that you use smaller arrays later on.

> >
> >
> >> +static struct gsc_hwmon_ch gsc_in_ch[16];
> >> +static struct gsc_hwmon_ch gsc_fan_ch[5];
> >> +
> >> +static int
> >> +gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32
> >> attr,
> >> +              int ch, long *val)
> >> +{
> >> +       struct gsc_dev *gsc = dev_get_drvdata(dev);
> >> +       int sz, ret;
> >> +       u8 reg;
> >> +       u8 buf[3];
> >> +
> >> +       dev_dbg(dev, "%s type=%d attr=%d ch=%d\n", __func__, type, attr,
> >> ch);
> >> +       switch (type) {
> >> +       case hwmon_in:
> >> +               sz = 3;
> >> +               reg = gsc_in_ch[ch].reg;
> >> +               break;
> >> +       case hwmon_temp:
> >> +               sz = 2;
> >> +               reg = gsc_temp_ch[ch].reg;
> >> +               break;
> >> +       default:
> >> +               return -EOPNOTSUPP;
> >> +       }
> >> +
> >> +       ret = regmap_bulk_read(gsc->regmap_hwmon, reg, &buf, sz);
> >> +       if (!ret) {
> >> +               *val = 0;
> >> +               while (sz-- > 0)
> >> +                       *val |= (buf[sz] << (8*sz));
> >> +               if ((type == hwmon_temp) && *val > 0x8000)
> >
> >
> > Excessive [and inconsistent] ( )
> >
> > Please make this
> >         if (ret)
> >                 return ret;
> >         ...
> >         return 0;
> 
> understood - a much cleaner pattern
> 
> >
> >
> >> +                       *val -= 0xffff;
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static int
> >> +gsc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> >> +                     u32 attr, int ch, const char **buf)
> >> +{
> >> +       dev_dbg(dev, "%s type=%d attr=%d ch=%d\n", __func__, type, attr,
> >> ch);
> >> +       switch (type) {
> >> +       case hwmon_in:
> >> +       case hwmon_temp:
> >> +       case hwmon_fan:
> >> +               switch (attr) {
> >> +               case hwmon_in_label:
> >> +                       *buf = gsc_in_ch[ch].name;
> >> +                       return 0;
> >> +                       break;
> >> +               case hwmon_temp_label:
> >> +                       *buf = gsc_temp_ch[ch].name;
> >> +                       return 0;
> >> +                       break;
> >> +               case hwmon_fan_label:
> >> +                       *buf = gsc_fan_ch[ch].name;
> >> +                       return 0;
> >> +                       break;
> >
> >
> > return followed by break doesn't make sense.
> 
> right - removed
> 
> >
> >
> >> +               default:
> >> +                       break;
> >> +               }
> >> +               break;
> >> +       default:
> >> +               break;
> >> +       }
> >> +
> >> +       return -ENOTSUPP;
> >> +}
> >> +
> >> +static int
> >> +gsc_hwmon_write(struct device *dev, enum hwmon_sensor_types type, u32
> >> attr,
> >> +              int ch, long val)
> >> +{
> >> +       struct gsc_dev *gsc = dev_get_drvdata(dev);
> >> +       int ret;
> >> +       u8 reg;
> >> +       u8 buf[3];
> >> +
> >> +       dev_dbg(dev, "%s type=%d attr=%d ch=%d\n", __func__, type, attr,
> >> ch);
> >> +       switch (type) {
> >> +       case hwmon_fan:
> >> +               buf[0] = val & 0xff;
> >> +               buf[1] = (val >> 8) & 0xff;
> >> +               reg = gsc_fan_ch[ch].reg;
> >> +               ret = regmap_bulk_write(gsc->regmap_hwmon, reg, &buf, 2);
> >
> >
> >         &buf -> buf
> 
> yikes - thanks for catching that
> 
> >
> >> +               break;
> >> +       default:
> >> +               ret = -EOPNOTSUPP;
> >> +               break;
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static umode_t
> >> +gsc_hwmon_is_visible(const void *_data, enum hwmon_sensor_types type, u32
> >> attr,
> >> +                    int ch)
> >> +{
> >> +       const struct gsc_dev *gsc = _data;
> >> +       struct device *dev = gsc->dev;
> >> +       umode_t mode = 0;
> >> +
> >> +       switch (type) {
> >> +       case hwmon_fan:
> >> +               if (attr == hwmon_fan_input)
> >> +                       mode = (S_IRUGO | S_IWUSR);
> >
> >
> > Unnecessary ( )
> 
> ok
> 
> >
> >
> >> +               break;
> >> +       case hwmon_temp:
> >> +       case hwmon_in:
> >> +               mode = S_IRUGO;
> >> +               break;
> >> +       default:
> >> +               break;
> >> +       }
> >> +       dev_dbg(dev, "%s type=%d attr=%d ch=%d mode=0x%x\n", __func__,
> >> type,
> >> +               attr, ch, mode);
> >> +
> >> +       return mode;
> >> +}
> >> +
> >> +static u32 gsc_in_config[] = {
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       HWMON_I_INPUT,
> >> +       0
> >> +};
> >> +static const struct hwmon_channel_info gsc_in = {
> >> +       .type = hwmon_in,
> >> +       .config = gsc_in_config,
> >> +};
> >> +
> >> +static u32 gsc_temp_config[] = {
> >> +       HWMON_T_INPUT,
> >> +       HWMON_T_INPUT,
> >> +       HWMON_T_INPUT,
> >> +       HWMON_T_INPUT,
> >> +       HWMON_T_INPUT,
> >> +       HWMON_T_INPUT,
> >> +       HWMON_T_INPUT,
> >> +       HWMON_T_INPUT,
> >> +       0
> >
> >
> > ... but this array only has 8+1 elements. This seems inconsistent.
> > How about using some defines for array sizes ?
> >
> > Also, why initialize those arrays ? You are overwriting them below.
> > You could just use a static size array instead.
> >
> > I assume it is guaranteed that there is only exactly one instance
> > of this device in the system. Have you tried what happens if you
> > declare two instances anyway ? The result must be interesting,
> > with all those static variables.
> 
> yes, that static arrays are not very forward-thinking and yes my
> arrays are not consistent. I'll convert to dynamically allocating the
> channels for v2
> 
> >
> >> +};
> >> +static const struct hwmon_channel_info gsc_temp = {
> >> +       .type = hwmon_temp,
> >> +       .config = gsc_temp_config,
> >> +};
> >> +
> >> +static u32 gsc_fan_config[] = {
> >> +       HWMON_F_INPUT,
> >> +       HWMON_F_INPUT,
> >> +       HWMON_F_INPUT,
> >> +       HWMON_F_INPUT,
> >> +       HWMON_F_INPUT,
> >> +       HWMON_F_INPUT,
> >> +       0,
> >> +};
> >
> >
> > The matching gsc_fan_ch has only 5 entries.
> 
> right - certainly an issue
> 
> >
> >
> >> +static const struct hwmon_channel_info gsc_fan = {
> >> +       .type = hwmon_fan,
> >> +       .config = gsc_fan_config,
> >> +};
> >> +
> >> +static const struct hwmon_channel_info *gsc_info[] = {
> >> +       &gsc_temp,
> >> +       &gsc_in,
> >> +       &gsc_fan,
> >> +       NULL
> >> +};
> >> +
> >> +static const struct hwmon_ops gsc_hwmon_ops = {
> >> +       .is_visible = gsc_hwmon_is_visible,
> >> +       .read = gsc_hwmon_read,
> >> +       .read_string = gsc_hwmon_read_string,
> >> +       .write = gsc_hwmon_write,
> >> +};
> >> +
> >> +static const struct hwmon_chip_info gsc_chip_info = {
> >> +       .ops = &gsc_hwmon_ops,
> >> +       .info = gsc_info,
> >> +};
> >> +
> >> +static int gsc_hwmon_probe(struct platform_device *pdev)
> >> +{
> >> +       struct gsc_dev *gsc = dev_get_drvdata(pdev->dev.parent);
> >> +       struct device_node *np;
> >> +       struct device *hwmon;
> >> +       int temp_count = 0;
> >> +       int in_count = 0;
> >> +       int fan_count = 0;
> >> +       int ret;
> >> +
> >> +       dev_dbg(&pdev->dev, "%s\n", __func__);
> >
> >
> > You declare local 'dev' variables all over the place, except here,
> > where it would actually be used multiple times.
> >
> > Please either declare one here as well, or drop all the others.
> 
> will do
> 
> >
> >> +       np = of_get_next_child(pdev->dev.of_node, NULL);
> >> +       while (np) {
> >> +               u32 reg, type;
> >> +               const char *label;
> >> +
> >> +               of_property_read_u32(np, "reg", &reg);
> >> +               of_property_read_u32(np, "type", &type);
> >> +               label = of_get_property(np, "label", NULL);
> >
> >
> > It must be interesting to see what happens if no 'label' property
> > is provided. Have you tried ? Also, no validation of 'reg' and 'type' ?
> > Are you sure ?
> 
> will add validation
> 
> >
> >> +               switch(type) {
> >> +               case 0: /* temperature sensor */
> >> +                       gsc_temp_config[temp_count] = HWMON_T_INPUT |
> >> +                                                     HWMON_T_LABEL;
> >> +                       gsc_temp_ch[temp_count].reg = reg;
> >> +                       strncpy(gsc_temp_ch[temp_count].name, label, 32);
> >
> >
> > This leaves the string unterminated if it is too long. Have you tested
> > what happens in this situation ? Consider using strlcpy instead.
> >
> > Also please use sizeof() instead of '32'.
> 
> ok
> 
> >
> >> +                       if (temp_count < ARRAY_SIZE(gsc_temp_config))
> >> +                               temp_count++;
> >
> >
> > I would suggest to abort with EINVAL if this happens. Otherwise the last
> > entry
> > is overwritten, which doesn't make much sense. Also, this accepts up to
> > ARRAY_SIZE()
> > entries, leaving no termination.
> >
> >> +                       break;
> >> +               case 1: /* voltage sensor */
> >> +                       gsc_in_config[in_count] = HWMON_I_INPUT |
> >> +                                                 HWMON_I_LABEL;
> >> +                       gsc_in_ch[in_count].reg = reg;
> >
> >
> > So a reg value of 0xXXyy is auto-converted to 0xYY ?
> 
> Do you mean stuffing a u32 into a u8?
> 

That is what you do, isn't it ? So reg=0xffff and reg=0xfeff will both
map to 0xff. Or, in other word, the code happily accepts invalid values
and converts them into something else.

> >
> >> +                       strncpy(gsc_in_ch[in_count].name, label, 32);
> >> +                       if (in_count < ARRAY_SIZE(gsc_in_config))
> >> +                               in_count++;
> >> +                       break;
> >> +               case 2: /* fan controller setpoint */
> >> +                       gsc_fan_config[fan_count] = HWMON_F_INPUT |
> >> +                                                   HWMON_F_LABEL;
> >> +                       gsc_fan_ch[fan_count].reg = reg;
> >
> >
> > It is going to be interesting to see what happens if there are more than
> > 5 such entries.
> 
> will fix
> 
> >
> >> +                       strncpy(gsc_fan_ch[fan_count].name, label, 32);
> >> +                       if (fan_count < ARRAY_SIZE(gsc_fan_config))
> >> +                               fan_count++;
> >> +                       break;
> >
> >
> > All other types are silently ignored ?
> 
> will fix
> 
> >
> >> +               }
> >> +               np = of_get_next_child(pdev->dev.of_node, np);
> >> +       }
> >> +       /* terminate list */
> >> +       gsc_in_config[in_count] = 0;
> >> +       gsc_temp_config[temp_count] = 0;
> >> +       gsc_fan_config[fan_count] = 0;
> >> +
> >
> > I would suggest to move above code into a separate function.
> 
> will do
> 
> >
> >> +       hwmon = devm_hwmon_device_register_with_info(&pdev->dev,
> >> +                                                    KBUILD_MODNAME, gsc,
> >> +                                                    &gsc_chip_info,
> >> NULL);
> >> +       if (IS_ERR(hwmon)) {
> >> +               ret = PTR_ERR(hwmon);
> >> +               dev_err(&pdev->dev, "Unable to register hwmon device:
> >> %d\n",
> >> +                       ret);
> >> +               return ret;
> >> +       }
> >
> >
> > The error would be ENOMEM. Is it necessary to report that again ?
> 
> could also return -EINVAL but not with the args I'm passing in so I'll
> change it to:
> return PTR_ERR_OR_ZERO(hwmon);
> 
Much preferred.

Thanks,
Guenter
