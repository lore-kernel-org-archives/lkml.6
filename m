Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F32C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864DD206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="cRlFDh94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfBWHzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 02:55:11 -0500
Received: from 7of9.schinagl.nl ([62.251.20.244]:37098 "EHLO 7of9.schinagl.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbfBWHzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 02:55:11 -0500
Received: from [10.2.10.179] (unknown [10.2.10.179])
        by 7of9.schinagl.nl (Postfix) with ESMTPA id E63D9B4EFF7;
        Sat, 23 Feb 2019 08:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1550908506; bh=fTvPyVgW9O9vlu3A+EhIWigHjkUscvOJgEbcxfOakdI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cRlFDh94FD+80jJicLpidXF5m2qNi8IYR+VohaDMeflGqR7dqKjF/YKh7cfdsa/y5
         pw1ROEDn+yqFLtJoC8bV03l6miecvMZInpO/Z4Vc48c+rqDlblcqgl0CzymLCvT65m
         pC9UW8S3Laj4m5EUuBgMBHk9t/5YJcLEcxk27/Cs=
Subject: Re: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS
 defines
To:     Mark Brown <broonie@kernel.org>, Axel Lin <axel.lin@ingics.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190220165013.12774-1-axel.lin@ingics.com>
 <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
 <CAFRkauAPGEBxj7k2GvmFwhyc7ZuofhXou17b75F3G-mUWVaf9A@mail.gmail.com>
 <20190221094237.GA5970@sirena.org.uk>
From:   Olliver Schinagl <oliver@schinagl.nl>
Message-ID: <d52c2711-71f3-9e72-f01b-e761f4a92a07@schinagl.nl>
Date:   Sat, 23 Feb 2019 08:55:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190221094237.GA5970@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-2019 10:42, Mark Brown wrote:
> On Thu, Feb 21, 2019 at 08:22:53AM +0800, Axel Lin wrote:
>> Olliver Schinagl <oliver@schinagl.nl> 於 2019年2月21日 週四 上午6:57寫道：
>>> On February 20, 2019 5:50:13 PM GMT+01:00, Axel Lin <axel.lin@ingics.com> wrote:
>>>> The AXP20X_xxx_START/END/STEPS defines make the code hard to read and
>>>> very hard to check the linear range settings because it needs to check
>>>> the defines one-by-one.
>>>> The original code without the defines is very good in readability
>>>> as the meaning of each field of REGULATOR_LINEAR_RANGE is clear.
>>>> So I suggest to get rid of AXP20X_xxx_START/END/STEPS defines.
>>> Are you suggesting that magic values and hex numbers are more readable?
>> For example:
>> static const struct regulator_linear_range axp803_dcdc234_ranges[] = {
>>        REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
>>        REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x4b, 20000),
>> };
>> Above looks very clear to me as it describes the linear ranges:
>> 1st linear range: min_uV is 500000, from selector 0 ~ 0x46, the uV_step is 10000
>> 2nd linear range: min_uV is 1220000, from selector 0x47 ~ 0x4b, the
>> uV_step is 20000
>> And it's easy to check the min_sel and max_sel in each linear range.
> Frankly I tend to agree with Axel here - the defines are used in exactly
> one place so their main impact is that you can't read the ranges
> directly in the array but have to jump around to read through the
> defines.

The number of times the defines are used, are of course no reason for it
to be a bad thing. Defines should certainly not be thought of as a tool
to only reduce duplicity of course. Also being consistent where others
do have multiple invocations makes sense.

I will not disagree that it may be extra work to look up the define
(especially if there is no tool tip or split view in the editor) but
reading the whole lot of code, with only the magic values, you still
have to look up the meaning of each magic value, have to guess which one
has the same meaning etc.

Further more, I do believe far more people reading will find an define
to be more descriptive to read. Whoever needs to actually go in and
fix/change things.

Also, how many steps are in the first or second regulator ranges? which
bits are these exactly? Etc etc, you still have to use your mind to
figure things out.

Finally, while some people live and breath hexadecimals and bitmasks,
others just see magic values. So having something readable there, may
make it harder for the one that needs to work on it (which hopefully is
almost never, as these things are not very dynamic/commonly changing)
but passers by see readable text and understand what is happening at a
glance. Which is why we where taught not to use magic values in the
first place :)

