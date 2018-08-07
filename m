Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70FEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5888621770
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5888621770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbeHGOBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:01:22 -0400
Received: from ms.tdt.de ([195.243.126.94]:56140 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeHGOBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:01:22 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 13CC7207F9;
        Tue,  7 Aug 2018 11:47:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 07 Aug 2018 13:47:22 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: Add driver for PC Engines APU2/APU3 GPIOs
In-Reply-To: <CAHp75VdNf8BCYEq348CQe2OUUOLdYehsr5TmBDQXXEAm59+kDg@mail.gmail.com>
References: <20180801111243.2848-1-fe@dev.tdt.de>
 <CAHp75VdNf8BCYEq348CQe2OUUOLdYehsr5TmBDQXXEAm59+kDg@mail.gmail.com>
Message-ID: <f1a1af620625c7d9c46e6df3eebc574b@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 21:08, Andy Shevchenko wrote:
>> - APU2/APU3 -> front button reset support
>> - APU3 -> SIM switch support
> 
> Good.
> Can we see some specification for those platforms?
> 

I think the informations from Christian Lamparter are OK?

<https://www.pcengines.ch/pdf/apu1.pdf>
<https://www.pcengines.ch/schema/apu1c.pdf>
<https://www.pcengines.ch/pdf/apu2.pdf>
<http://pcengines.ch/schema/apu2c.pdf>

>> + * GNU General Public License for more details
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see 
>> <http://www.gnu.org/licenses/>
> 
> SPDX, please!

I have already updated my patch in my git to use this identifier.
// SPDX-License-Identifier: GPL-2.0
This was a hint from Linus Walleji

> 
>> + */
> 
>> +#include <linux/gpio.h>
>> +#include <linux/gpio_keys.h>
> 
> These both looks very strange in here.
> 

On the front of the APU2/APU3 there is a SMD-push-button which is 
connected to
one of the GPIOs. This is used as a reset button for the system 
(reboot/factory-reset).
I am also not sure if this is the right place. But for the first review 
i thought this
will be ok.

The geode, the old board from PC-Engines
added the key gpios to this file
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform/geode/alix.c#n47
mybe this is the right place too x86/platfrom/apu/apu.c?

>> +#define APU_FCH_ACPI_MMIO_BASE 0xFED80000
>> +#define APU_FCH_GPIO_BASE      (APU_FCH_ACPI_MMIO_BASE + 0x1500)
> 
> Wow! Can we see ACPI tables for these boards? Care to share (via some
> file share service) output of `acpidump -o tables.dat` ?
> 

I have copied this from the leds-apu.c driver which is already upstream.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/leds-apu.c#n43

> 
>> +#define APU_GPIO_BIT_WRITE     22
>> +#define APU_GPIO_BIT_READ      16
>> +#define APU_GPIO_BIT_DIR       23
> 
> WR and RD looks shorter,
> And please keep them sorted by value.

Ok will fix this.

> 
>> +#define APU_IOSIZE             sizeof(u32)
> 
> This is usual for x86 stuff, no need to have a definition, I think.

Ok will fix this.

>> +static unsigned long apu3_gpio_offset[APU3_NUM_GPIO] = {
>> +       APU_FCH_GPIO_BASE + 89 * APU_IOSIZE, //KEY
>> +       APU_FCH_GPIO_BASE + 90 * APU_IOSIZE, //SIM
>> +};
>> +static void __iomem *apu3_gpio_addr[APU3_NUM_GPIO] = {NULL, NULL};
>> +
> 
>> +static int gpio_apu_get_dir (struct gpio_chip *chip, unsigned offset)
> 
> Style! We do not use space between func and its parameter list.
> 

OK

>> +{
>> +       u32 val;
>> +
>> +       spin_lock(&apu_gpio->lock);
>> +
> 
>> +       val = ~ioread32(apu_gpio->addr[offset]);
> 
> This is unusual (I mean ~). Better to leave IO alone and do bits
> manipulations latter on.

OK

> 
>> +       val = (val >> APU_GPIO_BIT_DIR) & 1;
> 
> Do you need this under spin lock?
> 

No i don´t.
Will fix this.
Thanks

>> +               apu_gpio->chip->ngpio = ARRAY_SIZE(apu2_gpio_offset);
>> +               for( i = 0; i < ARRAY_SIZE(apu2_gpio_offset); i++) {
>> +                       apu2_gpio_addr[i] = devm_ioremap(&pdev->dev,
>> +                                       apu_gpio->offset[i], 
>> apu_gpio->iosize);
>> +                       if (!apu2_gpio_addr[i]) {
>> +                               return -ENOMEM;
>> +                       }
>> +               }
>> +       }
> 
> The above should be part either as callback or driver_data of DMI 
> entries.

I have copied this from the leds-apu.c driver
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/leds-apu.c#n226

> 
>> +       ret = gpiochip_add(&gpio_apu_chip);
> 
> devm_
> 

What do you mean with "devm_"?

>> +       if (ret) {
> 
>> +               pr_err("Adding gpiochip failed\n");
> 
> dev_err(), but I consider this message completely useless.

Thanks will remove this too.

> 
>> +       }
> 
>> +
>> +       register_gpio_keys_polled(-1, 20, ARRAY_SIZE(apu_gpio_keys), 
>> apu_gpio_keys);
>> +
> 
> Not part of this driver. Remove.
> 

As described above should this go to a file "apu.c" in the directory 
"apu" under
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform
?

>> +       return ret;
>> +}
> 
>> +module_init(apu_gpio_init);
>> +module_exit(apu_gpio_exit);
> 
> Consider to use module_platform_driver() and accompanying data
> structures and functions.

Ok thanks will update this


Will update my patch with your hints thanks

