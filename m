Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E84AECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24996214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24996214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbeGMCZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:25:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:26096 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387972AbeGMCZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:25:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 19:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,346,1526367600"; 
   d="scan'208";a="54012108"
Received: from yongjuns-mobl2.ccr.corp.intel.com (HELO yhuang6-ux31a.ccr.corp.intel.com) ([10.254.213.67])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2018 19:12:37 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: [PATCH] mm, swap: Make CONFIG_THP_SWAP depends on CONFIG_SWAP
Date:   Fri, 13 Jul 2018 10:12:28 +0800
Message-Id: <20180713021228.439-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

CONFIG_THP_SWAP should depend on CONFIG_SWAP, because it's
unreasonable to optimize swapping for THP (Transparent Huge Page)
without basic swapping support.

In original code, when CONFIG_SWAP=n and CONFIG_THP_SWAP=y,
split_swap_cluster() will not be built because it is in swapfile.c,
but it will be called in huge_memory.c.  This doesn't trigger a build
error in practice because the call site is enclosed by
PageSwapCache(), which is defined to be constant 0 when CONFIG_SWAP=n.
But this is fragile and should be fixed.

The comments are fixed too to reflect the latest progress.

Fixes: 38d8b4e6bdc8 ("mm, THP, swap: delay splitting THP during swap out")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index b78e7cd4e9fe..97114c94239c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -419,10 +419,11 @@ config ARCH_WANTS_THP_SWAP
 
 config THP_SWAP
 	def_bool y
-	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP
+	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP && SWAP
 	help
 	  Swap transparent huge pages in one piece, without splitting.
-	  XXX: For now this only does clustered swap space allocation.
+	  XXX: For now, swap cluster backing transparent huge page
+	  will be split after swapout.
 
 	  For selection by architectures with reasonable THP sizes.
 
-- 
2.16.4

