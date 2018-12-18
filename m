Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DFAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7771217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545125294;
	bh=GmP6gl+OnmPFIYtuoAXp78y31o6kcnPD8cNRViuQ5A8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NHbE5xfp02ONUAnO/xhpnN79Kp2B5AsX+2q93B3Sfi7hKDjkHD3KqEXLoETC5YtRC
	 o8uL+VEmF7PKSvRFaDrtJUMG8qXolbLvS3cpVdNBdN3oqUfskPIpYdRrmkKJwe8Fqd
	 SZ+3JFWuYdiZPj4WwfXZvJYteL4XZyVGSyC/Q9Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbeLRJ2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:28:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43735 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:28:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so7848199pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPvGr/wNcmr4Tb5YHQNZJ/6FEIYgCd53/p3Q1S9g57k=;
        b=WXvsUfktY2Yetg0Z2PHLIORXZf1zYurEejZQmuGtua0pik3lYlxSt2JPbDMTptNEmh
         J6ZQ5uSS1f68mdTF4e1yX+YXmRSJudN5+mYqe2RC+ixtJESwpYJx+pb5OrnHMVureNds
         YDM70T5tfn0jAqtMgoogLXEc7+vEmVmBeo+K5/2iZAJqQOpLuIObNBHkQ4G2zRfcAae6
         mKitHuYiIccsI8Nvf9Eya5Mco2mIIfuTuw7S1CLp2memd+hBTLbof37GqJdp4ofXgtX/
         a3mt68bpwD5r/ZX9P3nXHM8w0/jwf0rAEuW1m72/8S+/XHiufvySjir7/L5pPz5478wi
         iBCQ==
X-Gm-Message-State: AA+aEWbD4Hpa0cNjAxs/dlSTM6qfmY41D3JfJlihcVRl7SigZKYJbZ1y
        DM6VaQQ+5JvXGNSu+JYt9vN0tkoZ
X-Google-Smtp-Source: AFSGD/Xaz9uMk7WsmcIJdbAQH9qQtYEhhAXaorM6ebFAjvod2kBDUwADFe1b9pLyHaTLUZ7cmDeOvw==
X-Received: by 2002:a62:30c3:: with SMTP id w186mr16023767pfw.39.1545125291692;
        Tue, 18 Dec 2018 01:28:11 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h9sm19484073pgd.53.2018.12.18.01.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 01:28:10 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm: do not report isolation failures for CMA pages
Date:   Tue, 18 Dec 2018 10:28:02 +0100
Message-Id: <20181218092802.31429-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Heiko has complained that his log is swamped by warnings from has_unmovable_pages
[   20.536664] page dumped because: has_unmovable_pages
[   20.536792] page:000003d081ff4080 count:1 mapcount:0 mapping:000000008ff88600 index:0x0 compound_mapcount: 0
[   20.536794] flags: 0x3fffe0000010200(slab|head)
[   20.536795] raw: 03fffe0000010200 0000000000000100 0000000000000200 000000008ff88600
[   20.536796] raw: 0000000000000000 0020004100000000 ffffffff00000001 0000000000000000
[   20.536797] page dumped because: has_unmovable_pages
[   20.536814] page:000003d0823b0000 count:1 mapcount:0 mapping:0000000000000000 index:0x0
[   20.536815] flags: 0x7fffe0000000000()
[   20.536817] raw: 07fffe0000000000 0000000000000100 0000000000000200 0000000000000000
[   20.536818] raw: 0000000000000000 0000000000000000 ffffffff00000001 0000000000000000

which are not triggered by the memory hotplug but rather CMA allocator.
The original idea behind dumping the page state for all call paths was
that these messages will be helpful debugging failures. From the above
it seems that this is not the case for the CMA path because we are
lacking much more context. E.g the second reported page might be a CMA
allocated page. It is still interesting to see a slab page in the CMA
area but it is hard to tell whether this is bug from the above output
alone.

Address this issue by dumping the page state only on request. Both
start_isolate_page_range and has_unmovable_pages already have an
argument to ignore hwpoison pages so make this argument more generic and
turn it into flags and allow callers to combine non-default modes into a
mask. While we are at it, has_unmovable_pages call from is_pageblock_removable_nolock
(sysfs removable file) is questionable to report the failure so drop it
from there as well.

Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi,
this is triggered by [1]. I think it should go as a separate patch
rathen than folded in to [2] because it gives a more context for future
reference but I will not insist of course.

