Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965119AbeBMOSX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:18:23 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:42663 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964950AbeBMOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:18:21 -0500
Subject: Re: [PATCH v2 13/15] MIPS: memblock: Discard bootmem from Loongson3
 code
To: Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <miodrag.dinic@mips.com>, <jhogan@kernel.org>, <goran.ferenc@mips.com>,
        <david.daney@cavium.com>, <paul.gortmaker@windriver.com>,
        <paul.burton@mips.com>, <alex.belits@cavium.com>,
        <Steven.Hill@cavium.com>
CC: <alexander.sverdlin@nokia.com>, <kumba@gentoo.org>,
        <marcin.nowakowski@mips.com>, <James.hogan@mips.com>,
        <Peter.Wotton@mips.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
 <20180202035458.30456-14-fancer.lancer@gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <65660251-bc25-c676-b08c-5168885faf5d@mips.com>
Date: Tue, 13 Feb 2018 14:09:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180202035458.30456-14-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518531291-298552-26922-43867-3
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189978
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On 02/02/18 03:54, Serge Semin wrote:
> Loongson64/3 runs its own code to initialize memory allocator in
> case of NUMA configuration is selected. So in order to move to the
> pure memblock utilization we discard the bootmem allocator usage
> and insert the memblock reservation method for kernel/addrspace_offset
> memory regions.
> 

I don't have a NUMA Loongson to test with, but on a non-NUMA Loongson3 
machine, tested as a part of the whole series, this works and looks good 
to me.

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Matt


> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   arch/mips/loongson64/loongson-3/numa.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
> index f17ef520799a..2f1ebf496c17 100644
> --- a/arch/mips/loongson64/loongson-3/numa.c
> +++ b/arch/mips/loongson64/loongson-3/numa.c
> @@ -180,7 +180,6 @@ static void __init szmem(unsigned int node)
>   
>   static void __init node_mem_init(unsigned int node)
>   {
> -	unsigned long bootmap_size;
>   	unsigned long node_addrspace_offset;
>   	unsigned long start_pfn, end_pfn, freepfn;
>   
> @@ -197,26 +196,21 @@ static void __init node_mem_init(unsigned int node)
>   
>   	__node_data[node] = prealloc__node_data + node;
>   
> -	NODE_DATA(node)->bdata = &bootmem_node_data[node];
>   	NODE_DATA(node)->node_start_pfn = start_pfn;
>   	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
>   
> -	bootmap_size = init_bootmem_node(NODE_DATA(node), freepfn,
> -					start_pfn, end_pfn);
>   	free_bootmem_with_active_regions(node, end_pfn);
>   	if (node == 0) /* used by finalize_initrd() */
>   		max_low_pfn = end_pfn;
>   
> -	/* This is reserved for the kernel and bdata->node_bootmem_map */
> -	reserve_bootmem_node(NODE_DATA(node), start_pfn << PAGE_SHIFT,
> -		((freepfn - start_pfn) << PAGE_SHIFT) + bootmap_size,
> -		BOOTMEM_DEFAULT);
> +	/* This is reserved for the kernel only */
> +	if (node == 0)
> +		memblock_reserve(start_pfn << PAGE_SHIFT,
> +			((freepfn - start_pfn) << PAGE_SHIFT));
>   
>   	if (node == 0 && node_end_pfn(0) >= (0xffffffff >> PAGE_SHIFT)) {
>   		/* Reserve 0xfe000000~0xffffffff for RS780E integrated GPU */
> -		reserve_bootmem_node(NODE_DATA(node),
> -				(node_addrspace_offset | 0xfe000000),
> -				32 << 20, BOOTMEM_DEFAULT);
> +		memblock_reserve(node_addrspace_offset | 0xfe000000, 32 << 20);
>   	}
>   
>   	sparse_memory_present_with_active_regions(node);
> 
