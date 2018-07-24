Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE6DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92DC2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92DC2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbeGXQ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:28:28 -0400
Received: from foss.arm.com ([217.140.101.70]:53766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeGXQ22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:28:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DAC780D;
        Tue, 24 Jul 2018 08:21:29 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10EAA3F237;
        Tue, 24 Jul 2018 08:21:25 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v13 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        robdclark@gmail.com, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        lukas@wunner.de, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org
References: <20180719101539.6104-1-vivek.gautam@codeaurora.org>
 <20180719101539.6104-2-vivek.gautam@codeaurora.org>
Message-ID: <e17fdcb7-2632-753f-4e2e-f81bcded36f1@arm.com>
Date:   Tue, 24 Jul 2018 16:21:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719101539.6104-2-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/18 11:15, Vivek Gautam wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> The smmu needs to be functional only when the respective
> master's using it are active. The device_link feature
> helps to track such functional dependencies, so that the
> iommu gets powered when the master device enables itself
> using pm_runtime. So by adapting the smmu driver for
> runtime pm, above said dependency can be addressed.
> 
> This patch adds the pm runtime/sleep callbacks to the
> driver and also the functions to parse the smmu clocks
> from DT and enable them in resume/suspend.
> 
> Also, while we enable the runtime pm add a pm sleep suspend
> callback that pushes devices to low power state by turning
> the clocks off in a system sleep.
> Also add corresponding clock enable path in resume callback.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Archit Taneja <architt@codeaurora.org>
> [vivek: rework for clock and pm ops]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
> Changes since v12:
>   - Added pm sleep .suspend callback. This disables the clocks.
>   - Added corresponding change to enable clocks in .resume
>    pm sleep callback.
> 
>   drivers/iommu/arm-smmu.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c73cfce1ccc0..9138a6fffe04 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -48,6 +48,7 @@
>   #include <linux/of_iommu.h>
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   
> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>   	u32				num_global_irqs;
>   	u32				num_context_irqs;
>   	unsigned int			*irqs;
> +	struct clk_bulk_data		*clks;
> +	int				num_clks;
>   
>   	u32				cavium_id_base; /* Specific to Cavium */
>   
> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   struct arm_smmu_match_data {
>   	enum arm_smmu_arch_version version;
>   	enum arm_smmu_implementation model;
> +	const char * const *clks;
> +	int num_clks;
>   };
>   
>   #define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>   
>   ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>   ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>   
> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
> +				   const char * const *clks)
> +{
> +	int i;
> +
> +	if (smmu->num_clks < 1)
> +		return;
> +
> +	smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
> +				  sizeof(*smmu->clks), GFP_KERNEL);
> +	if (!smmu->clks)
> +		return;
> +
> +	for (i = 0; i < smmu->num_clks; i++)
> +		smmu->clks[i].id = clks[i];
> +}
> +
>   #ifdef CONFIG_ACPI
>   static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
>   {
> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>   	data = of_device_get_match_data(dev);
>   	smmu->version = data->version;
>   	smmu->model = data->model;
> +	smmu->num_clks = data->num_clks;
> +
> +	arm_smmu_fill_clk_data(smmu, data->clks);
>   
>   	parse_driver_options(smmu);
>   
> @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   		smmu->irqs[i] = irq;
>   	}
>   
> +	err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
> +	if (err)
> +		return err;
> +
> +	err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
> +	if (err)
> +		return err;
> +
>   	err = arm_smmu_device_cfg_probe(smmu);
>   	if (err)
>   		return err;
> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>   
>   	/* Turn the thing off */
>   	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> +
> +	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> +
>   	return 0;
>   }
>   
> @@ -2189,15 +2225,50 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>   	arm_smmu_device_remove(pdev);
>   }
>   
> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	return clk_bulk_enable(smmu->num_clks, smmu->clks);

If there's a power domain being automatically switched by genpd then we 
need a reset here because we may have lost state entirely. Since I 
remembered the otherwise-useless GPU SMMU on Juno is in a separate power 
domain, I gave it a poking via sysfs with some debug stuff to dump sCR0 
in these callbacks, and the problem is clear:

...
[    4.625551] arm-smmu 2b400000.iommu: genpd_runtime_suspend()
[    4.631163] arm-smmu 2b400000.iommu: arm_smmu_runtime_suspend: 0x00201936
[    4.637897] arm-smmu 2b400000.iommu: suspend latency exceeded, 6733980 ns
[   21.566983] arm-smmu 2b400000.iommu: genpd_runtime_resume()
[   21.584796] arm-smmu 2b400000.iommu: arm_smmu_runtime_resume: 0x00220101
[   21.591452] arm-smmu 2b400000.iommu: resume latency exceeded, 6658020 ns
...

> +}
> +
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	clk_bulk_disable(smmu->num_clks, smmu->clks);
> +
> +	return 0;
> +}
> +
>   static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>   {
>   	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!pm_runtime_suspended(dev)) {
> +		ret = arm_smmu_runtime_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	arm_smmu_device_reset(smmu);

This looks a bit off too - if we wake from sleep when the SMMU was also 
runtime-suspended, it appears we might end up trying to restore the 
register state without clocks enabled. Surely we need to always enable 
clocks for the reset, then restore the previous suspended state? 
Although given my previous point, it's probably not worth doing anything 
at all here for that case.

Robin.

>   	return 0;
>   }
>   
> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> +{
> +	if (!pm_runtime_suspended(dev))
> +		return arm_smmu_runtime_suspend(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops arm_smmu_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)
> +	SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> +			   arm_smmu_runtime_resume, NULL)
> +};
>   
>   static struct platform_driver arm_smmu_driver = {
>   	.driver	= {
> 