Implementation wise I went with the simplest patch but if there is a
strong feeling that we need a dedicated enum then I will do that. The
API is quite low level so I didn't feel an urge to do that myself.

[1] http://lkml.kernel.org/r/20181217155922.GC3560@osiris
[2] http://lkml.kernel.org/r/20181116083020.20260-6-mhocko@kernel.org

 include/linux/page-isolation.h | 11 +++++++++--
 mm/memory_hotplug.c            |  5 +++--
 mm/page_alloc.c                | 11 +++++------
 mm/page_isolation.c            | 10 ++++------
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 4ae347cbc36d..4eb26d278046 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -30,8 +30,11 @@ static inline bool is_migrate_isolate(int migratetype)
 }
 #endif
 
+#define SKIP_HWPOISON	0x1
+#define REPORT_FAILURE	0x2
+
 bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
-			 int migratetype, bool skip_hwpoisoned_pages);
+			 int migratetype, int flags);
 void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable);
@@ -44,10 +47,14 @@ int move_freepages_block(struct zone *zone, struct page *page,
  * For isolating all pages in the range finally, the caller have to
  * free all pages in the range. test_page_isolated() can be used for
  * test it.
+ *
+ * The following flags are allowed (they can be combined in a bit mask)
+ * SKIP_HWPOISON - ignore hwpoison pages
+ * REPORT_FAILURE - report details about the failure to isolate the range
  */
 int
 start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			 unsigned migratetype, bool skip_hwpoisoned_pages);
+			 unsigned migratetype, int flags);
 
 /*
  * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c82193db4be6..8537429d33a6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1226,7 +1226,7 @@ static bool is_pageblock_removable_nolock(struct page *page)
 	if (!zone_spans_pfn(zone, pfn))
 		return false;
 
-	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, true);
+	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, SKIP_HWPOISON);
 }
 
 /* Checks if this range of memory is likely to be hot-removable. */
@@ -1577,7 +1577,8 @@ static int __ref __offline_pages(unsigned long start_pfn,
 
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
-				       MIGRATE_MOVABLE, true);
+				       MIGRATE_MOVABLE,
+				       SKIP_HWPOISON | REPORT_FAILURE);
 	if (ret) {
 		mem_hotplug_done();
 		reason = "failure to isolate range";
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ec2c7916dc2d..ee4043419791 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7754,8 +7754,7 @@ void *__init alloc_large_system_hash(const char *tablename,
  * race condition. So you can't expect this function should be exact.
  */
 bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
-			 int migratetype,
-			 bool skip_hwpoisoned_pages)
+			 int migratetype, int flags)
 {
 	unsigned long pfn, iter, found;
 
@@ -7818,7 +7817,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		 * The HWPoisoned page may be not in buddy system, and
 		 * page_count() is not 0.
 		 */
-		if (skip_hwpoisoned_pages && PageHWPoison(page))
+		if ((flags & SKIP_HWPOISON) && PageHWPoison(page))
 			continue;
 
 		if (__PageMovable(page))
@@ -7845,7 +7844,8 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 	return false;
 unmovable:
 	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-	dump_page(pfn_to_page(pfn+iter), "unmovable page");
+	if (flags & REPORT_FAILURE)
+		dump_page(pfn_to_page(pfn+iter), "unmovable page");
 	return true;
 }
 
@@ -7972,8 +7972,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 */
 
 	ret = start_isolate_page_range(pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype,
-				       false);
+				       pfn_max_align_up(end), migratetype, 0);
 	if (ret)
 		return ret;
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 43e085608846..ce323e56b34d 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -15,8 +15,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_isolation.h>
 
-static int set_migratetype_isolate(struct page *page, int migratetype,
-				bool skip_hwpoisoned_pages)
+static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
 {
 	struct zone *zone;
 	unsigned long flags, pfn;
@@ -60,8 +59,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype,
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype,
-				 skip_hwpoisoned_pages))
+	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype, flags))
 		ret = 0;
 
 	/*
@@ -185,7 +183,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * prevents two threads from simultaneously working on overlapping ranges.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     unsigned migratetype, bool skip_hwpoisoned_pages)
+			     unsigned migratetype, int flags)
 {
 	unsigned long pfn;
 	unsigned long undo_pfn;
@@ -199,7 +197,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
 		if (page &&
-		    set_migratetype_isolate(page, migratetype, skip_hwpoisoned_pages)) {
+		    set_migratetype_isolate(page, migratetype, flags)) {
 			undo_pfn = pfn;
 			goto undo;
 		}
-- 
2.19.2

