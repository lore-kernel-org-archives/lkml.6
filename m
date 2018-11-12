Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A43C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0029216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0029216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbeKLP76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:59:58 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:17745 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731704AbeKLP75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:59:57 -0500
X-IronPort-AV: E=Sophos;i="5.54,494,1534789800"; 
   d="scan'208";a="282851"
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Nov 2018 11:38:10 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9074"; a="5747618"
Received: from blr-ubuntu-104.ap.qualcomm.com (HELO blr-ubuntu-104.qualcomm.com) ([10.79.40.64])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Nov 2018 11:38:08 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id 96C2924B7; Mon, 12 Nov 2018 11:38:08 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vatsa@codeaurora.org,
        Arun KS <arunks@codeaurora.org>
Subject: [PATCH v4 4/4] mm: Remove managed_page_count spinlock
Date:   Mon, 12 Nov 2018 11:37:49 +0530
Message-Id: <1542002869-16704-5-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542002869-16704-1-git-send-email-arunks@codeaurora.org>
References: <1542002869-16704-1-git-send-email-arunks@codeaurora.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that totalram_pages and managed_pages are atomic varibles, no need
of managed_page_count spinlock. The lock had really a weak consistency
guarantee. It hasn't been used for anything but the update but no reader
actually cares about all the values being updated to be in sync.

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

