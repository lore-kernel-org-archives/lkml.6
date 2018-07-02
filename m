Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69340C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EB325636
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EB325636
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeGBFw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:52:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753383AbeGBFwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:52:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA84F308FB8B;
        Mon,  2 Jul 2018 05:52:51 +0000 (UTC)
Received: from llong.com (ovpn-116-112.phx2.redhat.com [10.3.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A26C10D51FD;
        Mon,  2 Jul 2018 05:52:45 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 2/6] fs/dcache: Make negative dentry tracking configurable
Date:   Mon,  2 Jul 2018 13:51:59 +0800
Message-Id: <1530510723-24814-3-git-send-email-longman@redhat.com>
In-Reply-To: <1530510723-24814-1-git-send-email-longman@redhat.com>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 02 Jul 2018 05:52:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The negative dentry tracking is made a configurable option so that
users who don't care about negative dentry tracking will have the
option to disable it. The new config option DCACHE_TRACK_NEG_ENTRY
is disabled by default.

If this option is enabled, a new kernel parameter "neg_dentry_pc=<%>"
allows users to set the soft limit on how many negative dentries are
allowed as a percentage of the total system memory. The default is 2%
and this new parameter accept a range of 0-10% where 0% means there
is no limit.

When the soft limit is reached, a warning message will be printed to
the console to alert the system administrator.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   9 ++
 fs/Kconfig                                      |  10 ++
 fs/dcache.c                                     | 170 +++++++++++++++++++++++-
 3 files changed, 184 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7..b7ab98a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2462,6 +2462,15 @@
 
 	n2=		[NET] SDL Inc. RISCom/N2 synchronous serial card
 
+	neg_dentry_pc=
+			With "CONFIG_DCACHE_TRACK_NEG_ENTRY=y", specify
+			the limit for the number negative dentries
+			allowable in a system as a percentage of the
+			total system memory. The default is 2% and the
+			valid range is 0-10 where 0 means no limit.
+
+			Format: <pc>
+
 	netdev=		[NET] Network devices parameters
 			Format: <irq>,<io>,<mem_start>,<mem_end>,<name>
 			Note that mem_start is often overloaded to mean
diff --git a/fs/Kconfig b/fs/Kconfig
index ac474a6..2e81637 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -113,6 +113,16 @@ source "fs/autofs/Kconfig"
 source "fs/fuse/Kconfig"
 source "fs/overlayfs/Kconfig"
 
+#
+# Track and limit the number of negative dentries allowed in the system.
+#
+config DCACHE_TRACK_NEG_ENTRY
+	bool "Track & limit negative dcache entries"
+	default n
+	help
+	  This option enables the tracking and limiting of the total
+	  number of negative dcache entries in the filesystem.
+
 menu "Caches"
 
 source "fs/fscache/Kconfig"
diff --git a/fs/dcache.c b/fs/dcache.c
index dbab6c2..889d3bb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -14,6 +14,8 @@
  * the dcache entry is deleted or garbage collected.
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/ratelimit.h>
 #include <linux/string.h>
 #include <linux/mm.h>
@@ -117,9 +119,37 @@ struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
 };
 
