Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeE3LBu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:01:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55621 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeE3LBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:01:38 -0400
X-Google-Smtp-Source: ADUXVKJRyFljY6Rl5SM2XSMAnlODLmSANEYx/b4l+HH/D09fk3iSf3KuyJB0ObR3Xs8E+CR5R04/ag==
Subject: Re: [PATCH 4/6] mfd: da9063: Disallow RTC on DA9063L
To: Lee Jones <lee.jones@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-4-marek.vasut+renesas@gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941A488A@SW-EX-MBX02.diasemi.com>
 <20180529075505.GD4790@dell>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <2960b4f7-7fb4-48d4-5b2c-5cc1bdc80ef5@gmail.com>
Date: Wed, 30 May 2018 12:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529075505.GD4790@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 09:55 AM, Lee Jones wrote:
> On Thu, 24 May 2018, Steve Twiss wrote:
> 
>> Thanks Marek,
>>
>> On 23 May 2018 12:42 Marek Vasut wrote,
>>
>>> To: linux-kernel@vger.kernel.org
>>> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>; Geert Uytterhoeven <geert+renesas@glider.be>; Lee Jones <lee.jones@linaro.org>; Mark Brown <broonie@kernel.org>; Steve Twiss <stwiss.opensource@diasemi.com>; Wolfram Sang <wsa+renesas@sang-engineering.com>; linux-renesas-soc@vger.kernel.org
>>> Subject: [PATCH 4/6] mfd: da9063: Disallow RTC on DA9063L
>>>
>>> The DA9063L does not contain RTC block, unlike the full DA9063.
>>> Do not allow binding RTC driver on this variant of the chip.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Lee Jones <lee.jones@linaro.org>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
>>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>> Cc: linux-renesas-soc@vger.kernel.org
>>> ---
>>>  drivers/mfd/da9063-core.c | 18 +++++++++++-------
>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c index 7360b76b4f72..263c83006413 100644
>>> --- a/drivers/mfd/da9063-core.c
>>> +++ b/drivers/mfd/da9063-core.c
>>> @@ -101,14 +101,14 @@ static const struct mfd_cell da9063_devs[] = {
>>>  		.of_compatible = "dlg,da9063-onkey",
>>>  	},
>>>  	{
>>> +		.name		= DA9063_DRVNAME_VIBRATION,
>>> +	},
>>> +	{	/* Only present on DA9063 , not on DA9063L */
>>>  		.name		= DA9063_DRVNAME_RTC,
>>>  		.num_resources	= ARRAY_SIZE(da9063_rtc_resources),
>>>  		.resources	= da9063_rtc_resources,
>>>  		.of_compatible	= "dlg,da9063-rtc",
>>>  	},
>>> -	{
>>> -		.name		= DA9063_DRVNAME_VIBRATION,
>>> -	},
>>>  };
>>>  
>>>  static int da9063_clear_fault_log(struct da9063 *da9063) @@ -163,7 +163,7 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)  {
>>>  	struct da9063_pdata *pdata = da9063->dev->platform_data;
>>>  	int model, variant_id, variant_code;
>>> -	int ret;
>>> +	int da9063_devs_len, ret;
>>>  
>>>  	ret = da9063_clear_fault_log(da9063);
>>>  	if (ret < 0)
>>> @@ -225,9 +225,13 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>>>  
>>>  	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
>>>  
>>> -	ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
>>> -			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
>>> -			      NULL);
>>> +	da9063_devs_len = ARRAY_SIZE(da9063_devs);
>>> +	/* RTC, the last device in the list, is only present on DA9063 */
>>> +	if (da9063->type == PMIC_TYPE_DA9063L)
>>> +		da9063_devs_len -= 1;
>>> +
>>> +	ret = mfd_add_devices(da9063->dev, -1, da9063_devs, da9063_devs_len,
>>> +			      NULL, da9063->irq_base, NULL);
>>>  	if (ret)
>>>  		dev_err(da9063->dev, "Cannot add MFD cells\n");
>>>  
>>
>> MFD cells definitely has less impact than regmap_range and regmap_irq.
>> I agree, there's no point in having a completely new 
>> static const struct mfd_cell da9063l_devs[] = { ... }  for DA9063L
> 
> This solution is fragile.
> 
> I agree that a new MFD cell is not required in its entirety.  It
> would however, be better to split out the RTC entry into a new one and
> only register it when (da9063->type == PMIC_TYPE_DA9063).  This is a
> better solution than messing around with passed struct sizes.

This indeed is better.

btw this da9063_device_init() function is missing a failpath to undo the
setup done by da9063_irq_init(), so I'll be sending a patch for that too
shortly.

-- 
Best regards,
Marek Vasut
