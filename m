Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFEBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AF1214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeLRIYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:24:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40568 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeLRIYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:24:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0DC215AB;
        Tue, 18 Dec 2018 00:24:08 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63D783F575;
        Tue, 18 Dec 2018 00:24:05 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        steve.capper@arm.com, catalin.marinas@arm.com, mhocko@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: [RESEND PATCH V3 1/5] mm/hugetlb: Distinguish between migratability and movability
Date:   Tue, 18 Dec 2018 13:54:06 +0530
Message-Id: <1545121450-1663-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
References: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During huge page allocation it's migratability is checked to determine if
it should be placed under movable zones with GFP_HIGHUSER_MOVABLE. But the
movability aspect of the huge page could depend on other factors than just
migratability. Movability in itself is a distinct property which should not
be tied with migratability alone.

This differentiates these two and implements an enhanced movability check
which also considers huge page size to determine if it is feasible to be
placed under a movable zone. At present it just checks for gigantic pages
but going forward it can incorporate other enhanced checks.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Suggested-by: Michal Hocko <mhocko@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/hugetlb.h | 30 ++++++++++++++++++++++++++++++
 mm/hugetlb.c            |  2 +-
 mm/migrate.c            |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 087fd5f4..1b858d7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -506,6 +506,31 @@ static inline bool hugepage_migration_supported(struct hstate *h)
 #endif
 }
 
+/*
+ * Movability check is different as compared to migration check.
+ * It determines whether or not a huge page should be placed on
+ * movable zone or not. Movability of any huge page should be
+ * required only if huge page size is supported for migration.
+ * There wont be any reason for the huge page to be movable if
+ * it is not migratable to start with. Also the size of the huge
+ * page should be large enough to be placed under a movable zone
+ * and still feasible enough to be migratable. Just the presence
+ * in movable zone does not make the migration feasible.
+ *
+ * So even though large huge page sizes like the gigantic ones
+ * are migratable they should not be movable because its not
+ * feasible to migrate them from movable zone.
+ */
+static inline bool hugepage_movable_supported(struct hstate *h)
+{
+	if (!hugepage_migration_supported(h))
+		return false;
+
+	if (hstate_is_gigantic(h))
+		return false;
+	return true;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
@@ -602,6 +627,11 @@ static inline bool hugepage_migration_supported(struct hstate *h)
 	return false;
 }
 
+static inline bool hugepage_movable_supported(struct hstate *h)
+{
+	return false;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 705a3e9c..795f745 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -919,7 +919,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 /* Movability of hugepages depends on migration support. */
 static inline gfp_t htlb_alloc_mask(struct hstate *h)
 {
-	if (hugepage_migration_supported(h))
+	if (hugepage_movable_supported(h))
 		return GFP_HIGHUSER_MOVABLE;
 	else
 		return GFP_HIGHUSER;
diff --git a/mm/migrate.c b/mm/migrate.c
index f7e4bfd..3020a06 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1262,7 +1262,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	struct anon_vma *anon_vma = NULL;
 
 	/*
-	 * Movability of hugepages depends on architectures and hugepage size.
+	 * Migratability of hugepages depends on architectures and their size.
 	 * This check is necessary because some callers of hugepage migration
 	 * like soft offline and memory hotremove don't walk through page
 	 * tables or check whether the hugepage is pmd-based or not before
-- 
2.7.4

