Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966817AbeEJRqF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:46:05 -0400
Received: from foss.arm.com ([217.140.101.70]:59396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966662AbeEJRqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:46:03 -0400
Subject: Re: [RFC][PATCH] arm64: update iomem_resource.end
To: Nicolin Chen <nicoleotsuka@gmail.com>, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        steve.capper@arm.com, kristina.martsenko@arm.com, labbott@redhat.com,
        stefan@agner.ch, akpm@linux-foundation.org, jglisse@redhat.com
References: <1525906703-28481-1-git-send-email-nicoleotsuka@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <cfb81f55-f917-431f-0afd-c97e7641a2f8@arm.com>
Date: Thu, 10 May 2018 18:45:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525906703-28481-1-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/18 23:58, Nicolin Chen wrote:
> The iomem_resource.end is -1 by default and should be updated in
> arch-level code.
> 
> ARM64 so far hasn't updated it while core kernel code (mm/hmm.c)
> started to use iomem_resource.end for boundary check. So it'd be
> better to assign iomem_resource.end using a valid value, the end
> of physical address space for example because iomem_resource.end
> in theory should reflect that.
> 
> However, VA_BITS might be smaller than PA_BITS in ARM64. So using
> the end of physical address space doesn't make a lot of sense in
> this case, or could be even harmful since virtual address cannot
> reach that memory region.

Why? There's plenty of stuff in the physical address space that will 
only ever be accessed via ioremap/memremap. There's no reason you 
shouldn't be able to run a VA_BITS < 48 kernel on a Cavium ThunderX 
where *all* the I/O is in the top half of the PA space. We already 
constrain RAM in this very function to those regions which fit into the 
linear map, and if you're accessing anything other than RAM through the 
linear map you're probably doing something wrong.

Furthermore, the physical region covered by the linear map doesn't 
necessarily start at physical address 0 anyway - see PHYS_OFFSET.

Robin.

> Furthermore, the linear region size of
> ARM64 only has the half of Virtual Memory size -- "VA_BITS - 1".
> 
> So this patch updates the iomem_resource.end by using the end of
> physical address space or the end of linear mapping region when
> (VA_BITS - 1) is smaller than PA_BITS.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   arch/arm64/mm/init.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index f48b194..22015af 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -377,6 +377,12 @@ void __init arm64_memblock_init(void)
>   	BUILD_BUG_ON(linear_region_size != BIT(VA_BITS - 1));
>   
>   	/*
> +	 * Update iomem_resource.end based on size of physical address space,
> +	 * or linear region size when (VA_BITS - 1) is smaller than PA_BITS.
> +	 */
> +	iomem_resource.end = BIT(min(PHYS_MASK_SHIFT, VA_BITS - 1)) - 1;
> +
> +	/*
>   	 * Select a suitable value for the base of physical memory.
>   	 */
>   	memstart_addr = round_down(memblock_start_of_DRAM(),
> 
