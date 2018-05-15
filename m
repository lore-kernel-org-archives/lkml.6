Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeEOWYv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:24:51 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:41500 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeEOWYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:24:48 -0400
X-Google-Smtp-Source: AB8JxZpRl/kKuKJ2A/iArJE4OIYaa/eviU8hIISkw8nYWj3jG/2cEow/6t/wxvBYnuvtmg5K4tBiq/4pxkxyrxuDNiU=
MIME-Version: 1.0
In-Reply-To: <08dda10d-f865-9cf2-b9a5-c79cbab5da98@ti.com>
References: <20180515154352.20263-1-dmurphy@ti.com> <20180515154352.20263-2-dmurphy@ti.com>
 <CAHp75VegjkiiD1qTGpi9rr6cg=72t9kSwDrG=sUpUWFVO58M4A@mail.gmail.com> <08dda10d-f865-9cf2-b9a5-c79cbab5da98@ti.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 01:24:47 +0300
Message-ID: <CAHp75Vcz08zrs3bgMFcvYwRrN_A43D=Nvt5cFDQf8m9whB=yhA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Dan Murphy <dmurphy@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 1:08 AM, Dan Murphy <dmurphy@ti.com> wrote:
> On 05/15/2018 04:56 PM, Andy Shevchenko wrote:
>> On Tue, May 15, 2018 at 6:43 PM, Dan Murphy <dmurphy@ti.com> wrote:

>>> +       depends on LEDS_CLASS && I2C && OF
>>
>> What is OF specific in this driver?
>
> as3645a_led_class_setup has a "of" dependency

So what? Is it called from this driver or?


>>> +static const struct lm3601x_max_timeouts strobe_timeouts[] = {
>>> +       { 40000, 0x00 },
>>> +       { 80000, 0x01 },
>>> +       { 120000, 0x02 },
>>> +       { 160000, 0x03 },
>>> +       { 200000, 0x04 },
>>> +       { 240000, 0x05 },
>>> +       { 280000, 0x06 },
>>> +       { 320000, 0x07 },
>>> +       { 360000, 0x08 },
>>> +       { 400000, 0x09 },
>>> +       { 600000, 0x0a },
>>> +       { 800000, 0x0b },
>>> +       { 1000000, 0x0c },
>>> +       { 1200000, 0x0d },
>>> +       { 1400000, 0x0e },
>>> +       { 1600000, 0x0f },
>>
>> Huh?!
>
> Please give comments that actually mean something other wise I will opt to ignore them.

I did below.

>> strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;
>
> Not sure what equation you are trying to point out here.  But if you are trying to apply
> a timeout step you cannot do this with this part.  As pointed out in the DT doc the timeout
> step is not linear.

Yeah, I know people are more than often too lazy to think.

if (x < 9)
 strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;
else
 strobe_timeout = (400 + (x - 9) * 200) * MSECS_IN_SEC;

>>> +               brightness_val = (brightness/2);
>>
>> Spaces.
>
> Not sure what this means checkpatch was clean

Even besides missed whispaces it has redundant parens.

checkpatch is not a silver bullet to get your code clean and nice.

>> This is return led_...();
>
> That is a preference.  It does not have to be that way.

What do you mean? We do not appreciate +LOCs for no (or even nagative!) benefit.

>>> +               ret = of_property_read_string(led->led_node, "label", &name);
>>
>> device_property_...();
>
> It can be if the maintainer is requesting this.

Jacek, if you need rationale behind this comment it's here: the driver
has nothing DT specific and getting rid of OF centric programming
allows to reuse the driver on non-DT platforms w/o touching a source
code.

> Is the trend to move to these functions?

See above.

> Most drivers use the "of" calls.

So what?


>>> +               if (!ret)
>>
>> if (ret) sounds more natural. And better just to split
>>
>>> +                       snprintf(led->led_name, sizeof(led->led_name),
>>> +                               "%s:%s", led->led_node->name, name);
>>> +               else
>>> +                       snprintf(led->led_name, sizeof(led->led_name),
>>> +                               "%s:torch", led->led_node->name);
>>
>> const char *tmp;
>>
>> ret = device_property_read_...(&tmp);
>> if (ret)
>>  tmp = ...
>> sprintf(...);

No comments on this?

>>> +       led = devm_kzalloc(&client->dev,
>>> +                           sizeof(struct lm3601x_led), GFP_KERNEL);
>>
>> sizeof(*led) and one line in the result

And this?


>>> +       { },
>>
>> Terminators better w/o comma.
>
> Looking at other drivers adding comma's on the sentinel is accepted.  See the as3645a driver

So what?

Terminator at compile time even better.

>>> +       {},
>>
>> Ditto.
>
> See above

See above.

-- 
With Best Regards,
Andy Shevchenko
