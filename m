Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F50C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586E62064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586E62064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeI0B3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:29:48 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25069 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbeI0B3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:47 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:05 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id C7352B05DE;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 12/20] vmw_balloon: rework the inflate and deflate loops
Date:   Wed, 26 Sep 2018 12:13:28 -0700
Message-ID: <20180926191336.101885-13-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926191336.101885-1-namit@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting compaction and OOM notification, this
patch reworks the inflate/deflate loops. The main idea is to separate
the allocation, communication with the hypervisor, and the handling of
errors from each other. Doing will allow us to perform concurrent
inflation and deflation, excluding the actual communication with the
hypervisor.

To do so, we need to get rid of the remaining global state that is kept
in the balloon struct, specifically the refuse_list. When the VM
communicates with the hypervisor, it does not free or put back pages
to the balloon list and instead only moves the pages whose status
indicated failure into a refuse_list on the stack. Once the operation
completes, the inflation or deflation functions handle the list
appropriately.

As we do that, we can consolidate the communication with the hypervisor
for both the lock and unlock operations into a single function. We also
reuse the deflation function for popping the balloon.

As a preparation for preventing races, we hold a spinlock when the
communication actually takes place, and use atomic operations for
updating the balloon size. The balloon page list is still racy and will
be handled in the next patch.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 829 ++++++++++++++++++++++++-------------
 1 file changed, 541 insertions(+), 288 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 0a2bdaf5773b..cb363db34b4a 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -27,6 +27,7 @@
 #include <linux/seq_file.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/vmw_vmci_defs.h>
 #include <linux/vmw_vmci_api.h>
 #include <asm/hypervisor.h>
