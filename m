Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeBIQWR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:22:17 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43567 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeBIQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:22:14 -0500
X-Google-Smtp-Source: AH8x227v/XXyhhnfRSIxQw8sXKomTm/Ecya91hEgw/CBBi48SrOKms59dkH037Q0T0fELcMwxcbZLstZIR9b0HALrZM=
MIME-Version: 1.0
In-Reply-To: <1515377863-20358-13-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com> <1515377863-20358-13-git-send-email-david@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 9 Feb 2018 17:22:13 +0100
Message-ID: <CAMRc=MfQuqTK+mDT0Gawa6J-3d1z6djLutaHREKfVm+3hATEqQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/44] clk: davinci: Add platform information for TI
 DA850 PSC
To: David Lechner <david@lechnology.com>
Cc: linux-clk@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Adam Ford <aford173@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-08 3:17 GMT+01:00 David Lechner <david@lechnology.com>:
> This adds platform-specific declarations for the PSC clocks on TI DA850/
> OMAP-L138/AM18XX SoCs.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/clk/davinci/Makefile    |   1 +
>  drivers/clk/davinci/psc-da850.c | 117 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk/davinci.h     |   1 +
>  3 files changed, 119 insertions(+)
>  create mode 100644 drivers/clk/davinci/psc-da850.c
>
> diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
> index fb14c8c..aef0390 100644
> --- a/drivers/clk/davinci/Makefile
> +++ b/drivers/clk/davinci/Makefile
> @@ -11,4 +11,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DM646x)     += pll-dm646x.o
>
>  obj-y += psc.o
>  obj-$(CONFIG_ARCH_DAVINCI_DA830)       += psc-da830.o
> +obj-$(CONFIG_ARCH_DAVINCI_DA850)       += psc-da850.o
>  endif
> diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
> new file mode 100644
> index 0000000..3b4583d
> --- /dev/null
> +++ b/drivers/clk/davinci/psc-da850.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PSC clock descriptions for TI DA850/OMAP-L138/AM18XX
> + *
> + * Copyright (C) 2017 David Lechner <david@lechnology.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/types.h>
> +
> +#include "psc.h"
> +
> +static const struct davinci_psc_clk_info da850_psc0_info[] __initconst = {
> +       LPSC(0, 0, tpcc0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
> +       LPSC(1, 0, tptc0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
> +       LPSC(2, 0, tptc1, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
> +       LPSC(3, 0, aemif, pll0_sysclk3, 0),
> +       LPSC(4, 0, spi0, pll0_sysclk2, 0),
> +       LPSC(5, 0, mmcsd0, pll0_sysclk2, 0),
> +       LPSC(6, 0, aintc, pll0_sysclk4, LPSC_ALWAYS_ENABLED),
> +       LPSC(7, 0, arm_rom, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
> +       LPSC(9, 0, uart0, pll0_sysclk2, 0),
> +       LPSC(13, 0, pruss, pll0_sysclk2, 0),
> +       LPSC(14, 0, arm, pll0_sysclk6, LPSC_ALWAYS_ENABLED),
> +       LPSC(15, 1, dsp, pll0_sysclk1, LPSC_FORCE | LPSC_LOCAL_RESET),
> +       { }
> +};
> +
> +static const struct davinci_psc_clk_info da850_psc1_info[] __initconst = {
> +       LPSC(0, 0, tpcc1, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
> +       LPSC(1, 0, usb0, pll0_sysclk2, 0),
> +       LPSC(2, 0, usb1, pll0_sysclk4, 0),
> +       LPSC(3, 0, gpio, pll0_sysclk4, 0),
> +       LPSC(5, 0, emac, pll0_sysclk4, 0),
> +       LPSC(6, 0, emif3, pll0_sysclk5, LPSC_ALWAYS_ENABLED),
> +       LPSC(7, 0, mcasp0, async3, 0),
> +       LPSC(8, 0, sata, pll0_sysclk2, LPSC_FORCE),
> +       LPSC(9, 0, vpif, pll0_sysclk2, 0),
> +       LPSC(10, 0, spi1, async3, 0),
> +       LPSC(11, 0, i2c1, pll0_sysclk4, 0),
> +       LPSC(12, 0, uart1, async3, 0),
> +       LPSC(13, 0, uart2, async3, 0),
> +       LPSC(14, 0, mcbsp0, async3, 0),
> +       LPSC(15, 0, mcbsp1, async3, 0),
> +       LPSC(16, 0, lcdc, pll0_sysclk2, 0),
> +       LPSC(17, 0, ehrpwm, async3, 0),
> +       LPSC(18, 0, mmcsd1, pll0_sysclk2, 0),
> +       LPSC(20, 0, ecap, async3, 0),
> +       LPSC(21, 0, tptc2, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
> +       { }
> +};
> +
> +void __init da850_psc_clk_init(void __iomem *psc0, void __iomem *psc1)
> +{
> +       struct clk_onecell_data *clk_data;
> +
> +       clk_data = davinci_psc_register_clocks(psc0, da850_psc0_info, 16);
> +       if (!clk_data)
> +               return;
> +
> +       clk_register_clkdev(clk_data->clks[3], NULL, "ti-aemif");
> +       clk_register_clkdev(clk_data->clks[3], "aemif", "davinci-nand.0");
> +       clk_register_clkdev(clk_data->clks[4], NULL, "spi_davinci.0");
> +       clk_register_clkdev(clk_data->clks[5], NULL, "da830-mmc.0");
> +       clk_register_clkdev(clk_data->clks[9], NULL, "serial8250.0");
> +       clk_register_clkdev(clk_data->clks[14], "arm", NULL);
> +       clk_register_clkdev(clk_data->clks[15], NULL, "davinci-rproc.0");
> +
> +       clk_free_onecell_data(clk_data);
> +
> +       clk_data = davinci_psc_register_clocks(psc1, da850_psc1_info, 32);
> +       if (!clk_data)
> +               return;
> +
> +       clk_register_clkdev(clk_data->clks[1], "usb20_psc_clk", NULL);
> +       clk_register_clkdev(clk_data->clks[1], NULL, "musb-da8xx");
> +       clk_register_clkdev(clk_data->clks[1], NULL, "cppi41-dmaengine");
> +       clk_register_clkdev(clk_data->clks[2], NULL, "ohci-da8xx");
> +       clk_register_clkdev(clk_data->clks[3], "gpio", NULL);
> +       clk_register_clkdev(clk_data->clks[5], NULL, "davinci_emac.1");
> +       clk_register_clkdev(clk_data->clks[5], "fck", "davinci_mdio.0");
> +       clk_register_clkdev(clk_data->clks[7], NULL, "davinci-mcasp.0");
> +       clk_register_clkdev(clk_data->clks[8], "fck", "ahci_da850");
> +       clk_register_clkdev(clk_data->clks[9], NULL, "vpif");
> +       clk_register_clkdev(clk_data->clks[10], NULL, "spi_davinci.1");
> +       clk_register_clkdev(clk_data->clks[11], NULL, "i2c_davinci.2");
> +       clk_register_clkdev(clk_data->clks[12], NULL, "serial8250.1");
> +       clk_register_clkdev(clk_data->clks[13], NULL, "serial8250.2");
> +       clk_register_clkdev(clk_data->clks[14], NULL, "davinci-mcbsp.0");
> +       clk_register_clkdev(clk_data->clks[15], NULL, "davinci-mcbsp.1");
> +       clk_register_clkdev(clk_data->clks[16], "fck", "da8xx_lcdc.0");
> +       clk_register_clkdev(clk_data->clks[17], "fck", "ehrpwm.0");
> +       clk_register_clkdev(clk_data->clks[17], "fck", "ehrpwm.1");
> +       clk_register_clkdev(clk_data->clks[18], NULL, "da830-mmc.1");
> +       clk_register_clkdev(clk_data->clks[20], "fck", "ecap.0");
> +       clk_register_clkdev(clk_data->clks[20], "fck", "ecap.1");
> +       clk_register_clkdev(clk_data->clks[20], "fck", "ecap.2");
> +
> +       clk_free_onecell_data(clk_data);
> +}
> +
> +#ifdef CONFIG_OF
> +static void __init of_da850_psc0_clk_init(struct device_node *node)
> +{
> +       of_davinci_psc_clk_init(node, da850_psc0_info, 16);
> +}
> +CLK_OF_DECLARE(da850_psc0_clk, "ti,da850-psc0", of_da850_psc0_clk_init);
> +
> +static void __init of_da850_psc1_clk_init(struct device_node *node)
> +{
> +       of_davinci_psc_clk_init(node, da850_psc1_info, 32);
> +}
> +CLK_OF_DECLARE(da850_psc1_clk, "ti,da850-psc1", of_da850_psc1_clk_init);
> +#endif
> diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
> index 3ec8100..3d8bdfa 100644
> --- a/include/linux/clk/davinci.h
> +++ b/include/linux/clk/davinci.h
> @@ -17,5 +17,6 @@ void dm644x_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
>  void dm646x_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
>
>  void da830_psc_clk_init(void __iomem *psc0, void __iomem *psc1);
> +void da850_psc_clk_init(void __iomem *psc0, void __iomem *psc1);
>
>  #endif /* __LINUX_CLK_DAVINCI_H__ */
> --
> 2.7.4
>

Hi David,

I've been working on moving the genpd code from its own driver to the
psc one. I couldn't get the system to boot though and problems
happened very early in the boot sequence. I struggled to figure out
what's happening, but eventually I noticed that psc uses
CLK_OF_DECLARE() to initialize clocks. The functions registered this
way are called very early in the boot sequence, way before
late_initcall() in which the genpd framework is initialized. This of
course makes it impossible to register genpd at the same time we
register PSCs.

Mike, Stephen - it would be great if you could confirm, but I believe
the clock framework now only accepts clock drivers which create real
platform drivers, in which case this series would need to be modified.

David: FYI I quickly converted the functions in psc-da850.c to actual
probe callbacks and it worked just fine on a da850-lcdk board.

Best regards,
Bartosz Golaszewski
