Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeBFE1A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:27:00 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37787 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeBFE0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:26:47 -0500
X-Google-Smtp-Source: AH8x225czuivqzdmAGfIPGmymhioPV5bD+m/y16hO+Z52RLOtiZ4rYh5hKXNs6b/9yfndBzmWQUTNw==
Date: Tue, 6 Feb 2018 09:56:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v6 14/15] cpufreq: Add module to register cpufreq on
 Krait CPUs
Message-ID: <20180206042642.GG28462@vireshk-i7>
References: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
 <1517890108-8140-15-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517890108-8140-15-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-02-18, 09:38, Sricharan R wrote:
> diff --git a/drivers/cpufreq/qcom-cpufreq.c b/drivers/cpufreq/qcom-cpufreq.c
> new file mode 100644
> index 0000000..5b988d4
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +
> +#include <linux/cpu.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +#include "cpufreq-dt.h"
> +#include <linux/nvmem-consumer.h>

I don't think you need all of these anymore, isn't it ? Can you cross check
which ones are really required? For example, cpufreq-dt.h isn't required for
sure.

> +static int __init qcom_cpufreq_driver_init(void)
> +{
> +	struct device *cpu_dev;
> +	struct device_node *np;
> +	struct nvmem_cell *pvs_nvmem;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +	if (!np)
> +		return -ENOENT;
> +
> +	if (!of_device_is_compatible(np, "operating-points-v2-krait-cpu")) {
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +
> +	pvs_nvmem = of_nvmem_cell_get(np, NULL);
> +	if (IS_ERR(pvs_nvmem)) {
> +		dev_err(cpu_dev, "Could not get nvmem cell\n");
> +		return PTR_ERR(pvs_nvmem);
> +	}
> +
> +	of_node_put(np);
> +
> +	ret = qcom_cpufreq_populate_opps(pvs_nvmem);
> +	if (ret)
> +		return ret;
> +
> +	return PTR_ERR(platform_device_register_simple("cpufreq-dt",
> +						       -1, NULL, 0));

Wanna do proper error handling here? For example, unset OPP name on failure here
so that resources get freed ?

> +}
> +module_init(qcom_cpufreq_driver_init);
> +
> +MODULE_DESCRIPTION("Qualcomm CPUfreq driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

-- 
viresh
