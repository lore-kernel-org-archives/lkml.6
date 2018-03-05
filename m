Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933833AbeCEJqZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:46:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933048AbeCEJqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:46:23 -0500
Date: Mon, 5 Mar 2018 10:46:02 +0100
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>, Vineet Gupta <vgupta@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>, Ralf Baechle <ralf@linux-mips.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH -V2 -mm] mm: Fix races between swapoff and flush dcache
References: <20180305083634.15174-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305083634.15174-1-ying.huang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18030509-0040-0000-0000-0000041AD534
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030509-0041-0000-0000-0000261DE349
Message-Id: <20180305094601.GA25231@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803050116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 04:36:34PM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> From commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB
> trunks") on, after swapoff, the address_space associated with the swap
> device will be freed.  So page_mapping() users which may touch the
> address_space need some kind of mechanism to prevent the address_space
> from being freed during accessing.
> 
> The dcache flushing functions (flush_dcache_page(), etc) in
> architecture specific code may access the address_space of swap device
> for anonymous pages in swap cache via page_mapping() function.  But in
> some cases there are no mechanisms to prevent the swap device from
> being swapoff, for example,
> 
> CPU1					CPU2
> __get_user_pages()			swapoff()
>   flush_dcache_page()
>     mapping = page_mapping()
>       ...				  exit_swap_address_space()
>       ...				    kvfree(spaces)
>       mapping_mapped(mapping)
> 
> The address space may be accessed after being freed.
> 
> But from cachetlb.txt and Russell King, flush_dcache_page() only care
> about file cache pages, for anonymous pages, flush_anon_page() should
> be used.  The implementation of flush_dcache_page() in all
> architectures follows this too.  They will check whether
> page_mapping() is NULL and whether mapping_mapped() is true to
> determine whether to flush the dcache immediately.  And they will use
> interval tree (mapping->i_mmap) to find all user space mappings.
> While mapping_mapped() and mapping->i_mmap isn't used by anonymous
> pages in swap cache at all.
> 
> So, to fix the race between swapoff and flush dcache, __page_mapping()
> is add to return the address_space for file cache pages and NULL
> otherwise.  All page_mapping() invoking in flush dcache functions are
> replaced with __page_mapping().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Chen Liqin <liqin.linux@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> 
> Changes:
> 
> v2:
> 
> - Rename __page_mapping() to page_mapping_file() and simplified
>   implementation as suggested by Andrew Morton.
> ---
>  arch/arc/mm/cache.c           |  2 +-
>  arch/arm/mm/copypage-v4mc.c   |  2 +-
>  arch/arm/mm/copypage-v6.c     |  2 +-
>  arch/arm/mm/copypage-xscale.c |  2 +-
>  arch/arm/mm/fault-armv.c      |  2 +-
>  arch/arm/mm/flush.c           |  6 +++---
>  arch/mips/mm/cache.c          |  2 +-
>  arch/nios2/mm/cacheflush.c    |  4 ++--
>  arch/parisc/kernel/cache.c    |  5 +++--
>  arch/score/mm/cache.c         |  5 +++--
>  arch/sh/mm/cache-sh4.c        |  2 +-
>  arch/sh/mm/cache-sh7705.c     |  2 +-
>  arch/sparc/kernel/smp_64.c    |  8 ++++----
>  arch/sparc/mm/init_64.c       |  6 +++---
>  arch/sparc/mm/tlb.c           |  2 +-
>  arch/unicore32/mm/flush.c     |  2 +-
>  arch/unicore32/mm/mmu.c       |  2 +-
>  arch/xtensa/mm/cache.c        |  2 +-
>  include/linux/mm.h            |  1 +
>  mm/util.c                     | 11 +++++++++++
>  20 files changed, 42 insertions(+), 28 deletions(-)
 
...

> diff --git a/mm/util.c b/mm/util.c
> index d800ce40816c..252f4748f00b 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -515,6 +515,17 @@ struct address_space *page_mapping(struct page *page)
>  }
>  EXPORT_SYMBOL(page_mapping);
> 
> +/*
> + * For file cache pages, return the address_space, otherwise return NULL
> + */
> +struct address_space *page_mapping_file(struct page *page)
> +{
> +	if (unlikely(PageSwapCache(page)))
> +		return NULL;
> +	else

Nit: you can drop the 'else' and just fall through to return
page_mapping(page).

> +		return page_mapping(page);
> +}
> +
>  /* Slow path of page_mapcount() for compound pages */
>  int __page_mapcount(struct page *page)
>  {
> -- 
> 2.15.1
> 

-- 
Sincerely yours,
Mike.
