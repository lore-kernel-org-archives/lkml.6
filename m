Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeC1K67 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:58:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47324 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC1K66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:58:58 -0400
Subject: Re: [PATCH v4 4/8] mfd: cros_ec_dev: Register cros-ec-rtc driver as a
 subdevice.
To: Lee Jones <lee.jones@linaro.org>
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org
References: <20180320122751.14019-1-enric.balletbo@collabora.com>
 <20180320122751.14019-5-enric.balletbo@collabora.com>
 <20180328105415.gwe2yaddhmauvzqr@dell>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <262e7e55-233a-e3d7-b165-46d3c9fd7d51@collabora.com>
Date: Wed, 28 Mar 2018 12:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328105415.gwe2yaddhmauvzqr@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/03/18 12:54, Lee Jones wrote:
> On Tue, 20 Mar 2018, Enric Balletbo i Serra wrote:
> 
>> Check whether this EC instance has RTC host command support and instatiate
>> the RTC driver as a subdevice in such case.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>>
>> Changes in v4:
>> - [4/8] Nit: check -> Check (Lee Jones)
>> - [4/8] Use ARRAY_SIZE() instead of hardcoded number (Lee Jones)
>>
>> Changes in v3:
>> - [4/8] Add the Reviewed-by Andy Shevchenko.
>>
>> Changes in v2:
>> - [4/8] Add the Reviewed-by Gwendal.
>>
>>  drivers/mfd/cros_ec_dev.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
>> index f98e5beffca6..f60a53f11942 100644
>> --- a/drivers/mfd/cros_ec_dev.c
>> +++ b/drivers/mfd/cros_ec_dev.c
>> @@ -389,6 +389,12 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>>  	kfree(msg);
>>  }
>>  
>> +static const struct mfd_cell cros_ec_rtc_cells[] = {
>> +	{
>> +		.name = "cros-ec-rtc",
>> +	}
> 
> You're going to hate me, but ...
> 

Nope, it's fine :)

I am creating a note with all these things, so hopefully next time I'll do better.

> One line and no need for the comma.
> 
> 	{ .name = "cros-ec-rtc" }
> 
>> +};
>> +

Ok, I'll wait today for if something else arises and send v5 tomorrow.

Thanks,
 Enric

>>  static int ec_device_probe(struct platform_device *pdev)
>>  {
>>  	int retval = -ENOMEM;
>> @@ -437,6 +443,18 @@ static int ec_device_probe(struct platform_device *pdev)
>>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>>  		cros_ec_sensors_register(ec);
>>  
>> +	/* Check whether this EC instance has RTC host command support */
>> +	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
>> +		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
>> +					 cros_ec_rtc_cells,
>> +					 ARRAY_SIZE(cros_ec_rtc_cells),
>> +					 NULL, 0, NULL);
>> +		if (retval)
>> +			dev_err(ec->dev,
>> +				"failed to add cros-ec-rtc device: %d\n",
>> +				retval);
>> +	}
>> +
>>  	/* Take control of the lightbar from the EC. */
>>  	lb_manual_suspend_ctrl(ec, 1);
>>  
> 