@@ -89,6 +90,16 @@ enum vmballoon_page_size_type {
 
 #define VMW_BALLOON_NUM_PAGE_SIZES	(VMW_BALLOON_LAST_SIZE + 1)
 
+static const char * const vmballoon_page_size_names[] = {
+	[VMW_BALLOON_4K_PAGE]			= "4k",
+	[VMW_BALLOON_2M_PAGE]			= "2M"
+};
+
+enum vmballoon_op {
+	VMW_BALLOON_INFLATE,
+	VMW_BALLOON_DEFLATE
+};
+
 enum vmballoon_op_stat_type {
 	VMW_BALLOON_OP_STAT,
 	VMW_BALLOON_OP_FAIL_STAT
@@ -216,13 +227,18 @@ enum vmballoon_stat_general {
 static DEFINE_STATIC_KEY_TRUE(vmw_balloon_batching);
 static DEFINE_STATIC_KEY_FALSE(balloon_stat_enabled);
 
-struct vmballoon_page_size {
-	/* list of reserved physical pages */
+struct vmballoon_ctl {
 	struct list_head pages;
-
-	/* transient list of non-balloonable pages */
 	struct list_head refused_pages;
 	unsigned int n_refused_pages;
+	unsigned int n_pages;
+	enum vmballoon_page_size_type page_size;
+	enum vmballoon_op op;
+};
+
+struct vmballoon_page_size {
+	/* list of reserved physical pages */
+	struct list_head pages;
 };
 
 /**
@@ -241,16 +257,47 @@ struct vmballoon_batch_entry {
 struct vmballoon {
 	struct vmballoon_page_size page_sizes[VMW_BALLOON_NUM_PAGE_SIZES];
 
-	/* supported page sizes. 1 == 4k pages only, 2 == 4k and 2m pages */
-	unsigned supported_page_sizes;
+	/**
+	 * @max_page_size: maximum supported page size for ballooning.
+	 *
+	 * Protected by @conf_sem
+	 */
+	enum vmballoon_page_size_type max_page_size;
+
+	/**
+	 * @size: balloon actual size in basic page size (frames).
+	 *
+	 * While we currently do not support size which is bigger than 32-bit,
+	 * in preparation for future support, use 64-bits.
+	 */
+	atomic64_t size;
 
-	/* balloon size in pages */
-	unsigned int size;
-	unsigned int target;
+	/**
+	 * @target: balloon target size in basic page size (frames).
+	 *
+	 * We do not protect the target under the assumption that setting the
+	 * value is always done through a single write. If this assumption ever
+	 * breaks, we would have to use X_ONCE for accesses, and suffer the less
+	 * optimized code. Although we may read stale target value if multiple
+	 * accesses happen at once, the performance impact should be minor.
+	 */
+	unsigned long target;
 
-	/* reset flag */
+	/**
+	 * @reset_required: reset flag
+	 *
+	 * Setting this flag may introduce races, but the code is expected to
+	 * handle them gracefully. In the worst case, another operation will
+	 * fail as reset did not take place. Clearing the flag is done while
+	 * holding @conf_sem for write.
+	 */
 	bool reset_required;
 
+	/**
+	 * @capabilities: hypervisor balloon capabilities.
+	 *
+	 * Protected by @conf_sem.
+	 */
 	unsigned long capabilities;
 
 	/**
@@ -261,7 +308,25 @@ struct vmballoon {
 	 */
 	struct vmballoon_batch_entry *batch_page;
 
+	/**
+	 * @batch_max_pages: maximum pages that can be locked/unlocked.
+	 *
+	 * Indicates the number of pages that the hypervisor can lock or unlock
+	 * at once, according to whether batching is enabled. If batching is
+	 * disabled, only a single page can be locked/unlock on each operation.
+	 *
+	 * Protected by @conf_sem.
+	 */
 	unsigned int batch_max_pages;
+
+	/**
+	 * @page: page to be locked/unlocked by the hypervisor
+	 *
+	 * @page is only used when batching is disabled and a single page is
+	 * reclaimed on each iteration.
+	 *
+	 * Protected by @comm_lock.
+	 */
 	struct page *page;
 
 	/* statistics */
@@ -274,12 +339,24 @@ struct vmballoon {
 
 	struct delayed_work dwork;
 
+	/**
+	 * @vmci_doorbell.
+	 *
+	 * Protected by @conf_sem.
+	 */
 	struct vmci_handle vmci_doorbell;
 
 	/**
 	 * @conf_sem: semaphore to protect the configuration and the statistics.
 	 */
 	struct rw_semaphore conf_sem;
+
+	/**
+	 * @comm_lock: lock to protect the communication with the host.
+	 *
+	 * Lock ordering: @conf_sem -> @comm_lock .
+	 */
+	spinlock_t comm_lock;
 };
 
 static struct vmballoon balloon;
@@ -326,10 +403,19 @@ static inline void vmballoon_stats_gen_add(struct vmballoon *b,
 
 static inline void vmballoon_stats_page_inc(struct vmballoon *b,
 					    enum vmballoon_stat_page stat,
-					    bool is_2m_page)
+					    enum vmballoon_page_size_type size)
 {
 	if (is_vmballoon_stats_on())
-		atomic64_inc(&b->stats->page_stat[stat][is_2m_page]);
+		atomic64_inc(&b->stats->page_stat[stat][size]);
+}
+
+static inline void vmballoon_stats_page_add(struct vmballoon *b,
+					    enum vmballoon_stat_page stat,
+					    enum vmballoon_page_size_type size,
+					    unsigned int val)
+{
+	if (is_vmballoon_stats_on())
+		atomic64_add(val, &b->stats->page_stat[stat][size]);
 }
 
 static inline unsigned long
@@ -361,7 +447,7 @@ __vmballoon_cmd(struct vmballoon *b, unsigned long cmd, unsigned long arg1,
 	/* update target when applicable */
 	if (status == VMW_BALLOON_SUCCESS &&
 	    ((1ul << cmd) & VMW_BALLOON_CMD_WITH_TARGET_MASK))
-		b->target = local_result;
+		WRITE_ONCE(b->target, local_result);
 
 	if (status != VMW_BALLOON_SUCCESS &&
 	    status != VMW_BALLOON_SUCCESS_WITH_CAPABILITIES) {
@@ -417,11 +503,11 @@ static bool vmballoon_send_start(struct vmballoon *b, unsigned long req_caps)
 	 * reason disabled, do not use 2MB pages, since otherwise the legacy
 	 * mechanism is used with 2MB pages, causing a failure.
 	 */
+	b->max_page_size = VMW_BALLOON_4K_PAGE;
 	if ((b->capabilities & VMW_BALLOON_BATCHED_2M_CMDS) &&
 	    (b->capabilities & VMW_BALLOON_BATCHED_CMDS))
-		b->supported_page_sizes = 2;
-	else
-		b->supported_page_sizes = 1;
+		b->max_page_size = VMW_BALLOON_2M_PAGE;
+
 
 	return success;
 }
@@ -445,12 +531,28 @@ static bool vmballoon_send_guest_id(struct vmballoon *b)
 	return false;
 }
 
-static u16 vmballoon_page_size(bool is_2m_page)
+/**
+ * vmballoon_page_order() - return the order of the page
+ * @page_size: the size of the page.
+ *
+ * Return: the allocation order.
+ */
+static inline
+unsigned int vmballoon_page_order(enum vmballoon_page_size_type page_size)
 {
-	if (is_2m_page)
-		return 1 << VMW_BALLOON_2M_ORDER;
+	return page_size == VMW_BALLOON_2M_PAGE ? VMW_BALLOON_2M_ORDER : 0;
+}
 
-	return 1;
+/**
+ * vmballoon_page_in_frames() - returns the number of frames in a page.
+ * @page_size: the size of the page.
+ *
+ * Return: the number of 4k frames.
+ */
+static inline unsigned int
+vmballoon_page_in_frames(enum vmballoon_page_size_type page_size)
+{
+	return 1 << vmballoon_page_order(page_size);
 }
 
 /**
@@ -478,53 +580,78 @@ static int vmballoon_send_get_target(struct vmballoon *b)
 	return status == VMW_BALLOON_SUCCESS ? 0 : -EIO;
 }
 
-static struct page *vmballoon_alloc_page(bool is_2m_page)
+/**
+ * vmballoon_alloc_page_list - allocates a list of pages.
+ *
+ * @b: pointer to the balloon.
+ * @ctl: pointer for the %struct vmballoon_ctl, which defines the operation.
+ * @req_n_pages: the number of requested pages.
+ *
+ * Tries to allocate @req_n_pages. Add them to the list of balloon pages in
+ * @ctl.pages and updates @ctl.n_pages to reflect the number of pages.
+ *
+ * Return: zero on success or error code otherwise.
+ */
+static int vmballoon_alloc_page_list(struct vmballoon *b,
+				     struct vmballoon_ctl *ctl,
+				     unsigned int req_n_pages)
 {
-	if (is_2m_page)
-		return alloc_pages(VMW_HUGE_PAGE_ALLOC_FLAGS,
-				   VMW_BALLOON_2M_ORDER);
+	struct page *page;
+	unsigned int i;
 
-	return alloc_page(VMW_PAGE_ALLOC_FLAGS);
-}
+	for (i = 0; i < req_n_pages; i++) {
+		if (ctl->page_size == VMW_BALLOON_2M_PAGE)
+			page = alloc_pages(VMW_HUGE_PAGE_ALLOC_FLAGS,
+					   VMW_BALLOON_2M_ORDER);
+		else
+			page = alloc_page(VMW_PAGE_ALLOC_FLAGS);
 
-static void vmballoon_free_page(struct page *page, bool is_2m_page)
-{
-	if (is_2m_page)
-		__free_pages(page, VMW_BALLOON_2M_ORDER);
-	else
-		__free_page(page);
+		/* Update statistics */
+		vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
+					 ctl->page_size);
+
+		if (page) {
+			/* Success. Add the page to the list and continue. */
+			list_add(&page->lru, &ctl->pages);
+			continue;
+		}
+
+		/* Allocation failed. Update statistics and stop. */
+		vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC_FAIL,
+					 ctl->page_size);
+		break;
+	}
+
+	ctl->n_pages = i;
+
+	return req_n_pages == ctl->n_pages ? 0 : -ENOMEM;
 }
 
-/*
- * Quickly release all pages allocated for the balloon. This function is
- * called when host decides to "reset" balloon for one reason or another.
- * Unlike normal "deflate" we do not (shall not) notify host of the pages
- * being released.
+/**
+ * vmballoon_handle_one_result - Handle lock/unlock result for a single page.
+ *
+ * @b: pointer for %struct vmballoon.
+ * @page: pointer for the page whose result should be handled.
+ * @page_size: size of the page.
+ * @status: status of the operation as provided by the hypervisor.
  */
-static void vmballoon_pop(struct vmballoon *b)
+static int vmballoon_handle_one_result(struct vmballoon *b, struct page *page,
+				       enum vmballoon_page_size_type page_size,
+				       unsigned long status)
 {
-	struct page *page, *next;
-	unsigned is_2m_pages;
-
-	for (is_2m_pages = 0; is_2m_pages < VMW_BALLOON_NUM_PAGE_SIZES;
-			is_2m_pages++) {
-		struct vmballoon_page_size *page_size =
-				&b->page_sizes[is_2m_pages];
-		u16 size_per_page = vmballoon_page_size(is_2m_pages);
-
-		list_for_each_entry_safe(page, next, &page_size->pages, lru) {
-			list_del(&page->lru);
-			vmballoon_free_page(page, is_2m_pages);
-			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_FREE,
-						 is_2m_pages);
-			b->size -= size_per_page;
-			cond_resched();
-		}
-	}
+	/* On success do nothing. The page is already on the balloon list. */
+	if (likely(status == VMW_BALLOON_SUCCESS))
+		return 0;
 
-	/* Clearing the batch_page unconditionally has no adverse effect */
-	free_page((unsigned long)b->batch_page);
-	b->batch_page = NULL;
+	pr_debug("%s: failed comm pfn %lx status %lu page_size %s\n", __func__,
+		 page_to_pfn(page), status,
+		 vmballoon_page_size_names[page_size]);
+
+	/* Error occurred */
+	vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_REFUSED_ALLOC,
+				 page_size);
+
+	return -EIO;
 }
 
 /**
@@ -565,8 +692,8 @@ static unsigned long vmballoon_status_page(struct vmballoon *b, int idx,
  * vmballoon_lock_op - notifies the host about inflated/deflated pages.
  * @b: pointer to the balloon.
  * @num_pages: number of inflated/deflated pages.
- * @is_2m_pages: whether the page(s) are 2M (or 4k).
- * @lock: whether the operation is lock (or unlock).
+ * @page_size: size of the page.
+ * @op: the type of operation (lock or unlock).
  *
  * Notify the host about page(s) that were ballooned (or removed from the
  * balloon) so that host can use it without fear that guest will need it (or
@@ -578,21 +705,27 @@ static unsigned long vmballoon_status_page(struct vmballoon *b, int idx,
  */
 static unsigned long vmballoon_lock_op(struct vmballoon *b,
 				       unsigned int num_pages,
-				       bool is_2m_pages, bool lock)
+				       enum vmballoon_page_size_type page_size,
+				       enum vmballoon_op op)
 {
 	unsigned long cmd, pfn;
 
+	lockdep_assert_held(&b->comm_lock);
+
 	if (static_branch_likely(&vmw_balloon_batching)) {
-		if (lock)
-			cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_LOCK :
-					    VMW_BALLOON_CMD_BATCHED_LOCK;
+		if (op == VMW_BALLOON_INFLATE)
+			cmd = page_size == VMW_BALLOON_2M_PAGE ?
+				VMW_BALLOON_CMD_BATCHED_2M_LOCK :
+				VMW_BALLOON_CMD_BATCHED_LOCK;
 		else
-			cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_UNLOCK :
-					    VMW_BALLOON_CMD_BATCHED_UNLOCK;
+			cmd = page_size == VMW_BALLOON_2M_PAGE ?
+				VMW_BALLOON_CMD_BATCHED_2M_UNLOCK :
+				VMW_BALLOON_CMD_BATCHED_UNLOCK;
 
 		pfn = PHYS_PFN(virt_to_phys(b->batch_page));
 	} else {
-		cmd = lock ? VMW_BALLOON_CMD_LOCK : VMW_BALLOON_CMD_UNLOCK;
+		cmd = op == VMW_BALLOON_INFLATE ? VMW_BALLOON_CMD_LOCK :
+						  VMW_BALLOON_CMD_UNLOCK;
 		pfn = page_to_pfn(b->page);
 
 		/* In non-batching mode, PFNs must fit in 32-bit */
@@ -603,22 +736,75 @@ static unsigned long vmballoon_lock_op(struct vmballoon *b,
 	return vmballoon_cmd(b, cmd, pfn, num_pages);
 }
 
-static int vmballoon_lock(struct vmballoon *b, unsigned int num_pages,
-			  bool is_2m_pages)
+/**
+ * vmballoon_add_page - adds a page towards lock/unlock operation.
+ *
+ * @b: pointer to the balloon.
+ * @idx: index of the page to be ballooned in this batch.
+ * @p: pointer to the page that is about to be ballooned.
+ *
+ * Adds the page to be ballooned. Must be called while holding @comm_lock.
+ */
+static void vmballoon_add_page(struct vmballoon *b, unsigned int idx,
+			       struct page *p)
+{
+	lockdep_assert_held(&b->comm_lock);
+
+	if (static_branch_likely(&vmw_balloon_batching))
+		b->batch_page[idx] = (struct vmballoon_batch_entry)
+					{ .pfn = page_to_pfn(p) };
+	else
+		b->page = p;
+}
+
+/**
+ * vmballoon_lock - lock or unlock a batch of pages.
+ *
+ * @b: pointer to the balloon.
+ * @ctl: pointer for the %struct vmballoon_ctl, which defines the operation.
+ *
+ * Notifies the host of about ballooned pages (after inflation or deflation,
+ * according to @ctl). If the host rejects the page put it on the
+ * @ctl refuse list. These refused page are then released when moving to the
+ * next size of pages.
+ *
+ * Note that we neither free any @page here nor put them back on the ballooned
+ * pages list. Instead we queue it for later processing. We do that for several
+ * reasons. First, we do not want to free the page under the lock. Second, it
+ * allows us to unify the handling of lock and unlock. In the inflate case, the
+ * caller will check if there are too many refused pages and release them.
+ * Although it is not identical to the past behavior, it should not affect
+ * performance.
+ */
+static int vmballoon_lock(struct vmballoon *b, struct vmballoon_ctl *ctl)
 {
 	unsigned long batch_status;
-	int i;
-	u16 size_per_page = vmballoon_page_size(is_2m_pages);
+	struct page *page;
+	unsigned int i, num_pages;
+
+	num_pages = ctl->n_pages;
+	if (num_pages == 0)
+		return 0;
 
-	batch_status = vmballoon_lock_op(b, num_pages, is_2m_pages, true);
+	/* communication with the host is done under the communication lock */
+	spin_lock(&b->comm_lock);
 
+	i = 0;
+	list_for_each_entry(page, &ctl->pages, lru)
+		vmballoon_add_page(b, i++, page);
+
+	batch_status = vmballoon_lock_op(b, ctl->n_pages, ctl->page_size,
+					 ctl->op);
+
+	/*
+	 * Iterate over the pages in the provided list. Since we are changing
+	 * @ctl->n_pages we are saving the original value in @num_pages and
+	 * use this value to bound the loop.
+	 */
 	for (i = 0; i < num_pages; i++) {
 		unsigned long status;
-		struct page *p;
-		struct vmballoon_page_size *page_size =
-				&b->page_sizes[is_2m_pages];
 
-		status = vmballoon_status_page(b, i, &p);
+		status = vmballoon_status_page(b, i, &page);
 
 		/*
 		 * Failure of the whole batch overrides a single operation
@@ -627,109 +813,61 @@ static int vmballoon_lock(struct vmballoon *b, unsigned int num_pages,
 		if (batch_status != VMW_BALLOON_SUCCESS)
 			status = batch_status;
 
-		if (status == VMW_BALLOON_SUCCESS) {
-			/* track allocated page */
-			list_add(&p->lru, &page_size->pages);
-
-			/* update balloon size */
-			b->size += size_per_page;
+		/* Continue if no error happened */
+		if (!vmballoon_handle_one_result(b, page, ctl->page_size,
+						 status))
 			continue;
-		}
-
-		/* Error occurred */
-		vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_REFUSED_ALLOC,
-					 is_2m_pages);
 
 		/*
-		 * Place page on the list of non-balloonable pages
-		 * and retry allocation, unless we already accumulated
-		 * too many of them, in which case take a breather.
+		 * Error happened. Move the pages to the refused list and update
+		 * the pages number.
 		 */
-		list_add(&p->lru, &page_size->refused_pages);
-		page_size->n_refused_pages++;
+		list_move(&page->lru, &ctl->refused_pages);
+		ctl->n_pages--;
+		ctl->n_refused_pages++;
 	}
 
+	spin_unlock(&b->comm_lock);
+
 	return batch_status == VMW_BALLOON_SUCCESS ? 0 : -EIO;
 }
 
