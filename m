Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C8CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6552151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6552151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeIZV4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:56:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48708 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeIZV4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:56:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A68118A;
        Wed, 26 Sep 2018 08:43:00 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9AD23F5BD;
        Wed, 26 Sep 2018 08:42:56 -0700 (PDT)
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
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
 <20180830144541.17740-3-vivek.gautam@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <763bc179-759a-cfda-e485-cf619ab5faec@arm.com>
Date:   Wed, 26 Sep 2018 16:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830144541.17740-3-vivek.gautam@codeaurora.org>
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
> The smmu device probe/remove and add/remove master device callbacks
> gets called when the smmu is not linked to its master, that is without
> the context of the master device. So calling runtime apis in those places
> separately.
> Global locks are also initialized before enabling runtime pm as the
> runtime_resume() calls device_reset() which does tlb_sync_global()
> that ultimately requires locks to be initialized.

To the best of my knowledge in this stuff (which is still not quite 
enough to be *truly* confident...),

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [vivek: Cleanup pm runtime calls]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 81 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index d900e007c3c9..1bf542010be7 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -268,6 +268,20 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>   	{ 0, NULL},
>   };
>   
> +static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> +{
> +	if (pm_runtime_enabled(smmu->dev))
> +		return pm_runtime_get_sync(smmu->dev);
> +
> +	return 0;
> +}
> +
> +static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> +{
> +	if (pm_runtime_enabled(smmu->dev))
> +		pm_runtime_put(smmu->dev);
> +}
> +
>   static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>   {
>   	return container_of(dom, struct arm_smmu_domain, domain);
> @@ -913,11 +927,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> -	int irq;
> +	int ret, irq;
>   
>   	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>   		return;
>   
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return;
> +
>   	/*
>   	 * Disable the context bank and free the page tables before freeing
>   	 * it.
> @@ -932,6 +950,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>   
>   	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>   	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> +
> +	arm_smmu_rpm_put(smmu);
>   }
>   
>   static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> @@ -1213,10 +1233,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   		return -ENODEV;
>   
>   	smmu = fwspec_smmu(fwspec);
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return ret;
> +
>   	/* Ensure that the domain is finalised */
>   	ret = arm_smmu_init_domain_context(domain, smmu);
>   	if (ret < 0)
> -		return ret;
> +		goto rpm_put;
>   
>   	/*
>   	 * Sanity check the domain. We don't support domains across
> @@ -1226,33 +1251,50 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   		dev_err(dev,
>   			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
>   			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto rpm_put;
>   	}
>   
>   	/* Looks ok, so add the device to the domain */
> -	return arm_smmu_domain_add_master(smmu_domain, fwspec);
> +	ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
> +
> +rpm_put:
> +	arm_smmu_rpm_put(smmu);
> +	return ret;
>   }
>   
>   static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>   			phys_addr_t paddr, size_t size, int prot)
>   {
>   	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> +	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> +	int ret;
>   
>   	if (!ops)
>   		return -ENODEV;
>   
> -	return ops->map(ops, iova, paddr, size, prot);
> +	arm_smmu_rpm_get(smmu);
> +	ret = ops->map(ops, iova, paddr, size, prot);
> +	arm_smmu_rpm_put(smmu);
> +
> +	return ret;
>   }
>   
>   static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>   			     size_t size)
>   {
>   	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> +	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> +	size_t ret;
>   
>   	if (!ops)
>   		return 0;
>   
> -	return ops->unmap(ops, iova, size);
> +	arm_smmu_rpm_get(smmu);
> +	ret = ops->unmap(ops, iova, size);
> +	arm_smmu_rpm_put(smmu);
> +
> +	return ret;
>   }
>   
>   static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
> @@ -1407,7 +1449,13 @@ static int arm_smmu_add_device(struct device *dev)
>   	while (i--)
>   		cfg->smendx[i] = INVALID_SMENDX;
>   
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		goto out_cfg_free;
> +
>   	ret = arm_smmu_master_alloc_smes(dev);
> +	arm_smmu_rpm_put(smmu);
> +
>   	if (ret)
>   		goto out_cfg_free;
>   
> @@ -1427,7 +1475,7 @@ static void arm_smmu_remove_device(struct device *dev)
>   	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>   	struct arm_smmu_master_cfg *cfg;
>   	struct arm_smmu_device *smmu;
> -
> +	int ret;
>   
>   	if (!fwspec || fwspec->ops != &arm_smmu_ops)
>   		return;
> @@ -1435,8 +1483,15 @@ static void arm_smmu_remove_device(struct device *dev)
>   	cfg  = fwspec->iommu_priv;
>   	smmu = cfg->smmu;
>   
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return;
> +
>   	iommu_device_unlink(&smmu->iommu, dev);
>   	arm_smmu_master_free_smes(fwspec);
> +
> +	arm_smmu_rpm_put(smmu);
> +
>   	iommu_group_remove_device(dev);
>   	kfree(fwspec->iommu_priv);
>   	iommu_fwspec_free(dev);
> @@ -2180,6 +2235,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	arm_smmu_device_reset(smmu);
>   	arm_smmu_test_smr_masks(smmu);
>   
> +	/*
> +	 * We want to avoid touching dev->power.lock in fastpaths unless
> +	 * it's really going to do something useful - pm_runtime_enabled()
> +	 * can serve as an ideal proxy for that decision. So, conditionally
> +	 * enable pm_runtime.
> +	 */
> +	if (dev->pm_domain) {
> +		pm_runtime_set_active(dev);
> +		pm_runtime_enable(dev);
> +	}
> +
>   	/*
>   	 * For ACPI and generic DT bindings, an SMMU will be probed before
>   	 * any device which might need it, so we want the bus ops in place
> @@ -2215,10 +2281,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>   	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
>   		dev_err(&pdev->dev, "removing device with active domains!\n");
>   
> +	arm_smmu_rpm_get(smmu);
>   	/* Turn the thing off */
>   	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> +	arm_smmu_rpm_put(smmu);
> +
> +	if (pm_runtime_enabled(smmu->dev))
> +		pm_runtime_force_suspend(smmu->dev);
> +	else
> +		clk_bulk_disable(smmu->num_clks, smmu->clks);
>   
> -	clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> +	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>   
>   	return 0;
>   }
> 
