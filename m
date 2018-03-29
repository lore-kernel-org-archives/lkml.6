Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeC2TaQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:30:16 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:22382 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC2TaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:30:13 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN1FDyY
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] drivers: gpio: pca953x: add compatibility for pcal6524 and pcal9555a
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <EA5887ED-9C02-4FFF-AC29-14F7D4F0B32D@goldelico.com>
Date: Thu, 29 Mar 2018 21:29:51 +0200
Cc: Mark Rutland <mark.rutland@arm.com>,
        Alexandre Courbot <gnurou@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>, kernel@pyra-handheld.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>
Message-Id: <281D9C45-537A-4804-A9FA-6816E0FCAD27@goldelico.com>
References: <49f6922ba342cf69bfd2a787d0c2a93b4df2c429.1520664883.git.hns@goldelico.com> <CACRpkdYfk7P0+Ysy43HboBe0Z66vO3COXRgUGaZ7Y9sSDh+yxA@mail.gmail.com> <EA5887ED-9C02-4FFF-AC29-14F7D4F0B32D@goldelico.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2TJUJaT011849

Hi,

> Am 28.03.2018 um 18:50 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> Hi Linus,
> 
>> Am 27.03.2018 um 15:02 schrieb Linus Walleij <linus.walleij@linaro.org>:
>> 
>> On Sat, Mar 10, 2018 at 12:00 PM, H. Nikolaus Schaller
>> <hns@goldelico.com> wrote:
>> 
>>> The Pyra-Handheld originally used the tca6424 but recently we have
>>> replaced it by the pin and package compatible pcal6524. So let's
>>> add this to the bindings and the driver.
>>> 
>>> And while we are at it, the pcal9555a does not have a compatible entry
>>> either but is already supported by the device id table.
>>> 
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> 
>> Patch applied with Rob's review tag.
> 
> Thanks!
> 
>> 
>> If there are any further concerns from the discussion with Andy,
>> please follow up with additional patches if need be, thanks!
> 
> Yes, there will be something.
> 
> But before submitting, I want to try to get interrupt handling tested.
> 
> First of all I have found the board which I can use for testing.
> It has a ts3a227 as interrupt source connected to input 14 of the
> pcal6524 (instead of tca6424) which has the interrupt output
> connected to the gpio6_161 of an OMAP5.
> 
> To see what happens I have added some printk to
> 
> 	drivers/gpio/gpio-pca953x.c
> 	kernel/irq/manage.c
> 	sound/soc/codecs/ts3a227e.c
> 
> The result is a little puzzling. I see both drivers call
> request_threaded_irq() with flags = IRQF_ONESHOT | IRQF_SHARED
> and | IRQF_TRIGGER_LOW for the pcal. It seems as if the flags
> from DT are ignored here.
> 
> Then strange things happen. The ts3a227e.c handler is called
> permanently. Even before interrupts are enabled in the chip,
> although I don't see any pca953x interrupt to occur. And
> so far I could neither see pca953x_irq_mask() pca953x_irq_unmask()
> nor pca953x_irq_bus_sync_unlock() pca953x_irq_bus_sync_lock()
> being called.

I have solved this issue.

I had assumed that it is sufficient to refer to the pcal6524 phandle
as interrupt-parent.

But it turns out that the chip has to be marked in the DT
as an interrupt-controller.

The result without this seems to have been that the omap-gpio irq
was delivered to the ts3a227 driver which is not able to remove the
irq at the gpio.

> 
> So I'd suspect that something is wrong with setting up the
> chained interrupts and the thread is not sleeping. Maybe a bug
> in my DT but I don't know yet.
> 
> Here is a shortened version of the relevant DT setup which may
> be wrong:
> 
>> 
>> 	/* system-led and other controls */
>> 	gpio99: tca6424@22 {
>> 		compatible = "nxp,pcal6524";
>> 		interrupt-parent = <&gpio6>;
>> 		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;	/* gpio6_161 */
>> 		vcc-supply = <&vdds_1v8_main>;

		interrupt-controller;
		#interrupt-cells = <2>;

>> 
>> 		reg = <0x22>;
>> 		gpio-controller;
>> 		#gpio-cells = <2>;
>> 		gpio-line-names =
>> 			"hdmi-ct-hpd", "hdmi.ls-oe", "p02", "p03", "vibra", "fault2", "p06", "p07",
>> 			"en-usb", "en-host1", "en-host2", "chg-int", "p14", "p15", "mic-int", "en-modem",
>> 			"shdn-hs-amp", "chg-status+red", "green", "blue", "en-esata", "fault1", "p26", "p27";
>> 	};
>> };
> 
> And what could make the ts3a227e handler being called without interrupt.

Now this seems to work, the ts3a227e interrupt flooding has stopped
and pca953x_irq_bus_sync_unlock() is called as expected.

I think I'll include a patch for the pca953x bindings documentation
to better point this out, maybe with example.

Another issue I have fixed is that the pcal6524 has 4 registers per
bank while the pcal9555a has only 2. This is encoded in the address
constants for the new "L"-registers and has to be taken care of in
pca953x_read_regs_24() and pca953x_write_regs_24().

But I still have another problem:

[    4.808823] pca953x 4-0022: irq 186: unsupported type 8
[    4.814303] genirq: Setting trigger mode 8 for irq 186 failed (pca953x_irq_set_type+0x0/0xa8)

This comes from https://elixir.bootlin.com/linux/v4.16-rc7/source/sound/soc/codecs/ts3a227e.c#L314

It appears that the pca953x driver/interrupt-controller can't handle
IRQF_TRIGGER_LOW, but that is hard coded into the ts3a227 driver.

Anyone with knowledge and help about this issue?

BR and thanks,
Nikolaus
