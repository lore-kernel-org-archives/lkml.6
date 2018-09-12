Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB60C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC0B20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC0B20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeILFqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:46:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:22566 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbeILFqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:46:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 17:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="69283805"
Received: from unknown (HELO yhuang-mobile.sh.intel.com) ([10.239.198.87])
  by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2018 17:44:06 -0700
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
Subject: [PATCH -V5 RESEND 02/21] swap: Add __swap_duplicate_locked()
Date:   Wed, 12 Sep 2018 08:43:55 +0800
Message-Id: <20180912004414.22583-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180912004414.22583-1-ying.huang@intel.com>
References: <20180912004414.22583-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The part of __swap_duplicate() with lock held is separated into a new
function __swap_duplicate_locked().  Because we will add more logic
about the PMD swap mapping into __swap_duplicate() and keep the most
PTE swap mapping related logic in __swap_duplicate_locked().

Just mechanical code refactoring, there is no any functional change in
this patch.

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
 mm/swapfile.c | 63 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 97a1bd1a7c9a..6a570ef00fa7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3436,32 +3436,12 @@ void si_swapinfo(struct sysinfo *val)
 	spin_unlock(&swap_lock);
 }
 
-/*
- * Verify that a swap entry is valid and increment its swap map count.
- *
- * Returns error code in following case.
- * - success -> 0
- * - swp_entry is invalid -> EINVAL
- * - swp_entry is migration entry -> EINVAL
- * - swap-cache reference is requested but there is already one. -> EEXIST
- * - swap-cache reference is requested but the entry is not used. -> ENOENT
- * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
- */
-static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+static int __swap_duplicate_locked(struct swap_info_struct *p,
+				   unsigned long offset, unsigned char usage)
 {
-	struct swap_info_struct *p;
-	struct swap_cluster_info *ci;
-	unsigned long offset;
 	unsigned char count;
 	unsigned char has_cache;
-	int err = -EINVAL;
-
-	p = get_swap_device(entry);
-	if (!p)
-		goto out;
-
-	offset = swp_offset(entry);
-	ci = lock_cluster_or_swap_info(p, offset);
+	int err = 0;
 
 	count = p->swap_map[offset];
 
@@ -3471,12 +3451,11 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 	 */
 	if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
 		err = -ENOENT;
-		goto unlock_out;
+		goto out;
 	}
 
 	has_cache = count & SWAP_HAS_CACHE;
 	count &= ~SWAP_HAS_CACHE;
-	err = 0;
 
 	if (usage == SWAP_HAS_CACHE) {
 
@@ -3503,11 +3482,39 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 
 	p->swap_map[offset] = count | has_cache;
 
-unlock_out:
+out:
+	return err;
+}
+
+/*
+ * Verify that a swap entry is valid and increment its swap map count.
+ *
+ * Returns error code in following case.
+ * - success -> 0
+ * - swp_entry is invalid -> EINVAL
+ * - swp_entry is migration entry -> EINVAL
+ * - swap-cache reference is requested but there is already one. -> EEXIST
+ * - swap-cache reference is requested but the entry is not used. -> ENOENT
+ * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
+ */
+static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+{
+	struct swap_info_struct *p;
+	struct swap_cluster_info *ci;
+	unsigned long offset;
+	int err = -EINVAL;
+
+	p = get_swap_device(entry);
+	if (!p)
+		goto out;
+
+	offset = swp_offset(entry);
+	ci = lock_cluster_or_swap_info(p, offset);
+	err = __swap_duplicate_locked(p, offset, usage);
 	unlock_cluster_or_swap_info(p, ci);
+
+	put_swap_device(p);
 out:
-	if (p)
-		put_swap_device(p);
 	return err;
 }
 
-- 
2.16.4

