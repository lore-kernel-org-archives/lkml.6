Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B90C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DB42070C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJafBLPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfAERIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:08:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35875 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAERIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:08:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so18833490pgm.3;
        Sat, 05 Jan 2019 09:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MgbB4H38L1kFw6yDp9fjfhBcofn2GhSL69NODza3NBo=;
        b=sJafBLPu2l4Pn6lGeoxkFhr1/G1B8l1XLtcn03DMjMsNQF9KWqThu+otyJPH4EKASd
         4bftEV4uv4GazYUeRo8F+FM79VVHNfWrT9+kj/ZFAyZwKggqnRvGKBBoLajzU6PxQAPJ
         Q5c7HRuJga2q0MqEke6Uyre3ZmVI+sktptX2vAU/DcnEmuNGDivPj46KEQM54T4fNuD+
         fsNT8wWjT9ZT/0Oe2VFo2FGIf7BzxxzR6Z/3/ftM9xtCPW66nkyKyV/us0gUIGl4MY+G
         HJ7baZgU9uBbep8ykGup7VGHulDgPNqgcW3zaYamgV/ibt8DKaOpamDOlsG02ETJq9TD
         Cgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MgbB4H38L1kFw6yDp9fjfhBcofn2GhSL69NODza3NBo=;
        b=aKvf422tFFLcrwy5KzFFAyreg64w6DGizmk0+e+Q2AzSlt7IlSBBDnDyAoly9xt65x
         IUuEYItagJtPQGwPseG1NIZDAn17Sw2LQJndpCP/6WrMntGPrOANLeCIiamNHXfxtoZz
         G5Kwz2Mlf4rHCmNfUs3R7UXTpd0O+5GDazVwDlk/kBQb59M87la9tTTzW1Vkkk7zVrpm
         fVVWVP548zWAAUlvOwKKz16w11XbZvmrr8nVrk7LDO3g//dFnIzju38er/eJusyOuGi8
         Po67YiktnfyRt2oWcVvYztyfFLdaqIKkvs0HHvGxBKNDaTWh8kAR9OcIvx+bNNzEuRiE
         JA4Q==
X-Gm-Message-State: AJcUukcras5R3d9BNex6bqZ5RG1dA40umUbAZIZSK7YLVHgg8OFm5/ky
        lbV/ryJJtZWgYVd2/z/mjBZaDxRW
X-Google-Smtp-Source: AFSGD/XKWItkxL3ySIy1XVBcwLj2Rew7Q3B49CnG6ZytT67njhjmcWR9bS/L9zWvByfTTRuzuyHBZg==
X-Received: by 2002:aa7:868f:: with SMTP id d15mr55997933pfo.225.1546708128962;
        Sat, 05 Jan 2019 09:08:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s21sm98227576pfk.133.2019.01.05.09.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 09:08:48 -0800 (PST)
Date:   Sat, 5 Jan 2019 09:08:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Cc:     jdelvare@suse.com, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        shunyong.yang@hxt-semitech.com, dongsheng.wang@hxt-semitech.com
Subject: Re: [PATCH 4/4] pmbus (dps650ab): add power supply driver
Message-ID: <20190105170847.GA14962@roeck-us.net>
References: <cover.1546591275.git.xiaoting.liu@hxt-semitech.com>
 <e0ad8b6bb620f9fc2f818cbda66825c297f73d67.1546591275.git.xiaoting.liu@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ad8b6bb620f9fc2f818cbda66825c297f73d67.1546591275.git.xiaoting.liu@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 05:05:27PM +0800, Xiaoting Liu wrote:
> The Delta dps650ab provides main power and standby power to server.
> dps650ab can be detected by MFR_ID and MFR_MODEL referring to
> manufacturer's feedback. This patch adds driver to moniter power
> supply status.
> 

Another comment: The subject should be something like
	hwmon: (pmbus) Add driver for DPS650AB power supply

Additional comments inline below.

Thanks,
Guenter

> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
> ---
>  drivers/hwmon/pmbus/Kconfig    |  10 +++++
>  drivers/hwmon/pmbus/Makefile   |   1 +
>  drivers/hwmon/pmbus/dps650ab.c | 100 +++++++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/pmbus/pmbus.c    |   3 ++
>  4 files changed, 114 insertions(+)
> 
> --
> 1.8.3.1
> 
> 
> 
> 
> This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 629cb45f8557..de4638396592 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -184,4 +184,14 @@ config SENSORS_ZL6100
>           This driver can also be built as a module. If so, the module will
>           be called zl6100.
> 
> +config SENSORS_DPS650AB
> +       tristate "Delta DPS650AB"
> +       default n
> +       help
> +         If you say yes here you get hardware monitoring support for the
> +         Delta DPS650AB controller.
> +
> +         This driver can also be built as a module. If so, the module will
> +         be called dps650ab.
> +
Ahplabetic order, please.

