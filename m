Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753685AbeDJORZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:17:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52120 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753206AbeDJORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:17:23 -0400
X-Google-Smtp-Source: AIpwx48LLSzwoLGLXLRxL/zAVIHJeQ9QPWHRZrZ1MB7635Zb+6jPsJojWMqyHFgFtBjkRO2wH/aC6g==
Date: Tue, 10 Apr 2018 16:17:13 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180410105841.ne26heazhwwqjx7v@earth.universe>
References: <20180410090643.GA26554@thinkpad> <20180410105841.ne26heazhwwqjx7v@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v1] battery: Add the ThinkPad battery status quirk
To: Sebastian Reichel <sre@kernel.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
From: Ognjen Galic <smclt30p@gmail.com>
Message-ID: <3A23A2DC-121E-4DA6-863D-EFEAF420A5FB@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3AEHUa3032669



On April 10, 2018 12:58:41 PM GMT+02:00, Sebastian Reichel <sre@kernel.org> wrote:
>Hi,
>
>On Tue, Apr 10, 2018 at 11:06:43AM +0200, Ognjen Galic wrote:
>> The EC/ACPI firmware on Lenovo ThinkPads used to report a status
>> of "Unknown" when the battery is between the charge start and charge
>> stop thresholds. On Windows, it reports "Not Charging" so the quirk
>> has been added to fix the "Unknown" state.
>> 
>> The chosen new state when the battery is not charging is "Fully
>Charged"
>> because a status of "Not Charging" breaks almost all applications in
>> userspace that depend on upower, because upower in itself can't
>handle
>> a state of "Not Charging", defaulting to "Unknown".
>> 
>> When we report "Fully Charged" instead of "Unknown", the userspace
>handles
>> everything just fine, displaying for example: "Fully Charged, 59%" in
>Xfce.
>
>This probably breaks dual-battery Thinkpads, that charges batteries
>alternating (so one of them is "not charging" without being "fully
>charged"). The correct fix is to teach upower the "not charging"
>state. It exists since the existance of the power supply kernel API,
>so missing support is a bug in UPower.

I did write a patch for upower, submitted it and tested it. The problem is the bug report has been open for a month now and nothing major is happening. And the userspace is still broken.


>
>-- Sebastian
>
>> This is a re-write of: https://patchwork.kernel.org/patch/10205359/
>> 
>> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
>> ---
>>  drivers/acpi/battery.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index bdb24d63..cb4457a7 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -74,6 +74,7 @@ static async_cookie_t async_cookie;
>>  static bool battery_driver_registered;
>>  static int battery_bix_broken_package;
>>  static int battery_notification_delay_ms;
>> +static int battery_quirk_thinkpad_full;
>>  static unsigned int cache_time = 1000;
>>  module_param(cache_time, uint, 0644);
>>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
>> @@ -233,7 +234,8 @@ static int acpi_battery_get_property(struct
>power_supply *psy,
>>  			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>>  		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
>>  			val->intval = POWER_SUPPLY_STATUS_CHARGING;
>> -		else if (acpi_battery_is_charged(battery))
>> +		else if (acpi_battery_is_charged(battery) ||
>> +				battery_quirk_thinkpad_full)
>>  			val->intval = POWER_SUPPLY_STATUS_FULL;
>>  		else
>>  			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
>> @@ -1332,6 +1334,13 @@ battery_notification_delay_quirk(const struct
>dmi_system_id *d)
>>  	return 0;
>>  }
>>  
>> +static int __init
>> +battery_thinkpad_full_charged_quirk(const struct dmi_system_id *d)
>> +{
>> +	battery_quirk_thinkpad_full = 1;
>> +	return 0;
>> +}
>> +
>>  static const struct dmi_system_id bat_dmi_table[] __initconst = {
>>  	{
>>  		.callback = battery_bix_broken_package_quirk,
>> @@ -1349,6 +1358,14 @@ static const struct dmi_system_id
>bat_dmi_table[] __initconst = {
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
>>  		},
>>  	},
>> +	{
>> +		.callback = battery_thinkpad_full_charged_quirk,
>> +		.ident = "Lenovo ThinkPad",
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
>> +		},
>> +	},
>>  	{},
>>  };
>>  
>> -- 
>> 2.15.1
>> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
