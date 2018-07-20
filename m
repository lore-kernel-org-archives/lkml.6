Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0035AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8D020647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8D020647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbeGTTDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:03:41 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53400 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388203AbeGTTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:03:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T50UBOI_1532110430;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T50UBOI_1532110430)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Jul 2018 02:13:58 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill@shutemov.name, hughd@google.com, rientjes@google.com,
        aaron.lu@intel.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: remove use_zero_page sysfs knob
Date:   Sat, 21 Jul 2018 02:13:50 +0800
Message-Id: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By digging into the original review, it looks use_zero_page sysfs knob
was added to help ease-of-testing and give user a way to mitigate
refcounting overhead.

It has been a few years since the knob was added at the first place, I
think we are confident that it is stable enough. And, since commit
6fcb52a56ff60 ("thp: reduce usage of huge zero page's atomic counter"),
it looks refcounting overhead has been reduced significantly.

Other than the above, the value of the knob is always 1 (enabled by
default), I'm supposed very few people turn it off by default.

So, it sounds not worth to still keep this knob around.

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  7 -------
 include/linux/huge_mm.h                    |  4 ----
 mm/huge_memory.c                           | 22 ++--------------------
 3 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 7ab93a8..d471ce8 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -148,13 +148,6 @@ madvise
 never
 	should be self-explanatory.
 
-By default kernel tries to use huge zero page on read page fault to
-anonymous mapping. It's possible to disable huge zero page by writing 0
-or enable it back by writing 1::
-
-	echo 0 >/sys/kernel/mm/transparent_hugepage/use_zero_page
-	echo 1 >/sys/kernel/mm/transparent_hugepage/use_zero_page
-
 Some userspace (such as a test program, or an optimized memory allocation
 library) may want to know the size (in bytes) of a transparent hugepage::
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a8a1262..0ea7808 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -58,7 +58,6 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
-	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
 #ifdef CONFIG_DEBUG_VM
 	TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG,
 #endif
@@ -116,9 +115,6 @@ static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
-#define transparent_hugepage_use_zero_page()				\
-	(transparent_hugepage_flags &					\
-	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
 #ifdef CONFIG_DEBUG_VM
 #define transparent_hugepage_debug_cow()				\
 	(transparent_hugepage_flags &					\
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1cd7c1a..0d4cf87 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -54,8 +54,7 @@
 	(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
 #endif
 	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG)|
-	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
-	(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
+	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
 
 static struct shrinker deferred_split_shrinker;
 
@@ -273,21 +272,6 @@ static ssize_t defrag_store(struct kobject *kobj,
 static struct kobj_attribute defrag_attr =
 	__ATTR(defrag, 0644, defrag_show, defrag_store);
 
-static ssize_t use_zero_page_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	return single_hugepage_flag_show(kobj, attr, buf,
-				TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
-}
-static ssize_t use_zero_page_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	return single_hugepage_flag_store(kobj, attr, buf, count,
-				 TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
-}
-static struct kobj_attribute use_zero_page_attr =
-	__ATTR(use_zero_page, 0644, use_zero_page_show, use_zero_page_store);
-
 static ssize_t hpage_pmd_size_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -317,7 +301,6 @@ static ssize_t debug_cow_store(struct kobject *kobj,
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
 	&defrag_attr.attr,
-	&use_zero_page_attr.attr,
 	&hpage_pmd_size_attr.attr,
 #if defined(CONFIG_SHMEM) && defined(CONFIG_TRANSPARENT_HUGE_PAGECACHE)
 	&shmem_enabled_attr.attr,
@@ -677,8 +660,7 @@ int do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	if (unlikely(khugepaged_enter(vma, vma->vm_flags)))
 		return VM_FAULT_OOM;
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
-			!mm_forbids_zeropage(vma->vm_mm) &&
-			transparent_hugepage_use_zero_page()) {
+			!mm_forbids_zeropage(vma->vm_mm)) {
 		pgtable_t pgtable;
 		struct page *zero_page;
 		bool set;
-- 
1.8.3.1

