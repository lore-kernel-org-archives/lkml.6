Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeEEC0n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 22:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbeEEC0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 22:26:41 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Akshu Agrawal <akshu.agrawal@amd.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525336264-29243-1-git-send-email-akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>, Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1525336264-29243-1-git-send-email-akshu.agrawal@amd.com>
Message-ID: <152548720041.138124.2994178054788686137@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: x86: Add ST oscout platform clock
Date: Fri, 04 May 2018 19:26:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w452Qn5p031690

Quoting Akshu Agrawal (2018-05-03 01:30:26)
> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
> index 1367afb..2aee002 100644
> --- a/drivers/clk/x86/Makefile
> +++ b/drivers/clk/x86/Makefile
> @@ -1,3 +1,4 @@
>  clk-x86-lpss-objs              := clk-lpt.o
>  obj-$(CONFIG_X86_INTEL_LPSS)   += clk-x86-lpss.o
>  obj-$(CONFIG_PMC_ATOM)         += clk-pmc-atom.o
> +obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)  += clk-st.o

Ok. Can you sort this by kconfig? Or by file name?

> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
> new file mode 100644
> index 0000000..d8c283c
> --- /dev/null
> +++ b/drivers/clk/x86/clk-st.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
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

One point of SPDX is to avoid this boiler plate multi-line license
comments. Can you remove this and just leave the AMD copyright part?

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
> +#define ST_CLK_48M     0
> +#define ST_CLK_25M     1
> +#define ST_CLK_MUX     2
> +#define ST_CLK_GATE    3
> +#define ST_MAX_CLKS    4
> +
> +static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
> +
> +static int st_clk_probe(struct platform_device *pdev)
> +{
> +       struct st_clk_data *st_data;
> +       struct clk_hw **hws;
> +
> +       st_data = dev_get_platdata(&pdev->dev);
> +       if (!st_data || !st_data->base)
> +               return -EINVAL;
> +
> +       hws = kzalloc(sizeof(*hws) * ST_MAX_CLKS, GFP_KERNEL);

Fix the kbuild robot errors please.

> +
> +       hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
> +                                                    48000000);
> +       hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz", NULL, 0,
> +                                                    25000000);

I'm not sure why we even keep these pointers around though. The driver
doesn't expose them as clks that clk_get() can find so they could just
be local variables and no heap allocation is needed.

> +
> +       hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
> +               clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
> +               0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
> +
> +       clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
> +
> +       hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
> +               0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
> +               CLK_GATE_SET_TO_DISABLE, NULL);
> +
> +       clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);

Could use devm_*() here in case you want to drop this stuff on driver
removal?

> +
> +       return 0;
> +}
> +
> +static struct platform_driver st_clk_driver = {
> +       .driver = {
> +               .name = "clk-st",
> +       },
> +       .probe = st_clk_probe,

suppress attributes here to prevent unbinding from sysfs?

> +};
> +builtin_platform_driver(st_clk_driver);
