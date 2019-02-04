Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7D6C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E410214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfBDIzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:55:17 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:60718 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbfBDIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:55:16 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 1549898686
        for <linux-kernel@vger.kernel.org>; Mon,  4 Feb 2019 08:55:15 +0000 (UTC)
Received: (qmail 18787 invoked from network); 4 Feb 2019 08:55:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Feb 2019 08:55:14 -0000
Date:   Mon, 4 Feb 2019 08:55:13 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [PATCH] mm, compaction: Use free lists to quickly locate a migration
 source -fix
Message-ID: <20190204085513.GK9565@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-10-mgorman@techsingularity.net>
 <4a6ae9fc-a52b-4300-0edb-a0f4169c314a@suse.cz>
 <20190201150614.GJ9565@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190201150614.GJ9565@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil correctly pointed out that when a fast search fails and cc->migrate_pfn
is reinitialised to the lowest PFN found that the caller does not use the updated
PFN.

This is a fix for the mmotm patch
mm-compaction-use-free-lists-to-quickly-locate-a-migration-source.patch

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

diff --git a/mm/compaction.c b/mm/compaction.c
index 92d10eb3d1c7..d249f257da7e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1238,14 +1238,16 @@ update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
 	cc->fast_start_pfn = min(cc->fast_start_pfn, pfn);
 }
 
-static inline void
+static inline unsigned long
 reinit_migrate_pfn(struct compact_control *cc)
 {
 	if (!cc->fast_start_pfn || cc->fast_start_pfn == ULONG_MAX)
-		return;
+		return cc->migrate_pfn;
 
 	cc->migrate_pfn = cc->fast_start_pfn;
 	cc->fast_start_pfn = ULONG_MAX;
+
+	return cc->migrate_pfn;
 }
 
 /*
@@ -1361,7 +1363,7 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 	 * that had free pages as the basis for starting a linear scan.
 	 */
 	if (pfn == cc->migrate_pfn)
-		reinit_migrate_pfn(cc);
+		pfn = reinit_migrate_pfn(cc);
 
 	return pfn;
 }
