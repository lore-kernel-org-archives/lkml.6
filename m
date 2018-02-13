Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933952AbeBMPyz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:54:55 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37997 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933440AbeBMPyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:54:52 -0500
X-Google-Smtp-Source: AH8x227EMyU4gVQTVm5FP1krBVCQA0AnTI82EI+JN7b+7AITYXLO4I7yi8O3tOdzvt6seR+ElOOqqUjiF76QAM2nfBg=
MIME-Version: 1.0
In-Reply-To: <20180212185915.25041-1-david.daney@cavium.com>
References: <20180212185915.25041-1-david.daney@cavium.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 17:54:50 +0200
Message-ID: <CAHp75VeMhKvv0SdMgy+ZdLcK7+aOTyKweg9VKOTYcb84vsn+NA@mail.gmail.com>
Subject: Re: [PATCH] rtc: isl12026: Add driver.
To: David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 8:59 PM, David Daney <david.daney@cavium.com> wrote:
> The ISL12026 is a combination RTC and EEPROM device with I2C
> interface.  The standard RTC driver interface is provided.  The EEPROM
> is accessed via the NVMEM interface via the "eeprom0" directory in the
> sysfs entry for the device.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  .../devicetree/bindings/rtc/isil,isl12026.txt      |  27 +
>  drivers/rtc/Kconfig                                |   9 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-isl12026.c                         | 550 +++++++++++++++++++++
>  4 files changed, 587 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12026.txt
>  create mode 100644 drivers/rtc/rtc-isl12026.c
>
> diff --git a/Documentation/devicetree/bindings/rtc/isil,isl12026.txt b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
> new file mode 100644
> index 000000000000..4b6c7177a95a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
> @@ -0,0 +1,27 @@
> +ISL12026 I2C RTC/EEPROM
> +
> +ISL12026 is an I2C RTC/EEPROM combination device.  The RTC and control
> +registers respond at bus address 0x6f, and the EEPROM array responds
> +at bus address 0x57.  The canonical "reg" value will be for the RTC portion.
> +
> +Required properties supported by the device:
> +
> + - "compatible": must be "isil,isl12026"
> + - "reg": I2C bus address of the device (always 0x6f)
> +
> +Optional properties:
> +
> + - "isil,pwr-bsw": If present PWR.BSW bit must be set to the specified
> +                   value for proper operation.
> +
> + - "isil,pwr-sbib": If present PWR.SBIB bit must be set to the specified
> +                    value for proper operation.
> +
> +
> +Example:
> +
> +       rtc@6f {
> +               reg = <0x6f>;
> +               isil,pwr-bsw = <0>;
> +               isil,pwr-sbib = <1>;
> +       }
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 8ab5f0a5d323..85171e9e3ada 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -407,6 +407,15 @@ config RTC_DRV_ISL12022
>           This driver can also be built as a module. If so, the module
>           will be called rtc-isl12022.
>
> +config RTC_DRV_ISL12026
> +       tristate "Intersil ISL12026"
> +       help
> +         If you say yes here you get support for the
> +         Intersil ISL12026 RTC chip.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called rtc-isl12026.
> +
>  config RTC_DRV_X1205
>         tristate "Xicor/Intersil X1205"
>         help
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 4fbf87e45a7c..f481661a6eae 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
>  obj-$(CONFIG_RTC_DRV_HYM8563)  += rtc-hym8563.o
>  obj-$(CONFIG_RTC_DRV_IMXDI)    += rtc-imxdi.o
>  obj-$(CONFIG_RTC_DRV_ISL12022) += rtc-isl12022.o
> +obj-$(CONFIG_RTC_DRV_ISL12026) += rtc-isl12026.o
>  obj-$(CONFIG_RTC_DRV_ISL1208)  += rtc-isl1208.o
>  obj-$(CONFIG_RTC_DRV_JZ4740)   += rtc-jz4740.o
>  obj-$(CONFIG_RTC_DRV_LP8788)   += rtc-lp8788.o
> diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
> new file mode 100644
> index 000000000000..a5f04e0faceb
> --- /dev/null
> +++ b/drivers/rtc/rtc-isl12026.c
> @@ -0,0 +1,550 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * An I2C driver for the Intersil ISL 12026
> + *
> + * Copyright (c) 2018 Cavium, Inc.
> + */

