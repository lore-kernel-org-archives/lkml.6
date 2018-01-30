Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeA3Olw convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:41:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752909AbeA3Ols (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:41:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F0421798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x227wbeRpiTO6LNmOs/iNtANBJt2JPLn/97VLwZBGtK44OagDvH9fRzLeTg9lXLmwcHd5AInUEUyTbJMeEhcMHtM=
MIME-Version: 1.0
In-Reply-To: <1517302582.5307.16.camel@diehl.com>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-5-m.grzeschik@pengutronix.de> <20180129234146.73hvclxohhme5i2w@rob-hp-laptop>
 <1517302582.5307.16.camel@diehl.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Jan 2018 08:41:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKEXtL0hvEgFALKaCgW2Go==wj14_dDomdK_hPU23oXLQ@mail.gmail.com>
Message-ID: <CAL_JsqKEXtL0hvEgFALKaCgW2Go==wj14_dDomdK_hPU23oXLQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 2:56 AM, Denis OSTERLAND
<denis.osterland@diehl.com> wrote:
> Am Montag, den 29.01.2018, 17:41 -0600 schrieb Rob Herring:
>> On Tue, Jan 23, 2018 at 01:18:01PM +0100, Michael Grzeschik wrote:
>> >
>> > We add support for the ISL1219 chip that got an integrated tamper
>> > detection function. This patch implements the feature by using an hwmon
>> > interface.
>> >
>> > The ISL1219 can also describe the timestamp of the intrusion
>> > event. For this we add the documentation of the new interface
>> > intrusion[0-*]_timestamp.
>> >
>> > The devicetree documentation for the ISL1219 device tree
>> > binding is added with an short example.
>> >
>> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> > Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
>> > ---
>> >  .../rtc/{intersil,isl1208.txt => isil,isl1208.txt} |  18 +-
>> >  Documentation/hwmon/sysfs-interface                |   7 +
>> >  drivers/rtc/rtc-isl1208.c                          | 190 +++++++++++++++++++--
>> >  3 files changed, 201 insertions(+), 14 deletions(-)
>> >  rename Documentation/devicetree/bindings/rtc/{intersil,isl1208.txt => isil,isl1208.txt} (57%)
>> >
>> > diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt b/Documentation/devicetree/bindings/rtc/isil,isl1208.txt
>> > similarity index 57%
>> > rename from Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
>> > rename to Documentation/devicetree/bindings/rtc/isil,isl1208.txt
>> > index a54e99feae1ca..d549699e1cfc4 100644
>> > --- a/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
>> > +++ b/Documentation/devicetree/bindings/rtc/isil,isl1208.txt
>> > @@ -1,14 +1,21 @@
>> > -Intersil ISL1208, ISL1218 I2C RTC/Alarm chip
>> > +Intersil ISL1208, ISL1218, ISL1219 I2C RTC/Alarm chip
>> >
>> >  ISL1208 is a trivial I2C device (it has simple device tree bindings,
>> >  consisting of a compatible field, an address and possibly an interrupt
>> >  line).
>> >
>> > +ISL1219 supports tamper detection user space representation through
>> > +case intrusion hwmon sensor.
>> User space and hwmon are Linux details not relevant to the binding. Just
>> describe the h/w.
> OK.
>>
>> >
>> > +ISL1219 has additional pins EVIN and #EVDET for tamper detection.
>> > +I2C devices support only one irq. #IRQ and #EVDET are open-drain active low,
>> > +so it is possible layout them to one SoC pin with pull-up.
>> > +
>> >  Required properties supported by the device:
>> >
>> >   - "compatible": must be one of
>> >     "isil,isl1208"
>> >     "isil,isl1218"
>> > +   "isil,isl1219"
>> >   - "reg": I2C bus address of the device
>> >
>> >  Optional properties:
>> > @@ -33,3 +40,12 @@ Example isl1208 node with #IRQ pin connected to SoC gpio1 pin 12:
>> >             interrupt-parent = <&gpio1>;
>> >             interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
>> >     };
>> > +
>> > +Example isl1219 node with #IRQ pin and #EVDET pin connected to SoC gpio1 pin 12:
>> > +
>> > +   isl1219: isl1219@68 {
>> > +           compatible = "intersil,isl1219";
>> > +           reg = <0x68>;
>> > +           interrupts-extended = <&gpio1 12 IRQ_TYPE_EDGE_FALLING>;
>> With 2 interrupts, you should have 2 values. If they are connected
>> together, just repeat the connection. Otherwise, you can't tell if EVDET
>> is a no connect.
> If I got you right, you suggest an additional IRQ entry to parse.

Yes.

> A short example, #IRQ pin connected to gpio1 pin 12 and
> #EVDET pin connected to gpio2 pin 24:
>
> isl1219: rtc@68 {
>         compatible = "intersil,isl1219";
>         reg = <0x68>;
>         interrupt-names = "irq", "evdet";
>         interrupts-extended = <&gpio1 12 IRQ_TYPE_EDGE_FALLING>,
>                 <&gpio2 24 IRQ_TYPE_EDGE_FALLING>;
> };
>
> In driver implementation we need only one interrupt, because we can
> determinate action to take based on value of status register.

That's fine. The binding describes the hardware. Drivers can support
as much or as little as they like.

> In current implementation there was no need to do some additional
> OF parsing, everything is done by I2C generic code.
> I guess, it is not much additional work to do so, but I am not sure
> if it´s worthwhile.

If you don't care about the 2nd interrupt, I don't think you'd have to
change anything.

>>
>> There's not much point in having an example for every compatible. This
>> binding is simple enough, one should be enough.
> Shell we remove the example without an interrupt?

The existing example has a single interrupt, right? That should be
enough. You just need to document for the interrupts property which
devices have 2 interrupts and what the order is.

Rob
