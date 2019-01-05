Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B2C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8D821915
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfAET5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:57:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:11871 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfAET5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:57:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2019 11:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,444,1539673200"; 
   d="scan'208";a="309252990"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2019 11:57:42 -0800
Subject: [4.19-stable PATCH 1/2] dax: Don't access a freed inode
From:   Dan Williams <dan.j.williams@intel.com>
To:     stable@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        sashal@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 05 Jan 2019 11:45:08 -0800
Message-ID: <154671750803.249397.826088373719257387.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154671750268.249397.710993904552440547.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154671750268.249397.710993904552440547.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <willy@infradead.org>

commit 55e56f06ed71d9441f3abd5b1d3c1a870812b3fe upstream.

After we drop the i_pages lock, the inode can be freed at any time.
The get_unlocked_entry() code has no choice but to reacquire the lock,
so it can't be used here.  Create a new wait_entry_unlocked() which takes
care not to acquire the lock or dereference the address_space in any way.

Fixes: c2a7d2a11552 ("filesystem-dax: Introduce dax_lock_mapping_entry()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |   69 +++++++++++++++++++++++++++++---------------------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 3a2682a6c832..415605fafaeb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -229,8 +229,8 @@ static void put_unlocked_mapping_entry(struct address_space *mapping,
  *
  * Must be called with the i_pages lock held.
  */
-static void *__get_unlocked_mapping_entry(struct address_space *mapping,
-		pgoff_t index, void ***slotp, bool (*wait_fn)(void))
+static void *get_unlocked_mapping_entry(struct address_space *mapping,
+		pgoff_t index, void ***slotp)
 {
 	void *entry, **slot;
 	struct wait_exceptional_entry_queue ewait;
@@ -240,8 +240,6 @@ static void *__get_unlocked_mapping_entry(struct address_space *mapping,
 	ewait.wait.func = wake_exceptional_entry_func;
 
 	for (;;) {
-		bool revalidate;
-
 		entry = __radix_tree_lookup(&mapping->i_pages, index, NULL,
 					  &slot);
 		if (!entry ||
@@ -256,30 +254,39 @@ static void *__get_unlocked_mapping_entry(struct address_space *mapping,
 		prepare_to_wait_exclusive(wq, &ewait.wait,
 					  TASK_UNINTERRUPTIBLE);
 		xa_unlock_irq(&mapping->i_pages);
-		revalidate = wait_fn();
+		schedule();
 		finish_wait(wq, &ewait.wait);
 		xa_lock_irq(&mapping->i_pages);
-		if (revalidate) {
-			put_unlocked_mapping_entry(mapping, index, entry);
-			return ERR_PTR(-EAGAIN);
-		}
 	}
 }
 
-static bool entry_wait(void)
+/*
+ * The only thing keeping the address space around is the i_pages lock
+ * (it's cycled in clear_inode() after removing the entries from i_pages)
+ * After we call xas_unlock_irq(), we cannot touch xas->xa.
+ */
+static void wait_entry_unlocked(struct address_space *mapping, pgoff_t index,
+		void ***slotp, void *entry)
 {
+	struct wait_exceptional_entry_queue ewait;
+	wait_queue_head_t *wq;
+
+	init_wait(&ewait.wait);
+	ewait.wait.func = wake_exceptional_entry_func;
+
+	wq = dax_entry_waitqueue(mapping, index, entry, &ewait.key);
+	prepare_to_wait_exclusive(wq, &ewait.wait, TASK_UNINTERRUPTIBLE);
+	xa_unlock_irq(&mapping->i_pages);
 	schedule();
+	finish_wait(wq, &ewait.wait);
+
 	/*
-	 * Never return an ERR_PTR() from
-	 * __get_unlocked_mapping_entry(), just keep looping.
+	 * Entry lock waits are exclusive. Wake up the next waiter since
+	 * we aren't sure we will acquire the entry lock and thus wake
+	 * the next waiter up on unlock.
 	 */
-	return false;
-}
-
-static void *get_unlocked_mapping_entry(struct address_space *mapping,
-		pgoff_t index, void ***slotp)
-{
-	return __get_unlocked_mapping_entry(mapping, index, slotp, entry_wait);
+	if (waitqueue_active(wq))
+		__wake_up(wq, TASK_NORMAL, 1, &ewait.key);
 }
 
 static void unlock_mapping_entry(struct address_space *mapping, pgoff_t index)
@@ -398,19 +405,6 @@ static struct page *dax_busy_page(void *entry)
 	return NULL;
 }
 
-static bool entry_wait_revalidate(void)
-{
-	rcu_read_unlock();
-	schedule();
-	rcu_read_lock();
-
-	/*
-	 * Tell __get_unlocked_mapping_entry() to take a break, we need
-	 * to revalidate page->mapping after dropping locks
-	 */
-	return true;
-}
-
 bool dax_lock_mapping_entry(struct page *page)
 {
 	pgoff_t index;
@@ -446,14 +440,15 @@ bool dax_lock_mapping_entry(struct page *page)
 		}
 		index = page->index;
 
-		entry = __get_unlocked_mapping_entry(mapping, index, &slot,
-				entry_wait_revalidate);
+		entry = __radix_tree_lookup(&mapping->i_pages, index,
+						NULL, &slot);
 		if (!entry) {
 			xa_unlock_irq(&mapping->i_pages);
 			break;
-		} else if (IS_ERR(entry)) {
-			xa_unlock_irq(&mapping->i_pages);
-			WARN_ON_ONCE(PTR_ERR(entry) != -EAGAIN);
+		} else if (slot_locked(mapping, slot)) {
+			rcu_read_unlock();
+			wait_entry_unlocked(mapping, index, &slot, entry);
+			rcu_read_lock();
 			continue;
 		}
 		lock_slot(mapping, slot);

