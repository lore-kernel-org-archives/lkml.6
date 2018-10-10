Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2338C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF442064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciel9o+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF442064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJJJev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 05:34:51 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:40886 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeJJJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 05:34:51 -0400
Received: by mail-lf1-f51.google.com with SMTP id t22-v6so2774246lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 19:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P/Sho3JimvBd+HdzjYQQ7EgIOkz14mUaOsYtQlmE5TQ=;
        b=ciel9o+tGb+dAx+CweXfwJzOd3gyaQ8RHgcvwndZ2/axzXNh7UreHAL2CH6NHje1Rn
         aZKussyjP6JIOsP8y2vgDjkdZaFp+c7O6+iZfQbBtTxLxHkevHiCS/vV39Q2Lz4A0aGb
         k6WQmU1q7wM6CfgnyxQtEJPpr1kb5frJqL6uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P/Sho3JimvBd+HdzjYQQ7EgIOkz14mUaOsYtQlmE5TQ=;
        b=PhYEnbZ76zg8bhjlehF6q/g4z001DlMrIPnFJ+o4lE6LUdZZU2mLy/4DPJBGQv9usC
         R1wuJVngCr6XNJ7xui+XZXrXaB8HaBzu1PcW5hO4KbasWrz8p9eoYThmG7lWzc8QHRyR
         8zu3ka14RpyV3KbGqndAsQuzkqkh6+UVUZTawicbsxfdfJ8/HSFWmfTtdHFosBn5jI4A
         OEUQPvRF1YIgAkHQRFytHJgZoXRrUS0w/ss4oOJTA2561OUTDUa39v7Aw7hBYskd5xmb
         lOQRL592m8TLdKaE6PdSyH/kqWiGm3ARaVf9t+TtUEmBZmJ6dAjaS0ZQhA8ubNLwC6Zh
         1IcQ==
X-Gm-Message-State: ABuFfojlFVGcqhyv5nCqer+HE8enU4d1m9vekPWdGXU2q79xEgZrFDQk
        5HI+H83MYv7ObP5JN81IHjrfE9lUkO+eFrzv6gmKZw==
X-Google-Smtp-Source: ACcGV603whLAoJZ04xPRK5txiYiSizHpKAylU9X9K45JSgybySRfFOZ1dkYPnFeM5JexIRuyaeI9k8ZQMqa185Ipy4s=
X-Received: by 2002:a19:1941:: with SMTP id 62-v6mr15119371lfz.99.1539137696528;
 Tue, 09 Oct 2018 19:14:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Tue, 9 Oct 2018 19:14:56 -0700 (PDT)
In-Reply-To: <931be52e-fa7e-72f8-0e5f-9a8a006d6ccd@gmail.com>
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
 <9bf6236e-83af-7156-b26b-7d88ece2d81e@gmail.com> <CAMz4kuJ4iB7pn+i29aypnbxxPK_UDjus=EiNZ2WefBB0onZPTg@mail.gmail.com>
 <7051613e-f2db-260f-85d7-d40278fd11cb@gmail.com> <CAMz4kuKJ73mHzYotwmx08h1sJJiKAZNCspo0_v7L-2Ec+5rEQg@mail.gmail.com>
 <931be52e-fa7e-72f8-0e5f-9a8a006d6ccd@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 10 Oct 2018 10:14:56 +0800
