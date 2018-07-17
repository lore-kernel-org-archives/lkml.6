Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591F7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061792086B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8OFWLz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061792086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeGQGDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:03:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43607 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeGQGDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:03:40 -0400
Received: by mail-pl0-f65.google.com with SMTP id o7-v6so5940883plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 22:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LA8Tezz09N+DfkcA4tB6goY21unWtbHDeihcHLz6flA=;
        b=G8OFWLz/MAhFjWUKmE4yfa4s0LZ7UM/SHS0BGU6PMer5oZW/HZgpzxiRf0O6UvtndP
         MCAtHAPVFCYTYeOmlVQWap3loE9GIlc3zbyc1uxCRo5XWlIeh+b3NIUpXsWldmg0lAzL
         yUCegzbaPDDmcIjInp/Zg8OWAZrIr8ikrmtoxzzCZdAgJkvzVbJ3E8QWHr/5GXf7bHvq
         AmYEzXm9/k9zqHASEISgufDjBqKykSze8VK4x0mIhXUN6seOy9zWUV1NDz5yeiT9h8FU
         tOCM+40uGteXrQv4n1k5QWe66lYaqx74lz1VCaIWbnGUjriD0r3WAqw7XjPyFMQM9C+3
         FQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=LA8Tezz09N+DfkcA4tB6goY21unWtbHDeihcHLz6flA=;
        b=CKEATgeocCWcxcKneWK6l3KF/45JPS+mjAZSt98lJbwkWNFlxu5xUP+CzBJy9vWYDE
         jEyC5gZ8eZwYyaDRWdc2C3hvumUZbDXFGisImW86wXQ+v4x8hrTsF1rU1e1u1O0bxgEG
         XdwKGshwSRs7gp73yjfX5YZDtmMLQXP9SRDeHVwDjQThHHOyp5suF/z51Nv40mBmc5vg
         7BmXXdA6Axoix/doF5GbACzyN1Vc9tVYQHmEOBm5w8YRL5KoQhkIb/E+g6VbKabXww1q
         gSXVc2bFtPW0FHOj9SD0cnkKvhLlbUI0yhy2Q5ypRNynTykkbWcasttPSxs0mJH7JJVJ
         4kbw==
X-Gm-Message-State: AOUpUlFyhduK3Qh+BBZykxEH1I58pJvB0oBI06t8LlqfIccVgvFkgJhz
        X1poU3MljoMb7CodpQBm8Q==
X-Google-Smtp-Source: AAOMgpdNN/ApMfNme1hcP7i4v7BLUQIo8h6k4Lf3/pHlI2aJNS7p9njV/Y6VdraDI6HHzgD6lgX/6g==
X-Received: by 2002:a17:902:b944:: with SMTP id h4-v6mr177743pls.157.1531805570887;
        Mon, 16 Jul 2018 22:32:50 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id y85-v6sm156220pfa.170.2018.07.16.22.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 22:32:49 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xishi.qiuxishi@alibaba-inc.com, zy.zhengyi@alibaba-inc.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm: soft-offline: close the race against page allocation
Date:   Tue, 17 Jul 2018 14:32:32 +0900
Message-Id: <1531805552-19547-3-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A process can be killed with SIGBUS(BUS_MCEERR_AR) when it tries to
allocate a page that was just freed on the way of soft-offline.
This is undesirable because soft-offline (which is about corrected error)
is less aggressive than hard-offline (which is about uncorrected error),
and we can make soft-offline fail and keep using the page for good reason
like "system is busy."

Two main changes of this patch are:

- setting migrate type of the target page to MIGRATE_ISOLATE. As done
  in free_unref_page_commit(), this makes kernel bypass pcplist when
  freeing the page. So we can assume that the page is in freelist just
  after put_page() returns,

- setting PG_hwpoison on free page under zone->lock which protects
  freelists, so this allows us to avoid setting PG_hwpoison on a page
  that is decided to be allocated soon.

Reported-by: Xishi Qiu <xishi.qiuxishi@alibaba-inc.com>
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
changelog v1->v2:
- updated comment on set_hwpoison_free_buddy_page(),
- moved calling set_hwpoison_free_buddy_page() from mm/migrate.c to
  mm/memory-failure.c, which is necessary to check the return code of
  set_hwpoison_free_buddy_page().
---
 include/linux/page-flags.h |  5 +++++
 include/linux/swapops.h    | 10 ----------
 mm/memory-failure.c        | 35 +++++++++++++++++++++++++++++------
 mm/migrate.c               |  9 ---------
 mm/page_alloc.c            | 30 ++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 25 deletions(-)

diff --git v4.18-rc4-mmotm-2018-07-10-16-50/include/linux/page-flags.h v4.18-rc4-mmotm-2018-07-10-16-50_patched/include/linux/page-flags.h
index 901943e..74bee8c 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/include/linux/page-flags.h
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/include/linux/page-flags.h
@@ -369,8 +369,13 @@ PAGEFLAG_FALSE(Uncached)
 PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
 #define __PG_HWPOISON (1UL << PG_hwpoison)
+extern bool set_hwpoison_free_buddy_page(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison)
+static inline bool set_hwpoison_free_buddy_page(struct page *page)
+{
+	return 0;
+}
 #define __PG_HWPOISON 0
 #endif
 
diff --git v4.18-rc4-mmotm-2018-07-10-16-50/include/linux/swapops.h v4.18-rc4-mmotm-2018-07-10-16-50_patched/include/linux/swapops.h
index 9c0eb4d..fe8e08b 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/include/linux/swapops.h
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/include/linux/swapops.h
@@ -335,11 +335,6 @@ static inline int is_hwpoison_entry(swp_entry_t entry)
 	return swp_type(entry) == SWP_HWPOISON;
 }
 
