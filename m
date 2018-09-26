Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377A3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A2721533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A2721533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeI0BbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:31:02 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:2656 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbeI0B3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:40 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:00 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 51563B0D7C;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 01/20] vmw_balloon: handle commands in a single function.
Date:   Wed, 26 Sep 2018 12:13:17 -0700
Message-ID: <20180926191336.101885-2-namit@vmware.com>
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

By inlining the hypercall interface, we can unify several operations
into one central point in the code:

- Updating the target.
- Updating when a reset is needed.
- Update statistics (which will be done later in the patch-set).
- Print debug-messages (although they cannot be enabled as selectively).

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 223 +++++++++++++++++++------------------
 1 file changed, 116 insertions(+), 107 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 2543ef1ece17..0a4d5501f805 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -138,6 +138,15 @@ enum vmwballoon_capabilities {
 #define VMW_BALLOON_BATCH_STATUS_MASK	((1UL << 5) - 1)
 #define VMW_BALLOON_BATCH_PAGE_MASK	(~((1UL << PAGE_SHIFT) - 1))
 
+#define VMW_BALLOON_CMD_WITH_TARGET_MASK			\
+	((1UL << VMW_BALLOON_CMD_GET_TARGET)		|	\
+	 (1UL << VMW_BALLOON_CMD_LOCK)			|	\
+	 (1UL << VMW_BALLOON_CMD_UNLOCK)		|	\
+	 (1UL << VMW_BALLOON_CMD_BATCHED_LOCK)		|	\
+	 (1UL << VMW_BALLOON_CMD_BATCHED_UNLOCK)	|	\
+	 (1UL << VMW_BALLOON_CMD_BATCHED_2M_LOCK)	|	\
+	 (1UL << VMW_BALLOON_CMD_BATCHED_2M_UNLOCK))
+
 struct vmballoon_batch_page {
 	u64 pages[VMW_BALLOON_BATCH_MAX_PAGES];
 };
@@ -159,28 +168,6 @@ static void vmballoon_batch_set_pa(struct vmballoon_batch_page *batch, int idx,
 	batch->pages[idx] = pa;
 }
 
-
-#define VMWARE_BALLOON_CMD(cmd, arg1, arg2, result)		\
-({								\
-	unsigned long __status, __dummy1, __dummy2, __dummy3;	\
-	__asm__ __volatile__ ("inl %%dx" :			\
-		"=a"(__status),					\
-		"=c"(__dummy1),					\
-		"=d"(__dummy2),					\
-		"=b"(result),					\
-		"=S" (__dummy3) :				\
-		"0"(VMW_BALLOON_HV_MAGIC),			\
-		"1"(VMW_BALLOON_CMD_##cmd),			\
-		"2"(VMW_BALLOON_HV_PORT),			\
-		"3"(arg1),					\
-		"4" (arg2) :					\
-		"memory");					\
-	if (VMW_BALLOON_CMD_##cmd == VMW_BALLOON_CMD_START)	\
-		result = __dummy1;				\
-	result &= -1UL;						\
-	__status & -1UL;					\
-})
-
 #ifdef CONFIG_DEBUG_FS
 struct vmballoon_stats {
 	unsigned int timer;
@@ -220,9 +207,9 @@ struct vmballoon;
 struct vmballoon_ops {
 	void (*add_page)(struct vmballoon *b, int idx, struct page *p);
 	int (*lock)(struct vmballoon *b, unsigned int num_pages,
-			bool is_2m_pages, unsigned int *target);
+		    bool is_2m_pages);
 	int (*unlock)(struct vmballoon *b, unsigned int num_pages,
-			bool is_2m_pages, unsigned int *target);
+		      bool is_2m_pages);
 };
 
 struct vmballoon_page_size {
@@ -272,18 +259,64 @@ struct vmballoon {
 
 static struct vmballoon balloon;
 
+static inline unsigned long
+__vmballoon_cmd(struct vmballoon *b, unsigned long cmd, unsigned long arg1,
+		unsigned long arg2, unsigned long *result)
+{
+	unsigned long status, dummy1, dummy2, dummy3, local_result;
+
+	asm volatile ("inl %%dx" :
+		"=a"(status),
+		"=c"(dummy1),
+		"=d"(dummy2),
+		"=b"(local_result),
+		"=S"(dummy3) :
+		"0"(VMW_BALLOON_HV_MAGIC),
+		"1"(cmd),
+		"2"(VMW_BALLOON_HV_PORT),
+		"3"(arg1),
+		"4"(arg2) :
+		"memory");
+
+	/* update the result if needed */
+	if (result)
+		*result = (cmd == VMW_BALLOON_CMD_START) ? dummy1 :
+							   local_result;
+
+	/* update target when applicable */
+	if (status == VMW_BALLOON_SUCCESS &&
+	    ((1ul << cmd) & VMW_BALLOON_CMD_WITH_TARGET_MASK))
+		b->target = local_result;
+
+	/* mark reset required accordingly */
+	if (status == VMW_BALLOON_ERROR_RESET)
+		b->reset_required = true;
+
+	return status;
+}
+
+static __always_inline unsigned long
+vmballoon_cmd(struct vmballoon *b, unsigned long cmd, unsigned long arg1,
+	      unsigned long arg2)
+{
+	unsigned long dummy;
+
+	return __vmballoon_cmd(b, cmd, arg1, arg2, &dummy);
+}
+
 /*
  * Send "start" command to the host, communicating supported version
  * of the protocol.
  */
 static bool vmballoon_send_start(struct vmballoon *b, unsigned long req_caps)
 {
-	unsigned long status, capabilities, dummy = 0;
+	unsigned long status, capabilities;
 	bool success;
 
 	STATS_INC(b->stats.start);
 
-	status = VMWARE_BALLOON_CMD(START, req_caps, dummy, capabilities);
+	status = __vmballoon_cmd(b, VMW_BALLOON_CMD_START, req_caps, 0,
+				 &capabilities);
 
 	switch (status) {
 	case VMW_BALLOON_SUCCESS_WITH_CAPABILITIES:
@@ -316,21 +349,6 @@ static bool vmballoon_send_start(struct vmballoon *b, unsigned long req_caps)
 	return success;
 }
 
-static bool vmballoon_check_status(struct vmballoon *b, unsigned long status)
-{
-	switch (status) {
-	case VMW_BALLOON_SUCCESS:
-		return true;
-
-	case VMW_BALLOON_ERROR_RESET:
-		b->reset_required = true;
-		/* fall through */
-
-	default:
-		return false;
-	}
-}
-
 /*
  * Communicate guest type to the host so that it can adjust ballooning
  * algorithm to the one most appropriate for the guest. This command
@@ -339,14 +357,14 @@ static bool vmballoon_check_status(struct vmballoon *b, unsigned long status)
  */
 static bool vmballoon_send_guest_id(struct vmballoon *b)
 {
-	unsigned long status, dummy = 0;
+	unsigned long status;
 
-	status = VMWARE_BALLOON_CMD(GUEST_ID, VMW_BALLOON_GUEST_ID, dummy,
-				dummy);
+	status = vmballoon_cmd(b, VMW_BALLOON_CMD_GUEST_ID,
+			       VMW_BALLOON_GUEST_ID, 0);
 
 	STATS_INC(b->stats.guest_type);
 
-	if (vmballoon_check_status(b, status))
+	if (status == VMW_BALLOON_SUCCESS)
 		return true;
 
 	pr_debug("%s - failed, hv returns %ld\n", __func__, status);
@@ -365,12 +383,10 @@ static u16 vmballoon_page_size(bool is_2m_page)
 /*
  * Retrieve desired balloon size from the host.
  */
-static bool vmballoon_send_get_target(struct vmballoon *b, u32 *new_target)
+static bool vmballoon_send_get_target(struct vmballoon *b)
 {
 	unsigned long status;
-	unsigned long target;
 	unsigned long limit;
-	unsigned long dummy = 0;
 	u32 limit32;
 
 	/*
@@ -389,11 +405,10 @@ static bool vmballoon_send_get_target(struct vmballoon *b, u32 *new_target)
 	/* update stats */
 	STATS_INC(b->stats.target);
 
-	status = VMWARE_BALLOON_CMD(GET_TARGET, limit, dummy, target);
-	if (vmballoon_check_status(b, status)) {
-		*new_target = target;
+	status = vmballoon_cmd(b, VMW_BALLOON_CMD_GET_TARGET, limit, 0);
+
+	if (status == VMW_BALLOON_SUCCESS)
 		return true;
-	}
 
 	pr_debug("%s - failed, hv returns %ld\n", __func__, status);
 	STATS_INC(b->stats.target_fail);
@@ -406,9 +421,9 @@ static bool vmballoon_send_get_target(struct vmballoon *b, u32 *new_target)
  * check the return value and maybe submit a different page.
  */
 static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
-				unsigned int *hv_status, unsigned int *target)
+				    unsigned int *hv_status)
 {
-	unsigned long status, dummy = 0;
+	unsigned long status;
 	u32 pfn32;
 
 	pfn32 = (u32)pfn;
@@ -417,8 +432,9 @@ static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
 
 	STATS_INC(b->stats.lock[false]);
 
-	*hv_status = status = VMWARE_BALLOON_CMD(LOCK, pfn, dummy, *target);
-	if (vmballoon_check_status(b, status))
+	*hv_status = status = vmballoon_cmd(b, VMW_BALLOON_CMD_LOCK, pfn, 0);
+
+	if (status == VMW_BALLOON_SUCCESS)
 		return 0;
 
 	pr_debug("%s - ppn %lx, hv returns %ld\n", __func__, pfn, status);
@@ -427,21 +443,19 @@ static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
 }
 
 static int vmballoon_send_batched_lock(struct vmballoon *b,
-		unsigned int num_pages, bool is_2m_pages, unsigned int *target)
+				       unsigned int num_pages, bool is_2m_pages)
 {
-	unsigned long status;
 	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
+	unsigned long status, cmd;
 
 	STATS_INC(b->stats.lock[is_2m_pages]);
 
-	if (is_2m_pages)
-		status = VMWARE_BALLOON_CMD(BATCHED_2M_LOCK, pfn, num_pages,
-				*target);
-	else
-		status = VMWARE_BALLOON_CMD(BATCHED_LOCK, pfn, num_pages,
-				*target);
+	cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_LOCK :
+			    VMW_BALLOON_CMD_BATCHED_LOCK;
 
-	if (vmballoon_check_status(b, status))
+	status = vmballoon_cmd(b, cmd, pfn, num_pages);
+
+	if (status == VMW_BALLOON_SUCCESS)
 		return 0;
 
 	pr_debug("%s - batch ppn %lx, hv returns %ld\n", __func__, pfn, status);
@@ -453,10 +467,9 @@ static int vmballoon_send_batched_lock(struct vmballoon *b,
  * Notify the host that guest intends to release given page back into
  * the pool of available (to the guest) pages.
  */
-static bool vmballoon_send_unlock_page(struct vmballoon *b, unsigned long pfn,
-							unsigned int *target)
+static bool vmballoon_send_unlock_page(struct vmballoon *b, unsigned long pfn)
 {
-	unsigned long status, dummy = 0;
+	unsigned long status;
 	u32 pfn32;
 
 	pfn32 = (u32)pfn;
@@ -465,8 +478,8 @@ static bool vmballoon_send_unlock_page(struct vmballoon *b, unsigned long pfn,
 
 	STATS_INC(b->stats.unlock[false]);
 
-	status = VMWARE_BALLOON_CMD(UNLOCK, pfn, dummy, *target);
-	if (vmballoon_check_status(b, status))
+	status = vmballoon_cmd(b, VMW_BALLOON_CMD_UNLOCK, pfn, 0);
+	if (status == VMW_BALLOON_SUCCESS)
 		return true;
 
 	pr_debug("%s - ppn %lx, hv returns %ld\n", __func__, pfn, status);
@@ -475,21 +488,19 @@ static bool vmballoon_send_unlock_page(struct vmballoon *b, unsigned long pfn,
 }
 
 static bool vmballoon_send_batched_unlock(struct vmballoon *b,
-		unsigned int num_pages, bool is_2m_pages, unsigned int *target)
+		unsigned int num_pages, bool is_2m_pages)
 {
-	unsigned long status;
 	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
+	unsigned long status, cmd;
 
 	STATS_INC(b->stats.unlock[is_2m_pages]);
 
-	if (is_2m_pages)
-		status = VMWARE_BALLOON_CMD(BATCHED_2M_UNLOCK, pfn, num_pages,
-				*target);
-	else
-		status = VMWARE_BALLOON_CMD(BATCHED_UNLOCK, pfn, num_pages,
-				*target);
+	cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_UNLOCK :
+			    VMW_BALLOON_CMD_BATCHED_UNLOCK;
+
+	status = vmballoon_cmd(b, cmd, pfn, num_pages);
 
-	if (vmballoon_check_status(b, status))
+	if (status == VMW_BALLOON_SUCCESS)
 		return true;
 
 	pr_debug("%s - batch ppn %lx, hv returns %ld\n", __func__, pfn, status);
@@ -550,7 +561,7 @@ static void vmballoon_pop(struct vmballoon *b)
  * inflation cycle.
  */
 static int vmballoon_lock_page(struct vmballoon *b, unsigned int num_pages,
-				bool is_2m_pages, unsigned int *target)
+				bool is_2m_pages)
 {
 	int locked, hv_status;
 	struct page *page = b->page;
@@ -558,8 +569,8 @@ static int vmballoon_lock_page(struct vmballoon *b, unsigned int num_pages,
 
 	/* is_2m_pages can never happen as 2m pages support implies batching */
 
-	locked = vmballoon_send_lock_page(b, page_to_pfn(page), &hv_status,
-								target);
+	locked = vmballoon_send_lock_page(b, page_to_pfn(page), &hv_status);
+
 	if (locked) {
 		STATS_INC(b->stats.refused_alloc[false]);
 
@@ -594,13 +605,13 @@ static int vmballoon_lock_page(struct vmballoon *b, unsigned int num_pages,
 }
 
 static int vmballoon_lock_batched_page(struct vmballoon *b,
-		unsigned int num_pages, bool is_2m_pages, unsigned int *target)
+				       unsigned int num_pages, bool is_2m_pages)
 {
 	int locked, i;
 	u16 size_per_page = vmballoon_page_size(is_2m_pages);
 
-	locked = vmballoon_send_batched_lock(b, num_pages, is_2m_pages,
-			target);
+	locked = vmballoon_send_batched_lock(b, num_pages, is_2m_pages);
+
 	if (locked > 0) {
 		for (i = 0; i < num_pages; i++) {
 			u64 pa = vmballoon_batch_get_pa(b->batch_page, i);
@@ -653,14 +664,14 @@ static int vmballoon_lock_batched_page(struct vmballoon *b,
  * to use, if needed.
  */
 static int vmballoon_unlock_page(struct vmballoon *b, unsigned int num_pages,
-		bool is_2m_pages, unsigned int *target)
+				 bool is_2m_pages)
 {
 	struct page *page = b->page;
 	struct vmballoon_page_size *page_size = &b->page_sizes[false];
 
 	/* is_2m_pages can never happen as 2m pages support implies batching */
 
-	if (!vmballoon_send_unlock_page(b, page_to_pfn(page), target)) {
+	if (!vmballoon_send_unlock_page(b, page_to_pfn(page))) {
 		list_add(&page->lru, &page_size->pages);
 		return -EIO;
 	}
@@ -676,15 +687,14 @@ static int vmballoon_unlock_page(struct vmballoon *b, unsigned int num_pages,
 }
 
 static int vmballoon_unlock_batched_page(struct vmballoon *b,
-				unsigned int num_pages, bool is_2m_pages,
-				unsigned int *target)
+				unsigned int num_pages, bool is_2m_pages)
 {
 	int locked, i, ret = 0;
 	bool hv_success;
 	u16 size_per_page = vmballoon_page_size(is_2m_pages);
 
-	hv_success = vmballoon_send_batched_unlock(b, num_pages, is_2m_pages,
-			target);
+	hv_success = vmballoon_send_batched_unlock(b, num_pages, is_2m_pages);
+
 	if (!hv_success)
 		ret = -EIO;
 
@@ -799,7 +809,7 @@ static void vmballoon_inflate(struct vmballoon *b)
 			STATS_INC(b->stats.alloc_fail[is_2m_pages]);
 
 			if (is_2m_pages) {
-				b->ops->lock(b, num_pages, true, &b->target);
+				b->ops->lock(b, num_pages, true);
 
 				/*
 				 * ignore errors from locking as we now switch
@@ -838,8 +848,8 @@ static void vmballoon_inflate(struct vmballoon *b)
 
 		b->ops->add_page(b, num_pages++, page);
 		if (num_pages == b->batch_max_pages) {
-			error = b->ops->lock(b, num_pages, is_2m_pages,
-					&b->target);
+			error = b->ops->lock(b, num_pages, is_2m_pages);
+
 			num_pages = 0;
 			if (error)
 				break;
@@ -849,7 +859,7 @@ static void vmballoon_inflate(struct vmballoon *b)
 	}
 
 	if (num_pages > 0)
-		b->ops->lock(b, num_pages, is_2m_pages, &b->target);
+		b->ops->lock(b, num_pages, is_2m_pages);
 
 	vmballoon_release_refused_pages(b, true);
 	vmballoon_release_refused_pages(b, false);
@@ -887,7 +897,7 @@ static void vmballoon_deflate(struct vmballoon *b)
 				int error;
 
 				error = b->ops->unlock(b, num_pages,
-						is_2m_pages, &b->target);
+						       is_2m_pages);
 				num_pages = 0;
 				if (error)
 					return;
@@ -897,7 +907,7 @@ static void vmballoon_deflate(struct vmballoon *b)
 		}
 
 		if (num_pages > 0)
-			b->ops->unlock(b, num_pages, is_2m_pages, &b->target);
+			b->ops->unlock(b, num_pages, is_2m_pages);
 	}
 }
 
@@ -942,10 +952,9 @@ static void vmballoon_doorbell(void *client_data)
  */
 static void vmballoon_vmci_cleanup(struct vmballoon *b)
 {
-	int error;
+	vmballoon_cmd(b, VMW_BALLOON_CMD_VMCI_DOORBELL_SET,
+		      VMCI_INVALID_ID, VMCI_INVALID_ID);
 
-	VMWARE_BALLOON_CMD(VMCI_DOORBELL_SET, VMCI_INVALID_ID,
-			VMCI_INVALID_ID, error);
 	STATS_INC(b->stats.doorbell_unset);
 
 	if (!vmci_handle_is_invalid(b->vmci_doorbell)) {
@@ -959,7 +968,7 @@ static void vmballoon_vmci_cleanup(struct vmballoon *b)
  */
 static int vmballoon_vmci_init(struct vmballoon *b)
 {
-	unsigned long error, dummy;
+	unsigned long error;
 
 	if ((b->capabilities & VMW_BALLOON_SIGNALLED_WAKEUP_CMD) == 0)
 		return 0;
@@ -971,8 +980,9 @@ static int vmballoon_vmci_init(struct vmballoon *b)
 	if (error != VMCI_SUCCESS)
 		goto fail;
 
-	error = VMWARE_BALLOON_CMD(VMCI_DOORBELL_SET, b->vmci_doorbell.context,
-				   b->vmci_doorbell.resource, dummy);
+	error =	__vmballoon_cmd(b, VMW_BALLOON_CMD_VMCI_DOORBELL_SET,
+				b->vmci_doorbell.context,
+				b->vmci_doorbell.resource, NULL);
 
 	STATS_INC(b->stats.doorbell_set);
 
@@ -1038,17 +1048,16 @@ static void vmballoon_work(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct vmballoon *b = container_of(dwork, struct vmballoon, dwork);
-	unsigned int target;
 
 	STATS_INC(b->stats.timer);
 
 	if (b->reset_required)
 		vmballoon_reset(b);
 
-	if (!b->reset_required && vmballoon_send_get_target(b, &target)) {
-		/* update target, adjust size */
-		b->target = target;
+	if (!b->reset_required && vmballoon_send_get_target(b)) {
+		unsigned long target = b->target;
 
+		/* update target, adjust size */
 		if (b->size < target)
 			vmballoon_inflate(b);
 		else if (target == 0 ||
-- 
2.17.1

