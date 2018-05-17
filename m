Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeEQOhG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:37:06 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:41513 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbeEQOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:37:02 -0400
Subject: Re: [PATCH v10 25/27] ARM: davinci: add device tree support to timer
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-26-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <8fa98514-7651-58cb-595e-6c7f713540b8@ti.com>
Date: Thu, 17 May 2018 20:05:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509172606.29387-26-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wednesday 09 May 2018 10:56 PM, David Lechner wrote:
> This adds device tree support to the davinci timer so that when clocks
> are moved to device tree, the timer will still work.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

> +static int __init of_davinci_timer_init(struct device_node *np)
> +{
> +	struct clk *clk;
> +
> +	clk = of_clk_get(np, 0);
> +	if (IS_ERR(clk)) {
> +		struct of_phandle_args clkspec;
> +
> +		/*
> +		 * Fall back to using ref_clk if the actual clock is not
> +		 * available. There will be problems later if the real clock
> +		 * source is disabled.
> +		 */
> +
> +		pr_warn("%s: falling back to ref_clk\n", __func__);
> +
> +		clkspec.np = of_find_node_by_name(NULL, "ref_clk");
> +		if (IS_ERR(clkspec.np)) {
> +			pr_err("%s: No clock available for timer!\n", __func__);
> +			return PTR_ERR(clkspec.np);
> +		}
> +		clk = of_clk_get_from_provider(&clkspec);
> +		of_node_put(clkspec.np);
> +	}

Do we need this error path now?

Thanks,
Sekhar