> +#include <linux/types.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/bcd.h>
> +#include <linux/i2c.h>
> +#include <linux/rtc.h>
> +#include <linux/of.h>

Perhaps in alphabetical order.

> +/* register offsets */
> +#define ISL12026_REG_SC                0x30
> +
> +#define ISL12026_REG_SR                0x3f
> +# define ISL12026_REG_SR_RTCF  BIT(0)
> +# define ISL12026_REG_SR_WEL   BIT(1)
> +# define ISL12026_REG_SR_RWEL  BIT(2)
> +# define ISL12026_REG_SR_MBZ   BIT(3)
> +# define ISL12026_REG_SR_OSCF  BIT(4)
> +
> +/* ISL register bits */
> +#define ISL12026_HR_MIL                BIT(7)  /* military or 24 hour time */
> +

> +#define ISL12026_REG_PWR       0x14

Perhaps keep it ordered? (0x14 < 0x30 obviously)

> +# define ISL12026_REG_PWR_BSW  BIT(6)
> +# define ISL12026_REG_PWR_SBIB BIT(7)

> +#define ISL12026_PAGESIZE 16
> +#define ISL12026_NVMEM_WRITE_TIME 20
> +
> +struct isl12026 {
> +       struct rtc_device *rtc;
> +       struct i2c_client *nvm_client;
> +       struct nvmem_device *nvm_dev;
> +       struct nvmem_config nvm_cfg;
> +       /*
> +        * RTC write operations require that multiple messages be
> +        * transmitted, we hold the lock for all accesses to the
> +        * device so that these sequences cannot be disrupted.  Also,
> +        * the write cycle to the nvmem takes many mS during which the
> +        * device does not respond to commands, so holding the lock
> +        * also prevents access during these times.
> +        */
> +       struct mutex lock;
> +};
> +
> +static int isl12026_read_reg(struct i2c_client *client, int reg)
> +{
> +       struct isl12026 *priv = i2c_get_clientdata(client);
> +       u8 addr[] = {0, reg};
> +       u8 val;
> +       int ret;
> +
> +       struct i2c_msg msgs[] = {
> +               {
> +                       .addr   = client->addr,
> +                       .flags  = 0,
> +                       .len    = sizeof(addr),
> +                       .buf    = addr
> +               },
> +               {
> +                       .addr   = client->addr,
> +                       .flags  = I2C_M_RD,
> +                       .len    = 1,
> +                       .buf    = &val
> +               }
> +       };
> +
> +       mutex_lock(&priv->lock);
> +
> +       ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +
> +       mutex_unlock(&priv->lock);
> +
> +       if (ret != ARRAY_SIZE(msgs)) {
> +               dev_err(&client->dev, "read reg error, ret=%d\n", ret);
> +               return -EIO;
> +       }
> +       return val;
> +}
> +
> +static int isl12026_write_reg(struct i2c_client *client, int reg, u8 val)
> +{
> +       struct isl12026 *priv = i2c_get_clientdata(client);
> +       int rv = 0;
> +       u8 op[3];
> +
> +       struct i2c_msg msg = {
> +               .addr   = client->addr,
> +               .flags  = 0,
> +               .len    = 1,
> +               .buf    = op
> +       };
> +
> +       int ret;
> +
> +       mutex_lock(&priv->lock);
> +
> +       /* Set SR.WEL */
> +       op[0] = 0;
> +       op[1] = ISL12026_REG_SR;
> +       op[2] = ISL12026_REG_SR_WEL;
> +       msg.len = 3;
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret != 1) {
> +               dev_err(&client->dev, "write error SR.WEL, ret=%d\n", ret);
> +               rv = -EIO;
> +               goto out;
> +       }
> +
> +       /* Set SR.WEL and SR.RWEL */
> +       op[2] = ISL12026_REG_SR_WEL | ISL12026_REG_SR_RWEL;
> +       msg.len = 3;
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret != 1) {
> +               dev_err(&client->dev,
> +                       "write error SR.WEL|SR.RWEL, ret=%d\n", ret);
> +               rv = -EIO;
> +               goto out;
> +       }
> +
> +       op[1] = reg;
> +       op[2] = val;
> +       msg.len = 3;
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret != 1) {
> +               dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
> +               rv = -EIO;
> +               goto out;
> +       }
> +
> +       msleep(ISL12026_NVMEM_WRITE_TIME);
> +
> +       /* Clear SR.WEL and SR.RWEL */
> +       op[1] = ISL12026_REG_SR;
> +       op[2] = 0;
> +       msg.len = 3;
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret != 1) {
> +               dev_err(&client->dev, "write error SR, ret=%d\n", ret);
> +               rv = -EIO;
> +               goto out;
> +       }
> +
> +out:
> +       mutex_unlock(&priv->lock);
> +
> +       return rv;
> +}
> +
> +static int isl12026_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct isl12026 *priv = i2c_get_clientdata(client);

