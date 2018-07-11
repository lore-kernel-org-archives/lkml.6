Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB57C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDF220B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDF220B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeGKJzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:55:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47274 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeGKJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:55:49 -0400
Received: from 79.184.255.246.ipv4.supernova.orange.pl (79.184.255.246) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id ab3330211bbacccc; Wed, 11 Jul 2018 11:52:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        robdclark@gmail.com, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jcrouse@codeaurora.org
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
Date:   Wed, 11 Jul 2018 11:50:44 +0200
Message-ID: <17407514.unFVTGoGrn@aspire.rjw.lan>
In-Reply-To: <20180708173413.1965-2-vivek.gautam@codeaurora.org>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org> <20180708173413.1965-2-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, July 8, 2018 7:34:10 PM CEST Vivek Gautam wrote:
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
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Archit Taneja <architt@codeaurora.org>
> [vivek: Clock rework to request bulk of clocks]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
>  - No change since v11.
> 
>  drivers/iommu/arm-smmu.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index f7a96bcf94a6..a01d0dde21dd 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -48,6 +48,7 @@
>  #include <linux/of_iommu.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>  	u32				num_global_irqs;
>  	u32				num_context_irqs;
>  	unsigned int			*irqs;
> +	struct clk_bulk_data		*clks;
> +	int				num_clks;
>  
>  	u32				cavium_id_base; /* Specific to Cavium */
>  
> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  struct arm_smmu_match_data {
>  	enum arm_smmu_arch_version version;
>  	enum arm_smmu_implementation model;
> +	const char * const *clks;
> +	int num_clks;
>  };
>  
>  #define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>  
>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
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
>  #ifdef CONFIG_ACPI
>  static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
>  {
> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  	data = of_device_get_match_data(dev);
>  	smmu->version = data->version;
>  	smmu->model = data->model;
> +	smmu->num_clks = data->num_clks;
> +
> +	arm_smmu_fill_clk_data(smmu, data->clks);
>  
>  	parse_driver_options(smmu);
>  
> @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  		smmu->irqs[i] = irq;
>  	}
>  
> +	err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
> +	if (err)
> +		return err;
> +
> +	err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
> +	if (err)
> +		return err;
> +
>  	err = arm_smmu_device_cfg_probe(smmu);
>  	if (err)
>  		return err;
> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>  
>  	/* Turn the thing off */
>  	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> +
> +	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> +
>  	return 0;
>  }
>  
> @@ -2197,7 +2233,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	return clk_bulk_enable(smmu->num_clks, smmu->clks);
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
> +static const struct dev_pm_ops arm_smmu_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)

This is suspicious.

If you need a runtime suspend method, why do you think that it is not necessary
to suspend the device during system-wide transitions?

> +	SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> +			   arm_smmu_runtime_resume, NULL)
> +};
>  
>  static struct platform_driver arm_smmu_driver = {
>  	.driver	= {
> 


