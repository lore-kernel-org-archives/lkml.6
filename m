Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeBBONk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:13:40 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52748 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeBBONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:13:32 -0500
X-Google-Smtp-Source: AH8x227Uhxh/3Zs6m4x9APMmG8SXJ87t5xpg1dQWi6yUCMyEAPsREvI6SakPvE9ZI5L2PxVrmtmeHw==
Subject: Re: [PATCH v2 06/16] iio: adc: sun4i-gpadc-iio: rework: support
 multiple sensors
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
 <20180128232919.12639-7-embed3d@gmail.com>
 <20180131184236.4yhp732l5kenhmp2@qschulz>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <42632deb-077a-ad73-58e1-92d92dbd0963@gmail.com>
Date: Fri, 2 Feb 2018 15:13:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180131184236.4yhp732l5kenhmp2@qschulz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.01.2018 19:42, Quentin Schulz wrote:
> Hi Philipp,
> 
> On Mon, Jan 29, 2018 at 12:29:09AM +0100, Philipp Rossak wrote:
>> For adding newer sensor some basic rework of the code is necessary.
>>
>> This patch reworks the driver to be able to handle more than one
>> thermal sensor. Newer SoC like the A80 have 4 thermal sensors.
>> Because of this the maximal sensor count value was set to 4.
>>
>> The sensor_id value is set during sensor registration and is for each
>> registered sensor indiviual. This makes it able to differntiate the
>> sensors when the value is read from the register.
>>
>> In function sun4i_gpadc_read_raw(), the sensor number of the ths sensor
>> was directly set to 0 (sun4i_gpadc_temp_read(x,x,0)). This selects
>> in the temp_read function automatically sensor 0. A check for the
>> sensor_id is here not required since the old sensors only have one
>> thermal sensor. In addition to that is the sun4i_gpadc_read_raw()
>> function only used by the "older" sensors (before A33) where the
>> thermal sensor was a cobination of an adc and a thermal sensor.
>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   drivers/iio/adc/sun4i-gpadc-iio.c | 36 +++++++++++++++++++++++-------------
>>   include/linux/mfd/sun4i-gpadc.h   |  3 +++
>>   2 files changed, 26 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> index 51ec0104d678..ac9ad2f8232f 100644
>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -67,12 +67,13 @@ struct gpadc_data {
>>   	unsigned int	tp_adc_select;
>>   	unsigned int	(*adc_chan_select)(unsigned int chan);
>>   	unsigned int	adc_chan_mask;
>> -	unsigned int	temp_data;
>> +	unsigned int	temp_data[MAX_SENSOR_COUNT];
>>   	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>>   	int		(*sample_end)(struct sun4i_gpadc_iio *info);
>>   	bool		has_bus_clk;
>>   	bool		has_bus_rst;
>>   	bool		has_mod_clk;
>> +	int		sensor_count;
>>   };
>>   
> 
> I've noticed that for H3, A83T, A64 (at least), if DATA reg of sensor 0
> is e.g. 0x80, DATA reg of sensor N is at 0x80 + 0x04 * N.
> 
> Is that verified for other SoCs? Does anyone have some input on this?
> 
> We could then just use temp_data as the DATA reg "base" and increment by
> 0x4 depending on the sensor id instead of using a fixed-size array.
> 

This sounds like a good idea! I will add this to the next version.

I can verify this with a table, I created during development. I will 
upload it during the weekend here: [1]


>>   static const struct gpadc_data sun4i_gpadc_data = {
>> @@ -82,9 +83,10 @@ static const struct gpadc_data sun4i_gpadc_data = {
>>   	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
>>   	.adc_chan_select = &sun4i_gpadc_chan_select,
>>   	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
>> -	.temp_data = SUN4I_GPADC_TEMP_DATA,
>> +	.temp_data = {SUN4I_GPADC_TEMP_DATA, 0, 0, 0},
>>   	.sample_start = sun4i_gpadc_sample_start,
>>   	.sample_end = sun4i_gpadc_sample_end,
>> +	.sensor_count = 1,
> 
> If the solution above is not desirable/possible, could we use something
> like:
> 
> unsigned int sun4i_temp_data[] = {SUN4I_GPADC_TEMP_DATA,};
> 
> static const struct gpadc_data sun4i_gpadc_data = {
> 	.temp_data = &sun4i_temp_data,
> 	.sensor_count = ARRAY_SIZE(sun4i_temp_data),
> };
> 
> That avoids 1) inconsistencies between the array size and the array
> itself, 2) does not require to pad the array with zeroes.
> 
> [...]
> 
>> @@ -745,9 +752,12 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>>   	pm_runtime_enable(&pdev->dev);
>>   
>>   	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
>> -		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
>> -							    0, info,
>> -							    &sun4i_ts_tz_ops);
>> +		for (i = 0; i < info->data->sensor_count; i++) {
>> +			info->sensor_id = i;
>> +			info->tzd = thermal_zone_of_sensor_register(
>> +					info->sensor_device,
>> +					i, info, &sun4i_ts_tz_ops);
>> +		}
> 
> As Maxime said, this does not work.
> 
> One way would be to have a new structure being:
> struct sun4i_sensor_info {
> 	struct sun4i_gpadc_iio	*info;
> 	unsigned int		sensor_id;
> };
> 
> Or since we only use the iio_dev within the sun4i_gpadc_iio in the
> .get_temp function, we may replace info by struct iio_dev *indio_dev
> above.
> 
> Quentin
> 
I will have a closer look on this next week, when I start to work on the 
next version..

Thanks,
Philipp

[1]: http://linux-sunxi.org/Thermal_Sensor
