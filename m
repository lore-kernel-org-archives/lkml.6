Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98672C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6249D213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6249D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeK3FRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:17:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbeK3FRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:17:40 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wATI4Kur119629
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:11:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p2jn57tqu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:11:25 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 29 Nov 2018 18:11:22 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Nov 2018 18:11:18 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wATIBHMa50725060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 18:11:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFF69A4053;
        Thu, 29 Nov 2018 18:11:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDE26A4051;
        Thu, 29 Nov 2018 18:11:16 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.201])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Nov 2018 18:11:16 +0000 (GMT)
Date:   Thu, 29 Nov 2018 20:11:15 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Qian Cai <cai@gmx.us>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        mhocko@suse.com, rppt@linux.ibm.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memblock: skip kmemleak for kasan_init()
References: <1543442925-17794-1-git-send-email-cai@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543442925-17794-1-git-send-email-cai@gmx.us>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18112918-0028-0000-0000-000003237AE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112918-0029-0000-0000-000023DF8CC5
Message-Id: <20181129181114.GB4295@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 05:08:45PM -0500, Qian Cai wrote:
> Kmemleak does not play well with KASAN (tested on both HPE Apollo 70 and
> Huawei TaiShan 2280 aarch64 servers).
> 
> After calling start_kernel()->setup_arch()->kasan_init(), kmemleak early
> log buffer went from something like 280 to 260000 which caused kmemleak
> disabled and crash dump memory reservation failed. The multitude of
> kmemleak_alloc() calls is from nested loops while KASAN is setting up
> full memory mappings, so let early kmemleak allocations skip those
> memblock_alloc_internal() calls came from kasan_init() given that those
> early KASAN memory mappings should not reference to other memory.
> Hence, no kmemleak false positives.
> 
> kasan_init
>   kasan_map_populate [1]
>     kasan_pgd_populate [2]
>       kasan_pud_populate [3]
>         kasan_pmd_populate [4]
>           kasan_pte_populate [5]
>             kasan_alloc_zeroed_page
>               memblock_alloc_try_nid
>                 memblock_alloc_internal
>                   kmemleak_alloc
> 
> [1] for_each_memblock(memory, reg)
> [2] while (pgdp++, addr = next, addr != end)
> [3] while (pudp++, addr = next, addr != end && pud_none(READ_ONCE(*pudp)))
> [4] while (pmdp++, addr = next, addr != end && pmd_none(READ_ONCE(*pmdp)))
> [5] while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)))
> 
> Signed-off-by: Qian Cai <cai@gmx.us>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com> # memblock parts

> ---
> 
> Changes since v1:
> * only skip memblock_alloc_internal() calls came from kasan_int().
> 
>  arch/arm64/mm/kasan_init.c |  2 +-
>  include/linux/memblock.h   |  1 +
>  mm/memblock.c              | 19 +++++++++++--------
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 63527e5..fcb2ca3 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -39,7 +39,7 @@ static phys_addr_t __init kasan_alloc_zeroed_page(int node)
>  {
>  	void *p = memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
>  					      __pa(MAX_DMA_ADDRESS),
> -					      MEMBLOCK_ALLOC_ACCESSIBLE, node);
> +					      MEMBLOCK_ALLOC_KASAN, node);
>  	return __pa(p);
>  }
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index aee299a..3ef3086 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -320,6 +320,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>  /* Flags for memblock allocation APIs */
>  #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
>  #define MEMBLOCK_ALLOC_ACCESSIBLE	0
> +#define MEMBLOCK_ALLOC_KASAN		1
> 
>  /* We are using top down, so it is safe to use 0 here */
>  #define MEMBLOCK_LOW_LIMIT 0
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 9a2d5ae..abb9f7f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -262,7 +262,8 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
>  	phys_addr_t kernel_end, ret;
> 
>  	/* pump up @end */
> -	if (end == MEMBLOCK_ALLOC_ACCESSIBLE)
> +	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
> +	    end == MEMBLOCK_ALLOC_KASAN)
>  		end = memblock.current_limit;
> 
>  	/* avoid allocating the first page */
> @@ -1412,13 +1413,15 @@ static void * __init memblock_alloc_internal(
>  done:
>  	ptr = phys_to_virt(alloc);
> 
> -	/*
> -	 * The min_count is set to 0 so that bootmem allocated blocks
> -	 * are never reported as leaks. This is because many of these blocks
> -	 * are only referred via the physical address which is not
> -	 * looked up by kmemleak.
> -	 */
> -	kmemleak_alloc(ptr, size, 0, 0);
> +	/* Skip kmemleak for kasan_init() due to high volume. */
> +	if (max_addr != MEMBLOCK_ALLOC_KASAN)
> +		/*
> +		 * The min_count is set to 0 so that bootmem allocated
> +		 * blocks are never reported as leaks. This is because many
> +		 * of these blocks are only referred via the physical
> +		 * address which is not looked up by kmemleak.
> +		 */
> +		kmemleak_alloc(ptr, size, 0, 0);
> 
>  	return ptr;
>  }
> -- 
> 1.8.3.1
> 

-- 
Sincerely yours,
Mike.

