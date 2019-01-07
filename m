Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825C0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472BF206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865862;
	bh=b5EHuPKIGuH3OjjOfQF3jxl7dWyvdoH5On5rhMiYioI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i9uIvsnRUpn0o/uBTQ49TpRylXm7jD7UAptssuOkcB7xjAo/3qjSLAvI7fmAkxLXC
	 nF7k5mpmVM2PFv1/u4A2WOAdrqVMPOmppOdB3OhpwL38xsEVbZFIA61OfjAOxWbNHC
	 ZzrofoLq8RG2ncaRB0HTHspkUxqztMCEGs7s4n5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfAGM5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:57:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbfAGM5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:57:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C32206BB;
        Mon,  7 Jan 2019 12:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865855;
        bh=b5EHuPKIGuH3OjjOfQF3jxl7dWyvdoH5On5rhMiYioI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwEHukW+WQM3TwpiSxhlXi2NhiZHTQVQwFYNf/LOjmA0J3rY9vZ/lypjAjNRHnk9v
         hlMOkSIXkzRMBVD6D+TvK4L0HOv5lFnHBukMaM400Q2ZdU2Ze4Ve4Sq7SZK8txsMsp
         W6OoZaUDhzLx33ff43m0AEnt8ypXAkD2NvVJn3as=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 136/170] dax: Dont access a freed inode
Date:   Mon,  7 Jan 2019 13:32:43 +0100
Message-Id: <20190107104509.026119134@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dax.c | 69 ++++++++++++++++++++++++++------------------------------
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
-- 
2.19.1



