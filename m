Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA60C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F0A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F0A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeLKIvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:51:22 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:57408 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKIvW (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 11 Dec 2018 03:51:22 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 11 Dec 2018 09:51:20 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Tue, 11 Dec 2018 08:50:48 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, pasha.tatashin@soleen.com,
        dan.j.williams@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm, memory_hotplug: Don't bail out in do_migrate_range prematurely
Date:   Tue, 11 Dec 2018 09:50:42 +0100
Message-Id: <20181211085042.2696-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Issue debugged in 4d0c7db96 ("hwpoison, memory_hotplug: allow hwpoisoned
pages to be offlined") has proved that.
During the debugging of that issue, it was noticed that if
do_migrate_ranges() fails to isolate a single page, we will
just discard the work we have done so far and bail out, which means
that scan_movable_pages() will find again the same set of pages.

Instead, we can just skip the error, keep isolating as much pages
as possible and then proceed with the call to migrate_pages().
This will allow us to do some work at least.

There is no danger in the skipped pages to be lost, because
scan_movable_pages() will give us them as they could not
be isolated and therefore migrated.

Although this patch has proved to be useful when dealing with
4d0c7db96 because it allows us to move forward as long as the
page is not in LRU, we still need 4d0c7db96
("hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined")
to handle the LRU case and the unmapping of the page if needed.
So, this is just a follow-up cleanup.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 86ab673fc4e3..804d0280d2ab 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1339,7 +1339,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 	unsigned long pfn;
 	struct page *page;
 	int move_pages = NR_OFFLINE_AT_ONCE_PAGES;
-	int not_managed = 0;
 	int ret = 0;
 	LIST_HEAD(source);
 
@@ -1395,25 +1394,9 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 				inc_node_page_state(page, NR_ISOLATED_ANON +
 						    page_is_file_cache(page));
 
-		} else {
-			pr_warn("failed to isolate pfn %lx\n", pfn);
-			dump_page(page, "isolation failed");
-			put_page(page);
-			/* Because we don't have big zone->lock. we should
-			   check this again here. */
-			if (page_count(page)) {
-				not_managed++;
-				ret = -EBUSY;
-				break;
-			}
 		}
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
@@ -1426,7 +1409,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			putback_movable_pages(&source);
 		}
 	}
-out:
+
 	return ret;
 }
 
-- 
2.13.7

