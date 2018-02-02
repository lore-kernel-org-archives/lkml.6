Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeBBIKM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 03:10:12 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51594 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbeBBIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 03:10:04 -0500
X-Google-Smtp-Source: AH8x226iKMLV5zWOlwcM975DB5RWFYa6JrGKlehOEdeo2EehRxPUWeWU9dlU752G84tv/NGUGecPAQ==
Subject: Re: [PATCH] extcon: int3496: process id-pin first so that we start
 with the right status
To: Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org
References: <CGME20180125193924epcas1p2d31c10f1552df00e572fe66ff9768591@epcas1p2.samsung.com>
 <20180125193919.1084-1-hdegoede@redhat.com> <5A73B1A5.5000907@samsung.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <9060e517-c67b-b04a-ba40-bc9e17bf2b4e@redhat.com>
Date: Fri, 2 Feb 2018 09:10:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A73B1A5.5000907@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02-02-18 01:32, Chanwoo Choi wrote:
> On 2018년 01월 26일 04:39, Hans de Goede wrote:
>> Some other drivers may be waiting for our extcon to show-up (exiting their
>> probe methods with -EPROBE_DEFER until we show up).
>>
>> These drivers will typically get the cable state directly after getting
>> the extcon, this commit changes the int3496 code to process the id-pin
>> before registering the extcon, so that other drivers see the correct state
>> right away.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/extcon/extcon-intel-int3496.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
>> index c8691b5a9cb0..b23ee9d993a3 100644
>> --- a/drivers/extcon/extcon-intel-int3496.c
>> +++ b/drivers/extcon/extcon-intel-int3496.c
>> @@ -131,6 +131,10 @@ static int int3496_probe(struct platform_device *pdev)
>>   	if (IS_ERR(data->gpio_usb_mux))
>>   		dev_info(dev, "can't request USB MUX GPIO\n");
>>   
>> +	/* process id-pin first so that we start with the right status */
>> +	queue_delayed_work(system_wq, &data->work, 0);
>> +	flush_delayed_work(&data->work);
>> +
>>   	/* register extcon device */
>>   	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
>>   	if (IS_ERR(data->edev))
>> @@ -153,9 +157,6 @@ static int int3496_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>   
>> -	/* queue initial processing of id-pin */
>> -	queue_delayed_work(system_wq, &data->work, 0);
>> -
>>   	platform_set_drvdata(pdev, data);
>>   
>>   	return 0;
>>
> 
> Looks good to me.
> How about adding the 'Fixes' commit id on patch description?

Right, this could use a:

Fixes: 2f556bdb9f2e ("extcon: int3496: Add Intel INT3496 ACPI device extcon driver")

tag.

> I think that your revert patch of axp288 and this patch
> should be included in extcon-fixes branch.

Ack.

Regards,

Hans
