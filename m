Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D9E214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D9E214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeIZVlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:41:12 -0400
Received: from foss.arm.com ([217.140.101.70]:48540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeIZVlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:41:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1827C18A;
        Wed, 26 Sep 2018 08:27:44 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E02003F5BD;
        Wed, 26 Sep 2018 08:27:40 -0700 (PDT)
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        robh+dt@kernel.org, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-2-vivek.gautam@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1a918f99-83b0-2f51-7634-126639a220de@arm.com>
Date:   Wed, 26 Sep 2018 16:27:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830144541.17740-2-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/18 15:45, Vivek Gautam wrote:
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
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index fd1b80ef9490..d900e007c3c9 100644
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
> @@ -1896,10 +1899,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
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
> @@ -1918,6 +1923,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
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
> @@ -2000,6 +2022,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>   	data = of_device_get_match_data(dev);
>   	smmu->version = data->version;
>   	smmu->model = data->model;
> +	smmu->num_clks = data->num_clks;
> +
> +	arm_smmu_fill_clk_data(smmu, data->clks);
>   
>   	parse_driver_options(smmu);
>   
> @@ -2098,6 +2123,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   		smmu->irqs[i] = irq;
>   	}
>   
> +	err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
> +	if (err)
> +		return err;
> +
> +	err = clk_bulk_prepare_enable(smmu->num_clks, smmu->clks);
> +	if (err)
> +		return err;
> +

Hmm, if we error out beyond here it looks like we should strictly 
balance that prepare/enable before devres does the clk_bulk_put(), 
however the probe error path is starting to look like it needs a bit of 
love in general, so I might just spin a cleanup patch on top (and even 
then only for the sake of not being a bad example; SMMU probe failure is 
never a realistic situation for the system to actually recover from).

Otherwise,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   	err = arm_smmu_device_cfg_probe(smmu);
>   	if (err)
>   		return err;
> @@ -2184,6 +2217,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>   
>   	/* Turn the thing off */
>   	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> +
> +	clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> +
>   	return 0;
>   }
>   
> @@ -2192,15 +2228,50 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>   	arm_smmu_device_remove(pdev);
>   }
>   
> -static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>   {
>   	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
> +	if (ret)
> +		return ret;
>   
>   	arm_smmu_device_reset(smmu);
> +
>   	return 0;
>   }
>   
> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	clk_bulk_disable(smmu->num_clks, smmu->clks);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> +{
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	return arm_smmu_runtime_resume(dev);
> +}
> +
> +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> +{
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	return arm_smmu_runtime_suspend(dev);
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
