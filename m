Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB47C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B272064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B272064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeI0B3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:29:43 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25069 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbeI0B3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:41 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:05 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id B6E4AB0E85;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 11/20] vmw_balloon: stats rework
Date:   Wed, 26 Sep 2018 12:13:27 -0700
Message-ID: <20180926191336.101885-12-namit@vmware.com>
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

To allow the balloon statistics to be updated concurrently, we change
the statistics to be held per core and aggregate it when needed.

To avoid the memory overhead of keeping the statistics per core, and
since it is likely not used by most users, we start updating the
statistics only after the first use. A read-write semaphore is used to
protect the statistics initialization and avoid races. This semaphore is
(and will) be used to protect configuration changes during reset.

While we are at it, address some other issues: change the statistics
update to inline functions instead of define; use ulong for saving the
statistics; and clean the statistics printouts.

Note that this patch changes the format of the outputs. If there are any
automatic tools that use the statistics, they might fail.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 384 +++++++++++++++++++++++++++----------
 1 file changed, 281 insertions(+), 103 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 3c80a21e0f91..0a2bdaf5773b 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -25,6 +25,8 @@
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
 #include <linux/vmw_vmci_defs.h>
 #include <linux/vmw_vmci_api.h>
 #include <asm/hypervisor.h>
@@ -78,46 +80,94 @@ enum vmwballoon_capabilities {
 					| VMW_BALLOON_SIGNALLED_WAKEUP_CMD)
 
 #define VMW_BALLOON_2M_ORDER		(PMD_SHIFT - PAGE_SHIFT)
-#define VMW_BALLOON_NUM_PAGE_SIZES	(2)
 
-/*
- * Backdoor commands availability:
+enum vmballoon_page_size_type {
+	VMW_BALLOON_4K_PAGE,
+	VMW_BALLOON_2M_PAGE,
+	VMW_BALLOON_LAST_SIZE = VMW_BALLOON_2M_PAGE
+};
+
+#define VMW_BALLOON_NUM_PAGE_SIZES	(VMW_BALLOON_LAST_SIZE + 1)
+
+enum vmballoon_op_stat_type {
+	VMW_BALLOON_OP_STAT,
+	VMW_BALLOON_OP_FAIL_STAT
+};
+
+#define VMW_BALLOON_OP_STAT_TYPES	(VMW_BALLOON_OP_FAIL_STAT + 1)
+
+/**
+ * enum vmballoon_cmd_type - backdoor commands.
+ *
+ * Availability of the commands is as followed:
+ *
+ * %VMW_BALLOON_CMD_START, %VMW_BALLOON_CMD_GET_TARGET and
+ * %VMW_BALLOON_CMD_GUEST_ID are always available.
+ *
+ * If the host reports %VMW_BALLOON_BASIC_CMDS are supported then
+ * %VMW_BALLOON_CMD_LOCK and %VMW_BALLOON_CMD_UNLOCK commands are available.
  *
- * START, GET_TARGET and GUEST_ID are always available,
+ * If the host reports %VMW_BALLOON_BATCHED_CMDS are supported then
+ * %VMW_BALLOON_CMD_BATCHED_LOCK and VMW_BALLOON_CMD_BATCHED_UNLOCK commands
+ * are available.
  *
- * VMW_BALLOON_BASIC_CMDS:
- *	LOCK and UNLOCK commands,
- * VMW_BALLOON_BATCHED_CMDS:
- *	BATCHED_LOCK and BATCHED_UNLOCK commands.
- * VMW BALLOON_BATCHED_2M_CMDS:
- *	BATCHED_2M_LOCK and BATCHED_2M_UNLOCK commands,
- * VMW VMW_BALLOON_SIGNALLED_WAKEUP_CMD:
- *	VMW_BALLOON_CMD_VMCI_DOORBELL_SET command.
+ * If the host reports %VMW_BALLOON_BATCHED_2M_CMDS are supported then
+ * %VMW_BALLOON_CMD_BATCHED_2M_LOCK and %VMW_BALLOON_CMD_BATCHED_2M_UNLOCK
+ * are supported.
+ *
+ * If the host reports  VMW_BALLOON_SIGNALLED_WAKEUP_CMD is supported then
+ * VMW_BALLOON_CMD_VMCI_DOORBELL_SET command is supported.
+ *
+ * @VMW_BALLOON_CMD_START: Communicating supported version with the hypervisor.
+ * @VMW_BALLOON_CMD_GET_TARGET: Gets the balloon target size.
+ * @VMW_BALLOON_CMD_LOCK: Informs the hypervisor about a ballooned page.
+ * @VMW_BALLOON_CMD_UNLOCK: Informs the hypervisor about a page that is about
+ *			    to be deflated from the balloon.
+ * @VMW_BALLOON_CMD_GUEST_ID: Informs the hypervisor about the type of OS that
+ *			      runs in the VM.
+ * @VMW_BALLOON_CMD_BATCHED_LOCK: Inform the hypervisor about a batch of
+ *				  ballooned pages (up to 512).
+ * @VMW_BALLOON_CMD_BATCHED_UNLOCK: Inform the hypervisor about a batch of
+ *				  pages that are about to be deflated from the
+ *				  balloon (up to 512).
+ * @VMW_BALLOON_CMD_BATCHED_2M_LOCK: Similar to @VMW_BALLOON_CMD_BATCHED_LOCK
+ *				     for 2MB pages.
+ * @VMW_BALLOON_CMD_BATCHED_2M_UNLOCK: Similar to
+ *				       @VMW_BALLOON_CMD_BATCHED_UNLOCK for 2MB
+ *				       pages.
+ * @VMW_BALLOON_CMD_VMCI_DOORBELL_SET: A command to set doorbell notification
+ *				       that would be invoked when the balloon
+ *				       size changes.
+ * @VMW_BALLOON_CMD_LAST: Value of the last command.
  */
