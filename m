Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEPUoX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:44:23 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:44063 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeEPUoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:44:19 -0400
Subject: Re: [PATCH v6 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20180515154352.20263-1-dmurphy@ti.com>
 <20180515154352.20263-2-dmurphy@ti.com>
 <CAHp75VegjkiiD1qTGpi9rr6cg=72t9kSwDrG=sUpUWFVO58M4A@mail.gmail.com>
 <08dda10d-f865-9cf2-b9a5-c79cbab5da98@ti.com>
 <CAHp75Vcz08zrs3bgMFcvYwRrN_A43D=Nvt5cFDQf8m9whB=yhA@mail.gmail.com>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <3a0f27b7-86a1-235c-0a96-5ec9c8feb6f0@ti.com>
Date: Wed, 16 May 2018 15:43:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcz08zrs3bgMFcvYwRrN_A43D=Nvt5cFDQf8m9whB=yhA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy

The first response is to Jacek the rest are addressed to you

On 05/15/2018 05:24 PM, Andy Shevchenko wrote:
> On Wed, May 16, 2018 at 1:08 AM, Dan Murphy <dmurphy@ti.com> wrote:
>> On 05/15/2018 04:56 PM, Andy Shevchenko wrote:
>>> On Tue, May 15, 2018 at 6:43 PM, Dan Murphy <dmurphy@ti.com> wrote:
> 
>>>> +       depends on LEDS_CLASS && I2C && OF
>>>
>>> What is OF specific in this driver?
>>
>> as3645a_led_class_setup has a "of" dependency
> 
> So what? Is it called from this driver or?
> 

Jacek

Do you have a preference about the use of "of" calls over the device_property calls?

I know Andy is pushing this for IoT and gave a good presentation on it last year on
common mistakes.  Not sure this is a "common mistake" but more of a overall Linux compatibility issue
between x86 and ARM using two different configuration methods.

Since these lighting drivers are agnostic to the processor maybe we should adopt that philosophy.

I have no problem being the example driver on that.

> 
>>>> +static const struct lm3601x_max_timeouts strobe_timeouts[] = {
>>>> +       { 40000, 0x00 },
>>>> +       { 80000, 0x01 },
>>>> +       { 120000, 0x02 },
>>>> +       { 160000, 0x03 },
>>>> +       { 200000, 0x04 },
>>>> +       { 240000, 0x05 },
>>>> +       { 280000, 0x06 },
>>>> +       { 320000, 0x07 },
>>>> +       { 360000, 0x08 },
>>>> +       { 400000, 0x09 },
>>>> +       { 600000, 0x0a },
>>>> +       { 800000, 0x0b },
>>>> +       { 1000000, 0x0c },
>>>> +       { 1200000, 0x0d },
>>>> +       { 1400000, 0x0e },
>>>> +       { 1600000, 0x0f },
>>>
>>> Huh?!
>>
>> Please give comments that actually mean something other wise I will opt to ignore them.
> 
> I did below.

Sort of.  "So what?" and "Huh" are not really a technical comments. I can tell from your LVEE presentation that
you have a passion for making the kernel better.  That is awesome but if we try to make the code perfect everytime no code will
ever get merged.  And we are human and we will miss coding issues and make mistakes.

> 
>>> strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;
>>
>> Not sure what equation you are trying to point out here.  But if you are trying to apply
>> a timeout step you cannot do this with this part.  As pointed out in the DT doc the timeout
>> step is not linear.
> 
> Yeah, I know people are more than often too lazy to think.

Well this is why I put the table in.  It is not laziness on my part as I try to add clarity for
our newbies or productization engineers, translation/lookup tables are not as bad as you think.
I am fully aware that this bloats the data section of the image and has negative impacts
on IoT small memory foot print devices.

> 
> if (x < 9)
>  strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;
> else
>  strobe_timeout = (400 + (x - 9) * 200) * MSECS_IN_SEC;
> 

Not sure if this will produce the register value I am looking for.  I have to run through the
algorithim.  The idea is to take in the timeout and get the reg value to program.

If it yields the expected output, or with a modified equation, then I can pull it in.

>>>> +               brightness_val = (brightness/2);
>>>
>>> Spaces.
>>
>> Not sure what this means checkpatch was clean
> 
> Even besides missed whispaces it has redundant parens.
> 
> checkpatch is not a silver bullet to get your code clean and nice.
> 

True but it is the tool many maintainers use (sometimes) to ensure clean and nice.
I am still not see the extra spaces here but I do see the unneeded parens.

>>> This is return led_...();
>>
>> That is a preference.  It does not have to be that way.
> 
> What do you mean? We do not appreciate +LOCs for no (or even nagative!) benefit.
> 

Again for non-IoT cases this would be fine but if we are striving to meet IoT size
requirements I do understand your concern.

>>>> +               ret = of_property_read_string(led->led_node, "label", &name);
>>>
>>> device_property_...();
>>
>> It can be if the maintainer is requesting this.
> 
> Jacek, if you need rationale behind this comment it's here: the driver
> has nothing DT specific and getting rid of OF centric programming
> allows to reuse the driver on non-DT platforms w/o touching a source
> code.
> 

See below

>> Is the trend to move to these functions?
> 
> See above.

See below

> 
>> Most drivers use the "of" calls.
> 
> So what?
> 

I am deferring this to Jacek.  Because this should be an overall coding change for all LED
drivers that are new.  Like I pointed out I don't mind adding/changing the code as long as
all LED drivers will have that same mandate moving forward.

If the maintainers agree we can get this driver to be the example for the use of device_property calls.

> 
>>>> +               if (!ret)
>>>
>>> if (ret) sounds more natural. And better just to split

OK

>>>
>>>> +                       snprintf(led->led_name, sizeof(led->led_name),
>>>> +                               "%s:%s", led->led_node->name, name);
>>>> +               else
>>>> +                       snprintf(led->led_name, sizeof(led->led_name),
>>>> +                               "%s:torch", led->led_node->name);
>>>
>>> const char *tmp;
>>>
>>> ret = device_property_read_...(&tmp);
>>> if (ret)
>>>  tmp = ...
>>> sprintf(...);
> 
> No comments on this?

No.  This would depend on the disposition of the device_property calls.
If we go that way then yes this will probably change.  But we need to have an
if..else as the label property is option in the DT documentation and we have to
make a label if one does not exist.

> 
>>>> +       led = devm_kzalloc(&client->dev,
>>>> +                           sizeof(struct lm3601x_led), GFP_KERNEL);
>>>
>>> sizeof(*led) and one line in the result
> 
> And this?

Either one should yield the same allocation.  So I can change it.

> 
> 
>>>> +       { },
>>>
>>> Terminators better w/o comma.
>>
>> Looking at other drivers adding comma's on the sentinel is accepted.  See the as3645a driver
> 
> So what?

Not a compile issue here.  I have been asked by maintainers/reviewers to add the comma on the sentinnel not just
struct definition but also for enums.

This is a maintainer decision I defer to them for guidance.

> 
> Terminator at compile time even better.
> 
>>>> +       {},
>>>
>>> Ditto.
>>
>> See above
> 
> See above.
> 

See above


-- 
------------------
Dan Murphy
