Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8658CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555192087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfAYSct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:32:49 -0500
Received: from foss.arm.com ([217.140.101.70]:52506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfAYScs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:32:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 755CFEBD;
        Fri, 25 Jan 2019 10:32:48 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 179B83F5C1;
        Fri, 25 Jan 2019 10:32:45 -0800 (PST)
Subject: Re: [PATCH v5 4/4] perf/smmuv3_pmu: Enable HiSilicon Erratum
 162001800 quirk
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        lorenzo.pieralisi@arm.com
Cc:     jean-philippe.brucker@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, guohanjun@huawei.com, john.garry@huawei.com,
        pabba@codeaurora.org, vkilari@codeaurora.org,
        rruigrok@codeaurora.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, neil.m.leeder@gmail.com
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
 <20181130154751.28580-5-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bfb957ad-ab5d-1848-7aec-a486476f8be6@arm.com>
Date:   Fri, 25 Jan 2019 18:32:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181130154751.28580-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 15:47, Shameer Kolothum wrote:
> HiSilicon erratum 162001800 describes the limitation of
> SMMUv3 PMCG implementation on HiSilicon Hip08 platforms.
> 
> On these platforms, the PMCG event counter registers
> (SMMU_PMCG_EVCNTRn) are read only and as a result it
> is not possible to set the initial counter period value
> on event monitor start.
> 
> To work around this, the current value of the counter
> is read and used for delta calculations. OEM information
> from ACPI header is used to identify the affected hardware
> platforms.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c     | 30 +++++++++++++++++++++++++++---
>   drivers/perf/arm_smmuv3_pmu.c | 35 +++++++++++++++++++++++++++++------
>   include/linux/acpi_iort.h     |  3 +++
>   3 files changed, 59 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 2da08e1..d174379 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1364,6 +1364,22 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
>   				       ACPI_EDGE_SENSITIVE, &res[2]);
>   }
>   
> +static struct acpi_platform_list pmcg_evcntr_rdonly_list[] __initdata = {
> +	/* HiSilicon Erratum 162001800 */
> +	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal},
> +	{ }
> +};
> +
> +static int __init arm_smmu_v3_pmcg_add_platdata(struct platform_device *pdev)
> +{
> +	u32 options = 0;
> +
> +	if (acpi_match_platform_list(pmcg_evcntr_rdonly_list) >= 0)
> +		options |= IORT_PMCG_EVCNTR_RDONLY;

Hmm, do we want IORT code to have to understand a (potential) whole load 
of PMCG-specific quirks directly, or do we really only need to pass some 
unambiguous identifier for the PMCG implementation, and let the driver 
handle the details in private - much like the SMMU model field, only 
without an external spec to constrain us :)

