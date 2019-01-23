Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FB3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF68821726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfAWDtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:49:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfAWDt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:49:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8031858E29;
        Wed, 23 Jan 2019 03:49:28 +0000 (UTC)
Received: from llong.com (ovpn-120-224.rdu2.redhat.com [10.10.120.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4A445D6A6;
        Wed, 23 Jan 2019 03:49:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/4] locking/qspinlock_stat: Separate out the PV specific stat counts
Date:   Tue, 22 Jan 2019 22:49:10 -0500
Message-Id: <1548215351-18896-4-git-send-email-longman@redhat.com>
In-Reply-To: <1548215351-18896-1-git-send-email-longman@redhat.com>
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 23 Jan 2019 03:49:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the statistics counts are for PV qspinlocks only and are not
applicable if PARAVIRT_SPINLOCKS aren't configured. So make those counts
dependent on the PARAVIRT_SPINLOCKS config option now.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock_stat.h | 129 +++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 48 deletions(-)

diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 31728f6..7a0a848 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -49,6 +49,7 @@
  * There may be slight difference between pv_kick_wake and pv_kick_unlock.
  */
 enum qlock_stats {
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 	qstat_pv_hash_hops,
 	qstat_pv_kick_unlock,
 	qstat_pv_kick_wake,
@@ -60,6 +61,7 @@ enum qlock_stats {
 	qstat_pv_wait_early,
 	qstat_pv_wait_head,
 	qstat_pv_wait_node,
+#endif
 	qstat_lock_pending,
 	qstat_lock_slowpath,
 	qstat_lock_use_node2,
@@ -80,6 +82,7 @@ enum qlock_stats {
 #include <linux/fs.h>
 
 static const char * const qstat_names[qstat_num + 1] = {
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 	[qstat_pv_hash_hops]	   = "pv_hash_hops",
 	[qstat_pv_kick_unlock]     = "pv_kick_unlock",
 	[qstat_pv_kick_wake]       = "pv_kick_wake",
@@ -91,6 +94,7 @@ enum qlock_stats {
 	[qstat_pv_wait_early]      = "pv_wait_early",
 	[qstat_pv_wait_head]       = "pv_wait_head",
 	[qstat_pv_wait_node]       = "pv_wait_node",
+#endif
 	[qstat_lock_pending]       = "lock_pending",
 	[qstat_lock_slowpath]      = "lock_slowpath",
 	[qstat_lock_use_node2]	   = "lock_use_node2",
@@ -104,6 +108,20 @@ enum qlock_stats {
  * Per-cpu counters
  */
 static DEFINE_PER_CPU(unsigned long, qstats[qstat_num]);
+
+/*
+ * Increment the PV qspinlock statistical counters
+ */
+static inline void qstat_inc(enum qlock_stats stat, bool cond)
+{
+	if (cond)
+		this_cpu_inc(qstats[stat]);
+}
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+/*
+ * PV specific per-cpu counters
+ */
 static DEFINE_PER_CPU(u64, pv_kick_time);
 
 /*
@@ -178,6 +196,69 @@ static ssize_t qstat_read(struct file *file, char __user *user_buf,
 }
 
 /*
+ * PV hash hop count
+ */
+static inline void qstat_hop(int hopcnt)
+{
+	this_cpu_add(qstats[qstat_pv_hash_hops], hopcnt);
+}
+
+/*
+ * Replacement function for pv_kick()
+ */
+static inline void __pv_kick(int cpu)
+{
+	u64 start = sched_clock();
+
+	per_cpu(pv_kick_time, cpu) = start;
+	pv_kick(cpu);
+	this_cpu_add(qstats[qstat_pv_latency_kick], sched_clock() - start);
+}
+
+/*
+ * Replacement function for pv_wait()
+ */
+static inline void __pv_wait(u8 *ptr, u8 val)
+{
+	u64 *pkick_time = this_cpu_ptr(&pv_kick_time);
+
+	*pkick_time = 0;
+	pv_wait(ptr, val);
+	if (*pkick_time) {
+		this_cpu_add(qstats[qstat_pv_latency_wake],
+			     sched_clock() - *pkick_time);
+		qstat_inc(qstat_pv_kick_wake, true);
+	}
+}
+
+#define pv_kick(c)	__pv_kick(c)
+#define pv_wait(p, v)	__pv_wait(p, v)
+
+#else /* CONFIG_PARAVIRT_SPINLOCKS */
+static ssize_t qstat_read(struct file *file, char __user *user_buf,
+			  size_t count, loff_t *ppos)
+{
+	char buf[64];
+	int cpu, counter, len;
+	u64 stat = 0;
+
+	/*
+	 * Get the counter ID stored in file->f_inode->i_private
+	 */
+	counter = (long)file_inode(file)->i_private;
+
+	if (counter >= qstat_num)
+		return -EBADF;
+
+	for_each_possible_cpu(cpu)
+		stat += per_cpu(qstats[counter], cpu);
+	len = snprintf(buf, sizeof(buf) - 1, "%llu\n", stat);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
+
+/*
  * Function to handle write request
  *
  * When counter = reset_cnts, reset all the counter values.
@@ -250,54 +331,6 @@ static int __init init_qspinlock_stat(void)
 }
 fs_initcall(init_qspinlock_stat);
 
-/*
- * Increment the PV qspinlock statistical counters
- */
-static inline void qstat_inc(enum qlock_stats stat, bool cond)
-{
-	if (cond)
-		this_cpu_inc(qstats[stat]);
-}
-
-/*
- * PV hash hop count
- */
-static inline void qstat_hop(int hopcnt)
-{
-	this_cpu_add(qstats[qstat_pv_hash_hops], hopcnt);
-}
-
-/*
- * Replacement function for pv_kick()
- */
-static inline void __pv_kick(int cpu)
-{
-	u64 start = sched_clock();
-
-	per_cpu(pv_kick_time, cpu) = start;
-	pv_kick(cpu);
-	this_cpu_add(qstats[qstat_pv_latency_kick], sched_clock() - start);
-}
-
-/*
- * Replacement function for pv_wait()
- */
-static inline void __pv_wait(u8 *ptr, u8 val)
-{
-	u64 *pkick_time = this_cpu_ptr(&pv_kick_time);
-
-	*pkick_time = 0;
-	pv_wait(ptr, val);
-	if (*pkick_time) {
-		this_cpu_add(qstats[qstat_pv_latency_wake],
-			     sched_clock() - *pkick_time);
-		qstat_inc(qstat_pv_kick_wake, true);
-	}
-}
-
-#define pv_kick(c)	__pv_kick(c)
-#define pv_wait(p, v)	__pv_wait(p, v)
-
 #else /* CONFIG_QUEUED_LOCK_STAT */
 
 static inline void qstat_inc(enum qlock_stats stat, bool cond)	{ }
-- 
1.8.3.1

