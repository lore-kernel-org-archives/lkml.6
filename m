Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC82EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC2E21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC2E21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeI0B3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:29:42 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:2656 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727221AbeI0B3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:41 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:01 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 7E07BB0D7C;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 06/20] vmw_balloon: change batch/single lock abstractions
Date:   Wed, 26 Sep 2018 12:13:22 -0700
Message-ID: <20180926191336.101885-7-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926191336.101885-1-namit@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current abstractions for batch vs single operations seem suboptimal
and complicate the implementation of additional features (OOM,
compaction).

The immediate problem of the current abstractions is that they cause
differences in how operations are handled when batching is on or off.
For example, the refused_alloc counter is not updated when batching is
on. These discrepancies are caused by code redundancies.

Instead, this patch presents three type of operations, according to
whether batching is on or off: (1) add page, (2) communication with the
hypervisor and (3) retrieving the status of a page.

To avoid the overhead of virtual functions, and since we do not expect
additional interfaces for communication with the hypervisor, we use
static keys instead of virtual functions.

Finally, while we are at it, change vmballoon_init_batching() to return
int instead of bool, to be consistent in the return type and avoid
potential coding errors.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 358 +++++++++++++++++--------------------
 1 file changed, 165 insertions(+), 193 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 952308997499..96dde120bbd5 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -165,15 +165,7 @@ struct vmballoon_stats {
 #define STATS_INC(stat)
 #endif
 
-struct vmballoon;
-
-struct vmballoon_ops {
-	void (*add_page)(struct vmballoon *b, int idx, struct page *p);
-	int (*lock)(struct vmballoon *b, unsigned int num_pages,
-		    bool is_2m_pages);
-	int (*unlock)(struct vmballoon *b, unsigned int num_pages,
-		      bool is_2m_pages);
-};
+static DEFINE_STATIC_KEY_TRUE(vmw_balloon_batching);
 
 struct vmballoon_page_size {
 	/* list of reserved physical pages */
@@ -223,8 +215,6 @@ struct vmballoon {
 	unsigned int batch_max_pages;
 	struct page *page;
 
-	const struct vmballoon_ops *ops;
-
 #ifdef CONFIG_DEBUG_FS
 	/* statistics */
 	struct vmballoon_stats stats;
@@ -393,53 +383,6 @@ static bool vmballoon_send_get_target(struct vmballoon *b)
 	return false;
 }
 
-/*
- * Notify the host about allocated page so that host can use it without
- * fear that guest will need it. Host may reject some pages, we need to
- * check the return value and maybe submit a different page.
- */
-static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
-				    unsigned int *hv_status, bool lock)
-{
-	unsigned long status, cmd;
-	u32 pfn32;
-
-	pfn32 = (u32)pfn;
-	if (pfn32 != pfn)
-		return -EINVAL;
-
-	cmd = lock ? VMW_BALLOON_CMD_LOCK : VMW_BALLOON_CMD_UNLOCK;
-
-	*hv_status = status = vmballoon_cmd(b, cmd, pfn, 0);
-
-	if (status == VMW_BALLOON_SUCCESS)
-		return 0;
-
-	return -EIO;
-}
-
-static int vmballoon_send_batched_lock(struct vmballoon *b,
-				       unsigned int num_pages, bool is_2m_pages,
-				       bool lock)
-{
-	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
-	unsigned long status, cmd;
-
-	if (lock)
-		cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_LOCK :
-				    VMW_BALLOON_CMD_BATCHED_LOCK;
-	else
-		cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_UNLOCK :
-				    VMW_BALLOON_CMD_BATCHED_UNLOCK;
-
-	status = vmballoon_cmd(b, cmd, pfn, num_pages);
-
-	if (status == VMW_BALLOON_SUCCESS)
-		return 0;
-
-	return 1;
-}
-
 static struct page *vmballoon_alloc_page(bool is_2m_page)
 {
 	if (is_2m_page)
@@ -488,88 +431,126 @@ static void vmballoon_pop(struct vmballoon *b)
 	b->batch_page = NULL;
 }
 
-/*
- * Notify the host of a ballooned page. If host rejects the page put it on the
- * refuse list, those refused page are then released at the end of the
- * inflation cycle.
+/**
+ * vmballoon_status_page - returns the status of (un)lock operation
+ *
+ * @b: pointer to the balloon.
+ * @idx: index for the page for which the operation is performed.
+ * @p: pointer to where the page struct is returned.
+ *
+ * Following a lock or unlock operation, returns the status of the operation for
+ * an individual page. Provides the page that the operation was performed on on
+ * the @page argument.
+ *
+ * Returns: The status of a lock or unlock operation for an individual page.
  */
-static int vmballoon_lock_page(struct vmballoon *b, unsigned int num_pages,
-				bool is_2m_pages)
+static unsigned long vmballoon_status_page(struct vmballoon *b, int idx,
+					   struct page **p)
 {
-	int locked, hv_status;
-	struct page *page = b->page;
-	struct vmballoon_page_size *page_size = &b->page_sizes[false];
-
-	/* is_2m_pages can never happen as 2m pages support implies batching */
-
-	locked = vmballoon_send_lock_page(b, page_to_pfn(page), &hv_status,
-					  true);
+	if (static_branch_likely(&vmw_balloon_batching)) {
+		/* batching mode */
+		*p = pfn_to_page(b->batch_page[idx].pfn);
+		return b->batch_page[idx].status;
+	}
 
-	if (locked) {
-		STATS_INC(b->stats.refused_alloc[false]);
+	/* non-batching mode */
+	*p = b->page;
 
-		if (locked == -EIO &&
-		    (hv_status == VMW_BALLOON_ERROR_RESET ||
-		     hv_status == VMW_BALLOON_ERROR_PPN_NOTNEEDED)) {
-			vmballoon_free_page(page, false);
-			return -EIO;
-		}
+	/*
+	 * If a failure occurs, the indication will be provided in the status
+	 * of the entire operation, which is considered before the individual
+	 * page status. So for non-batching mode, the indication is always of
+	 * success.
+	 */
+	return VMW_BALLOON_SUCCESS;
+}
 
-		/*
-		 * Place page on the list of non-balloonable pages
-		 * and retry allocation, unless we already accumulated
-		 * too many of them, in which case take a breather.
-		 */
-		if (page_size->n_refused_pages < VMW_BALLOON_MAX_REFUSED) {
-			page_size->n_refused_pages++;
-			list_add(&page->lru, &page_size->refused_pages);
-		} else {
-			vmballoon_free_page(page, false);
-		}
-		return locked;
+/**
+ * vmballoon_lock_op - notifies the host about inflated/deflated pages.
+ * @b: pointer to the balloon.
+ * @num_pages: number of inflated/deflated pages.
+ * @is_2m_pages: whether the page(s) are 2M (or 4k).
+ * @lock: whether the operation is lock (or unlock).
+ *
+ * Notify the host about page(s) that were ballooned (or removed from the
+ * balloon) so that host can use it without fear that guest will need it (or
+ * stop using them since the VM does). Host may reject some pages, we need to
+ * check the return value and maybe submit a different page. The pages that are
+ * inflated/deflated are pointed by @b->page.
+ *
+ * Return: result as provided by the hypervisor.
+ */
+static unsigned long vmballoon_lock_op(struct vmballoon *b,
+				       unsigned int num_pages,
+				       bool is_2m_pages, bool lock)
+{
+	unsigned long cmd, pfn;
+
+	if (static_branch_likely(&vmw_balloon_batching)) {
+		if (lock)
+			cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_LOCK :
+					    VMW_BALLOON_CMD_BATCHED_LOCK;
+		else
+			cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_UNLOCK :
+					    VMW_BALLOON_CMD_BATCHED_UNLOCK;
+
+		pfn = PHYS_PFN(virt_to_phys(b->batch_page));
+	} else {
+		cmd = lock ? VMW_BALLOON_CMD_LOCK : VMW_BALLOON_CMD_UNLOCK;
+		pfn = page_to_pfn(b->page);
+
+		/* In non-batching mode, PFNs must fit in 32-bit */
+		if (unlikely(pfn != (u32)pfn))
+			return VMW_BALLOON_ERROR_PPN_INVALID;
 	}
 
-	/* track allocated page */
-	list_add(&page->lru, &page_size->pages);
-
-	/* update balloon size */
-	b->size++;
-
-	return 0;
+	return vmballoon_cmd(b, cmd, pfn, num_pages);
 }
 
-static int vmballoon_lock_batched_page(struct vmballoon *b,
-				       unsigned int num_pages, bool is_2m_pages)
+static int vmballoon_lock(struct vmballoon *b, unsigned int num_pages,
+			  bool is_2m_pages)
 {
-	int locked, i;
+	unsigned long batch_status;
+	int i;
 	u16 size_per_page = vmballoon_page_size(is_2m_pages);
 
-	locked = vmballoon_send_batched_lock(b, num_pages, is_2m_pages, true);
-
-	if (locked > 0) {
-		for (i = 0; i < num_pages; i++) {
-			struct page *p = pfn_to_page(b->batch_page[i].pfn);
-
-			vmballoon_free_page(p, is_2m_pages);
-		}
-
-		return -EIO;
-	}
+	batch_status = vmballoon_lock_op(b, num_pages, is_2m_pages, true);
 
 	for (i = 0; i < num_pages; i++) {
-		struct page *p = pfn_to_page(b->batch_page[i].pfn);
+		unsigned long status;
+		struct page *p;
 		struct vmballoon_page_size *page_size =
 				&b->page_sizes[is_2m_pages];
 
-		locked = b->batch_page[i].status;
+		status = vmballoon_status_page(b, i, &p);
+
+		/*
+		 * Failure of the whole batch overrides a single operation
+		 * results.
+		 */
+		if (batch_status != VMW_BALLOON_SUCCESS)
+			status = batch_status;
 
-		switch (locked) {
-		case VMW_BALLOON_SUCCESS:
+		if (status == VMW_BALLOON_SUCCESS) {
+			/* track allocated page */
 			list_add(&p->lru, &page_size->pages);
+
+			/* update balloon size */
 			b->size += size_per_page;
-			break;
+			continue;
+		}
+
+		/* Error occurred */
+		STATS_INC(b->stats.refused_alloc[is_2m_pages]);
+
+		switch (status) {
 		case VMW_BALLOON_ERROR_PPN_PINNED:
 		case VMW_BALLOON_ERROR_PPN_INVALID:
+			/*
+			 * Place page on the list of non-balloonable pages
+			 * and retry allocation, unless we already accumulated
+			 * too many of them, in which case take a breather.
+			 */
 			if (page_size->n_refused_pages
 					< VMW_BALLOON_MAX_REFUSED) {
 				list_add(&p->lru, &page_size->refused_pages);
@@ -587,7 +568,7 @@ static int vmballoon_lock_batched_page(struct vmballoon *b,
 		}
 	}
 
-	return 0;
+	return batch_status == VMW_BALLOON_SUCCESS ? 0 : -EIO;
 }
 
 /*
@@ -595,51 +576,31 @@ static int vmballoon_lock_batched_page(struct vmballoon *b,
  * the host so it can make sure the page will be available for the guest
  * to use, if needed.
  */
-static int vmballoon_unlock_page(struct vmballoon *b, unsigned int num_pages,
-				 bool is_2m_pages)
+static int vmballoon_unlock(struct vmballoon *b, unsigned int num_pages,
+			    bool is_2m_pages)
 {
-	struct page *page = b->page;
-	struct vmballoon_page_size *page_size = &b->page_sizes[false];
-	unsigned int hv_status;
-
-	/* is_2m_pages can never happen as 2m pages support implies batching */
-
-	if (!vmballoon_send_lock_page(b, page_to_pfn(page), &hv_status,
-				      false)) {
-		list_add(&page->lru, &page_size->pages);
-		return -EIO;
-	}
-
-	/* deallocate page */
-	vmballoon_free_page(page, false);
-	STATS_INC(b->stats.free[false]);
-
-	/* update balloon size */
-	b->size--;
-
-	return 0;
-}
-
-static int vmballoon_unlock_batched_page(struct vmballoon *b,
-				unsigned int num_pages, bool is_2m_pages)
-{
-	int locked, i, ret = 0;
-	bool hv_success;
+	int i;
+	unsigned long batch_status;
 	u16 size_per_page = vmballoon_page_size(is_2m_pages);
 
-	hv_success = vmballoon_send_batched_lock(b, num_pages, is_2m_pages,
-						 false);
-
-	if (!hv_success)
-		ret = -EIO;
+	batch_status = vmballoon_lock_op(b, num_pages, is_2m_pages, false);
 
 	for (i = 0; i < num_pages; i++) {
-		struct page *p = pfn_to_page(b->batch_page[i].pfn);
-		struct vmballoon_page_size *page_size =
-				&b->page_sizes[is_2m_pages];
+		struct vmballoon_page_size *page_size;
+		unsigned long status;
+		struct page *p;
 
-		locked = b->batch_page[i].status;
-		if (!hv_success || locked != VMW_BALLOON_SUCCESS) {
+		status = vmballoon_status_page(b, i, &p);
+		page_size = &b->page_sizes[is_2m_pages];
+
+		/*
+		 * Failure of the whole batch overrides a single operation
+		 * results.
+		 */
+		if (batch_status != VMW_BALLOON_SUCCESS)
+			status = batch_status;
+
+		if (status != VMW_BALLOON_SUCCESS) {
 			/*
 			 * That page wasn't successfully unlocked by the
 			 * hypervisor, re-add it to the list of pages owned by
@@ -656,7 +617,7 @@ static int vmballoon_unlock_batched_page(struct vmballoon *b,
 		}
 	}
 
-	return ret;
+	return batch_status == VMW_BALLOON_SUCCESS ? 0 : -EIO;
 }
 
 /*
@@ -681,14 +642,11 @@ static void vmballoon_release_refused_pages(struct vmballoon *b,
 
 static void vmballoon_add_page(struct vmballoon *b, int idx, struct page *p)
 {
-	b->page = p;
-}
-
-static void vmballoon_add_batched_page(struct vmballoon *b, int idx,
-				struct page *p)
-{
-	b->batch_page[idx] = (struct vmballoon_batch_entry)
+	if (static_branch_likely(&vmw_balloon_batching))
+		b->batch_page[idx] = (struct vmballoon_batch_entry)
 					{ .pfn = page_to_pfn(p) };
+	else
+		b->page = p;
 }
 
 /*
@@ -737,7 +695,7 @@ static void vmballoon_inflate(struct vmballoon *b)
 		if (!page) {
 			STATS_INC(b->stats.alloc_fail[is_2m_pages]);
 			if (is_2m_pages) {
-				b->ops->lock(b, num_pages, true);
+				vmballoon_lock(b, num_pages, true);
 
 				/*
 				 * ignore errors from locking as we now switch
@@ -752,9 +710,9 @@ static void vmballoon_inflate(struct vmballoon *b)
 			break;
 		}
 
-		b->ops->add_page(b, num_pages++, page);
+		vmballoon_add_page(b, num_pages++, page);
 		if (num_pages == b->batch_max_pages) {
-			error = b->ops->lock(b, num_pages, is_2m_pages);
+			error = vmballoon_lock(b, num_pages, is_2m_pages);
 
 			num_pages = 0;
 			if (error)
@@ -765,7 +723,7 @@ static void vmballoon_inflate(struct vmballoon *b)
 	}
 
 	if (num_pages > 0)
-		b->ops->lock(b, num_pages, is_2m_pages);
+		vmballoon_lock(b, num_pages, is_2m_pages);
 
 	vmballoon_release_refused_pages(b, true);
 	vmballoon_release_refused_pages(b, false);
@@ -797,12 +755,12 @@ static void vmballoon_deflate(struct vmballoon *b)
 				break;
 
 			list_del(&page->lru);
-			b->ops->add_page(b, num_pages++, page);
+			vmballoon_add_page(b, num_pages++, page);
 
 			if (num_pages == b->batch_max_pages) {
 				int error;
 
-				error = b->ops->unlock(b, num_pages,
+				error = vmballoon_unlock(b, num_pages,
 						       is_2m_pages);
 				num_pages = 0;
 				if (error)
@@ -813,32 +771,50 @@ static void vmballoon_deflate(struct vmballoon *b)
 		}
 
 		if (num_pages > 0)
-			b->ops->unlock(b, num_pages, is_2m_pages);
+			vmballoon_unlock(b, num_pages, is_2m_pages);
 	}
 }
 
-static const struct vmballoon_ops vmballoon_basic_ops = {
-	.add_page = vmballoon_add_page,
-	.lock = vmballoon_lock_page,
-	.unlock = vmballoon_unlock_page
-};
-
-static const struct vmballoon_ops vmballoon_batched_ops = {
-	.add_page = vmballoon_add_batched_page,
-	.lock = vmballoon_lock_batched_page,
-	.unlock = vmballoon_unlock_batched_page
-};
+/**
+ * vmballoon_deinit_batching - disables batching mode.
+ *
+ * @b: pointer to &struct vmballoon.
+ *
+ * Disables batching, by deallocating the page for communication with the
+ * hypervisor and disabling the static key to indicate that batching is off.
+ */
+static void vmballoon_deinit_batching(struct vmballoon *b)
+{
+	free_page((unsigned long)b->batch_page);
+	b->batch_page = NULL;
+	static_branch_disable(&vmw_balloon_batching);
+	b->batch_max_pages = 1;
+}
 
-static bool vmballoon_init_batching(struct vmballoon *b)
+/**
+ * vmballoon_init_batching - enable batching mode.
+ *
+ * @b: pointer to &struct vmballoon.
+ *
+ * Enables batching, by allocating a page for communication with the hypervisor
+ * and enabling the static_key to use batching.
+ *
+ * Return: zero on success or an appropriate error-code.
+ */
+static int vmballoon_init_batching(struct vmballoon *b)
 {
 	struct page *page;
 
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!page)
-		return false;
+		return -ENOMEM;
 
 	b->batch_page = page_address(page);
-	return true;
+	b->batch_max_pages = PAGE_SIZE / sizeof(struct vmballoon_batch_entry);
+
+	static_branch_enable(&vmw_balloon_batching);
+
+	return 0;
 }
 
 /*
@@ -915,10 +891,7 @@ static void vmballoon_reset(struct vmballoon *b)
 		return;
 
 	if ((b->capabilities & VMW_BALLOON_BATCHED_CMDS) != 0) {
-		b->ops = &vmballoon_batched_ops;
-		b->batch_max_pages = PAGE_SIZE / sizeof(struct
-							vmballoon_batch_entry);
-		if (!vmballoon_init_batching(b)) {
+		if (vmballoon_init_batching(b)) {
 			/*
 			 * We failed to initialize batching, inform the monitor
 			 * about it by sending a null capability.
@@ -929,8 +902,7 @@ static void vmballoon_reset(struct vmballoon *b)
 			return;
 		}
 	} else if ((b->capabilities & VMW_BALLOON_BASIC_CMDS) != 0) {
-		b->ops = &vmballoon_basic_ops;
-		b->batch_max_pages = 1;
+		vmballoon_deinit_batching(b);
 	}
 
 	b->reset_required = false;
-- 
2.17.1

