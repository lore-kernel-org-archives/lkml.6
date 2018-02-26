Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeBZRh1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:37:27 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44630 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751186AbeBZRhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:37:25 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Subject: Re: [PATCH v8 3/9] mfd: madera: Add common support for Cirrus Logic
 Madera codecs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <patches@opensource.cirrus.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180226130558.7634-1-rf@opensource.cirrus.com>
 <20180226130558.7634-4-rf@opensource.cirrus.com>
 <CAHp75VdQtLKfSR5fhxxGJfa0j8h-vKT3YLDRTt0Khxe1UKzknw@mail.gmail.com>
 <c59653aa-c55a-52ea-98f6-292f70f97b25@opensource.cirrus.com>
 <CAHp75Vea8dbDrpYg3sJ+maQT+V+pBA2RyGSpLc+=m1WYWC1+FQ@mail.gmail.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <f9cd5c10-acdb-4ab1-9aa6-64f567cee99b@opensource.cirrus.com>
Date: Mon, 26 Feb 2018 17:37:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75Vea8dbDrpYg3sJ+maQT+V+pBA2RyGSpLc+=m1WYWC1+FQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802260228
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/18 17:19, Andy Shevchenko wrote:
> On Mon, Feb 26, 2018 at 7:06 PM, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>> On 26/02/18 14:11, Andy Shevchenko wrote:
>>> On Mon, Feb 26, 2018 at 3:05 PM, Richard Fitzgerald
>>> <rf@opensource.cirrus.com> wrote:
> 
>>>> +static void madera_enable_hard_reset(struct madera *madera)
>>>> +{
>>>> +       if (madera->reset_gpio)
>>>
>>>
>>> if (!...)
>>>    return
>>>
>>
>> Could do but why bother? For such a trivial function, in my opinion
>>
>> static void madera_enable_hard_reset(struct madera *madera)
>> {
>>          if (madera->reset_gpio)
>>                  gpiod_set_value_cansleep(madera->reset_gpio, 0);
>> }
>>
>> is simpler and more readable than
>>
>> static void madera_enable_hard_reset(struct madera *madera)
>> {
>>          if (!madera->reset_gpio)
>>                  return;
>>
>>          gpiod_set_value_cansleep(madera->reset_gpio, 0);
>> }
> 
> The rationale is that if someone wants to add more code you will not
> need to take care of deeper indentation and potentially split lines.
> 

Yes, true. It's probably unlikely here and I'm inclined to leave it
as it is because Lee already acked it.


>>
>>>> +               gpiod_set_value_cansleep(madera->reset_gpio, 0);
>>>> +}
>>>> +
>>>> +static void madera_disable_hard_reset(struct madera *madera)
>>>> +{
>>>> +       if (madera->reset_gpio) {
>>>
>>>
>>> Ditto.
>>>
>>
>> As above, yes it would work the other way but I think for such a simple
>> implementation the way I have written it is more readable.
> 
> I have different opinion, but yes. It's more matter of taste with
> rationale above (perhaps never happen to this code).
> 
>>>> +               gpiod_set_value_cansleep(madera->reset_gpio, 1);
>>>> +               usleep_range(1000, 2000);
>>>> +       }
>>>> +}
> 
>>>> +const struct of_device_id madera_of_match[] = {
>>>> +       { .compatible = "cirrus,cs47l35", .data = (void *)CS47L35 },
>>>> +       { .compatible = "cirrus,cs47l85", .data = (void *)CS47L85 },
>>>> +       { .compatible = "cirrus,cs47l90", .data = (void *)CS47L90 },
>>>> +       { .compatible = "cirrus,cs47l91", .data = (void *)CS47L91 },
>>>> +       { .compatible = "cirrus,wm1840", .data = (void *)WM1840 },
>>>
>>>
>>>> +       {},
>>>
>>>
>>> No comma.
>>>
>>
>> Seems to be personal preference. Both ways are used in the kernel and
>> we've always used this style so I'll leave it to Lee to decide.
> 
> This is not.
> The rationale is pretty obvious, terminator must terminate. With cheap
> price (no comma), we just prevent some potential weird cases (bad
> patch application for example, or not very careful contributor) where
> entry goes after. Compiler will fail.
> 

Yes, ok. I see a lot of people don't do that (I searched). But if I
do a new version of this patch I'll change it.

>>
>>>> +};
> 
>>>> +               ret = devm_gpio_request_one(madera->dev,
>>>> +                                           madera->pdata.reset,
>>>> +                                           GPIOF_DIR_OUT |
>>>> GPIOF_INIT_LOW,
>>>> +                                           "madera reset");
>>>> +               if (!ret)
>>>> +                       madera->reset_gpio =
>>>> gpio_to_desc(madera->pdata.reset);
>>>
>>>
>>> Why? What's wrong with descriptors?
> 
>> This is what I mean by code going stale when it's acked but then never
>> gets merged. Some time ago there was a reason (which I forget).
> 
> So, can we switch to descriptors?
> 

Yes, however as this patch has been in review for nearly 1 year now, and
acked for several months, I'd really hoped we could get it merged now
and update it later.

>>>> +       dev_set_drvdata(madera->dev, madera);
>>>> +       if (dev_get_platdata(madera->dev))
>>>
>>>
>>> What this dance for?
>>>
>>
>> Are you perhaps thinking the second line is dev_get_drvdata()?
>> dev_get_platdata() gets a pointer to any pdata, so not related
>> to dev_set_drvdata().
> 
> Indeed.
> 
>>>> +       ret = mfd_add_devices(madera->dev, PLATFORM_DEVID_NONE,
>>>> +                             mfd_devs, n_devs,
>>>> +                             NULL, 0, NULL);
>>>
>>>
>>> devm_?
>>>
>>
>> I can try it and see. It's scary because we can depend on our
>> children but maybe devm_mfd_add_devices() is safe.
> 
> It will fail in the same way. It does nothing more, than keeping a
> pointer to release function and its data.
> 
>>>> +struct madera_irqchip_pdata;
>>>> +struct madera_codec_pdata;
> 
>>> Why do you need platform data in new code?
> 
>> Answered in a comment in another patch. We care about allowing people
>> to use our chips with systems that don't use devicetree/acpi. There
>> are also many out-of-tree systems.
> 
> a) we don't care about out of tree much;

You might not, but as a commercial company we have to.

> b) there are other means to provide date w/o using platform data:
>   - unified device property API (including built-in device properties)
>   - bunch of lookup tables GPIO, regulator, PWM, etc
>   - fwnode graph for more complex cases with device dependencies
> 

Basically same answer as (a)
