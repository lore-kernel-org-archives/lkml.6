Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeFEKAp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:00:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33861 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeFEKAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:00:42 -0400
X-Google-Smtp-Source: ADUXVKKCHxfn60k9R8akGozsR8oBXt7O/QO3zrmsz3YnS4tcn/RHYe/IECeNGVCSbINp1wCoJFyLbw==
Subject: Re: [PATCH v3 08/10] mfd: da9063: Register RTC only on DA9063L
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-8-marek.vasut+renesas@gmail.com>
 <20180605075321.GM21163@dell>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <ac43842f-7d8a-1d6d-7077-9fb58ab852b7@gmail.com>
Date: Tue, 5 Jun 2018 11:29:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605075321.GM21163@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 09:53 AM, Lee Jones wrote:
> On Sat, 02 Jun 2018, Marek Vasut wrote:
> 
>> The DA9063L does not contain RTC block, unlike the full DA9063.
>> Split the RTC block into separate mfd cell and register it only
>> on DA9063.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> V2: No change
>> V3: Rework of mfd: da9063: Disallow RTC on DA9063L
>> ---
>>  drivers/mfd/da9063-core.c | 30 +++++++++++++++++++++++-------
>>  1 file changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
>> index eebca3442cf3..b05910c797af 100644
>> --- a/drivers/mfd/da9063-core.c
>> +++ b/drivers/mfd/da9063-core.c
>> @@ -76,7 +76,7 @@ static struct resource da9063_hwmon_resources[] = {
>>  };
>>  
>>  
>> -static const struct mfd_cell da9063_devs[] = {
>> +static const struct mfd_cell da9063_common_devs[] = {
>>  	{
>>  		.name		= DA9063_DRVNAME_REGULATORS,
> 
> Appreciate that these are historical, but these device name defines
> make me shudder.  They only serve to act as an obfuscation layer when
> debugging at platform level.  Please consider getting rid of them.

The macro can be shared between the core and the drivers, so the names
never run out of sync.

>>  		.num_resources	= ARRAY_SIZE(da9063_regulators_resources),
>> @@ -100,15 +100,19 @@ static const struct mfd_cell da9063_devs[] = {
>>  		.resources	= da9063_onkey_resources,
>>  		.of_compatible = "dlg,da9063-onkey",
>>  	},
>> +	{
>> +		.name		= DA9063_DRVNAME_VIBRATION,
>> +	},
> 
> Place this on a single line please.

This would only make the style inconsistent with the ie. LEDs entry.

>         { .name	= DA9063_DRVNAME_VIBRATION },
> 
>> +};
>> +
>> +/* Only present on DA9063 , not on DA9063L */
>> +static const struct mfd_cell da9063_devs[] = {
>>  	{
>>  		.name		= DA9063_DRVNAME_RTC,
>>  		.num_resources	= ARRAY_SIZE(da9063_rtc_resources),
>>  		.resources	= da9063_rtc_resources,
>>  		.of_compatible	= "dlg,da9063-rtc",
>>  	},
>> -	{
>> -		.name		= DA9063_DRVNAME_VIBRATION,
>> -	},
>>  };
>>  
>>  static int da9063_clear_fault_log(struct da9063 *da9063)
>> @@ -225,16 +229,28 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>>  
>>  	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
>>  
>> -	ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
>> -			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
>> -			      NULL);
>> +	ret = mfd_add_devices(da9063->dev, -1, da9063_common_devs,
> 
> Please consider updating the -1's in this file with the appropriate
> define in a separate patch.

Done

>> +			      ARRAY_SIZE(da9063_common_devs),
>> +			      NULL, da9063->irq_base, NULL);
>>  	if (ret) {
>>  		dev_err(da9063->dev, "Cannot add MFD cells\n");
>>  		goto err_irq_exit;
>>  	}
>>  
>> +	if (da9063->type == PMIC_TYPE_DA9063) {
>> +		ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
>> +				      ARRAY_SIZE(da9063_devs),
>> +				      NULL, da9063->irq_base, NULL);
>> +		if (ret) {
>> +			dev_err(da9063->dev, "Cannot add MFD cells\n");
> 
> Better to be more general here.
> 
> "Failed to add child devices" or such.
> 
> Users don't tend to care about MFD cells.

Hum, done.

>> +			goto err_mfd_cleanup;
>> +		}
>> +	}
>> +
>>  	return ret;
>>  
>> +err_mfd_cleanup:
>> +	mfd_remove_devices(da9063->dev);
> 
> Any reason why you can't use devm_*?

Because we need to undo the MFD setup before the IRQ setup.

>>  err_irq_exit:
>>  	da9063_irq_exit(da9063);
>>  	return ret;
> 


-- 
Best regards,
Marek Vasut