-/*
- * Release the page allocated for the balloon. Note that we first notify
- * the host so it can make sure the page will be available for the guest
- * to use, if needed.
+/**
+ * vmballoon_release_page_list() - Releases a page list
+ *
+ * @page_list: list of pages to release.
+ * @n_pages: pointer to the number of pages.
+ * @page_size: whether the pages in the list are 2MB (or else 4KB).
+ *
+ * Releases the list of pages and zeros the number of pages.
  */
-static int vmballoon_unlock(struct vmballoon *b, unsigned int num_pages,
-			    bool is_2m_pages)
+static void vmballoon_release_page_list(struct list_head *page_list,
+				       int *n_pages,
+				       enum vmballoon_page_size_type page_size)
 {
-	int i;
-	unsigned long batch_status;
-	u16 size_per_page = vmballoon_page_size(is_2m_pages);
-
-	batch_status = vmballoon_lock_op(b, num_pages, is_2m_pages, false);
-
-	for (i = 0; i < num_pages; i++) {
-		struct vmballoon_page_size *page_size;
-		unsigned long status;
-		struct page *p;
+	struct page *page, *tmp;
 
-		status = vmballoon_status_page(b, i, &p);
-		page_size = &b->page_sizes[is_2m_pages];
-
-		/*
-		 * Failure of the whole batch overrides a single operation
-		 * results.
-		 */
-		if (batch_status != VMW_BALLOON_SUCCESS)
-			status = batch_status;
-
-		if (status != VMW_BALLOON_SUCCESS) {
-			/*
-			 * That page wasn't successfully unlocked by the
-			 * hypervisor, re-add it to the list of pages owned by
-			 * the balloon driver.
-			 */
-			list_add(&p->lru, &page_size->pages);
-		} else {
-			/* deallocate page */
-			vmballoon_free_page(p, is_2m_pages);
-			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_FREE,
-						 is_2m_pages);
-
-			/* update balloon size */
-			b->size -= size_per_page;
-		}
+	list_for_each_entry_safe(page, tmp, page_list, lru) {
+		list_del(&page->lru);
+		__free_pages(page, vmballoon_page_order(page_size));
 	}
 
-	return batch_status == VMW_BALLOON_SUCCESS ? 0 : -EIO;
+	*n_pages = 0;
 }
 
