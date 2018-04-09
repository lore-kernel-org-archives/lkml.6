Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbeDITZB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:25:01 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33107 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeDITY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:24:58 -0400
X-Google-Smtp-Source: AIpwx48O1BqWsPcAqCTSEmBKcstT91w8y6bZPKWCcWNTQ0lc/fP+1Pj9Af4/0NlOAIh4dZ7s0kpKFg==
Date: Mon, 9 Apr 2018 14:24:56 -0500
From: Rob Herring <robh@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Add Gateworks System Controller
 bindings
Message-ID: <20180409192456.ne4zgdqozucquk42@rob-hp-laptop>
References: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
 <1522250043-8065-2-git-send-email-tharvey@gateworks.com>
 <20180328162416.GB25325@roeck-us.net>
 <CAJ+vNU2aUN4ME3+RA3DNPO75O6vPBcQpuRSfQJ4_Ns_zQAtCCQ@mail.gmail.com>
 <20180328202321.GA21664@roeck-us.net>
 <CAJ+vNU1cJFYTv3N6TZQ3k-VQw=0jxHEntpMxeSAOhWAb_ap81g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU1cJFYTv3N6TZQ3k-VQw=0jxHEntpMxeSAOhWAb_ap81g@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 01:53:53PM -0700, Tim Harvey wrote:
> On Wed, Mar 28, 2018 at 1:23 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Mar 28, 2018 at 12:17:34PM -0700, Tim Harvey wrote:
> >> On Wed, Mar 28, 2018 at 9:24 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> >> > On Wed, Mar 28, 2018 at 08:14:00AM -0700, Tim Harvey wrote:
> >> >> This patch adds documentation of device-tree bindings for the
> >> >> Gateworks System Controller (GSC).
> >> >>
> >> >> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >> >> ---
> >> >> v3:
> >> >>  - replaced _ with -
> >> >>  - remove input bindings
> >> >>  - added full description of hwmon
> >> >>  - fix unit address of hwmon child nodes
> >> >>
> >> >> ---
> >> >>  .../devicetree/bindings/mfd/gateworks-gsc.txt      | 135 +++++++++++++++++++++
> >> >>  1 file changed, 135 insertions(+)
> >> >>  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.txt
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.txt b/Documentation/devicetree/bindings/mfd/gateworks-gsc.txt
> >> >> new file mode 100644
> >> >> index 0000000..8f530ed
> >> >> --- /dev/null
> >> >> +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.txt
> >> >> @@ -0,0 +1,135 @@
> >> >> +Gateworks System Controller multi-function device
> >> >> +
> >> >> +The GSC is a Multifunction I2C slave device with the following submodules:
> >> >> +- WDT
> >> >> +- GPIO
> >> >> +- Pushbutton controller
> >> >> +- HWMON
> >> >> +
> >> >> +Required properties:
> >> >> +- compatible : Must be "gw,gsc"
> >> >> +- reg: I2C address of the device
> >> >> +- interrupts: interrupt triggered by GSC_IRQ# signal
> >> >> +- interrupt-parent: Interrupt controller GSC is connected to
> >> >> +- #interrupt-cells: should be <1>, index of the interrupt within the
> >> >> +  controller, in accordance with the "one cell" variant of
> >> >> +  <devicetree/bindings/interrupt-controller/interrupt.txt>
> >> >> +
> >> >> +Optional nodes:
> >> >> +* watchdog:
> >> >> +The GSC provides a Watchdog monitor which can power cycle the board's
> >> >> +primary power supply on most board models when tripped.
> >> >> +
> >> >> +Required watchdog properties:
> >> >> +- compatible: must be "gw,gsc-watchdog"
> >> >> +
> >> >> +* hwmon:
> >> >> +The GSC provides a set of Analog to Digitcal Converter (ADC) pins used for
> >> >> +temperature and/or voltage monitoring.
> >> >> +
> >> >> +Required hwmon properties:
> >> >> +- compatible: must be "gw,gsc-hwmon"
> >> >> +
> >> >
> >> > "hwmon" is a very Linux specific term. It might make sense to find a more
> >> > generic term.
> >>
> >> The 'hwmon' driver supports child nodes that fall into the following category:
> >>  - temperature sensor (GSC internal temperature sensor - i2c registers
> >> returns value in C*10)
> >>  - voltage rails (two types here; cooked: i2c registers return
> >> pre-scaled value in mV), raw: i2c registers return a raw ADC value
> >> that must be scaled based on ADC internal ref voltage and resolution
> >> and adjusted for a voltage divider to convert to mV
> >>  - fan setpoints (I'll explain these below)
> >>
> >> I called the node 'gw,gsc-hwmon' because the driver fits into the
> >> 'hwmon' API. Isn't that appropriate here for the driver compatible
> >> string?
> >>
> >
> > Devicetree properties are supposed to be OS independent.

+1

> >
> >> >
> >> >> +Optional hwmon properties:
> >> >> +- gw,reference-voltage: ADC reference voltage (mV) used in scaling raw ADCs
> >> >
> >> > AFAIK devicetree likes to specify voltages in uV.
> >>
> >> There are currently plenty of dt props specified in mV (grep -r mV
> >> Documentation/devicetree/bindings/).
> >>
> >
> > "But so many others are speeding, why do I get a ticket ?"
> >
> > Please discuss with Rob.
> 
> Yes - hoping for feedback on mV vs uV as well as naming of hwmon mfd child node.

Use what is defined in 
Documentation/devicetree/bindings/property-units.txt. If you don't like 
what is there, then add to it first. But generally you should have some 
reason why what's there doesn't work for you.

Rob
