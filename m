Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FB4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BE5207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BE5207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbeJXFpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:45:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37686 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXFpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:45:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NLKPOK124531;
        Tue, 23 Oct 2018 16:20:25 -0500
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NLKPQP106968
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 16:20:25 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 16:20:24 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 16:20:24 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NLKOHb031085;
        Tue, 23 Oct 2018 16:20:24 -0500
Subject: Re: [PATCH v4 08/17] remoteproc: add alloc ops in rproc_mem_entry
 struct
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-9-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <c12a887d-8d26-5813-2fa7-8156cf84c4b4@ti.com>
Date:   Tue, 23 Oct 2018 16:20:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1532697292-14272-9-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On 7/27/18 8:14 AM, Loic Pallardy wrote:
> Memory entry could be allocated in different ways (ioremap,
> dma_alloc_coherent, internal RAM allocator...).
> This patch introduces an alloc ops in rproc_mem_entry structure
> to associate dedicated allocation mechanism to each memory entry
> descriptor in order to do remote core agnostic from memory allocators.
> 
> The introduction of this ops allows to perform allocation of all registered
> carveout at the same time, just before calling rproc_start().
> It simplifies and makes uniform carveout management whatever origin.

This patch is causing a kernel crash with trace entries. Please see
further below for the cause.

> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 261 ++++++++++++++++++++++-------------
>  include/linux/remoteproc.h           |   7 +
>  2 files changed, 175 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 77b39ba..2c51549 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -642,74 +642,31 @@ static int rproc_handle_devmem(struct rproc *rproc, struct fw_rsc_devmem *rsc,
>  }
>  
>  /**
> - * rproc_release_carveout() - release acquired carveout
> + * rproc_alloc_carveout() - allocated specified carveout
>   * @rproc: rproc handle
> - * @mem: the memory entry to release
> - *
> - * This function releases specified memory entry @mem allocated via
> - * dma_alloc_coherent() function by @rproc.
> - */
> -static int rproc_release_carveout(struct rproc *rproc,
> -				  struct rproc_mem_entry *mem)
> -{
> -	struct device *dev = &rproc->dev;
> -
> -	/* clean up carveout allocations */
> -	dma_free_coherent(dev->parent, mem->len, mem->va, mem->dma);
> -	return 0;
> -}
> -
> -/**
> - * rproc_handle_carveout() - handle phys contig memory allocation requests
> - * @rproc: rproc handle
> - * @rsc: the resource entry
> - * @avail: size of available data (for image validation)
> - *
> - * This function will handle firmware requests for allocation of physically
> - * contiguous memory regions.
> - *
> - * These request entries should come first in the firmware's resource table,
> - * as other firmware entries might request placing other data objects inside
> - * these memory regions (e.g. data/code segments, trace resource entries, ...).
> + * @mem: the memory entry to allocate
>   *
> - * Allocating memory this way helps utilizing the reserved physical memory
> - * (e.g. CMA) more efficiently, and also minimizes the number of TLB entries
> - * needed to map it (in case @rproc is using an IOMMU). Reducing the TLB
> - * pressure is important; it may have a substantial impact on performance.
> + * This function allocate specified memory entry @mem using
> + * dma_alloc_coherent() as default allocator
>   */
> -static int rproc_handle_carveout(struct rproc *rproc,
> -				 struct fw_rsc_carveout *rsc,
> -				 int offset, int avail)
> +static int rproc_alloc_carveout(struct rproc *rproc,
> +				struct rproc_mem_entry *mem)
>  {
> -	struct rproc_mem_entry *carveout, *mapping = NULL;
> +	struct rproc_mem_entry *mapping = NULL;
>  	struct device *dev = &rproc->dev;
>  	dma_addr_t dma;
>  	void *va;
>  	int ret;
>  
> -	if (sizeof(*rsc) > avail) {
> -		dev_err(dev, "carveout rsc is truncated\n");
> -		return -EINVAL;
> -	}
> -
> -	/* make sure reserved bytes are zeroes */
> -	if (rsc->reserved) {
> -		dev_err(dev, "carveout rsc has non zero reserved bytes\n");
> -		return -EINVAL;
> -	}
> -
> -	dev_dbg(dev, "carveout rsc: name: %s, da 0x%x, pa 0x%x, len 0x%x, flags 0x%x\n",
> -		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
> -
> -	va = dma_alloc_coherent(dev->parent, rsc->len, &dma, GFP_KERNEL);
> +	va = dma_alloc_coherent(dev->parent, mem->len, &dma, GFP_KERNEL);
>  	if (!va) {
>  		dev_err(dev->parent,
> -			"failed to allocate dma memory: len 0x%x\n", rsc->len);
> +			"failed to allocate dma memory: len 0x%x\n", mem->len);
>  		return -ENOMEM;
>  	}
>  
>  	dev_dbg(dev, "carveout va %pK, dma %pad, len 0x%x\n",
> -		va, &dma, rsc->len);
> +		va, &dma, mem->len);
>  
>  	/*
>  	 * Ok, this is non-standard.
> @@ -729,22 +686,22 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  	 * physical address in this case.
>  	 */
>  
> -	if (rsc->da != FW_RSC_ADDR_ANY && !rproc->domain) {
> -		dev_err(dev->parent,
> -			"Bad carveout rsc configuration\n");
> -		ret = -ENOMEM;
> -		goto dma_free;
> -	}
> +	if (mem->da != FW_RSC_ADDR_ANY) {
> +		if (!rproc->domain) {
> +			dev_err(dev->parent,
> +				"Bad carveout rsc configuration\n");
> +			ret = -ENOMEM;
> +			goto dma_free;
> +		}

Same comment from Patch 1.

>  
> -	if (rsc->da != FW_RSC_ADDR_ANY && rproc->domain) {
>  		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
>  		if (!mapping) {
>  			ret = -ENOMEM;
>  			goto dma_free;
>  		}
>  
> -		ret = iommu_map(rproc->domain, rsc->da, dma, rsc->len,
> -				rsc->flags);
> +		ret = iommu_map(rproc->domain, mem->da, dma, mem->len,
> +				mem->flags);
>  		if (ret) {
>  			dev_err(dev, "iommu_map failed: %d\n", ret);
>  			goto free_mapping;
> @@ -757,52 +714,102 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  		 * We can't trust the remote processor not to change the
>  		 * resource table, so we must maintain this info independently.
>  		 */
> -		mapping->da = rsc->da;
> -		mapping->len = rsc->len;
> +		mapping->da = mem->da;
> +		mapping->len = mem->len;
>  		list_add_tail(&mapping->node, &rproc->mappings);
>  
>  		dev_dbg(dev, "carveout mapped 0x%x to %pad\n",
> -			rsc->da, &dma);
> +			mem->da, &dma);
> +	} else {
> +		mem->da = (u32)dma;

Hmm, what was the purpose of this? So, this appears to be handling the
missing implementation for the comment in the fw_rsc_carveout about
FW_RSC_ADDR_ANY.

>  	}
>  
> -	/*
> -	 * Some remote processors might need to know the pa
> -	 * even though they are behind an IOMMU. E.g., OMAP4's
> -	 * remote M3 processor needs this so it can control
> -	 * on-chip hardware accelerators that are not behind
> -	 * the IOMMU, and therefor must know the pa.
> -	 *
> -	 * Generally we don't want to expose physical addresses
> -	 * if we don't have to (remote processors are generally
> -	 * _not_ trusted), so we might want to do this only for
> -	 * remote processor that _must_ have this (e.g. OMAP4's
> -	 * dual M3 subsystem).
> -	 *
> -	 * Non-IOMMU processors might also want to have this info.
> -	 * In this case, the device address and the physical address
> -	 * are the same.
> -	 */
> -	rsc->pa = (u32)rproc_va_to_pa(va);
> -
> -	carveout = rproc_mem_entry_init(dev, va, dma, rsc->len, rsc->da,
> -					rproc_release_carveout, rsc->name);
> -	if (!carveout)
> -		goto free_carv;
> -
> -	rproc_add_carveout(rproc, carveout);
> +	mem->dma = (u32)dma;

We don't need the typecast, mem->dma is already of type dma_addr_t. Same
comment above on the else part as well.

> +	mem->va = va;
>  
>  	return 0;
>  
> -free_carv:
> -	kfree(carveout);
>  free_mapping:
>  	kfree(mapping);
>  dma_free:
> -	dma_free_coherent(dev->parent, rsc->len, va, dma);
> +	dma_free_coherent(dev->parent, mem->len, va, dma);
>  	return ret;
>  }
>  
>  /**
> + * rproc_release_carveout() - release acquired carveout
> + * @rproc: rproc handle
> + * @mem: the memory entry to release
> + *
> + * This function releases specified memory entry @mem allocated via
> + * rproc_alloc_carveout() function by @rproc.
> + */
> +static int rproc_release_carveout(struct rproc *rproc,
> +				  struct rproc_mem_entry *mem)
> +{
> +	struct device *dev = &rproc->dev;
> +
> +	/* clean up carveout allocations */
> +	dma_free_coherent(dev->parent, mem->len, mem->va, mem->dma);
> +	return 0;
> +}
> +
> +/**
> + * rproc_handle_carveout() - handle phys contig memory allocation requests
> + * @rproc: rproc handle
> + * @rsc: the resource entry
> + * @avail: size of available data (for image validation)
> + *
> + * This function will handle firmware requests for allocation of physically
> + * contiguous memory regions.
> + *
> + * These request entries should come first in the firmware's resource table,
> + * as other firmware entries might request placing other data objects inside
> + * these memory regions (e.g. data/code segments, trace resource entries, ...).
> + *
> + * Allocating memory this way helps utilizing the reserved physical memory
> + * (e.g. CMA) more efficiently, and also minimizes the number of TLB entries
> + * needed to map it (in case @rproc is using an IOMMU). Reducing the TLB
> + * pressure is important; it may have a substantial impact on performance.
> + */
> +static int rproc_handle_carveout(struct rproc *rproc,
> +				 struct fw_rsc_carveout *rsc,
> +				 int offset, int avail)
> +{
> +	struct rproc_mem_entry *carveout;
> +	struct device *dev = &rproc->dev;
> +
> +	if (sizeof(*rsc) > avail) {
> +		dev_err(dev, "carveout rsc is truncated\n");
> +		return -EINVAL;
> +	}
> +
> +	/* make sure reserved bytes are zeroes */
> +	if (rsc->reserved) {
> +		dev_err(dev, "carveout rsc has non zero reserved bytes\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "carveout rsc: name: %s, da 0x%x, pa 0x%x, len 0x%x, flags 0x%x\n",
> +		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
> +
> +	/* Register carveout in in list */
> +	carveout = rproc_mem_entry_init(dev, 0, 0, rsc->len, rsc->da,
> +					rproc_alloc_carveout,
> +					rproc_release_carveout, rsc->name);
> +	if (!carveout) {
> +		dev_err(dev, "Can't allocate memory entry structure\n");
> +		return -ENOMEM;
> +	}
> +
> +	carveout->flags = rsc->flags;
> +	carveout->rsc_offset = offset;
> +	rproc_add_carveout(rproc, carveout);

Once we get rid of rproc_add_carveout, the list addition will mostly be
handled in rproc_mem_entry_init itself.

> +
> +	return 0;
> +}
> +
> +/**
>   * rproc_add_carveout() - register an allocated carveout region
>   * @rproc: rproc handle
>   * @mem: memory entry to register
> @@ -832,6 +839,7 @@ void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
>  struct rproc_mem_entry *
>  rproc_mem_entry_init(struct device *dev,
>  		     void *va, dma_addr_t dma, int len, u32 da,
> +		     int (*alloc)(struct rproc *, struct rproc_mem_entry *),
>  		     int (*release)(struct rproc *, struct rproc_mem_entry *),
>  		     const char *name, ...)
>  {
> @@ -846,7 +854,9 @@ struct rproc_mem_entry *
>  	mem->dma = dma;
>  	mem->da = da;
>  	mem->len = len;
> +	mem->alloc = alloc;
>  	mem->release = release;
> +	mem->rsc_offset = FW_RSC_ADDR_ANY;
>  
>  	va_start(args, name);
>  	vsnprintf(mem->name, sizeof(mem->name), name, args);
> @@ -978,6 +988,63 @@ static void rproc_unprepare_subdevices(struct rproc *rproc)
>  }
>  
>  /**
> + * rproc_alloc_registered_carveouts() - allocate all carveouts registered
> + * in the list
> + * @rproc: the remote processor handle
> + *
> + * This function parses registered carveout list, performs allocation
> + * if alloc() ops registered and updates resource table information
> + * if rsc_offset set.
> + *
> + * Return: 0 on success
> + */
> +static int rproc_alloc_registered_carveouts(struct rproc *rproc)
> +{
> +	struct rproc_mem_entry *entry, *tmp;
> +	struct fw_rsc_carveout *rsc;
> +	struct device *dev = &rproc->dev;
> +	int ret;
> +
> +	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
> +		if (entry->alloc) {
> +			ret = entry->alloc(rproc, entry);
> +			if (ret) {
> +				dev_err(dev, "Unable to allocate carveout %s: %d\n",
> +					entry->name, ret);
> +				return -ENOMEM;
> +			}
> +		}
> +
> +		if (entry->rsc_offset != FW_RSC_ADDR_ANY) {
> +			/* update resource table */
> +			rsc = (void *)rproc->table_ptr + entry->rsc_offset;
> +
> +			/*
> +			 * Some remote processors might need to know the pa
> +			 * even though they are behind an IOMMU. E.g., OMAP4's
> +			 * remote M3 processor needs this so it can control
> +			 * on-chip hardware accelerators that are not behind
> +			 * the IOMMU, and therefor must know the pa.
> +			 *
> +			 * Generally we don't want to expose physical addresses
> +			 * if we don't have to (remote processors are generally
> +			 * _not_ trusted), so we might want to do this only for
> +			 * remote processor that _must_ have this (e.g. OMAP4's
> +			 * dual M3 subsystem).
> +			 *
> +			 * Non-IOMMU processors might also want to have this info.
> +			 * In this case, the device address and the physical address
> +			 * are the same.
> +			 */
> +			if (entry->va)
> +				rsc->pa = (u32)rproc_va_to_pa(entry->va);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
>   * rproc_coredump_cleanup() - clean up dump_segments list
>   * @rproc: the remote processor handle
>   */
> @@ -1148,6 +1215,14 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  		goto clean_up_resources;
>  	}
>  
> +	/* Allocate carveout resources associated to rproc */
> +	ret = rproc_alloc_registered_carveouts(rproc);
> +	if (ret) {
> +		dev_err(dev, "Failed to allocate associated carveouts: %d\n",
> +			ret);
> +		goto clean_up_resources;
> +	}

This is causing an issue with RSC_TRACE on where the trace region on the
remote processor is actually backed by a DDR carveout address. The
allocations are now being done after processing the resources from the
rproc_loading_handlers, which causes the RSC_TRACE to be configured with
an incorrect kernel va, and accessing it through debugfs then results in
a kernel crash.

regards
Suman

> +
>  	ret = rproc_start(rproc, fw);
>  	if (ret)
>  		goto clean_up_resources;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 55f30fc..ea95b04 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -317,6 +317,9 @@ struct fw_rsc_vdev {
>   * @priv: associated data
>   * @name: associated memory region name (optional)
>   * @node: list node
> + * @rsc_offset: offset in resource table
> + * @flags: iommu protection flags
> + * @alloc: specific memory allocator function
>   */
>  struct rproc_mem_entry {
>  	void *va;
> @@ -326,6 +329,9 @@ struct rproc_mem_entry {
>  	void *priv;
>  	char name[32];
>  	struct list_head node;
> +	u32 rsc_offset;
> +	u32 flags;
> +	int (*alloc)(struct rproc *rproc, struct rproc_mem_entry *mem);
>  	int (*release)(struct rproc *rproc, struct rproc_mem_entry *mem);
>  };
>  
> @@ -563,6 +569,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  struct rproc_mem_entry *
>  rproc_mem_entry_init(struct device *dev,
>  		     void *va, dma_addr_t dma, int len, u32 da,
> +		     int (*alloc)(struct rproc *, struct rproc_mem_entry *),
>  		     int (*release)(struct rproc *, struct rproc_mem_entry *),
>  		     const char *name, ...);
>  
> 

