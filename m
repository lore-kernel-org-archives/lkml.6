Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965270AbeCHGxq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 01:53:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46204 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935218AbeCHGxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 01:53:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3BA56024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2] slub: use jitter-free reference while printing age
Date: Thu,  8 Mar 2018 12:23:30 +0530
Message-Id: <1520492010-19389-1-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SLUB_DEBUG catches the some issues, it prints
all the required debug info. However, in few cases
where allocation and free of the object has have
happened in a very short time, 'age' might mislead.
See the example below,

[ 6044.137581] =============================================================================
[ 6044.145863] BUG kmalloc-256 (Tainted: G        W  O   ): Poison overwritten
[ 6044.152889] -----------------------------------------------------------------------------
...
[ 6044.170804] INFO: Allocated in binder_transaction+0x4b0/0x2448 age=731 cpu=3 pid=5314
...
[ 6044.216696] INFO: Freed in binder_free_transaction+0x2c/0x58 age=735 cpu=6 pid=2079
...
[ 6044.494293] Object fffffff14956a870: 6b 6b 6b 6b 6b 6b 6b 6b 67 6b 6b 6b 6b 6b 6b a5  kkkkkkkkgkkkk

In this case, object got freed later but 'age'
shows otherwise. This could be because, while
printing this info, we print allocation traces
first and free traces thereafter. In between,
if we get schedule out or jiffies increment,
(jiffies - t->when) could become meaningless.

Use the jitter free reference to calculate age.

Change-Id: I0846565807a4229748649bbecb1ffb743d71fcd8
Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
Changes from V1->V2
 * Use 'age' with common jiffies for both prints
 * Trimmed commit text for clear visibility 

 mm/slub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e381728..d92218e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -598,13 +598,13 @@ static void init_tracking(struct kmem_cache *s, void *object)
 	set_track(s, object, TRACK_ALLOC, 0UL);
 }
 
-static void print_track(const char *s, struct track *t)
+static void print_track(const char *s, struct track *t, unsigned long pr_time)
 {
 	if (!t->addr)
 		return;
 
 	pr_err("INFO: %s in %pS age=%lu cpu=%u pid=%d\n",
-	       s, (void *)t->addr, jiffies - t->when, t->cpu, t->pid);
+	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
 #ifdef CONFIG_STACKTRACE
 	{
 		int i;
@@ -619,11 +619,12 @@ static void print_track(const char *s, struct track *t)
 
 static void print_tracking(struct kmem_cache *s, void *object)
 {
+	unsigned long pr_time = jiffies;
 	if (!(s->flags & SLAB_STORE_USER))
 		return;
 
-	print_track("Allocated", get_track(s, object, TRACK_ALLOC));
-	print_track("Freed", get_track(s, object, TRACK_FREE));
+	print_track("Allocated", get_track(s, object, TRACK_ALLOC), pr_time);
+	print_track("Freed", get_track(s, object, TRACK_FREE), pr_time);
 }
 
 static void print_page_info(struct page *page)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
