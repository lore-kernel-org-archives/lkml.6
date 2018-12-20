Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE1DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C622176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeLTIYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:24:07 -0500
Received: from ozlabs.ru ([107.173.13.209]:54003 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730755AbeLTIYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:24:06 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 7740BAE80110;
        Thu, 20 Dec 2018 03:24:01 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        Reza Arbab <arbab@linux.ibm.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= 
        <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH kernel v7 02/20] powerpc/mm/iommu/vfio_spapr_tce: Change mm_iommu_get to reference a region
Date:   Thu, 20 Dec 2018 19:23:32 +1100
Message-Id: <20181220082350.58113-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally mm_iommu_get() should add a reference and mm_iommu_put() should
remove it. However historically mm_iommu_find() does the referencing and
mm_iommu_get() is doing allocation and referencing.

We are going to add another helper to preregister device memory so
instead of having mm_iommu_new() (which pre-registers the normal memory
and references the region), we need separate helpers for pre-registering
and referencing.

This renames:
- mm_iommu_get to mm_iommu_new;
- mm_iommu_find to mm_iommu_get.

This changes mm_iommu_get() to reference the region so the name now
reflects what it does.

This removes the check for exact match from mm_iommu_new() as we want it
to fail on existing regions; mm_iommu_get() should be used instead.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v5:
* fixed a bug with uninitialized @found in tce_iommu_unregister_pages()
* reworded the commit log

v4:
* squashed "powerpc/mm/iommu: Make mm_iommu_new() fail on existing regions" into this

v2:
* merged 2 patches into one
---
 arch/powerpc/include/asm/mmu_context.h |  4 +--
 arch/powerpc/mm/mmu_context_iommu.c    | 19 +++++++-------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 35 +++++++++++++++++---------
 3 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index c05efd2..268e112 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -21,7 +21,7 @@ struct mm_iommu_table_group_mem_t;
 
 extern int isolate_lru_page(struct page *page);	/* from internal.h */
 extern bool mm_iommu_preregistered(struct mm_struct *mm);
-extern long mm_iommu_get(struct mm_struct *mm,
+extern long mm_iommu_new(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem);
 extern long mm_iommu_put(struct mm_struct *mm,
@@ -32,7 +32,7 @@ extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
 		unsigned long ua, unsigned long size);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
 		struct mm_struct *mm, unsigned long ua, unsigned long size);
-extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
+extern struct mm_iommu_table_group_mem_t *mm_iommu_get(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries);
 extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 0741d90..25a4b7f7 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -89,7 +89,7 @@ bool mm_iommu_preregistered(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
 
-long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
+long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
@@ -100,12 +100,6 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
 			next) {
-		if ((mem->ua == ua) && (mem->entries == entries)) {
-			++mem->used;
-			*pmem = mem;
-			goto unlock_exit;
-		}
-
 		/* Overlap? */
 		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
 				(ua < (mem->ua +
@@ -192,7 +186,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mm_iommu_get);
+EXPORT_SYMBOL_GPL(mm_iommu_new);
 
 static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
 {
@@ -308,21 +302,26 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(struct mm_struct *mm,
 	return ret;
 }
 
-struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
+struct mm_iommu_table_group_mem_t *mm_iommu_get(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries)
 {
 	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
 
+	mutex_lock(&mem_list_mutex);
+
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
 		if ((mem->ua == ua) && (mem->entries == entries)) {
 			ret = mem;
+			++mem->used;
 			break;
 		}
 	}
 
+	mutex_unlock(&mem_list_mutex);
+
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mm_iommu_find);
+EXPORT_SYMBOL_GPL(mm_iommu_get);
 
 long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index ad63725..1d8b889 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -152,11 +152,12 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 	struct mm_iommu_table_group_mem_t *mem;
 	struct tce_iommu_prereg *tcemem;
 	bool found = false;
+	long ret;
 
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
 		return -EINVAL;
 
-	mem = mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
+	mem = mm_iommu_get(container->mm, vaddr, size >> PAGE_SHIFT);
 	if (!mem)
 		return -ENOENT;
 
@@ -168,9 +169,13 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 	}
 
 	if (!found)
-		return -ENOENT;
+		ret = -ENOENT;
+	else
+		ret = tce_iommu_prereg_free(container, tcemem);
 
-	return tce_iommu_prereg_free(container, tcemem);
+	mm_iommu_put(container->mm, mem);
+
+	return ret;
 }
 
 static long tce_iommu_register_pages(struct tce_container *container,
@@ -185,22 +190,24 @@ static long tce_iommu_register_pages(struct tce_container *container,
 			((vaddr + size) < vaddr))
 		return -EINVAL;
 
-	mem = mm_iommu_find(container->mm, vaddr, entries);
+	mem = mm_iommu_get(container->mm, vaddr, entries);
 	if (mem) {
 		list_for_each_entry(tcemem, &container->prereg_list, next) {
-			if (tcemem->mem == mem)
-				return -EBUSY;
+			if (tcemem->mem == mem) {
+				ret = -EBUSY;
+				goto put_exit;
+			}
 		}
+	} else {
+		ret = mm_iommu_new(container->mm, vaddr, entries, &mem);
+		if (ret)
+			return ret;
 	}
 
-	ret = mm_iommu_get(container->mm, vaddr, entries, &mem);
-	if (ret)
-		return ret;
-
 	tcemem = kzalloc(sizeof(*tcemem), GFP_KERNEL);
 	if (!tcemem) {
-		mm_iommu_put(container->mm, mem);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto put_exit;
 	}
 
 	tcemem->mem = mem;
@@ -209,6 +216,10 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	container->enabled = true;
 
 	return 0;
+
+put_exit:
+	mm_iommu_put(container->mm, mem);
+	return ret;
 }
 
 static bool tce_page_is_contained(struct page *page, unsigned page_shift)
-- 
2.17.1

