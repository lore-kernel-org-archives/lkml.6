Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6616DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D2624D31
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D2624D31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeGBFxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:53:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752671AbeGBFxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:53:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95142307D84B;
        Mon,  2 Jul 2018 05:53:13 +0000 (UTC)
Received: from llong.com (ovpn-116-112.phx2.redhat.com [10.3.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB96D1001640;
        Mon,  2 Jul 2018 05:53:08 +0000 (UTC)
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
Subject: [PATCH v5 5/6] fs/dcache: Allow optional enforcement of negative dentry limit
Date:   Mon,  2 Jul 2018 13:52:02 +0800
Message-Id: <1530510723-24814-6-git-send-email-longman@redhat.com>
In-Reply-To: <1530510723-24814-1-git-send-email-longman@redhat.com>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 02 Jul 2018 05:53:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a rogue application that generates a large number of negative
dentries is running, the automatic negative dentries pruning process
may not be fast enough to clear up the negative dentries in time. In
this case, it is possible that negative dentries will use up most
of the available memory in the system when that application is not
under the control of a memory cgroup that limit kernel memory.

The lack of available memory may significantly affect the operation
of other applications running in the system. It may even lead to OOM
kill of useful applications.

To allow system administrators the option to prevent this extreme
situation from happening, the "enforce" option can now be added to
the "neg_dentry_pc" kernel parameter to enforce the negative dentry
limit. When the limit is enforced, extra negative dentries that exceed
the limit will be killed after use instead of leaving them in the LRU.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +-
 fs/dcache.c                                     | 94 +++++++++++++++++++------
 include/linux/dcache.h                          |  2 +-
 3 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b7ab98a..05531a8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2468,8 +2468,11 @@
 			allowable in a system as a percentage of the
 			total system memory. The default is 2% and the
 			valid range is 0-10 where 0 means no limit.
+			The optional "enforce" option can be added to
+			enforce the limit by killing excessive negative
+			dentries.
 
-			Format: <pc>
+			Format: <pc>[,enforce]
 
 	netdev=		[NET] Network devices parameters
 			Format: <irq>,<io>,<mem_start>,<mem_end>,<name>
diff --git a/fs/dcache.c b/fs/dcache.c
index 4f34f53..77910c9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -124,7 +124,10 @@ struct dentry_stat_t dentry_stat = {
  * allowed in the super blocks' LRU lists, if enabled. The default limit
  * is 2% of the total system memory. On a 64-bit system with 1G memory,
  * that translated to about 100k dentries which is quite a lot. The limit
- * can be changed by using the "neg_dentry_pc" kernel parameter.
+ * can be changed by using the "neg_dentry_pc" kernel parameter. An
+ * optional "enforce" option can be added to enforce the limit by
+ * destroying extra negative dentries after use when the limit is
+ * exceeded.
  *
  * To avoid performance problem with a global counter on an SMP system,
  * the tracking is done mostly on a per-cpu basis. The total limit is
@@ -143,6 +146,7 @@ struct dentry_stat_t dentry_stat = {
 	unlikely(!(sb)->s_root || !((sb)->s_flags & MS_ACTIVE))
 
 #ifdef CONFIG_DCACHE_TRACK_NEG_ENTRY
+static int enforce_neg_dentry_limit __read_mostly;
 static int neg_dentry_pc __read_mostly = NEG_DENTRY_PC_DEFAULT;
 static long neg_dentry_percpu_limit __read_mostly;
 static long neg_dentry_nfree_init __read_mostly; /* Free pool initial value */
@@ -276,6 +280,9 @@ static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char
 #endif
 
 #ifdef CONFIG_DCACHE_TRACK_NEG_ENTRY
+
+static void d_lru_del(struct dentry *dentry);
+
 /*
  * Decrement negative dentry count if applicable.
  */
@@ -318,8 +325,12 @@ static long __neg_dentry_nfree_dec(void)
 
 /*
  * Increment negative dentry count if applicable.
+ *
+ * The retain flag will only be set when calling from
+ * __d_clear_type_and_inode() so as to retain the entry even
+ * if the negative dentry limit has been exceeded.
  */
-static void __neg_dentry_inc(struct dentry *dentry)
+static void __neg_dentry_inc(struct dentry *dentry, bool retain)
 {
 	long cnt = 0, *pcnt;
 
@@ -340,10 +351,18 @@ static void __neg_dentry_inc(struct dentry *dentry)
 	put_cpu_ptr(&nr_dentry_neg);
 
 	/*
-	 * Put out a warning if there are too many negative dentries.
+	 * Put out a warning if there are too many negative dentries or
+	 * kill it by removing it from the LRU and set the
+	 * DCACHE_KILL_NEGATIVE flag if the enforce option is on.
 	 */
-	if (!cnt)
-		pr_warn_once("Too many negative dentries.");
+	if (!cnt) {
+		if (enforce_neg_dentry_limit && !retain) {
+			dentry->d_flags |= DCACHE_KILL_NEGATIVE;
+			d_lru_del(dentry);
+		} else {
+			pr_warn_once("Too many negative dentries.");
+		}
+	}
 
 	/*
 	 * Initiate negative dentry pruning if free pool has less than
@@ -369,7 +388,7 @@ static void __neg_dentry_inc(struct dentry *dentry)
 static inline void neg_dentry_inc(struct dentry *dentry)
 {
 	if (unlikely(d_is_negative(dentry)))
-		__neg_dentry_inc(dentry);
+		__neg_dentry_inc(dentry, false);
 }
 
 #else /* CONFIG_DCACHE_TRACK_NEG_ENTRY */
@@ -382,7 +401,7 @@ static inline void neg_dentry_dec(struct dentry *dentry)
 {
 }
 
-static inline void __neg_dentry_inc(struct dentry *dentry)
+static inline void __neg_dentry_inc(struct dentry *dentry, bool retain)
 {
 }
 
@@ -509,7 +528,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
 	if (dentry->d_flags & DCACHE_LRU_LIST)
-		__neg_dentry_inc(dentry);
+		__neg_dentry_inc(dentry, true);	/* Always retain it */
 }
 
 static void dentry_free(struct dentry *dentry)
@@ -816,16 +835,27 @@ static inline bool retain_dentry(struct dentry *dentry)
 	if (unlikely(dentry->d_flags & DCACHE_DISCONNECTED))
 		return false;
 
+	if (unlikely(dentry->d_flags & DCACHE_KILL_NEGATIVE))
+		return false;
+
 	if (unlikely(dentry->d_flags & DCACHE_OP_DELETE)) {
 		if (dentry->d_op->d_delete(dentry))
 			return false;
 	}
 	/* retain; LRU fodder */
 	dentry->d_lockref.count--;
-	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
+	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST))) {
 		d_lru_add(dentry);
-	else if (unlikely(!(dentry->d_flags & DCACHE_REFERENCED)))
+		/*
+		 * If DCACHE_LRU_LIST flag isn't set after d_lru_add(),
+		 * it means that it is a negative dentry that has to
+		 * be killed.
+		 */
+		if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
+			return false;
+	} else if (unlikely(!(dentry->d_flags & DCACHE_REFERENCED))) {
 		dentry->d_flags |= DCACHE_REFERENCED;
+	}
 	return true;
 }
 
