Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeCTHQM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbeCTHQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:16:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2E62177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, mark.rutland@arm.com, mturquette@baylibre.com,
        robh+dt@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180317100952.28538-13-manivannan.sadhasivam@linaro.org>
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
 <20180317100952.28538-13-manivannan.sadhasivam@linaro.org>
Message-ID: <152153016749.254778.17294370002590376536@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 12/12] clk: actions: Add S900 SoC clock support
Date: Tue, 20 Mar 2018 00:16:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-03-17 03:09:52)
> diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900.c
> new file mode 100644
> index 000000000000..5a9b1e3f3571
> --- /dev/null
> +++ b/drivers/clk/actions/owl-s900.c
> @@ -0,0 +1,690 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// OWL S900 SoC clock driver
> +//
> +// Copyright (c) 2014 Actions Semi Inc.
> +// Author: David Liu <liuwei@actions-semi.com>
> +//
> +// Copyright (c) 2018 Linaro Ltd.
> +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

Is this include used?

> +
> +#include "owl-common.h"
> +#include "owl-composite.h"
> +#include "owl-divider.h"
> +#include "owl-factor.h"
> +#include "owl-fixed-factor.h"
> +#include "owl-gate.h"
> +#include "owl-mux.h"
> +#include "owl-pll.h"
> +#include "owl-s900.h"
> +
> +#include <dt-bindings/clock/actions,s900-cmu.h>
> +
> +static struct clk_pll_table clk_audio_pll_table[] = {
> +       {0, 45158400}, {1, 49152000},
> +       {0, 0},
> +};
> +
> +static struct clk_pll_table clk_edp_pll_table[] = {
> +       {0, 810000000}, {1, 1350000000}, {2, 2700000000},

Please put spaces around brackets.

> +       {0, 0},
> +};
> +
> +/* pll clocks */
> +static OWL_PLL_NO_PARENT(core_pll_clk, "core_pll_clk", CMU_COREPLL, 24000000, 9, 0, 8, 5, 107, NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(dev_pll_clk, "dev_pll_clk", CMU_DEVPLL, 6000000, 8, 0, 8, 20, 180, NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(ddr_pll_clk, "ddr_pll_clk", CMU_DDRPLL, 24000000, 8, 0, 8, 5, 45, NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(nand_pll_clk, "nand_pll_clk", CMU_NANDPLL, 6000000, 8, 0, 8, 4, 100, NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(display_pll_clk, "display_pll_clk", CMU_DISPLAYPLL, 6000000, 8, 0, 8, 20, 180, NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(assist_pll_clk, "assist_pll_clk", CMU_ASSISTPLL, 500000000, 0, 0, 0, 0, 0, NULL, CLK_IGNORE_UNUSED);
> +static OWL_PLL_NO_PARENT(audio_pll_clk, "audio_pll_clk", CMU_AUDIOPLL, 0, 4, 0, 1, 0, 0, clk_audio_pll_table, CLK_IGNORE_UNUSED);
> +static OWL_PLL(edp_pll_clk, "edp_pll_clk", "edp24M_clk", CMU_EDPCLK, 0, 9, 0, 2, 0, 0, clk_edp_pll_table, CLK_IGNORE_UNUSED);
> +
> +static const char *cpu_clk_mux_p[] = { "losc", "hosc", "core_pll_clk", };
> +static const char *dev_clk_p[] = { "hosc", "dev_pll_clk", };
> diff --git a/drivers/clk/actions/owl-s900.h b/drivers/clk/actions/owl-s900.h
> new file mode 100644
> index 000000000000..d0c10594e518
> --- /dev/null
> +++ b/drivers/clk/actions/owl-s900.h
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// OWL S900 SoC clock driver
> +//
> +// Copyright (c) 2014 Actions Semi Inc.
> +// Author: David Liu <liuwei@actions-semi.com>
> +//
> +// Copyright (c) 2018 Linaro Ltd.
> +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +#ifndef _OWL_S900_H_
> +#define _OWL_S900_H_

I'd prefer this file contents go inside the one C file that uses it so
we can quickly reference the offsets without going to another file.

> +
> +#define CMU_COREPLL            (0x0000)
> +#define CMU_DEVPLL             (0x0004)
> +#define CMU_DDRPLL             (0x0008)
