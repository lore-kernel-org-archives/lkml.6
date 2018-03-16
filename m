Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeCPOg3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:36:29 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35911 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751233AbeCPOg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:36:28 -0400
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "gabriel.fernandez.st@gmail.com" <gabriel.fernandez.st@gmail.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/2] reset: stm32mp1: Enable stm32mp1 reset driver
Thread-Topic: [PATCH v2 2/2] reset: stm32mp1: Enable stm32mp1 reset driver
Thread-Index: AQHTu7G2MI13qlmdg0yaOXoGEu7t/aPSzZKAgAASQgA=
Date: Fri, 16 Mar 2018 14:35:16 +0000
Message-ID: <0aa41806-22c9-c8ef-6fe4-1353cbbd680a@st.com>
References: <1521045001-30788-1-git-send-email-gabriel.fernandez@st.com>
 <1521045001-30788-3-git-send-email-gabriel.fernandez@st.com>
 <1521206991.5061.5.camel@pengutronix.de>
In-Reply-To: <1521206991.5061.5.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BE38ABF8E1FF64DBEEC588A588AD7A7@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2GEabrl007654


Hi Philipp,

Thanks for reviewing.

On 03/16/2018 02:29 PM, Philipp Zabel wrote:
> Hi Gabriel,
>
> this looks mostly good to me, a few questions and comments below:
>
> On Wed, 2018-03-14 at 17:30 +0100, gabriel.fernandez@st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> stm32mp1 RCC IP 1 has a reset SET register and a reset CLEAR register.
>>
>> Writing '0' on reset SET register has no effect
>> Writing '1' on reset SET register
>> 	activates the reset of the corresponding peripheral
>>
>> Writing '0' on reset CLEAR register	has no effect
>> Writing '1' on reset CLEAR register
>> 	releases the reset of the corresponding peripheral
>>
>> See Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
>>   drivers/reset/Kconfig          |   6 ++
>>   drivers/reset/Makefile         |   1 +
>>   drivers/reset/reset-stm32mp1.c | 122 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 129 insertions(+)
>>   create mode 100644 drivers/reset/reset-stm32mp1.c
>>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 1efbc6c..c0b292b 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -97,6 +97,12 @@ config RESET_SIMPLE
>>   	   - Allwinner SoCs
>>   	   - ZTE's zx2967 family
>>   
>> +config RESET_STM32MP157
>> +	bool "STM32MP157 Reset Driver" if COMPILE_TEST
>> +	default MACH_STM32MP157
>> +	help
>> +	  This enables the RCC reset controller driver for STM32 MPUs.
>> +
>>   config RESET_SUNXI
>>   	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
>>   	default ARCH_SUNXI
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 132c24f..c1261dc 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_RESET_MESON) += reset-meson.o
>>   obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>>   obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
>>   obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
>> +obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
>>   obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>>   obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>>   obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
>> diff --git a/drivers/reset/reset-stm32mp1.c b/drivers/reset/reset-stm32mp1.c
>> new file mode 100644
>> index 0000000..5e25388
>> --- /dev/null
>> +++ b/drivers/reset/reset-stm32mp1.c
>> @@ -0,0 +1,122 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
>> + * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
>> + */
>> +
>> +#include <linux/arm-smccc.h>
> This does not seem to be necessary.
right
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
> This does not seem to be necessary either.
ok
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +
>> +#define CLR_OFFSET 0x4
>> +
>> +struct stm32_reset_data {
>> +	struct reset_controller_dev	rcdev;
>> +	void __iomem			*membase;
>> +};
>> +
>> +static inline struct stm32_reset_data *
>> +to_stm32_reset_data(struct reset_controller_dev *rcdev)
>> +{
>> +	return container_of(rcdev, struct stm32_reset_data, rcdev);
>> +}
>> +
>> +static int stm32_reset_update(struct reset_controller_dev *rcdev,
>> +			      unsigned long id, bool assert)
>> +{
>> +	struct stm32_reset_data *data = to_stm32_reset_data(rcdev);
>> +	int reg_width = sizeof(u32);
>> +	int bank = id / (reg_width * BITS_PER_BYTE);
>> +	int offset = id % (reg_width * BITS_PER_BYTE);
>> +	void __iomem *addr;
>> +
>> +	addr = data->membase + (bank * reg_width);
>> +	if (!assert)
>> +		addr += CLR_OFFSET;
>> +
>> +	writel(BIT(offset), addr);
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_reset_assert(struct reset_controller_dev *rcdev,
>> +			      unsigned long id)
>> +{
>> +	return stm32_reset_update(rcdev, id, true);
>> +}
>> +
>> +static int stm32_reset_deassert(struct reset_controller_dev *rcdev,
>> +				unsigned long id)
>> +{
>> +	return stm32_reset_update(rcdev, id, false);
>> +}
>> +
>> +static int stm32_reset_status(struct reset_controller_dev *rcdev,
>> +			      unsigned long id)
>> +{
>> +	struct stm32_reset_data *data = to_stm32_reset_data(rcdev);
>> +	int reg_width = sizeof(u32);
>> +	int bank = id / (reg_width * BITS_PER_BYTE);
>> +	int offset = id % (reg_width * BITS_PER_BYTE);
>> +	u32 reg;
>> +
>> +	reg = readl(data->membase + (bank * reg_width));
>> +
>> +	return !(reg & BIT(offset));
>> +}
> So the SET register can be read back and returns 0 for reset lines that
> are currently asserted and returns 1 for reset lines that are currently
> deasserted?
yes you have spotted a error, i will replace by'return !!(reg & 
BIT(offset));'
>> +
>> +const struct reset_control_ops stm32_reset_ops = {
>> +	.assert		= stm32_reset_assert,
>> +	.deassert	= stm32_reset_deassert,
>> +	.status		= stm32_reset_status,
>> +};
>> +
>> +static const struct of_device_id stm32_reset_dt_ids[] = {
>> +	{ .compatible = "st,stm32mp1-rcc"},
>> +	{ /* sentinel */ },
>> +};
>  From the DT bindings it looks like the clock and reset drivers are
> sharing the same node. Is there just no clock platform_driver at all?
there is one hardware block that is used for clock, reset and power, 
they share the same node but each have it own platform_driver

>> +
>> +static int stm32_reset_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct stm32_reset_data *data;
>> +	void __iomem *membase;
>> +	struct resource *res;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	membase = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(membase))
>> +		return PTR_ERR(membase);
>> +
>> +	data->membase = membase;
>> +	data->rcdev.owner = THIS_MODULE;
>> +	data->rcdev.nr_resets = resource_size(res) * BITS_PER_BYTE;
>> +	data->rcdev.ops = &stm32_reset_ops;
>> +	data->rcdev.of_node = dev->of_node;
>> +
>> +	return devm_reset_controller_register(dev, &data->rcdev);
>> +}
>> +
>> +static struct platform_driver stm32_reset_driver = {
>> +	.probe	= stm32_reset_probe,
>> +	.driver = {
>> +		.name		= "stm32mp1-reset",
>> +		.of_match_table	= stm32_reset_dt_ids,
>> +	},
>> +};
>> +
>> +static int __init stm32_reset_init(void)
>> +{
>> +	return platform_driver_register(&stm32_reset_driver);
>> +}
>> +
>> +postcore_initcall(stm32_reset_init);
> Isn't builtin_platform_driver early enough?
ok

Best Regards

Gabriel

>
> regards
> Philipp
