Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237F8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D600725904
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D600725904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933684AbeFYMak (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:30:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:29967 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933263AbeFYMag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:30:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 05:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="67044114"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2018 05:30:33 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, pbonzini@redhat.com,
        wei.w.wang@intel.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, peterx@redhat.com
Subject: [PATCH v34 1/4] mm: support to get hints of free page blocks
Date:   Mon, 25 Jun 2018 20:05:09 +0800
Message-Id: <1529928312-30500-2-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to get free page blocks from a free page list.
The physical addresses of the blocks are stored to the arrays passed
from the caller. The obtained free page blocks are hints about free pages,
because there is no guarantee that they are still on the free page list
after the function returns.

One use example of this patch is to accelerate live migration by skipping
the transfer of free pages reported from the guest. A popular method used
by the hypervisor to track which part of memory is written during live
migration is to write-protect all the guest memory. So, those pages that
are hinted as free pages but are written after this function returns will
be captured by the hypervisor, and they will be added to the next round of
memory transfer.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Liang Li <liang.z.li@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/mm.h |  3 ++
 mm/page_alloc.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a0fbb9f..1b51d43 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2007,6 +2007,9 @@ extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, unsigned long * zones_size,
 		unsigned long zone_start_pfn, unsigned long *zholes_size);
 extern void free_initmem(void);
+uint32_t max_free_page_blocks(int order);
+uint32_t get_from_free_page_list(int order, uint32_t num, __le64 *buf[],
+				 uint32_t size);
 
 /*
  * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100..2e462ab 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5042,6 +5042,88 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 
 	show_swap_cache_info();
 }
+/**
+ * max_free_page_blocks - estimate the max number of free page blocks
+ * @order: the order of the free page blocks to estimate
+ *
+ * This function gives a rough estimation of the possible maximum number of
+ * free page blocks a free list may have. The estimation works on an assumption
+ * that all the system pages are on that list.
+ *
+ * Context: Any context.
+ *
+ * Return: The largest number of free page blocks that the free list can have.
+ */
+uint32_t max_free_page_blocks(int order)
+{
+	return totalram_pages / (1 << order);
+}
+EXPORT_SYMBOL_GPL(max_free_page_blocks);
+
+/**
+ * get_from_free_page_list - get hints of free pages from a free page list
+ * @order: the order of the free page list to check
+ * @num: the number of arrays
+ * @bufs: the arrays to store the physical addresses of the free page blocks
+ * @size: the number of entries each array has
+ *
+ * This function offers hints about free pages. The addresses of free page
+ * blocks are stored to the arrays passed from the caller. There is no
+ * guarantee that the obtained free pages are still on the free page list
+ * after the function returns. pfn_to_page on the obtained free pages is
+ * strongly discouraged and if there is an absolute need for that, make sure
+ * to contact MM people to discuss potential problems.
+ *
+ * The addresses are currently stored to an array in little endian. This
+ * avoids the overhead of converting endianness by the caller who needs data
+ * in the little endian format. Big endian support can be added on demand in
+ * the future. The maximum number of free page blocks that can be obtained is
+ * limited to the size of arrays.
+ *
+ * Context: Process context.
+ *
+ * Return: The number of free page blocks obtained from the free page list.
+ */
+uint32_t get_from_free_page_list(int order, uint32_t num, __le64 *bufs[],
+				 uint32_t size)
+{
+	struct zone *zone;
+	enum migratetype mt;
+	struct page *page;
+	struct list_head *list;
+	unsigned long addr;
+	uint32_t array_index = 0, entry_index = 0;
+	__le64 *array = bufs[array_index];
+
+	/* Validity check */
+	if (order < 0 || order >= MAX_ORDER)
+		return 0;
+
+	for_each_populated_zone(zone) {
+		spin_lock_irq(&zone->lock);
+		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
+			list = &zone->free_area[order].free_list[mt];
+			list_for_each_entry(page, list, lru) {
+				addr = page_to_pfn(page) << PAGE_SHIFT;
+				/* This array is full, so use the next one */
+				if (entry_index == size) {
+					/* All the arrays are consumed */
+					if (++array_index == num) {
+						spin_unlock_irq(&zone->lock);
+						return array_index * size;
+					}
+					array = bufs[array_index];
+					entry_index = 0;
+				}
+				array[entry_index++] = cpu_to_le64(addr);
+			}
+		}
+		spin_unlock_irq(&zone->lock);
+	}
+
+	return array_index * size + entry_index;
+}
+EXPORT_SYMBOL_GPL(get_from_free_page_list);
 
 static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
 {
-- 
2.7.4

