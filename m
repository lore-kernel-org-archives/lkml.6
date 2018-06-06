Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX3RavgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 768846070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbeFFJuw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:50:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35174 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932371AbeFFJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:50:49 -0400
X-Google-Smtp-Source: ADUXVKJkw0nlfFSnY4uQqh1SbeVJ0b2e9ALKt7USWoDXVZNbL/TuU4QYrbJ2/ruswnxlg9DoHLZzqA==
Subject: Re: [PATCH v3 08/10] mfd: da9063: Register RTC only on DA9063L
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-8-marek.vasut+renesas@gmail.com>
 <20180605075321.GM21163@dell>
 <ac43842f-7d8a-1d6d-7077-9fb58ab852b7@gmail.com>
 <20180606061623.GT21163@dell>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <69893894-899f-54cd-2610-96653ec246c0@gmail.com>
Date: Wed, 6 Jun 2018 11:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606061623.GT21163@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 08:16 AM, Lee Jones wrote:
> On Tue, 05 Jun 2018, Marek Vasut wrote:

[...]

>>>> -static const struct mfd_cell da9063_devs[] = {
>>>> +static const struct mfd_cell da9063_common_devs[] = {
>>>>  	{
>>>>  		.name		= DA9063_DRVNAME_REGULATORS,
>>>
>>> Appreciate that these are historical, but these device name defines
>>> make me shudder.  They only serve to act as an obfuscation layer when
>>> debugging at platform level.  Please consider getting rid of them.
>>
>> The macro can be shared between the core and the drivers, so the names
>> never run out of sync.
> 
> Platform driver name changes are vary rare.  Even if they are changed,
> even light testing would uncover the fact that child drivers do not
> .probe().

Sure, while if the macro is used, this problem is avoided altogether.

> Due to the current obfuscation, I currently have no idea
> what this device's name is.

I'm sure ctags or git grep can easily help.

> This technique is not allowed for new
> drivers - unfortunately I didn't not review this driver in the first
> instance.

Why not ? This looks like a step back to me.

> It doesn't bother me enough to go and change it myself and I'm not
> going to have a baby over patches not being submitted to fix it.
> 
>>>>  		.num_resources	= ARRAY_SIZE(da9063_regulators_resources),
>>>> @@ -100,15 +100,19 @@ static const struct mfd_cell da9063_devs[] = {
>>>>  		.resources	= da9063_onkey_resources,
>>>>  		.of_compatible = "dlg,da9063-onkey",
>>>>  	},
>>>> +	{
>>>> +		.name		= DA9063_DRVNAME_VIBRATION,
>>>> +	},
>>>
>>> Place this on a single line please.
>>
>> This would only make the style inconsistent with the ie. LEDs entry.
>>
>>>         { .name	= DA9063_DRVNAME_VIBRATION },
> 
> If that is a one line entry spaced over multiple lines, then that
> should also be changed.
> 
> Maybe I will go through and stylise this driver a bit after all (but
> as time is short at the moment, maybe not!) :)

You'd end up with two entries which look different then the rest, which
triggers my OCD.

> [...]
> 
>>>> +err_mfd_cleanup:
>>>> +	mfd_remove_devices(da9063->dev);
>>>
>>> Any reason why you can't use devm_*?
>>
>> Because we need to undo the MFD setup before the IRQ setup.
> 
> Sounds like a good enough reason.

Or the da9063_irq_init() could use devm_regmap_add_irq_chip().

-- 
Best regards,
Marek Vasut