> +       int rv = 0;

> +       u8 op[10];
> +
> +       struct i2c_msg msg = {
> +               .addr   = client->addr,
> +               .flags  = 0,
> +               .len    = 1,
> +               .buf    = op
> +       };

> +

Redundant.

> +       int ret;

rv, ret, ... ???

> +
> +       mutex_lock(&priv->lock);
> +
> +       /* Set SR.WEL */
> +       op[0] = 0;
> +       op[1] = ISL12026_REG_SR;
> +       op[2] = ISL12026_REG_SR_WEL;
> +       msg.len = 3;

> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret != 1) {

Can it return < 0? If so, why do you shadow the error code?

> +               dev_err(&client->dev, "write error SR.WEL, ret=%d\n", ret);
> +               rv = -EIO;
> +               goto out;
> +       }

> +
> +       /* Set SR.WEL and SR.RWEL */
> +       op[2] = ISL12026_REG_SR_WEL | ISL12026_REG_SR_RWEL;
> +       msg.len = 3;
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret != 1) {
> +               dev_err(&client->dev,
> +                       "write error SR.WEL|SR.RWEL, ret=%d\n", ret);
> +               rv = -EIO;
> +               goto out;
> +       }
> +
> +       /* Set the CCR registers */
> +       op[1] = ISL12026_REG_SC;
> +       op[2] = bin2bcd(tm->tm_sec); /* SC */
> +       op[3] = bin2bcd(tm->tm_min); /* MN */
> +       op[4] = bin2bcd(tm->tm_hour) | ISL12026_HR_MIL; /* HR */
> +       op[5] = bin2bcd(tm->tm_mday); /* DT */
> +       op[6] = bin2bcd(tm->tm_mon + 1); /* MO */
> +       op[7] = bin2bcd(tm->tm_year % 100); /* YR */
> +       op[8] = bin2bcd(tm->tm_wday & 7); /* DW */
> +       op[9] = bin2bcd(tm->tm_year >= 100 ? 20 : 19); /* Y2K */
> +       msg.len = 10;
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret != 1) {
> +               dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
> +               rv = -EIO;
> +               goto out;
> +       }
> +
> +       /* Clear SR.WEL and SR.RWEL */
> +       op[1] = ISL12026_REG_SR;
> +       op[2] = 0;
> +       msg.len = 3;
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret != 1) {
> +               dev_err(&client->dev, "write error SR, ret=%d\n", ret);
> +               rv = -EIO;
> +               goto out;
> +       }
> +
> +out:
> +       mutex_unlock(&priv->lock);
> +
> +       return rv;
> +}
> +
> +static int isl12026_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct isl12026 *priv = i2c_get_clientdata(client);
> +       u8 ccr[8];
> +       u8 addr[2];
> +       u8 sr;
> +       int ret;
> +       int rv = 0;
> +
> +       struct i2c_msg msgs[] = {
> +               {
> +                       .addr   = client->addr,
> +                       .flags  = 0,
> +                       .len    = sizeof(addr),
> +                       .buf    = addr
> +               },
> +               {
> +                       .addr   = client->addr,
> +                       .flags  = I2C_M_RD,
> +               }
> +       };
> +
> +       mutex_lock(&priv->lock);
> +
> +       /* First, read SR */
> +       addr[0] = 0;
> +       addr[1] = ISL12026_REG_SR;
> +       msgs[1].len = 1;
> +       msgs[1].buf = &sr;
> +
> +       ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +       if (ret != ARRAY_SIZE(msgs)) {
> +               dev_err(&client->dev, "read error, ret=%d\n", ret);
> +               rv = -EIO;
> +               goto out;
> +       }
> +