@@ -865,7 +895,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	spin_lock(&dentry->d_lock);
 	parent = lock_parent(dentry);
 got_locks:
-	if (unlikely(dentry->d_lockref.count != 1)) {
+	if (unlikely((dentry->d_lockref.count != 1) &&
+		    !(dentry->d_flags & DCACHE_KILL_NEGATIVE))) {
 		dentry->d_lockref.count--;
 	} else if (likely(!retain_dentry(dentry))) {
 		__dentry_kill(dentry);
@@ -3451,6 +3482,8 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 EXPORT_SYMBOL(d_tmpfile);
 
 #ifdef CONFIG_DCACHE_TRACK_NEG_ENTRY
+#include <linux/ctype.h>
+
 static void __init neg_dentry_init(void)
 {
 	/* Rough estimate of # of dentries allocated per page */
@@ -3473,23 +3506,38 @@ static void __init neg_dentry_init(void)
 
 static int __init set_neg_dentry_pc(char *str)
 {
-	int err = -EINVAL;
+	int err = 0;
+	int enforce = false;
 	unsigned long pc;
 
-	if (str) {
-		err = kstrtoul(str, 0, &pc);
-		if (err)
-			return err;
+	if (!str)
+		return -EINVAL;
 
-		/*
-		 * Valid negative dentry percentage: 0-10%
-		 */
-		if ((pc >= 0) && (pc <= 10)) {
-			neg_dentry_pc = pc;
-			return 0;
+	while (*str && !err) {
+		if (isdigit(*str)) {
+			err = kstrtoul(str, 0, &pc);
+			if (err)
+				break;
+			/*
+			 * Valid negative dentry percentage: 0-10%
+			 */
+			if ((pc >= 0) && (pc <= 10)) {
+				neg_dentry_pc = pc;
+				while (isxdigit(*str))
+					str++;
+			} else {
+				err = -ERANGE;
+			}
+		} else if (isspace(*str) || (*str == ',')) {
+			str++;
+		} else if (*str && !strncmp("enforce", str, 7)) {
+			str += 7;
+			enforce = true;
+		} else {
+			err = -EINVAL;
 		}
-		err = -ERANGE;
 	}
+	enforce_neg_dentry_limit = enforce;
 	return err;
 }
 early_param("neg_dentry_pc", set_neg_dentry_pc);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6e06d91..69b8cb3 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -215,7 +215,7 @@ struct dentry_operations {
 #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
 #define DCACHE_ENCRYPTED_WITH_KEY	0x02000000 /* dir is encrypted with a valid key */
 #define DCACHE_OP_REAL			0x04000000
-
+#define DCACHE_KILL_NEGATIVE		0x08000000 /* Kill negative dentry */
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 
-- 
1.8.3.1

