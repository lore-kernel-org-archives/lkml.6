Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A911218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeLZNiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:38:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:33944 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbeLZNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="121185471"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2018 05:37:02 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005PS-Ms; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133352.246320288@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:15:06 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>, Jingqi Liu <jingqi.liu@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Yao Yuan <yuan.yao@intel.com>
cc:     Peng Dong <dongx.peng@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>
cc:     Zhang Yi <yi.z.zhang@linux.intel.com>
cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [RFC][PATCH v2 20/21] mm/vmscan.c: migrate anon DRAM pages to PMEM node
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0012-vmscan-migrate-anonymous-pages-to-pmem-node-before-s.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jingqi Liu <jingqi.liu@intel.com>

With PMEM nodes, the demotion path could be

1) DRAM pages: migrate to PMEM node
2) PMEM pages: swap out

This patch does (1) for anonymous pages only. Since we cannot
detect hotness of (unmapped) page cache pages for now.

The user space daemon can do migration in both directions:
- PMEM=>DRAM hot page migration
- DRAM=>PMEM cold page migration
However it's more natural for user space to do hot page migration
and kernel to do cold page migration. Especially, only kernel can
guarantee on-demand migration when there is memory pressure.

So the big picture will look like this: user space daemon does regular
hot page migration to DRAM, creating memory pressure on DRAM nodes,
which triggers kernel cold page migration to PMEM nodes.

Du Fan:
- Support multiple NUMA nodes.
- Don't migrate clean MADV_FREE pages to PMEM node.

With advise(MADV_FREE) syscall, both vma structure and
its corresponding page entries still lives, but we got
MADV_FREE page, anonymous but WITHOUT SwapBacked.

In case of page reclaim, clean MADV_FREE pages will be
freed and return to buddy system, the dirty ones then
turn into canonical anonymous page with
PageSwapBacked(page) set, and put into LRU_INACTIVE_FILE
list falling into standard aging routine.

Point is clean MADV_FREE pages should not be migrated,
it has steal (useless) user data once madvise(MADV_FREE)
called and guard against thus scenarios.

P.S. MADV_FREE is heavily used by jemalloc engine, and
workload like redis, refer to [1] for detailed backgroud,
usecase, and benchmark result.

[1]
https://lore.kernel.org/patchwork/patch/622179/

Fengguang:
- detect migrate thp and hugetlb
- avoid moving pages to a non-existent node

Signed-off-by: Fan Du <fan.du@intel.com>
Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 mm/vmscan.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- linux.orig/mm/vmscan.c	2018-12-23 20:37:58.305551976 +0800
+++ linux/mm/vmscan.c	2018-12-23 20:37:58.305551976 +0800
@@ -1112,6 +1112,7 @@ static unsigned long shrink_page_list(st
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
+	LIST_HEAD(move_pages);
 	int pgactivate = 0;
 	unsigned nr_unqueued_dirty = 0;
 	unsigned nr_dirty = 0;
@@ -1121,6 +1122,7 @@ static unsigned long shrink_page_list(st
 	unsigned nr_immediate = 0;
 	unsigned nr_ref_keep = 0;
 	unsigned nr_unmap_fail = 0;
+	int page_on_dram = is_node_dram(pgdat->node_id);
 
 	cond_resched();
 
@@ -1275,6 +1277,21 @@ static unsigned long shrink_page_list(st
 		}
 
 		/*
+		 * Check if the page is in DRAM numa node.
+		 * Skip MADV_FREE pages as it might be freed
+		 * immediately to buddy system if it's clean.
+		 */
+		if (node_online(pgdat->peer_node) &&
+			PageAnon(page) && (PageSwapBacked(page) || PageTransHuge(page))) {
+			if (page_on_dram) {
+				/* Add to the page list which will be moved to pmem numa node. */
+				list_add(&page->lru, &move_pages);
+				unlock_page(page);
+				continue;
+			}
+		}
+
+		/*
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
 		 * Lazyfree page could be freed directly
@@ -1496,6 +1513,22 @@ keep:
 		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
 	}
 
+	/* Move the anonymous pages to PMEM numa node. */
+	if (!list_empty(&move_pages)) {
+		int err;
+
+		/* Could not block. */
+		err = migrate_pages(&move_pages, alloc_new_node_page, NULL,
+					pgdat->peer_node,
+					MIGRATE_ASYNC, MR_NUMA_MISPLACED);
+		if (err) {
+			putback_movable_pages(&move_pages);
+
+			/* Join the pages which were not migrated.  */
+			list_splice(&ret_pages, &move_pages);
+		}
+	}
+
 	mem_cgroup_uncharge_list(&free_pages);
 	try_to_unmap_flush();
 	free_unref_page_list(&free_pages);


