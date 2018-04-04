Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeDDIcY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:32:24 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:21451 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeDDIcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:32:22 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WiucxqETr1IQ==
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] drivers: gpio: pca953x: add compatibility for pcal6524 and pcal9555a
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAHp75VdWYDvZ0tS-MXB+MeEAF+v1ry31ka7oKAn12-Ov=ZPcXw@mail.gmail.com>
Date: Wed, 4 Apr 2018 10:32:03 +0200
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Courbot <gnurou@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>, kernel@pyra-handheld.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>
Message-Id: <AB9C05B2-D5F1-4CBA-8247-41F211CD778C@goldelico.com>
References: <49f6922ba342cf69bfd2a787d0c2a93b4df2c429.1520664883.git.hns@goldelico.com> <CACRpkdYfk7P0+Ysy43HboBe0Z66vO3COXRgUGaZ7Y9sSDh+yxA@mail.gmail.com> <EA5887ED-9C02-4FFF-AC29-14F7D4F0B32D@goldelico.com> <281D9C45-537A-4804-A9FA-6816E0FCAD27@goldelico.com> <CAHp75VdWYDvZ0tS-MXB+MeEAF+v1ry31ka7oKAn12-Ov=ZPcXw@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w348WVqr031667

Hi,

> Am 30.03.2018 um 23:39 schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> 
> On Thu, Mar 29, 2018 at 10:29 PM, H. Nikolaus Schaller
> <hns@goldelico.com> wrote:
> 
>> Another issue I have fixed is that the pcal6524 has 4 registers per
>> bank while the pcal9555a has only 2.
> 
> So, you mean it's still in non-working case in Linus' tree?

Only the pcal6524 has this problem (pcal9555a should be fine).
IMHO, it does not matter since nobody is currently using it by in-tree DTS.

> Please, send patches!

Will come for review today.

> 
>> This is encoded in the address
>> constants for the new "L"-registers and has to be taken care of in
>> pca953x_read_regs_24() and pca953x_write_regs_24().
>> 
>> But I still have another problem:
>> 
>> [    4.808823] pca953x 4-0022: irq 186: unsupported type 8
>> [    4.814303] genirq: Setting trigger mode 8 for irq 186 failed (pca953x_irq_set_type+0x0/0xa8)
>> 
>> This comes from https://elixir.bootlin.com/linux/v4.16-rc7/source/sound/soc/codecs/ts3a227e.c#L314
>> 
>> It appears that the pca953x driver/interrupt-controller can't handle
>> IRQF_TRIGGER_LOW, but that is hard coded into the ts3a227 driver.
>> 
>> Anyone with knowledge and help about this issue?
> 
> This is easy to fix (not read datasheet for better solution though):
> emulate it via FALLING (LOW) and RISING (HIGH).

I have tested it by some ugly but simple hack (will include the patch),
but we have to consider:

* the request of LEVEL_LOW vs. EDGE_FALLING is defined in the driver of the attached device
  i.e. changing it there might break a lot of systems where the interrupt-controller can handle
  LEVEL_LOW properly
* I could not find any code that allows to overwrite it by DT (by the second parameter of interrupts = <number type>)
* EDGE_FALLING as a replacement of LEVEL_LOW may loose interrupts if multiple interrupts are
  present and the connected chip does not provide a pulse for each one
* I am not sure if the tca/pca hardware can really handle LEVEL interrupts - so it might need some
  emulation (repeat the irq while the input is still active after the handler did run)

Anyways, the pcal6524 basically works in interrupt mode and code can always be improved.

There is another thing I came across: the pcal6524 has a built-in pull-up/down option
which seems to be enabled by default, which might make trouble if there are external
pull-downs in the circuits. This is different to the pin-compatible tca6424.

So I am tempted to turn off this pull-up/down by probe code to stay compatible.
The right thing would be to define some pinctrl but that is beyond my capabilities
and capacity for this chip.

BR and thanks,
Nikolaus
