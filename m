Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB54C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEDB20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEDB20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeHaB7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:59:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbeHaB7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:59:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E44BE8151D46;
        Thu, 30 Aug 2018 21:55:28 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD892157F4B;
        Thu, 30 Aug 2018 21:55:28 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
        Michal Hocko <mhocko@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/4] fs/dcache: Track & report number of negative dentries
Date:   Thu, 30 Aug 2018 17:55:06 -0400
Message-Id: <1535666107-25699-4-git-send-email-longman@redhat.com>
In-Reply-To: <1535666107-25699-1-git-send-email-longman@redhat.com>
References: <1535666107-25699-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 21:55:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 21:55:29 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current dentry number tracking code doesn't distinguish between
positive & negative dentries. It just reports the total number of
dentries in the LRU lists.

As excessive number of negative dentries can have an impact on system
performance, it will be wise to track the number of positive and
negative dentries separately.

This patch adds tracking for the total number of negative dentries
in the system LRU lists and reports it in the 7th field in the
/proc/sys/fs/dentry-state file. The number, however, does not include
negative dentries that are in flight but not in the LRU yet as well
as those in the shrinker lists.

The number of positive dentries in the LRU lists can be roughly found
by subtracting the number of negative dentries from the unused count.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/sysctl/fs.txt | 22 ++++++++++++++--------
 fs/dcache.c                 | 31 +++++++++++++++++++++++++++++++
 include/linux/dcache.h      |  5 +++--
 kernel/sysctl.c             |  2 +-
 4 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
index 819caf8..21679d0 100644
--- a/Documentation/sysctl/fs.txt
+++ b/Documentation/sysctl/fs.txt
@@ -56,26 +56,32 @@ of any kernel data structures.
 
 dentry-state:
 
-From linux/fs/dentry.c:
+From linux/include/linux/dcache.h:
 --------------------------------------------------------------
-struct {
+struct dentry_stat_t dentry_stat {
         int nr_dentry;
         int nr_unused;
         int age_limit;         /* age in seconds */
         int want_pages;        /* pages requested by system */
         int dummy[2];
-} dentry_stat = {0, 0, 45, 0,};
--------------------------------------------------------------- 
+        int nr_negative;       /* # of unused negative dentries */
+};
+--------------------------------------------------------------
+
+Dentries are dynamically allocated and deallocated.
+
+nr_dentry shows the total number of dentries allocated (active
++ unused). nr_unused shows the number of dentries that are not
+actively used, but are saved in the LRU list for future reuse.
 
-Dentries are dynamically allocated and deallocated, and
-nr_dentry seems to be 0 all the time. Hence it's safe to
-assume that only nr_unused, age_limit and want_pages are
-used. Nr_unused seems to be exactly what its name says.
 Age_limit is the age in seconds after which dcache entries
 can be reclaimed when memory is short and want_pages is
 nonzero when shrink_dcache_pages() has been called and the
 dcache isn't pruned yet.
 
+nr_negative shows the number of unused dentries that are also
+negative dentries which do not mapped to actual files.
+
 ==============================================================
 
 dquot-max & dquot-nr:
diff --git a/fs/dcache.c b/fs/dcache.c
index cb515f1..c1cc956 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -119,6 +119,7 @@ struct dentry_stat_t dentry_stat = {
 
 static DEFINE_PER_CPU(long, nr_dentry);
 static DEFINE_PER_CPU(long, nr_dentry_unused);
+static DEFINE_PER_CPU(long, nr_dentry_negative);
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
 
@@ -152,11 +153,22 @@ static long get_nr_dentry_unused(void)
 	return sum < 0 ? 0 : sum;
 }
 
+static long get_nr_dentry_negative(void)
+{
+	int i;
+	long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(nr_dentry_negative, i);
+	return sum < 0 ? 0 : sum;
+}
+
 int proc_nr_dentry(struct ctl_table *table, int write, void __user *buffer,
 		   size_t *lenp, loff_t *ppos)
 {
 	dentry_stat.nr_dentry = get_nr_dentry();
 	dentry_stat.nr_unused = get_nr_dentry_unused();
+	dentry_stat.nr_negative = get_nr_dentry_negative();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 #endif
@@ -331,6 +343,8 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
+	if (dentry->d_flags & DCACHE_LRU_LIST)
+		this_cpu_inc(nr_dentry_negative);
 }
 
 static void dentry_free(struct dentry *dentry)
