Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeFDR5U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:57:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55699 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeFDR5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:57:04 -0400
X-Google-Smtp-Source: ADUXVKJ5xAZeaNG5fYYM2cW6+fmpeO/svzxOyB6F2IEKgGvx/lEzOF9F/kGOQKdiHXnFplron55apg==
Subject: Re: [PATCH v3 06/10] mfd: da9063: Add custom regmap for DA9063L
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-6-marek.vasut+renesas@gmail.com>
 <CAMuHMdV-o0_G76vR0i9nTnSowpzP3Wrt2rC7jVnoFSR3SdObYA@mail.gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <9acdc0af-4be9-91cb-ffed-25133bba73c3@gmail.com>
Date: Mon, 4 Jun 2018 18:25:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV-o0_G76vR0i9nTnSowpzP3Wrt2rC7jVnoFSR3SdObYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 09:39 AM, Geert Uytterhoeven wrote:
> Hi Marek, Steve,
> 
> On Sat, Jun 2, 2018 at 12:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> While the datasheet for DA9063L (2v1, 23-Mar-2017) lists the RTC register
>> block, the DA9063L does not have an RTC. Add custom regmap for DA9063L to
>> prevent access into that register block.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/mfd/da9063-i2c.c
>> +++ b/drivers/mfd/da9063-i2c.c
>> @@ -254,6 +341,10 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
> 
> Note that the line above doesn't check da9063->type, but da9063->variant_code...
> 
>>                 da9063_regmap_config.rd_table = &da9063_ad_readable_table;
>>                 da9063_regmap_config.wr_table = &da9063_ad_writeable_table;
>>                 da9063_regmap_config.volatile_table = &da9063_ad_volatile_table;
>> +       } else if (da9063->type == PMIC_TYPE_DA9063L) {
> 
> ... so this may be slightly confusing.

I know.

>> +               da9063_regmap_config.rd_table = &da9063l_bb_readable_table;
>> +               da9063_regmap_config.wr_table = &da9063l_bb_writeable_table;
>> +               da9063_regmap_config.volatile_table = &da9063l_bb_volatile_table;
>>         } else {
>>                 da9063_regmap_config.rd_table = &da9063_bb_readable_table;
>>                 da9063_regmap_config.wr_table = &da9063_bb_writeable_table;
> 
> However, da9063->variant_code doesn't seem to have been filled in at this
> point yet (the call to da9063_device_init() doing so is below, at the end
> of the probe function!), so commit 9cb42e2a8ed06e91 ("mfd: da9063: Add
> support for AD silicon variant") never actually handled the AD silicon variant
> correctly? Or am I missing something?

Ha, that is a good point.

-- 
Best regards,
Marek Vasut
