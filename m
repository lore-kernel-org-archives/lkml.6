Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeEJTnP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:43:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33759 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbeEJTnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:43:11 -0400
X-Google-Smtp-Source: AB8JxZrOuik2w0oBzN+jKtgbr2K0MqYIhTsMKYYfx1mH7SFKBkFnGVA7KABlTBgORibqwVqLiQt1cA==
Subject: Re: [PATCH v2 2/2] leds: Add Spreadtrum SC27xx breathing light
 controller driver
To: Pavel Machek <pavel@ucw.cz>
Cc: Baolin Wang <baolin.wang@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, xiaotong.lu@spreadtrum.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
 <9a2a07b8eb313ae3ba64af911337ee7ff7c9ad43.1525757122.git.baolin.wang@linaro.org>
 <20180509142539.GB25131@amd> <bddc1f89-8c2c-ba6e-3c7e-d89710ed5424@gmail.com>
 <20180510113749.GG6977@amd>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <6289571e-7224-ca5e-1acf-5b099be57302@gmail.com>
Date: Thu, 10 May 2018 21:41:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510113749.GG6977@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 05/10/2018 01:37 PM, Pavel Machek wrote:
> Hi!
> 
>>>> This patch adds Spreadtrum SC27xx PMIC series breathing light controller
>>>> driver, which can support 3 LEDs. Each LED can work at normal PWM mode
>>>> and breathing mode.
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>>>> new file mode 100644
>>>> index 0000000..22166fb
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>>>> @@ -0,0 +1,19 @@
>>>> +What:		/sys/class/leds/<led>/rise_time
>>>> +What:		/sys/class/leds/<led>/high_time
>>>> +What:		/sys/class/leds/<led>/fall_time
>>>> +What:		/sys/class/leds/<led>/low_time
>>>> +Date:		May 2018
>>>> +KernelVersion:	4.18
>>>> +Contact:	Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>>>> +Description:
>>>> +		Set the pattern generator rise, high, fall and low
>>>> +		times (0..63). It's unit is 0.125s, it should be > 0.
>>>> +
>>>> +		1 - 125 ms
>>>> +		2 - 250 ms
>>>> +		3 - 375 ms
>>>> +		...
>>>> +		...
>>>> +		...
>>>> +		62 - 7.75 s
>>>> +		63 - 7.875 s
>>>
>>> How does this interact with triggers? With manually setting
>>> brightness? Are the pattern generators independend for the LEDs?
>>>
>>> Can you generate white breathing pattern? If so, how?
>>>
>>> How do you select between normal and breathing modes?
>>>
>>> I'd specify times in miliseconds or something, this is way too
>>> hardware specific.
>>
>> Agreed.
>>
>>> Now... functionality like this is common between many LED
>>> controllers. N900 could do this kind of "breathing", too, and it also
>>> supports other patterns.
>>>
>>> I believe we need interface common between different LED controllers.
>>>
>>> And I guess it would be easiest if you dropped this part from initial
>>> merge.
>>
>> I disagree here. We already had the same discussion at the occasion
>> of the patch [0] and it turned out to be a dead-end [1]. Now we have
>> neither the driver nor the generic pattern interface.
>>
>> We also already have some older LED class drivers that implement custom
>> pattern interfaces (e.g. drivers/leds/leds-lm3533.c) and the same
>> approach can be applied in this case.
> 
> Please don't. It was mistake to implement custom pattern interfaces
> back then, it is still mistake now.

It turned out to be really hard to cover all known pattern generator
implementations with generic interface. Sure, it would be nice to have
one, but the whole discussion around [0] only unveiled the diversity of
parameters to cover. And still new devices appear on the market.

We would have to propose a set of pattern schemes and allow to
add new ones to it.

> If we really need solution now, I'd recommend "pattern" file with
> 
> "<delta time> <brightness> <delta time> <brightness>".
> 
> In this specific case, hardware only supports patterns in this format:
> 
> low_time 0 rise_time 255 high_time 255 fall_time 0
> 
> so driver would simply -EINVAL on anything else.

I'm fine with the pattern file, but the pattern format would have
to be defined in the per-driver ABI documentation. It wouldn't much
differ from the custom pattern approach though, unless I'm missing some
gain of having pattern setting in a uniformly named single sysfs file
(with semantics differing from driver to driver).

-- 
Best regards,
Jacek Anaszewski
