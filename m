Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DC4B8C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BC9208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BC9208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754800AbeFNIVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:21:14 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:12036 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeFNIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:21:11 -0400
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="15245826"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jun 2018 01:21:10 -0700
Received: from [10.145.4.57] (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Thu, 14 Jun 2018
 01:21:09 -0700
Subject: Re: [PATCH v7 3/6] mfd: at91-usart: added mfd driver for usart
To:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee.jones@linaro.org>,
        <richard.genoud@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180613163621.23995-1-radu.pirea@microchip.com>
 <20180613163621.23995-4-radu.pirea@microchip.com>
 <20180614075849.dfiqwcu6rtzgpzq7@rfolt0960.corp.atmel.com>
From:   Radu Pirea <radu.pirea@microchip.com>
Message-ID: <1086330e-40e4-8d9b-50aa-1ae9bf48aa22@microchip.com>
Date:   Thu, 14 Jun 2018 11:22:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180614075849.dfiqwcu6rtzgpzq7@rfolt0960.corp.atmel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/14/2018 10:58 AM, Ludovic Desroches wrote:
> On Wed, Jun 13, 2018 at 07:36:18PM +0300, Radu Pirea wrote:
>> This mfd driver is just a wrapper over atmel_serial driver and
>> spi-at91-usart driver. Selection of one of the drivers is based on a
>> property from device tree. If the property is not specified, the default
>> driver is atmel_serial.
>>
>> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   drivers/mfd/Kconfig      |  9 ++++++
>>   drivers/mfd/Makefile     |  1 +
>>   drivers/mfd/at91-usart.c | 69 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 79 insertions(+)
>>   create mode 100644 drivers/mfd/at91-usart.c
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index b860eb5aa194..a886672b960d 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -99,6 +99,15 @@ config MFD_AAT2870_CORE
>>   	  additional drivers must be enabled in order to use the
>>   	  functionality of the device.
>>   
>> +config MFD_AT91_USART
>> +	tristate "AT91 USART Driver"
>> +	select MFD_CORE
>> +	help
>> +	  Select this to get support for AT91 USART IP. This is a wrapper
>> +	  over at91-usart-serial driver and usart-spi-driver. Only one function
>> +	  can be used at a time. The choice is done at boot time by the probe
>> +	  function of this MFD driver according to a device tree property.
>> +
>>   config MFD_ATMEL_FLEXCOM
>>   	tristate "Atmel Flexcom (Flexible Serial Communication Unit)"
>>   	select MFD_CORE
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index d9d2cf0d32ef..db1332aa96db 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -185,6 +185,7 @@ obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
>>   obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
>>   obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
>>   obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
>> +obj-$(CONFIG_MFD_AT91_USART)	+= at91-usart.o
>>   obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
>>   obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
>>   obj-$(CONFIG_MFD_ATMEL_SMC)	+= atmel-smc.o
>> diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
>> new file mode 100644
>> index 000000000000..3014ce532644
>> --- /dev/null
>> +++ b/drivers/mfd/at91-usart.c
>> @@ -0,0 +1,69 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for AT91 USART
>> + *
>> + * Copyright (C) 2018 Microchip Technology
>> + *
>> + * Author: Radu Pirea <radu.pirea@microchip.com>
>> + *
>> + */
>> +
>> +#include <dt-bindings/mfd/at91-usart.h>
>> +
>> +#include <linux/module.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/property.h>
>> +
>> +static struct mfd_cell at91_usart_spi_subdev = {
>> +		.name = "at91_usart_spi",
>> +		.of_compatible = "microchip,at91sam9g45-usart-spi",
>> +	};
>> +
>> +static struct mfd_cell at91_usart_serial_subdev = {
>> +		.name = "atmel_usart_serial",
>> +		.of_compatible = "atmel,at91rm9200-usart-serial",
>> +	};
>> +
>> +static int at91_usart_mode_probe(struct platform_device *pdev)
>> +{
>> +	struct mfd_cell cell;
>> +	u32 opmode = AT91_USART_MODE_SERIAL;
>> +
>> +	device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
>> +
>> +	switch (opmode) {
>> +	case AT91_USART_MODE_SPI:
>> +		cell = at91_usart_spi_subdev;
>> +		break;
>> +	case AT91_USART_MODE_SERIAL:
>> +		cell = at91_usart_serial_subdev;
>> +		break;
>> +	default:
>> +		break;
> 
> If there is an invalid opmode from the DT, you will pass a non initialized cell
> to mfd_add_device().
> 
> Regards
> 
> Ludovic

Hi Ludovic,

Tnx. That's true. How is better to do if atmel,usart-mode has an invalid 
value? To initialize cell with at91_usart_serial_subdev or to print an 
error message and return -EINVAL?

Regards.
Radu Pirea
> 
>> +	}
>> +
>> +	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, &cell, 1,
>> +			      NULL, 0, NULL);
>> +}
>> +
>> +static const struct of_device_id at91_usart_mode_of_match[] = {
>> +	{ .compatible = "atmel,at91rm9200-usart" },
>> +	{ .compatible = "atmel,at91sam9260-usart" },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, at91_flexcom_of_match);
>> +
>> +static struct platform_driver at91_usart_mfd = {
>> +	.probe	= at91_usart_mode_probe,
>> +	.driver	= {
>> +		.name		= "at91_usart_mode",
>> +		.of_match_table	= at91_usart_mode_of_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(at91_usart_mfd);
>> +
>> +MODULE_AUTHOR("Radu Pirea <radu.pirea@microchip.com>");
>> +MODULE_DESCRIPTION("AT91 USART MFD driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