+
 /*
  * Release pages that were allocated while attempting to inflate the
  * balloon but were refused by the host for one reason or another.
  */
 static void vmballoon_release_refused_pages(struct vmballoon *b,
-		bool is_2m_pages)
+					    struct vmballoon_ctl *ctl)
 {
-	struct page *page, *next;
-	struct vmballoon_page_size *page_size =
-			&b->page_sizes[is_2m_pages];
+	vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_REFUSED_FREE,
+				 ctl->page_size);
 
-	list_for_each_entry_safe(page, next, &page_size->refused_pages, lru) {
-		list_del(&page->lru);
-		vmballoon_free_page(page, is_2m_pages);
-		vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_REFUSED_FREE,
-					 is_2m_pages);
-	}
-
-	page_size->n_refused_pages = 0;
-}
-
-static void vmballoon_add_page(struct vmballoon *b, int idx, struct page *p)
-{
-	if (static_branch_likely(&vmw_balloon_batching))
-		b->batch_page[idx] = (struct vmballoon_batch_entry)
-					{ .pfn = page_to_pfn(p) };
-	else
-		b->page = p;
+	vmballoon_release_page_list(&ctl->refused_pages, &ctl->n_refused_pages,
+				    ctl->page_size);
 }
 
 /**
@@ -744,8 +882,8 @@ static int64_t vmballoon_change(struct vmballoon *b)
 {
 	int64_t size, target;
 
-	size = b->size;
-	target = b->target;
+	size = atomic64_read(&b->size);
+	target = READ_ONCE(b->target);
 
 	/*
 	 * We must cast first because of int sizes
@@ -756,154 +894,257 @@ static int64_t vmballoon_change(struct vmballoon *b)
 		return 0;
 
 	/* consider a 2MB slack on deflate, unless the balloon is emptied */
