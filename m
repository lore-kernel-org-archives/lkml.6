Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeE3M4m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:56:42 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42907 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeE3M4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:56:39 -0400
X-Google-Smtp-Source: ADUXVKLBqb6JmHuYLiaLvlDGC47JY9rwKzgkz/pcxSXfKeiOjq78Jaqqcn6TY8RFzWFi3eIhZ/XmGg==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Wed, 30 May 2018 15:56:34 +0300
To: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 0/6] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <20180530125634.GE13528@localhost.localdomain>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <20180530090512.GC13528@localhost.localdomain>
 <20180530110000.GI6920@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530110000.GI6920@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, May 30, 2018 at 12:00:00PM +0100, Mark Brown wrote:
> On Wed, May 30, 2018 at 12:05:12PM +0300, Matti Vaittinen wrote:
> 
> > Other 4 can be used on PWM or PFM switching mode. When PWM is used
> > voltages can be changed without disabling regulator. On PFM this should
> > not be done. These latter 4 regulators can be forced to PWM mode via
> > control bit in register. This driver does not support controlling this
> > mode though. So this driver version just checks if regulator is enabled
> > before changing the voltage and if it is the voltage change fails with
> > -EBUSY
> 
> It probably should support setting modes (especially if the device isn't
> smart enough to automatically shift which sounds like the case) but
> that's a separate thing.

Thanks for the guidance! The first 4 BUCKs (which support DVS) do change
the mode automatically. Latter 4 do not. I however didn't find example
on how to allow doing this mode change via regulator framework and thus
the driver is not allowing mode change. For me it would sound good to
allow setting the mode via device-tree property - and via in-kernel API
or sysfs - but as I said I didn't yet find a nice example on that. (But
I assume this device is not first one allowing mode change and thus
there should be an example and I probably should not invent own DT
properties or sysfs entries for this. Guess I just need to search harder).

> 
> > My question is whether it would be good idea to also read the 'force
> > PWM' bit when voltage is changed and allow the change if PWM mode is
> > forced to be used? Problem is that the check and voltage change can't be
> > atomic so there is a chance someone changes the mode (bypassing the
> > driver and regulator core) after this check but before we get to modify
> > the voltage. Furthermore, I doubt the 'force PWM' is widely used (but I
> > can't say for sure as I can't imagine all use cases) as it is not so
> > power efficient.
> 
> Why would anything else be changing the mode configuration of the
> regulator while the system is running?  That sounds like a bad idea.
This was also my initial thought. Still with my lack of experience on this
area (and with my experience on people inventing strange solutions) I
felt unsure.

> In any case if the hardware really needs to be manually put into force
> PWM to change voltage then the simplest thing would be to just move it
> into force PWM mode, do the change, then change back if it wasn't
> already in force PWM mode.
I see 4 options for these last 4 bucks which can't switch to PWM
automatically when voltage is changed.

1. prohibit voltage change if regulator is enabled (safest? current
   approach)
2. allow voltage change if regulator is enabled and force PWM is used
3. switch to 'force PWM' when changing voltage (as suggested by Mark)
4. disable regulator for duration of voltage change (discarded option)

So option 4 was discarded. Option 1 is the current approach. I will ask
from ROHM PMIC HW colleagues what they think of Mark's suggestion
(option 3) and implement it if HW behaves Ok. I guess option 2 is not
worth the hassle.

> 
> The tradeoff with forced PWM mode is that the quality of regulation will
> be a lot better, especially if the load changes suddenly (as things like
> CPUs often do).  Most hardware that's at all current is able respond to
> changes in load and switch modes automatically when it's appropriate,
> except possibly in some very low power modes.

Yes. The mode switching is automatic. But there is this control bit for
disabling automatic mode switching and forcing the PWM. Problem with
these 4 last bucks is just that if regulator is in PFM (and it may be
if not forced to PWM - due to this automatic switching) then the voltage
change is not behaving well.

Thanks for all the support Mark!

Br,
	Matti Vaittinen
