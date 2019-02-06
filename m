Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE2EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ECE2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfBFX5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:57:30 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:44318 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbfBFX50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:57:26 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 6 Feb 2019 15:56:37 -0800
Received: from ubuntu.localdomain (unknown [10.33.115.182])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id E550A40FB0;
        Wed,  6 Feb 2019 15:57:11 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        Julien Freche <jfreche@vmware.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 5/6] vmw_balloon: add memory shrinker
Date:   Wed, 6 Feb 2019 15:57:05 -0800
Message-ID: <20190206235706.4851-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206235706.4851-1-namit@vmware.com>
References: <20190206235706.4851-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a shrinker to the VMware balloon to prevent out-of-memory events.
We reuse the deflate logic for this matter. Deadlocks should not happen,
as no memory allocation is performed while the locks of the
communication (batch/page) and page-list are taken. In the unlikely
event in which the configuration semaphore is taken for write we bail
out and fail gracefully (causing processes to be killed).

Once the shrinker is called, inflation is postponed for few seconds.
The timeout is updated without any lock, but this should not cause any
races, as it is written and read atomically.

This feature is disabled by default, since it might cause performance
degradation.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 135 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 3ea2af9c9208..793f7ee6d9df 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -40,6 +40,17 @@ MODULE_ALIAS("dmi:*:svnVMware*:*");
 MODULE_ALIAS("vmware_vmmemctl");
 MODULE_LICENSE("GPL");
 
+bool __read_mostly vmwballoon_shrinker_enable;
+module_param(vmwballoon_shrinker_enable, bool, 0444);
+MODULE_PARM_DESC(vmwballoon_shrinker_enable,
+		 "Enable non-cooperative out-of-memory protection. This feature "
+		 "is disabled by default as it might negatively impact "
+		 "performance.");
+
+/* Delay in seconds after shrink before inflation. */
+#define VMBALLOON_SHRINK_DELAY		(5)
+
+/* Maximum number of refused pages we accumulate during inflation cycle */
 #define VMW_BALLOON_MAX_REFUSED		16
 
 /* Magic number for the balloon mount-point */
@@ -217,12 +228,13 @@ enum vmballoon_stat_general {
 	VMW_BALLOON_STAT_TIMER,
 	VMW_BALLOON_STAT_DOORBELL,
 	VMW_BALLOON_STAT_RESET,
-	VMW_BALLOON_STAT_LAST = VMW_BALLOON_STAT_RESET
+	VMW_BALLOON_STAT_SHRINK,
+	VMW_BALLOON_STAT_SHRINK_FREE,
+	VMW_BALLOON_STAT_LAST = VMW_BALLOON_STAT_SHRINK_FREE
 };
 
 #define VMW_BALLOON_STAT_NUM		(VMW_BALLOON_STAT_LAST + 1)
 
-
 static DEFINE_STATIC_KEY_TRUE(vmw_balloon_batching);
 static DEFINE_STATIC_KEY_FALSE(balloon_stat_enabled);
 
@@ -321,6 +333,15 @@ struct vmballoon {
 	 */
 	struct page *page;
 
+	/**
+	 * @shrink_timeout: timeout until the next inflation.
+	 *
+	 * After an shrink event, indicates the time in jiffies after which
+	 * inflation is allowed again. Can be written concurrently with reads,
+	 * so must use READ_ONCE/WRITE_ONCE when accessing.
+	 */
+	unsigned long shrink_timeout;
+
 	/* statistics */
 	struct vmballoon_stats *stats;
 
@@ -361,6 +382,20 @@ struct vmballoon {
 	 * Lock ordering: @conf_sem -> @comm_lock .
 	 */
 	spinlock_t comm_lock;
+
+	/**
+	 * @shrinker: shrinker interface that is used to avoid over-inflation.
+	 */
+	struct shrinker shrinker;
+
+	/**
+	 * @shrinker_registered: whether the shrinker was registered.
+	 *
+	 * The shrinker interface does not handle gracefully the removal of
+	 * shrinker that was not registered before. This indication allows to
+	 * simplify the unregistration process.
+	 */
+	bool shrinker_registered;
 };
 
 static struct vmballoon balloon;
@@ -903,6 +938,10 @@ static int64_t vmballoon_change(struct vmballoon *b)
 	    size - target < vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE))
 		return 0;
 
+	/* If an out-of-memory recently occurred, inflation is disallowed. */
+	if (target > size && time_before(jiffies, READ_ONCE(b->shrink_timeout)))
+		return 0;
+
 	return target - size;
 }
 
