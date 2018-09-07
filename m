Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5B2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5889B2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5889B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeIGUYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:24:10 -0400
Received: from foss.arm.com ([217.140.101.70]:33756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727752AbeIGUYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:24:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E69C618A;
        Fri,  7 Sep 2018 08:42:41 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2FC3F5BC;
        Fri,  7 Sep 2018 08:42:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] acpi: arm64: iort helper to find the associated
 smmu of pmcg node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        lorenzo.pieralisi@arm.com
Cc:     will.deacon@arm.com, mark.rutland@arm.com, guohanjun@huawei.com,
        john.garry@huawei.com, pabba@codeaurora.org,
        vkilari@codeaurora.org, rruigrok@codeaurora.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        neil.m.leeder@gmail.com
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <20180724114515.21764-3-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0eda98b8-cd99-1153-e6c3-3de2feca91ba@arm.com>
Date:   Fri, 7 Sep 2018 16:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724114515.21764-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/18 12:45, Shameer Kolothum wrote:
> This adds an helper to retrieve the smmuv3 dev(if any) associated
> with the PMCG node. This will be used in subsequent SMMUv3 PMU
> driver patch to name the pmu device.

As before, I think we might as well try to generalise this to the NC/RC 
case now, rather than have to redo it later once PMCGs for "external" 
TBUs become a real thing.

