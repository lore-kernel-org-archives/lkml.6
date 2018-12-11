Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADECC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6800F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6800F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeLKNx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:53:27 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:58188 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeLKNx0 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 11 Dec 2018 08:53:26 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 11 Dec 2018 14:53:24 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Tue, 11 Dec 2018 13:53:20 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, pasha.tatashin@soleen.com,
        dan.j.williams@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2] mm, memory_hotplug: Don't bail out in do_migrate_range prematurely
Date:   Tue, 11 Dec 2018 14:53:12 +0100
Message-Id: <20181211135312.27034-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
        - Keep branch to decrease refcount and print out
          the failed pfn/page
        - Modified changelog per Michal's feedback
        - move put_page() out of the if/else branch

---
From f81da873be9a5b7845249d1e62a423f054c487d5 Mon Sep 17 00:00:00 2001
From: Oscar Salvador <osalvador@suse.com>
Date: Tue, 11 Dec 2018 11:45:19 +0100
Subject: [PATCH] mm, memory_hotplug: Don't bail out in do_migrate_range
 prematurely

do_migrate_ranges() takes a memory range and tries to isolate the
pages to put them into a list.
This list will be later on used in migrate_pages() to know
the pages we need to migrate.

Currently, if we fail to isolate a single page, we put all already
isolated pages back to their LRU and we bail out from the function.
This is quite suboptimal, as this will force us to start over again
because scan_movable_pages will give us the same range.
If there is no chance that we can isolate that page, we will loop here
forever.

Issue debugged in [1] has proved that.
During the debugging of that issue, it was noticed that if
do_migrate_ranges() fails to isolate a single page, we will
just discard the work we have done so far and bail out, which means
that scan_movable_pages() will find again the same set of pages.

Instead, we can just skip the error, keep isolating as much pages
as possible and then proceed with the call to migrate_pages().

This will allow us to do as much work as possible at once.

[1] https://lkml.org/lkml/2018/12/6/324

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 86ab673fc4e3..68e740b1768e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1339,7 +1339,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 	unsigned long pfn;
 	struct page *page;
 	int move_pages = NR_OFFLINE_AT_ONCE_PAGES;
-	int not_managed = 0;
 	int ret = 0;
 	LIST_HEAD(source);
 
@@ -1388,7 +1387,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		else
 			ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
 		if (!ret) { /* Success */
-			put_page(page);
 			list_add_tail(&page->lru, &source);
 			move_pages--;
 			if (!__PageMovable(page))
@@ -1398,22 +1396,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		} else {
 			pr_warn("failed to isolate pfn %lx\n", pfn);
 			dump_page(page, "isolation failed");
-			put_page(page);
-			/* Because we don't have big zone->lock. we should
-			   check this again here. */
-			if (page_count(page)) {
-				not_managed++;
-				ret = -EBUSY;
-				break;
-			}
 		}
+		put_page(page);
 	}
 	if (!list_empty(&source)) {
-		if (not_managed) {
-			putback_movable_pages(&source);
-			goto out;
-		}
-
 		/* Allocate a new page from the nearest neighbor node */
 		ret = migrate_pages(&source, new_node_page, NULL, 0,
 					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
@@ -1426,7 +1412,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			putback_movable_pages(&source);
 		}
 	}
-out:
+
 	return ret;
 }
 
-- 
2.13.7

