Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965331AbeEIP6U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:58:20 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40158 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965055AbeEIP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:58:18 -0400
X-Google-Smtp-Source: AB8JxZrW8l81kGDJuzAmgNPZ3OLgkQXYz9O2aFS9UeciXQ6Tk3Yy/9xEZKIxCDn/FODNA0ILZgZqT6PckGnXCRB5SXo=
MIME-Version: 1.0
References: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com> <1525859941-23654-2-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1525859941-23654-2-git-send-email-akshu.agrawal@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Wed, 09 May 2018 15:58:06 +0000
Message-ID: <CAGS+omCB=b-PDos0uWY6k1nWpMkjSQ3TpSMAe8WSdrXByAG2Uw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] clk: x86: Add ST oscout platform clock
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: Alexander.Deucher@amd.com, Mike Turquette <mturquette@baylibre.com>,
        sboyd@kernel.org, christian.koenig@amd.com,
        Dave Airlie <airlied@redhat.com>, Shaoyun.Liu@amd.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 4:01 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:

> Stoney SoC provides oscout clock. This clock can support 25Mhz and
> 48Mhz of frequency.
> The clock is available for general system use.

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>


> ---
> v2: config change, added SPDX tag and used clk_hw_register_.
> v3: Fix kbuild warning for checking of NULL pointer
> v4: unregister clk_hw in driver remove, add .suppress_bind_attrs
> v5: Fix license, used static array
>   drivers/clk/x86/Makefile             |  3 +-
>   drivers/clk/x86/clk-st.c             | 77
++++++++++++++++++++++++++++++++++++
>   include/linux/platform_data/clk-st.h | 17 ++++++++
>   3 files changed, 96 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/clk/x86/clk-st.c
>   create mode 100644 include/linux/platform_data/clk-st.h

> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
> index 1367afb..00303bc 100644
> --- a/drivers/clk/x86/Makefile
> +++ b/drivers/clk/x86/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_PMC_ATOM)         += clk-pmc-atom.o
> +obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)  += clk-st.o
>   clk-x86-lpss-objs              := clk-lpt.o
>   obj-$(CONFIG_X86_INTEL_LPSS)   += clk-x86-lpss.o
> -obj-$(CONFIG_PMC_ATOM)         += clk-pmc-atom.o
> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
> new file mode 100644
> index 0000000..fb62f39
> --- /dev/null
> +++ b/drivers/clk/x86/clk-st.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * clock framework for AMD Stoney based clocks
> + *
> + * Copyright 2018 Advanced Micro Devices, Inc.
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
> +static const char * const clk_oscout1_parents[] = { "clk48MHz",
"clk25MHz" };
> +static struct clk_hw *hws[ST_MAX_CLKS];
> +
> +static int st_clk_probe(struct platform_device *pdev)
> +{
> +       struct st_clk_data *st_data;
> +
> +       st_data = dev_get_platdata(&pdev->dev);
> +       if (!st_data || !st_data->base)
> +               return -EINVAL;
> +
> +       hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
NULL, 0,
> +                                                    48000000);
> +       hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
NULL, 0,
> +                                                    25000000);
> +
> +       hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
> +               clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
> +               0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0,
NULL);
> +
> +       clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
> +
> +       hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
"oscout1_mux",
> +               0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
> +               CLK_GATE_SET_TO_DISABLE, NULL);
> +
> +       clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
> +
> +       return 0;
> +}
> +
> +static int st_clk_remove(struct platform_device *pdev)
> +{
> +       int i;
> +
> +       for (i = 0; i < ST_MAX_CLKS; i++)
> +               clk_hw_unregister(hws[i]);
> +       return 0;
> +}
> +
> +static struct platform_driver st_clk_driver = {
> +       .driver = {
> +               .name = "clk-st",
> +               .suppress_bind_attrs = true,
> +       },
> +       .probe = st_clk_probe,
> +       .remove = st_clk_remove,
> +};
> +builtin_platform_driver(st_clk_driver);
> diff --git a/include/linux/platform_data/clk-st.h
b/include/linux/platform_data/clk-st.h
> new file mode 100644
> index 0000000..7cdb6a4
> --- /dev/null
> +++ b/include/linux/platform_data/clk-st.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * clock framework for AMD Stoney based clock
> + *
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef __CLK_ST_H
> +#define __CLK_ST_H
> +
> +#include <linux/compiler.h>
> +
> +struct st_clk_data {
> +       void __iomem *base;
> +};
> +
> +#endif /* __CLK_ST_H */
> --
> 1.9.1
