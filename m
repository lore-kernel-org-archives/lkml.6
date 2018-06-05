Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeFEJhr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:37:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39473 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeFEJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:37:46 -0400
Message-ID: <1528191453.4074.4.camel@pengutronix.de>
Subject: Re: [reset-control] How to initialize hardware state with the
 shared reset line?
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Date: Tue, 05 Jun 2018 11:37:33 +0200
In-Reply-To: <CAK7LNAQ56ND=6=7swD3ioKwNsGJCxN1SibkH==n24xPX6SdBBQ@mail.gmail.com>
References: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
         <CAFBinCADQsXoc6CUKabH6VX3ZBYb5apo-xBbe1w0BiO8wBAsPw@mail.gmail.com>
         <CAK7LNAR1b_F_eLEWAdQc3L=daGz=ttKq0mQP78BkjzTOssaXvw@mail.gmail.com>
         <CAFBinCBTTmPqD0UP8zzMBjsjzP9fJx9_pmhGz0_Vy-V+wmhLXQ@mail.gmail.com>
         <1526997879.3671.27.camel@pengutronix.de>
         <CAFBinCBAoRebScz+DTSKSgiU5DjeSHS1F3=2vt8KM-yCv+2A8g@mail.gmail.com>
         <CAK7LNAQ56ND=6=7swD3ioKwNsGJCxN1SibkH==n24xPX6SdBBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Wed, 2018-05-30 at 14:57 +0900, Masahiro Yamada wrote:
> One more thing.
> 
> I want to remove reset_control_reset() entirely.

reset_control_reset is for those cases where "the reset controller
knows" how to reset us. There are hardware reset controllers that can
control a bunch of actual reset signals in the right order and with the
right timings necessary for the connected IP cores by triggering a
single bit.
In that case it wouldn't make much sense to do assert / delay / deassert
in the driver, as the information about the delay is contained in the
reset controller hardware.

> [1] Some reset consumers (e.g. drivers/ata/sata_gemini.c)
>     use reset_control_reset() to reset the HW.
> 
> [2] Some reset consumers (e.g. drivers/input/keyboard/tegra-kbc.c)
>     use the combination of reset_control_assert() and reset_control_deassert()
>     to reset the HW.
> 
> [1] is the only way if the reset controller only supports the pulse reset.
> 
> [2] is the only way if the reset controller only supports the level reset.
> 
> So, this is another strangeness because
> the implementation of reset controller
> affects reset consumers.
> 
> We do not need [1].
> 
> [2] is more flexible than [1] because hardware usually specifies
> how long the reset line should be kept asserted.

This is not always the case.

> For all reset consumers,
> replace
>   reset_control_reset();
> with
>   reset_control_assert();
>   reset_control_deassert();

To be honest, it doesn't make sense to me. If the intention in the
driver is just to reset our internal state, and we have a system reset
controller that can reset us by writing a single bit, I'd prefer to call
a reset function over two assert/deassert functions, one of which ends
up doing nothing.

How about moving in the other direction, and allowing to replace

	reset_control_assert(rstc);
	udelay(delay);
	reset_control_deassert(rstc);

and variants with calls like

	reset_control_reset_udelay(rstc, delay);

? If the reset controller knows better, or can't change the delay in
hardware, it may ignore the delay parameter.

> and deprecate reset_control_reset().
>
> I think this is the right thing to do.

I don't think this helps the API, as with that change we have to remove
a guarantee it currently makes: This either only works for shared resets
or we have to accept that reset_control_assert for exclusive resets does
not guarantee to return with the reset line asserted anymore.
Also, for drivers that do deassert in probe and assert in remove, we
would have to issue the reset in deassert and let assert be the no-op,
instead of the other way around.

> The reset controller side should be implemented like this:
> 
> If your reset controller only supports the pulse reset,
>    .deassert hook should be no-op.
>    .assert hook should pulse the reset
> 
> Then .reset hook should be removed.

There is hardware where assert, deassert, and reset are three different
operations. See for example the tegra/reset-bpmp.c driver. Both assert /
deassert and module reset messages are part of the firmware ABI.

> Or, we can keep the reset drivers as they are.
> drivers/reset/core.c can take care of the proper fallback logic.

I prefer to keep assert, deassert and reset separate for those cases
where the hardware actually supports both variants.

regards
Philipp