Robin.

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c | 84 ++++++++++++++++++++++++++++++++++++-----------
>   include/linux/acpi_iort.h |  4 +++
>   2 files changed, 69 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ac4d0d6..7940080 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -42,6 +42,7 @@ struct iort_fwnode {
>   	struct list_head list;
>   	struct acpi_iort_node *iort_node;
>   	struct fwnode_handle *fwnode;
> +	struct platform_device *pdev;
>   };
>   static LIST_HEAD(iort_fwnode_list);
>   static DEFINE_SPINLOCK(iort_fwnode_lock);
> @@ -52,12 +53,14 @@ static DEFINE_SPINLOCK(iort_fwnode_lock);
>    *
>    * @node: IORT table node associated with the IOMMU
>    * @fwnode: fwnode associated with the IORT node
> + * @pdev: platform dev associated with the IORT node if any
>    *
>    * Returns: 0 on success
>    *          <0 on failure
>    */
>   static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
> -				  struct fwnode_handle *fwnode)
> +				  struct fwnode_handle *fwnode,
> +				  struct platform_device *pdev)
>   {
>   	struct iort_fwnode *np;
>   
> @@ -69,6 +72,7 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
>   	INIT_LIST_HEAD(&np->list);
>   	np->iort_node = iort_node;
>   	np->fwnode = fwnode;
> +	np->pdev = pdev;
>   
>   	spin_lock(&iort_fwnode_lock);
>   	list_add_tail(&np->list, &iort_fwnode_list);
> @@ -78,6 +82,31 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
>   }
>   
>   /**
> + * iort_get_pdev() - Retrieve pdev associated with an IORT node
> + *
> + * @node: IORT table node to be looked-up
> + *
> + * Returns: platform dev pointer on success, NULL on failure
> + */
> +static inline struct platform_device *iort_get_pdev(
> +			struct acpi_iort_node *node)
> +{
> +	struct iort_fwnode *curr;
> +	struct platform_device *pdev = NULL;
> +
> +	spin_lock(&iort_fwnode_lock);
> +	list_for_each_entry(curr, &iort_fwnode_list, list) {
> +		if (curr->iort_node == node) {
> +			pdev = curr->pdev;
> +			break;
> +		}
> +	}
> +	spin_unlock(&iort_fwnode_lock);
> +
> +	return pdev;
> +}
> +
> +/**
>    * iort_get_fwnode() - Retrieve fwnode associated with an IORT node
>    *
>    * @node: IORT table node to be looked-up
> @@ -1347,6 +1376,32 @@ static struct acpi_iort_node *iort_find_pmcg_ref(struct acpi_iort_node *node)
>   	return ref_node;
>   }
>   
> +/**
> + * iort_find_pmcg_ref_smmu - helper to retrieve SMMUv3 associated with PMCG
> + * @dev: PMCG device
> + *
> + * Returns: smmu dev associated with the PMCG on success, NULL on failure
> + */
> +struct device *iort_find_pmcg_ref_smmu(struct device *dev)
> +{
> +	struct acpi_iort_node *node;
> +	struct acpi_iort_node *ref_node = NULL;
> +	struct platform_device *pdev = NULL;
> +
> +	node = iort_get_iort_node(dev->fwnode);
> +	if (!node || node->type != ACPI_IORT_NODE_PMCG)
> +		return NULL;
> +
> +	ref_node = iort_find_pmcg_ref(node);
> +	if (ref_node && ref_node->type == ACPI_IORT_NODE_SMMU_V3)
> +		pdev = iort_get_pdev(ref_node);
> +
> +	if (pdev)
> +		return &pdev->dev;
> +
> +	return NULL;
> +}
> +
>   struct iort_dev_config {
>   	const char *name;
>   	int (*dev_init)(struct acpi_iort_node *node);
> @@ -1453,13 +1508,14 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>   	if (ret)
>   		goto dev_put;
>   
> -	fwnode = iort_get_fwnode(node);
> -
> +	fwnode = acpi_alloc_fwnode_static();
>   	if (!fwnode) {
>   		ret = -ENODEV;
>   		goto dev_put;
>   	}
>   
> +	iort_set_fwnode(node, fwnode, pdev);
> +
>   	pdev->dev.fwnode = fwnode;
>   
>   	if (ops->dev_dma_configure) {
> @@ -1472,12 +1528,14 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>   
>   	ret = platform_device_add(pdev);
>   	if (ret)
> -		goto dma_deconfigure;
> +		goto out;
>   
>   	return 0;
>   
> -dma_deconfigure:
> +out:
>   	acpi_dma_deconfigure(&pdev->dev);
> +	iort_delete_fwnode(node);
> +	acpi_free_fwnode_static(fwnode);
>   dev_put:
>   	platform_device_put(pdev);
>   
> @@ -1519,8 +1577,7 @@ static void __init iort_init_platform_devices(void)
>   {
>   	struct acpi_iort_node *iort_node, *iort_end;
>   	struct acpi_table_iort *iort;
> -	struct fwnode_handle *fwnode;
> -	int i, ret;
> +	int i;
>   	bool acs_enabled = false;
>   	const struct iort_dev_config *ops;
>   
> @@ -1547,18 +1604,7 @@ static void __init iort_init_platform_devices(void)
>   
>   		ops = iort_get_dev_cfg(iort_node);
>   		if (ops) {
> -			fwnode = acpi_alloc_fwnode_static();
> -			if (!fwnode)
> -				return;
> -
> -			iort_set_fwnode(iort_node, fwnode);
> -
> -			ret = iort_add_platform_device(iort_node, ops);
> -			if (ret) {
> -				iort_delete_fwnode(iort_node);
> -				acpi_free_fwnode_static(fwnode);
> -				return;
> -			}
> +			iort_add_platform_device(iort_node, ops);
>   		}
>   
>   		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 38cd77b..54ccff2 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -36,6 +36,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id);
>   struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
>   void acpi_configure_pmsi_domain(struct device *dev);
>   int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
> +struct device *iort_find_pmcg_ref_smmu(struct device *dev);
>   /* IOMMU interface */
>   void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
>   const struct iommu_ops *iort_iommu_configure(struct device *dev);
> @@ -48,6 +49,9 @@ static inline struct irq_domain *iort_get_device_domain(struct device *dev,
>   							u32 req_id)
>   { return NULL; }
>   static inline void acpi_configure_pmsi_domain(struct device *dev) { }
> +static inline
> +struct device *iort_find_pmcg_ref_smmu(struct device *dev)
> +{ return NULL; }
>   /* IOMMU interface */
>   static inline void iort_dma_setup(struct device *dev, u64 *dma_addr,
>   				  u64 *size) { }
> 
