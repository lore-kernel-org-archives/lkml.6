Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeDSNzj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:55:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52781 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbeDSNzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:55:37 -0400
X-Google-Smtp-Source: AIpwx4/ZL1KKsdcqJF9uKEnQOmFsJkF/0N1XiErdtsZR5sXUsbAgw/mKWN0IrztAnQwUv39Nn4CXXPRTisXFC5mWnlM=
MIME-Version: 1.0
In-Reply-To: <20180213111147.kr4kecqbhmcoq6w2@localhost.localdomain>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
 <20180212131717.27193-17-linus.walleij@linaro.org> <20180213111147.kr4kecqbhmcoq6w2@localhost.localdomain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 19 Apr 2018 15:55:35 +0200
Message-ID: <CACRpkdZVoYsdWy6GwnnSfaSc2_wycEse3JswqufqDoz=GFb5FQ@mail.gmail.com>
Subject: Re: [PATCH 16/21] regulator: wm8994: Pass descriptor instead of GPIO number
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        patches@opensource.cirrus.com, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 12:11 PM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

>> +static struct gpiod_lookup_table wm8994_gpiod_table = {
>> +     .dev_id = "i2c-wm8958", /* I2C device name */
>> +     .table = {
>> +             GPIO_LOOKUP("GPION", 6,
>> +                         "wlf,ldo1ena", GPIO_ACTIVE_HIGH),
>> +             GPIO_LOOKUP("GPION", 4,
>> +                         "wlf,ldo2ena", GPIO_ACTIVE_HIGH),
>> +             { },
>>       },
>>  };
>>
>> @@ -366,6 +379,7 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
>>                                           rev == gf_mods[i].rev))
>>                       break;
>>
>> +     gpiod_add_lookup_table(&wm8994_gpiod_table);
>
> Would it be nicer to add this as a new member of gf_mods and
> register it inside the loop?

There is a lot of stuff that would be nice, but currently I'm almost
breaking my back over these refactorings, so I would prefer to
take one thing per patch, cleanups can be done later. I am also
hesitant to do any unnecessary infrastructure changes as I
cannot test anything (don't have this system).

> Since eventually we will need tables
> for wm5102, wm8994, wm2200, wm8996, wm5100 and wm0010.

Just wm5102 and wm8994 this time, because only those
drivers pass an enable GPIO to the regulator core. The wm2200
for example is just managing the LDO without the use of the
regulator framework (I guess this is technically incorrect).

I am only trying to fix the regulators right now, fixing all GPIOs
in the kernel tree to use descriptors is something I might have
time to accomplish before I retire.

> Likewise here the DT bindings for these parts have no -gpio
> suffix on them so this will break the DT case.

This is solved in the GPIO OF core as mentioned before.
I will put a pointer in the commit message.

Yours,
Linus Walleij
