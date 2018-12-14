Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6D3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF26620675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbeLNXDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:03:14 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:41545 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729029AbeLNXDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:03:13 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 5F3B91C2072
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 23:03:11 +0000 (GMT)
Received: (qmail 31182 invoked from network); 14 Dec 2018 23:03:11 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPA; 14 Dec 2018 23:03:11 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 02/14] mm, compaction: Rearrange compact_control
Date:   Fri, 14 Dec 2018 23:02:58 +0000
Message-Id: <20181214230310.572-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181214230310.572-1-mgorman@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compact_control spans two cache lines with write-intensive lines on
both. Rearrange so the most write-intensive fields are in the same
cache line. This has a negligible impact on the overall performance of
compaction and is more a tidying exercise than anything.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5564841fce36..867af5425432 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -184,14 +184,14 @@ extern int user_min_free_kbytes;
 struct compact_control {
 	struct list_head freepages;	/* List of free pages to migrate to */
 	struct list_head migratepages;	/* List of pages being migrated */
-	struct zone *zone;
 	unsigned int nr_freepages;	/* Number of isolated free pages */
 	unsigned int nr_migratepages;	/* Number of pages to migrate */
-	unsigned long total_migrate_scanned;
-	unsigned long total_free_scanned;
 	unsigned long free_pfn;		/* isolate_freepages search base */
 	unsigned long migrate_pfn;	/* isolate_migratepages search base */
 	unsigned long last_migrated_pfn;/* Not yet flushed page being freed */
+	struct zone *zone;
+	unsigned long total_migrate_scanned;
+	unsigned long total_free_scanned;
 	const gfp_t gfp_mask;		/* gfp mask of a direct compactor */
 	int order;			/* order a direct compactor needs */
 	int migratetype;		/* migratetype of direct compactor */
-- 
2.16.4

