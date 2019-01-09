Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642EFC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B93A21783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbfAILQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:16:13 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:42469 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730111AbfAILQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:16:12 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 12906B89F4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 11:16:11 +0000 (GMT)
Received: (qmail 12389 invoked from network); 9 Jan 2019 11:16:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jan 2019 11:16:10 -0000
Date:   Wed, 9 Jan 2019 11:16:09 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>, kirill@shutemov.name,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm, compaction: Round-robin the order while searching the
 free lists for a target -fix
Message-ID: <20190109111609.GW31517@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter reported the following static checker warning:

        mm/compaction.c:1252 next_search_order()
        warn: impossible condition '(cc->search_order < 0) => (0-u16max < 0)'

While a negative order never makes sense, the control flow is
easier if search_order is signed. This is a fix to the mmotm patch
broken-out/mm-compaction-round-robin-the-order-while-searching-the-free-lists-for-a-target.patch

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index d028abd8a8f3..e74dbc257550 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -192,7 +192,7 @@ struct compact_control {
 	unsigned long total_migrate_scanned;
 	unsigned long total_free_scanned;
 	unsigned short fast_search_fail;/* failures to use free list searches */
-	unsigned short search_order;	/* order to start a fast search at */
+	short search_order;		/* order to start a fast search at */
 	const gfp_t gfp_mask;		/* gfp mask of a direct compactor */
 	int order;			/* order a direct compactor needs */
 	int migratetype;		/* migratetype of direct compactor */