+/*
+ * There is a system-wide soft limit to the number of negative dentries
+ * allowed in the super blocks' LRU lists, if enabled. The default limit
+ * is 2% of the total system memory. On a 64-bit system with 1G memory,
+ * that translated to about 100k dentries which is quite a lot. The limit
+ * can be changed by using the "neg_dentry_pc" kernel parameter.
+ *
+ * To avoid performance problem with a global counter on an SMP system,
+ * the tracking is done mostly on a per-cpu basis. The total limit is
+ * distributed in a 80/20 ratio to per-cpu counters and a global free pool.
+ *
+ * If a per-cpu counter runs out of negative dentries, it can borrow extra
+ * ones from the global free pool. If it has more than its percpu limit,
+ * the extra ones will be returned back to the global pool.
+ */
+#define NEG_DENTRY_PC_DEFAULT	2
+#define NEG_DENTRY_BATCH	(1 << 8)
+
+#ifdef CONFIG_DCACHE_TRACK_NEG_ENTRY
+static int neg_dentry_pc __read_mostly = NEG_DENTRY_PC_DEFAULT;
+static long neg_dentry_percpu_limit __read_mostly;
+static long neg_dentry_nfree_init __read_mostly; /* Free pool initial value */
+static struct {
+	raw_spinlock_t nfree_lock;
+	long nfree;			/* Negative dentry free pool */
+} ndblk ____cacheline_aligned_in_smp;
+static DEFINE_PER_CPU(long, nr_dentry_neg);
+#endif
+
 static DEFINE_PER_CPU(long, nr_dentry);
 static DEFINE_PER_CPU(long, nr_dentry_unused);
-static DEFINE_PER_CPU(long, nr_dentry_neg);
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
 
@@ -153,6 +183,7 @@ static long get_nr_dentry_unused(void)
 	return sum < 0 ? 0 : sum;
 }
 
+#ifdef CONFIG_DCACHE_TRACK_NEG_ENTRY
 static long get_nr_dentry_neg(void)
 {
 	int i;
@@ -160,8 +191,12 @@ static long get_nr_dentry_neg(void)
 
 	for_each_possible_cpu(i)
 		sum += per_cpu(nr_dentry_neg, i);
+	sum += neg_dentry_nfree_init - ndblk.nfree;
 	return sum < 0 ? 0 : sum;
 }
+#else
+static long get_nr_dentry_neg(void)	{ return 0L; }
+#endif
 
 int proc_nr_dentry(struct ctl_table *table, int write, void __user *buffer,
 		   size_t *lenp, loff_t *ppos)
@@ -226,9 +261,23 @@ static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char
 
 #endif
 
-static inline void __neg_dentry_dec(struct dentry *dentry)
+#ifdef CONFIG_DCACHE_TRACK_NEG_ENTRY
+/*
+ * Decrement negative dentry count if applicable.
+ */
+static void __neg_dentry_dec(struct dentry *dentry)
 {
-	this_cpu_dec(nr_dentry_neg);
+	if (unlikely((this_cpu_dec_return(nr_dentry_neg) < 0) &&
+	    neg_dentry_pc)) {
+		long *pcnt = get_cpu_ptr(&nr_dentry_neg);
+
+		if ((*pcnt < 0) && raw_spin_trylock(&ndblk.nfree_lock)) {
+			WRITE_ONCE(ndblk.nfree, ndblk.nfree + NEG_DENTRY_BATCH);
+			*pcnt += NEG_DENTRY_BATCH;
+			raw_spin_unlock(&ndblk.nfree_lock);
+		}
+		put_cpu_ptr(&nr_dentry_neg);
+	}
 }
 
 static inline void neg_dentry_dec(struct dentry *dentry)
@@ -237,9 +286,50 @@ static inline void neg_dentry_dec(struct dentry *dentry)
 		__neg_dentry_dec(dentry);
 }
 
