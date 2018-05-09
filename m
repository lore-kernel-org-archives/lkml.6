Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965630AbeEITmA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:42:00 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35640 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964850AbeEITl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:41:58 -0400
X-Google-Smtp-Source: AB8JxZrmbQnOiuJbnEgQ3hvj/K5ecYXMOZQg/HEs42SEE466ycac7ZrvCOUkL1Hip/7hbMB8u8kC1A==
Subject: Re: [PATCH v2 2/2] leds: Add Spreadtrum SC27xx breathing light
 controller driver
To: Pavel Machek <pavel@ucw.cz>, Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, xiaotong.lu@spreadtrum.com,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
 <9a2a07b8eb313ae3ba64af911337ee7ff7c9ad43.1525757122.git.baolin.wang@linaro.org>
 <20180509142539.GB25131@amd>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <bddc1f89-8c2c-ba6e-3c7e-d89710ed5424@gmail.com>
Date: Wed, 9 May 2018 21:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509142539.GB25131@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/09/2018 04:25 PM, Pavel Machek wrote:
> On Tue 2018-05-08 13:39:45, Baolin Wang wrote:
>> From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>>
>> This patch adds Spreadtrum SC27xx PMIC series breathing light controller
>> driver, which can support 3 LEDs. Each LED can work at normal PWM mode
>> and breathing mode.
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>> new file mode 100644
>> index 0000000..22166fb
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>> @@ -0,0 +1,19 @@
>> +What:		/sys/class/leds/<led>/rise_time
>> +What:		/sys/class/leds/<led>/high_time
>> +What:		/sys/class/leds/<led>/fall_time
>> +What:		/sys/class/leds/<led>/low_time
>> +Date:		May 2018
>> +KernelVersion:	4.18
>> +Contact:	Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>> +Description:
>> +		Set the pattern generator rise, high, fall and low
>> +		times (0..63). It's unit is 0.125s, it should be > 0.
>> +
>> +		1 - 125 ms
>> +		2 - 250 ms
>> +		3 - 375 ms
>> +		...
>> +		...
>> +		...
>> +		62 - 7.75 s
>> +		63 - 7.875 s
> 
> How does this interact with triggers? With manually setting
> brightness? Are the pattern generators independend for the LEDs?
> 
> Can you generate white breathing pattern? If so, how?
> 
> How do you select between normal and breathing modes?
> 
> I'd specify times in miliseconds or something, this is way too
> hardware specific.

Agreed.

> Now... functionality like this is common between many LED
> controllers. N900 could do this kind of "breathing", too, and it also
> supports other patterns.
> 
> I believe we need interface common between different LED controllers.
> 
> And I guess it would be easiest if you dropped this part from initial
> merge.

I disagree here. We already had the same discussion at the occasion
of the patch [0] and it turned out to be a dead-end [1]. Now we have
neither the driver nor the generic pattern interface.

We also already have some older LED class drivers that implement custom
pattern interfaces (e.g. drivers/leds/leds-lm3533.c) and the same
approach can be applied in this case.

Regarding interaction with triggers - we could disable pattern
on setting any trigger and return -EBUSY from the pattern
interface if led_cdev->trigger is not NULL.

[0] https://lkml.org/lkml/2017/3/23/33
[1] https://lkml.org/lkml/2017/11/15/27

-- 
Best regards,
Jacek Anaszewski
