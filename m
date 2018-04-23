Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755571AbeDWQhQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:37:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43258 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754900AbeDWQhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:37:15 -0400
Subject: Re: [PATCH] iommu/iova: Update cached node pointer when current node
 fails to get any free IOVA
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: tomasz.nowicki@cavium.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
References: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c6c3655b-cef2-1112-e8a7-79c99f9ddac6@arm.com>
Date: Mon, 23 Apr 2018 17:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/18 18:12, Ganapatrao Kulkarni wrote:
> The performance drop is observed with long hours iperf testing using 40G
> cards. This is mainly due to long iterations in finding the free iova
> range in 32bit address space.
> 
> In current implementation for 64bit PCI devices, there is always first
> attempt to allocate iova from 32bit(SAC preferred over DAC) address
> range. Once we run out 32bit range, there is allocation from higher range,
> however due to cached32_node optimization it does not suppose to be
> painful. cached32_node always points to recently allocated 32-bit node.
> When address range is full, it will be pointing to last allocated node
> (leaf node), so walking rbtree to find the available range is not
> expensive affair. However this optimization does not behave well when
> one of the middle node is freed. In that case cached32_node is updated
> to point to next iova range. The next iova allocation will consume free
> range and again update cached32_node to itself. From now on, walking
> over 32-bit range is more expensive.
> 
> This patch adds fix to update cached node to leaf node when there are no
> iova free range left, which avoids unnecessary long iterations.

The only trouble with this is that "allocation failed" doesn't uniquely 
mean "space full". Say that after some time the 32-bit space ends up 
empty except for one page at 0x1000 and one at 0x80000000, then somebody 
tries to allocate 2GB. If we move the cached node down to the leftmost 
entry when that fails, all subsequent allocation attempts are now going 
to fail despite the space being 99.9999% free!

I can see a couple of ways to solve that general problem of free space 
above the cached node getting lost, but neither of them helps with the 
case where there is genuinely insufficient space (and if anything would 
make it even slower). In terms of the optimisation you want here, i.e. 
fail fast when an allocation cannot possibly succeed, the only reliable 
idea which comes to mind is free-PFN accounting. I might give that a go 
myself to see how ugly it looks.

Robin.

> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>   drivers/iommu/iova.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 83fe262..e6ee2ea 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -201,6 +201,12 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	} while (curr && new_pfn <= curr_iova->pfn_hi);
>   
>   	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> +		/* No more cached node points to free hole, update to leaf node.
> +		 */
> +		struct iova *prev_iova;
> +
> +		prev_iova = rb_entry(prev, struct iova, node);
> +		__cached_rbnode_insert_update(iovad, prev_iova);
>   		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>   		return -ENOMEM;
>   	}
> 
