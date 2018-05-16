Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeEPWL1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:11:27 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45821 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbeEPWLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:11:25 -0400
X-Google-Smtp-Source: AB8JxZp1er419L7xCCbQdGxTuQQkdl83LXUdWvc7ES8ucyOwhLr6OT60g+MAl942YqSLYxtBXRan7e/+t2V0NP/6BGg=
MIME-Version: 1.0
In-Reply-To: <3a0f27b7-86a1-235c-0a96-5ec9c8feb6f0@ti.com>
References: <20180515154352.20263-1-dmurphy@ti.com> <20180515154352.20263-2-dmurphy@ti.com>
 <CAHp75VegjkiiD1qTGpi9rr6cg=72t9kSwDrG=sUpUWFVO58M4A@mail.gmail.com>
 <08dda10d-f865-9cf2-b9a5-c79cbab5da98@ti.com> <CAHp75Vcz08zrs3bgMFcvYwRrN_A43D=Nvt5cFDQf8m9whB=yhA@mail.gmail.com>
 <3a0f27b7-86a1-235c-0a96-5ec9c8feb6f0@ti.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 17 May 2018 01:11:23 +0300
Message-ID: <CAHp75Vd-cyR7zVofP7g+4Z1ouqawV+Rqp5s5BcDhpGiHheUgpg@mail.gmail.com>
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

On Wed, May 16, 2018 at 11:43 PM, Dan Murphy <dmurphy@ti.com> wrote:
> On 05/15/2018 05:24 PM, Andy Shevchenko wrote:
>> On Wed, May 16, 2018 at 1:08 AM, Dan Murphy <dmurphy@ti.com> wrote:
>>> On 05/15/2018 04:56 PM, Andy Shevchenko wrote:
>>>> On Tue, May 15, 2018 at 6:43 PM, Dan Murphy <dmurphy@ti.com> wrote:

>>>>> +static const struct lm3601x_max_timeouts strobe_timeouts[] = {
>>>>> +       { 40000, 0x00 },
>>>>> +       { 80000, 0x01 },
>>>>> +       { 120000, 0x02 },
>>>>> +       { 160000, 0x03 },
>>>>> +       { 200000, 0x04 },
>>>>> +       { 240000, 0x05 },
>>>>> +       { 280000, 0x06 },
>>>>> +       { 320000, 0x07 },
>>>>> +       { 360000, 0x08 },
>>>>> +       { 400000, 0x09 },
>>>>> +       { 600000, 0x0a },
>>>>> +       { 800000, 0x0b },
>>>>> +       { 1000000, 0x0c },
>>>>> +       { 1200000, 0x0d },
>>>>> +       { 1400000, 0x0e },
>>>>> +       { 1600000, 0x0f },
>>>>
>>>> Huh?!
>>>
>>> Please give comments that actually mean something other wise I will opt to ignore them.
>>
>> I did below.
>
> Sort of.  "So what?" and "Huh" are not really a technical comments.

True.

> I can tell from your LVEE presentation that
> you have a passion for making the kernel better.  That is awesome but if we try to make the code perfect everytime no code will
> ever get merged.

True.

>  And we are human and we will miss coding issues and make mistakes.

True.

While all above is true, I still don't get why we have lookup tables
whenever we can use simple calculations.

>>>> strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;
>>>
>>> Not sure what equation you are trying to point out here.  But if you are trying to apply
>>> a timeout step you cannot do this with this part.  As pointed out in the DT doc the timeout
>>> step is not linear.
>>
>> Yeah, I know people are more than often too lazy to think.
>
> Well this is why I put the table in.  It is not laziness on my part as I try to add clarity for
> our newbies or productization engineers, translation/lookup tables are not as bad as you think.

Sometimes.

> I am fully aware that this bloats the data section of the image and has negative impacts
> on IoT small memory foot print devices.
>
>>
>> if (x < 9)
>>  strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;
>> else
>>  strobe_timeout = (400 + (x - 9) * 200) * MSECS_IN_SEC;
>>
>
> Not sure if this will produce the register value I am looking for.  I have to run through the
> algorithim.  The idea is to take in the timeout and get the reg value to program.
>
> If it yields the expected output, or with a modified equation, then I can pull it in.

So, you need a reversed calculus in this case.

u8 regval;

/* To make it in range... */
timeout = clamp_val(timeout, 40000, 1600000);
/* ...other possibility to issue an error */

if (timeout >= 400000)
 regval = timeout / 200000 + 0x07;
else
 regval = timeout / 40000 - 0x01;

In any case, please double check it gives a correct values.

>>>>> +               brightness_val = (brightness/2);

> I am still not see the extra spaces here.

Exactly, spaces are missed.

>> What do you mean? We do not appreciate +LOCs for no (or even nagative!) benefit.

> Again for non-IoT cases this would be fine but if we are striving to meet IoT size
> requirements I do understand your concern.

It has nothing with IoT in this case. The pattern

ret = foo();
if (ret)
  return ret;

return 0;

is a too way verbose variant of

ret foo();

though I can imagine some rare cases where it might make sense.

OTOH the variant

ret = foo();
return ret;

pointless at all.

>>>>> +               ret = of_property_read_string(led->led_node, "label", &name);
>>>> device_property_...();

>> Jacek, if you need rationale behind this comment it's here: the driver
>> has nothing DT specific and getting rid of OF centric programming
>> allows to reuse the driver on non-DT platforms w/o touching a source
>> code.

> I am deferring this to Jacek.  Because this should be an overall coding change for all LED
> drivers that are new.
>  Like I pointed out I don't mind adding/changing the code as long as
> all LED drivers will have that same mandate moving forward.

Whenever we might get driver working on different platforms for free,
better to do it that way. The entire exersice about unified device
properties API is to give drivers an agnostic way for getting their
resources / properties.

> If the maintainers agree we can get this driver to be the example for the use of device_property calls.

That's fair.
I dunno why Sakari made as3645a not in this way in the first place.
Will talk to him.

>>>>> +                       snprintf(led->led_name, sizeof(led->led_name),
>>>>> +                               "%s:%s", led->led_node->name, name);
>>>>> +               else
>>>>> +                       snprintf(led->led_name, sizeof(led->led_name),
>>>>> +                               "%s:torch", led->led_node->name);
>>>>
>>>> const char *tmp;
>>>>
>>>> ret = device_property_read_...(&tmp);
>>>> if (ret)
>>>>  tmp = ...
>>>> sprintf(...);
>>
>> No comments on this?
>
> No.  This would depend on the disposition of the device_property calls.
> If we go that way then yes this will probably change.  But we need to have an
> if..else as the label property is option in the DT documentation and we have to
> make a label if one does not exist.

The example is not related to device_property_ vs of_property_.
The idea is to figure out the label and use it in one place.

Though, I have no preferences of it.

-- 
With Best Regards,
Andy Shevchenko
