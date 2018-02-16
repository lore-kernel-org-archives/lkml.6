Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758728AbeBPQ5N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:57:13 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35928 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758691AbeBPQ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:56:59 -0500
X-Google-Smtp-Source: AH8x226XH/gcDeyacepTetreYqp6CMPWNSNFR5HzFw16f54LdNYNgNAJ0Ov2WSeQR8rm1kmuRX7sC6b/I77MCIZ9ygk=
MIME-Version: 1.0
In-Reply-To: <20180215195437.29207-1-david.daney@cavium.com>
References: <20180215195437.29207-1-david.daney@cavium.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 18:56:57 +0200
Message-ID: <CAHp75VcVaXb5dgBs9UkSgEjTNB44cs+gr8hjE3mdr_BKYy0Ffg@mail.gmail.com>
Subject: Re: [PATCH v3] rtc: isl12026: Add driver.
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

On Thu, Feb 15, 2018 at 9:54 PM, David Daney <david.daney@cavium.com> wrote:
> The ISL12026 is a combination RTC and EEPROM device with I2C
> interface.  The standard RTC driver interface is provided.  The EEPROM
> is accessed via the NVMEM interface via the "eeprom0" directory in the
> sysfs entry for the device.
>

Couple of nitpicks below, though in any case, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> Changes from v2:
>
> o More code cleanups suggested by reviewers.
>
> Changes from v1:
>
> o Fixed device tree bindings document example.
>
> o Use RTC_NVMEM facility for eeprom support.
>
> o Small code cleanups suggested by reviewers.
>
> .../devicetree/bindings/rtc/isil,isl12026.txt      |  28 ++
>  drivers/rtc/Kconfig                                |   9 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-isl12026.c                         | 529 +++++++++++++++++++++
>  4 files changed, 567 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12026.txt
>  create mode 100644 drivers/rtc/rtc-isl12026.c
>
> diff --git a/Documentation/devicetree/bindings/rtc/isil,isl12026.txt b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
> new file mode 100644
> index 000000000000..2e0be45193bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
> @@ -0,0 +1,28 @@
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
> +               compatible = "isil,isl12026";
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
> index 000000000000..1cb111e4c442
> --- /dev/null
> +++ b/drivers/rtc/rtc-isl12026.c
> @@ -0,0 +1,529 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * An I2C driver for the Intersil ISL 12026
> + *
> + * Copyright (c) 2018 Cavium, Inc.
> + */
> +#include <linux/bcd.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/rtc.h>
> +#include <linux/slab.h>
> +
> +/* register offsets */
> +#define ISL12026_REG_PWR       0x14
> +# define ISL12026_REG_PWR_BSW  BIT(6)
> +# define ISL12026_REG_PWR_SBIB BIT(7)
> +#define ISL12026_REG_SC                0x30
> +#define ISL12026_REG_HR                0x32
> +# define ISL12026_REG_HR_MIL   BIT(7)  /* military or 24 hour time */
> +#define ISL12026_REG_SR                0x3f
> +# define ISL12026_REG_SR_RTCF  BIT(0)
> +# define ISL12026_REG_SR_WEL   BIT(1)
> +# define ISL12026_REG_SR_RWEL  BIT(2)
> +# define ISL12026_REG_SR_MBZ   BIT(3)
> +# define ISL12026_REG_SR_OSCF  BIT(4)
> +
> +/* The EEPROM array responds at i2c address 0x57 */
> +#define ISL12026_EEPROM_ADDR   0x57
> +
> +#define ISL12026_PAGESIZE 16
> +#define ISL12026_NVMEM_WRITE_TIME 20
> +
> +struct isl12026 {
> +       struct rtc_device *rtc;
> +       struct i2c_client *nvm_client;
> +       struct nvmem_config nvm_cfg;
> +       /*
> +        * RTC write operations require that multiple messages be
> +        * transmitted, we hold the lock for all accesses to the
> +        * device so that these sequences cannot be disrupted.  Also,
> +        * the write cycle to the nvmem takes many ms during which the
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
> +               }, {
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
> +       if (ret != ARRAY_SIZE(msgs)) {
> +               dev_err(&client->dev, "read reg error, ret=%d\n", ret);
> +               ret = ret < 0 ? ret : -EIO;
> +       } else {
> +               ret = val;
> +       }
> +
> +       mutex_unlock(&priv->lock);
> +
> +       return ret;
> +}
> +
> +static int isl12026_write_reg(struct i2c_client *client, int reg, u8 val)
> +{
> +       struct isl12026 *priv = i2c_get_clientdata(client);
> +       int ret;
> +       u8 op[3];
> +       struct i2c_msg msg = {
> +               .addr   = client->addr,
> +               .flags  = 0,
> +               .len    = 1,
> +               .buf    = op
> +       };
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
> +               ret = ret < 0 ? ret : -EIO;
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
> +               ret = ret < 0 ? ret : -EIO;
> +               goto out;
> +       }
> +
> +       op[1] = reg;
> +       op[2] = val;
> +       msg.len = 3;
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret != 1) {
> +               dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
> +               ret = ret < 0 ? ret : -EIO;
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
> +               ret = ret < 0 ? ret : -EIO;
> +               goto out;
> +       }
> +       ret = 0;
> +out:
> +       mutex_unlock(&priv->lock);
> +
> +       return ret;
> +}
> +
> +static int isl12026_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct isl12026 *priv = i2c_get_clientdata(client);
> +       int ret;
> +       u8 op[10];
> +       struct i2c_msg msg = {
> +               .addr   = client->addr,
> +               .flags  = 0,
> +               .len    = 1,
> +               .buf    = op
> +       };
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
> +               ret = ret < 0 ? ret : -EIO;
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
> +               ret = ret < 0 ? ret : -EIO;
> +               goto out;
> +       }
> +
> +       /* Set the CCR registers */
> +       op[1] = ISL12026_REG_SC;
> +       op[2] = bin2bcd(tm->tm_sec); /* SC */
> +       op[3] = bin2bcd(tm->tm_min); /* MN */
> +       op[4] = bin2bcd(tm->tm_hour) | ISL12026_REG_HR_MIL; /* HR */
> +       op[5] = bin2bcd(tm->tm_mday); /* DT */
> +       op[6] = bin2bcd(tm->tm_mon + 1); /* MO */
> +       op[7] = bin2bcd(tm->tm_year % 100); /* YR */
> +       op[8] = bin2bcd(tm->tm_wday & 7); /* DW */
> +       op[9] = bin2bcd(tm->tm_year >= 100 ? 20 : 19); /* Y2K */
> +       msg.len = 10;
> +       ret = i2c_transfer(client->adapter, &msg, 1);
> +       if (ret != 1) {
> +               dev_err(&client->dev, "write error CCR, ret=%d\n", ret);
> +               ret = ret < 0 ? ret : -EIO;
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
> +               ret = ret < 0 ? ret : -EIO;
> +               goto out;
> +       }
> +       ret = 0;
> +out:
> +       mutex_unlock(&priv->lock);
> +
> +       return ret;
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
> +       struct i2c_msg msgs[] = {
> +               {
> +                       .addr   = client->addr,
> +                       .flags  = 0,
> +                       .len    = sizeof(addr),
> +                       .buf    = addr
> +               }, {
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
> +               ret = ret < 0 ? ret : -EIO;
> +               goto out;
> +       }
> +
> +       if (sr & ISL12026_REG_SR_RTCF)
> +               dev_warn(&client->dev, "Real-Time Clock Failure on read\n");
> +       if (sr & ISL12026_REG_SR_OSCF)
> +               dev_warn(&client->dev, "Oscillator Failure on read\n");
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
> +               ret = ret < 0 ? ret : -EIO;
> +               goto out;
> +       }
> +
> +       tm->tm_sec = bcd2bin(ccr[0] & 0x7F);
> +       tm->tm_min = bcd2bin(ccr[1] & 0x7F);
> +       if (ccr[2] & ISL12026_REG_HR_MIL)
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
> +       ret = rtc_valid_tm(tm);
> +out:
> +       mutex_unlock(&priv->lock);
> +       return ret;
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
> +       int ret;
> +       u8 addr[2];
> +       struct i2c_msg msgs[] = {
> +               {
> +                       .addr   = priv->nvm_client->addr,
> +                       .flags  = 0,
> +                       .len    = sizeof(addr),
> +                       .buf    = addr
> +               }, {
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
> +       mutex_lock(&priv->lock);
> +
> +       /* 2 bytes of address, most significant first */
> +       addr[0] = offset >> 8;
> +       addr[1] = offset;
> +       msgs[1].len = bytes;
> +       ret = i2c_transfer(priv->nvm_client->adapter, msgs, ARRAY_SIZE(msgs));
> +
> +       mutex_unlock(&priv->lock);
> +
> +       if (ret != ARRAY_SIZE(msgs)) {
> +               dev_err(priv->nvm_cfg.dev, "nvmem read error, ret=%d\n", ret);
> +               return ret < 0 ? ret : -EIO;
> +       }
> +
> +       return bytes;
> +}
> +
> +static int isl12026_nvm_write(void *p, unsigned int offset,
> +                             void *val, size_t bytes)
> +{
> +       struct isl12026 *priv = p;
> +       int ret = -EIO;
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
> +               /*
> +                * 2 bytes of address, most significant first, followed
> +                * by page data bytes
> +                */
> +               memcpy(payload + 2, v + num_written, chunk_size);
> +               payload[0] = offset >> 8;
> +               payload[1] = offset;
> +               msgs[0].len = chunk_size + 2;
> +               ret = i2c_transfer(priv->nvm_client->adapter,
> +                                  msgs, ARRAY_SIZE(msgs));
> +               if (ret != ARRAY_SIZE(msgs)) {
> +                       dev_err(priv->nvm_cfg.dev,
> +                               "nvmem write error, ret=%d\n", ret);
> +                       ret = ret < 0 ? ret : -EIO;
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
> +       return num_written >= 0 ? num_written : ret;
> +}
> +
> +static void isl12026_force_power_modes(struct i2c_client *client)
> +{
> +       int ret;
> +       int pwr, requested_pwr;
> +       u32 bsw_val, sbib_val;
> +       bool set_bsw, set_sbib;
> +
> +       /*
> +        * If we can read the of_property, set the specified value.
> +        * If there is an error reading the of_property (likely
> +        * because it does not exist), keep the current value.
> +        */
> +       ret = of_property_read_u32(client->dev.of_node,
> +                                  "isil,pwr-bsw", &bsw_val);
> +       set_bsw = (ret == 0);
> +
> +       ret = of_property_read_u32(client->dev.of_node,
> +                                  "isil,pwr-sbib", &sbib_val);
> +       set_sbib = (ret == 0);
> +
> +       /* Check if PWR.BSW and/or PWR.SBIB need specified values */
> +       if (!set_bsw && !set_sbib)
> +               return;
> +
> +       pwr = isl12026_read_reg(client, ISL12026_REG_PWR);
> +       if (pwr < 0) {

> +               dev_err(&client->dev, "Error: Failed to read PWR %d\n", pwr);

dev_warn()?

> +               return;
> +       }
> +
> +       requested_pwr = pwr;
> +
> +       if (set_bsw) {
> +               if (bsw_val)
> +                       requested_pwr |= ISL12026_REG_PWR_BSW;
> +               else
> +                       requested_pwr &= ~ISL12026_REG_PWR_BSW;
> +       } /* else keep current BSW */
> +
> +       if (set_sbib) {
> +               if (sbib_val)
> +                       requested_pwr |= ISL12026_REG_PWR_SBIB;
> +               else
> +                       requested_pwr &= ~ISL12026_REG_PWR_SBIB;
> +       } /* else keep current SBIB */
> +
> +       if (pwr >= 0 && pwr != requested_pwr) {
> +               dev_info(&client->dev, "PWR: %02x\n", pwr);
> +               dev_info(&client->dev,
> +                        "Updating PWR to: %02x\n", requested_pwr);
> +               isl12026_write_reg(client, ISL12026_REG_PWR, requested_pwr);
> +       }
> +}
> +
> +static int isl12026_probe_new(struct i2c_client *client)
> +{
> +       struct isl12026 *priv;
> +       int ret;
> +
> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +               return -ENODEV;
> +
> +       priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       mutex_init(&priv->lock);
> +
> +       i2c_set_clientdata(client, priv);
> +
> +       isl12026_force_power_modes(client);
> +
> +       priv->nvm_client = i2c_new_dummy(client->adapter, ISL12026_EEPROM_ADDR);
> +       if (!priv->nvm_client)
> +               return -ENOMEM;
> +
> +       priv->rtc = devm_rtc_allocate_device(&client->dev);
> +       ret = PTR_ERR_OR_ZERO(priv->rtc);
> +       if (ret)
> +               return ret;
> +
> +       priv->rtc->ops = &isl12026_rtc_ops;
> +
> +       priv->nvm_cfg.name = "eeprom";
> +       priv->nvm_cfg.read_only = false;
> +       priv->nvm_cfg.root_only = true;
> +       priv->nvm_cfg.base_dev = &client->dev;
> +       priv->nvm_cfg.priv = priv;
> +       priv->nvm_cfg.stride = 1;
> +       priv->nvm_cfg.word_size = 1;
> +       priv->nvm_cfg.size = 512;
> +       priv->nvm_cfg.reg_read = isl12026_nvm_read;
> +       priv->nvm_cfg.reg_write = isl12026_nvm_write;
> +
> +       priv->rtc->nvmem_config = &priv->nvm_cfg;
> +       priv->rtc->nvram_old_abi = false;
> +
> +       return rtc_register_device(priv->rtc);
> +}
> +
> +static int isl12026_remove(struct i2c_client *client)
> +{
> +       struct isl12026 *priv = i2c_get_clientdata(client);
> +
> +       i2c_unregister_device(priv->nvm_client);
> +       return 0;
> +}
> +
> +static const struct of_device_id isl12026_dt_match[] = {
> +       { .compatible = "isil,isl12026" },

> +       { },

Slightly better to remove comma.

> +};
> +MODULE_DEVICE_TABLE(of, isl12026_dt_match);
> +
> +static struct i2c_driver isl12026_driver = {
> +       .driver         = {
> +               .name   = "rtc-isl12026",
> +               .of_match_table = of_match_ptr(isl12026_dt_match),
> +       },
> +       .probe_new      = isl12026_probe_new,
> +       .remove         = isl12026_remove,
> +};
> +
> +module_i2c_driver(isl12026_driver);
> +
> +MODULE_DESCRIPTION("ISL 12026 RTC driver");
> +MODULE_LICENSE("GPL");
> --
> 2.14.3
>



-- 
With Best Regards,
Andy Shevchenko
