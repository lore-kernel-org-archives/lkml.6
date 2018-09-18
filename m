Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1E4ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A396121471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A396121471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeIRODv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:03:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:21852 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbeIRODu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:03:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 01:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="233841417"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 18 Sep 2018 01:31:58 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 18 Sep 2018 11:31:57 +0300
Date:   Tue, 18 Sep 2018 11:31:57 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        casey.g.bowman@intel.com,
        "Atwood, Matthew S" <matthew.s.atwood@intel.com>
Subject: Re: pinctrl-icelake: driver writes to wrong offsets?
Message-ID: <20180918083157.GC14465@lahna.fi.intel.com>
References: <CACK8Z6ECjwWqDnaXKrmEbEXzmiX41Sbzys=FSCqMwh8eYLPH9A@mail.gmail.com>
 <20180917081249.GM14465@lahna.fi.intel.com>
 <CACK8Z6EpPCCGWRZX_FEewyoySLjBUUKDPzKZof4LvvKatU_NLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6EpPCCGWRZX_FEewyoySLjBUUKDPzKZof4LvvKatU_NLg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 11:16:41AM -0700, Rajat Jain wrote:
> On Mon, Sep 17, 2018 at 1:13 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Fri, Sep 14, 2018 at 05:18:34PM -0700, Rajat Jain wrote:
> > > This is to report what I think is a problem in the pinctrl-icelake
> > > driver. It seems that when trying to control GPIO pins GPP_A* and
> > > GPIO_B*, the driver ends up writing to incorrect PADCFG registers.
> > > I've reached this conclusion by putting debug prints in the driver,
> > > although this can be seen by the following commands too. Please let me
> > > know if something is wrong in my experiments. For example, when trying
> > > to control GPP_B8/ISH_I2C1_SCL, the driver ends up writing to
> > > GPP_A6/ESPI_RESETB registers.
> >
> > Hmm, when you add debug prints to the driver and you access GPIO 224
> > (GPP_B8/ISH_I2C1_SCL) from userspace you can see that the driver
> > actually uses PADCFG registers of GPP_A6/ESPI_RESETB? So that it is not
> > just a side-effect of how the pins are wired on your board.
> 
> Right, also I don't have to use put debug prints as it can be seen
> from the following debug files. And it is not isolated to just this
> pin. For instance, in this examples you can see that another pin 18
> (GPP_B10/I2C5_SCL) that I'm trying to write , the value actually gets
> written to the PADCFG for (GPP_A8/I2S2_SFRM) i.e. pin42. So there is
> clearly a pattern:
> 
> static const struct pinctrl_pin_desc icllp_pins[] = {
>  ...
>         /* GPP_B */
> ..
>         PINCTRL_PIN(18, "I2C5_SCL"),  <----- GPP_B10/I2C5_SCL = Pin 18
> ....
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/gpio-ranges
> GPIO ranges handled:
> 0: INT3455:00 GPIOS [184 - 191] PINS [0 - 7]
> 32: INT3455:00 GPIOS [216 - 241] PINS [8 - 33]  <---- pin 18 = gpio 226
> ....
> 
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
> "I2C5_SCL\|(I2S2_SFRM)"
> pin 18 (I2C5_SCL) mode 1 0x44000702 0x0000002a 0x00000000 [ACPI]
> pin 42 (I2S2_SFRM) mode 2 0x44000b00 0x00000040 0x00000100 [ACPI]
> localhost /sys/class/gpio #
> localhost /sys/class/gpio # echo 226 > export
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
> "I2C5_SCL\|(I2S2_SFRM)"
> pin 18 (I2C5_SCL) GPIO 0x44000102 0x0000002a 0x00000000 [ACPI]
> pin 42 (I2S2_SFRM) mode 2 0x44000b00 0x00000040 0x00000100 [ACPI]
> localhost /sys/class/gpio #
> localhost /sys/class/gpio #
> localhost /sys/class/gpio # cat gpio226/value
> 0
> localhost /sys/class/gpio # cat gpio226/direction
> in
> localhost /sys/class/gpio # echo out > gpio226/direction
> localhost /sys/class/gpio # cat gpio226/direction
> out
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
> "I2C5_SCL\|(I2S2_SFRM)"
> pin 18 (I2C5_SCL) GPIO 0x44000200 0x0000002a 0x00000000 [ACPI]
> pin 42 (I2S2_SFRM) mode 2 0x44000b00 0x00000040 0x00000100 [ACPI]
> localhost /sys/class/gpio #
> localhost /sys/class/gpio #
> localhost /sys/class/gpio # cat gpio226/value
> 0
> localhost /sys/class/gpio # echo 1 > gpio226/value
> localhost /sys/class/gpio # cat gpio226/value
> 0
> localhost /sys/class/gpio # cat
> /sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
> "I2C5_SCL\|(I2S2_SFRM)"
> pin 18 (I2C5_SCL) GPIO 0x44000200 0x0000002a 0x00000000 [ACPI]
> pin 42 (I2S2_SFRM) mode 2 0x44000b01 0x00000040 0x00000100 [ACPI]
> localhost /sys/class/gpio #
> 
> As you can see in the above example, when I export the pins and change
> the directions from "in" to "out" PADCFG get updated correctly for pin
> 18, but when writing the value, it is the PADCFG for pin 42 that gets
> updated which is incorrect.

It looks like we are missing translation (call intel_gpio_to_pin()) in
intel_gpio_set(), intel_gpio_get() and intel_gpio_get_direction(). IIRC
gpiolib handles the translation but here it seems not. Strange.

> So this looks like a driver issue to me. Please let me know if I need
> to file a bug on bugzilla for this.

I agree, definitely driver issue. Please file bugzilla about this (add
me and Andy there as well) and we'll investigate.

Thanks!
