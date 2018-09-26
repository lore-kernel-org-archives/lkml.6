Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91281C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477A821533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477A821533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeI0B3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:29:35 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25069 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbeI0B3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:35 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:04 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 607AEB0E88;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 02/20] vmw_balloon: unify commands tracing and stats
Date:   Wed, 26 Sep 2018 12:13:18 -0700
Message-ID: <20180926191336.101885-3-namit@vmware.com>
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

Now that we have a single point, unify the tracing and collecting the
statistics for commands and their failure. While it might somewhat
reduce the control over debugging, it cleans the code a lot.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 116 +++++++++++++------------------------
 1 file changed, 41 insertions(+), 75 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 0a4d5501f805..2ed4875319c8 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -105,6 +105,7 @@ enum vmwballoon_capabilities {
 #define VMW_BALLOON_CMD_BATCHED_2M_UNLOCK	9
 #define VMW_BALLOON_CMD_VMCI_DOORBELL_SET	10
 
+#define VMW_BALLOON_CMD_NUM			11
 
 /* error codes */
 #define VMW_BALLOON_SUCCESS		        0
@@ -147,6 +148,19 @@ enum vmwballoon_capabilities {
 	 (1UL << VMW_BALLOON_CMD_BATCHED_2M_LOCK)	|	\
 	 (1UL << VMW_BALLOON_CMD_BATCHED_2M_UNLOCK))
 
+static const char * const vmballoon_cmd_names[] = {
+	[VMW_BALLOON_CMD_START]			= "start",
+	[VMW_BALLOON_CMD_GET_TARGET]		= "target",
+	[VMW_BALLOON_CMD_LOCK]			= "lock",
+	[VMW_BALLOON_CMD_UNLOCK]		= "unlock",
+	[VMW_BALLOON_CMD_GUEST_ID]		= "guestType",
+	[VMW_BALLOON_CMD_BATCHED_LOCK]		= "batchLock",
+	[VMW_BALLOON_CMD_BATCHED_UNLOCK]	= "batchUnlock",
+	[VMW_BALLOON_CMD_BATCHED_2M_LOCK]	= "2m-lock",
+	[VMW_BALLOON_CMD_BATCHED_2M_UNLOCK]	= "2m-unlock",
+	[VMW_BALLOON_CMD_VMCI_DOORBELL_SET]	= "doorbellSet"
+};
+
 struct vmballoon_batch_page {
 	u64 pages[VMW_BALLOON_BATCH_MAX_PAGES];
 };
@@ -182,19 +196,9 @@ struct vmballoon_stats {
 	unsigned int refused_free[VMW_BALLOON_NUM_PAGE_SIZES];
 	unsigned int free[VMW_BALLOON_NUM_PAGE_SIZES];
 
-	/* monitor operations */
-	unsigned int lock[VMW_BALLOON_NUM_PAGE_SIZES];
-	unsigned int lock_fail[VMW_BALLOON_NUM_PAGE_SIZES];
-	unsigned int unlock[VMW_BALLOON_NUM_PAGE_SIZES];
-	unsigned int unlock_fail[VMW_BALLOON_NUM_PAGE_SIZES];
-	unsigned int target;
-	unsigned int target_fail;
-	unsigned int start;
-	unsigned int start_fail;
-	unsigned int guest_type;
-	unsigned int guest_type_fail;
-	unsigned int doorbell_set;
-	unsigned int doorbell_unset;
+	/* Monitor operations.  */
+	unsigned long ops[VMW_BALLOON_CMD_NUM];
+	unsigned long ops_fail[VMW_BALLOON_CMD_NUM];
 };
 
 #define STATS_INC(stat) (stat)++
@@ -265,6 +269,8 @@ __vmballoon_cmd(struct vmballoon *b, unsigned long cmd, unsigned long arg1,
 {
 	unsigned long status, dummy1, dummy2, dummy3, local_result;
 
+	STATS_INC(b->stats.ops[cmd]);
+
 	asm volatile ("inl %%dx" :
 		"=a"(status),
 		"=c"(dummy1),
@@ -288,6 +294,14 @@ __vmballoon_cmd(struct vmballoon *b, unsigned long cmd, unsigned long arg1,
 	    ((1ul << cmd) & VMW_BALLOON_CMD_WITH_TARGET_MASK))
 		b->target = local_result;
 
+	if (status != VMW_BALLOON_SUCCESS &&
+	    status != VMW_BALLOON_SUCCESS_WITH_CAPABILITIES) {
+		STATS_INC(b->stats.ops_fail[cmd]);
+		pr_debug("%s: %s [0x%lx,0x%lx) failed, returned %ld\n",
+			 __func__, vmballoon_cmd_names[cmd], arg1, arg2,
+			 status);
+	}
+
 	/* mark reset required accordingly */
 	if (status == VMW_BALLOON_ERROR_RESET)
 		b->reset_required = true;
@@ -313,8 +327,6 @@ static bool vmballoon_send_start(struct vmballoon *b, unsigned long req_caps)
 	unsigned long status, capabilities;
 	bool success;
 
-	STATS_INC(b->stats.start);
-
 	status = __vmballoon_cmd(b, VMW_BALLOON_CMD_START, req_caps, 0,
 				 &capabilities);
 
@@ -342,10 +354,6 @@ static bool vmballoon_send_start(struct vmballoon *b, unsigned long req_caps)
 	else
 		b->supported_page_sizes = 1;
 
-	if (!success) {
-		pr_debug("%s - failed, hv returns %ld\n", __func__, status);
-		STATS_INC(b->stats.start_fail);
-	}
 	return success;
 }
 
@@ -362,13 +370,9 @@ static bool vmballoon_send_guest_id(struct vmballoon *b)
 	status = vmballoon_cmd(b, VMW_BALLOON_CMD_GUEST_ID,
 			       VMW_BALLOON_GUEST_ID, 0);
 
-	STATS_INC(b->stats.guest_type);
-
 	if (status == VMW_BALLOON_SUCCESS)
 		return true;
 
-	pr_debug("%s - failed, hv returns %ld\n", __func__, status);
-	STATS_INC(b->stats.guest_type_fail);
 	return false;
 }
 
@@ -402,16 +406,11 @@ static bool vmballoon_send_get_target(struct vmballoon *b)
 	if (limit != limit32)
 		return false;
 
-	/* update stats */
-	STATS_INC(b->stats.target);
-
 	status = vmballoon_cmd(b, VMW_BALLOON_CMD_GET_TARGET, limit, 0);
 
 	if (status == VMW_BALLOON_SUCCESS)
 		return true;
 
-	pr_debug("%s - failed, hv returns %ld\n", __func__, status);
-	STATS_INC(b->stats.target_fail);
 	return false;
 }
 
@@ -430,15 +429,11 @@ static int vmballoon_send_lock_page(struct vmballoon *b, unsigned long pfn,
 	if (pfn32 != pfn)
 		return -EINVAL;
 
-	STATS_INC(b->stats.lock[false]);
-
 	*hv_status = status = vmballoon_cmd(b, VMW_BALLOON_CMD_LOCK, pfn, 0);
 
 	if (status == VMW_BALLOON_SUCCESS)
 		return 0;
 
-	pr_debug("%s - ppn %lx, hv returns %ld\n", __func__, pfn, status);
-	STATS_INC(b->stats.lock_fail[false]);
 	return -EIO;
 }
 
@@ -448,8 +443,6 @@ static int vmballoon_send_batched_lock(struct vmballoon *b,
 	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
 	unsigned long status, cmd;
 
-	STATS_INC(b->stats.lock[is_2m_pages]);
-
 	cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_LOCK :
 			    VMW_BALLOON_CMD_BATCHED_LOCK;
 
@@ -458,8 +451,6 @@ static int vmballoon_send_batched_lock(struct vmballoon *b,
 	if (status == VMW_BALLOON_SUCCESS)
 		return 0;
 
-	pr_debug("%s - batch ppn %lx, hv returns %ld\n", __func__, pfn, status);
-	STATS_INC(b->stats.lock_fail[is_2m_pages]);
 	return 1;
 }
 
@@ -476,15 +467,8 @@ static bool vmballoon_send_unlock_page(struct vmballoon *b, unsigned long pfn)
 	if (pfn32 != pfn)
 		return false;
 
-	STATS_INC(b->stats.unlock[false]);
-
 	status = vmballoon_cmd(b, VMW_BALLOON_CMD_UNLOCK, pfn, 0);
-	if (status == VMW_BALLOON_SUCCESS)
-		return true;
-
-	pr_debug("%s - ppn %lx, hv returns %ld\n", __func__, pfn, status);
-	STATS_INC(b->stats.unlock_fail[false]);
-	return false;
+	return status == VMW_BALLOON_SUCCESS;
 }
 
 static bool vmballoon_send_batched_unlock(struct vmballoon *b,
@@ -493,19 +477,12 @@ static bool vmballoon_send_batched_unlock(struct vmballoon *b,
 	unsigned long pfn = PHYS_PFN(virt_to_phys(b->batch_page));
 	unsigned long status, cmd;
 
-	STATS_INC(b->stats.unlock[is_2m_pages]);
-
 	cmd = is_2m_pages ? VMW_BALLOON_CMD_BATCHED_2M_UNLOCK :
 			    VMW_BALLOON_CMD_BATCHED_UNLOCK;
 
 	status = vmballoon_cmd(b, cmd, pfn, num_pages);
 
-	if (status == VMW_BALLOON_SUCCESS)
-		return true;
-
-	pr_debug("%s - batch ppn %lx, hv returns %ld\n", __func__, pfn, status);
-	STATS_INC(b->stats.unlock_fail[is_2m_pages]);
-	return false;
+	return status == VMW_BALLOON_SUCCESS;
 }
 
 static struct page *vmballoon_alloc_page(gfp_t flags, bool is_2m_page)
@@ -955,8 +932,6 @@ static void vmballoon_vmci_cleanup(struct vmballoon *b)
 	vmballoon_cmd(b, VMW_BALLOON_CMD_VMCI_DOORBELL_SET,
 		      VMCI_INVALID_ID, VMCI_INVALID_ID);
 
-	STATS_INC(b->stats.doorbell_unset);
-
 	if (!vmci_handle_is_invalid(b->vmci_doorbell)) {
 		vmci_doorbell_destroy(b->vmci_doorbell);
 		b->vmci_doorbell = VMCI_INVALID_HANDLE;
@@ -984,8 +959,6 @@ static int vmballoon_vmci_init(struct vmballoon *b)
 				b->vmci_doorbell.context,
 				b->vmci_doorbell.resource, NULL);
 
-	STATS_INC(b->stats.doorbell_set);
-
 	if (error != VMW_BALLOON_SUCCESS)
 		goto fail;
 
@@ -1082,6 +1055,7 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 {
 	struct vmballoon *b = f->private;
 	struct vmballoon_stats *stats = &b->stats;
+	int i;
 
 	/* format capabilities info */
 	seq_printf(f,
@@ -1097,17 +1071,19 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 		   "current:            %8d pages\n",
 		   b->target, b->size);
 
+	for (i = 0; i < VMW_BALLOON_CMD_NUM; i++) {
+		if (vmballoon_cmd_names[i] == NULL)
+			continue;
+
+		seq_printf(f, "%-22s: %16lu (%lu failed)\n",
+			   vmballoon_cmd_names[i], stats->ops[i],
+			   stats->ops_fail[i]);
+	}
+
 	seq_printf(f,
 		   "\n"
 		   "timer:              %8u\n"
 		   "doorbell:           %8u\n"
-		   "start:              %8u (%4u failed)\n"
-		   "guestType:          %8u (%4u failed)\n"
-		   "2m-lock:            %8u (%4u failed)\n"
-		   "lock:               %8u (%4u failed)\n"
-		   "2m-unlock:          %8u (%4u failed)\n"
-		   "unlock:             %8u (%4u failed)\n"
-		   "target:             %8u (%4u failed)\n"
 		   "prim2mAlloc:        %8u (%4u failed)\n"
 		   "primNoSleepAlloc:   %8u (%4u failed)\n"
 		   "primCanSleepAlloc:  %8u (%4u failed)\n"
@@ -1116,26 +1092,16 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 		   "err2mAlloc:         %8u\n"
 		   "errAlloc:           %8u\n"
 		   "err2mFree:          %8u\n"
-		   "errFree:            %8u\n"
-		   "doorbellSet:        %8u\n"
-		   "doorbellUnset:      %8u\n",
+		   "errFree:            %8u\n",
 		   stats->timer,
 		   stats->doorbell,
-		   stats->start, stats->start_fail,
-		   stats->guest_type, stats->guest_type_fail,
-		   stats->lock[true],  stats->lock_fail[true],
-		   stats->lock[false],  stats->lock_fail[false],
-		   stats->unlock[true], stats->unlock_fail[true],
-		   stats->unlock[false], stats->unlock_fail[false],
-		   stats->target, stats->target_fail,
 		   stats->alloc[true], stats->alloc_fail[true],
 		   stats->alloc[false], stats->alloc_fail[false],
 		   stats->sleep_alloc, stats->sleep_alloc_fail,
 		   stats->free[true],
 		   stats->free[false],
 		   stats->refused_alloc[true], stats->refused_alloc[false],
-		   stats->refused_free[true], stats->refused_free[false],
-		   stats->doorbell_set, stats->doorbell_unset);
+		   stats->refused_free[true], stats->refused_free[false]);
 
 	return 0;
 }
-- 
2.17.1

