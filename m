Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B40C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFDA21908
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfBSUGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:06:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfBSUGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:06:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30C07C074F05;
        Tue, 19 Feb 2019 20:06:02 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-134.rdu2.redhat.com [10.10.122.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E7616013D;
        Tue, 19 Feb 2019 20:05:52 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 9/9] mm/mmu_notifier: set MMU_NOTIFIER_USE_CHANGE_PTE flag where appropriate v2
Date:   Tue, 19 Feb 2019 15:04:30 -0500
Message-Id: <20190219200430.11130-10-jglisse@redhat.com>
In-Reply-To: <20190219200430.11130-1-jglisse@redhat.com>
References: <20190219200430.11130-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 19 Feb 2019 20:06:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

When notifying change for a range use MMU_NOTIFIER_USE_CHANGE_PTE flag
for page table update that use set_pte_at_notify() and where the we are
going either from read and write to read only with same pfn or read only
to read and write with new pfn.

Note that set_pte_at_notify() itself should only be use in rare cases
ie we do not want to use it when we are updating a significant range of
virtual addresses and thus a significant number of pte. Instead for
those cases the event provided to mmu notifer invalidate_range_start()
callback should be use for optimization.

Changes since v1:
    - Use the new unsigned flags field in struct mmu_notifier_range
    - Use the new flags parameter to mmu_notifier_range_init()
    - Explicitly list all the patterns where we can use change_pte()

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: kvm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-rdma@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/mmu_notifier.h | 34 ++++++++++++++++++++++++++++++++--
 mm/ksm.c                     | 11 ++++++-----
 mm/memory.c                  |  5 +++--
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index b6c004bd9f6a..0230a4b06b46 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -40,6 +40,26 @@ enum mmu_notifier_event {
 	MMU_NOTIFY_SOFT_DIRTY,
 };
 
+/*
+ * @MMU_NOTIFIER_RANGE_BLOCKABLE: can the mmu notifier range_start/range_end
+ * callback block or not ? If set then the callback can block.
+ *
+ * @MMU_NOTIFIER_USE_CHANGE_PTE: only set when the page table it updated with
+ * the set_pte_at_notify() the valid patterns for this are:
+ *      - pte read and write to read only same pfn
+ *      - pte read only to read and write (pfn can change or stay the same)
+ *      - pte read only to read only with different pfn
+ * It is illegal to set in any other circumstances.
+ *
+ * Note that set_pte_at_notify() should not be use outside of the above cases.
+ * When updating a range in batch (like write protecting a range) it is better
+ * to rely on invalidate_range_start() and struct mmu_notifier_range to infer
+ * the kind of update that is happening (as an example you can look at the
+ * mmu_notifier_range_update_to_read_only() function).
+ */
+#define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
+#define MMU_NOTIFIER_USE_CHANGE_PTE (1 << 1)
+
 #ifdef CONFIG_MMU_NOTIFIER
 
 /*
@@ -55,8 +75,6 @@ struct mmu_notifier_mm {
 	spinlock_t lock;
 };
 
-#define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
-
 struct mmu_notifier_range {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
@@ -268,6 +286,12 @@ mmu_notifier_range_blockable(const struct mmu_notifier_range *range)
 	return (range->flags & MMU_NOTIFIER_RANGE_BLOCKABLE);
 }
 
+static inline bool
+mmu_notifier_range_use_change_pte(const struct mmu_notifier_range *range)
+{
+	return (range->flags & MMU_NOTIFIER_USE_CHANGE_PTE);
+}
+
 static inline void mmu_notifier_release(struct mm_struct *mm)
 {
 	if (mm_has_notifiers(mm))
@@ -509,6 +533,12 @@ mmu_notifier_range_blockable(const struct mmu_notifier_range *range)
 	return true;
 }
 
+static inline bool
+mmu_notifier_range_use_change_pte(const struct mmu_notifier_range *range)
+{
+	return false;
+}
+
 static inline int mm_has_notifiers(struct mm_struct *mm)
 {
 	return 0;
diff --git a/mm/ksm.c b/mm/ksm.c
index b782fadade8f..41e51882f999 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1066,9 +1066,9 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 
 	BUG_ON(PageTransCompound(page));
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
-				pvmw.address,
-				pvmw.address + PAGE_SIZE);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR,
+				MMU_NOTIFIER_USE_CHANGE_PTE, vma, mm,
+				pvmw.address, pvmw.address + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
 	if (!page_vma_mapped_walk(&pvmw))
@@ -1155,8 +1155,9 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	if (!pmd)
 		goto out;
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
-				addr + PAGE_SIZE);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR,
+				MMU_NOTIFIER_USE_CHANGE_PTE,
+				vma, mm, addr, addr + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
 	ptep = pte_offset_map_lock(mm, pmd, addr, &ptl);
diff --git a/mm/memory.c b/mm/memory.c
index 45dbc174a88c..cb71d3ff1b97 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2282,8 +2282,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 
 	__SetPageUptodate(new_page);
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
-				vmf->address & PAGE_MASK,
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR,
+				MMU_NOTIFIER_USE_CHANGE_PTE,
+				vma, mm, vmf->address & PAGE_MASK,
 				(vmf->address & PAGE_MASK) + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
-- 
2.17.2

