Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbeBSQ6e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:58:34 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57954 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753400AbeBSQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:58:31 -0500
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Lee Jones <lee.jones@linaro.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/6] mfd: Add ST Multi-Function eXpander core driver
Thread-Topic: [PATCH 2/6] mfd: Add ST Multi-Function eXpander core driver
Thread-Index: AQHToOkCMgAtE6p6MUacifCOH+p/o6OgoRsAgAtR4YA=
Date: Mon, 19 Feb 2018 16:57:56 +0000
Message-ID: <91ab70f9-0fd5-12fc-1424-c6186efa47b4@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-3-git-send-email-amelie.delaunay@st.com>
 <20180212120600.5cghrzz4jqvvkgz6@dell>
In-Reply-To: <20180212120600.5cghrzz4jqvvkgz6@dell>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF267DE6D9D0D549AA42E35F75581E39@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1JGwc7c023096



On 02/12/2018 01:06 PM, Lee Jones wrote:
> On Thu, 08 Feb 2018, Amelie Delaunay wrote:
> 
>> ST Multi-Function eXpander (MFX) is a slave controller using I2C
>> for communication with the main MCU. Main features are:
>> - 16 fast GPIOs individually configurable in input/output
>> - 8 alternate GPIOs individually configurable in input/output
>> - Main MCU IDD measurement
>> - Resistive touchscreen controller
>>
>> Only GPIO expander (16 fast GPIOs + 8 alternate) feature is
>> supported for the moment.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   drivers/mfd/Kconfig        |  15 ++
>>   drivers/mfd/Makefile       |   1 +
>>   drivers/mfd/st-mfx.c       | 526 +++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/st-mfx.h | 116 ++++++++++
>>   4 files changed, 658 insertions(+)
>>   create mode 100644 drivers/mfd/st-mfx.c
>>   create mode 100644 include/linux/mfd/st-mfx.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 1d20a80..e78e818 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1823,6 +1823,21 @@ config MFD_STM32_TIMERS
>>   	  for PWM and IIO Timer. This driver allow to share the
>>   	  registers between the others drivers.
>>   
>> +config MFD_ST_MFX
>> +	bool "STMicroelectronics MFX"
>> +	depends on I2C
>> +	depends on OF || COMPILE_TEST
>> +	select MFD_CORE
>> +	select REGMAP_I2C
>> +	help
>> +	  Support for the STMicroelectronics Multi-Function eXpander.
> 
> Is that really what this device is called?
Yes, all STMicroelectronics Evaluation boards and Discovery kits (using 
an expansion device) user manuals refer to "MFX (Multi Function eXpander)".
> 
> Is there a datasheet?
> 
>> +	  This driver provides common support for accessing the device,
>> +	  additional drivers must be enabled in order to use the functionality
>> +	  of the device. Currently available sub drivers are:
>> +
>> +		GPIO: mfx-gpio
> 
> This driver would be easier to review if I could picture the device as
> a whole.  What other functionality does it have?  What is it that
> makes this an MFD?
>
MFX is a slave controller based on the STM32L152CCT6 MCU.
MFX firmware integrates 3 features:
- main MCU IDD measurement: this allows measurement of the IDD current 
consumed by the main MCU, especially for static measurement in low power 
mode.
- resistive touchscreen controller, using ADC inputs of STM32L152CCT6.
- GPIO expander: 16 programmable input/output + 8 alternate GPIO 
(Touchscreen controller uses the four first gpios of this bank when 
enabled, IDD used the 4 last ones when enabled).

IDD measurement driver and touchscreen driver have not been developed 
yet because I have no hardware to test it. But anyway, I will send a V2 
with gpio driver only.

