Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeB1O2X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:28:23 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36617 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeB1O2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:28:22 -0500
X-Google-Smtp-Source: AH8x227afaF/yNTS3GHId8kzH4rDRgGEBCFKvWaTu4abvuHpZEBJNmwJs8gPv7dSaV0QmrKwqyKpAQ==
Subject: Re: [PATCH v1] extcon: int3496: Ignore incorrect IoRestriction for ID
 pin
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, linux-kernel@vger.kernel.org
References: <CGME20180226193456epcas3p39565d818a6a57db386bd5e81aed20674@epcas3p3.samsung.com>
 <20180226193444.69883-1-andriy.shevchenko@linux.intel.com>
 <5A94D7AD.6020402@samsung.com> <1519828022.10722.299.camel@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5c0a3742-834f-af4f-8bc7-c9d97781baf2@redhat.com>
Date: Wed, 28 Feb 2018 15:28:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519828022.10722.299.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-02-18 15:27, Andy Shevchenko wrote:
> On Tue, 2018-02-27 at 12:59 +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2018년 02월 27일 04:34, Andy Shevchenko wrote:
>>> The commit 70216fd937fe introduced a workaround for incorrect
>>
>> You better to specify the commit id and patch name as following:
>> commit 70216fd937fe -> commit 70216fd937fe ("extcon: int3496: Set the
>> id pin to direction-input if necessary")
> 
> Will fix in v2.

Note I'm currently running some tests with this patch, should be
done in an hour max.

Regards,

Hans


> 
>>
>>> IoRestriction mode in ACPI table.
>>>
>>> Now, when GPIO ACPI library does it in generic way, just set
>>
>> I recommend that you specify clearly which patch you mention
>> about GPIO ACPI library.
> 
> Do you mean list all of them? It's a bit hard to choose one.
> 
>>> an appropriate quirk flag instead.
>>>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>   drivers/extcon/extcon-intel-int3496.c | 9 +++++----
>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-intel-int3496.c
>>> b/drivers/extcon/extcon-intel-int3496.c
>>> index 191e99f06a9a..acaccb128fc4 100644
>>> --- a/drivers/extcon/extcon-intel-int3496.c
>>> +++ b/drivers/extcon/extcon-intel-int3496.c
>>> @@ -50,7 +50,11 @@ static const struct acpi_gpio_params vbus_gpios =
>>> { INT3496_GPIO_VBUS_EN, 0, fal
>>>   static const struct acpi_gpio_params mux_gpios = {
>>> INT3496_GPIO_USB_MUX, 0, false };
>>>   
>>>   static const struct acpi_gpio_mapping acpi_int3496_default_gpios[]
>>> = {
>>> -	{ "id-gpios", &id_gpios, 1 },
>>> +	/*
>>> +	 * Some platforms have a bug in ACPI GPIO description
>>> making IRQ
>>> +	 * GPIO to be output only. Ask the GPIO core to ignore this
>>> limit.
>>> +	 */
>>> +	{ "id-gpios", &id_gpios, 1,
>>> ACPI_GPIO_QUIRK_NO_IO_RESTRICTION },
>>>   	{ "vbus-gpios", &vbus_gpios, 1 },
>>>   	{ "mux-gpios", &mux_gpios, 1 },
>>>   	{ },
>>> @@ -112,9 +116,6 @@ static int int3496_probe(struct platform_device
>>> *pdev)
>>>   		ret = PTR_ERR(data->gpio_usb_id);
>>>   		dev_err(dev, "can't request USB ID GPIO: %d\n",
>>> ret);
>>>   		return ret;
>>> -	} else if (gpiod_get_direction(data->gpio_usb_id) !=
>>> GPIOF_DIR_IN) {
>>> -		dev_warn(dev, FW_BUG "USB ID GPIO not in input
>>> mode, fixing\n");
>>> -		gpiod_direction_input(data->gpio_usb_id);
>>>   	}
>>>   
>>>   	data->usb_id_irq = gpiod_to_irq(data->gpio_usb_id);
>>>
>>
>>
> 