> +       if (sr & ISL12026_REG_SR_RTCF)
> +               dev_warn(&client->dev, "Real-Time Clock Failure on read\n");
> +       if (sr & ISL12026_REG_SR_OSCF)
> +               dev_warn(&client->dev, "Oscillator Failure on read\n");

Can you get them together?
if not, perhaps consider 'else' keyword.

> +
> +       /* Second, CCR regs */
> +       addr[0] = 0;
> +       addr[1] = ISL12026_REG_SC;
> +       msgs[1].len = sizeof(ccr);
> +       msgs[1].buf = ccr;
> +
> +       ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +       if (ret != ARRAY_SIZE(msgs)) {
> +               dev_err(&client->dev, "read error, ret=%d\n", ret);
> +               rv = -EIO;
> +               goto out;
> +       }
> +

> +       dev_dbg(&client->dev,
> +               "raw data is sec=%02x, min=%02x, hr=%02x, mday=%02x, mon=%02x, year=%02x, wday=%02x, y2k=%02x\n",
> +               ccr[0], ccr[1], ccr[2], ccr[3],
> +               ccr[4], ccr[5], ccr[6], ccr[7]);

Ouch.

> +
> +       tm->tm_sec = bcd2bin(ccr[0] & 0x7F);
> +       tm->tm_min = bcd2bin(ccr[1] & 0x7F);
> +       if (ccr[2] & ISL12026_HR_MIL)
> +               tm->tm_hour = bcd2bin(ccr[2] & 0x3F);
> +       else
> +               tm->tm_hour = bcd2bin(ccr[2] & 0x1F) +
> +                       ((ccr[2] & 0x20) ? 12 : 0);
> +       tm->tm_mday = bcd2bin(ccr[3] & 0x3F);
> +       tm->tm_mon = bcd2bin(ccr[4] & 0x1F) - 1;
> +       tm->tm_year = bcd2bin(ccr[5]);
> +       if (bcd2bin(ccr[7]) == 20)
> +               tm->tm_year += 100;
> +       tm->tm_wday = ccr[6] & 0x07;
> +
> +       dev_dbg(&client->dev, "secs=%d, mins=%d, hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
> +               tm->tm_sec, tm->tm_min, tm->tm_hour,
> +               tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
> +       rv = rtc_valid_tm(tm);

> +out:
> +       mutex_unlock(&priv->lock);

Here one pattern, below another...

Hey, you have to learn being consistent.

> +       return rv;
> +}
> +
> +static const struct rtc_class_ops isl12026_rtc_ops = {
> +       .read_time      = isl12026_rtc_read_time,
> +       .set_time       = isl12026_rtc_set_time,
> +};
> +
> +static int isl12026_nvm_read(void *p, unsigned int offset,
> +                            void *val, size_t bytes)
> +{
> +       struct isl12026 *priv = p;
> +       int r;
> +       u8 addr[2];
> +       struct i2c_msg msgs[] = {
> +               {
> +                       .addr   = priv->nvm_client->addr,
> +                       .flags  = 0,
> +                       .len    = sizeof(addr),
> +                       .buf    = addr
> +               },
> +               {
> +                       .addr   = priv->nvm_client->addr,
> +                       .flags  = I2C_M_RD,
> +                       .buf    = val
> +               }
> +       };
> +
> +       if (offset >= priv->nvm_cfg.size)
> +               return 0; /* End-of-file */
> +       if (offset + bytes > priv->nvm_cfg.size)
> +               bytes = priv->nvm_cfg.size - offset;
> +

> +       addr[0] = (offset >> 8) & 0xff;
> +       addr[1] = offset & 0xff;

Useless & 0xff:s.

Isn't endianess handled by i2c core?

> +       msgs[1].len = bytes;
> +       mutex_lock(&priv->lock);

> +       r = i2c_transfer(priv->nvm_client->adapter, msgs, ARRAY_SIZE(msgs));
> +
> +       mutex_unlock(&priv->lock);
> +
> +       if (r != ARRAY_SIZE(msgs)) {

A bit unusual pattern,

what about

mutex_lock();
r = ...;
if (r...) {
 ...
 mutex_unlock();
 return -Exxx;
}
mutex_unlock();

?

> +               dev_err(priv->nvm_cfg.dev, "nvmem read error, ret=%d\n", r);
> +               return -EIO;
> +       }
> +
> +       return bytes;
> +}
> +
> +static int isl12026_nvm_write(void *p, unsigned int offset,
> +                             void *val, size_t bytes)
> +{
> +       struct isl12026 *priv = p;

> +       int r;

Use consistent style, either r everywhere, or ret, or rc, or rval.

> +       u8 *v = val;
> +       size_t chunk_size, num_written;
> +       u8 payload[ISL12026_PAGESIZE + 2]; /* page + 2 address bytes */
> +       struct i2c_msg msgs[] = {
> +               {
> +                       .addr   = priv->nvm_client->addr,
> +                       .flags  = 0,
> +                       .buf    = payload
> +               }
> +       };
> +
> +       if (offset >= priv->nvm_cfg.size)
> +               return 0; /* End-of-file */
> +       if (offset + bytes > priv->nvm_cfg.size)
> +               bytes = priv->nvm_cfg.size - offset;
> +
> +       mutex_lock(&priv->lock);
> +
> +       num_written = 0;
> +       while (bytes) {
> +               chunk_size = round_down(offset, ISL12026_PAGESIZE) +
> +                       ISL12026_PAGESIZE - offset;
> +               chunk_size = min(bytes, chunk_size);
> +               memcpy(payload + 2, v + num_written, chunk_size);

> +               payload[0] = (offset >> 8) & 0xff;
> +               payload[1] = offset & 0xff;

Useless & 0xff:s.

Isn't endianess handled by i2c core?

> +               msgs[0].len = chunk_size + 2;
> +               r = i2c_transfer(priv->nvm_client->adapter,
> +                                msgs, ARRAY_SIZE(msgs));
> +               if (r != ARRAY_SIZE(msgs)) {
> +                       dev_err(priv->nvm_cfg.dev,
> +                               "nvmem write error, ret=%d\n", r);
> +                       break;
> +               }
> +               bytes -= chunk_size;
> +               offset += chunk_size;
> +               num_written += chunk_size;
> +               msleep(ISL12026_NVMEM_WRITE_TIME);
> +       }
> +
> +       mutex_unlock(&priv->lock);
> +
> +       return num_written > 0 ? num_written : -EIO;
> +}
> +
> +static int isl12026_probe(struct i2c_client *client,
> +                         const struct i2c_device_id *id)
> +{
> +       struct isl12026 *priv;
> +       int pwr, requested_pwr;
> +       int ret;
> +       u32 bsw_val, sbib_val;
> +       bool set_bsw, set_sbib;

> +       priv = devm_kzalloc(&client->dev, sizeof(struct isl12026), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;

sizeof(*priv) ?

> +       ret = of_property_read_u32(client->dev.of_node,
> +                                  "isil,pwr-bsw", &bsw_val);
> +       set_bsw = (ret == 0);
> +
> +       ret = of_property_read_u32(client->dev.of_node,
> +                                  "isil,pwr-sbib", &sbib_val);
> +       set_sbib = (ret == 0);
> +
> +       /* Check if PWR.BSW and/or PWR.SBIB need specified values */
> +
> +       if (set_bsw || set_sbib) {
> +               pwr = isl12026_read_reg(client, ISL12026_REG_PWR);
> +               if (pwr < 0)
> +                       dev_err(&client->dev,
> +                               "Error: Failed to read PWR %d\n", pwr);

...and what? No recovery? No nothing except the message?

> +
> +               requested_pwr = pwr;
> +
> +               if (set_bsw) {
> +                       if (bsw_val)
> +                               requested_pwr |= ISL12026_REG_PWR_BSW;
> +                       else
> +                               requested_pwr &= ~ISL12026_REG_PWR_BSW;
> +               }
> +               if (set_sbib) {
> +                       if (sbib_val)
> +                               requested_pwr |= ISL12026_REG_PWR_SBIB;
> +                       else
> +                               requested_pwr &= ~ISL12026_REG_PWR_SBIB;
> +               }
> +
> +               if (pwr >= 0 && pwr != requested_pwr) {
> +                       dev_info(&client->dev, "PWR: %02x\n", pwr);
> +                       dev_info(&client->dev,
> +                                "Updating PWR to: %02x\n", (u8)requested_pwr);
> +                       isl12026_write_reg(client,
> +                                          ISL12026_REG_PWR, requested_pwr);
> +               }
> +       }

Can you refactor above to a separate function?

> +       priv->rtc = devm_rtc_device_register(&client->dev, "rtc-isl12026",
> +                                            &isl12026_rtc_ops, THIS_MODULE);

> +

Redundant empty line.

> +       ret = PTR_ERR_OR_ZERO(priv->rtc);
> +       if (ret)
> +               return ret;


> +       if (IS_ENABLED(CONFIG_NVMEM)) {

I think you don't need this, see below.

> +               priv->nvm_client = i2c_new_dummy(client->adapter, 0x57);
> +               if (!priv->nvm_client)
> +                       return -ENOMEM;

i2c_new_secondary_device() ?

> +               priv->nvm_dev = nvmem_register(&priv->nvm_cfg);
> +

Redundant empty line.

> +               if (!priv->nvm_dev)

Should it be IS_ERR() ?

> +                       return -ENOMEM;

After all rtc_nvmem_register() ?

> +       }
> +       return 0;
> +}
> +
> +static int isl12026_remove(struct i2c_client *client)
> +{
> +       struct isl12026 *priv = i2c_get_clientdata(client);
> +

> +       if (priv->nvm_dev)

How is it

> +               nvmem_unregister(priv->nvm_dev);


> +       if (priv->nvm_client)

Check with v4.16-rc1. This is duplicate check.

> +               i2c_unregister_device(priv->nvm_client);
> +
> +       return 0;
> +}

> +#ifdef CONFIG_OF

Useless.

> +static const struct of_device_id isl12026_dt_match[] = {
> +       { .compatible = "isil,isl12026" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, isl12026_dt_match);
> +#endif
> +

> +static const struct i2c_device_id isl12026_id[] = {
> +       { "isl12026", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, isl12026_id);

Useless. Use ->probe_new() approach.

> +#ifdef CONFIG_OF

Ugly and useless.

> +               .of_match_table = of_match_ptr(isl12026_dt_match),
> +#endif

-- 
With Best Regards,
Andy Shevchenko
