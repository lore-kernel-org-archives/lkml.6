Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA0BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235462147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691862;
	bh=aEWnACEXuAjnas7RCyqo+LR5iDP9OLbY564td9odYRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2h+ZsvvrCoXORY5pl3aQ3xN7wS7SCKTUVuCTg4d9stOAKBT6M4WVF3E31gMNLVDpT
	 5EwaZrzF0cdjOpttv7akR27td/WMhYn6P0Wcex5yOfSq1K2YQG9XQptK0enStkTy6I
	 a92lIZ2TZ3HOBZrG9lrKsl3zlUTyp42s1ly3jjGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbfA1QLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731361AbfA1QK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:10:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264912175B;
        Mon, 28 Jan 2019 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691858;
        bh=aEWnACEXuAjnas7RCyqo+LR5iDP9OLbY564td9odYRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avQgHdfruHG93CI7vJDiQH5um8AUAdRoZlxocnDglRClEjU6x6K4ITa47XQuWK3TT
         cFKOtMW+uZAbYVs/CI/0fMBj1WSoyuOqh0Ihg+19a0wWnKHG2Yty7lDidrp04IiWkd
         1fyWmyUf0BS4cxo/T1gqfbRGYdAiAiYVXlxFF4ME=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 238/258] mm/page_alloc.c: don't call kasan_free_pages() at deferred mem init
Date:   Mon, 28 Jan 2019 10:59:04 -0500
Message-Id: <20190128155924.51521-238-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

[ Upstream commit 3c0c12cc8f00ca5f81acb010023b8eb13e9a7004 ]

When CONFIG_KASAN is enabled on large memory SMP systems, the deferrred
pages initialization can take a long time.  Below were the reported init
times on a 8-socket 96-core 4TB IvyBridge system.

  1) Non-debug kernel without CONFIG_KASAN
     [    8.764222] node 1 initialised, 132086516 pages in 7027ms

  2) Debug kernel with CONFIG_KASAN
     [  146.288115] node 1 initialised, 132075466 pages in 143052ms

So the page init time in a debug kernel was 20X of the non-debug kernel.
The long init time can be problematic as the page initialization is done
with interrupt disabled.  In this particular case, it caused the
appearance of following warning messages as well as NMI backtraces of all
the cores that were doing the initialization.

[   68.240049] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   68.241000] rcu: 	25-...0: (100 ticks this GP) idle=b72/1/0x4000000000000000 softirq=915/915 fqs=16252
[   68.241000] rcu: 	44-...0: (95 ticks this GP) idle=49a/1/0x4000000000000000 softirq=788/788 fqs=16253
[   68.241000] rcu: 	54-...0: (104 ticks this GP) idle=03a/1/0x4000000000000000 softirq=721/825 fqs=16253
[   68.241000] rcu: 	60-...0: (103 ticks this GP) idle=cbe/1/0x4000000000000000 softirq=637/740 fqs=16253
[   68.241000] rcu: 	72-...0: (105 ticks this GP) idle=786/1/0x4000000000000000 softirq=536/641 fqs=16253
[   68.241000] rcu: 	84-...0: (99 ticks this GP) idle=292/1/0x4000000000000000 softirq=537/537 fqs=16253
[   68.241000] rcu: 	111-...0: (104 ticks this GP) idle=bde/1/0x4000000000000000 softirq=474/476 fqs=16253
[   68.241000] rcu: 	(detected by 13, t=65018 jiffies, g=249, q=2)

The long init time was mainly caused by the call to kasan_free_pages() to
poison the newly initialized pages.  On a 4TB system, we are talking about
almost 500GB of memory probably on the same node.

In reality, we may not need to poison the newly initialized pages before
they are ever allocated.  So KASAN poisoning of freed pages before the
completion of deferred memory initialization is now disabled.  Those pages
will be properly poisoned when they are allocated or freed after deferred
pages initialization is done.

With this change, the new page initialization time became:

[   21.948010] node 1 initialised, 132075466 pages in 18702ms

This was still about double the non-debug kernel time, but was much
better than before.

Link: http://lkml.kernel.org/r/1544459388-8736-1-git-send-email-longman@redhat.com
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 93e73ccb4dec..b87dc47db5ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -294,6 +294,32 @@ EXPORT_SYMBOL(nr_online_nodes);
 int page_group_by_mobility_disabled __read_mostly;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+/*
+ * During boot we initialize deferred pages on-demand, as needed, but once
+ * page_alloc_init_late() has finished, the deferred pages are all initialized,
+ * and we can permanently disable that path.
+ */
+static DEFINE_STATIC_KEY_TRUE(deferred_pages);
+
+/*
+ * Calling kasan_free_pages() only after deferred memory initialization
+ * has completed. Poisoning pages during deferred memory init will greatly
+ * lengthen the process and cause problem in large memory systems as the
+ * deferred pages initialization is done with interrupt disabled.
+ *
+ * Assuming that there will be no reference to those newly initialized
+ * pages before they are ever allocated, this should have no effect on
+ * KASAN memory tracking as the poison will be properly inserted at page
+ * allocation time. The only corner case is when pages are allocated by
+ * on-demand allocation and then freed again before the deferred pages
+ * initialization is done, but this is not likely to happen.
+ */
+static inline void kasan_free_nondeferred_pages(struct page *page, int order)
+{
+	if (!static_branch_unlikely(&deferred_pages))
+		kasan_free_pages(page, order);
+}
+
 /* Returns true if the struct page for the pfn is uninitialised */
 static inline bool __meminit early_page_uninitialised(unsigned long pfn)
 {
@@ -326,6 +352,8 @@ static inline bool update_defer_init(pg_data_t *pgdat,
 	return true;
 }
 #else
+#define kasan_free_nondeferred_pages(p, o)	kasan_free_pages(p, o)
+
 static inline bool early_page_uninitialised(unsigned long pfn)
 {
 	return false;
@@ -1030,7 +1058,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	arch_free_page(page, order);
 	kernel_poison_pages(page, 1 << order, 0);
 	kernel_map_pages(page, 1 << order, 0);
-	kasan_free_pages(page, order);
+	kasan_free_nondeferred_pages(page, order);
 
 	return true;
 }
@@ -1593,13 +1621,6 @@ static int __init deferred_init_memmap(void *data)
 	return 0;
 }
 
-/*
- * During boot we initialize deferred pages on-demand, as needed, but once
- * page_alloc_init_late() has finished, the deferred pages are all initialized,
- * and we can permanently disable that path.
- */
-static DEFINE_STATIC_KEY_TRUE(deferred_pages);
-
 /*
  * If this zone has deferred pages, try to grow it by initializing enough
  * deferred pages to satisfy the allocation specified by order, rounded up to
-- 
2.19.1

