Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD1C41535
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54930214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54930214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeJJOsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:48:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:22995 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeJJOsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:48:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 00:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,363,1534834800"; 
   d="scan'208";a="93870015"
Received: from yhuang-mobile.sh.intel.com ([10.239.198.87])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2018 00:19:21 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH -V6 10/21] swap: Support to count THP swapin and its fallback
Date:   Wed, 10 Oct 2018 15:19:13 +0800
Message-Id: <20181010071924.18767-11-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181010071924.18767-1-ying.huang@intel.com>
References: <20181010071924.18767-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 new /proc/vmstat fields are added, "thp_swapin" and
"thp_swapin_fallback" to count swapin a THP from swap device in one
piece and fallback to normal page swapin.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  8 ++++++++
 include/linux/vm_event_item.h              |  2 ++
 mm/huge_memory.c                           |  4 +++-
 mm/page_io.c                               | 15 ++++++++++++---
 mm/vmstat.c                                |  2 ++
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 7ab93a8404b9..85e33f785fd7 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -364,6 +364,14 @@ thp_swpout_fallback
 	Usually because failed to allocate some continuous swap space
 	for the huge page.
 
+thp_swpin
+	is incremented every time a huge page is swapin in one piece
+	without splitting.
+
+thp_swpin_fallback
+	is incremented if a huge page has to be split during swapin.
+	Usually because failed to allocate a huge page.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 47a3441cf4c4..c20b655cfdcc 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -88,6 +88,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_ZERO_PAGE_ALLOC_FAILED,
 		THP_SWPOUT,
 		THP_SWPOUT_FALLBACK,
+		THP_SWPIN,
+		THP_SWPIN_FALLBACK,
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 		BALLOON_INFLATE,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fbc9c9e30992..8efcc84fb4b0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1715,8 +1715,10 @@ int do_huge_pmd_swap_page(struct vm_fault *vmf, pmd_t orig_pmd)
 				/* swapoff occurs under us */
 				} else if (ret == -EINVAL)
 					ret = 0;
-				else
+				else {
+					count_vm_event(THP_SWPIN_FALLBACK);
 					goto fallback;
+				}
 			}
 			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
 			goto out;
diff --git a/mm/page_io.c b/mm/page_io.c
index 573d3663d846..bcc2da750590 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -348,6 +348,15 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	return ret;
 }
 
+static inline void count_swpin_vm_event(struct page *page)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (unlikely(PageTransHuge(page)))
+		count_vm_event(THP_SWPIN);
+#endif
+	count_vm_events(PSWPIN, hpage_nr_pages(page));
+}
+
 int swap_readpage(struct page *page, bool synchronous)
 {
 	struct bio *bio;
@@ -371,7 +380,7 @@ int swap_readpage(struct page *page, bool synchronous)
 
 		ret = mapping->a_ops->readpage(swap_file, page);
 		if (!ret)
-			count_vm_event(PSWPIN);
+			count_swpin_vm_event(page);
 		return ret;
 	}
 
@@ -382,7 +391,7 @@ int swap_readpage(struct page *page, bool synchronous)
 			unlock_page(page);
 		}
 
-		count_vm_event(PSWPIN);
+		count_swpin_vm_event(page);
 		return 0;
 	}
 
@@ -401,7 +410,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	get_task_struct(current);
 	bio->bi_private = current;
 	bio_set_op_attrs(bio, REQ_OP_READ, 0);
-	count_vm_event(PSWPIN);
+	count_swpin_vm_event(page);
 	bio_get(bio);
 	qc = submit_bio(bio);
 	while (synchronous) {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d08ed044759d..823856fae136 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1264,6 +1264,8 @@ const char * const vmstat_text[] = {
 	"thp_zero_page_alloc_failed",
 	"thp_swpout",
 	"thp_swpout_fallback",
+	"thp_swpin",
+	"thp_swpin_fallback",
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 	"balloon_inflate",
-- 
2.16.4

