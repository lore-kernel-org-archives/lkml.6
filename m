Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeEAV6H convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbeEAV6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:58:06 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Akshu Agrawal <akshu.agrawal@amd.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525072055-17898-1-git-send-email-akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1525072055-17898-1-git-send-email-akshu.agrawal@amd.com>
Message-ID: <152521188500.138124.10561048787941050422@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: x86: Add ST oscout platform clock
Date: Tue, 01 May 2018 14:58:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akshu Agrawal (2018-04-30 00:06:53)
> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
> index 1367afb..f7ebae1 100644
> --- a/drivers/clk/x86/Makefile
> +++ b/drivers/clk/x86/Makefile
> @@ -1,3 +1,4 @@
>  clk-x86-lpss-objs              := clk-lpt.o
>  obj-$(CONFIG_X86_INTEL_LPSS)   += clk-x86-lpss.o
>  obj-$(CONFIG_PMC_ATOM)         += clk-pmc-atom.o
> +obj-$(CONFIG_X86)              += clk-st.o

No desire to make a Kconfig for this driver so it isn't included all the
time on x86 devices that don't have this hardware?

> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
> new file mode 100644
> index 0000000..6ac0dc5
> --- /dev/null
> +++ b/drivers/clk/x86/clk-st.c
> @@ -0,0 +1,80 @@
> +/*
> + * clock framework for AMD Stoney based clocks
> + *
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.

Can you use the SPDX tags here?

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_data/clk-st.h>
> +#include <linux/platform_device.h>
> +
> +/* Clock Driving Strength 2 register */
> +#define CLKDRVSTR2     0x28
> +/* Clock Control 1 register */
> +#define MISCCLKCNTL1   0x40
> +/* Auxiliary clock1 enable bit */
> +#define OSCCLKENB      2
> +/* 25Mhz auxiliary output clock freq bit */
> +#define OSCOUT1CLK25MHZ        16
> +
> +static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
> +
> +static int st_clk_probe(struct platform_device *pdev)
> +{
> +       struct st_clk_data *st_data;
> +       struct clk *clk_48m;
> +       struct clk *clk_25m;
> +       struct clk *clk_oscout1_mux;
> +       struct clk *clk_oscout1;
> +
> +       st_data = dev_get_platdata(&pdev->dev);
> +       if (!st_data || !st_data->base)
> +               return -EINVAL;
> +
> +       clk_48m = clk_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
> +                                         48000000);
> +       clk_25m = clk_register_fixed_rate(NULL, "clk25MHz", NULL, 0,
> +                                         25000000);
> +
> +       clk_oscout1_mux = clk_register_mux(NULL, "oscout1_mux",
> +               clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
> +               0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
> +
> +       clk_set_parent(clk_oscout1_mux, clk_25m);
> +
> +       clk_oscout1 = clk_register_gate(NULL, "oscout1", "oscout1_mux",
> +               0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
> +               CLK_GATE_SET_TO_DISABLE, NULL);
> +
> +       clk_register_clkdev(clk_oscout1, "oscout1", NULL);

Can you use the clk_hw registration and clkdev APIs? It would mean that
clk_set_parent() call up above would still be needed but I guess that's
OK. We don't currently have a way for non-DT based drivers to configure
the parents of a clk when it's registered.

> +
> +       return 0;
> +}
> +
> diff --git a/include/linux/platform_data/clk-st.h b/include/linux/platform_data/clk-st.h
> new file mode 100644
> index 0000000..5ede980
> --- /dev/null
> +++ b/include/linux/platform_data/clk-st.h
> @@ -0,0 +1,32 @@
> +/*
> + * clock framework for AMD Stoney based clock
> + *
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef __CLK_ST_H
> +#define __CLK_ST_H
> +
> +struct st_clk_data {
> +       void __iomem *base;

Can you include compiler.h in this file for the __iomem usage?
