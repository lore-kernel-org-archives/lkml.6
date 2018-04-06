Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755416AbeDFOyV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:54:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeDFOyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:54:18 -0400
Date: Fri, 6 Apr 2018 07:54:15 -0700
From: Matthew Wilcox <willy@infradead.org>
To: akpm@linux-foundation.org
Cc: broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2018-04-05-16-59 uploaded
Message-ID: <20180406145415.GB20605@bombadil.infradead.org>
References: <20180406000009.l1ebV%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406000009.l1ebV%akpm@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 05:00:09PM -0700, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-04-05-16-59 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/

> * page-cache-use-xa_lock.patch

Hi Andrew.  Could I trouble you to add page-cache-use-xa_lock-fix.patch?

---
 arch/nds32/include/asm/cacheflush.h | 4 ++--
 fs/dax.c                            | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 7b9b20a381cb..1240f148ec0f 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -34,8 +34,8 @@ void flush_anon_page(struct vm_area_struct *vma,
 void flush_kernel_dcache_page(struct page *page);
 void flush_icache_range(unsigned long start, unsigned long end);
 void flush_icache_page(struct vm_area_struct *vma, struct page *page);
-#define flush_dcache_mmap_lock(mapping)   spin_lock_irq(&(mapping)->tree_lock)
-#define flush_dcache_mmap_unlock(mapping) spin_unlock_irq(&(mapping)->tree_lock)
+#define flush_dcache_mmap_lock(mapping)   xa_lock_irq(&(mapping)->i_pages)
+#define flush_dcache_mmap_unlock(mapping) xa_unlock_irq(&(mapping)->i_pages)
 
 #else
 #include <asm-generic/cacheflush.h>
diff --git a/fs/dax.c b/fs/dax.c
index fef7d458fd7d..aaec72ded1b6 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -499,7 +499,7 @@ static int __dax_invalidate_mapping_entry(struct address_space *mapping,
 	void *entry;
 	struct radix_tree_root *pages = &mapping->i_pages;
 
-	xa_lock_irq(&mapping->i_pages);
+	xa_lock_irq(pages);
 	entry = get_unlocked_mapping_entry(mapping, index, NULL);
 	if (!entry || WARN_ON_ONCE(!radix_tree_exceptional_entry(entry)))
 		goto out;
@@ -513,7 +513,7 @@ static int __dax_invalidate_mapping_entry(struct address_space *mapping,
 	ret = 1;
 out:
 	put_unlocked_mapping_entry(mapping, index, entry);
-	xa_unlock_irq(&mapping->i_pages);
+	xa_unlock_irq(pages);
 	return ret;
 }
 /*
@@ -600,7 +600,7 @@ static void *dax_insert_mapping_entry(struct address_space *mapping,
 			unmap_mapping_pages(mapping, vmf->pgoff, 1, false);
 	}
 
-	xa_lock_irq(&mapping->i_pages);
+	xa_lock_irq(pages);
 	new_entry = dax_radix_locked_entry(pfn, flags);
 	if (dax_entry_size(entry) != dax_entry_size(new_entry)) {
 		dax_disassociate_entry(entry, mapping, false);
-- 
2.16.3
