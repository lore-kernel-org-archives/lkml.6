Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C183C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58FD2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHRmvzKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58FD2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeJRVhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:37:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40701 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeJRVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:37:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so14341050plv.7;
        Thu, 18 Oct 2018 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PUvIZBAn5MGosJFxh8DKMZjGLR4RFzbQ3x6OJZ/wuZs=;
        b=KHRmvzKFZT8b31kf2eHUaF3WIl0kijfXgATUopTbYBMC/6dxqRm5av3Zly2YsI4IZJ
         2ob1cy50NEt48Uqez1aqL8q70YxccQyuEaX3SMC4Yatk7sN8i7Gv4b+dKJgFkMjvos+W
         yZoeXA6bQoThmo4TdeTa/G482FvjP9cNhkITyfbGPuIZhIdLZpuxwGHUmmX9IRPywKD5
         ETJuGOzdNp6T/ERzax/PGupIt1k3EYU9elieO/FbCecdu8S3QPF1csk+Pao7H6VLh0o+
         KE7QjxA9bjJXxQM9EdFHzF/o5NzY6ZZ9piosyY+ODB/OpjATRoaWS4PHZvI1cB69/7zV
         1Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PUvIZBAn5MGosJFxh8DKMZjGLR4RFzbQ3x6OJZ/wuZs=;
        b=gao5lvGjbnlnyaGllMFlfzhJ+IHMCgyRrxRiJ41touUizUogh5DoesDbiC1rajhVXE
         Plmy9HC6mJ5wKR0o09lmCVUeCRvOdxTWml/yZIH/D7VKMqOgfLMEbvqbAhnYeudxXFPs
         2ZOeMeovafImPzulKb7PFrw3/DfggXusrwhfKObuGOtRNdGGz0tbLPb9g2a+iZMX4H9U
         dfi1hydMIALumKZ1sQudDu9xTf7IvHAqY+bs+AlMb8IDnffMOPouc7PjAaMschgljKKp
         393Y6OAgdSr9KD+150yijCeMYzIPkgkc63duuCSYjOfreWCcP8wz2XHfMorhZCPs6gMb
         iYgA==
X-Gm-Message-State: ABuFfoix7jM/kM03qblNsQF7/R6/PVA3uqniYzkH2TE9ds30acbA9Iql
        qJO0FPnVdFZpzGVCiT2yvPTLV22P
X-Google-Smtp-Source: ACcGV60UtSSSnB99pfHAWzO+89qyQ6fpprfsCkeHiXFVD1xUGgUvHCV1BAFNbWbEBw0Eg2JDblr+cA==
X-Received: by 2002:a17:902:ba8d:: with SMTP id k13-v6mr30275683pls.12.1539869786292;
        Thu, 18 Oct 2018 06:36:26 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j3-v6sm20416142pfn.175.2018.10.18.06.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 06:36:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: (pmbus): Add driver for Intersil ISL68137
To:     Kun Yi <kunyi@google.com>
Cc:     openbmc@lists.ozlabs.org, Maxim Sloyko <maxims@google.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20181017225603.7782-1-kunyi@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <51dbddbc-0e92-7bb5-03c7-4bad3a0af029@roeck-us.net>
Date:   Thu, 18 Oct 2018 06:36:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017225603.7782-1-kunyi@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 03:56 PM, Kun Yi wrote:
> From: Maxim Sloyko <maxims@google.com>
> 
> Intersil ISL68137 is a digital output 7-phase configurable PWM
> controller with an AVSBus interface.
> 
> Signed-off-by: Maxim Sloyko <maxims@google.com>
> Signed-off-by: Kun Yi <kunyi@google.com>
> ---
>   drivers/hwmon/pmbus/Kconfig    | 10 ++++
>   drivers/hwmon/pmbus/Makefile   |  1 +
>   drivers/hwmon/pmbus/isl68137.c | 86 ++++++++++++++++++++++++++++++++++
>   3 files changed, 97 insertions(+)
>   create mode 100644 drivers/hwmon/pmbus/isl68137.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 629cb45f8557..15c197f1c4c4 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -54,6 +54,16 @@ config SENSORS_IR35221
>   	  This driver can also be built as a module. If so, the module will
>   	  be called ir35521.
>   
> +config SENSORS_ISL68137
> +	tristate "Intersil ISL68137"
> +	default y
> +	help
> +	  If you say yes here you get hardware monitoring support for Intersil
> +	  ISL68137.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called isl68137.
> +
>   config SENSORS_LM25066
>   	tristate "National Semiconductor LM25066 and compatibles"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index ea0e39518c21..0684b35216da 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
>   obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>   obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
>   obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
> +obj-$(CONFIG_SENSORS_ISL68137)	+= isl68137.o
>   obj-$(CONFIG_SENSORS_LM25066)	+= lm25066.o
>   obj-$(CONFIG_SENSORS_LTC2978)	+= ltc2978.o
>   obj-$(CONFIG_SENSORS_LTC3815)	+= ltc3815.o
> diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
> new file mode 100644
> index 000000000000..2a5322e4a286
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/isl68137.c
> @@ -0,0 +1,86 @@
> +/*
> + * Hardware monitoring driver for Intersil ISL68137
> + *
> + * Copyright (c) 2017 Google Inc
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +

Please use SPDX for new drivers.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>

Alphabetic order, please.

> +#include "pmbus.h"
> +
> +static struct pmbus_driver_info isl68137_info = {
> +	.pages = 2,
> +	.format[PSC_VOLTAGE_IN] = direct,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +	.format[PSC_CURRENT_IN] = direct,
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.format[PSC_POWER] = direct,
> +	.format[PSC_TEMPERATURE] = direct,
> +	.m[PSC_VOLTAGE_IN] = 1,
> +	.b[PSC_VOLTAGE_IN] = 0,
> +	.R[PSC_VOLTAGE_IN] = 3,
> +	.m[PSC_VOLTAGE_OUT] = 1,
> +	.b[PSC_VOLTAGE_OUT] = 0,
> +	.R[PSC_VOLTAGE_OUT] = 3,
> +	.m[PSC_CURRENT_IN] = 1,
> +	.b[PSC_CURRENT_IN] = 0,
> +	.R[PSC_CURRENT_IN] = 2,
> +	.m[PSC_CURRENT_OUT] = 1,
> +	.b[PSC_CURRENT_OUT] = 0,
> +	.R[PSC_CURRENT_OUT] = 1,
> +	.m[PSC_POWER] = 1,
> +	.b[PSC_POWER] = 0,
> +	.R[PSC_POWER] = 0,
> +	.m[PSC_TEMPERATURE] = 1,
> +	.b[PSC_TEMPERATURE] = 0,
> +	.R[PSC_TEMPERATURE] = 0,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN
> +	    | PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> +	    | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_TEMP
> +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
> +	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
> +};
> +
> +static int isl68137_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	return pmbus_do_probe(client, id, &isl68137_info);
> +}
> +
> +static const struct i2c_device_id isl68137_id[] = {
> +	{"isl68137", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, isl68137_id);
> +
> +/* This is the driver that will be inserted */
> +static struct i2c_driver isl68137_driver = {
> +	.driver = {
> +		   .name = "isl68137",
> +		   },
> +	.probe = isl68137_probe,
> +	.remove = pmbus_do_remove,
> +	.id_table = isl68137_id,
> +};
> +
> +module_i2c_driver(isl68137_driver);
> +
> +MODULE_AUTHOR("Maxim Sloyko <maxims@google.com>");
> +MODULE_DESCRIPTION("PMBus driver for Intersil ISL68137");
> +MODULE_LICENSE("GPL");
> 

