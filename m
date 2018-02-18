Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeBRQgf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 11:36:35 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:35058 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeBRQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 11:36:34 -0500
Date: Sun, 18 Feb 2018 17:32:11 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tim@krieglstein.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i2c-designware: sound and s2ram broken on Broadwell-U system
 since commit ca382f5b38f367b6 (add i2c gpio recovery option)
Message-ID: <20180218163211.GA1650@light.dominikbrodowski.net>
References: <20180217132543.GA21571@light.dominikbrodowski.net>
 <1518879773.22495.378.camel@linux.intel.com>
 <1518880180.22495.379.camel@linux.intel.com>
 <20180217165815.GA1854@light.dominikbrodowski.net>
 <1518901021.22495.383.camel@linux.intel.com>
 <20180218094135.GA2459@light.dominikbrodowski.net>
 <CAHp75Vf2sS8c4GubL1MRkrGdpYdn0n5stmzZNnp8axNn3AkEcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf2sS8c4GubL1MRkrGdpYdn0n5stmzZNnp8axNn3AkEcw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 04:23:41PM +0200, Andy Shevchenko wrote:
> On Sun, Feb 18, 2018 at 11:41 AM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > On Sat, Feb 17, 2018 at 10:57:01PM +0200, Andy Shevchenko wrote:
> >> On Sat, 2018-02-17 at 17:58 +0100, Dominik Brodowski wrote:
> 
> >> >  Do you still need the DEBUG_GPIO output?
> >>
> >> It would be nice to have, though if it makes difficulties to you, then
> >> don't bother.
> >
> > Note that I have to enable CONFIG_GPIOLIB before I can enable DEBUG_GPIO;
> > CONFIG_PINCTRL was off as well. Maybe some "SELECT" is missing for
> > CONFIG_I2C_DESIGNWARE_BAYTRAIL ?
> 
> Ah, so, your configuration misses pin control driver. You need to
> enable it in order to get GPIOs working.

Well, I did not need it in the past to have working sound and working
suspend to RAM. And it already works if 

	CONFIG_PINCTRL=y
	CONFIG_DEBUG_PINCTRL=y

	CONFIG_GPIOLIB=y
	CONFIG_GPIO_ACPI=y
	CONFIG_DEBUG_GPIO=y

are set (but no PINCTRL or GPIO drivers!).

So I'd suggest to

(a) keep your fixup patch (as things work as previously then),

(b) to have CONFIG_I2C_DESIGNWARE_BAYTRAIL select the appropriate options from
    above [and CONFIG_XPOWER_PMIC_OPREGION ?] (or depend on it?), or

(c) (probably best) both.


> It might fix your issue w/o my patch.
> 
> > The following output is with your patch applied.
> 
> ...which is useless.
> 
> > Do you need it without
> > your fixup patch as well?
> 
> Yes, and with enabled pin control driver.

Well, I've reverted your fixup patch locally and enabled all drivers that I
could -- including CONFIG_XPOWER_PMIC_OPREGION, CONFIG_MFD_AXP20X, and
CONFIG_MFD_AXP20X_I2C. But I'm not sure at all that a driver actually became
active...

$ dmesg | egrep -i "(gpio|pinctrl|i2c|broadw)"
[    0.031029] Performance Events: PEBS fmt2+, Broadwell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.079300] pinctrl core: initialized pinctrl subsystem
[    0.105267] gpio-f7188x: Not a Fintek device at 0x0000002e
[    0.105285] gpio-f7188x: Not a Fintek device at 0x0000004e
[    0.621048] i2c_designware INT3432:00: GPIO lookup for consumer scl
[    0.621053] i2c_designware INT3432:00: using ACPI for GPIO lookup
[    0.621057] acpi INT3432:00: GPIO: looking up scl-gpios
[    0.621062] acpi INT3432:00: GPIO: looking up scl-gpio
[    0.621065] i2c_designware INT3432:00: using lookup tables for GPIO lookup
[    0.621087] i2c_designware INT3432:00: lookup for GPIO scl failed
[    0.682478] i2c_designware INT3433:00: GPIO lookup for consumer scl
[    0.682482] i2c_designware INT3433:00: using ACPI for GPIO lookup
[    0.682486] acpi INT3433:00: GPIO: looking up scl-gpios
[    0.682490] acpi INT3433:00: GPIO: looking up scl-gpio
[    0.682493] i2c_designware INT3433:00: using lookup tables for GPIO lookup
[    0.682497] i2c_designware INT3433:00: lookup for GPIO scl failed
[    1.208551] gpio_it87: Unknown Chip found, Chip 1d00 Revision 0
[    1.870861] input: DLL0665:01 06CB:76AD Touchpad as /devices/pci0000:00/INT3433:00/i2c-1/i2c-DLL0665:01/0018:06CB:76AD.0001/input/input9
[    1.871601] hid-multitouch 0018:06CB:76AD.0001: input: I2C HID v1.00 Mouse [DLL0665:01 06CB:76AD] on i2c-DLL0665:01
[    2.015224] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mapping ok
[    2.015433] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapping ok
[    2.015642] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapping ok
[    2.015839] broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapping ok
[    2.017899] broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mapping ok
[    2.025473] input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwell-audio/sound/card1/input15

Thanks,
	Dominik