If we ever want to have named imp-def events, we'd need to do something 
like that anyway, so perhaps we might be better off taking that approach 
to begin with (and if so, I'd be inclined to push the basic platdata 
initialisation for "generic PMCG" into patch #1).

> +
> +	return platform_device_add_data(pdev, &options, sizeof(options));
> +}
> +
>   struct iort_dev_config {
>   	const char *name;
>   	int (*dev_init)(struct acpi_iort_node *node);
> @@ -1374,6 +1390,7 @@ struct iort_dev_config {
>   				     struct acpi_iort_node *node);
>   	void (*dev_set_proximity)(struct device *dev,
>   				    struct acpi_iort_node *node);
> +	int (*dev_add_platdata)(struct platform_device *pdev);
>   };
>   
>   static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
> @@ -1395,6 +1412,7 @@ static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
>   	.name = "arm-smmu-v3-pmu",
>   	.dev_count_resources = arm_smmu_v3_pmcg_count_resources,
>   	.dev_init_resources = arm_smmu_v3_pmcg_init_resources,
> +	.dev_add_platdata	= arm_smmu_v3_pmcg_add_platdata,
>   };
>   
>   static __init const struct iort_dev_config *iort_get_dev_cfg(
> @@ -1455,10 +1473,16 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>   		goto dev_put;
>   
>   	/*
> -	 * Add a copy of IORT node pointer to platform_data to
> -	 * be used to retrieve IORT data information.
> +	 * Platform devices based on PMCG nodes uses platform_data to
> +	 * pass quirk flags to the driver. For others, add a copy of
> +	 * IORT node pointer to platform_data to be used to retrieve
> +	 * IORT data information.
>   	 */
> -	ret = platform_device_add_data(pdev, &node, sizeof(node));
> +	if (ops->dev_add_platdata)
> +		ret = ops->dev_add_platdata(pdev);
> +	else
> +		ret = platform_device_add_data(pdev, &node, sizeof(node));
> +
>   	if (ret)
>   		goto dev_put;
>   
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 71d10a0..02107a1 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -35,6 +35,7 @@
>    */
>   
>   #include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>   #include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/cpuhotplug.h>
> @@ -111,6 +112,7 @@ struct smmu_pmu {
>   	struct device *dev;
>   	void __iomem *reg_base;
>   	void __iomem *reloc_base;
> +	u32 options;
>   	u64 counter_present_mask;
>   	u64 counter_mask;
>   };
> @@ -224,12 +226,25 @@ static void smmu_pmu_set_period(struct smmu_pmu *smmu_pmu,
>   	u32 idx = hwc->idx;
>   	u64 new;
>   
> -	/*
> -	 * We limit the max period to half the max counter value of the counter
> -	 * size, so that even in the case of extreme interrupt latency the
> -	 * counter will (hopefully) not wrap past its initial value.
> -	 */
> -	new = smmu_pmu->counter_mask >> 1;
> +	if (smmu_pmu->options & IORT_PMCG_EVCNTR_RDONLY) {
> +		/*
> +		 * On platforms that require this quirk, if the counter starts
> +		 * at < half_counter value and wraps, the current logic of
> +		 * handling the overflow may not work. It is expected that,
> +		 * those platforms will have full 64 counter bits implemented
> +		 * so that such a possibility is remote(eg: HiSilicon HIP08).
> +		 */
> +		new = smmu_pmu_counter_get_value(smmu_pmu, idx);
> +	} else {
> +		/*
> +		 * We limit the max period to half the max counter value
> +		 * of the counter size, so that even in the case of extreme
> +		 * interrupt latency the counter will (hopefully) not wrap
> +		 * past its initial value.
> +		 */
> +		new = smmu_pmu->counter_mask >> 1;
> +		smmu_pmu_counter_set_value(smmu_pmu, idx, new);
> +	}
>   
>   	local64_set(&hwc->prev_count, new);
>   	smmu_pmu_counter_set_value(smmu_pmu, idx, new);

Either we've just done this already, or it's not going to have any 
effect anyway, so it can definitely go.

Robin.

> @@ -670,6 +685,12 @@ static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
>   		       smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
>   }
>   
> +static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
> +{
> +	smmu_pmu->options = *(u32 *)dev_get_platdata(smmu_pmu->dev);
> +	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
> +}
> +
>   static int smmu_pmu_probe(struct platform_device *pdev)
>   {
>   	struct smmu_pmu *smmu_pmu;
> @@ -749,6 +770,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> +	smmu_pmu_get_acpi_options(smmu_pmu);
> +
>   	/* Pick one CPU to be the preferred one to use */
>   	smmu_pmu->on_cpu = get_cpu();
>   	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 38cd77b..4a7ae69 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -26,6 +26,9 @@
>   #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
>   #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
>   
> +/* PMCG node option or quirk flags */
> +#define IORT_PMCG_EVCNTR_RDONLY		(1 << 0)
> +
>   int iort_register_domain_token(int trans_id, phys_addr_t base,
>   			       struct fwnode_handle *fw_node);
>   void iort_deregister_domain_token(int trans_id);
> 
