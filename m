Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D79BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC3620684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC3620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJCUaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:30:22 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:42874 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbeJCUaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:30:21 -0400
X-IronPort-AV: E=Sophos;i="5.54,336,1534789800"; 
   d="scan'208";a="195425"
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Oct 2018 19:09:48 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9033"; a="1904525"
Received: from blr-ubuntu-104.ap.qualcomm.com (HELO blr-ubuntu-104.qualcomm.com) ([10.79.40.64])
  by ironmsg01-blr.qualcomm.com with ESMTP; 03 Oct 2018 19:09:48 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id 8D7902380; Wed,  3 Oct 2018 19:09:47 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org
Cc:     vatsa@codeaurora.org, vinmenon@codeaurora.org, getarunks@gmail.com,
        Arun KS <arunks@codeaurora.org>
Subject: [PATCH v4] memory_hotplug: Free pages as higher order
Date:   Wed,  3 Oct 2018 19:09:39 +0530
Message-Id: <1538573979-28365-1-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When free pages are done with higher order, time spend on
coalescing pages by buddy allocator can be reduced. With
section size of 256MB, hot add latency of a single section
shows improvement from 50-60 ms to less than 1 ms, hence
improving the hot add latency by 60%. Modify external
providers of online callback to align with the change.
Also remove prefetch from __free_pages_core().

Signed-off-by: Arun KS <arunks@codeaurora.org>
---
Changes since v3:
- renamed _free_pages_boot_core -> __free_pages_core.
- removed prefetch from __free_pages_core.
- removed xen_online_page().

Changes since v2:
- reuse code from __free_pages_boot_core().

Changes since v1:
- Removed prefetch().

Changes since RFC:
- Rebase.
- As suggested by Michal Hocko remove pages_per_block.
- Modifed external providers of online_page_callback.

v3: https://lore.kernel.org/patchwork/patch/992348/
v2: https://lore.kernel.org/patchwork/patch/991363/
v1: https://lore.kernel.org/patchwork/patch/989445/
RFC: https://lore.kernel.org/patchwork/patch/984754/

---
 drivers/hv/hv_balloon.c        |  6 ++++--
 drivers/xen/balloon.c          | 23 ++++++++++++++--------
 include/linux/memory_hotplug.h |  2 +-
 mm/internal.h                  |  1 +
 mm/memory_hotplug.c            | 44 ++++++++++++++++++++++++++++++------------
 mm/page_alloc.c                | 14 +++++---------
 6 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index b1b7880..c5bc0b5 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -771,7 +771,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 	}
 }
 
-static void hv_online_page(struct page *pg)
+static int hv_online_page(struct page *pg, unsigned int order)
 {
 	struct hv_hotadd_state *has;
 	unsigned long flags;
@@ -783,10 +783,12 @@ static void hv_online_page(struct page *pg)
 		if ((pfn < has->start_pfn) || (pfn >= has->end_pfn))
 			continue;
 
-		hv_page_online_one(has, pg);
+		hv_bring_pgs_online(has, pfn, (1UL << order));
 		break;
 	}
 	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+
+	return 0;
 }
 
 static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index e12bb25..58ddf48 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -390,8 +390,8 @@ static enum bp_state reserve_additional_memory(void)
 
 	/*
 	 * add_memory_resource() will call online_pages() which in its turn
-	 * will call xen_online_page() callback causing deadlock if we don't
-	 * release balloon_mutex here. Unlocking here is safe because the
+	 * will call xen_bring_pgs_online() callback causing deadlock if we
+	 * don't release balloon_mutex here. Unlocking here is safe because the
 	 * callers drop the mutex before trying again.
 	 */
 	mutex_unlock(&balloon_mutex);
@@ -411,15 +411,22 @@ static enum bp_state reserve_additional_memory(void)
 	return BP_ECANCELED;
 }
 
-static void xen_online_page(struct page *page)
+static int xen_bring_pgs_online(struct page *pg, unsigned int order)
 {
-	__online_page_set_limits(page);
+	unsigned long i, size = (1 << order);
+	unsigned long start_pfn = page_to_pfn(pg);
+	struct page *p;
 
+	pr_debug("Online %lu pages starting at pfn 0x%lx\n", size, start_pfn);
 	mutex_lock(&balloon_mutex);
-
-	__balloon_append(page);
-
+	for (i = 0; i < size; i++) {
+		p = pfn_to_page(start_pfn + i);
+		__online_page_set_limits(p);
+		__balloon_append(p);
+	}
 	mutex_unlock(&balloon_mutex);
+
+	return 0;
 }
 
 static int xen_memory_notifier(struct notifier_block *nb, unsigned long val, void *v)
@@ -744,7 +751,7 @@ static int __init balloon_init(void)
 	balloon_stats.max_retry_count = RETRY_UNLIMITED;
 
 #ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