Message-ID: <CAMz4kuKHRXNC=K4j01ReGHi1Zm=Q8UQfCAHppG3wqymmjbOL-Q@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 10 October 2018 at 02:37, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> On 10/09/2018 02:01 PM, Baolin Wang wrote:
>> Hi Jacek and Pavel,
>>
>> On 5 October 2018 at 04:00, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>> Hi Baolin,
>>>
>>> On 10/03/2018 03:21 AM, Baolin Wang wrote:
>>>> Hi Jacek,
>>>>
>>>> On 3 October 2018 at 04:25, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>>>> Hi Baolin,
>>>>>
>>>>> Thank you for the v14. We'll probably need v15, though :-)
>>>>>
>>>>> I added the comments in the code below.
>>>>>
>>>>> On 10/02/2018 05:43 PM, Baolin Wang wrote:
>>>>>> This patch adds one new led trigger that LED device can configure
>>>>>> the software or hardware pattern and trigger it.
>>>>>>
>>>>>> Consumers can write 'pattern' file to enable the software pattern
>>>>>> which alters the brightness for the specified duration with one
>>>>>> software timer.
>>>>>>
>>>>>> Moreover consumers can write 'hw_pattern' file to enable the hardware
>>>>>> pattern for some LED controllers which can autonomously control
>>>>>> brightness over time, according to some preprogrammed hardware
>>>>>> patterns.
>>>>>>
>>>>>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>>>> ---
>>>>>> Changes from v13:
>>>>>>  - Add duration validation for gradual dimming.
>>>>>>  - Coding style optimization.
>>>>>>
>>>>>> Changes from v12:
>>>>>>  - Add gradual dimming support for software pattern.
>>>>>>
>>>>>> Changes from v11:
>>>>>>  - Change -1 means repeat indefinitely.
>>>>>>
>>>>>> Changes from v10:
>>>>>>  - Change 'int' to 'u32' for delta_t field.
>>>>>>
>>>>>> Changes from v9:
>>>>>>  - None.
>>>>>>
>>>>>> Changes from v8:
>>>>>>  - None.
>>>>>>
>>>>>> Changes from v7:
>>>>>>  - Move the SC27XX hardware patterns description into its own ABI file.
>>>>>>
>>>>>> Changes from v6:
>>>>>>  - Improve commit message.
>>>>>>  - Optimize the description of the hw_pattern file.
>>>>>>  - Simplify some logics.
>>>>>>
>>>>>> Changes from v5:
>>>>>>  - Add one 'hw_pattern' file for hardware patterns.
>>>>>>
>>>>>> Changes from v4:
>>>>>>  - Change the repeat file to return the originally written number.
>>>>>>  - Improve comments.
>>>>>>  - Fix some build warnings.
>>>>>>
>>>>>> Changes from v3:
>>>>>>  - Reset pattern number to 0 if user provides incorrect pattern string.
>>>>>>  - Support one pattern.
>>>>>>
>>>>>> Changes from v2:
>>>>>>  - Remove hardware_pattern boolen.
>>>>>>  - Chnage the pattern string format.
>>>>>>
>>>>>> Changes from v1:
>>>>>>  - Use ATTRIBUTE_GROUPS() to define attributes.
>>>>>>  - Introduce hardware_pattern flag to determine if software pattern
>>>>>>  or hardware pattern.
>>>>>>  - Re-implement pattern_trig_store_pattern() function.
>>>>>>  - Remove pattern_get() interface.
>>>>>>  - Improve comments.
>>>>>>  - Other small optimization.
>>>>>> ---
>>>>>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |  76 ++++
>>>>>>  drivers/leds/trigger/Kconfig                       |   7 +
>>>>>>  drivers/leds/trigger/Makefile                      |   1 +
>>>>>>  drivers/leds/trigger/ledtrig-pattern.c             | 431 +++++++++++++++++++++
>>>>>>  include/linux/leds.h                               |  15 +
>>>>>>  5 files changed, 530 insertions(+)
>>>>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>>>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>>>>>
>>>>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>>>> new file mode 100644
>>>>>> index 0000000..22d7af7
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>>>> @@ -0,0 +1,76 @@
>>>>>> +What:                /sys/class/leds/<led>/pattern
>>>>>> +Date:                September 2018
>>>>>> +KernelVersion:       4.20
>>>>>> +Description:
>>>>>> +             Specify a software pattern for the LED, that supports altering
>>>>>> +             the brightness for the specified duration with one software
>>>>>> +             timer. It can do gradual dimming and constant brightness.
>>>>>> +
>>>>>> +             The pattern is given by a series of tuples, of brightness and
>>>>>> +             duration (ms). The LED is expected to traverse the series and
>>>>>> +             each brightness value for the specified duration. Duration of
>>>>>> +             0 means brightness should immediately change to new value.
>>>>>> +
>>>>>> +             1. When doing gradual dimming, the led brightness will be updated
>>>>>> +             every 50 milliseconds, so the duration of each step should not
>>>>>> +             less than 50 milliseconds.
>>>>>
>>>>> I'd like to avoid this constraint. Lowest supported delta_t should be 1.
>>>>>
>>>>> We should only prevent entering dimming mode if current delta_t
>>>>> is lower than UPDATE_INTERVAL.
>>>>
>>>> I do not think so. If the pattern format is used for dimming and the
>>>> delta_t is lower than UPDATE_INTERVAL, we should return errors. Since
>>>> in this case, we can not change to constant mode.
>>>
>>> I'll play with the code at weekend and will let you know my findings.
>>
>> Thanks Jacek. Do you have any more suggestion?
>
> Sorry to say, but I had really busy weekend and failed to carve out
> time for looking into that. It's queued up with the highest priority
> on my todo list of things needing more than five minutes of attention.

Ah, okay, no hurry :)

>> BTW, we have not get a consensus about adding one 'dimming_interval'
>> file to set the dimming interval instead of fixed 50 ms.
>> Pavel, I want to hear your suggestion before I submit new patch set? Thanks.
>
> I think that this feature belongs to the "nice to have" category,
> and lack of it will not prevent us from merging the patch set.

OK. Thanks.

-- 
Baolin Wang
Best Regards
