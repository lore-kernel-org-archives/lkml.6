Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932118AbeFEXLH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:11:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36062 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeFEXKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:10:55 -0400
X-Google-Smtp-Source: ADUXVKKJW9EgJCcN7iqUI8vKY0ZbaMXH3+XpX01Jq4Ek+0nM9cFSu//1fVSgu6EuHftjt1JnpwpQcA==
Subject: Re: [PATCH v3 06/10] mfd: da9063: Add custom regmap for DA9063L
To: Steve Twiss <stwiss.opensource@diasemi.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-6-marek.vasut+renesas@gmail.com>
 <CAMuHMdV-o0_G76vR0i9nTnSowpzP3Wrt2rC7jVnoFSR3SdObYA@mail.gmail.com>
 <9acdc0af-4be9-91cb-ffed-25133bba73c3@gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941AD701@SW-EX-MBX02.diasemi.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <ab8fa587-a33a-5906-9403-ff5e23e09ff0@gmail.com>
Date: Wed, 6 Jun 2018 01:02:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB701941AD701@SW-EX-MBX02.diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 10:17 PM, Steve Twiss wrote:
> Hi Marek and Geert,
> 
> On 04 June 2018 17:25 Marek Vasut wrote,
> 
>> Subject: Re: [PATCH v3 06/10] mfd: da9063: Add custom regmap for DA9063L
>>
>> On 06/04/2018 09:39 AM, Geert Uytterhoeven wrote:
>>> Hi Marek, Steve,
>>>
>>> On Sat, Jun 2, 2018 at 12:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> While the datasheet for DA9063L (2v1, 23-Mar-2017) lists the RTC register
>>>> block, the DA9063L does not have an RTC. Add custom regmap for DA9063L to
>>>> prevent access into that register block.
> 
> Ok. I've said previously in [v3 07/10], but I'll copy again:
> There is now an internal Dialog request to remove the RTC references from the DA9063L datasheet.
> Adding that first part to the sentence in the commit log: "While the datasheet for DA9063L
> (2v1, 23-Mar-2017) lists the RTC register block" -- it exists in error for the register map table
> on page 91, but the datasheet also identifies those registers in Table 102 on page 126 as
> "Reserved".
> 
> Pointing out the ambiguity in this version of the datasheet seems redundant in the commit log.
> Also Dialog do not store a history of Datasheets on their website so once this is updated (although
> this update is not in my hands) the datasheet will be replaced. So, it seems this comment could
> make the commit message just as misleading as the current datasheet.
> 
> How about something simpler?
> "The DA9063L does not have an RTC. Add custom regmap for DA9063L to prevent access
> into that register block."
> 
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/drivers/mfd/da9063-i2c.c
>>>> +++ b/drivers/mfd/da9063-i2c.c
>>>> @@ -254,6 +341,10 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
>>>
>>> Note that the line above doesn't check da9063->type, but da9063-
>>> variant_code...
>>>
>>>>                 da9063_regmap_config.rd_table = &da9063_ad_readable_table;
>>>>                 da9063_regmap_config.wr_table = &da9063_ad_writeable_table;
>>>>                 da9063_regmap_config.volatile_table = &da9063_ad_volatile_table;
>>>> +       } else if (da9063->type == PMIC_TYPE_DA9063L) {
>>>
>>> ... so this may be slightly confusing.
>>
>> I know.
>>
>>>> +               da9063_regmap_config.rd_table = &da9063l_bb_readable_table;
>>>> +               da9063_regmap_config.wr_table = &da9063l_bb_writeable_table;
>>>> +               da9063_regmap_config.volatile_table = &da9063l_bb_volatile_table;
>>>>         } else {
>>>>                 da9063_regmap_config.rd_table = &da9063_bb_readable_table;
>>>>                 da9063_regmap_config.wr_table = &da9063_bb_writeable_table;
>>>
>>> However, da9063->variant_code doesn't seem to have been filled in at this
>>> point yet (the call to da9063_device_init() doing so is below, at the end
>>> of the probe function!), so commit 9cb42e2a8ed06e91 ("mfd: da9063: Add
>>> support for AD silicon variant") never actually handled the AD silicon variant
>>> correctly? Or am I missing something?
> 
> Okay ... No. You're not missing anything. I had noticed that.
> The AD chip model is not referenced and by default only the BB chip model is used.
> 
>> Ha, that is a good point.
> 
> Yeah, it's a good point, but it's not an amusing point.
> The device tree only distinguishes a "dlg,da9063", there is no AD type in the DT schema.
> There is no datasheet listing AD registers supported by Dialog, only BB.
> 
> But, AD registers were added back into the header file in commit 9cb42e2a8ed06e91
> and the RTC driver was updated to distinguish between the AD and BB according to
> the type of variant detected at run-time during the da9063_device_init() call.
> 
> The real problem is that this leads to two competing chip detection methods for the
> DA9063. The function da9063_device_init() autodetects the chip variant, but
> autodetection cannot define the chip model. It's circular: the chip model cannot be
> autodetected because a chip model is needed to access the register used during
> autodetection.
> 
> Which leads me back to what I said two paragraphs up:
>> The device tree only distinguishes a "dlg,da9063", there is no AD type in the DT schema.
>> There is no datasheet listing AD registers supported by Dialog, only BB.
> 
> This is not how it is done in the DA9062 and DA9061 driver: the variant code is only
> used to print the information to the console during start-up and it is the DT that defines
> the chip model based upon "dlg,da9062" or "dlg,da9061".

So the AD was broken since forever and noone noticed ? :)

Do you have an AD hardware and can you fix it ?

-- 
Best regards,
Marek Vasut
