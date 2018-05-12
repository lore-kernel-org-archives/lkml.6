Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeELUp4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 16:45:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37169 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeELUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 16:45:53 -0400
X-Google-Smtp-Source: AB8JxZoBhgly9E4aVxEe1lYauN4cP5WE36TMM0Tlwf1Bz+/0n4G2sThpCtdEI6D+3FP2W3eB7Zz9pg==
Subject: Re: [PATCH v2 2/2] leds: Add Spreadtrum SC27xx breathing light
 controller driver
To: Pavel Machek <pavel@ucw.cz>
References: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
 <9a2a07b8eb313ae3ba64af911337ee7ff7c9ad43.1525757122.git.baolin.wang@linaro.org>
 <20180509142539.GB25131@amd> <bddc1f89-8c2c-ba6e-3c7e-d89710ed5424@gmail.com>
 <20180510113749.GG6977@amd> <6289571e-7224-ca5e-1acf-5b099be57302@gmail.com>
 <20180512083559.GB8944@amd>
Cc: Baolin Wang <baolin.wang@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, xiaotong.lu@spreadtrum.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <7c9d5eec-4e6b-9b26-470c-f8002cca5f27@gmail.com>
Date: Sat, 12 May 2018 22:44:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180512083559.GB8944@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 05/12/2018 10:35 AM, Pavel Machek wrote:
> Hi!
>
>>>> I disagree here. We already had the same discussion at the occasion
>>>> of the patch [0] and it turned out to be a dead-end [1]. Now we have
>>>> neither the driver nor the generic pattern interface.
>>>>
>>>> We also already have some older LED class drivers that implement custom
>>>> pattern interfaces (e.g. drivers/leds/leds-lm3533.c) and the same
>>>> approach can be applied in this case.
>>>
>>> Please don't. It was mistake to implement custom pattern interfaces
>>> back then, it is still mistake now.
>>
>> It turned out to be really hard to cover all known pattern generator
>> implementations with generic interface. Sure, it would be nice to have
>> one, but the whole discussion around [0] only unveiled the diversity of
>> parameters to cover. And still new devices appear on the market.
>>
>> We would have to propose a set of pattern schemes and allow to
>> add new ones to it.
>
> I believe that what I'm proposing below is close enough to universal.
>
>>> If we really need solution now, I'd recommend "pattern" file with
>>>
>>> "<delta time> <brightness> <delta time> <brightness>".
>>>
>>> In this specific case, hardware only supports patterns in this format:
>>>
>>> low_time 0 rise_time 255 high_time 255 fall_time 0
>>>
>>> so driver would simply -EINVAL on anything else.
>>
>> I'm fine with the pattern file, but the pattern format would have
>> to be defined in the per-driver ABI documentation. It wouldn't much
>> differ from the custom pattern approach though, unless I'm missing some
>> gain of having pattern setting in a uniformly named single sysfs file
>> (with semantics differing from driver to driver).
>
> I'm proposing "<delta time> <brightness> ..." sysfs file. It certainly
> covers this hardware, it would be enough to cover the Qualcomm Pulse
> generator (IIRC), and it would cover most uses cases of Nokia N900's
> LED.
>
> Yes, we would need to document limitations of each chip. But it should
> be easily possible to run pattern designed for Spreadtrum on N900,
> even if it would not work the other way around.
>
> (If someone really wants to run complex patterns on simple hardware,
> we can provide software emulation using same file format. I believe I
> still have that patch somewhere.)

OK, I've revised the discussion under Qualcomm LPG patch set and
it seems that we have almost ready solution in [0], except the
pattern_repeat file you mention in [1]. So probably Baolin could
address your remarks from [1] and add pattern_repeat file to the
patch that begins thread [0].

[0] https://lkml.org/lkml/2017/11/15/27
[1] https://lkml.org/lkml/2017/12/8/470

-- 
Best regards,
Jacek Anaszewski
