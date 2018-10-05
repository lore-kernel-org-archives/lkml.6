Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A072C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BCE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BCE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeJEPIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:08:02 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:28057 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727073AbeJEPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:08:01 -0400
X-IronPort-AV: E=Sophos;i="5.54,343,1534789800"; 
   d="scan'208";a="197671"
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Oct 2018 13:40:22 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9036"; a="1466215"
Received: from blr-ubuntu-104.ap.qualcomm.com (HELO blr-ubuntu-104.qualcomm.com) ([10.79.40.64])
  by ironmsg02-blr.qualcomm.com with ESMTP; 05 Oct 2018 13:40:22 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id 05F742391; Fri,  5 Oct 2018 13:40:20 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org
Cc:     vatsa@codeaurora.org, vinmenon@codeaurora.org, getarunks@gmail.com,
        Arun KS <arunks@codeaurora.org>
Subject: [PATCH v5 2/2] mm/page_alloc: remove software prefetching in __free_pages_core
Date:   Fri,  5 Oct 2018 13:40:06 +0530
Message-Id: <1538727006-5727-2-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
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
index 7ab5274..90db431 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1258,14 +1258,10 @@ void __free_pages_core(struct page *page, unsigned int order)
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

