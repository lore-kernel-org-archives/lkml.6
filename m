Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24CFECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1D920827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1D920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeKHR6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:58:03 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:32583 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbeKHR6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:58:03 -0500
X-IronPort-AV: E=Sophos;i="5.54,478,1534789800"; 
   d="scan'208";a="233248"
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Nov 2018 13:53:26 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9070"; a="5699124"
Received: from blr-ubuntu-104.ap.qualcomm.com (HELO blr-ubuntu-104.qualcomm.com) ([10.79.40.64])
  by ironmsg01-blr.qualcomm.com with ESMTP; 08 Nov 2018 13:53:25 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id 6FA5923A8; Thu,  8 Nov 2018 13:53:25 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        khlebnikov@yandex-team.ru, minchan@kernel.org, mhocko@kernel.org,
        vbabka@suse.cz, osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     getarunks@gmail.com, Arun KS <arunks@codeaurora.org>
Subject: [PATCH v3 4/4] mm: Remove managed_page_count spinlock
Date:   Thu,  8 Nov 2018 13:53:18 +0530
Message-Id: <1541665398-29925-5-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541665398-29925-1-git-send-email-arunks@codeaurora.org>
References: <1541665398-29925-1-git-send-email-arunks@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now totalram_pages and managed_pages are atomic varibles. No need
of managed_page_count spinlock.

Signed-off-by: Arun KS <arunks@codeaurora.org>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
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
index f8b64cc..26c5e14 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -122,9 +122,6 @@
 };
 EXPORT_SYMBOL(node_states);
 
-/* Protect totalram_pages and zone->managed_pages */
-static DEFINE_SPINLOCK(managed_page_count_lock);
-
 atomic_long_t _totalram_pages __read_mostly;
 EXPORT_SYMBOL(_totalram_pages);
 unsigned long totalreserve_pages __read_mostly;
@@ -7065,14 +7062,12 @@ static int __init cmdline_parse_movablecore(char *p)
 
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