-static inline void __neg_dentry_inc(struct dentry *dentry)
+/*
+ * Try to decrement the negative dentry free pool by NEG_DENTRY_BATCH.
+ * The actual decrement returned by the function may be smaller.
+ */
+static long __neg_dentry_nfree_dec(void)
 {
-	this_cpu_inc(nr_dentry_neg);
+	long cnt = NEG_DENTRY_BATCH;
+
+	raw_spin_lock(&ndblk.nfree_lock);
+	if (ndblk.nfree < cnt)
+		cnt = ndblk.nfree;
+	WRITE_ONCE(ndblk.nfree, ndblk.nfree - cnt);
+	raw_spin_unlock(&ndblk.nfree_lock);
+	return cnt;
+}
+
+/*
+ * Increment negative dentry count if applicable.
+ */
+static void __neg_dentry_inc(struct dentry *dentry)
+{
+	long cnt = 0, *pcnt;
+
+	if (likely((this_cpu_inc_return(nr_dentry_neg) <=
+		    neg_dentry_percpu_limit) || !neg_dentry_pc))
+		return;
+
+	/*
+	 * Try to move some negative dentry quota from the global free
+	 * pool to the percpu count to allow more negative dentries to
+	 * be added to the LRU.
+	 */
+	pcnt = get_cpu_ptr(&nr_dentry_neg);
+	if (READ_ONCE(ndblk.nfree) && (*pcnt > neg_dentry_percpu_limit)) {
+		cnt = __neg_dentry_nfree_dec();
+		*pcnt -= cnt;
+	}
+	put_cpu_ptr(&nr_dentry_neg);
+
+	/*
+	 * Put out a warning if there are too many negative dentries.
+	 */
+	if (!cnt)
+		pr_warn_once("Too many negative dentries.");
 }
 
 static inline void neg_dentry_inc(struct dentry *dentry)
@@ -248,6 +338,26 @@ static inline void neg_dentry_inc(struct dentry *dentry)
 		__neg_dentry_inc(dentry);
 }
 
+#else /* CONFIG_DCACHE_TRACK_NEG_ENTRY */
+
+static inline void __neg_dentry_dec(struct dentry *dentry)
+{
+}
+
+static inline void neg_dentry_dec(struct dentry *dentry)
+{
+}
+
+static inline void __neg_dentry_inc(struct dentry *dentry)
+{
+}
+
+static inline void neg_dentry_inc(struct dentry *dentry)
+{
+}
+
+#endif /* CONFIG_DCACHE_TRACK_NEG_ENTRY */
+
 static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *ct, unsigned tcount)
 {
 	/*
@@ -3149,6 +3259,54 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_tmpfile);
 
+#ifdef CONFIG_DCACHE_TRACK_NEG_ENTRY
+static void __init neg_dentry_init(void)
+{
+	/* Rough estimate of # of dentries allocated per page */
+	unsigned int nr_dentry_page = PAGE_SIZE/sizeof(struct dentry) - 1;
+	unsigned long cnt;
+
+	raw_spin_lock_init(&ndblk.nfree_lock);
+
+	/* 20% in global pool & 80% in percpu free */
+	ndblk.nfree = neg_dentry_nfree_init
+		    = totalram_pages * nr_dentry_page * neg_dentry_pc / 500;
+	cnt = ndblk.nfree * 4 / num_possible_cpus();
+	if (unlikely((cnt < 2 * NEG_DENTRY_BATCH) && neg_dentry_pc))
+		cnt = 2 * NEG_DENTRY_BATCH;
+	neg_dentry_percpu_limit = cnt;
+
+	pr_info("Negative dentry: percpu limit = %ld, free pool = %ld\n",
+		neg_dentry_percpu_limit, ndblk.nfree);
+}
+
+static int __init set_neg_dentry_pc(char *str)
+{
+	int err = -EINVAL;
+	unsigned long pc;
+
+	if (str) {
+		err = kstrtoul(str, 0, &pc);
+		if (err)
+			return err;
+
+		/*
+		 * Valid negative dentry percentage: 0-10%
+		 */
+		if ((pc >= 0) && (pc <= 10)) {
+			neg_dentry_pc = pc;
+			return 0;
+		}
+		err = -ERANGE;
+	}
+	return err;
+}
+early_param("neg_dentry_pc", set_neg_dentry_pc);
+#else
+static inline void neg_dentry_init(void) { }
+#endif
+
+
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
 {
@@ -3191,6 +3349,8 @@ static void __init dcache_init(void)
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
 		d_iname);
 
+	neg_dentry_init();
+
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
 		return;
-- 
1.8.3.1