>>   menu "Multimedia Capabilities Port drivers"
>>   	depends on ARCH_SA1100
>>   
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index d9474ad..1379a18 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -230,3 +230,4 @@ obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
>>   obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
>>   obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
>>   obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
>> +obj-$(CONFIG_MFD_ST_MFX) 	+= st-mfx.o
>> diff --git a/drivers/mfd/st-mfx.c b/drivers/mfd/st-mfx.c
>> new file mode 100644
>> index 0000000..5bee5d3
>> --- /dev/null
>> +++ b/drivers/mfd/st-mfx.c
>> @@ -0,0 +1,526 @@
>> +/*
>> + * STMicroelectronics Multi-Function eXpander (ST-MFX) Core Driver
>> + *
>> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>> + * Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
> 
> You don't need to put "for STMicroelectronics".  This was something we
> made up when submitting from a different (!st.com) email address.
> 
OK, I will fix it in gpio driver for V2.
>> + * License terms: GPL V2.0.
>> + *
>> + * st-mfx Core Driver is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + *
>> + * st-mfx Core Driver is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
>> + * details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * st-mfx Core Driver. If not, see <http://www.gnu.org/licenses/>.
> 
> You should be able to use the short version of the licensing
> agreement.  Also, please grep for "SPDX".
> 
OK.
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/st-mfx.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/regmap.h>
>> +
>> +/**
>> + * struct mfx_priv - MFX MFD private structure
>> + * @dev: device, mostly for logs
>> + * @regmap: register map
>> + * @mfx: MFX MFD public structure, to share information with subdrivers
>> + * @irq_domain: IRQ domain
>> + * @irq: IRQ number for mfx
>> + * @irq_lock: IRQ bus lock
>> + * @irqen: cache of IRQ_SRC_EN register for bus_lock
>> + * @oldirqen: cache of IRQ_SRC_EN register for bus_lock
>> + */
> 
> /**
>   * struct mfx_priv - MFX MFD private structure
>   * @dev:  	   device, mostly for logs
>   * @regmap: 	   register map
>   * @mfx: 	   MFX MFD public structure, to share information with subdrivers
>   * @irq_domain:    IRQ domain
>   * @irq: 	   IRQ number for mfx
>   * @irq_lock: 	   IRQ bus lock
>   * @irqen: 	   cache of IRQ_SRC_EN register for bus_lock
>   * @oldirqen: 	   cache of IRQ_SRC_EN register for bus_lock
>   */
> 
> Easier to read?
> 
I will pay attention to the indentation in gpio driver V2.
>> +struct mfx_priv {
> 
> mfx_ddata
> 
OK.
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	struct mfx mfx;
>> +	struct irq_domain *irq_domain;
>> +	int irq;
>> +	struct mutex irq_lock; /* IRQ bus lock */
>> +	u8 irqen;
>> +	u8 oldirqen;
>> +};
>> +
>> +#define to_mfx_priv(_mfx) container_of(_mfx, struct mfx_priv, mfx)
> 
> FYI: I don't like this idea.  More to follow.
> 
>> +/* MFX boot time is around 10ms, so after reset, we have to wait this delay */
>> +#define MFX_BOOT_TIME 10
> 
> MFX_BOOT_TIME_MS
> 
OK.
>> +static u8 mfx_blocks_to_mask(u32 blocks)
> 
> I think it would be better to prepend a vendor tag to everything too.
> 
>    st_mfx_*
> 
OK.
>> +{
>> +	u8 mask = 0;
>> +
>> +	if (blocks & MFX_BLOCK_GPIO)
>> +		mask |= MFX_REG_SYS_CTRL_GPIO_EN;
>> +	else
>> +		mask &= ~MFX_REG_SYS_CTRL_GPIO_EN;
>> +
>> +	if (blocks & MFX_BLOCK_TS)
>> +		mask |= MFX_REG_SYS_CTRL_TS_EN;
>> +	else
>> +		mask &= ~MFX_REG_SYS_CTRL_TS_EN;
>> +
>> +	if (blocks & MFX_BLOCK_IDD)
>> +		mask |= MFX_REG_SYS_CTRL_IDD_EN;
>> +	else
>> +		mask &= ~MFX_REG_SYS_CTRL_IDD_EN;
>> +
>> +	if (blocks & MFX_BLOCK_ALTGPIO)
>> +		mask |= MFX_REG_SYS_CTRL_ALTGPIO_EN;
>> +	else
>> +		mask &= ~MFX_REG_SYS_CTRL_ALTGPIO_EN;
>> +
>> +	return mask;
>> +}
>> +
>> +static int mfx_reset(struct mfx *mfx)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(mfx);
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(mfx_priv->regmap, MFX_REG_SYS_CTRL,
>> +				 MFX_REG_SYS_CTRL_SWRST,
>> +				 MFX_REG_SYS_CTRL_SWRST);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	msleep(MFX_BOOT_TIME);
>> +
>> +	return ret;
>> +}
>> +
>> +int mfx_block_read(struct mfx *mfx, u8 reg, u8 length, u8 *values)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(mfx);
>> +
>> +	return regmap_bulk_read(mfx_priv->regmap, reg, values, length);
>> +}
>> +EXPORT_SYMBOL_GPL(mfx_block_read);
>> +
>> +int mfx_block_write(struct mfx *mfx, u8 reg, u8 length, const u8 *values)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(mfx);
>> +
>> +	return regmap_bulk_write(mfx_priv->regmap, reg, values, length);
>> +}
>> +EXPORT_SYMBOL_GPL(mfx_block_write);
>> +
>> +int mfx_reg_read(struct mfx *mfx, u8 reg)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(mfx);
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = regmap_read(mfx_priv->regmap, reg, &val);
>> +
>> +	return ret ? ret : val;
>> +}
>> +EXPORT_SYMBOL_GPL(mfx_reg_read);
>> +
>> +int mfx_reg_write(struct mfx *mfx, u8 reg, u8 val)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(mfx);
>> +
>> +	return regmap_write(mfx_priv->regmap, reg, val);
>> +}
>> +EXPORT_SYMBOL_GPL(mfx_reg_write);
>> +
>> +int mfx_set_bits(struct mfx *mfx, u8 reg, u8 mask, u8 val)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(mfx);
>> +
>> +	return regmap_update_bits(mfx_priv->regmap, reg, mask, val);
>> +}
>> +EXPORT_SYMBOL_GPL(mfx_set_bits);
>> +
>> +int mfx_enable(struct mfx *mfx, u32 blocks)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(mfx);
>> +	u8 mask = mfx_blocks_to_mask(blocks);
>> +
>> +	return regmap_update_bits(mfx_priv->regmap, MFX_REG_SYS_CTRL,
>> +				  mask, mask);
>> +}
>> +EXPORT_SYMBOL_GPL(mfx_enable);
>> +
>> +int mfx_disable(struct mfx *mfx, u32 blocks)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(mfx);
>> +	u8 mask = mfx_blocks_to_mask(blocks);
>> +
>> +	return regmap_update_bits(mfx_priv->regmap, MFX_REG_SYS_CTRL,
>> +				  mask, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(mfx_disable);
> 
> The remap infrastructure doesn't need further abstraction.  Please
> pass the pointer to any child devices and have them use it directly.
> 
I will keep it in mind if the need of other features aruses, justifying 
the use of an MFD.
>> +static void mfx_irq_lock(struct irq_data *data)
>> +{
>> +	struct mfx_priv *mfx_priv = irq_data_get_irq_chip_data(data);
>> +
>> +	mutex_lock(&mfx_priv->irq_lock);
>> +}
>> +
>> +static void mfx_irq_sync_unlock(struct irq_data *data)
>> +{
>> +	struct mfx_priv *mfx_priv = irq_data_get_irq_chip_data(data);
>> +	u8 new = mfx_priv->irqen;
>> +	u8 old = mfx_priv->oldirqen;
>> +
>> +	if (new == old)
>> +		goto unlock;
>> +
>> +	mfx_priv->oldirqen = new;
>> +	mfx_reg_write(&mfx_priv->mfx, MFX_REG_IRQ_SRC_EN, new);
>> +unlock:
>> +	mutex_unlock(&mfx_priv->irq_lock);
>> +}
>> +
>> +static void mfx_irq_mask(struct irq_data *data)
>> +{
>> +	struct mfx_priv *mfx_priv = irq_data_get_irq_chip_data(data);
>> +
>> +	mfx_priv->irqen &= ~BIT(data->hwirq % 8);
>> +}
>> +
>> +static void mfx_irq_unmask(struct irq_data *data)
>> +{
>> +	struct mfx_priv *mfx_priv = irq_data_get_irq_chip_data(data);
>> +
>> +	mfx_priv->irqen |= BIT(data->hwirq % 8);
>> +}
>> +
>> +static struct irq_chip mfx_irq_chip = {
>> +	.name			= "mfx",
>> +	.irq_bus_lock		= mfx_irq_lock,
>> +	.irq_bus_sync_unlock	= mfx_irq_sync_unlock,
>> +	.irq_mask		= mfx_irq_mask,
>> +	.irq_unmask		= mfx_irq_unmask,
>> +};
>> +
>> +static irqreturn_t mfx_irq(int irq, void *data)
>> +{
>> +	struct mfx_priv *mfx_priv = data;
> 
> 'ddata' is a more consistent naming approach.
> 
OK.
>> +	unsigned long status, bit;
>> +	u8 ack;
>> +	int ret;
>> +
>> +	ret = mfx_reg_read(&mfx_priv->mfx, MFX_REG_IRQ_PENDING);
>> +	if (ret < 0) {
>> +		dev_err(mfx_priv->dev, "can't get IRQ_PENDING: %d\n", ret);
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	/* It can be GPIO, IDD, ERROR, TS* IRQs */
>> +	status = ret & mfx_priv->irqen;
>> +
>> +	/*
>> +	 * There is no ACK for GPIO, MFX_REG_IRQ_PENDING_GPIO is a logical OR
>> +	 * of MFX_REG_IRQ_GPI _PENDING1/_PENDING2/_PENDING3
>> +	 */
>> +	ack = status & ~MFX_REG_IRQ_PENDING_GPIO;
>> +
>> +	for_each_set_bit(bit, &status, 8)
>> +		handle_nested_irq(irq_find_mapping(mfx_priv->irq_domain, bit));
>> +
>> +	if (ack)
>> +		mfx_reg_write(&mfx_priv->mfx, MFX_REG_IRQ_ACK, ack);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int mfx_irq_map(struct irq_domain *d, unsigned int virq,
>> +		       irq_hw_number_t hwirq)
>> +{
>> +	struct mfx_priv *mfx_priv = d->host_data;
>> +
>> +	irq_set_chip_data(virq, mfx_priv);
>> +	irq_set_chip(virq, &mfx_irq_chip);
>> +	irq_set_nested_thread(virq, 1);
>> +	irq_set_parent(virq, mfx_priv->irq);
>> +	irq_set_noprobe(virq);
>> +
>> +	return 0;
>> +}
>> +
>> +static void mfx_irq_unmap(struct irq_domain *d, unsigned int virq)
>> +{
>> +	irq_set_chip_and_handler(virq, NULL, NULL);
>> +	irq_set_chip_data(virq, NULL);
>> +}
>> +
>> +static const struct irq_domain_ops mfx_irq_ops = {
>> +	.map = mfx_irq_map,
>> +	.unmap = mfx_irq_unmap,
>> +	.xlate = irq_domain_xlate_onecell,
>> +};
>> +
>> +static int mfx_irq_init(struct mfx_priv *mfx_priv, struct device_node *np)
>> +{
>> +	int irqoutpin = MFX_REG_IRQ_OUT_PIN_TYPE; /* Push-Pull */
>> +	int irqtrigger, ret;
>> +
>> +	mfx_priv->irq = of_irq_get(np, 0);
>> +	if (mfx_priv->irq > 0) {
>> +		irqtrigger = irq_get_trigger_type(mfx_priv->irq);
>> +	} else {
>> +		dev_err(mfx_priv->dev, "failed to get irq: %d\n",
>> +			mfx_priv->irq);
>> +		return mfx_priv->irq;
>> +	}
>> +
>> +	if ((irqtrigger & IRQ_TYPE_EDGE_FALLING) ||
>> +	    (irqtrigger & IRQ_TYPE_LEVEL_LOW))
>> +		irqoutpin &= ~MFX_REG_IRQ_OUT_PIN_POL; /* Active Low */
>> +	else
>> +		irqoutpin |= MFX_REG_IRQ_OUT_PIN_POL; /* Active High */
>> +
>> +	mfx_reg_write(&mfx_priv->mfx, MFX_REG_IRQ_OUT_PIN, irqoutpin);
>> +
>> +	mfx_priv->irq_domain = irq_domain_add_linear(np, MFX_IRQ_SRC_NR,
>> +						     &mfx_irq_ops, mfx_priv);
>> +	if (!mfx_priv->irq_domain) {
>> +		dev_err(mfx_priv->dev, "failed to create irq domain\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = devm_request_threaded_irq(mfx_priv->dev, mfx_priv->irq,
>> +					NULL, mfx_irq,
>> +					irqtrigger | IRQF_ONESHOT, "mfx",
>> +					mfx_priv);
>> +	if (ret) {
>> +		dev_err(mfx_priv->dev, "failed to request irq: %d\n", ret);
>> +		irq_domain_remove(mfx_priv->irq_domain);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void mfx_irq_remove(struct mfx_priv *mfx_priv)
>> +{
>> +	int hwirq;
>> +
>> +	for (hwirq = 0; hwirq < MFX_IRQ_SRC_NR; hwirq++)
>> +		irq_dispose_mapping(irq_find_mapping(mfx_priv->irq_domain,
>> +						     hwirq));
>> +	irq_domain_remove(mfx_priv->irq_domain);
>> +}
> 
> Is there any reason why this IRQ stuff can't live in the GPIO driver?
> 
MFX has a first level of interrupts (8 sources), with touscreen 
interrupts, idd interrupt and gpio interrupt. Then gpio has its own 
level of interrupts, with 24 possible sources.
GPIO interrupts are raised through MFX_IRQ_OUT pin only if at least one 
source is enabled at gpio level, and gpio interrupt is enabled at MFX level.
               _TS_OVF
              |_TS_FULL
              |_TS_TH
              |_TS_NE
MFX_IRQ_OUT < _TS_DET
              |_ERROR(IDD)     _ GPIO0
              |_IDD           |
              |_GPIO---------<...
                              |_ GPIO23
>> +static int mfx_chip_init(struct mfx_priv *mfx_priv, u16 i2c_addr)
>> +{
>> +	struct mfx *mfx = &mfx_priv->mfx;
>> +	int ret;
>> +	int id;
>> +	u8 version[2];
>> +
>> +	id = mfx_reg_read(mfx, MFX_REG_CHIP_ID);
>> +	if (id < 0) {
>> +		dev_err(mfx_priv->dev, "error reading chip id: %d\n", id);
>> +		return id;
>> +	}
>> +
>> +	ret = mfx_block_read(mfx, MFX_REG_FW_VERSION_MSB,
>> +			     ARRAY_SIZE(version), version);
>> +	if (ret < 0) {
>> +		dev_err(mfx_priv->dev, "error reading fw version: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Check that ID is the complement of the I2C address:
>> +	 * MFX I2C address follows the 7-bit format (MSB), that's why
>> +	 * i2c_addr is shifted.
>> +	 *
>> +	 * MFX_I2C_ADDR |         MFX         |        Linux
>> +	 *  input pin   | I2C device address  | I2C device address
>> +	 *--------------------------------------------------------
>> +	 *      0       | b: 1000 010x h:0x84 |       0x42
>> +	 *      1       | b: 1000 011x h:0x86 |       0x43
>> +	 */
>> +	if (FIELD_GET(MFX_REG_CHIP_ID_MASK, ~id) != (i2c_addr << 1)) {
>> +		dev_err(mfx_priv->dev, "unknown chip id: %#x\n", id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_info(mfx_priv->dev, "ST-MFX chip id: %#x, fw version: %x.%02x\n",
>> +		 id, version[0], version[1]);
>> +
>> +	/* Disable all features, subdrivers should enable what they need */
>> +	ret = mfx_disable(mfx, ~0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return mfx_reset(mfx);
>> +}
>> +
>> +static const struct regmap_config mfx_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +};
>> +
>> +static const struct of_device_id mfx_of_match[] = {
>> +	{ .compatible = "st,mfx" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mfx_of_match);
>> +
>> +static int mfx_of_probe(struct device_node *np, struct mfx_priv *mfx_priv)
>> +{
>> +	struct device_node *child;
>> +
>> +	if (!np)
>> +		return -ENODEV;
> 
> Is this even possible?
> 
> Do you support !OF?
> 
No.
>> +	for_each_child_of_node(np, child) {
>> +		if (of_device_is_compatible(child, "st,mfx-gpio")) {
>> +			mfx_priv->mfx.blocks |= MFX_BLOCK_GPIO;
>> +			mfx_priv->mfx.num_gpio = 16;
> 
> This is ugly.
> 
> Where is num_gpio used?
> 
Was used in gpio driver. But anyway this will disappear in V2.
>> +		}
>> +		/*
>> +		 * Here we could find other children like "st,mfx-ts" or
>> +		 * "st,mfx-idd.
>> +		 */
>> +	}
>> +
>> +	if (!(mfx_priv->mfx.blocks & MFX_BLOCK_TS) &&
>> +	    !(mfx_priv->mfx.blocks & MFX_BLOCK_IDD)) {
>> +		mfx_priv->mfx.blocks |= MFX_BLOCK_ALTGPIO;
>> +		mfx_priv->mfx.num_gpio += 8;
>> +	}
> 
> What are TS and IDD?
> 
> This is starting to look like a GPIO driver, and nothing more.
> 
Without touschreen controller driver and idd measurement driver, 
definitely yes.
>> +	/*
>> +	 * TODO: aGPIO[3:0] and aGPIO[7:4] can be used independently:
>> +	 * - if IDD is used but not TS, aGPIO[3:0] can be used as GPIO,
>> +	 * - if TS is used but not IDD: aGPIO[7:4] can be used as GPIO.
>> +	 */
>> +
>> +	return of_platform_populate(np, NULL, NULL, mfx_priv->dev);
>> +}
>> +
>> +int mfx_probe(struct i2c_client *client, const struct i2c_device_id *id)
>> +{
>> +	struct device_node *np = client->dev.of_node;
>> +	struct mfx_priv *mfx_priv;
>> +	int ret;
>> +
>> +	mfx_priv = devm_kzalloc(&client->dev, sizeof(struct mfx_priv),
>> +				GFP_KERNEL);
>> +	if (!mfx_priv)
>> +		return -ENOMEM;
>> +
>> +	mfx_priv->regmap = devm_regmap_init_i2c(client, &mfx_regmap_config);
>> +	if (IS_ERR(mfx_priv->regmap)) {
>> +		ret = PTR_ERR(mfx_priv->regmap);
>> +		dev_err(&client->dev, "failed to allocate register map: %d\n",
>> +			ret);
> 
> Nit: Prefer if you broke the line after '&client->dev,'.
> 
OK.
>> +		return ret;
>> +	}
>> +
>> +	mfx_priv->dev = &client->dev;
> 
> 
>> +	i2c_set_clientdata(client, &mfx_priv->mfx);
>> +
>> +	mutex_init(&mfx_priv->irq_lock);
>> +
>> +	ret = mfx_chip_init(mfx_priv, client->addr);
>> +	if (ret) {
>> +		if (ret == -ETIMEDOUT)
>> +			return -EPROBE_DEFER;
> 
> Return -EPROBE_DEFER from reset() instead.
> 
OK.
>> +		return ret;
>> +	}
>> +
>> +	ret = mfx_irq_init(mfx_priv, np);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = mfx_of_probe(np, mfx_priv);
>> +	if (ret < 0)
>> +		return ret;
> 
> Is it possible to build with !OF?
> 
> If not, move all probe code into here.
> 
>> +	dev_info(mfx_priv->dev, "ST-MFX (CORE) initialized\n");
> 
> These kinds of messages are usually frowned upon.
> 
OK.
>> +	return 0;
>> +}
>> +
>> +static int mfx_remove(struct i2c_client *client)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(i2c_get_clientdata(client));
>> +
>> +	mfx_irq_remove(mfx_priv);
>> +	of_platform_depopulate(mfx_priv->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int mfx_suspend(struct device *dev)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(dev_get_drvdata(dev));
>> +
>> +	if (device_may_wakeup(dev))
>> +		enable_irq_wake(mfx_priv->irq);
>> +
>> +	/*
>> +	 * TODO: Do we put MFX in STANDBY mode ?
>> +	 * (Wakeup by rising edge on MFX_wakeup pin)
>> +	 */
> 
> How long before you answer this question?
> 
> Better do just enable it right away or make a mental note and remove
> the comment from the upstream driver.
> 
>> +	return 0;
>> +}
>> +
>> +static int mfx_resume(struct device *dev)
>> +{
>> +	struct mfx_priv *mfx_priv = to_mfx_priv(dev_get_drvdata(dev));
>> +
>> +	if (device_may_wakeup(dev))
>> +		disable_irq_wake(mfx_priv->irq);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(mfx_dev_pm_ops, mfx_suspend, mfx_resume);
>> +
>> +static const struct i2c_device_id mfx_i2c_id[] = {
>> +	{ "mfx", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, mfx_id);
> 
> I don't think this is required anymore.
> 
You're right.

Thanks for review,
Amelie
>> +static struct i2c_driver mfx_driver = {
>> +	.driver = {
>> +		.name = "st-mfx",
>> +		.pm = &mfx_dev_pm_ops,
>> +		.of_match_table = mfx_of_match,
>> +	},
>> +	.probe = mfx_probe,
>> +	.remove = mfx_remove,
>> +	.id_table = mfx_i2c_id,
>> +};
>> +
>> +static int __init mfx_init(void)
>> +{
>> +	return i2c_add_driver(&mfx_driver);
>> +}
>> +subsys_initcall(mfx_init);
>> +
>> +static void __exit mfx_exit(void)
>> +{
>> +	i2c_del_driver(&mfx_driver);
>> +}
>> +module_exit(mfx_exit);
>> +
>> +MODULE_DESCRIPTION("STMicroelectronics Multi-Function eXpander MFD core driver");
>> +MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@st.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/mfd/st-mfx.h b/include/linux/mfd/st-mfx.h
>> new file mode 100644
>> index 0000000..1bf7e65
>> --- /dev/null
>> +++ b/include/linux/mfd/st-mfx.h
>> @@ -0,0 +1,116 @@
>> +/*
>> + * STMicroelectronics Multi-Function eXpander (ST-MFX)
>> + *
>> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>> + * Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
>> + *
>> + * License terms: GPL V2.0.
>> + *
>> + * st-mfx is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + *
>> + * st-mfx is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
>> + * details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * st-mfx. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __MFD_ST_MFX_H
>> +#define __MFD_ST_MFX_H
>> +
>> +enum mfx_block {
>> +	MFX_BLOCK_GPIO		= BIT(0),
>> +	MFX_BLOCK_TS		= BIT(1),
>> +	MFX_BLOCK_IDD		= BIT(2),
>> +	MFX_BLOCK_ALTGPIO	= BIT(3),
>> +};
>> +
>> +/*
>> + * 8 events can activate the MFX_IRQ_OUT signal,
>> + * but for the moment, only GPIO event is used
>> + */
>> +enum mfx_irq {
>> +	MFX_IRQ_SRC_GPIO,
>> +
>> +	MFX_IRQ_SRC_NR,
>> +};
>> +
>> +/**
>> + * struct mfx - MFX MFD structure
>> + * @blocks: mask of mfx_block to be enabled
>> + * @num_gpio: number of gpios
>> + */
>> +struct mfx {
>> +	u32 blocks;
>> +	u32 num_gpio;
>> +};
>> +
>> +int mfx_reg_write(struct mfx *mfx, u8 reg, u8 data);
>> +int mfx_reg_read(struct mfx *mfx, u8 reg);
>> +int mfx_block_read(struct mfx *mfx, u8 reg, u8 length, u8 *values);
>> +int mfx_block_write(struct mfx *mfx, u8 reg, u8 length, const u8 *values);
>> +int mfx_set_bits(struct mfx *mfx, u8 reg, u8 mask, u8 val);
>> +int mfx_enable(struct mfx *mfx, unsigned int blocks);
>> +int mfx_disable(struct mfx *mfx, unsigned int blocks);
>> +
>> +/* General */
>> +#define MFX_REG_CHIP_ID			0x00 /* R */
>> +#define MFX_REG_FW_VERSION_MSB		0x01 /* R */
>> +#define MFX_REG_FW_VERSION_LSB		0x02 /* R */
>> +#define MFX_REG_SYS_CTRL		0x40 /* RW */
>> +/* IRQ output management */
>> +#define MFX_REG_IRQ_OUT_PIN		0x41 /* RW */
>> +#define MFX_REG_IRQ_SRC_EN		0x42 /* RW */
>> +#define MFX_REG_IRQ_PENDING		0x08 /* R */
>> +#define MFX_REG_IRQ_ACK			0x44 /* RW */
>> +/* GPIOs expander */
>> +/* GPIO_STATE1 0x10, GPIO_STATE2 0x11, GPIO_STATE3 0x12 */
>> +#define MFX_REG_GPIO_STATE		0x10 /* R */
>> +/* GPIO_DIR1 0x60, GPIO_DIR2 0x61, GPIO_DIR3 0x63 */
>> +#define MFX_REG_GPIO_DIR		0x60 /* RW */
>> +/* GPIO_TYPE1 0x64, GPIO_TYPE2 0x65, GPIO_TYPE3 0x66 */
>> +#define MFX_REG_GPIO_TYPE		0x64 /* RW */
>> +/* GPIO_PUPD1 0x68, GPIO_PUPD2 0x69, GPIO_PUPD3 0x6A */
>> +#define MFX_REG_GPIO_PUPD		0x68 /* RW */
>> +/* GPO_SET1 0x6C, GPO_SET2 0x6D, GPO_SET3 0x6E */
>> +#define MFX_REG_GPO_SET			0x6C /* RW */
>> +/* GPO_CLR1 0x70, GPO_CLR2 0x71, GPO_CLR3 0x72 */
>> +#define MFX_REG_GPO_CLR			0x70 /* RW */
>> +/* IRQ_GPI_SRC1 0x48, IRQ_GPI_SRC2 0x49, IRQ_GPI_SRC3 0x4A */
>> +#define MFX_REG_IRQ_GPI_SRC		0x48 /* RW */
>> +/* IRQ_GPI_EVT1 0x4C, IRQ_GPI_EVT2 0x4D, IRQ_GPI_EVT3 0x4E */
>> +#define MFX_REG_IRQ_GPI_EVT		0x4C /* RW */
>> +/* IRQ_GPI_TYPE1 0x50, IRQ_GPI_TYPE2 0x51, IRQ_GPI_TYPE3 0x52 */
>> +#define MFX_REG_IRQ_GPI_TYPE		0x50 /* RW */
>> +/* IRQ_GPI_PENDING1 0x0C, IRQ_GPI_PENDING2 0x0D, IRQ_GPI_PENDING3 0x0E*/
>> +#define MFX_REG_IRQ_GPI_PENDING		0x0C /* R */
>> +/* IRQ_GPI_ACK1 0x54, IRQ_GPI_ACK2 0x55, IRQ_GPI_ACK3 0x56 */
>> +#define MFX_REG_IRQ_GPI_ACK		0x54 /* RW */
>> +
>> +/* MFX_REG_CHIP_ID bitfields */
>> +#define MFX_REG_CHIP_ID_MASK		GENMASK(7, 0)
>> +
>> +/* MFX_REG_SYS_CTRL bitfields */
>> +#define MFX_REG_SYS_CTRL_GPIO_EN	BIT(0)
>> +#define MFX_REG_SYS_CTRL_TS_EN		BIT(1)
>> +#define MFX_REG_SYS_CTRL_IDD_EN		BIT(2)
>> +#define MFX_REG_SYS_CTRL_ALTGPIO_EN	BIT(3)
>> +#define MFX_REG_SYS_CTRL_STANDBY	BIT(6)
>> +#define MFX_REG_SYS_CTRL_SWRST		BIT(7)
>> +
>> +/* MFX_REG_IRQ_OUT_PIN bitfields */
>> +#define MFX_REG_IRQ_OUT_PIN_TYPE	BIT(0) /* 0-OD 1-PP */
>> +#define MFX_REG_IRQ_OUT_PIN_POL		BIT(1) /* 0-active LOW 1-active HIGH */
>> +
>> +/* MFX_REG_IRQ_SRC_EN bitfields */
>> +#define MFX_REG_IRQ_SRC_EN_GPIO		BIT(0)
>> +
>> +/* MFX_REG_IRQ_PENDING bitfields */
>> +#define MFX_REG_IRQ_PENDING_GPIO	BIT(0)
>> +
>> +#endif /* __MFD_ST_MFX_H */
>> +
> 
