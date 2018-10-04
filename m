Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232F6C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D476F2083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D476F2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJDXhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:37:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40068 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbeJDXhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B22917A9;
        Thu,  4 Oct 2018 09:43:15 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AFEE3F5B3;
        Thu,  4 Oct 2018 09:43:12 -0700 (PDT)
Date:   Thu, 4 Oct 2018 17:43:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        guohanjun@huawei.com, john.garry@huawei.com, pabba@codeaurora.org,
        vkilari@codeaurora.org, rruigrok@codeaurora.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        neil.m.leeder@gmail.com
Subject: Re: [PATCH v3 1/3] acpi: arm64: add iort support for PMCG
Message-ID: <20181004164356.GA16278@red-moon>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150803.25444-2-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 04:08:01PM +0100, Shameer Kolothum wrote:
> From: Neil Leeder <nleeder@codeaurora.org>
> 
> Add support for the SMMU Performance Monitor Counter Group
> information from ACPI. This is in preparation for its use
> in the SMMUv3 PMU driver.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 78 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 66 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 08f26db..b979c86 100644
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
> @@ -1309,6 +1312,50 @@ static bool __init arm_smmu_is_coherent(struct acpi_iort_node *node)
>  	return smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK;
>  }
>  
> +static void __init arm_smmu_common_dma_configure(struct device *dev,
> +						enum dev_dma_attr attr)
> +{
> +	/* We expect the dma masks to be equivalent for all SMMUs set-ups */
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	/* Configure DMA for the page table walker */
> +	acpi_dma_configure(dev, attr);
> +}

It looks like we can't get rid of this acpi_dma_configure() call
given that the platform device we create has no ACPI companion
(and I am not looking forward to fabricating one to make the
code homogeneous :)).

Still, having two methods per IORT node type (dev_is_coherent() and
dev_dma_configure()) does not make much sense, we can merge it into one
I think.

Thanks,
Lorenzo

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
> +					       struct acpi_iort_node *node)
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
>  struct iort_dev_config {
>  	const char *name;
>  	int (*dev_init)(struct acpi_iort_node *node);
> @@ -1318,6 +1365,8 @@ struct iort_dev_config {
>  				     struct acpi_iort_node *node);
>  	void (*dev_set_proximity)(struct device *dev,
>  				    struct acpi_iort_node *node);
> +	void (*dev_dma_configure)(struct device *dev,
> +					enum dev_dma_attr attr);
>  };
>  
>  static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
> @@ -1326,23 +1375,34 @@ static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
>  	.dev_count_resources = arm_smmu_v3_count_resources,
>  	.dev_init_resources = arm_smmu_v3_init_resources,
>  	.dev_set_proximity = arm_smmu_v3_set_proximity,
> +	.dev_dma_configure = arm_smmu_common_dma_configure,
>  };
>  
>  static const struct iort_dev_config iort_arm_smmu_cfg __initconst = {
>  	.name = "arm-smmu",
>  	.dev_is_coherent = arm_smmu_is_coherent,
>  	.dev_count_resources = arm_smmu_count_resources,
> -	.dev_init_resources = arm_smmu_init_resources
> +	.dev_init_resources = arm_smmu_init_resources,
> +	.dev_dma_configure = arm_smmu_common_dma_configure,
> +};
> +
> +static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
> +	.name = "arm-smmu-v3-pmu",
> +	.dev_count_resources = arm_smmu_v3_pmcg_count_resources,
> +	.dev_init_resources = arm_smmu_v3_pmcg_init_resources,
>  };
>  
>  static __init const struct iort_dev_config *iort_get_dev_cfg(
>  			struct acpi_iort_node *node)
>  {
> +
>  	switch (node->type) {
>  	case ACPI_IORT_NODE_SMMU_V3:
>  		return &iort_arm_smmu_v3_cfg;
>  	case ACPI_IORT_NODE_SMMU:
>  		return &iort_arm_smmu_cfg;
> +	case ACPI_IORT_NODE_PMCG:
> +		return &iort_arm_smmu_v3_pmcg_cfg;
>  	default:
>  		return NULL;
>  	}
> @@ -1398,12 +1458,6 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
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
> @@ -1413,11 +1467,11 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  
>  	pdev->dev.fwnode = fwnode;
>  
> -	attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
> +	if (ops->dev_dma_configure) {
> +		attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
>  			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> -
> -	/* Configure DMA for the page table walker */
> -	acpi_dma_configure(&pdev->dev, attr);
> +		ops->dev_dma_configure(&pdev->dev, attr);
> +	}
>  
>  	iort_set_device_domain(&pdev->dev, node);
>  
> -- 
> 2.7.4
> 
> 
