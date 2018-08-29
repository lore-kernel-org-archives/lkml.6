Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF39C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCB32064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QFijrzlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCB32064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeH2V71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:59:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36335 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbeH2V70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:59:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so2664431pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9GDpMREyeT2GBhNT8zhNcEBbqvFl4QeVKQ66Bh2sdcQ=;
        b=QFijrzltB7+NRK4h8zmA3chKGuH41HhUyQ3Dj8RNOJiEJaDY2IWfMaT5ROgW/DdUjI
         BOe4cIWEJCzfJgFfccl3RSMjCG793Ko4l7tcDTX0T86jd/NRQTpm5X7IR4WzJQCXaLkh
         CcLZmYtbxvN2Epukwqub1HO924TOyxG9HDvZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9GDpMREyeT2GBhNT8zhNcEBbqvFl4QeVKQ66Bh2sdcQ=;
        b=sugf5Q+NGwBCaVGLlmLlEaUdBdBRQ+nj/G6I81P8SZ8L1p56URm5hfcdd8iXDY+lKt
         h0GAe0Lx6/2pLyjrmsBkbFrmDIB7n/GaY+BLgw43LY3jTJJC1MSO577GDHwVzl3RMgAV
         2J0MCptmIImNeXHfmFzPXAnNiEq4P4JP3S+6ZPZUE0LHxok7yqGMyQSLT8lRT99V96vr
         Tnn0wknwtKdJBN11Kchu1rhaD+T0aIvwoU/6hMnH1P7iAz2KPGk2+hacyZkzpxuywadI
         U+O4hKDcT31nQMETqd+IyQlHdE74zZuJ3ReG4X/Pb0S3QDzF+REKPYHYgwi0ry5Vp2BV
         J5jQ==
X-Gm-Message-State: APzg51A2WM5QHHQElrbsDQXkP0qz0NdnXjdOxm7FulHzKhh9JtE7wQR8
        z2gNyYGbmdL0Capc4OWzHN76UQ==
X-Google-Smtp-Source: ANB0VdauMM/ZIRuXZSNieSTVRqnXv4bGBtB86SLkuZQGRrrYZ8X0Sh5w9cB8RTvmTGfe7uEJG7sTJw==
X-Received: by 2002:a63:5055:: with SMTP id q21-v6mr6578307pgl.397.1535565684024;
        Wed, 29 Aug 2018 11:01:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id k8-v6sm7860980pga.80.2018.08.29.11.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 11:01:23 -0700 (PDT)
Date:   Wed, 29 Aug 2018 11:01:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20180829180122.GC10879@google.com>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

On Tue, Jul 24, 2018 at 04:12:50PM +0530, Taniya Das wrote:
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  11 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 348 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 360 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 0cd8eb7..93a9d72 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -298,3 +298,14 @@ config ARM_PXA2xx_CPUFREQ
>  	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
> 
>  	  If in doubt, say N.
> +
> +config ARM_QCOM_CPUFREQ_HW
> +	bool "QCOM CPUFreq HW driver"
> +	depends on ARCH_QCOM
> +	help
> +	 Support for the CPUFreq HW driver.
> +	 Some QCOM chipsets have a HW engine to offload the steps
> +	 necessary for changing the frequency of the CPUs. Firmware loaded
> +	 in this engine exposes a programming interface to the OS.
> +	 The driver implements the cpufreq interface for this HW engine.
> +	 Say Y if you want to support CPUFreq HW.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index c1ffeab..ca48a1d 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
> 
> 
>  ##################################################################################
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> new file mode 100644
> index 0000000..ea8f7d1
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +
> +#define INIT_RATE			300000000UL
> +#define LUT_MAX_ENTRIES			40U
> +#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
> +#define LUT_ROW_SIZE			32
> +
> +enum {
> +	REG_ENABLE,
> +	REG_LUT_TABLE,
> +	REG_PERF_STATE,
> +
> +	REG_ARRAY_SIZE,
> +};
> +
> +struct cpufreq_qcom {
> +	struct cpufreq_frequency_table *table;
> +	struct device *dev;

'dev' is not used and can be removed.

> ...
> 
> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +				   struct device_node *np, unsigned int cpu,
> +				   unsigned long xo_rate)
> +{
> +	struct cpufreq_qcom *c;
> +	struct resource res;
> +	struct device *dev = &pdev->dev;
> +	const u16 *offsets;
> +	int ret, i, cpu_first, cpu_r;
> +	void __iomem *base;
> +
> +	if (qcom_freq_domain_map[cpu])
> +		return 0;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	offsets = of_device_get_match_data(&pdev->dev);
> +	if (!offsets)
> +		return -EINVAL;
> +
> +	if (of_address_to_resource(np, 0, &res))
> +		return -ENOMEM;
> +
> +	base = devm_ioremap_resource(dev, &res);
> +	if (!base)
> +		return -ENOMEM;
> +
> +	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
> +		c->reg_bases[i] = base + offsets[i];
> +
> +	/* HW should be in enabled state to proceed */
> +	if (!(readl_relaxed(c->reg_bases[REG_ENABLE]) & 0x1)) {
> +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
> +		return -ENODEV;
> +	}
> +
> +	ret = qcom_get_related_cpus(np, &c->related_cpus);
> +	if (ret) {
> +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
> +		return ret;
> +	}
> +
> +	c->max_cores = cpumask_weight(&c->related_cpus);
> +	if (!c->max_cores)
> +		return -ENOENT;
> +
> +	c->xo_rate = xo_rate;
> +
> +	ret = qcom_cpufreq_hw_read_lut(pdev, c);
> +	if (ret) {
> +		dev_err(dev, "%s failed to read LUT\n", np->name);
> +		return ret;
> +	}
> +
> +	qcom_freq_domain_map[cpu] = c;
> +
> +	/* Related CPUs */
> +	cpu_first = cpumask_first(&c->related_cpus);
> +
> +	for_each_cpu(cpu_r, &c->related_cpus) {
> +		if (cpu_r != cpu_first)
> +			qcom_freq_domain_map[cpu_r] =
> +				qcom_freq_domain_map[cpu_first];
> +	}

The above ten lines could be simplified to:

	for_each_cpu(cpu_r, &c->related_cpus)
		qcom_freq_domain_map[cpu_r] = c;

> ...
> 
> +static int __init qcom_cpufreq_hw_init(void)
> +{
> +	return platform_driver_register(&qcom_cpufreq_hw_driver);
> +}
> +subsys_initcall(qcom_cpufreq_hw_init);

Is subsys_initcall used for a particular reason? It will cause
problems when registering cooling devices, since the thermal device
class is initialized through an fs_initcall, which are executed
later.

Most cpufreq drivers use module_init, device_initcall or
late_initcall, can't this driver use one of those?

Cheers

Matthias
