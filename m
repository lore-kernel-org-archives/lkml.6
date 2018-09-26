Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E5FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C9721533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C9721533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeI0BaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:30:23 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:2656 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727613AbeI0B3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:45 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:01 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 2641FB0E8C;
        Wed, 26 Sep 2018 15:15:10 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 19/20] vmw_balloon: memory shrinker
Date:   Wed, 26 Sep 2018 12:13:35 -0700
Message-ID: <20180926191336.101885-20-namit@vmware.com>
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

Adding a shrinker to the VMware balloon to prevent out-of-memory events.
We reuse the deflate logic for this matter. Deadlocks should not happen,
as no memory allocation is performed while the locks of the
communication (batch/page) and page-list are taken. In the unlikely
event in which the configuration semaphore is taken for write we bail
out and fail gracefully (causing processes to be killed).

Once the shrinker is called, inflation is postponed for few seconds.
The timeout is updated without any lock, but this should not cause any
races, as it is written and read atomically.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 124 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 4c9c171325c3..8d60c7e65242 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -41,6 +41,10 @@ MODULE_ALIAS("dmi:*:svnVMware*:*");
 MODULE_ALIAS("vmware_vmmemctl");
 MODULE_LICENSE("GPL");
 
+/* Delay in seconds after shrink before inflation. */
+#define VMBALLOON_SHRINK_DELAY		(5)
+
+/* Maximum number of refused pages we accumulate during inflation cycle */
 #define VMW_BALLOON_MAX_REFUSED		16
 
 /* Magic number for the balloon mount-point */
@@ -218,12 +222,13 @@ enum vmballoon_stat_general {
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
 
@@ -322,6 +327,15 @@ struct vmballoon {
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
 
@@ -362,6 +376,20 @@ struct vmballoon {
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
@@ -904,6 +932,10 @@ static int64_t vmballoon_change(struct vmballoon *b)
 	    size - target < vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE))
 		return 0;
 
+	/* If an out-of-memory recently occurred, inflation is disallowed. */
+	if (target > size && time_before(jiffies, READ_ONCE(b->shrink_timeout)))
+		return 0;
+
 	return target - size;
 }
 
@@ -1398,6 +1430,86 @@ static void vmballoon_work(struct work_struct *work)
 
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
@@ -1415,6 +1527,8 @@ static const char * const vmballoon_stat_names[] = {
 	[VMW_BALLOON_STAT_TIMER]		= "timer",
 	[VMW_BALLOON_STAT_DOORBELL]		= "doorbell",
 	[VMW_BALLOON_STAT_RESET]		= "reset",
+	[VMW_BALLOON_STAT_SHRINK]		= "shrink",
+	[VMW_BALLOON_STAT_SHRINK_FREE]		= "shrinkFree"
 };
 
 static int vmballoon_enable_stats(struct vmballoon *b)
@@ -1759,6 +1873,10 @@ static int __init vmballoon_init(void)
 
 	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
 
+	error = vmballoon_register_shrinker(&balloon);
+	if (error)
+		goto fail;
+
 	error = vmballoon_debugfs_init(&balloon);
 	if (error)
 		goto fail;
@@ -1784,6 +1902,7 @@ static int __init vmballoon_init(void)
 
 	return 0;
 fail:
+	vmballoon_unregister_shrinker(&balloon);
 	vmballoon_compaction_deinit(&balloon);
 	return error;
 }
@@ -1798,6 +1917,7 @@ late_initcall(vmballoon_init);
 
 static void __exit vmballoon_exit(void)
 {
+	vmballoon_unregister_shrinker(&balloon);
 	vmballoon_vmci_cleanup(&balloon);
 	cancel_delayed_work_sync(&balloon.dwork);
 
-- 
2.17.1