@@ -385,6 +399,10 @@ static void dentry_unlink_inode(struct dentry * dentry)
  * The per-cpu "nr_dentry_unused" counters are updated with
  * the DCACHE_LRU_LIST bit.
  *
+ * The per-cpu "nr_dentry_negative" counters are only updated
+ * when deleted or added to the per-superblock LRU list, not
+ * on the shrink list.
+ *
  * These helper functions make sure we always follow the
  * rules. d_lock must be held by the caller.
  */
@@ -394,6 +412,8 @@ static void d_lru_add(struct dentry *dentry)
 	D_FLAG_VERIFY(dentry, 0);
 	dentry->d_flags |= DCACHE_LRU_LIST;
 	this_cpu_inc(nr_dentry_unused);
+	if (d_is_negative(dentry))
+		this_cpu_inc(nr_dentry_negative);
 	WARN_ON_ONCE(!list_lru_add(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
 }
 
@@ -402,6 +422,8 @@ static void d_lru_del(struct dentry *dentry)
 	D_FLAG_VERIFY(dentry, DCACHE_LRU_LIST);
 	dentry->d_flags &= ~DCACHE_LRU_LIST;
 	this_cpu_dec(nr_dentry_unused);
+	if (d_is_negative(dentry))
+		this_cpu_dec(nr_dentry_negative);
 	WARN_ON_ONCE(!list_lru_del(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
 }
 
@@ -432,6 +454,8 @@ static void d_lru_isolate(struct list_lru_one *lru, struct dentry *dentry)
 	D_FLAG_VERIFY(dentry, DCACHE_LRU_LIST);
 	dentry->d_flags &= ~DCACHE_LRU_LIST;
 	this_cpu_dec(nr_dentry_unused);
+	if (d_is_negative(dentry))
+		this_cpu_dec(nr_dentry_negative);
 	list_lru_isolate(lru, &dentry->d_lru);
 }
 
@@ -440,6 +464,8 @@ static void d_lru_shrink_move(struct list_lru_one *lru, struct dentry *dentry,
 {
 	D_FLAG_VERIFY(dentry, DCACHE_LRU_LIST);
 	dentry->d_flags |= DCACHE_SHRINK_LIST;
+	if (d_is_negative(dentry))
+		this_cpu_dec(nr_dentry_negative);
 	list_lru_isolate_move(lru, &dentry->d_lru, list);
 }
 
@@ -1836,6 +1862,11 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	WARN_ON(d_in_lookup(dentry));
 
 	spin_lock(&dentry->d_lock);
+	/*
+	 * Decrement negative dentry count if it was in the LRU list.
+	 */
+	if (dentry->d_flags & DCACHE_LRU_LIST)
+		this_cpu_dec(nr_dentry_negative);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_set_inode_and_type(dentry, inode, add_flags);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index ef4b70f..619a249 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -62,9 +62,10 @@ struct qstr {
 struct dentry_stat_t {
 	long nr_dentry;
 	long nr_unused;
-	long age_limit;          /* age in seconds */
-	long want_pages;         /* pages requested by system */
+	long age_limit;		/* age in seconds */
+	long want_pages;	/* pages requested by system */
 	long dummy[2];
+	long nr_negative;	/* # of unused negative dentries */
 };
 extern struct dentry_stat_t dentry_stat;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050..77ff61c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1708,7 +1708,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 	{
 		.procname	= "dentry-state",
 		.data		= &dentry_stat,
-		.maxlen		= 6*sizeof(long),
+		.maxlen		= 7*sizeof(long),
 		.mode		= 0444,
 		.proc_handler	= proc_nr_dentry,
 	},
-- 
1.8.3.1