-	if (target < size && size - target < vmballoon_page_size(true) &&
-	    target != 0)
+	if (target < size && target != 0 &&
+	    size - target < vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE))
 		return 0;
 
 	return target - size;
 }
 
-/*
- * Inflate the balloon towards its target size. Note that we try to limit
- * the rate of allocation to make sure we are not choking the rest of the
- * system.
+/**
+ * vmballoon_enqueue_page_list() - Enqueues list of pages after inflation.
+ *
+ * @b: pointer to balloon.
+ * @pages: list of pages to enqueue.
+ * @n_pages: pointer to number of pages in list. The value is zeroed.
+ * @page_size: whether the pages are 2MB or 4KB pages.
+ *
+ * Enqueues the provides list of pages in the ballooned page list, clears the
+ * list and zeroes the number of pages that was provided.
+ */
+static void vmballoon_enqueue_page_list(struct vmballoon *b,
+					struct list_head *pages,
+					unsigned int *n_pages,
+					enum vmballoon_page_size_type page_size)
+{
+	struct vmballoon_page_size *page_size_info = &b->page_sizes[page_size];
+
+	list_splice_init(pages, &page_size_info->pages);
+	*n_pages = 0;
+}
+
+/**
+ * vmballoon_dequeue_page_list() - Dequeues page lists for deflation.
+ *
+ * @b: pointer to balloon.
+ * @pages: list of pages to enqueue.
+ * @n_pages: pointer to number of pages in list. The value is zeroed.
+ * @page_size: whether the pages are 2MB or 4KB pages.
+ * @n_req_pages: the number of requested pages.
+ *
+ * Dequeues the number of requested pages from the balloon for deflation. The
+ * number of dequeued pages may be lower, if not enough pages in the requested
+ * size are available.
+ */
+static void vmballoon_dequeue_page_list(struct vmballoon *b,
+					struct list_head *pages,
+					unsigned int *n_pages,
+					enum vmballoon_page_size_type page_size,
+					unsigned int n_req_pages)
+{
+	struct vmballoon_page_size *page_size_info = &b->page_sizes[page_size];
+	struct page *page, *tmp;
+	unsigned int i = 0;
+
+	list_for_each_entry_safe(page, tmp, &page_size_info->pages, lru) {
+		list_move(&page->lru, pages);
+		if (++i == n_req_pages)
+			break;
+	}
+	*n_pages = i;
+}
+
+/**
+ * vmballoon_inflate() - Inflate the balloon towards its target size.
+ *
+ * @b: pointer to the balloon.
  */
 static void vmballoon_inflate(struct vmballoon *b)
 {
-	unsigned int num_pages = 0;
-	int error = 0;
-	bool is_2m_pages;
+	int64_t to_inflate_frames;
+	struct vmballoon_ctl ctl = {
+		.pages = LIST_HEAD_INIT(ctl.pages),
+		.refused_pages = LIST_HEAD_INIT(ctl.refused_pages),
+		.page_size = b->max_page_size,
+		.op = VMW_BALLOON_INFLATE
+	};
 
-	/*
-	 * First try NOSLEEP page allocations to inflate balloon.
-	 *
-	 * If we do not throttle nosleep allocations, we can drain all
-	 * free pages in the guest quickly (if the balloon target is high).
-	 * As a side-effect, draining free pages helps to inform (force)
-	 * the guest to start swapping if balloon target is not met yet,
-	 * which is a desired behavior. However, balloon driver can consume
-	 * all available CPU cycles if too many pages are allocated in a
-	 * second. Therefore, we throttle nosleep allocations even when
-	 * the guest is not under memory pressure. OTOH, if we have already
-	 * predicted that the guest is under memory pressure, then we
-	 * slowdown page allocations considerably.
-	 */
+	while ((to_inflate_frames = vmballoon_change(b)) > 0) {
+		unsigned int to_inflate_pages, page_in_frames;
+		int alloc_error, lock_error = 0;
 
-	/*
-	 * Start with no sleep allocation rate which may be higher
-	 * than sleeping allocation rate.
-	 */
-	is_2m_pages = b->supported_page_sizes == VMW_BALLOON_NUM_PAGE_SIZES;
+		VM_BUG_ON(!list_empty(&ctl.pages));
+		VM_BUG_ON(ctl.n_pages != 0);
 
-	while ((int64_t)(num_pages * vmballoon_page_size(is_2m_pages)) <
-	       vmballoon_change(b)) {
-		struct page *page;
+		page_in_frames = vmballoon_page_in_frames(ctl.page_size);
 
-		vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
-					 is_2m_pages);
-
-		page = vmballoon_alloc_page(is_2m_pages);
-		if (!page) {
-			vmballoon_stats_page_inc(b,
-				VMW_BALLOON_PAGE_STAT_ALLOC_FAIL, is_2m_pages);
-
-			if (is_2m_pages) {
-				vmballoon_lock(b, num_pages, true);
-
-				/*
-				 * ignore errors from locking as we now switch
-				 * to 4k pages and we might get different
-				 * errors.
-				 */
-
-				num_pages = 0;
-				is_2m_pages = false;
-				continue;
-			}
+		to_inflate_pages = min_t(unsigned long, b->batch_max_pages,
+					 DIV_ROUND_UP_ULL(to_inflate_frames,
+							  page_in_frames));
+
+		/* Start by allocating */
+		alloc_error = vmballoon_alloc_page_list(b, &ctl,
+							to_inflate_pages);
+
+		/* Actually lock the pages by telling the hypervisor */
+		lock_error = vmballoon_lock(b, &ctl);
+
+		/*
+		 * If an error indicates that something serious went wrong,
+		 * stop the inflation.
+		 */
+		if (lock_error)
 			break;
-		}
 
-		vmballoon_add_page(b, num_pages++, page);
-		if (num_pages == b->batch_max_pages) {
-			struct vmballoon_page_size *page_size =
-					&b->page_sizes[is_2m_pages];
+		/* Update the balloon size */
+		atomic64_add(ctl.n_pages * page_in_frames, &b->size);
 
-			error = vmballoon_lock(b, num_pages, is_2m_pages);
+		vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
+					    ctl.page_size);
 
-			num_pages = 0;
+		/*
+		 * If allocation failed or the number of refused pages exceeds
+		 * the maximum allowed, move to the next page size.
+		 */
+		if (alloc_error ||
+		    ctl.n_refused_pages >= VMW_BALLOON_MAX_REFUSED) {
+			if (ctl.page_size == VMW_BALLOON_4K_PAGE)
+				break;
 
 			/*
-			 * Stop allocating this page size if we already
-			 * accumulated too many pages that the hypervisor
-			 * refused.
+			 * Ignore errors from locking as we now switch to 4k
+			 * pages and we might get different errors.
 			 */
-			if (page_size->n_refused_pages >=
-			    VMW_BALLOON_MAX_REFUSED) {
-				if (!is_2m_pages)
-					break;
-
-				/*
-				 * Release the refused pages as we move to 4k
-				 * pages.
-				 */
-				vmballoon_release_refused_pages(b, true);
-				is_2m_pages = true;
-			}
-
-			if (error)
-				break;
+			vmballoon_release_refused_pages(b, &ctl);
+			ctl.page_size--;
 		}
 
 		cond_resched();
 	}
 
-	if (num_pages > 0)
-		vmballoon_lock(b, num_pages, is_2m_pages);
-
-	vmballoon_release_refused_pages(b, true);
-	vmballoon_release_refused_pages(b, false);
+	/*
+	 * Release pages that were allocated while attempting to inflate the
+	 * balloon but were refused by the host for one reason or another,
+	 * and update the statistics.
+	 */
+	if (ctl.n_refused_pages != 0)
+		vmballoon_release_refused_pages(b, &ctl);
 }
 
