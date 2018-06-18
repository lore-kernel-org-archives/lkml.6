Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8205DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A86920652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A86920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937074AbeFRKUb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:20:31 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:49594 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933818AbeFRKU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:20:26 -0400
Received: from [10.103.176.24] (94.197.120.225.threembb.co.uk [94.197.120.225])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 2DB299E8544;
        Mon, 18 Jun 2018 11:20:17 +0100 (BST)
Date:   Mon, 18 Jun 2018 11:20:08 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMz4kuLVtdbBaNBY6e8F9fPuSBo60HGxzJ2wsW-dDV9-iOsfDg@mail.gmail.com>
References: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org> <5728839377cefd20cdb95913b43dbdab530c1e81.1529040864.git.baolin.wang@linaro.org> <20180616193540.6ed717f7@archlinux> <CAMz4kuLVtdbBaNBY6e8F9fPuSBo60HGxzJ2wsW-dDV9-iOsfDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 2/2] iio: adc: Add Spreadtrum SC27XX PMICs ADC support
To:     Baolin Wang <baolin.wang@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@spreadtrum.com, Mark Brown <broonie@kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <2E8CE82E-41FD-4DA8-8969-FD5ADA229464@jic23.retrosnub.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17 June 2018 09:03:04 BST, Baolin Wang <baolin.wang@linaro.org> wrote:
>Hi Jonathan,
>
>On 17 June 2018 at 02:35, Jonathan Cameron <jic23@kernel.org> wrote:
>> On Fri, 15 Jun 2018 15:03:36 +0800
>> Baolin Wang <baolin.wang@linaro.org> wrote:
>>
>>> From: Freeman Liu <freeman.liu@spreadtrum.com>
>>>
>>> The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
>>> which is used to sample voltages with 12 bits conversion.
>>>
>>> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>
>> Hi,
>>
>> There are some race conditions around the probe and remove.
>> More care is needed when we have a mixture of managed and unmanaged
>cleanup
>> like here.
>
>Thanks to point the race issue.
>
>>
>> I'm not understanding the way you have exposed a simple _raw and
>_scale
>> attributes with what looks to be different scaling to that applied
>> in _processed.   As I say below, we should not have both of those
>interface
>> options anyway.  The ABI is that (X_raw + X_offset)*X_scale =
>X_processed.
>> (with defaults of X_scale = 1 and X_offset = 0).
>
>See below comments.
>
>>
>> Please rename to avoid using wild cards in the name.  That's gone
>> wrong so many times in the past you wouldn't believe it!
>> Hmm Awkward though if the MFD is already upstream. Ah well, I guess
>> for consistency we should follow that and groan when it goes wrong.
>
>Can I rename to be 'sprd-pmic-adc.c'? I can not rename it as
>'sc2731-adc', we have differnet PMICs (SC2730, SC2731, SC2720 etc.),
>but they are all integrated the same ADC controller.

You can rename as this is a common problem throughout drivers. There is no good solution.