-#define VMW_BALLOON_CMD_START			0
-#define VMW_BALLOON_CMD_GET_TARGET		1
-#define VMW_BALLOON_CMD_LOCK			2
-#define VMW_BALLOON_CMD_UNLOCK			3
-#define VMW_BALLOON_CMD_GUEST_ID		4
-#define VMW_BALLOON_CMD_BATCHED_LOCK		6
-#define VMW_BALLOON_CMD_BATCHED_UNLOCK		7
-#define VMW_BALLOON_CMD_BATCHED_2M_LOCK		8
-#define VMW_BALLOON_CMD_BATCHED_2M_UNLOCK	9
-#define VMW_BALLOON_CMD_VMCI_DOORBELL_SET	10
-
-#define VMW_BALLOON_CMD_NUM			11
-
-/* error codes */
-#define VMW_BALLOON_SUCCESS		        0
-#define VMW_BALLOON_FAILURE		        -1
-#define VMW_BALLOON_ERROR_CMD_INVALID	        1
-#define VMW_BALLOON_ERROR_PPN_INVALID	        2
-#define VMW_BALLOON_ERROR_PPN_LOCKED	        3
-#define VMW_BALLOON_ERROR_PPN_UNLOCKED	        4
-#define VMW_BALLOON_ERROR_PPN_PINNED	        5
-#define VMW_BALLOON_ERROR_PPN_NOTNEEDED	        6
-#define VMW_BALLOON_ERROR_RESET		        7
-#define VMW_BALLOON_ERROR_BUSY		        8
+enum vmballoon_cmd_type {
+	VMW_BALLOON_CMD_START,
+	VMW_BALLOON_CMD_GET_TARGET,
+	VMW_BALLOON_CMD_LOCK,
+	VMW_BALLOON_CMD_UNLOCK,
+	VMW_BALLOON_CMD_GUEST_ID,
+	/* No command 5 */
+	VMW_BALLOON_CMD_BATCHED_LOCK = 6,
+	VMW_BALLOON_CMD_BATCHED_UNLOCK,
+	VMW_BALLOON_CMD_BATCHED_2M_LOCK,
+	VMW_BALLOON_CMD_BATCHED_2M_UNLOCK,
+	VMW_BALLOON_CMD_VMCI_DOORBELL_SET,
+	VMW_BALLOON_CMD_LAST = VMW_BALLOON_CMD_VMCI_DOORBELL_SET,
+};
+
+#define VMW_BALLOON_CMD_NUM	(VMW_BALLOON_CMD_LAST + 1)
+
+enum vmballoon_error_codes {
+	VMW_BALLOON_SUCCESS,
+	VMW_BALLOON_ERROR_CMD_INVALID,
+	VMW_BALLOON_ERROR_PPN_INVALID,
+	VMW_BALLOON_ERROR_PPN_LOCKED,
+	VMW_BALLOON_ERROR_PPN_UNLOCKED,
+	VMW_BALLOON_ERROR_PPN_PINNED,
+	VMW_BALLOON_ERROR_PPN_NOTNEEDED,
+	VMW_BALLOON_ERROR_RESET,
+	VMW_BALLOON_ERROR_BUSY
+};
 
 #define VMW_BALLOON_SUCCESS_WITH_CAPABILITIES	(0x03000000)
 
