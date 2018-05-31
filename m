Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbeEaJLv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:11:51 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38781 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754147AbeEaJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:11:46 -0400
X-Google-Smtp-Source: ADUXVKJ2RI2PGHvJ4/5vG72n7+pTz/mFJ7aCYYBcqTOBg+3BMzA0fS1YXOJafmS0f2Nq0zS/vkGlyD6cZwzbB3BwRAA=
MIME-Version: 1.0
References: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com>
 <1527154169-32380-2-git-send-email-michel.pollet@bp.renesas.com> <CAMuHMdVzN0Cbc9+MJqC4EzVgD3bkDixkf10NA13ko87cMwvpLA@mail.gmail.com>
In-Reply-To: <CAMuHMdVzN0Cbc9+MJqC4EzVgD3bkDixkf10NA13ko87cMwvpLA@mail.gmail.com>
From: M P <buserror@gmail.com>
Date: Thu, 31 May 2018 10:11:34 +0100
Message-ID: <CAMMfpEwpiZnZEykzxQJMTwE+cDnOD_qA3nUzyB96DGTWPzSJrw@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] dt-bindings: Add the r9a06g032-sysctrl.h file
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: michel.pollet@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>, buserror+upstream@gmail.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, geert+renesas@glider.be,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4V9D2Cj029463

On Fri, 25 May 2018 at 11:31, Geert Uytterhoeven <geert@linux-m68k.org>
wrote:

> Hi Michel,

Hi Geert,


> On Thu, May 24, 2018 at 11:28 AM, Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
> > This adds the constants necessary to use the renesas,r9a06g032-sysctrl
node.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

> Thanks for your patch!

> > --- /dev/null
> > +++ b/include/dt-bindings/clock/r9a06g032-sysctrl.h

> You can still call this file r9a06g032-clocks.h, if you want, as it
> contains clock definitions only.

Well, having renamed the node, I thought it made sense to keep the naming
consistent. Any further #define could be added to here instead of having to
add another file...


> > @@ -0,0 +1,187 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * R9A06G032 sysctrl IDs
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Europe Limited
> > + *
> > + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
> > + * Derived from zx-reboot.c
> > + */
> > +
> > +#ifndef __DT_BINDINGS_R9A06G032_SYSCTRL_H__
> > +#define __DT_BINDINGS_R9A06G032_SYSCTRL_H__
> > +
> > +#define R9A06G032_CLKOUT                       0
> > +#define R9A06G032_CLK_PLL_USB                  1
> > +#define R9A06G032_CLK_48                       1 /* AKA CLK_PLL_USB */
> > +#define R9A06G032_CLKOUT_D10                   2
> > +#define R9A06G032_CLKOUT_D16                   3
> > +#define R9A06G032_MSEBIS_CLK                   3 /* AKA CLKOUT_D16 */
> > +#define R9A06G032_MSEBIM_CLK                   3 /* AKA CLKOUT_D16 */
> > +#define R9A06G032_CLKOUT_D160                  4
> > +#define R9A06G032_CLKOUT_D1OR2                 5
> > +#define R9A06G032_CLK_DDRPHY_PLLCLK            5 /* AKA CLKOUT_D1OR2 */

> [...]

> I have 3 comments:

>    1. I had expected this list to match (both name- and order-wise)
Appendix
>       C ("Clock Tree Structure") in the RZ/N1[DSL] User’s Manual: System
>       Introduction, Multiplexing, Electrical and Mechanical Information.
>       That would make it easier to review.

Well, that document was made a *long* time after the internal documentation
we used to generate the clock lists. There are a few things we had to do:

* Renumber peripherals. We decided a long time ago that u-boot and linux
would stick to zero based peripherals, and not one based numbers. It's next
to impossible to keep mixing number based across software base, so we use
UART0 while the hardware manual mentions UART1 -- It *is* documented
extensively with out SDK, and makes life using linux a lot easier. It's
across all our SDK, u-boot, webapps readmes, howtos etc.

* Rename some peripherals. Plenty of peripherals names made little sense
and had zero consistency, in fact, many names were different depending on
the place they were used! -- "flashnand"+"nand_flash"+"FNAND" etc,
"QUADSPI"+"QSPI" etc etc so we also re-normalized the names to match linux
conventions.

* Other internal reasons I can't document here

Also, the value here are made up anyway -- so I've decided to sort them to
make sure any clock that has a parent is numbered *after* the parent...

>    2. These definitions seems to be a mix of:
>         1. Internal core clocks,
>         2. Other core clocks,
>         3. Module clocks.

>       The internal clocks do not need to be referenced from DT, so I would
>       not make them part of the DT bindings.

Why? I'm told that "Bindings aren't for linux" -- why can't I imagine
'something' needing them? Why would I decide NOT to include them,
as they are there? I 'factored' a few of them to the same number when
applicable.

This is all done automatically BTW -- a script takes the original clocking
spreadsheet, and converts it into a table, correcting 'human input' as it
goes along.

>    3. It looks like the module clocks can be referred to by register offset
>       and bit position, which is similar to how this is handled on R-Car
>       SoCs.
>       Perhaps you can just drop the definitions for these from the header
>       file, and refer to them by (combined) register offset and bit
position
>       instead?
>       Or am I missing something?
>       I believe this can also be done for the module resets (later).

If you look in the .c file, you'll see that most gate have not just one
register/bit pair associated with them -- there are several, spread
across registers.. Also, there are clocks in there with two gates,
or none. Given that, I've decided a separate numbering
made sense.
As mentioned, it's arbitrary, with 'root' clocks numbered lowered than
sub-clocks.

Thank you!

Michel
