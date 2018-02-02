Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeBBO5N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:57:13 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:40388 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeBBO5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:57:05 -0500
Subject: Re: [PATCH v6 25/41] ARM: dm646x: add new clock init using common
 clock framework
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-26-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <d874e568-315d-0325-1b60-920ed35ca740@ti.com>
Date: Fri, 2 Feb 2018 20:25:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-26-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
>  void __init dm646x_init_time(unsigned long ref_clk_rate,
>  			     unsigned long aux_clkin_rate)
>  {
> +#ifdef CONFIG_COMMON_CLK
> +	void __iomem *pll1, *pll2, *psc;
> +	struct clk *clk;
> +
> +	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_4K);
> +	pll2 = ioremap(DAVINCI_PLL2_BASE, SZ_4K);
> +	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
> +
> +	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
> +	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
> +
> +	dm646x_pll_clk_init(pll1, pll2);
> +
> +	dm646x_psc_clk_init(psc);

> +	/* no LPSC, always enabled; c.f. spruep9a */
> +	clk = clk_register_fixed_factor(NULL, "timer2", "pll1_sysclk3", 0, 1, 1);
> +	clk_register_clkdev(clk, NULL, "davinci-wdt");

Lets move this to dm646x_pll_clk_init() and directly register to clkdev
to pll1_sysclk3?

Thanks,
Sekhar
