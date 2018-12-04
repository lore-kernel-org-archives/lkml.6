Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD37C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A3C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A3C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbeLDKRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:17:40 -0500
Received: from ms.tdt.de ([195.243.126.94]:45837 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbeLDKRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:17:40 -0500
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 62FD721920;
        Tue,  4 Dec 2018 10:17:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 Dec 2018 11:17:37 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] gpio: Add driver for PC Engines APU boards
In-Reply-To: <CAHp75Vc0-t=nBGPbYjbaJDoPEg77xKLVDuhUtFQ6imgnkNuz-g@mail.gmail.com>
References: <20181127132508.5501-1-fe@dev.tdt.de>
 <20181127132508.5501-2-fe@dev.tdt.de>
 <CAHp75Vc0-t=nBGPbYjbaJDoPEg77xKLVDuhUtFQ6imgnkNuz-g@mail.gmail.com>
Message-ID: <9102ea20a4f7fec9021ea4e11570865a@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> /*
>  * Multi-line comments
>  * have this style
>  */

fixed


>> +#include <linux/kernel.h>
> 
> kbuild bot complains for absence of
> 
> #include <linux/mod_devicetable.h>
> 
> here.
> 

fixed

>> +static int gpio_apu_get_dir(struct gpio_chip *chip, unsigned int 
>> offset)
>> +{
>> +       u32 val;
>> +       struct apu_gpio_pdata *apu_gpio = gpiochip_get_data(chip);
>> +
>> +       spin_lock(&apu_gpio->lock);
>> +
> 
>> +       val = ~ioread32(apu_gpio->addr[offset]);
> 
> There is no need to do ~ under spin lock.
> 

fixed

>> +
>> +       spin_unlock(&apu_gpio->lock);
>> +
>> +       return !!(val & BIT(APU_GPIO_BIT_DIR));
>> +}
> 
>> +       if (dmi_check_system(apu3_gpio_dmi_table)) {
> 
> (1)
> 
>> +               apu_gpio->addr = devm_kzalloc(&pdev->dev,
>> +                               sizeof(apu3_gpio_offset),
>> +                               GFP_KERNEL);
> 
>> +
> 
> No need to have this blank line. Same for the other cases.
> 

fixed

>> +               if (!apu_gpio->addr)
>> +                       return -ENOMEM;
> 
>> +       } else if (dmi_check_system(apu2_gpio_dmi_table)) {
> 
> (2)
> 
> I think I have already told about (1) and (2). You may create two
> callbacks and utilize .callback member in DMI table.
> 

Done but I do not seen any advantage. I used the following driver as 
basis.
https://github.com/torvalds/linux/blob/master/drivers/leds/leds-clevo-mail.c

>> +       }
> 
>> +static int __init apu_gpio_init(void)
>> +{
> 
>> +       if (!(dmi_check_system(apu2_gpio_dmi_table)) &&
>> +               !(dmi_check_system(apu3_gpio_dmi_table))) {
>> +               pr_err("No PC Engines board detected\n");
>> +               return -ENODEV;
>> +       }
> 
> I don't think we need this.
> 

see below


>> +}
>> +
>> +module_init(apu_gpio_init);
>> +module_exit(apu_gpio_exit);

> 
> After removing unneeded checks why not to simple use
> module_platform_driver()
> ?

I have fixed all the above hints from you now but using 
"module_platform_driver" is no option.
I played around with them but the driver does not find any device. So I 
need the init function
to add a platform device. Only if I do this way driver and device will 
find and match. And I
see the gpios under /sys/class/gpio. So I think I need this?
I have not find any driver who has the same problems
I used the following drivers as my basis:
https://github.com/torvalds/linux/blob/master/drivers/leds/leds-apu.c
https://github.com/torvalds/linux/blob/master/drivers/leds/leds-clevo-mail.c
They all use dmi and need init/exit for platform device register and 
unregister



