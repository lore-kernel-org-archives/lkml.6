Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10AFC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCC320869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCC320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbeKGByc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:54:32 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:22830 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389375AbeKGBya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:54:30 -0500
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2018 20:54:22 EST
X-IronPort-AV: E=Sophos;i="5.54,472,1534789800"; 
   d="scan'208";a="277259"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Nov 2018 21:52:16 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9069"; a="1957400"
Received: from blr-ubuntu-104.ap.qualcomm.com (HELO blr-ubuntu-104.qualcomm.com) ([10.79.40.64])
  by ironmsg03-blr.qualcomm.com with ESMTP; 06 Nov 2018 21:52:17 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id C859531D5; Tue,  6 Nov 2018 21:52:15 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        khlebnikov@yandex-team.ru, minchan@kernel.org, mhocko@kernel.org,
        vbabka@suse.cz, osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     getarunks@gmail.com, Arun KS <arunks@codeaurora.org>
Subject: [PATCH v2 4/4] mm: Remove managed_page_count spinlock
Date:   Tue,  6 Nov 2018 21:51:50 +0530
Message-Id: <1541521310-28739-5-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541521310-28739-1-git-send-email-arunks@codeaurora.org>
References: <1541521310-28739-1-git-send-email-arunks@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now totalram_pages and managed_pages are atomic varibles. No need
of managed_page_count spinlock.

Signed-off-by: Arun KS <arunks@codeaurora.org>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/mmzone.h | 6 ------
 mm/page_alloc.c        | 5 -----
 2 files changed, 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e73dc31..c71b4d9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -428,12 +428,6 @@ struct zone {
 	 * Write access to present_pages at runtime should be protected by
 	 * mem_hotplug_begin/end(). Any reader who can't tolerant drift of
 	 * present_pages should get_online_mems() to get a stable value.
-	 *
-	 * Read access to managed_pages should be safe because it's unsigned
-	 * long. Write access to zone->managed_pages and totalram_pages are
-	 * protected by managed_page_count_lock at runtime. Idealy only
-	 * adjust_managed_page_count() should be used instead of directly
-	 * touching zone->managed_pages and totalram_pages.
 	 */
 	atomic_long_t		managed_pages;
 	unsigned long		spanned_pages;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2a42c3f..4d78bde 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -122,9 +122,6 @@
 };
 EXPORT_SYMBOL(node_states);
 
-/* Protect totalram_pages and zone->managed_pages */
-static DEFINE_SPINLOCK(managed_page_count_lock);
-
 atomic_long_t _totalram_pages __read_mostly;
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
@@ -7064,14 +7061,12 @@ static int __init cmdline_parse_movablecore(char *p)
 
 void adjust_managed_page_count(struct page *page, long count)
 {
-	spin_lock(&managed_page_count_lock);
 	atomic_long_add(count, &page_zone(page)->managed_pages);
 	totalram_pages_add(count);
 #ifdef CONFIG_HIGHMEM
 	if (PageHighMem(page))
 		totalhigh_pages_add(count);
 #endif
-	spin_unlock(&managed_page_count_lock);
 }
 EXPORT_SYMBOL(adjust_managed_page_count);
 
-- 
1.9.1

