Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66401C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E002081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E002081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeKFP1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:27:10 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:41667 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729337AbeKFP1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:27:09 -0500
X-IronPort-AV: E=Sophos;i="5.54,470,1534789800"; 
   d="scan'208";a="231191"
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Nov 2018 11:33:34 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9068"; a="5671283"
Received: from blr-ubuntu-104.ap.qualcomm.com (HELO blr-ubuntu-104.qualcomm.com) ([10.79.40.64])
  by ironmsg01-blr.qualcomm.com with ESMTP; 06 Nov 2018 11:33:33 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id 67FC831C6; Tue,  6 Nov 2018 11:33:33 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
To:     arunks.linux@gmail.com, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     getarunks@gmail.com, Arun KS <arunks@codeaurora.org>
Subject: [PATCH v6 2/2] mm/page_alloc: remove software prefetching in __free_pages_core
Date:   Tue,  6 Nov 2018 11:33:14 +0530
Message-Id: <1541484194-1493-2-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541484194-1493-1-git-send-email-arunks@codeaurora.org>
References: <1541484194-1493-1-git-send-email-arunks@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They not only increase the code footprint, they actually make things
slower rather than faster. Remove them as contemporary hardware doesn't
need any hint.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Arun KS <arunks@codeaurora.org>
---
 mm/page_alloc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7cf503f..a1b9a6a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1270,14 +1270,10 @@ void __free_pages_core(struct page *page, unsigned int order)
 	struct page *p = page;
 	unsigned int loop;
 
-	prefetchw(p);
-	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
-		prefetchw(p + 1);
+	for (loop = 0; loop < nr_pages ; loop++, p++) {
 		__ClearPageReserved(p);
 		set_page_count(p, 0);
 	}
-	__ClearPageReserved(p);
-	set_page_count(p, 0);
 
 	page_zone(page)->managed_pages += nr_pages;
 	set_page_refcounted(page);
-- 
1.9.1

