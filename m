Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D532C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23282085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23282085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeJZTiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:38:10 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:46435 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727655AbeJZTiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:38:09 -0400
X-IronPort-AV: E=Sophos;i="5.54,427,1534789800"; 
   d="scan'208";a="219938"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Oct 2018 16:31:30 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9057"; a="1798199"
Received: from blr-ubuntu-104.ap.qualcomm.com (HELO blr-ubuntu-104.qualcomm.com) ([10.79.40.64])
  by ironmsg03-blr.qualcomm.com with ESMTP; 26 Oct 2018 16:31:30 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id 1BC5E2F15; Fri, 26 Oct 2018 16:31:29 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arun KS <arunks@codeaurora.org>
Subject: [PATCH v1 4/4] mm: Remove managed_page_count spinlock
Date:   Fri, 26 Oct 2018 16:31:02 +0530
Message-Id: <1540551662-26458-5-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540551662-26458-1-git-send-email-arunks@codeaurora.org>
References: <1540551662-26458-1-git-send-email-arunks@codeaurora.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now totalram_pages and managed_pages are atomic varibles. No need
of managed_page_count spinlock.

Signed-off-by: Arun KS <arunks@codeaurora.org>
---
 include/linux/mmzone.h | 6 ------
 mm/page_alloc.c        | 5 -----
 2 files changed, 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 597b0c7..aa960f6 100644
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
index af832de..e29e78f 100644
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
@@ -7062,14 +7059,12 @@ static int __init cmdline_parse_movablecore(char *p)
 
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