-static inline bool test_set_page_hwpoison(struct page *page)
-{
-	return TestSetPageHWPoison(page);
-}
-
 static inline void num_poisoned_pages_inc(void)
 {
 	atomic_long_inc(&num_poisoned_pages);
@@ -362,11 +357,6 @@ static inline int is_hwpoison_entry(swp_entry_t swp)
 	return 0;
 }
 
-static inline bool test_set_page_hwpoison(struct page *page)
-{
-	return false;
-}
-
 static inline void num_poisoned_pages_inc(void)
 {
 }
diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
index 9b77f85..936d0e7 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/mm/memory-failure.c
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/memory-failure.c
@@ -57,6 +57,7 @@
 #include <linux/mm_inline.h>
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
+#include <linux/page-isolation.h>
 #include "internal.h"
 #include "ras/ras_event.h"
 
@@ -1609,8 +1610,10 @@ static int soft_offline_huge_page(struct page *page, int flags)
 		 */
 		ret = dissolve_free_huge_page(page);
 		if (!ret) {
-			if (!TestSetPageHWPoison(page))
+			if (set_hwpoison_free_buddy_page(page))
 				num_poisoned_pages_inc();
+			else
+				ret = -EBUSY;
 		}
 	}
 	return ret;
@@ -1688,6 +1691,11 @@ static int __soft_offline_page(struct page *page, int flags)
 				pfn, ret, page->flags, &page->flags);
 			if (ret > 0)
 				ret = -EIO;
+		} else {
+			if (set_hwpoison_free_buddy_page(page))
+				num_poisoned_pages_inc();
+			else
+				ret = -EBUSY;
 		}
 	} else {
 		pr_info("soft offline: %#lx: isolation failed: %d, page count %d, type %lx (%pGp)\n",
@@ -1699,6 +1707,7 @@ static int __soft_offline_page(struct page *page, int flags)
 static int soft_offline_in_use_page(struct page *page, int flags)
 {
 	int ret;
+	int mt;
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage)) {
@@ -1717,23 +1726,37 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 		put_hwpoison_page(hpage);
 	}
 
+	/*
+	 * Setting MIGRATE_ISOLATE here ensures that the page will be linked
+	 * to free list immediately (not via pcplist) when released after
+	 * successful page migration. Otherwise we can't guarantee that the
+	 * page is really free after put_page() returns, so
+	 * set_hwpoison_free_buddy_page() highly likely fails.
+	 */
+	mt = get_pageblock_migratetype(page);
+	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 	if (PageHuge(page))
 		ret = soft_offline_huge_page(page, flags);
 	else
 		ret = __soft_offline_page(page, flags);
-
+	set_pageblock_migratetype(page, mt);
 	return ret;
 }
 
-static void soft_offline_free_page(struct page *page)
+static int soft_offline_free_page(struct page *page)
 {
 	int rc = 0;
 	struct page *head = compound_head(page);
 
 	if (PageHuge(head))
 		rc = dissolve_free_huge_page(page);
-	if (!rc && !TestSetPageHWPoison(page))
-		num_poisoned_pages_inc();
+	if (!rc) {
+		if (set_hwpoison_free_buddy_page(page))
+			num_poisoned_pages_inc();
+		else
+			rc = -EBUSY;
+	}
+	return rc;
 }
 
 /**
@@ -1777,7 +1800,7 @@ int soft_offline_page(struct page *page, int flags)
 	if (ret > 0)
 		ret = soft_offline_in_use_page(page, flags);
 	else if (ret == 0)
-		soft_offline_free_page(page);
+		ret = soft_offline_free_page(page);
 
 	return ret;
 }
diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/migrate.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/migrate.c
index 3ae213b..4fd0fe0 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/mm/migrate.c
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/migrate.c
@@ -1193,15 +1193,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
 		put_page(page);
-		if (reason == MR_MEMORY_FAILURE) {
-			/*
-			 * Set PG_HWPoison on just freed page
-			 * intentionally. Although it's rather weird,
-			 * it's how HWPoison flag works at the moment.
-			 */
-			if (!test_set_page_hwpoison(page))
-				num_poisoned_pages_inc();
-		}
 	} else {
 		if (rc != -EAGAIN) {
 			if (likely(!__PageMovable(page))) {
diff --git v4.18-rc4-mmotm-2018-07-10-16-50/mm/page_alloc.c v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/page_alloc.c
index 607deff..4058b7e 100644
--- v4.18-rc4-mmotm-2018-07-10-16-50/mm/page_alloc.c
+++ v4.18-rc4-mmotm-2018-07-10-16-50_patched/mm/page_alloc.c
@@ -8027,3 +8027,33 @@ bool is_free_buddy_page(struct page *page)
 
 	return order < MAX_ORDER;
 }
+
+#ifdef CONFIG_MEMORY_FAILURE
+/*
+ * Set PG_hwpoison flag if a given page is confirmed to be a free page.  This
+ * test is performed under the zone lock to prevent a race against page
+ * allocation.
+ */
+bool set_hwpoison_free_buddy_page(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long flags;
+	unsigned int order;
+	bool hwpoisoned = false;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	for (order = 0; order < MAX_ORDER; order++) {
+		struct page *page_head = page - (pfn & ((1 << order) - 1));
+
+		if (PageBuddy(page_head) && page_order(page_head) >= order) {
+			if (!TestSetPageHWPoison(page))
+				hwpoisoned = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+
+	return hwpoisoned;
+}
+#endif
-- 
2.7.0

