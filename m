Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4954AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C25218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfAaShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:37:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfAaShT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:37:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D85489AF1;
        Thu, 31 Jan 2019 18:37:19 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87A7A18506;
        Thu, 31 Jan 2019 18:37:18 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: [RFC PATCH 3/4] mm/mmu_notifier: set MMU_NOTIFIER_USE_CHANGE_PTE flag where appropriate
Date:   Thu, 31 Jan 2019 13:37:05 -0500
Message-Id: <20190131183706.20980-4-jglisse@redhat.com>
In-Reply-To: <20190131183706.20980-1-jglisse@redhat.com>
References: <20190131183706.20980-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 31 Jan 2019 18:37:19 +0000 (UTC)
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

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
---
 include/linux/mmu_notifier.h | 13 +++++++++++++
 mm/ksm.c                     |  6 ++++--
 mm/memory.c                  |  3 ++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index d7a35975c2bd..0885bf33dc9c 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -43,6 +43,19 @@ enum mmu_notifier_event {
 };
 
 #define MMU_NOTIFIER_EVENT_BITS order_base_2(MMU_NOTIFY_EVENT_MAX)
+/*
+ * Set MMU_NOTIFIER_USE_CHANGE_PTE only when the page table it updated with the
+ * set_pte_at_notify() and when pte is updated from read and write to read only
+ * with same pfn or from read only to read and write with different pfn. It is
+ * illegal to set in any other circumstances.
+ *
+ * Note that set_pte_at_notify() should not be use outside of the above cases.
+ * When updating a range in batch (like write protecting a range) it is better
+ * to rely on invalidate_range_start() and struct mmu_notifier_range to infer
+ * the kind of update that is happening (as an example you can look at the
+ * mmu_notifier_range_update_to_read_only() function).
+ */
+#define MMU_NOTIFIER_USE_CHANGE_PTE (1 << MMU_NOTIFIER_EVENT_BITS)
 
 #ifdef CONFIG_MMU_NOTIFIER
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 97757c5fa15f..b7fb7b560cc0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1051,7 +1051,8 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 
 	BUG_ON(PageTransCompound(page));
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, vma, mm,
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR |
+				MMU_NOTIFIER_USE_CHANGE_PTE, vma, mm,
 				pvmw.address,
 				pvmw.address + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
@@ -1140,7 +1141,8 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	if (!pmd)
 		goto out;
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, vma, mm, addr,
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR |
+				MMU_NOTIFIER_USE_CHANGE_PTE, vma, mm, addr,
 				addr + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
diff --git a/mm/memory.c b/mm/memory.c
index a8c6922526f6..daf4b0f92af8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2275,7 +2275,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 
 	__SetPageUptodate(new_page);
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, vma, mm,
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR |
+				MMU_NOTIFIER_USE_CHANGE_PTE, vma, mm,
 				vmf->address & PAGE_MASK,
 				(vmf->address & PAGE_MASK) + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
-- 
2.17.1