Given mfd naming, just leave it with wild cards as better than a name no one will recognise 
>
>>> ---
>>> Changes since v1:
>>>  - Add const for static structures definition.
>>>  - Change SC27XX_ADC_TO_VOLTAGE macro to be one function.
>>>  - Move channel scale accessing into mutex protection.
>>>  - Fix some typos.
>>> ---
>>>  drivers/iio/adc/Kconfig      |   10 +
>>>  drivers/iio/adc/Makefile     |    1 +
>>>  drivers/iio/adc/sc27xx_adc.c |  547
>++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 558 insertions(+)
>>>  create mode 100644 drivers/iio/adc/sc27xx_adc.c
>>>
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index 9da7907..985b73e 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -621,6 +621,16 @@ config ROCKCHIP_SARADC
>>>         To compile this driver as a module, choose M here: the
>>>         module will be called rockchip_saradc.
>>>
>>> +config SC27XX_ADC
>>> +     tristate "Spreadtrum SC27xx series PMICs ADC"
>>> +     depends on MFD_SC27XX_PMIC || COMPILE_TEST
>>> +     help
>>> +       Say yes here to build support for the integrated ADC inside
>the
>>> +       Spreadtrum SC27xx series PMICs.
>>> +
>>> +       This driver can also be built as a module. If so, the module
>>> +       will be called sc27xx_adc.
>>> +
>>>  config SPEAR_ADC
>>>       tristate "ST SPEAr ADC"
>>>       depends on PLAT_SPEAR || COMPILE_TEST
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index 28a9423..03db7b5 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -59,6 +59,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>>>  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>>>  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
>>>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>>> +obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>>>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
>>>  obj-$(CONFIG_STX104) += stx104.o
>>>  obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
>>> diff --git a/drivers/iio/adc/sc27xx_adc.c
>b/drivers/iio/adc/sc27xx_adc.c
>>> new file mode 100644
>>> index 0000000..52e5b74
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/sc27xx_adc.c
>>
>> In general (i.e. when we notice in time) we don't allow wild cards in
>names.
>> Far too many times we did this in the past and ended up with later
>parts
>> that fitted the name, but could not be supported by the driver.
>>
>> The convention is to name everything after the first part supported.
>> So here, sc2731. (I relaxed my thoughts on this later having seen the
>mfd
>> has this naming - so there are no ideal options left..)
>
>Like I explained above, maybe change to 'sprd_pmic_adc.c', is this OK
>for you?
Goes wrong just as quickly as wild cards...

