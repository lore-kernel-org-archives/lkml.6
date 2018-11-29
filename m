Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4744C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB3420673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB3420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeK2Tnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:43:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:35614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726780AbeK2Tnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:43:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25AFBAD33;
        Thu, 29 Nov 2018 08:39:04 +0000 (UTC)
Date:   Thu, 29 Nov 2018 09:39:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove pte_lock_deinit()
Message-ID: <20181129083903.GP6923@dhcp22.suse.cz>
References: <20181128235525.58780-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128235525.58780-1-yuzhao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-11-18 16:55:25, Yu Zhao wrote:
> Pagetable page doesn't touch page->mapping or have any used field
> that overlaps with it. No need to clear mapping in dtor. In fact,
> doing so might mask problems that otherwise would be detected by
> bad_page().

yes the layour of the structure has changed since Hugh introduced the
pte lock split

> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mm.h | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5411de93a363..7c8f4fc9244e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1900,13 +1900,6 @@ static inline bool ptlock_init(struct page *page)
>  	return true;
>  }
>  
> -/* Reset page->mapping so free_pages_check won't complain. */
> -static inline void pte_lock_deinit(struct page *page)
> -{
> -	page->mapping = NULL;
> -	ptlock_free(page);
> -}
> -
>  #else	/* !USE_SPLIT_PTE_PTLOCKS */
>  /*
>   * We use mm->page_table_lock to guard all pagetable pages of the mm.
> @@ -1917,7 +1910,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  }
>  static inline void ptlock_cache_init(void) {}
>  static inline bool ptlock_init(struct page *page) { return true; }
> -static inline void pte_lock_deinit(struct page *page) {}
> +static inline void ptlock_free(struct page *page) {}
>  #endif /* USE_SPLIT_PTE_PTLOCKS */
>  
>  static inline void pgtable_init(void)
> @@ -1937,7 +1930,7 @@ static inline bool pgtable_page_ctor(struct page *page)
>  
>  static inline void pgtable_page_dtor(struct page *page)
>  {
> -	pte_lock_deinit(page);
> +	ptlock_free(page);
>  	__ClearPageTable(page);
>  	dec_zone_page_state(page, NR_PAGETABLE);
>  }
> -- 
> 2.20.0.rc1.387.gf8505762e3-goog
> 

-- 
Michal Hocko
SUSE Labs
