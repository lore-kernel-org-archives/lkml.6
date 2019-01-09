Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639D1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0EC21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfAILNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:13:48 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:35774 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730569AbfAILNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:13:47 -0500
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id EE05F1C297A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 11:13:45 +0000 (GMT)
Received: (qmail 4583 invoked from network); 9 Jan 2019 11:13:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jan 2019 11:13:45 -0000
Date:   Wed, 9 Jan 2019 11:13:44 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm, compaction: Use free lists to quickly locate a migration
 target -fix
Message-ID: <20190109111344.GU31517@techsingularity.net>
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

Full compaction of a node passes in negative orders which can lead to array
boundary issues. While it could be addressed in the control flow of the
primary loop, it would be fragile so explicitly check for the condition.
This is a fix for the mmotm patch
broken-out/mm-compaction-use-free-lists-to-quickly-locate-a-migration-target.patch

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 9438f0564ed5..167ad0f5c2fe 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1206,6 +1206,10 @@ fast_isolate_freepages(struct compact_control *cc)
 	bool scan_start = false;
 	int order;
 
+	/* Full compaction passes in a negative order */
+	if (order <= 0)
+		return cc->free_pfn;
+
 	/*
 	 * If starting the scan, use a deeper search and use the highest
 	 * PFN found if a suitable one is not found.