@@ -1397,6 +1436,90 @@ static void vmballoon_work(struct work_struct *work)
 
 }
 
+/**
+ * vmballoon_shrinker_scan() - deflate the balloon due to memory pressure.
+ * @shrinker: pointer to the balloon shrinker.
+ * @sc: page reclaim information.
+ *
+ * Returns: number of pages that were freed during deflation.
+ */
+static unsigned long vmballoon_shrinker_scan(struct shrinker *shrinker,
+					     struct shrink_control *sc)
+{
+	struct vmballoon *b = &balloon;
+	unsigned long deflated_frames;
+
+	pr_debug("%s - size: %llu", __func__, atomic64_read(&b->size));
+
+	vmballoon_stats_gen_inc(b, VMW_BALLOON_STAT_SHRINK);
+
+	/*
+	 * If the lock is also contended for read, we cannot easily reclaim and
+	 * we bail out.
+	 */
+	if (!down_read_trylock(&b->conf_sem))
+		return 0;
+
+	deflated_frames = vmballoon_deflate(b, sc->nr_to_scan, true);
+
+	vmballoon_stats_gen_add(b, VMW_BALLOON_STAT_SHRINK_FREE,
+				deflated_frames);
+
+	/*
+	 * Delay future inflation for some time to mitigate the situations in
+	 * which balloon continuously grows and shrinks. Use WRITE_ONCE() since
+	 * the access is asynchronous.
+	 */
+	WRITE_ONCE(b->shrink_timeout, jiffies + HZ * VMBALLOON_SHRINK_DELAY);
+
+	up_read(&b->conf_sem);
+
+	return deflated_frames;
+}
+
+/**
+ * vmballoon_shrinker_count() - return the number of ballooned pages.
+ * @shrinker: pointer to the balloon shrinker.
+ * @sc: page reclaim information.
+ *
+ * Returns: number of 4k pages that are allocated for the balloon and can
+ *	    therefore be reclaimed under pressure.
+ */
+static unsigned long vmballoon_shrinker_count(struct shrinker *shrinker,
+					      struct shrink_control *sc)
+{
+	struct vmballoon *b = &balloon;
+
+	return atomic64_read(&b->size);
+}
+
+static void vmballoon_unregister_shrinker(struct vmballoon *b)
+{
+	if (b->shrinker_registered)
+		unregister_shrinker(&b->shrinker);
+	b->shrinker_registered = false;
+}
+
+static int vmballoon_register_shrinker(struct vmballoon *b)
+{
+	int r;
+
+	/* Do nothing if the shrinker is not enabled */
+	if (!vmwballoon_shrinker_enable)
+		return 0;
+
+	b->shrinker.scan_objects = vmballoon_shrinker_scan;
+	b->shrinker.count_objects = vmballoon_shrinker_count;
+	b->shrinker.seeks = DEFAULT_SEEKS;
+
+	r = register_shrinker(&b->shrinker);
+
+	if (r == 0)
+		b->shrinker_registered = true;
+
+	return r;
+}
+
 /*
  * DEBUGFS Interface
  */
@@ -1414,6 +1537,8 @@ static const char * const vmballoon_stat_names[] = {
 	[VMW_BALLOON_STAT_TIMER]		= "timer",
 	[VMW_BALLOON_STAT_DOORBELL]		= "doorbell",
 	[VMW_BALLOON_STAT_RESET]		= "reset",
+	[VMW_BALLOON_STAT_SHRINK]		= "shrink",
+	[VMW_BALLOON_STAT_SHRINK_FREE]		= "shrinkFree"
 };
 
 static int vmballoon_enable_stats(struct vmballoon *b)
@@ -1747,6 +1872,10 @@ static int __init vmballoon_init(void)
 
 	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
 
+	error = vmballoon_register_shrinker(&balloon);
+	if (error)
+		goto fail;
+
 	error = vmballoon_debugfs_init(&balloon);
 	if (error)
 		goto fail;
@@ -1772,6 +1901,7 @@ static int __init vmballoon_init(void)
 
 	return 0;
 fail:
+	vmballoon_unregister_shrinker(&balloon);
 	vmballoon_compaction_deinit(&balloon);
 	return error;
 }
@@ -1786,6 +1916,7 @@ late_initcall(vmballoon_init);
 
 static void __exit vmballoon_exit(void)
 {
+	vmballoon_unregister_shrinker(&balloon);
 	vmballoon_vmci_cleanup(&balloon);
 	cancel_delayed_work_sync(&balloon.dwork);
 
-- 
2.17.1

