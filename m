Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030231AbeBNMsc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:48:32 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36194 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030215AbeBNMs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:48:29 -0500
X-Google-Smtp-Source: AH8x227lTy4Kb1K9klgxRs1SkCDWzlrkBU2ne3ftGVrhQMpf3h/zBCOfVB/v1i0Yr9qjODxTxhUDG6s/+1Rhc7qm0X8=
MIME-Version: 1.0
In-Reply-To: <1518515162-23663-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org> <1518515162-23663-4-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2018 13:48:27 +0100
X-Google-Sender-Auth: aKPso2zcEcApTbmpBJz7N4Z0Nyo
Message-ID: <CAMuHMdU-pYNwjrXSR7j2kNkJSYsKd=0Kf0Tzq5LHpwA7p4_9MA@mail.gmail.com>
Subject: Re: [PATCH 03/15] soc: renesas: Add R-Car M3-N support
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thanks for your patch!

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add support for R-Car M3-N (r8a77965) power areas and reset.
> M3-N power areas are identical to M3-W ones, so just copy and rename
> them.

They are not identical:
  - M3-N does not have the CA53-related areas,
  - M3-W does not have A3VP,
  - M3-N does not have A2VC0 (M3-W also doesn't, according to latest
datasheet?).

The datasheet also mentions A3SH, without further info about the register
block. I think we need to bring this up with Renesas.

>  .../bindings/power/renesas,rcar-sysc.txt           |  1 +
>  .../devicetree/bindings/reset/renesas,rst.txt      |  1 +
>  drivers/soc/renesas/Kconfig                        |  9 ++++--
>  drivers/soc/renesas/Makefile                       |  1 +
>  drivers/soc/renesas/r8a77965-sysc.c                | 37 ++++++++++++++++++++++
>  drivers/soc/renesas/rcar-rst.c                     |  1 +
>  drivers/soc/renesas/rcar-sysc.c                    |  3 ++
>  drivers/soc/renesas/rcar-sysc.h                    |  1 +
>  drivers/soc/renesas/renesas-soc.c                  |  8 +++++
>  include/dt-bindings/power/r8a77965-sysc.h          | 31 ++++++++++++++++++
>  10 files changed, 91 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/soc/renesas/r8a77965-sysc.c
>  create mode 100644 include/dt-bindings/power/r8a77965-sysc.h

The maintainer may ask you to split this patch by functionality...

> --- /dev/null
> +++ b/drivers/soc/renesas/r8a77965-sysc.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas R-Car M3-N System Controller
> + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> + *
> + * Based on Renesas R-Car M3-W System Controller
> + * Copyright (C) 2016 Glider bvba
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/kernel.h>
> +
> +#include <dt-bindings/power/r8a77965-sysc.h>
> +
> +#include "rcar-sysc.h"
> +
> +static const struct rcar_sysc_area r8a77965_areas[] __initconst = {
> +       { "always-on",      0, 0, R8A77965_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
> +       { "ca57-scu",   0x1c0, 0, R8A77965_PD_CA57_SCU, R8A77965_PD_ALWAYS_ON,
> +         PD_SCU },
> +       { "ca57-cpu0",   0x80, 0, R8A77965_PD_CA57_CPU0, R8A77965_PD_CA57_SCU,
> +         PD_CPU_NOCR },
> +       { "ca57-cpu1",   0x80, 1, R8A77965_PD_CA57_CPU1, R8A77965_PD_CA57_SCU,
> +         PD_CPU_NOCR },
> +       { "cr7",        0x240, 0, R8A77965_PD_CR7,      R8A77965_PD_ALWAYS_ON },
> +       { "a3vc",       0x380, 0, R8A77965_PD_A3VC,     R8A77965_PD_ALWAYS_ON },
> +       { "a2vc0",      0x3c0, 0, R8A77965_PD_A2VC0,    R8A77965_PD_A3VC },

M3-N (and M3-W) does not have A2VC0?

> +       { "a2vc1",      0x3c0, 1, R8A77965_PD_A2VC1,    R8A77965_PD_A3VC },
> +       { "3dg-a",      0x100, 0, R8A77965_PD_3DG_A,    R8A77965_PD_ALWAYS_ON },
> +       { "3dg-b",      0x100, 1, R8A77965_PD_3DG_B,    R8A77965_PD_3DG_A },
> +       { "a3ir",       0x180, 0, R8A77965_PD_A3IR,     R8A77965_PD_ALWAYS_ON },

A3VP is missing?

> +};
> +
> +const struct rcar_sysc_info r8a77965_sysc_info __initconst = {
> +       .areas = r8a77965_areas,
> +       .num_areas = ARRAY_SIZE(r8a77965_areas),
> +};

> --- /dev/null
> +++ b/include/dt-bindings/power/r8a77965-sysc.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> + * Copyright (C) 2016 Glider bvba
> + */
> +
> +#ifndef __DT_BINDINGS_POWER_R8A77965_SYSC_H__
> +#define __DT_BINDINGS_POWER_R8A77965_SYSC_H__
> +
> +/*
> + * These power domain indices match the numbers of the interrupt bits
> + * representing the power areas in the various Interrupt Registers
> + * (e.g. SYSCISR, Interrupt Status Register)
> + */
> +
> +#define R8A77965_PD_CA57_CPU0           0
> +#define R8A77965_PD_CA57_CPU1           1
> +#define R8A77965_PD_A3VP                9
> +#define R8A77965_PD_CA57_SCU           12
> +#define R8A77965_PD_CR7                        13
> +#define R8A77965_PD_A3VC               14
> +#define R8A77965_PD_3DG_A              17
> +#define R8A77965_PD_3DG_B              18
> +#define R8A77965_PD_A3IR               24
> +#define R8A77965_PD_A2VC0              25

M3-N (and M3-W) does not have A2VC0?

> +#define R8A77965_PD_A2VC1              26
> +
> +/* Always-on power area */
> +#define R8A77965_PD_ALWAYS_ON          32
> +
> +#endif /* __DT_BINDINGS_POWER_R8A77965_SYSC_H__ */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
