Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeBBOaq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:30:46 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35518 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeBBOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:30:38 -0500
X-Google-Smtp-Source: AH8x227VODtnRdWmrQKnZwGJqA/ME2w8dDx+l98/rrZ2O4UWjig0GX3QgI6hQkyHXDQexC+yS06Ryg==
Subject: Re: [PATCH v2 08/16] iio: adc: sun4i-gpadc-iio: rework: add interrupt
 support
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
 <20180128232919.12639-9-embed3d@gmail.com>
 <20180131190718.ustqzwdxzw7mqe52@qschulz>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <8a3ff924-9752-e9dc-d70e-609436505b1a@gmail.com>
Date: Fri, 2 Feb 2018 15:30:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180131190718.ustqzwdxzw7mqe52@qschulz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.01.2018 20:07, Quentin Schulz wrote:
> Hi Philipp,
> 
> On Mon, Jan 29, 2018 at 12:29:11AM +0100, Philipp Rossak wrote:
>> This patch rewors the driver to support interrupts for the thermal part
>> of the sensor.
>>
>> This is only available for the newer sensor (currently H3 and A83T).
>> The interrupt will be trigerd on data available and triggers the update
>> for the thermal sensors. All newer sensors have different amount of
>> sensors and different interrupts for each device the reset of the
>> interrupts need to be done different
>>
>> For the newer sensors is the autosuspend disabled.
>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> Acked-by: Jonathan  Cameron <jonathan.cameron@huawei.com>
>> ---
>>   drivers/iio/adc/sun4i-gpadc-iio.c | 60 +++++++++++++++++++++++++++++++++++----
>>   include/linux/mfd/sun4i-gpadc.h   |  2 ++
>>   2 files changed, 56 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> index 74eeb5cd5218..b7b5451226b0 100644
>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -71,11 +71,14 @@ struct gpadc_data {
>>   	unsigned int	temp_data[MAX_SENSOR_COUNT];
>>   	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>>   	int		(*sample_end)(struct sun4i_gpadc_iio *info);
>> +	u32		irq_clear_map;
>> +	u32		irq_control_map;
> 
> I would say to use a regmap_irq_chip for controlling IRQs.
> 
Sounds good for me! I will rework that in the next version.
>>   	bool		has_bus_clk;
>>   	bool		has_bus_rst;
>>   	bool		has_mod_clk;
>>   	int		sensor_count;
>>   	bool		supports_nvmem;
>> +	bool		support_irq;
>>   };
>>   
>>   static const struct gpadc_data sun4i_gpadc_data = {
>> @@ -90,6 +93,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
>>   	.sample_end = sun4i_gpadc_sample_end,
>>   	.sensor_count = 1,
>>   	.supports_nvmem = false,
>> +	.support_irq = false,
> 
> False is the default, no need to set support_irq.
> 
> [...]
> 
>>   struct sun4i_gpadc_iio {
>> @@ -332,6 +339,11 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val,
>>   		return 0;
>>   	}
>>   
>> +	if (info->data->support_irq) {
>> +		regmap_read(info->regmap, info->data->temp_data[sensor], val);
>> +		return 0;
>> +	}
>> +
> 
> Maybe you could define a new thermal_zone_of_device_ops for these new
> thermal sensors? That way, you don't even need the boolean support_irq.
> 
Sounds good for me! I will rework that in the next version.

>>   	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
>>   }
>>   
>> @@ -429,6 +441,17 @@ static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +static irqreturn_t sunxi_irq_thread(int irq, void *data)
> 
> I think we're trying to avoid sunxi mentions but rather using the name
> of the first IP (in term of product release, not support) using this
> function.
> 
>> +{
>> +	struct sun4i_gpadc_iio *info = data;
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_STAT, info->data->irq_clear_map);
>> +
> 
> Will be handled by regmap_irq_chip.
> [...]
>> -	info->no_irq = true;
>> +	if (info->data->support_irq) {
>> +		/* only the new versions of ths support right now irqs */
>> +		irq = platform_get_irq(pdev, 0);
>> +		if (irq < 0) {
>> +			dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
>> +			return irq;
>> +		}
>> +
>> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>> +				sunxi_irq_thread, IRQF_ONESHOT,
>> +				dev_name(&pdev->dev), info);
>> +		if (ret)
>> +			return ret;
>> +
>> +	} else
>> +		info->no_irq = true;
>> +
> 
> That's a bit funny to have two booleans named no_irq and support_irq :)
> 
I know this looks very funny. I thought this would be better to keep, to 
_not_ break anything. Since I will rework the whole driver and integrate 
the mfd part I hope I can remove both.

>>   	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
>>   	indio_dev->channels = sun8i_a33_gpadc_channels;
>>   
>> @@ -789,11 +829,13 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	pm_runtime_set_autosuspend_delay(&pdev->dev,
>> -					 SUN4I_GPADC_AUTOSUSPEND_DELAY);
>> -	pm_runtime_use_autosuspend(&pdev->dev);
>> -	pm_runtime_set_suspended(&pdev->dev);
>> -	pm_runtime_enable(&pdev->dev);
>> +	if (!info->data->support_irq) {
>> +		pm_runtime_set_autosuspend_delay(&pdev->dev,
>> +						 SUN4I_GPADC_AUTOSUSPEND_DELAY);
>> +		pm_runtime_use_autosuspend(&pdev->dev);
>> +		pm_runtime_set_suspended(&pdev->dev);
>> +		pm_runtime_enable(&pdev->dev);
>> +	}
> 
> Why would you not want your IP to do runtime PM?

I will enable this again, in the next version! I had some issues with 
this, thus I disabled this, but I know now what I did wrong!

Thanks,
Philipp
