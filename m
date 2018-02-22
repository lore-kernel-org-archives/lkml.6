Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932749AbeBVOEV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:04:21 -0500
Received: from foss.arm.com ([217.140.101.70]:41796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932573AbeBVOEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:04:20 -0500
Subject: Re: [PATCH] lib/dma-debug.c: fix memory leakage
To: miles.chen@mediatek.com, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <1519298540-3071-1-git-send-email-miles.chen@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6df7e9bd-2203-0692-97e4-8c6434304b0f@arm.com>
Date: Thu, 22 Feb 2018 14:04:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519298540-3071-1-git-send-email-miles.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/18 11:22, miles.chen@mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> Marty reported a memory leakage introduced by commit 3aaabbf1c39e
> ("lib/dma-debug.c: fix incorrect pfn calculation"). Fix it
> by checking the virtual address before allocating the entry.

Oops, seems I failed to look closely enough at the surrounding diff 
context when I reviewed the original patch... :(

> This patch also use virt_addr_valid() instead of virt_to_page()
> to check if a virtual address is linear.

That's an area I happen to have been looking at lately and now 
understand a lot better, so fully agreed there as well.

Acked-by: Robin Murphy <robin.murphy@arm.com>

Maybe also worth having a proper Fixes: tag instead of just naming the 
commit in prose?

Thanks,
Robin.

> Reported-by: Marty Faltesek <mfaltesek@google.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   lib/dma-debug.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index 1b34d210452c..7f5cdc1e6b29 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -1491,12 +1491,12 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
>   	if (unlikely(virt == NULL))
>   		return;
>   
> -	entry = dma_entry_alloc();
> -	if (!entry)
> +	/* handle vmalloc and linear addresses */
> +	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
>   		return;
>   
> -	/* handle vmalloc and linear addresses */
> -	if (!is_vmalloc_addr(virt) && !virt_to_page(virt))
> +	entry = dma_entry_alloc();
> +	if (!entry)
>   		return;
>   
>   	entry->type      = dma_debug_coherent;
> @@ -1528,7 +1528,7 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
>   	};
>   
>   	/* handle vmalloc and linear addresses */
> -	if (!is_vmalloc_addr(virt) && !virt_to_page(virt))
> +	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
>   		return;
>   
>   	if (is_vmalloc_addr(virt))
> 
