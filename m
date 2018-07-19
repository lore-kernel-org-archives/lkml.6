Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F338ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5F120693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5F120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbeGSJbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:31:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:10716 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbeGSJbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:31:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 01:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,374,1526367600"; 
   d="scan'208";a="76038339"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.195.246])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2018 01:49:07 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v3 8/8] swap, put_swap_page: Share more between huge/normal code path
Date:   Thu, 19 Jul 2018 16:48:42 +0800
Message-Id: <20180719084842.11385-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180719084842.11385-1-ying.huang@intel.com>
References: <20180719084842.11385-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch, locking related code is shared between huge/normal code
path in put_swap_page() to reduce code duplication.  And `free_entries
== 0` case is merged into more general `free_entries !=
SWAPFILE_CLUSTER` case, because the new locking method makes it easy.

The added lines is same as the removed lines.  But the code size is
increased when CONFIG_TRANSPARENT_HUGEPAGE=n.

		text	   data	    bss	    dec	    hex	filename
base:	       24123	   2004	    340	  26467	   6763	mm/swapfile.o
unified:       24485	   2004	    340	  26829	   68cd	mm/swapfile.o

Dig on step deeper with `size -A mm/swapfile.o` for base and unified
kernel and compare the result, yields,

  -.text                                17723      0
  +.text                                17835      0
  -.orc_unwind_ip                        1380      0
  +.orc_unwind_ip                        1480      0
  -.orc_unwind                           2070      0
  +.orc_unwind                           2220      0
  -Total                                26686
  +Total                                27048

The total difference is the same.  The text segment difference is much
smaller: 112.  More difference comes from the ORC unwinder
segments: (1480 + 2220) - (1380 + 2070) = 250.  If the frame pointer
unwinder is used, this costs nothing.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 mm/swapfile.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d313f7512d26..2fe2e93cee0e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1284,8 +1284,8 @@ void put_swap_page(struct page *page, swp_entry_t entry)
 	if (!si)
 		return;
 
+	ci = lock_cluster_or_swap_info(si, offset);
 	if (size == SWAPFILE_CLUSTER) {
-		ci = lock_cluster(si, offset);
 		VM_BUG_ON(!cluster_is_huge(ci));
 		map = si->swap_map + offset;
 		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
@@ -1294,13 +1294,9 @@ void put_swap_page(struct page *page, swp_entry_t entry)
 			if (val == SWAP_HAS_CACHE)
 				free_entries++;
 		}
-		if (!free_entries) {
-			for (i = 0; i < SWAPFILE_CLUSTER; i++)
-				map[i] &= ~SWAP_HAS_CACHE;
-		}
 		cluster_clear_huge(ci);
-		unlock_cluster(ci);
 		if (free_entries == SWAPFILE_CLUSTER) {
+			unlock_cluster_or_swap_info(si, ci);
 			spin_lock(&si->lock);
 			ci = lock_cluster(si, offset);
 			memset(map, 0, SWAPFILE_CLUSTER);
@@ -1311,12 +1307,16 @@ void put_swap_page(struct page *page, swp_entry_t entry)
 			return;
 		}
 	}
-	if (size == 1 || free_entries) {
-		for (i = 0; i < size; i++, entry.val++) {
-			if (!__swap_entry_free(si, entry, SWAP_HAS_CACHE))
-				free_swap_slot(entry);
+	for (i = 0; i < size; i++, entry.val++) {
+		if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE)) {
+			unlock_cluster_or_swap_info(si, ci);
+			free_swap_slot(entry);
+			if (i == size - 1)
+				return;
+			lock_cluster_or_swap_info(si, offset);
 		}
 	}
+	unlock_cluster_or_swap_info(si, ci);
 }
 
 #ifdef CONFIG_THP_SWAP
-- 
2.16.4