>  endif # PMBUS
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index ea0e39518c21..414818230a26 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_SENSORS_TPS53679)        += tps53679.o
>  obj-$(CONFIG_SENSORS_UCD9000)  += ucd9000.o
>  obj-$(CONFIG_SENSORS_UCD9200)  += ucd9200.o
>  obj-$(CONFIG_SENSORS_ZL6100)   += zl6100.o
> +obj-$(CONFIG_SENSORS_DPS650AB) += dps650ab.o

Alphabetic order, please.

> diff --git a/drivers/hwmon/pmbus/dps650ab.c b/drivers/hwmon/pmbus/dps650ab.c
> new file mode 100644
> index 000000000000..3c300e621f5a
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/dps650ab.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Hardware monitoring driver for DELTA DPS650AB
> + *
> + * Copyright (c) 2018 Huaxintong Semiconductor Technology Co., Ltd.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "pmbus.h"
> +
> +#define DPS650AB_MFR_ID                        "DELTA"
> +#define DPS650AB_MFR_MODEL             "DPS-650AB-16 A"
> +
> +static int dps650ab_probe(struct i2c_client *client,
> +                        const struct i2c_device_id *id)
> +{
> +       struct pmbus_driver_info *info;
> +       u8 buf[I2C_SMBUS_BLOCK_MAX];
> +       int ret;
> +
> +       memset(buf, 0, I2C_SMBUS_BLOCK_MAX);
> +
> +       if (!i2c_check_functionality(client->adapter,
> +                                    I2C_FUNC_SMBUS_READ_BYTE_DATA
> +                               | I2C_FUNC_SMBUS_READ_WORD_DATA
> +                               | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> +               return -ENODEV;
> +
> +       ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +       if (ret < 0) {
> +               dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
> +               return ret;
> +       }
> +
> +       if (strncmp(buf, DPS650AB_MFR_ID, strlen(DPS650AB_MFR_ID))) {
> +               dev_err(&client->dev, "DPS650AB_MFR_ID unrecognised\n");
> +               return -ENODEV;
> +       }
> +
> +       ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +       if (ret < 0) {
> +               dev_err(&client->dev, "Failed to read PMBUS_MFR_MODEL\n");
> +               return ret;
> +       }
> +
> +       if (strncmp(buf, DPS650AB_MFR_MODEL, strlen(DPS650AB_MFR_MODEL))) {
> +               dev_err(&client->dev, "DPS650AB_MFR_MODEL unrecognised\n");
> +               return -ENODEV;
> +       }
> +
> +       info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       info->pages = 1;
> +       info->format[PSC_VOLTAGE_IN] = linear;
> +       info->format[PSC_VOLTAGE_OUT] = linear;
> +       info->format[PSC_CURRENT_IN] = linear;
> +       info->format[PSC_CURRENT_OUT] = linear;
> +       info->format[PSC_POWER] = linear;
> +       info->format[PSC_TEMPERATURE] = linear;
> +
> +       info->func[0] = PMBUS_HAVE_VIN
> +               | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN
> +               | PMBUS_HAVE_STATUS_INPUT
> +               | PMBUS_HAVE_POUT | PMBUS_HAVE_FAN12
> +               | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> +               | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +               | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> +               | PMBUS_HAVE_STATUS_TEMP;
> +       info->func[1] = info->func[0];
> +
> +       return pmbus_do_probe(client, id, info);
> +}
> +
> +static const struct i2c_device_id dps650ab_id[] = {
> +       {"dps650ab", 1},
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, dps650ab_id);
> +
> +static struct i2c_driver dps650ab_driver = {
> +       .driver = {
> +               .name   = "dps650ab",
> +       },
> +       .probe          = dps650ab_probe,
> +       .remove         = pmbus_do_remove,
> +       .id_table       = dps650ab_id,
> +};
> +
> +module_i2c_driver(dps650ab_driver);
> +
> +MODULE_AUTHOR("Liuxiaoting <xiaoting.liu@hxt-semitech.com");
> +MODULE_DESCRIPTION("PMBus driver for DPS650AB");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
> index aa4cf9636e99..930e8a3e2366 100644
> --- a/drivers/hwmon/pmbus/pmbus.c
> +++ b/drivers/hwmon/pmbus/pmbus.c
> @@ -204,6 +204,8 @@ static int pmbus_probe(struct i2c_client *client,
>  static const struct pmbus_device_info sgd009_pmbus_info = {
>                                 1, PMBUS_SKIP_STATUS_CHECK};
>  static const struct pmbus_device_info pmbus_info = {0, 0};
> +static const struct pmbus_device_info dps650ab_pmbus_info = {
> +                               1, PMBUS_SKIP_STATUS_CHECK};
>  /*
>   * Use driver_data to set the number of pages supported by the chip.
>   */
> @@ -227,6 +229,7 @@ static int pmbus_probe(struct i2c_client *client,
>         {"tps544c20", (kernel_ulong_t)&default_pmbus_info},
>         {"tps544c25", (kernel_ulong_t)&default_pmbus_info},
>         {"udt020", (kernel_ulong_t)&default_pmbus_info},
> +       {"dps650ab", (kernel_ulong_t)&dps650ab_pmbus_info},
>         {}
>  };
