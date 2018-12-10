Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E35C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92842082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92842082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeLJUAV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:00:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:29399 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbeLJUAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:00:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 12:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="97676935"
Received: from schen9-mobl3.jf.intel.com ([10.24.9.33])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2018 12:00:17 -0800
Subject: Re: [PATCH v2 1/2] swiotlb: add debugfs to track swiotlb buffer usage
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joe.jin@oracle.com
References: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <41becd27-8c3a-da2b-e5ed-e361ba20e4d4@linux.intel.com>
Date:   Mon, 10 Dec 2018 12:00:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 12/9/18 4:37 PM, Dongli Zhang wrote:

> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 045930e..3979c2c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -35,6 +35,9 @@
>  #include <linux/scatterlist.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/set_memory.h>
> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/debugfs.h>
> +#endif

Seems like #ifdef CONFIG_DEBUG_FS is better located inside debugfs.h,
instead of requiring every file that includes it
to have a #ifdef CONFIG_DEBUG_FS.

>  
>  #include <asm/io.h>
>  #include <asm/dma.h>
> @@ -73,6 +76,13 @@ static phys_addr_t io_tlb_start, io_tlb_end;
>   */
>  static unsigned long io_tlb_nslabs;
>  
> +#ifdef CONFIG_DEBUG_FS
> +/*
> + * The number of used IO TLB block
> + */
> +static unsigned long io_tlb_used;
> +#endif
> +
>  /*
>   * This is a free list describing the number of free entries available from
>   * each index
> @@ -528,6 +538,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>  	return SWIOTLB_MAP_ERROR;
>  found:
> +#ifdef CONFIG_DEBUG_FS
> +	io_tlb_used += nslots;
> +#endif

One nit I have about this patch is there are too many CONFIG_DEBUG_FS.

For example here, instead of io_tlb_used, we can have a macro defined,
perhaps something like inc_iotlb_used(nslots).  It can be placed in the
same section that swiotlb_create_debugfs is defined so there's a single
place where all the CONFIG_DEBUG_FS stuff is located.

Then define inc_iotlb_used to be null when we don't have
CONFIG_DEBUG_FS.

>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  
>  	/*
> @@ -588,6 +601,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>  		 */
>  		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
>  			io_tlb_list[i] = ++count;
> +
> +#ifdef CONFIG_DEBUG_FS
> +		io_tlb_used -= nslots;
> +#endif
>  	}
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  }
> @@ -883,3 +900,36 @@ const struct dma_map_ops swiotlb_dma_ops = {
>  	.dma_supported		= dma_direct_supported,
>  };
>  EXPORT_SYMBOL(swiotlb_dma_ops);
> +
> +#ifdef CONFIG_DEBUG_FS
> +

Maybe move io_tlb_used definition here and define
inc_iotlb_used here.

> +static int __init swiotlb_create_debugfs(void)
> +{
> +	static struct dentry *d_swiotlb_usage;
> +	struct dentry *ent;
> +
> +	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);
> +
> +	if (!d_swiotlb_usage)
> +		return -ENOMEM;
> +
> +	ent = debugfs_create_ulong("io_tlb_nslabs", 0400,
> +				   d_swiotlb_usage, &io_tlb_nslabs);
> +	if (!ent)
> +		goto fail;
> +
> +	ent = debugfs_create_ulong("io_tlb_used", 0400,
> +				    d_swiotlb_usage, &io_tlb_used);
> +	if (!ent)
> +		goto fail;
> +
> +	return 0;
> +
> +fail:
> +	debugfs_remove_recursive(d_swiotlb_usage);
> +	return -ENOMEM;
> +}
> +
> +late_initcall(swiotlb_create_debugfs);
> +
> +#endif
> 

Thanks.

Tim

