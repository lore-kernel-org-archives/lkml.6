Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA3FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC0521852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeLRQb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:31:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49210 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeLRQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:31:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7A83826107F
Subject: Re: [PATCH v3 1/2] power: supply: add input voltage limit property
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        Sameer Nanda <snanda@chromium.org>, bleung@chromium.org,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com,
        kernel@collabora.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
References: <20181213120944.30967-1-enric.balletbo@collabora.com>
 <20181213222000.GA12302@amd>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2fcfc863-3218-55e8-2a0f-75d7cb2d55db@collabora.com>
Date:   Tue, 18 Dec 2018 17:31:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181213222000.GA12302@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 13/12/18 23:20, Pavel Machek wrote:
> Hi!
> 
>> This is part of the Pixel C's thermal management strategy to effectively
>> limit the input power to 5V 3A when the screen is on. When the screen is
>> on, the display, the CPU, and the GPU all contribute more heat to the
>> system than while the screen is off, and we made a tradeoff to throttle
>> the charger in order to give more of the thermal budget to those other
>> components.
>>
>> So there's nothing fundamentally broken about the hardware that would
>> cause the Pixel C to malfunction if we were charging at 9V or 12V instead
>> of 5V when the screen is on, ie if userspace doesn't change this.
>>
>> What would happen is that you wouldn't meet Google's skin temperature
>> targets on the system if the charger was allowed to run at 9V or 12V with
>> the screen on.
>>
>> For folks hacking on Pixel Cs (which is now outside of Google's official
>> support window for Android) and customizing their own kernel and userspace
>> this would be acceptable, but we wanted to expose this feature in the
>> power supply properties because the feature does exist in the Emedded
>> Controller firmware of the Pixel C and all of Google's Chromebooks with
>> USB-C made since 2015 in case someone running an up to date kernel wanted
>> to limit the charging power for thermal or other reasons.
>>
>> This patch exposes a new property, similar to input current limit, to
>> re-configure the maximum voltage from the external supply at runtime
>> based on system-level knowledge or user input.
> 
> Could we get power input limit, instead?
> 

I'm open but I have some concerns, so lets discuss a bit about it :)

According to the USB PD 2.0 specs if we limit the source at 15W we can get 5V/3A
or 9V/1.67A, if I am not mistaken the higher voltage caused problem since the
conversion to lower internal voltages generated more heat, so in this case
9V/1.67A is not a valid value for us (maybe someone from ChromeOS can confirm
this?).

There is also the USB Power Delivery Specification revision 3.0, who defines a
programmable power supply protocol that allows granular control over VBUS power
in 20 mV steps to facilitate constant current or constant voltage charging. So,
maybe we might be interested on set a specific constant current or a specific
contant voltage. I think that in this case would be interesting have the
possibility to set voltage or current. What do you think?

Thanks,
 Enric


> That is what you really want, it is more generally useful, and it is
> what current input limit should have been, in the first place...
> 
> Thanks,
> 									Pavel
> 
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Reviewed-by: Guenter Roeck <groeck@chromium.org>
>> ---
>>
>> Changes in v3:
>> - Improve commit log and documentation with Benson comments.
>>
>> Changes in v2:
>> - Document the new property in ABI/testing/sysfs-class-power.
>> - Add the Reviewed-by Guenter Roeck tag.
>>
>>  Documentation/ABI/testing/sysfs-class-power | 15 +++++++++++++++
>>  Documentation/power/power_supply_class.txt  |  2 ++
>>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>>  include/linux/power_supply.h                |  1 +
>>  4 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
>> index 5e23e22dce1b..6dee5c105a28 100644
>> --- a/Documentation/ABI/testing/sysfs-class-power
>> +++ b/Documentation/ABI/testing/sysfs-class-power
>> @@ -335,6 +335,21 @@ Description:
>>  		Access: Read, Write
>>  		Valid values: Represented in microamps
>>  
>> +What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
>> +Date:		Nov 2018
>> +Contact:	linux-pm@vger.kernel.org
>> +Description:
>> +		This entry configures the incoming VBUS voltage limit currently
>> +		set in the supply. Normally this is configured based on
>> +		system-level knowledge or user input (e.g. This is part of the
>> +		Pixel C's thermal management strategy to effectively limit the
>> +		input power to 5V when the screen is on to meet Google's skin
>> +		temperature targets). Note that this feature should not be
>> +		used for safety critical things.
>> +
>> +		Access: Read, Write
>> +		Valid values: Represented in microvolts
>> +
>>  What:		/sys/class/power_supply/<supply_name>/online,
>>  Date:		May 2007
>>  Contact:	linux-pm@vger.kernel.org
>> diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
>> index 300d37896e51..7b4be615b4f8 100644
>> --- a/Documentation/power/power_supply_class.txt
>> +++ b/Documentation/power/power_supply_class.txt
>> @@ -137,6 +137,8 @@ power supply object.
>>  
>>  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicates
>>  the current drawn from a charging source.
>> +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger. Indicates
>> +the voltage limit from a charging source.
>>  
>>  CHARGE_CONTROL_LIMIT - current charge control limit setting
>>  CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>> index dce24f596160..5848742ebb59 100644
>> --- a/drivers/power/supply/power_supply_sysfs.c
>> +++ b/drivers/power/supply/power_supply_sysfs.c
>> @@ -275,6 +275,7 @@ static struct device_attribute power_supply_attrs[] = {
>>  	POWER_SUPPLY_ATTR(charge_control_limit),
>>  	POWER_SUPPLY_ATTR(charge_control_limit_max),
>>  	POWER_SUPPLY_ATTR(input_current_limit),
>> +	POWER_SUPPLY_ATTR(input_voltage_limit),
>>  	POWER_SUPPLY_ATTR(energy_full_design),
>>  	POWER_SUPPLY_ATTR(energy_empty_design),
>>  	POWER_SUPPLY_ATTR(energy_full),
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index f80769175c56..608ba88e32ee 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -122,6 +122,7 @@ enum power_supply_property {
>>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
>>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>> +	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>>  	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
>>  	POWER_SUPPLY_PROP_ENERGY_FULL,
> 
