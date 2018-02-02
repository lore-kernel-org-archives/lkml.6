Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeBBOmn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:42:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50495 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeBBOmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:42:35 -0500
X-Google-Smtp-Source: AH8x224Nn3LD/Jw+dBM+fwV5+1TjkKTS7Q5twPBHCLpL28zaME14ssuvXonJEr0HDhhoys0MzGpmqA==
Subject: Re: [PATCH v2 09/16] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
        rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
        krzk@kernel.org, icenowy@aosc.io, edu.molinas@gmail.com,
        singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-10-embed3d@gmail.com>
 <20180131192354.sb7zmcwc6c3eisqj@qschulz>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <d5c97217-c6a0-230f-5bc8-7a522880ff3e@gmail.com>
Date: Fri, 2 Feb 2018 15:42:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180131192354.sb7zmcwc6c3eisqj@qschulz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.01.2018 20:23, Quentin Schulz wrote:
> Hi Philipp,
> 
> On Mon, Jan 29, 2018 at 12:29:12AM +0100, Philipp Rossak wrote:
>> This patch adds support for the H3 ths sensor.
>>
>> The H3 supports interrupts. The interrupt is configured to update the
>> the sensor values every second. The calibration data is writen at the
>> begin of the init process.
>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   drivers/iio/adc/sun4i-gpadc-iio.c | 86 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/sun4i-gpadc.h   | 22 ++++++++++
>>   2 files changed, 108 insertions(+)
>>
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> index b7b5451226b0..8196203d65fe 100644
>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -61,6 +61,9 @@ struct sun4i_gpadc_iio;
>>   static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info);
>>   static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info);
>>   
>> +static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info);
>> +static int sunxi_ths_sample_end(struct sun4i_gpadc_iio *info);
>> +
> 
> We try to avoid using the generic sunxi prefix.
> 
>>   struct gpadc_data {
>>   	int		temp_offset;
>>   	int		temp_scale;
>> @@ -71,6 +74,10 @@ struct gpadc_data {
>>   	unsigned int	temp_data[MAX_SENSOR_COUNT];
>>   	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>>   	int		(*sample_end)(struct sun4i_gpadc_iio *info);
>> +	u32		ctrl0_map;
>> +	u32		ctrl2_map;
>> +	u32		sensor_en_map;
>> +	u32		filter_map;
>>   	u32		irq_clear_map;
>>   	u32		irq_control_map;
>>   	bool		has_bus_clk;
>> @@ -138,6 +145,31 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
>>   	.support_irq = false,
>>   };
>>   
>> +static const struct gpadc_data sun8i_h3_ths_data = {
>> +	.temp_offset = -1791,
>> +	.temp_scale = -121,
>> +	.temp_data = {SUN8I_H3_THS_TDATA0, 0, 0, 0},
>> +	.sample_start = sunxi_ths_sample_start,
>> +	.sample_end = sunxi_ths_sample_end,
>> +	.has_bus_clk = true,
>> +	.has_bus_rst = true,
>> +	.has_mod_clk = true,
>> +	.sensor_count = 1,
>> +	.supports_nvmem = true,
>> +	.support_irq = true,
>> +	.ctrl0_map = SUN4I_GPADC_CTRL0_T_ACQ(0xff),
>> +	.ctrl2_map = SUN8I_H3_THS_ACQ1(0x3f),
>> +	.sensor_en_map = SUN8I_H3_THS_TEMP_SENSE_EN0,
>> +	.filter_map = SUN4I_GPADC_CTRL3_FILTER_EN |
>> +		SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2),
>> +	.irq_clear_map = SUN8I_H3_THS_INTS_ALARM_INT_0 |
>> +			SUN8I_H3_THS_INTS_SHUT_INT_0   |
>> +			SUN8I_H3_THS_INTS_TDATA_IRQ_0  |
>> +			SUN8I_H3_THS_INTS_ALARM_OFF_0,
>> +	.irq_control_map = SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
>> +		SUN8I_H3_THS_TEMP_PERIOD(0x7),
> 
>  From what I've understood, ACQ regs are basically clock dividers. We
> should make a better job at explaining it :)
> 

I agree, I will add this in the next version in the commit message.