-	set_online_page_callback(&xen_online_page);
+	set_online_page_callback(&xen_bring_pgs_online);
 	register_memory_notifier(&xen_memory_nb);
 	register_sysctl_table(xen_root);
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 34a2822..7b04c1d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -87,7 +87,7 @@ extern int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long *valid_start, unsigned long *valid_end);
 extern void __offline_isolated_pages(unsigned long, unsigned long);
 
-typedef void (*online_page_callback_t)(struct page *page);
+typedef int (*online_page_callback_t)(struct page *page, unsigned int order);
 
 extern int set_online_page_callback(online_page_callback_t callback);
 extern int restore_online_page_callback(online_page_callback_t callback);
diff --git a/mm/internal.h b/mm/internal.h
index 87256ae..636679c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -163,6 +163,7 @@ static inline struct page *pageblock_pfn_to_page(unsigned long start_pfn,
 extern int __isolate_free_page(struct page *page, unsigned int order);
 extern void __free_pages_bootmem(struct page *page, unsigned long pfn,
 					unsigned int order);
+extern void __free_pages_core(struct page *page, unsigned int order);
 extern void prep_compound_page(struct page *page, unsigned int order);
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 38d94b7..6223021 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -47,7 +47,7 @@
  * and restore_online_page_callback() for generic callback restore.
  */
 
-static void generic_online_page(struct page *page);
+static int generic_online_page(struct page *page, unsigned int order);
 
 static online_page_callback_t online_page_callback = generic_online_page;
 static DEFINE_MUTEX(online_page_callback_lock);
@@ -655,26 +655,46 @@ void __online_page_free(struct page *page)
 }
 EXPORT_SYMBOL_GPL(__online_page_free);
 
-static void generic_online_page(struct page *page)
+static int generic_online_page(struct page *page, unsigned int order)
 {
-	__online_page_set_limits(page);
-	__online_page_increment_counters(page);
-	__online_page_free(page);
+	__free_pages_core(page, order);
+	totalram_pages += (1UL << order);
+#ifdef CONFIG_HIGHMEM
+	if (PageHighMem(page))
+		totalhigh_pages += (1UL << order);
+#endif
+	return 0;
+}
+
+static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
+{
+	unsigned long end = start + nr_pages;
+	int order, ret, onlined_pages = 0;
+
+	while (start < end) {
+		order = min(MAX_ORDER - 1UL, __ffs(start));
+
+		while (start + (1UL << order) > end)
+			order--;
+
+		ret = (*online_page_callback)(pfn_to_page(start), order);
+		if (!ret)
+			onlined_pages += (1UL << order);
+		else if (ret > 0)
+			onlined_pages += ret;
+
+		start += (1UL << order);
+	}
+	return onlined_pages;
 }
 
 static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
 			void *arg)
 {
-	unsigned long i;
 	unsigned long onlined_pages = *(unsigned long *)arg;
-	struct page *page;
 
 	if (PageReserved(pfn_to_page(start_pfn)))
-		for (i = 0; i < nr_pages; i++) {
-			page = pfn_to_page(start_pfn + i);
-			(*online_page_callback)(page);
-			onlined_pages++;
-		}
+		onlined_pages = online_pages_blocks(start_pfn, nr_pages);
 
 	online_mem_sections(start_pfn, start_pfn + nr_pages);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 89d2a2a..fea0255 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1252,20 +1252,16 @@ static void __free_pages_ok(struct page *page, unsigned int order)
 	local_irq_restore(flags);
 }
 
-static void __init __free_pages_boot_core(struct page *page, unsigned int order)
+void __free_pages_core(struct page *page, unsigned int order)
 {
 	unsigned int nr_pages = 1 << order;
 	struct page *p = page;
 	unsigned int loop;
 
-	prefetchw(p);
-	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
-		prefetchw(p + 1);
+	for (loop = 0; loop < nr_pages; loop++, p++) {
 		__ClearPageReserved(p);
 		set_page_count(p, 0);
 	}
-	__ClearPageReserved(p);
-	set_page_count(p, 0);
 
 	page_zone(page)->managed_pages += nr_pages;
 	set_page_refcounted(page);
@@ -1331,7 +1327,7 @@ void __init __free_pages_bootmem(struct page *page, unsigned long pfn,
 {
 	if (early_page_uninitialised(pfn))
 		return;
-	return __free_pages_boot_core(page, order);
+	return __free_pages_core(page, order);
 }
 
 /*
@@ -1421,14 +1417,14 @@ static void __init deferred_free_range(unsigned long pfn,
 	if (nr_pages == pageblock_nr_pages &&
 	    (pfn & (pageblock_nr_pages - 1)) == 0) {
 		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		__free_pages_boot_core(page, pageblock_order);
+		__free_pages_core(page, pageblock_order);
 		return;
 	}
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if ((pfn & (pageblock_nr_pages - 1)) == 0)
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		__free_pages_boot_core(page, 0);
+		__free_pages_core(page, 0);
 	}
 }
 
-- 
1.9.1

