Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeETK50 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 06:57:26 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40780 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeETK5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 06:57:23 -0400
X-Google-Smtp-Source: AB8JxZqcNxd87QmultfpsaXq98yADptN9Ic7xL+mypG5D1psnaK2YiYS+I+H8bVmB6hqbQL2SO+OTqVzPQ3ulvZ0OCw=
MIME-Version: 1.0
In-Reply-To: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
References: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 20 May 2018 12:57:01 +0200
Message-ID: <CAFBinCADQsXoc6CUKabH6VX3ZBYb5apo-xBbe1w0BiO8wBAsPw@mail.gmail.com>
Subject: Re: [reset-control] How to initialize hardware state with the shared
 reset line?
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 10, 2018 at 11:16 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
[snip]
> I may be missing something, but
> one solution might be reset hogging on the
> reset provider side.  This allows us to describe
> the initial state of reset lines in the reset controller.
>
> The idea for "reset-hog" is similar to:
>  - "gpio-hog" defined in
>    Documentation/devicetree/bindings/gpio/gpio.txt
>  - "assigned-clocks" defined in
>    Documetation/devicetree/bindings/clock/clock-bindings.txt
>
>
>
> For example,
>
>    reset-controller {
>             ....
>
>             line_a {
>                   reset-hog;
>                   resets = <1>;
>                   reset-assert;
>             };
>    }
>
>
> When the reset controller is registered,
> the reset ID '1' is asserted.
>
>
> So, all reset consumers that share the reset line '1'
> will start from the asserted state
> (i.e. defined state machine state).
I wonder if a "reset hog" can be board specific:
- GPIO hogs are definitely board specific (meson-gxbb-odroidc2.dts for
example uses it to take the USB hub out of reset)
- assigned-clock-parents (and the like) can also be board specific (I
made up a use-case since I don't know of any actual examples: board A
uses an external XTAL while board B uses some other internal
clock-source because it doesn't have an external XTAL)

however, can reset lines be board specific? or in other words: do we
need to describe them in device-tree?
we could extend struct reset_controller_dev (= reset controller
driver) if they are not board specific:
- either assert all reset lines by default except if they are listed
in a new field (may break backwards compatibility, requires testing of
all reset controller drivers)
- specify a list of reset lines and their desired state (or to keep it
easy: specify a list of reset lines that should be asserted)
(I must admit that this is basically your idea but the definition is
moved from device-tree to the reset controller driver)

any "chip" specific differences could be expressed by using a
different of_device_id

one the other hand: your "reset hog" solution looks fine to me if
reset lines can be board specific

> From the discussion with Martin Blumenstingl
> (https://lkml.org/lkml/2018/4/28/115),
> the problem for Amlogic is that
> the reset line is "de-asserted" by default.
> If so, the 'reset-hog' would fix the problem,
> and DWC3 driver would be able to use
> shared, level reset, I think.
I think you are right: if we could control the initial state then we
should be able to use level resets


Regards
Martin