>
>>
>>> @@ -0,0 +1,547 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// Copyright (C) 2018 Spreadtrum Communications Inc.
>>> +
>>> +#include <linux/hwspinlock.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +/* PMIC global registers definition */
>>> +#define SC27XX_MODULE_EN             0xc08
>> Please avoid wild cards.  This goes wrong an awful lot of the time
>> when a company comes out with an incompatible part that fits in the
>> existing wild cards.
>
>Sure.
>
>>
>>> +#define SC27XX_MODULE_ADC_EN         BIT(5)
>>> +#define SC27XX_ARM_CLK_EN            0xc10
>>> +#define SC27XX_CLK_ADC_EN            BIT(5)
>>> +#define SC27XX_CLK_ADC_CLK_EN                BIT(6)
>>> +
>>> +/* ADC controller registers definition */
>>> +#define SC27XX_ADC_CTL                       0x0
>>> +#define SC27XX_ADC_CH_CFG            0x4
>>> +#define SC27XX_ADC_DATA                      0x4c
>>> +#define SC27XX_ADC_INT_EN            0x50
>>> +#define SC27XX_ADC_INT_CLR           0x54
>>> +#define SC27XX_ADC_INT_STS           0x58
>>> +#define SC27XX_ADC_INT_RAW           0x5c
>>> +
>>> +/* Bits and mask definition for SC27XX_ADC_CTL register */
>>> +#define SC27XX_ADC_EN                        BIT(0)
>>> +#define SC27XX_ADC_CHN_RUN           BIT(1)
>>> +#define SC27XX_ADC_12BIT_MODE                BIT(2)
>>> +#define SC27XX_ADC_RUN_NUM_MASK              GENMASK(7, 4)
>>> +#define SC27XX_ADC_RUN_NUM_SHIFT     4
>>> +
>>> +/* Bits and mask definition for SC27XX_ADC_CH_CFG register */
>>> +#define SC27XX_ADC_CHN_ID_MASK               GENMASK(4, 0)
>>> +#define SC27XX_ADC_SCALE_MASK                GENMASK(10, 8)
>>> +#define SC27XX_ADC_SCALE_SHIFT               8
>>> +
>>> +/* Bits definitions for SC27XX_ADC_INT_EN registers */
>>> +#define SC27XX_ADC_IRQ_EN            BIT(0)
>>> +
>>> +/* Bits definitions for SC27XX_ADC_INT_CLR registers */
>>> +#define SC27XX_ADC_IRQ_CLR           BIT(0)
>>> +
>>> +/* Mask definition for SC27XX_ADC_DATA register */
>>> +#define SC27XX_ADC_DATA_MASK         GENMASK(11, 0)
>>> +
>>> +/* Timeout (ms) for the trylock of hardware spinlocks */
>>> +#define SC27XX_ADC_HWLOCK_TIMEOUT    5000
>>> +
>>> +/* Maximum ADC channel number */
>>> +#define SC27XX_ADC_CHANNEL_MAX               32
>>> +
>>> +/* ADC voltage ratio definition */
>>> +#define SC27XX_VOLT_RATIO(n, d)              \
>>> +     (((n) << SC27XX_RATIO_NUMERATOR_OFFSET) | (d))
>>> +#define SC27XX_RATIO_NUMERATOR_OFFSET        16
>>> +#define SC27XX_RATIO_DENOMINATOR_MASK        GENMASK(15, 0)
>>> +
>>> +struct sc27xx_adc_data {
>>> +     struct device *dev;
>>> +     struct regmap *regmap;
>>> +     /*
>>> +      * One hardware spinlock to synchronize between the multiple
>>> +      * subsystems which will access the unique ADC controller.
>>> +      */
>>> +     struct hwspinlock *hwlock;
>>> +     struct completion completion;
>>> +     int channel_scale[SC27XX_ADC_CHANNEL_MAX];
>>> +     int (*get_volt_ratio)(int channel, int scale);
>>> +     u32 base;
>>> +     int value;
>>> +     int irq;
>>> +};
>>> +
>>> +struct sc27xx_adc_linear_graph {
>>> +     int volt0;
>>> +     int adc0;
>>> +     int volt1;
>>> +     int adc1;
>>> +};
>>> +
>>> +/*
>>> + * According to the datasheet, we can convert one ADC value to one
>voltage value
>>> + * through 2 points in the linear graph. If the voltage is less
>than 1.2v, we
>>> + * should use the small-scale graph, and if more than 1.2v, we
>should use the
>>> + * big-scale graph.
>>> + */
>>> +static const struct sc27xx_adc_linear_graph big_scale_graph = {
>>> +     4200, 3310,
>>> +     3600, 2832,
>>> +};
>>> +
>>> +static const struct sc27xx_adc_linear_graph small_scale_graph = {
>>> +     1000, 3413,
>>> +     100, 341,
>>> +};
>>> +
>>> +static int sc27xx_adc_2731_ratio(int channel, int scale)
>>> +{
>>> +     switch (channel) {
>>> +     case 1:
>>> +     case 2:
>>> +     case 3:
>>> +     case 4:
>>> +             return scale ? SC27XX_VOLT_RATIO(400, 1025) :
>>> +                     SC27XX_VOLT_RATIO(1, 1);
>>> +     case 5:
>>> +             return SC27XX_VOLT_RATIO(7, 29);
>>> +     case 6:
>>> +             return SC27XX_VOLT_RATIO(375, 9000);
>>> +     case 7:
>>> +     case 8:
>>> +             return scale ? SC27XX_VOLT_RATIO(100, 125) :
>>> +                     SC27XX_VOLT_RATIO(1, 1);
>>> +     case 19:
>>> +             return SC27XX_VOLT_RATIO(1, 3);
>>> +     default:
>>> +             return SC27XX_VOLT_RATIO(1, 1);
>>> +     }
>>> +     return SC27XX_VOLT_RATIO(1, 1);
>>> +}
>>> +
>>> +static int sc27xx_adc_read(struct sc27xx_adc_data *data, int
>channel,
>>> +                        int scale, int *val)
>>> +{
>>> +     int ret;
>>> +     u32 tmp;
>>> +
>>> +     reinit_completion(&data->completion);
>>> +
>>> +     ret = hwspin_lock_timeout_raw(data->hwlock,
>SC27XX_ADC_HWLOCK_TIMEOUT);
>>> +     if (ret) {
>>> +             dev_err(data->dev, "timeout to get the hwspinlock\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = regmap_update_bits(data->regmap, data->base +
>SC27XX_ADC_CTL,
>>> +                              SC27XX_ADC_EN, SC27XX_ADC_EN);
>>> +     if (ret)
>>> +             goto unlock_adc;
>>> +
>>> +     /* Configure the channel id and scale */
>>> +     tmp = (scale << SC27XX_ADC_SCALE_SHIFT) &
>SC27XX_ADC_SCALE_MASK;
>>> +     tmp |= channel & SC27XX_ADC_CHN_ID_MASK;
>>> +     ret = regmap_update_bits(data->regmap, data->base +
>SC27XX_ADC_CH_CFG,
>>> +                              SC27XX_ADC_CHN_ID_MASK |
>SC27XX_ADC_SCALE_MASK,
>>> +                              tmp);
>>> +     if (ret)
>>> +             goto disable_adc;
>>> +
>>> +     /* Select 12bit conversion mode, and only sample 1 time */
>>> +     tmp = SC27XX_ADC_12BIT_MODE;
>>> +     tmp |= (0 << SC27XX_ADC_RUN_NUM_SHIFT) &
>SC27XX_ADC_RUN_NUM_MASK;
>>> +     ret = regmap_update_bits(data->regmap, data->base +
>SC27XX_ADC_CTL,
>>> +                              SC27XX_ADC_RUN_NUM_MASK |
>SC27XX_ADC_12BIT_MODE,
>>> +                              tmp);
>>> +     if (ret)
>>> +             goto disable_adc;
>>> +
>>> +     ret = regmap_update_bits(data->regmap, data->base +
>SC27XX_ADC_CTL,
>>> +                              SC27XX_ADC_CHN_RUN,
>SC27XX_ADC_CHN_RUN);
>>> +     if (ret)
>>> +             goto disable_adc;
>>> +
>>> +     wait_for_completion(&data->completion);
>>> +
>>> +disable_adc:
>>> +     regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>>> +                        SC27XX_ADC_EN, 0);
>>> +unlock_adc:
>>> +     hwspin_unlock_raw(data->hwlock);
>>> +
>>> +     if (!ret)
>>> +             *val = data->value;
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static irqreturn_t sc27xx_adc_isr(int irq, void *dev_id)
>>> +{
>>> +     struct sc27xx_adc_data *data = dev_id;
>>> +     int ret;
>>> +
>>> +     ret = regmap_update_bits(data->regmap, data->base +
>SC27XX_ADC_INT_CLR,
>>> +                              SC27XX_ADC_IRQ_CLR,
>SC27XX_ADC_IRQ_CLR);
>>> +     if (ret)
>>> +             return IRQ_RETVAL(ret);
>>> +
>>> +     ret = regmap_read(data->regmap, data->base + SC27XX_ADC_DATA,
>>> +                       &data->value);
>>> +     if (ret)
>>> +             return IRQ_RETVAL(ret);
>>> +
>>> +     data->value &= SC27XX_ADC_DATA_MASK;
>>> +     complete(&data->completion);
>>> +
>>> +     return IRQ_HANDLED;
>>> +}
>>> +
>>> +static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
>>> +                               int channel, int scale,
>>> +                               u32 *div_numerator, u32
>*div_denominator)
>>> +{
>>> +     u32 ratio = data->get_volt_ratio(channel, scale);
>>> +
>>> +     *div_numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
>>> +     *div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
>>> +}
>>> +
>>> +static int sc27xx_adc_to_volt(const struct sc27xx_adc_linear_graph
>*graph,
>>> +                           int raw_adc)
>>> +{
>>> +     int tmp;
>>> +
>>> +     tmp = (graph->volt0 - graph->volt1) * (raw_adc - graph->adc1);
>>> +     tmp /= (graph->adc0 - graph->adc1);
>>> +     tmp += graph->volt1;
>>> +
>>> +     return tmp < 0 ? 0 : tmp;
>>> +}
>>> +
>>> +static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data,
>int channel,
>>> +                                int scale, int raw_adc)
>>> +{
>>> +     u32 numerator, denominator;
>>> +     u32 volt;
>>> +
>>> +     /*
>>> +      * Convert ADC values to voltage values according to the
>linear graph,
>>> +      * and channel 5 and channel 1 has been calibrated, so we can
>just
>>> +      * return the voltage values calculated by the linear graph.
>But other
>>> +      * channels need be calculated to the real voltage values with
>the
>>> +      * voltage ratio.
>>> +      */
>>> +     switch (channel) {
>>> +     case 5:
>>> +             return sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
>>> +
>>> +     case 1:
>>> +             return sc27xx_adc_to_volt(&small_scale_graph,
>raw_adc);
>>> +
>>> +     default:
>>> +             volt = sc27xx_adc_to_volt(&small_scale_graph,
>raw_adc);
>>> +             break;
>>> +     }
>>
>> This looks a lot more complex than simple scaling that is indicated
>by the
>> raw and scale attributes? They can't both be right..
>
>Since this is special for our ADC controller, we have 2 channels that
>has been calibrated in hardware, but for other
>none-calibrated-channels, we should care about the channel voltage
>ratio when converting to a real voltage values, that is because some
>channel's voltage is larger so we need one voltage ratio to sample the
>ADC values.

It's still a question of one or the other. Channels should not do processed and raw without a very good reason.

Issue with processed is that you can't easily do buffered chrdev streaming in future.


>
>>> +
>>> +     sc27xx_adc_volt_ratio(data, channel, scale, &numerator,
>&denominator);
>>> +
>>> +     return (volt * denominator + numerator / 2) / numerator;
>>> +}
>>> +
>>> +static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
>>> +                                  int channel, int scale, int *val)
>>> +{
>>> +     int ret, raw_adc;
>>> +
>>> +     ret = sc27xx_adc_read(data, channel, scale, &raw_adc);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     *val = sc27xx_adc_convert_volt(data, channel, scale, raw_adc);
>>> +     return 0;
>>> +}
>>> +
>>> +static int sc27xx_adc_read_raw(struct iio_dev *indio_dev,
>>> +                            struct iio_chan_spec const *chan,
>>> +                            int *val, int *val2, long mask)
>>> +{
>>> +     struct sc27xx_adc_data *data = iio_priv(indio_dev);
>>> +     int scale, ret, tmp;
>>> +
>>> +     switch (mask) {
>>> +     case IIO_CHAN_INFO_RAW:
>>> +     case IIO_CHAN_INFO_AVERAGE_RAW:
>>> +             mutex_lock(&indio_dev->mlock);
>>> +             scale = data->channel_scale[chan->channel];
>>> +             ret = sc27xx_adc_read(data, chan->channel, scale,
>&tmp);
>>> +             mutex_unlock(&indio_dev->mlock);
>>> +
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             *val = tmp;
>>> +             return IIO_VAL_INT;
>>> +
>>> +     case IIO_CHAN_INFO_PROCESSED:
>>> +             mutex_lock(&indio_dev->mlock);
>>> +             scale = data->channel_scale[chan->channel];
>>> +             ret = sc27xx_adc_read_processed(data, chan->channel,
>scale,
>>> +                                             &tmp);
>>
>> To keep to the rule of 'one way to read a value' we don't tend to
>support
>> both raw and processed.  The only exception is made for devices where
>we got
>> this wrong in the first place and so have to support both to avoid a
>potential
>> regression due to ABI changes.
>>
>> If it is a simple linear scaling (like here I think) then the
>preferred option
>> is to not supply the processed version.  Just do raw.
>
>Unfortunately, we can not use the formula ( (X_raw + X_offset)*X_scale
>= X_processed) for our ADC controller to get a processed value.
>Firstly, the ADC hardware will do the sampling with the scale value.

Hmm fair enough, scale is fine for that. But don't provide raw unless real voltage is scale *raw 

>Secondly we should convert a raw value to a voltage value by the
>linear graph table, for some channels, we should also use the channel
>voltage ratio to get a real voltage value. So I think we should keep
>our special processed approach for consumers.

That's fine but drop the raw access or you are not obeying the abi.



>
>>> +             mutex_unlock(&indio_dev->mlock);
>>> +
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             *val = tmp;
>>> +             return IIO_VAL_INT;
>>> +
>>> +     case IIO_CHAN_INFO_SCALE:
>>> +             mutex_lock(&indio_dev->mlock);
>>> +             *val = data->channel_scale[chan->channel];
>>> +             mutex_unlock(&indio_dev->mlock);
>>> +             return IIO_VAL_INT;
>>> +
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +}
>>> +
>>> +static int sc27xx_adc_write_raw(struct iio_dev *indio_dev,
>>> +                             struct iio_chan_spec const *chan,
>>> +                             int val, int val2, long mask)
>>> +{
>>> +     struct sc27xx_adc_data *data = iio_priv(indio_dev);
>>> +
>>> +     switch (mask) {
>>> +     case IIO_CHAN_INFO_SCALE:
>>> +             mutex_lock(&indio_dev->mlock);
>>> +             data->channel_scale[chan->channel] = val;
>>> +             mutex_unlock(&indio_dev->mlock);
>>
>> This is rather heavy weight locking for an integer write that will
>> be atomic (I hope!) anyway.  Hence I don't think you need to
>> lock around this value at all.
>>
>> It 'might' change during a read, but given you take a snapshot
>> of it anyway I'm not sure why that would matter?
>
>OK, I can remove the lock.
>
>>
>>> +             return IIO_VAL_INT;
>>> +
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +}
>>> +
>>> +static const struct iio_info sc27xx_info = {
>>> +     .read_raw = &sc27xx_adc_read_raw,
>>> +     .write_raw = &sc27xx_adc_write_raw,
>>> +};
>>> +
>>> +#define SC27XX_ADC_CHANNEL(index) {                          \
>>> +     .type = IIO_VOLTAGE,                                    \
>>> +     .channel = index,                                       \
>>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
>>> +                           BIT(IIO_CHAN_INFO_AVERAGE_RAW) |  \
>>> +                           BIT(IIO_CHAN_INFO_PROCESSED) |    \
>>> +                           BIT(IIO_CHAN_INFO_SCALE),         \
>>> +     .datasheet_name = "CH##index",                          \
>>> +     .indexed = 1,                                           \
>>> +}
>>> +
>>> +static const struct iio_chan_spec sc27xx_channels[] = {
>>> +     SC27XX_ADC_CHANNEL(0),
>>> +     SC27XX_ADC_CHANNEL(1),
>>> +     SC27XX_ADC_CHANNEL(2),
>>> +     SC27XX_ADC_CHANNEL(3),
>>> +     SC27XX_ADC_CHANNEL(4),
>>> +     SC27XX_ADC_CHANNEL(5),
>>> +     SC27XX_ADC_CHANNEL(6),
>>> +     SC27XX_ADC_CHANNEL(7),
>>> +     SC27XX_ADC_CHANNEL(8),
>>> +     SC27XX_ADC_CHANNEL(9),
>>> +     SC27XX_ADC_CHANNEL(10),
>>> +     SC27XX_ADC_CHANNEL(11),
>>> +     SC27XX_ADC_CHANNEL(12),
>>> +     SC27XX_ADC_CHANNEL(13),
>>> +     SC27XX_ADC_CHANNEL(14),
>>> +     SC27XX_ADC_CHANNEL(15),
>>> +     SC27XX_ADC_CHANNEL(16),
>>> +     SC27XX_ADC_CHANNEL(17),
>>> +     SC27XX_ADC_CHANNEL(18),
>>> +     SC27XX_ADC_CHANNEL(19),
>>> +     SC27XX_ADC_CHANNEL(20),
>>> +     SC27XX_ADC_CHANNEL(21),
>>> +     SC27XX_ADC_CHANNEL(22),
>>> +     SC27XX_ADC_CHANNEL(23),
>>> +     SC27XX_ADC_CHANNEL(24),
>>> +     SC27XX_ADC_CHANNEL(25),
>>> +     SC27XX_ADC_CHANNEL(26),
>>> +     SC27XX_ADC_CHANNEL(27),
>>> +     SC27XX_ADC_CHANNEL(28),
>>> +     SC27XX_ADC_CHANNEL(29),
>>> +     SC27XX_ADC_CHANNEL(30),
>>> +     SC27XX_ADC_CHANNEL(31),
>>> +};
>>> +
>>> +static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
>>> +                              SC27XX_MODULE_ADC_EN,
>SC27XX_MODULE_ADC_EN);
>>> +     if (ret)
>>> +             return ret;
>> Hmm. We allow this function to return errors, but don't really clean
>up properly
>> if it happens.
>>
>> So errors in later paths than this one should ensure this is undone. 
>The state
>> on exit from this function (when an error occurs) should be as close
>as possible
>> to the state on entry.
>>
>> Now things get interesting if the failure indicates we probably have
>a hardware
>> failure, but it would still be nice to be consistent and try and
>unwind.
>
>You are right, we should ensure previous operations are undone. Will
>fix in next version.
>
>>> +
>>> +     /* Enable ADC work clock and controller clock */
>>> +     ret = regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
>>> +                              SC27XX_CLK_ADC_EN |
>SC27XX_CLK_ADC_CLK_EN,
>>> +                              SC27XX_CLK_ADC_EN |
>SC27XX_CLK_ADC_CLK_EN);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = regmap_update_bits(data->regmap, data->base +
>SC27XX_ADC_INT_EN,
>>> +                              SC27XX_ADC_IRQ_EN,
>SC27XX_ADC_IRQ_EN);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return regmap_update_bits(data->regmap, data->base +
>SC27XX_ADC_INT_CLR,
>>> +                               SC27XX_ADC_IRQ_CLR,
>SC27XX_ADC_IRQ_CLR);
>>> +}
>>> +
>>> +static void sc27xx_adc_disable(struct sc27xx_adc_data *data)
>>> +{
>>> +     regmap_update_bits(data->regmap, data->base +
>SC27XX_ADC_INT_EN,
>>> +                        SC27XX_ADC_IRQ_EN, 0);
>>> +
>>> +     /* Disable ADC work clock and controller clock */
>>> +     regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
>>> +                        SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN,
>0);
>>> +
>>> +     regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
>>> +                        SC27XX_MODULE_ADC_EN, 0);
>>> +}
>>> +
>>> +static int sc27xx_adc_probe(struct platform_device *pdev)
>>> +{
>>> +     struct device_node *np = pdev->dev.of_node;
>>> +     struct sc27xx_adc_data *sc27xx_data;
>>> +     struct iio_dev *indio_dev;
>>> +     const void *data;
>>> +     int ret;
>>> +
>>> +     data = of_device_get_match_data(&pdev->dev);
>>> +     if (!data) {
>>> +             dev_err(&pdev->dev, "failed to get match data\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     indio_dev = devm_iio_device_alloc(&pdev->dev,
>sizeof(*sc27xx_data));
>>> +     if (!indio_dev)
>>> +             return -ENOMEM;
>>> +
>>> +     sc27xx_data = iio_priv(indio_dev);
>>> +
>>> +     sc27xx_data->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>>> +     if (!sc27xx_data->regmap) {
>>> +             dev_err(&pdev->dev, "failed to get ADC regmap\n");
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     ret = of_property_read_u32(np, "reg", &sc27xx_data->base);
>>> +     if (ret) {
>>> +             dev_err(&pdev->dev, "failed to get ADC base
>address\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     sc27xx_data->irq = platform_get_irq(pdev, 0);
>>> +     if (sc27xx_data->irq < 0) {
>>> +             dev_err(&pdev->dev, "failed to get ADC irq number\n");
>>> +             return sc27xx_data->irq;
>>> +     }
>>> +
>>> +     ret = of_hwspin_lock_get_id(np, 0);
>>> +     if (ret < 0) {
>>> +             dev_err(&pdev->dev, "failed to get hwspinlock id\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     sc27xx_data->hwlock = hwspin_lock_request_specific(ret);
>>> +     if (!sc27xx_data->hwlock) {
>>> +             dev_err(&pdev->dev, "failed to request hwspinlock\n");
>>> +             return -ENXIO;
>>> +     }
>>> +
>>> +     init_completion(&sc27xx_data->completion);
>>> +
>>> +     /*
>>> +      * Different PMIC ADC controllers can have different channel
>voltage
>>> +      * ratios, so we should save the implementation of getting
>voltage
>>> +      * ratio for corresponding PMIC ADC in the device data
>structure.
>>> +      */
>>> +     sc27xx_data->get_volt_ratio = data;
>>> +     sc27xx_data->dev = &pdev->dev;
>>> +
>>> +     ret = sc27xx_adc_enable(sc27xx_data);
>>> +     if (ret) {
>>> +             dev_err(&pdev->dev, "failed to enable ADC module\n");
>>> +             goto free_hwlock;
>>> +     }
>>> +
>>> +     ret = devm_request_threaded_irq(&pdev->dev, sc27xx_data->irq,
>NULL,
>>> +                                     sc27xx_adc_isr, IRQF_ONESHOT,
>>> +                                     pdev->name, sc27xx_data);
>>
>> This worries me from a race point of view as well. You shouldn't have
>> an interrupt still in use once the adc_disable in the remove is
>> called.  It might be safe, but it's not immediately obvious that it
>> is.  As such I'd rather we didn't use the managed interrupt request
>here.
>> So use request_threaded_irq and free_irq as appropriate instead.
>
>Thanks for pointing this issue out and will fix in next version.
>
>>
>>
>>> +     if (ret) {
>>> +             dev_err(&pdev->dev, "failed to request ADC irq\n");
>>> +             goto disable_adc;
>>> +     }
>>> +
>>> +     indio_dev->dev.parent = &pdev->dev;
>>> +     indio_dev->name = dev_name(&pdev->dev);
>>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>>> +     indio_dev->info = &sc27xx_info;
>>> +     indio_dev->channels = sc27xx_channels;
>>> +     indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
>>> +     ret = devm_iio_device_register(&pdev->dev, indio_dev);
>>> +     if (ret) {
>> The moment I see any unwinding happening after a devm call I know
>> there is probably a race.
>>
>> Here the race is that you will be turning the ADC off and unlocking
>> before the userspace interface is removed (as devm unwind will happen
>> after remove is finished).
>>
>> You'll have to use the non managed version of iio_device_register
>> and unwind by hand to avoid this.
>>
>> Or you could if you prefer register some additional actions with devm
>> core to call the adc disable and hw_spinlock_free as appropriate.
>
>That is a good idea and I will add some additional actions with devm
>to avoid the race issue.
>
>>
>>> +             dev_err(&pdev->dev, "could not register iio (ADC)");
>>> +             goto disable_adc;
>>> +     }
>>> +
>>> +     platform_set_drvdata(pdev, indio_dev);
>> Generally put a blank line before simple returns like this,
>> Aids readability (a very small amount!)
>
>Sure.
>
>>
>>> +     return 0;
>>> +
>>> +disable_adc:
>>> +     sc27xx_adc_disable(sc27xx_data);
>>> +free_hwlock:
>>> +     hwspin_lock_free(sc27xx_data->hwlock);
>>> +     return ret;
>>> +}
>>> +
>>> +static int sc27xx_adc_remove(struct platform_device *pdev)
>>> +{
>>> +     struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>> +     struct sc27xx_adc_data *sc27xx_data = iio_priv(indio_dev);
>>> +
>>> +     sc27xx_adc_disable(sc27xx_data);
>>> +     hwspin_lock_free(sc27xx_data->hwlock);
>>
>> blank line here please.
>
>Sure.
>
>>
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct of_device_id sc27xx_adc_of_match[] = {
>>> +     {
>>> +             .compatible = "sprd,sc2731-adc",
>>> +             .data = (void *)&sc27xx_adc_2731_ratio,
>>
>> There is no need to cast to (void *) Implicit casting too
>> and from void pointers is always fine under the c spec.
>
>Yes, this is redundant.
>
>>
>> However, for cleanness I would put that function pointer into
>> a const structure.  Chances are you'll need something else in there
>> for some future feature and this would make it a lot cleaner.
>>
>> Also, a little unusual todo this when submitting a driver
>> supporting only one part.  I'm fine leaving it if you confirm there
>> are other parts going to be supported by this driver in the near
>future.
>> Otherwise drop this unnecessary abstraction.
>
>Make sense and I will remove it. Very appreciate for your comments.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
