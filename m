Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A139AC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E911320672
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E911320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeKUAMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:12:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42763 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKUAMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:12:50 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so1942373edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPA8FPoPMv+gmc6SS8CXiLWc7PLkSqS/f1EA6JDY91M=;
        b=RKXv2LtdA82XTmWXCkc0NN+jtkH0YP1KQlJDX2r/fmUVnxyNphBALPtNRCBKwMefmB
         qwh+5AFrD9GQyiQr4pchgKl8kpjckv9uF9oZIJTsoz7Hh85c0eRflfKx8slWNYBRinEw
         mTrbY81aYDBnLl8Dr1wydFea17YPDED7Fh44ciniTkfWEzJ5yGqSILcu+tNyeiRERNLa
         lwT+pucNRkQPg3gG/s4ZzpG6U9HHxeJmawfUpLbL5naPo90asEyufGMoYkj+Nj+uv8F1
         8//M7LE0ZP3FMDlWEszCqg8mY3rsZzurLjqRbhc0IMc//33Uvtdi4cm9Nf7+VlYYYKra
         yN9g==
X-Gm-Message-State: AA+aEWaX6F+jr0akfXJk4vz3bZA4ZdMIdE8SXH+mHXT1Ka9OT+PtjzyC
        P1KbNz7qMNm7ToXlVcWcE4NrShYI
X-Google-Smtp-Source: AFSGD/UXIyPh/3c7XVeJ+kNuWyZkxIcVYxxw03A3PtUVq8tllJKzM6JPgEjUx2ox3Ct5oBx7q6ySfg==
X-Received: by 2002:a50:a4fc:: with SMTP id x57mr2265364edb.229.1542721415966;
        Tue, 20 Nov 2018 05:43:35 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 49sm8428786edz.59.2018.11.20.05.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:43:35 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 1/3] mm, memory_hotplug: try to migrate full section worth of pages
Date:   Tue, 20 Nov 2018 14:43:21 +0100
Message-Id: <20181120134323.13007-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120134323.13007-1-mhocko@kernel.org>
References: <20181120134323.13007-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

do_migrate_range has been limiting the number of pages to migrate to 256
for some reason which is not documented. Even if the limit made some
sense back then when it was introduced it doesn't really serve a good
purpose these days. If the range contains huge pages then
we break out of the loop too early and go through LRU and pcp
caches draining and scan_movable_pages is quite suboptimal.

The only reason to limit the number of pages I can think of is to reduce
the potential time to react on the fatal signal. But even then the
number of pages is a questionable metric because even a single page
might migration block in a non-killable state (e.g. __unmap_and_move).

Remove the limit and offline the full requested range (this is one
membblock worth of pages with the current code). Should we ever get a
report that offlining takes too long to react on fatal signal then we
should rather fix the core migration to use killable waits and bailout
on a signal.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c82193db4be6..6263c8cd4491 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1339,18 +1339,16 @@ static struct page *new_node_page(struct page *page, unsigned long private)
 	return new_page_nodemask(page, nid, &nmask);
 }
 
-#define NR_OFFLINE_AT_ONCE_PAGES	(256)
 static int
 do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
 	struct page *page;
-	int move_pages = NR_OFFLINE_AT_ONCE_PAGES;
 	int not_managed = 0;
 	int ret = 0;
 	LIST_HEAD(source);
 
-	for (pfn = start_pfn; pfn < end_pfn && move_pages > 0; pfn++) {
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		if (!pfn_valid(pfn))
 			continue;
 		page = pfn_to_page(pfn);
@@ -1362,8 +1360,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 				ret = -EBUSY;
 				break;
 			}
-			if (isolate_huge_page(page, &source))
-				move_pages -= 1 << compound_order(head);
+			isolate_huge_page(page, &source);
 			continue;
 		} else if (PageTransHuge(page))
 			pfn = page_to_pfn(compound_head(page))
@@ -1382,7 +1379,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (!ret) { /* Success */
 			put_page(page);
 			list_add_tail(&page->lru, &source);
-			move_pages--;
 			if (!__PageMovable(page))
 				inc_node_page_state(page, NR_ISOLATED_ANON +
 						    page_is_file_cache(page));
-- 
2.19.1

