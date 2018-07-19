Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E292DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A595320693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A595320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbeGSJbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:31:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:10716 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbeGSJbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:31:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 01:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,374,1526367600"; 
   d="scan'208";a="76038329"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.195.246])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2018 01:49:05 -0700
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
Subject: [PATCH v3 7/8] swap: Add __swap_entry_free_locked()
Date:   Thu, 19 Jul 2018 16:48:41 +0800
Message-Id: <20180719084842.11385-8-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180719084842.11385-1-ying.huang@intel.com>
References: <20180719084842.11385-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The part of __swap_entry_free() with lock held is separated into a new
function __swap_entry_free_locked().  Because we want to reuse that
piece of code in some other places.

Just mechanical code refactoring, there is no any functional change in
this function.

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
 mm/swapfile.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 318ceb527c78..d313f7512d26 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1184,16 +1184,13 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
-static unsigned char __swap_entry_free(struct swap_info_struct *p,
-				       swp_entry_t entry, unsigned char usage)
+static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
+					      unsigned long offset,
+					      unsigned char usage)
 {
-	struct swap_cluster_info *ci;
-	unsigned long offset = swp_offset(entry);
 	unsigned char count;
 	unsigned char has_cache;
 
-	ci = lock_cluster_or_swap_info(p, offset);
-
 	count = p->swap_map[offset];
 
 	has_cache = count & SWAP_HAS_CACHE;
@@ -1221,6 +1218,17 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
 	usage = count | has_cache;
 	p->swap_map[offset] = usage ? : SWAP_HAS_CACHE;
 
+	return usage;
+}
+
+static unsigned char __swap_entry_free(struct swap_info_struct *p,
+				       swp_entry_t entry, unsigned char usage)
+{
+	struct swap_cluster_info *ci;
+	unsigned long offset = swp_offset(entry);
+
+	ci = lock_cluster_or_swap_info(p, offset);
+	usage = __swap_entry_free_locked(p, offset, usage);
 	unlock_cluster_or_swap_info(p, ci);
 
 	return usage;
-- 
2.16.4