@@ -143,29 +193,28 @@ static const char * const vmballoon_cmd_names[] = {
 	[VMW_BALLOON_CMD_VMCI_DOORBELL_SET]	= "doorbellSet"
 };
 
-#ifdef CONFIG_DEBUG_FS
-struct vmballoon_stats {
-	unsigned int timer;
-	unsigned int doorbell;
-
-	/* allocation statistics */
-	unsigned int alloc[VMW_BALLOON_NUM_PAGE_SIZES];
-	unsigned int alloc_fail[VMW_BALLOON_NUM_PAGE_SIZES];
-	unsigned int refused_alloc[VMW_BALLOON_NUM_PAGE_SIZES];
-	unsigned int refused_free[VMW_BALLOON_NUM_PAGE_SIZES];
-	unsigned int free[VMW_BALLOON_NUM_PAGE_SIZES];
-
-	/* Monitor operations.  */
-	unsigned long ops[VMW_BALLOON_CMD_NUM];
-	unsigned long ops_fail[VMW_BALLOON_CMD_NUM];
+enum vmballoon_stat_page {
+	VMW_BALLOON_PAGE_STAT_ALLOC,
+	VMW_BALLOON_PAGE_STAT_ALLOC_FAIL,
+	VMW_BALLOON_PAGE_STAT_REFUSED_ALLOC,
+	VMW_BALLOON_PAGE_STAT_REFUSED_FREE,
+	VMW_BALLOON_PAGE_STAT_FREE,
+	VMW_BALLOON_PAGE_STAT_LAST = VMW_BALLOON_PAGE_STAT_FREE
 };
 
-#define STATS_INC(stat) (stat)++
-#else
-#define STATS_INC(stat)
-#endif
+#define VMW_BALLOON_PAGE_STAT_NUM	(VMW_BALLOON_PAGE_STAT_LAST + 1)
+
+enum vmballoon_stat_general {
+	VMW_BALLOON_STAT_TIMER,
+	VMW_BALLOON_STAT_DOORBELL,
+	VMW_BALLOON_STAT_LAST = VMW_BALLOON_STAT_DOORBELL
+};
+
+#define VMW_BALLOON_STAT_NUM		(VMW_BALLOON_STAT_LAST + 1)
+
 
 static DEFINE_STATIC_KEY_TRUE(vmw_balloon_batching);
+static DEFINE_STATIC_KEY_FALSE(balloon_stat_enabled);
 
 struct vmballoon_page_size {
 	/* list of reserved physical pages */
@@ -215,10 +264,10 @@ struct vmballoon {
 	unsigned int batch_max_pages;
 	struct page *page;
 
-#ifdef CONFIG_DEBUG_FS
 	/* statistics */
-	struct vmballoon_stats stats;
+	struct vmballoon_stats *stats;
 
+#ifdef CONFIG_DEBUG_FS
 	/* debugfs file exporting statistics */
 	struct dentry *dbg_entry;
 #endif
@@ -226,17 +275,70 @@ struct vmballoon {
 	struct delayed_work dwork;
 
 	struct vmci_handle vmci_doorbell;
+
+	/**
+	 * @conf_sem: semaphore to protect the configuration and the statistics.
+	 */
+	struct rw_semaphore conf_sem;
 };
 
 static struct vmballoon balloon;
 
+struct vmballoon_stats {
+	/* timer / doorbell operations */
+	atomic64_t general_stat[VMW_BALLOON_STAT_NUM];
+
+	/* allocation statistics for huge and small pages */
+	atomic64_t
+	       page_stat[VMW_BALLOON_PAGE_STAT_NUM][VMW_BALLOON_NUM_PAGE_SIZES];
+
+	/* Monitor operations: total operations, and failures */
+	atomic64_t ops[VMW_BALLOON_CMD_NUM][VMW_BALLOON_OP_STAT_TYPES];
+};
+
+static inline bool is_vmballoon_stats_on(void)
+{
+	return IS_ENABLED(CONFIG_DEBUG_FS) &&
+		static_branch_unlikely(&balloon_stat_enabled);
+}
+
+static inline void vmballoon_stats_op_inc(struct vmballoon *b, unsigned int op,
+					  enum vmballoon_op_stat_type type)
+{
+	if (is_vmballoon_stats_on())
+		atomic64_inc(&b->stats->ops[op][type]);
+}
+
+static inline void vmballoon_stats_gen_inc(struct vmballoon *b,
+					   enum vmballoon_stat_general stat)
+{
+	if (is_vmballoon_stats_on())
+		atomic64_inc(&b->stats->general_stat[stat]);
+}
+
+static inline void vmballoon_stats_gen_add(struct vmballoon *b,
+					   enum vmballoon_stat_general stat,
+					   unsigned int val)
+{
+	if (is_vmballoon_stats_on())
+		atomic64_add(val, &b->stats->general_stat[stat]);
+}
+
+static inline void vmballoon_stats_page_inc(struct vmballoon *b,
+					    enum vmballoon_stat_page stat,
+					    bool is_2m_page)
+{
+	if (is_vmballoon_stats_on())
+		atomic64_inc(&b->stats->page_stat[stat][is_2m_page]);
+}
+
 static inline unsigned long
 __vmballoon_cmd(struct vmballoon *b, unsigned long cmd, unsigned long arg1,
 		unsigned long arg2, unsigned long *result)
 {
 	unsigned long status, dummy1, dummy2, dummy3, local_result;
 
-	STATS_INC(b->stats.ops[cmd]);
+	vmballoon_stats_op_inc(b, cmd, VMW_BALLOON_OP_STAT);
 
 	asm volatile ("inl %%dx" :
 		"=a"(status),
@@ -263,7 +365,7 @@ __vmballoon_cmd(struct vmballoon *b, unsigned long cmd, unsigned long arg1,
 
 	if (status != VMW_BALLOON_SUCCESS &&
 	    status != VMW_BALLOON_SUCCESS_WITH_CAPABILITIES) {
-		STATS_INC(b->stats.ops_fail[cmd]);
+		vmballoon_stats_op_inc(b, cmd, VMW_BALLOON_OP_FAIL_STAT);
 		pr_debug("%s: %s [0x%lx,0x%lx) failed, returned %ld\n",
 			 __func__, vmballoon_cmd_names[cmd], arg1, arg2,
 			 status);
@@ -413,7 +515,8 @@ static void vmballoon_pop(struct vmballoon *b)
 		list_for_each_entry_safe(page, next, &page_size->pages, lru) {
 			list_del(&page->lru);
 			vmballoon_free_page(page, is_2m_pages);
-			STATS_INC(b->stats.free[is_2m_pages]);
+			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_FREE,
+						 is_2m_pages);
 			b->size -= size_per_page;
 			cond_resched();
 		}
@@ -534,7 +637,8 @@ static int vmballoon_lock(struct vmballoon *b, unsigned int num_pages,
 		}
 
 		/* Error occurred */
-		STATS_INC(b->stats.refused_alloc[is_2m_pages]);
+		vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_REFUSED_ALLOC,
+					 is_2m_pages);
 
 		/*
 		 * Place page on the list of non-balloonable pages
@@ -587,7 +691,8 @@ static int vmballoon_unlock(struct vmballoon *b, unsigned int num_pages,
 		} else {
 			/* deallocate page */
 			vmballoon_free_page(p, is_2m_pages);
-			STATS_INC(b->stats.free[is_2m_pages]);
+			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_FREE,
+						 is_2m_pages);
 
 			/* update balloon size */
 			b->size -= size_per_page;
@@ -611,7 +716,8 @@ static void vmballoon_release_refused_pages(struct vmballoon *b,
 	list_for_each_entry_safe(page, next, &page_size->refused_pages, lru) {
 		list_del(&page->lru);
 		vmballoon_free_page(page, is_2m_pages);
-		STATS_INC(b->stats.refused_free[is_2m_pages]);
+		vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_REFUSED_FREE,
+					 is_2m_pages);
 	}
 
 	page_size->n_refused_pages = 0;
@@ -693,10 +799,14 @@ static void vmballoon_inflate(struct vmballoon *b)
 	       vmballoon_change(b)) {
 		struct page *page;
 
-		STATS_INC(b->stats.alloc[is_2m_pages]);
+		vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
+					 is_2m_pages);
+
 		page = vmballoon_alloc_page(is_2m_pages);
 		if (!page) {
-			STATS_INC(b->stats.alloc_fail[is_2m_pages]);
+			vmballoon_stats_page_inc(b,
+				VMW_BALLOON_PAGE_STAT_ALLOC_FAIL, is_2m_pages);
+
 			if (is_2m_pages) {
 				vmballoon_lock(b, num_pages, true);
 
@@ -845,7 +955,7 @@ static void vmballoon_doorbell(void *client_data)
 {
 	struct vmballoon *b = client_data;
 
-	STATS_INC(b->stats.doorbell);
+	vmballoon_stats_gen_inc(b, VMW_BALLOON_STAT_DOORBELL);
 
 	mod_delayed_work(system_freezable_wq, &b->dwork, 0);
 }
@@ -903,6 +1013,8 @@ static void vmballoon_reset(struct vmballoon *b)
 {
 	int error;
 
+	down_write(&b->conf_sem);
+
 	vmballoon_vmci_cleanup(b);
 
 	/* free all pages, skipping monitor unlock */
@@ -934,6 +1046,8 @@ static void vmballoon_reset(struct vmballoon *b)
 
 	if (!vmballoon_send_guest_id(b))
 		pr_err("failed to send guest ID to the host\n");
+
+	up_write(&b->conf_sem);
 }
 
 /**
@@ -950,11 +1064,18 @@ static void vmballoon_work(struct work_struct *work)
 	struct vmballoon *b = container_of(dwork, struct vmballoon, dwork);
 	int64_t change = 0;
 
-	STATS_INC(b->stats.timer);
-
 	if (b->reset_required)
 		vmballoon_reset(b);
 
+	down_read(&b->conf_sem);
+
+	/*
+	 * Update the stats while holding the semaphore to ensure that
+	 * @stats_enabled is consistent with whether the stats are actually
+	 * enabled
+	 */
+	vmballoon_stats_gen_inc(b, VMW_BALLOON_STAT_TIMER);
+
 	if (!vmballoon_send_get_target(b))
 		change = vmballoon_change(b);
 
@@ -968,12 +1089,15 @@ static void vmballoon_work(struct work_struct *work)
 			vmballoon_deflate(b);
 	}
 
+	up_read(&b->conf_sem);
+
 	/*
 	 * We are using a freezable workqueue so that balloon operations are
 	 * stopped while the system transitions to/from sleep/hibernation.
 	 */
 	queue_delayed_work(system_freezable_wq,
 			   dwork, round_jiffies_relative(HZ));
+
 }
 
 /*
@@ -981,55 +1105,105 @@ static void vmballoon_work(struct work_struct *work)
  */
 #ifdef CONFIG_DEBUG_FS
 
+static const char * const vmballoon_stat_page_names[] = {
+	[VMW_BALLOON_PAGE_STAT_ALLOC]		= "alloc",
+	[VMW_BALLOON_PAGE_STAT_ALLOC_FAIL]	= "allocFail",
+	[VMW_BALLOON_PAGE_STAT_REFUSED_ALLOC]	= "errAlloc",
+	[VMW_BALLOON_PAGE_STAT_REFUSED_FREE]	= "errFree",
+	[VMW_BALLOON_PAGE_STAT_FREE]		= "free"
+};
+
+static const char * const vmballoon_stat_names[] = {
+	[VMW_BALLOON_STAT_TIMER]		= "timer",
+	[VMW_BALLOON_STAT_DOORBELL]		= "doorbell"
+};
+
+static const char * const vmballoon_page_size_names[] = {
+	[VMW_BALLOON_4K_PAGE]			= "4k",
+	[VMW_BALLOON_2M_PAGE]			= "2M"
+};
+
+static int vmballoon_enable_stats(struct vmballoon *b)
+{
+	int r = 0;
+
+	down_write(&b->conf_sem);
+
+	/* did we somehow race with another reader which enabled stats? */
+	if (b->stats)
+		goto out;
+
+	b->stats = kzalloc(sizeof(*b->stats), GFP_KERNEL);
+
+	if (!b->stats) {
+		/* allocation failed */
+		r = -ENOMEM;
+		goto out;
+	}
+	static_key_enable(&balloon_stat_enabled.key);
+out:
+	up_write(&b->conf_sem);
+	return r;
+}
+
+/**
+ * vmballoon_debug_show - shows statistics of balloon operations.
+ * @f: pointer to the &struct seq_file.
+ * @offset: ignored.
+ *
+ * Provides the statistics that can be accessed in vmmemctl in the debugfs.
+ * To avoid the overhead - mainly that of memory - of collecting the statistics,
+ * we only collect statistics after the first time the counters are read.
+ *
+ * Return: zero on success or an error code.
+ */
 static int vmballoon_debug_show(struct seq_file *f, void *offset)
 {
 	struct vmballoon *b = f->private;
-	struct vmballoon_stats *stats = &b->stats;
-	int i;
+	int i, j;
+
+	/* enables stats if they are disabled */
+	if (!b->stats) {
+		int r = vmballoon_enable_stats(b);
+
+		if (r)
+			return r;
+	}
 
 	/* format capabilities info */
-	seq_printf(f,
-		   "balloon capabilities:   %#4x\n"
-		   "used capabilities:      %#4lx\n"
-		   "is resetting:           %c\n",
-		   VMW_BALLOON_CAPABILITIES, b->capabilities,
-		   b->reset_required ? 'y' : 'n');
+	seq_printf(f, "%-22s: %#4x\n", "balloon capabilities",
+		   VMW_BALLOON_CAPABILITIES);
+	seq_printf(f, "%-22s: %#4lx\n", "used capabilities",
+		   b->capabilities);
+	seq_printf(f, "%-22s: %16s\n", "is resetting",
+		   b->reset_required ? "y" : "n");
 
 	/* format size info */
-	seq_printf(f,
-		   "target:             %8d pages\n"
-		   "current:            %8d pages\n",
-		   b->target, b->size);
+	seq_printf(f, "%-22s: %16u\n", "target", b->target);
+	seq_printf(f, "%-22s: %16u\n", "current", b->size);
 
 	for (i = 0; i < VMW_BALLOON_CMD_NUM; i++) {
 		if (vmballoon_cmd_names[i] == NULL)
 			continue;
 
-		seq_printf(f, "%-22s: %16lu (%lu failed)\n",
-			   vmballoon_cmd_names[i], stats->ops[i],
-			   stats->ops_fail[i]);
+		seq_printf(f, "%-22s: %16llu (%llu failed)\n",
+			   vmballoon_cmd_names[i],
+			   atomic64_read(&b->stats->ops[i][VMW_BALLOON_OP_STAT]),
+			   atomic64_read(&b->stats->ops[i][VMW_BALLOON_OP_FAIL_STAT]));
 	}
 
-	seq_printf(f,
-		   "\n"
-		   "timer:              %8u\n"
-		   "doorbell:           %8u\n"
-		   "prim2mAlloc:        %8u (%4u failed)\n"
-		   "prim4kAlloc:        %8u (%4u failed)\n"
-		   "prim2mFree:         %8u\n"
-		   "primFree:           %8u\n"
-		   "err2mAlloc:         %8u\n"
-		   "errAlloc:           %8u\n"
-		   "err2mFree:          %8u\n"
-		   "errFree:            %8u\n",
-		   stats->timer,
-		   stats->doorbell,
-		   stats->alloc[true], stats->alloc_fail[true],
-		   stats->alloc[false], stats->alloc_fail[false],
-		   stats->free[true],
-		   stats->free[false],
-		   stats->refused_alloc[true], stats->refused_alloc[false],
-		   stats->refused_free[true], stats->refused_free[false]);
+	for (i = 0; i < VMW_BALLOON_STAT_NUM; i++)
+		seq_printf(f, "%-22s: %16llu\n",
+			   vmballoon_stat_names[i],
+			   atomic64_read(&b->stats->general_stat[i]));
+
+	for (i = 0; i < VMW_BALLOON_PAGE_STAT_NUM; i++) {
+		for (j = 0; j < VMW_BALLOON_NUM_PAGE_SIZES; j++)
+			seq_printf(f, "%-18s(%s): %16llu\n",
+				   vmballoon_stat_page_names[i],
+				   vmballoon_page_size_names[j],
+				   atomic64_read(&b->stats->page_stat[i][j]));
+	}
 
 	return 0;
 }
@@ -1064,7 +1238,10 @@ static int __init vmballoon_debugfs_init(struct vmballoon *b)
 
 static void __exit vmballoon_debugfs_exit(struct vmballoon *b)
 {
+	static_key_disable(&balloon_stat_enabled.key);
 	debugfs_remove(b->dbg_entry);
+	kfree(b->stats);
+	b->stats = NULL;
 }
 
 #else
@@ -1103,6 +1280,7 @@ static int __init vmballoon_init(void)
 	if (error)
 		return error;
 
+	init_rwsem(&balloon.conf_sem);
 	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
 	balloon.batch_page = NULL;
 	balloon.page = NULL;
-- 
2.17.1