-/*
+/**
+ * vmballoon_deflate() - Decrease the size of the balloon.
+ *
+ * @b: pointer to the balloon
+ * @n_frames: the number of frames to deflate. If zero, automatically
+ * calculated according to the target size.
+ * @coordinated: whether to coordinate with the host
+ *
  * Decrease the size of the balloon allowing guest to use more memory.
+ *
+ * Return: The number of deflated frames (i.e., basic page size units)
  */
-static void vmballoon_deflate(struct vmballoon *b)
+static unsigned long vmballoon_deflate(struct vmballoon *b, uint64_t n_frames,
+				       bool coordinated)
 {
-	unsigned is_2m_pages;
+	unsigned long deflated_frames = 0;
+	unsigned long tried_frames = 0;
+	struct vmballoon_ctl ctl = {
+		.pages = LIST_HEAD_INIT(ctl.pages),
+		.refused_pages = LIST_HEAD_INIT(ctl.refused_pages),
+		.page_size = VMW_BALLOON_4K_PAGE,
+		.op = VMW_BALLOON_DEFLATE
+	};
 
 	/* free pages to reach target */
-	for (is_2m_pages = 0; is_2m_pages < b->supported_page_sizes;
-			is_2m_pages++) {
-		struct page *page, *next;
-		unsigned int num_pages = 0;
-		struct vmballoon_page_size *page_size =
-				&b->page_sizes[is_2m_pages];
-
-		list_for_each_entry_safe(page, next, &page_size->pages, lru) {
-			if ((int64_t)(num_pages *
-				      vmballoon_page_size(is_2m_pages)) >=
-					-vmballoon_change(b))
-				break;
+	while (true) {
+		unsigned int to_deflate_pages, n_unlocked_frames;
+		unsigned int page_in_frames;
+		int64_t to_deflate_frames;
+		bool deflated_all;
+
+		page_in_frames = vmballoon_page_in_frames(ctl.page_size);
+
+		VM_BUG_ON(!list_empty(&ctl.pages));
+		VM_BUG_ON(ctl.n_pages);
+		VM_BUG_ON(!list_empty(&ctl.refused_pages));
+		VM_BUG_ON(ctl.n_refused_pages);
+
+		/*
+		 * If we were requested a specific number of frames, we try to
+		 * deflate this number of frames. Otherwise, deflation is
+		 * performed according to the target and balloon size.
+		 */
+		to_deflate_frames = n_frames ? n_frames - tried_frames :
+					       -vmballoon_change(b);
+
+		/* break if no work to do */
+		if (to_deflate_frames <= 0)
+			break;
+
+		/*
+		 * Calculate the number of frames based on current page size,
+		 * but limit the deflated frames to a single chunk
+		 */
+		to_deflate_pages = min_t(unsigned long, b->batch_max_pages,
+					 DIV_ROUND_UP_ULL(to_deflate_frames,
+							  page_in_frames));
+
+		/* First take the pages from the balloon pages. */
+		vmballoon_dequeue_page_list(b, &ctl.pages, &ctl.n_pages,
+					    ctl.page_size, to_deflate_pages);
 
-			list_del(&page->lru);
-			vmballoon_add_page(b, num_pages++, page);
+		/*
+		 * Before pages are moving to the refused list, count their
+		 * frames as frames that we tried to deflate.
+		 */
+		tried_frames += ctl.n_pages * page_in_frames;
+
+		/*
+		 * Unlock the pages by communicating with the hypervisor if the
+		 * communication is coordinated (i.e., not pop). We ignore the
+		 * return code. Instead we check if all the pages we manage to
+		 * unlock all the pages. If we failed, we will move to the next
+		 * page size, and would eventually try again later.
+		 */
+		if (coordinated)
+			vmballoon_lock(b, &ctl);
+
+		/*
+		 * Check if we deflated enough. We will move to the next page
+		 * size if we did not manage to do so. This calculation takes
+		 * place now, as once the pages are released, the number of
+		 * pages is zeroed.
+		 */
+		deflated_all = (ctl.n_pages == to_deflate_pages);
 
-			if (num_pages == b->batch_max_pages) {
-				int error;
+		/* Update local and global counters */
+		n_unlocked_frames = ctl.n_pages * page_in_frames;
+		atomic64_sub(n_unlocked_frames, &b->size);
+		deflated_frames += n_unlocked_frames;
 
-				error = vmballoon_unlock(b, num_pages,
-						       is_2m_pages);
-				num_pages = 0;
-				if (error)
-					return;
-			}
+		vmballoon_stats_page_add(b, VMW_BALLOON_PAGE_STAT_FREE,
+					 ctl.page_size, ctl.n_pages);
 
-			cond_resched();
+		/* free the ballooned pages */
+		vmballoon_release_page_list(&ctl.pages, &ctl.n_pages,
+					    ctl.page_size);
+
+		/* Return the refused pages to the ballooned list. */
+		vmballoon_enqueue_page_list(b, &ctl.refused_pages,
+					    &ctl.n_refused_pages,
+					    ctl.page_size);
+
+		/* If we failed to unlock all the pages, move to next size. */
+		if (!deflated_all) {
+			if (ctl.page_size == b->max_page_size)
+				break;
+			ctl.page_size++;
 		}
 
-		if (num_pages > 0)
-			vmballoon_unlock(b, num_pages, is_2m_pages);
+		cond_resched();
 	}
+
+	return deflated_frames;
 }
 
 /**
@@ -1004,6 +1245,23 @@ static int vmballoon_vmci_init(struct vmballoon *b)
 	return -EIO;
 }
 
+/**
+ * vmballoon_pop - Quickly release all pages allocate for the balloon.
+ *
+ * @b: pointer to the balloon.
+ *
+ * This function is called when host decides to "reset" balloon for one reason
+ * or another. Unlike normal "deflate" we do not (shall not) notify host of the
+ * pages being released.
+ */
+static void vmballoon_pop(struct vmballoon *b)
+{
+	unsigned long size;
+
+	while ((size = atomic64_read(&b->size)))
+		vmballoon_deflate(b, size, false);
+}
+
 /*
  * Perform standard reset sequence by popping the balloon (in case it
  * is not  empty) and then restarting protocol. This operation normally
@@ -1080,13 +1338,13 @@ static void vmballoon_work(struct work_struct *work)
 		change = vmballoon_change(b);
 
 	if (change != 0) {
-		pr_debug("%s - size: %u, target %u", __func__,
-			 b->size, b->target);
+		pr_debug("%s - size: %llu, target %lu\n", __func__,
+			 atomic64_read(&b->size), READ_ONCE(b->target));
 
 		if (change > 0)
 			vmballoon_inflate(b);
 		else  /* (change < 0) */
-			vmballoon_deflate(b);
+			vmballoon_deflate(b, 0, true);
 	}
 
 	up_read(&b->conf_sem);
@@ -1118,11 +1376,6 @@ static const char * const vmballoon_stat_names[] = {
 	[VMW_BALLOON_STAT_DOORBELL]		= "doorbell"
 };
 
-static const char * const vmballoon_page_size_names[] = {
-	[VMW_BALLOON_4K_PAGE]			= "4k",
-	[VMW_BALLOON_2M_PAGE]			= "2M"
-};
-
 static int vmballoon_enable_stats(struct vmballoon *b)
 {
 	int r = 0;
@@ -1171,16 +1424,15 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 	}
 
 	/* format capabilities info */
-	seq_printf(f, "%-22s: %#4x\n", "balloon capabilities",
+	seq_printf(f, "%-22s: %#16x\n", "balloon capabilities",
 		   VMW_BALLOON_CAPABILITIES);
-	seq_printf(f, "%-22s: %#4lx\n", "used capabilities",
-		   b->capabilities);
+	seq_printf(f, "%-22s: %#16lx\n", "used capabilities", b->capabilities);
 	seq_printf(f, "%-22s: %16s\n", "is resetting",
 		   b->reset_required ? "y" : "n");
 
 	/* format size info */
-	seq_printf(f, "%-22s: %16u\n", "target", b->target);
-	seq_printf(f, "%-22s: %16u\n", "current", b->size);
+	seq_printf(f, "%-22s: %16lu\n", "target", READ_ONCE(b->target));
+	seq_printf(f, "%-22s: %16llu\n", "current", atomic64_read(&b->size));
 
 	for (i = 0; i < VMW_BALLOON_CMD_NUM; i++) {
 		if (vmballoon_cmd_names[i] == NULL)
@@ -1259,8 +1511,9 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
 
 static int __init vmballoon_init(void)
 {
+	enum vmballoon_page_size_type page_size;
 	int error;
-	unsigned is_2m_pages;
+
 	/*
 	 * Check if we are running on VMware's hypervisor and bail out
 	 * if we are not.
@@ -1268,11 +1521,10 @@ static int __init vmballoon_init(void)
 	if (x86_hyper_type != X86_HYPER_VMWARE)
 		return -ENODEV;
 
-	for (is_2m_pages = 0; is_2m_pages < VMW_BALLOON_NUM_PAGE_SIZES;
-			is_2m_pages++) {
-		INIT_LIST_HEAD(&balloon.page_sizes[is_2m_pages].pages);
-		INIT_LIST_HEAD(&balloon.page_sizes[is_2m_pages].refused_pages);
-	}
+	for (page_size = VMW_BALLOON_4K_PAGE;
+	     page_size <= VMW_BALLOON_LAST_SIZE; page_size++)
+		INIT_LIST_HEAD(&balloon.page_sizes[page_size].pages);
+
 
 	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
 
@@ -1280,6 +1532,7 @@ static int __init vmballoon_init(void)
 	if (error)
 		return error;
 
+	spin_lock_init(&balloon.comm_lock);
 	init_rwsem(&balloon.conf_sem);
 	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
 	balloon.batch_page = NULL;
-- 
2.17.1

