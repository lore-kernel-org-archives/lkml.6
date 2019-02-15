Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9781B21916
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436776AbfBOLwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:52:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58628 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbfBOLwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:52:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4636EBD;
        Fri, 15 Feb 2019 03:52:54 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B24FB3F575;
        Fri, 15 Feb 2019 03:52:51 -0800 (PST)
Date:   Fri, 15 Feb 2019 11:52:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     robin.murphy@arm.com, andrew.murray@arm.com,
        jean-philippe.brucker@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, guohanjun@huawei.com, john.garry@huawei.com,
        pabba@codeaurora.org, vkilari@codeaurora.org,
        rruigrok@codeaurora.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, neil.m.leeder@gmail.com
Subject: Re: [PATCH v6 1/4] acpi: arm64: add iort support for PMCG
Message-ID: <20190215115245.GA29775@e107981-ln.cambridge.arm.com>
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
 <20190204121324.11460-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204121324.11460-2-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 12:13:21PM +0000, Shameer Kolothum wrote:
> From: Neil Leeder <nleeder@codeaurora.org>
> 
> Add support for the SMMU Performance Monitor Counter Group
> information from ACPI. This is in preparation for its use
> in the SMMUv3 PMU driver.

Also, in case I do not get a chance to update it, please run:

git log --oneline --no-merges drivers/acpi/arm64/iort.c

You would notice incosistency in the $SUBJECT, fix it please.

Thanks,
Lorenzo

> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/iort.c | 117 ++++++++++++++++++++++++++++++++++++----------
>  include/linux/acpi_iort.h |   6 +++
>  2 files changed, 99 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e48894e..e2c9b26 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -356,7 +356,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>  	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>  		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>  		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> -		    node->type == ACPI_IORT_NODE_SMMU_V3) {
> +		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
> +		    node->type == ACPI_IORT_NODE_PMCG) {
>  			*id_out = map->output_base;
>  			return parent;
>  		}
> @@ -394,6 +395,8 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>  		}
>  
>  		return smmu->id_mapping_index;
> +	case ACPI_IORT_NODE_PMCG:
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1218,14 +1221,23 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
>  	}
>  }
>  
> -static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
> +static void __init arm_smmu_v3_dma_configure(struct device *dev,
> +					     struct acpi_iort_node *node)
>  {
>  	struct acpi_iort_smmu_v3 *smmu;
> +	enum dev_dma_attr attr;
>  
>  	/* Retrieve SMMUv3 specific data */
>  	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>  
> -	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
> +	attr = (smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE) ?
> +			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> +
> +	/* We expect the dma masks to be equivalent for all SMMUv3 set-ups */
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	/* Configure DMA for the page table walker */
> +	acpi_dma_configure(dev, attr);
>  }
>  
>  #if defined(CONFIG_ACPI_NUMA)
> @@ -1301,30 +1313,82 @@ static void __init arm_smmu_init_resources(struct resource *res,
>  	}
>  }
>  
> -static bool __init arm_smmu_is_coherent(struct acpi_iort_node *node)
> +static void __init arm_smmu_dma_configure(struct device *dev,
> +					  struct acpi_iort_node *node)
>  {
>  	struct acpi_iort_smmu *smmu;
> +	enum dev_dma_attr attr;
>  
>  	/* Retrieve SMMU specific data */
>  	smmu = (struct acpi_iort_smmu *)node->node_data;
>  
> -	return smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK;
> +	attr = (smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK) ?
> +			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> +
> +	/* We expect the dma masks to be equivalent for SMMU set-ups */
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	/* Configure DMA for the page table walker */
> +	acpi_dma_configure(dev, attr);
> +}
> +
> +static int __init arm_smmu_v3_pmcg_count_resources(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_pmcg *pmcg;
> +
> +	/* Retrieve PMCG specific data */
> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +
> +	/*
> +	 * There are always 2 memory resources.
> +	 * If the overflow_gsiv is present then add that for a total of 3.
> +	 */
> +	return pmcg->overflow_gsiv ? 3 : 2;
> +}
> +
> +static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
> +						   struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_pmcg *pmcg;
> +
> +	/* Retrieve PMCG specific data */
> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +
> +	res[0].start = pmcg->page0_base_address;
> +	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
> +	res[0].flags = IORESOURCE_MEM;
> +	res[1].start = pmcg->page1_base_address;
> +	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
> +	res[1].flags = IORESOURCE_MEM;
> +
> +	if (pmcg->overflow_gsiv)
> +		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
> +				       ACPI_EDGE_SENSITIVE, &res[2]);
> +}
> +
> +static int __init arm_smmu_v3_pmcg_add_platdata(struct platform_device *pdev)
> +{
> +	u32 model = IORT_SMMU_V3_PMCG_GENERIC;
> +
> +	return platform_device_add_data(pdev, &model, sizeof(model));
>  }
>  
>  struct iort_dev_config {
>  	const char *name;
>  	int (*dev_init)(struct acpi_iort_node *node);
> -	bool (*dev_is_coherent)(struct acpi_iort_node *node);
> +	void (*dev_dma_configure)(struct device *dev,
> +				  struct acpi_iort_node *node);
>  	int (*dev_count_resources)(struct acpi_iort_node *node);
>  	void (*dev_init_resources)(struct resource *res,
>  				     struct acpi_iort_node *node);
>  	void (*dev_set_proximity)(struct device *dev,
>  				    struct acpi_iort_node *node);
> +	int (*dev_add_platdata)(struct platform_device *pdev);
>  };
>  
>  static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
>  	.name = "arm-smmu-v3",
> -	.dev_is_coherent = arm_smmu_v3_is_coherent,
> +	.dev_dma_configure = arm_smmu_v3_dma_configure,
>  	.dev_count_resources = arm_smmu_v3_count_resources,
>  	.dev_init_resources = arm_smmu_v3_init_resources,
>  	.dev_set_proximity = arm_smmu_v3_set_proximity,
> @@ -1332,9 +1396,16 @@ static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
>  
>  static const struct iort_dev_config iort_arm_smmu_cfg __initconst = {
>  	.name = "arm-smmu",
> -	.dev_is_coherent = arm_smmu_is_coherent,
> +	.dev_dma_configure = arm_smmu_dma_configure,
>  	.dev_count_resources = arm_smmu_count_resources,
> -	.dev_init_resources = arm_smmu_init_resources
> +	.dev_init_resources = arm_smmu_init_resources,
> +};
> +
> +static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
> +	.name = "arm-smmu-v3-pmcg",
> +	.dev_count_resources = arm_smmu_v3_pmcg_count_resources,
> +	.dev_init_resources = arm_smmu_v3_pmcg_init_resources,
> +	.dev_add_platdata = arm_smmu_v3_pmcg_add_platdata,
>  };
>  
>  static __init const struct iort_dev_config *iort_get_dev_cfg(
> @@ -1345,6 +1416,8 @@ static __init const struct iort_dev_config *iort_get_dev_cfg(
>  		return &iort_arm_smmu_v3_cfg;
>  	case ACPI_IORT_NODE_SMMU:
>  		return &iort_arm_smmu_cfg;
> +	case ACPI_IORT_NODE_PMCG:
> +		return &iort_arm_smmu_v3_pmcg_cfg;
>  	default:
>  		return NULL;
>  	}
> @@ -1362,7 +1435,6 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  	struct fwnode_handle *fwnode;
>  	struct platform_device *pdev;
>  	struct resource *r;
> -	enum dev_dma_attr attr;
>  	int ret, count;
>  
>  	pdev = platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
> @@ -1393,19 +1465,19 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  		goto dev_put;
>  
>  	/*
> -	 * Add a copy of IORT node pointer to platform_data to
> -	 * be used to retrieve IORT data information.
> +	 * Platform devices based on PMCG nodes uses platform_data to
> +	 * pass the hardware model info to the driver. For others, add
> +	 * a copy of IORT node pointer to platform_data to be used to
> +	 * retrieve IORT data information.
>  	 */
> -	ret = platform_device_add_data(pdev, &node, sizeof(node));
> +	if (ops->dev_add_platdata)
> +		ret = ops->dev_add_platdata(pdev);
> +	else
> +		ret = platform_device_add_data(pdev, &node, sizeof(node));
> +
>  	if (ret)
>  		goto dev_put;
>  
> -	/*
> -	 * We expect the dma masks to be equivalent for
> -	 * all SMMUs set-ups
> -	 */
> -	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> -
>  	fwnode = iort_get_fwnode(node);
>  
>  	if (!fwnode) {
> @@ -1415,11 +1487,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  
>  	pdev->dev.fwnode = fwnode;
>  
> -	attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
> -			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> -
> -	/* Configure DMA for the page table walker */
> -	acpi_dma_configure(&pdev->dev, attr);
> +	if (ops->dev_dma_configure)
> +		ops->dev_dma_configure(&pdev->dev, node);
>  
>  	iort_set_device_domain(&pdev->dev, node);
>  
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 38cd77b..832bd6a 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -26,6 +26,12 @@
>  #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
>  #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
>  
> +/*
> + * PMCG model identifiers for use in smmu pmu driver. Please note
> + * that, this is not part of the IORT specification.
> + */
> +#define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
> +
>  int iort_register_domain_token(int trans_id, phys_addr_t base,
>  			       struct fwnode_handle *fw_node);
>  void iort_deregister_domain_token(int trans_id);
> -- 
> 2.7.4
> 
> 
