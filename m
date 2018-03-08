Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbeCHW0s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:26:48 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11204 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeCHW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:26:46 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Mar 2018 14:26:46 -0800
Subject: Re: [PATCH v3 02/11] clk: tegra: retrieve regulator info from
 framework
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-3-git-send-email-pdeschrijver@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4ccd7c38-45f5-03d2-cb28-84fd5f967401@nvidia.com>
Date: Thu, 8 Mar 2018 22:26:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517934852-23255-3-git-send-email-pdeschrijver@nvidia.com>
X-Originating-IP: [10.26.11.23]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/02/18 16:34, Peter De Schrijver wrote:
> The CVB table contains calibration data for the CPU DFLL based on
> process charaterization. The regulator step and offset parameters depend
> on the regulator supplying vdd-cpu , not on the specific Tegra SKU.
> Hence than hardcoding those regulator parameters in the CVB table,
> retrieve them from the regulator framework and store them as part of the
> tegra_dfll_soc_data struct.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/clk/tegra/clk-dfll.h               |  2 ++
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 42 +++++++++++++++++++++++++-----
>  drivers/clk/tegra/cvb.c                    | 16 +++++++++---
>  drivers/clk/tegra/cvb.h                    |  6 ++---
>  4 files changed, 53 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h
> index 83352c8..e7cbc5b 100644
> --- a/drivers/clk/tegra/clk-dfll.h
> +++ b/drivers/clk/tegra/clk-dfll.h
> @@ -21,6 +21,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/types.h>
> +#include "cvb.h"
>  
>  /**
>   * struct tegra_dfll_soc_data - SoC-specific hooks/integration for the DFLL driver
> @@ -35,6 +36,7 @@ struct tegra_dfll_soc_data {
>  	struct device *dev;
>  	unsigned long max_freq;
>  	const struct cvb_table *cvb;
> +	struct rail_alignment alignment;
>  
>  	void (*init_clock_trimmers)(void);
>  	void (*set_clock_trimmers_high)(void);
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> index 269d359..e2dbb79 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -22,6 +22,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <soc/tegra/fuse.h>
>  
>  #include "clk.h"
> @@ -42,9 +43,6 @@
>  		.process_id = -1,
>  		.min_millivolts = 900,
>  		.max_millivolts = 1260,
> -		.alignment = {
> -			.step_uv = 10000, /* 10mV */
> -		},
>  		.speedo_scale = 100,
>  		.voltage_scale = 1000,
>  		.entries = {
> @@ -82,6 +80,34 @@
>  	},
>  };
>  
> +static int get_alignment_from_regulator(struct device *dev,
> +					struct rail_alignment *align)
> +{
> +	int min_uV, max_uV, n_voltages, ret;
> +	struct regulator *reg;
> +
> +	reg = devm_regulator_get(dev, "vdd-cpu");
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	ret = regulator_get_constraint_voltages(reg, &min_uV, &max_uV);
> +	if (!ret)
> +		align->offset_uv = min_uV;
> +	else
> +		return ret;

Nit-pick ... looks a bit odd, why not ...

	if (ret)
		return ret;

	align->offset_uv = min_uV;

> +
> +	align->step_uv = regulator_get_linear_step(reg);
> +	if (!align->step_uv && !ret) {

Do you need to test 'ret' here?

> +		n_voltages = regulator_count_voltages(reg);
> +		if (n_voltages > 1)
> +			align->step_uv = (max_uV - min_uV) / (n_voltages - 1);

Later in the patch !align->step_uv is treated as an error, so if
n_voltages should always be greater 1 then why not return an error here?
Seems that this should not happen?

Cheers
Jon

-- 
nvpublic
