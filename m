Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeBBOOI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:14:08 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:18890 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeBBONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:13:53 -0500
Subject: Re: [PATCH v6 20/41] ARM: da830: add new clock init using common
 clock framework
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-21-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <4b2f45f5-7f0d-f0e6-6854-9992e19f45f2@ti.com>
Date: Fri, 2 Feb 2018 19:42:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-21-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>  void __init da830_init_time(void)
>  {
> +#ifdef CONFIG_COMMON_CLK
> +	void __iomem *pll0, *psc0, *psc1;
> +	struct clk *clk;
> +
> +	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
> +	psc0 = ioremap(DA8XX_PSC0_BASE, SZ_4K);
> +	psc1 = ioremap(DA8XX_PSC1_BASE, SZ_4K);
> +
> +	da8xx_register_cfgchip();
> +
> +	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
> +
> +	da830_pll_clk_init(pll0);
> +
> +	da830_psc_clk_init(psc0, psc1);
> +

> +	clk = clk_register_fixed_factor(NULL, "i2c0", "pll0_aux_clk", 0, 1, 1);
> +	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
> +
> +	clk = clk_register_fixed_factor(NULL, "timer0", "pll0_aux_clk", 0, 1, 1);
> +	clk_register_clkdev(clk, "timer0", NULL);
> +
> +	clk = clk_register_fixed_factor(NULL, "timer1", "pll0_aux_clk", 0, 1, 1);
> +	clk_register_clkdev(clk, NULL, "davinci-wdt");

Isn't this better done in da830_pll_clk_init() ? I think we can get rid
of the dummy fixed factor clock too and directly use the pll0_auxclk.
That reminds me, is "pll0_aux_clk" above correct, or should it be
"pll0_auxclk" like in da830_pll_clk_init()?

> +
> +	clk = clk_register_fixed_factor(NULL, "rmii", "pll0_sysclk7", 0, 1, 1);
> +	clk_register_clkdev(clk, "rmii", NULL);

I don't see any driver looking for this clock using con_id "rmii". I
know this came from existing code. But its most likely a vestige and can
be dropped.

Thanks,
Sekhar
