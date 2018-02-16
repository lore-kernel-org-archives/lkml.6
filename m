Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758003AbeBPOkk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:40:40 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41657 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbeBPOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:40:38 -0500
X-Google-Smtp-Source: AH8x227dRTf5qMJuvLAc0bA1yZJqOmb0a7XGpmErV5yNW6jmzzMOx7qsOl+SYdYpQYQiQDHAbbV0KRrb0BkwmwhIgMo=
MIME-Version: 1.0
In-Reply-To: <4047b1de-40c6-813e-c410-543954190413@caviumnetworks.com>
References: <20180214005536.22739-1-david.daney@cavium.com>
 <CAHp75VcQm-gr0GRszBSRJSZOpdSutRyhVkw-BN_YAwhjaPM4yg@mail.gmail.com> <4047b1de-40c6-813e-c410-543954190413@caviumnetworks.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 16:40:36 +0200
Message-ID: <CAHp75Vdp1Q2LFRToRTgf+Zr7Pdvcegqu9ObQkpFKZFhXUExnCA@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: isl12026: Add driver.
To: David Daney <ddaney@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 9:01 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 02/15/2018 04:45 AM, Andy Shevchenko wrote:
>> On Wed, Feb 14, 2018 at 2:55 AM, David Daney <david.daney@cavium.com>
>> wrote:
>>>
>>> The ISL12026 is a combination RTC and EEPROM device with I2C
>>> interface.  The standard RTC driver interface is provided.  The EEPROM
>>> is accessed via the NVMEM interface via the "eeprom0" directory in the
>>> sysfs entry for the device.

>>> +       /* 2 bytes of address, most significant first */
>>> +       addr[0] = (offset >> 8) & 0xff;
>>> +       addr[1] = offset & 0xff;
>>
>>
>> Consider to drop '& 0xff', they are pointless (you have u8 type).
>
>
> Generated code is the same, but the intent of the code is less clear when
> the explicit masking is removed.  Never the less, since this seems to be
> impeding progress, I will remove it.

You can use the following:

      addr[0] = offset >> 8;
      addr[1] = offset >> 0;

>>> +       bool set_bsw, set_sbib;
>>> +

>>> +       ret = of_property_read_u32(client->dev.of_node,
>>> +                                  "isil,pwr-bsw", &bsw_val);
>>> +       set_bsw = (ret == 0);

>> Which is not fully correct. Better to do

> I think it is correct.  The properties are optional, so it it perfectly fine
> for of_property_read_u32() to fail.  If it fails, we simply keep the current
> value.  I will add comments to document the intended logic.

OK.

>> set_bsw = of_property_present();

> There are no occurrences of "of_property_present" in my source tree.

Ah, indeed.


>> ret = of_property_read...();
>> if (ret)
>>    return ret;

What about then

set_bsw = of_property_read_bool();

set_sbid = ...


if (!x && !y)
 return ...

...

if (x) {

}

>>
>>> +
>>> +       ret = of_property_read_u32(client->dev.of_node,
>>> +                                  "isil,pwr-sbib", &sbib_val);
>>> +       set_sbib = (ret == 0);
>>
>>
>> Ditto.

>>> +               if (set_bsw) {
>>> +                       if (bsw_val)
>>> +                               requested_pwr |= ISL12026_REG_PWR_BSW;
>>> +                       else
>>> +                               requested_pwr &= ~ISL12026_REG_PWR_BSW;
>>> +               }
>>
>>
>> Undefined state if no value?

> It is defined.  See above.

It's opaque. Depends on firmware settings, boot loader, etc.

>>> +#ifdef CONFIG_OF
>> Remove this ugly #ifdef. Your driver OF only one.

> The driver doesn't require OF.

>  By removing the #if (which I will do), the
> size of the module may be bloated in the non-OF case.  If anybody cares
> about this, they can add back the #if.

Nobody.

>>> +static const struct of_device_id isl12026_dt_match[] = {
>>> +       { .compatible = "isil,isl12026" },
>>> +       { },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, isl12026_dt_match);

>>> +               .of_match_table = of_match_ptr(isl12026_dt_match),
>> Drop of_match_ptr().

> Best to keep it so that the non-OF case is correctly handled.

If you drop above ifdef, you need to drop this macro. And code bloat is not big.

Btw, driver since ->probe_new() is become OF/ACPI only, so, otherwise
there will be no way to enumerate.

-- 
With Best Regards,
Andy Shevchenko