>> +};
>> +
>>   struct sun4i_gpadc_iio {
>>   	struct iio_dev			*indio_dev;
>>   	struct completion		completion;
>> @@ -462,6 +494,16 @@ static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info)
>>   	return 0;
>>   }
>>   
>> +static int sunxi_ths_sample_end(struct sun4i_gpadc_iio *info)
>> +{
>> +	/* Disable ths interrupt */
>> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC, 0x0);
>> +	/* Disable temperature sensor */
>> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2, 0x0);
>> +
>> +	return 0;
>> +}
>> +
>>   static int sun4i_gpadc_runtime_suspend(struct device *dev)
>>   {
>>   	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
>> @@ -473,6 +515,17 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
>>   	return info->data->sample_end(info);
>>   }
>>   
>> +static void sunxi_calibrate(struct sun4i_gpadc_iio *info)
>> +{
>> +	if (info->has_calibration_data[0])
>> +		regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
>> +			info->calibration_data[0]);
>> +
>> +	if (info->has_calibration_data[1])
>> +		regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
>> +			info->calibration_data[1]);
>> +}
>> +
>>   static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
>>   {
>>   	/* clkin = 6MHz */
>> @@ -492,6 +545,35 @@ static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
>>   	return 0;
>>   }
>>   
>> +static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info)
>> +{
>> +	u32 value;
>> +	sunxi_calibrate(info);
>> +
>> +	if (info->data->ctrl0_map)
>> +		regmap_write(info->regmap, SUN8I_H3_THS_CTRL0,
>> +			info->data->ctrl0_map);
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
>> +		info->data->ctrl2_map);
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
>> +			info->data->irq_clear_map);
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_FILTER,
>> +		info->data->filter_map);
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC,
>> +		info->data->irq_control_map);
>> +
>> +	regmap_read(info->regmap, SUN8I_H3_THS_CTRL2, &value);
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
>> +		info->data->sensor_en_map | value);
>> +
>> +	return 0;
>> +}
>> +
> 
> I'm a bit worried. Will all the sensors have the same sample start? Or
> will we need at some point also entries in info->data for register
> addresses, if they have ctrl2 or filter, etc...
>  > Maybe we could define a sample_start for the h3 only and reuse-it if
> possible and if not declare another sample start? All depends if the
> sample start is most likely to change in the near future or not. If it
> is, then we should avoid adding a lot of variables in info->data and
> just go for a single sample_start per SoC.
> 

for H3, A83T, H5, A64 we can use the same sample start. So I would use 
here a H3 sample start function and reuse it.

A80 is special since it has no crtl0 register, thus it would get also 
its own function.

H6 will need also an own sample start function (looking in the near future).

>>   static int sun4i_gpadc_runtime_resume(struct device *dev)
>>   {
>>   	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
>> @@ -582,6 +664,10 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
>>   		.compatible = "allwinner,sun8i-a33-ths",
>>   		.data = &sun8i_a33_gpadc_data,
>>   	},
>> +	{
>> +		.compatible = "allwinner,sun8i-h3-ths",
>> +		.data = &sun8i_h3_ths_data,
>> +	},
>>   	{ /* sentinel */ }
>>   };
>>   
>> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
>> index 458f2159a95a..80b79c31cea3 100644
>> --- a/include/linux/mfd/sun4i-gpadc.h
>> +++ b/include/linux/mfd/sun4i-gpadc.h
>> @@ -91,7 +91,29 @@
>>   #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
>>   
>>   /* SUNXI_THS COMMON REGISTERS + DEFINES */
>> +#define SUN8I_H3_THS_CTRL0				0x00
>> +#define SUN8I_H3_THS_CTRL2				0x40
>>   #define SUN8I_H3_THS_INTC				0x44
>> +#define SUN8I_H3_THS_STAT				0x48
>> +#define SUN8I_H3_THS_FILTER				0x70
>> +#define SUNXI_THS_CDATA_0_1				0x74
>> +#define SUNXI_THS_CDATA_2_3				0x78
>> +#define SUN8I_H3_THS_TDATA0				0x80
>> +
>> +#define SUN8I_H3_THS_ACQ1(x)				(GENMASK(31, 16) & ((x) << 16))
>> +
>> +#define SUN8I_H3_THS_TEMP_SENSE_EN0			BIT(0)
>> +
>> +#define SUN8I_H3_THS_TEMP_PERIOD(x)			(GENMASK(31, 12) & ((x) << 12))
>> +
>> +#define SUN8I_H3_THS_INTS_ALARM_INT_0			BIT(0)
>> +#define SUN8I_H3_THS_INTS_SHUT_INT_0			BIT(4)
>> +#define SUN8I_H3_THS_INTS_TDATA_IRQ_0			BIT(8)
>> +#define SUN8I_H3_THS_INTS_ALARM_OFF_0			BIT(12)
>> +
>> +#define SUN8I_H3_THS_INTC_ALARM_INT_EN0			BIT(0)
>> +#define SUN8I_H3_THS_INTC_SHUT_INT_EN0			BIT(4)
>> +#define SUN8I_H3_THS_INTC_TDATA_IRQ_EN0			BIT(8)
>>   
> 
> Personal taste here but I prefer the register bits to be defined just
> below the register address define.
> 
> i.e.:
> 
> #define SUN8I_H3_THS_CTRL2                           0x40
> #define SUN8I_H3_THS_ACQ1(x)                         (GENMASK(31, 16) & ((x) << 16))
> #define SUN8I_H3_THS_TEMP_SENSE_EN0                  BIT(0)
> 
> that way we know for which register we should use which constants.
> 
> Quentin
> 

I agree, this the better way to do it.


Thanks,
Philipp
