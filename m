Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2B7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40529254F6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40529254F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeGBFwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:52:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753060AbeGBFwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:52:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A47913082A40;
        Mon,  2 Jul 2018 05:52:45 +0000 (UTC)
Received: from llong.com (ovpn-116-112.phx2.redhat.com [10.3.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FB361001643;
        Mon,  2 Jul 2018 05:52:40 +0000 (UTC)
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
Subject: [PATCH v5 1/6] fs/dcache: Track & report number of negative dentries
Date:   Mon,  2 Jul 2018 13:51:58 +0800
Message-Id: <1530510723-24814-2-git-send-email-longman@redhat.com>
In-Reply-To: <1530510723-24814-1-git-send-email-longman@redhat.com>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 02 Jul 2018 05:52:46 +0000 (UTC)
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

This patch adds tracking for the total number of negative dentries in
the system LRU lists and reports it in the /proc/sys/fs/dentry-state
file.  The number of positive dentries in the LRU lists can be found
by subtracting the number of negative dentries from the total.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/sysctl/fs.txt | 19 +++++++++++++------
 fs/dcache.c                 | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h      |  7 ++++---
 3 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
index 6c00c1e..a8e3f1f 100644
--- a/Documentation/sysctl/fs.txt
+++ b/Documentation/sysctl/fs.txt
@@ -61,19 +61,26 @@ struct {
         int nr_unused;
         int age_limit;         /* age in seconds */
         int want_pages;        /* pages requested by system */
-        int dummy[2];
+        int nr_negative;       /* # of unused negative dentries */
+        int dummy;
 } dentry_stat = {0, 0, 45, 0,};
--------------------------------------------------------------- 
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
+negative dentries which do not mapped to actual files if negative
+dentries tracking is enabled.
+
 ==============================================================
 
 dquot-max & dquot-nr:
diff --git a/fs/dcache.c b/fs/dcache.c
index 0e8e5de..dbab6c2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -119,6 +119,7 @@ struct dentry_stat_t dentry_stat = {
 
 static DEFINE_PER_CPU(long, nr_dentry);
 static DEFINE_PER_CPU(long, nr_dentry_unused);
+static DEFINE_PER_CPU(long, nr_dentry_neg);
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
 
@@ -152,11 +153,22 @@ static long get_nr_dentry_unused(void)
 	return sum < 0 ? 0 : sum;
 }
 
+static long get_nr_dentry_neg(void)
+{
+	int i;
+	long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(nr_dentry_neg, i);
+	return sum < 0 ? 0 : sum;
+}
+
 int proc_nr_dentry(struct ctl_table *table, int write, void __user *buffer,
 		   size_t *lenp, loff_t *ppos)
 {
 	dentry_stat.nr_dentry = get_nr_dentry();
 	dentry_stat.nr_unused = get_nr_dentry_unused();
+	dentry_stat.nr_negative = get_nr_dentry_neg();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 #endif
@@ -214,6 +226,28 @@ static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char
 
 #endif
 
+static inline void __neg_dentry_dec(struct dentry *dentry)
+{
+	this_cpu_dec(nr_dentry_neg);
+}
+
+static inline void neg_dentry_dec(struct dentry *dentry)
+{
+	if (unlikely(d_is_negative(dentry)))
+		__neg_dentry_dec(dentry);
+}
+
+static inline void __neg_dentry_inc(struct dentry *dentry)
+{
+	this_cpu_inc(nr_dentry_neg);
+}
+
+static inline void neg_dentry_inc(struct dentry *dentry)
+{
+	if (unlikely(d_is_negative(dentry)))
+		__neg_dentry_inc(dentry);
+}
+
 static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *ct, unsigned tcount)
 {
 	/*
@@ -330,6 +364,8 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
+	if (dentry->d_flags & DCACHE_LRU_LIST)
+		__neg_dentry_inc(dentry);
 }
 
 static void dentry_free(struct dentry *dentry)
@@ -397,6 +433,7 @@ static void d_lru_add(struct dentry *dentry)
 	dentry->d_flags |= DCACHE_LRU_LIST;
 	this_cpu_inc(nr_dentry_unused);
 	WARN_ON_ONCE(!list_lru_add(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
+	neg_dentry_inc(dentry);
 }
 
 static void d_lru_del(struct dentry *dentry)
@@ -405,6 +442,7 @@ static void d_lru_del(struct dentry *dentry)
 	dentry->d_flags &= ~DCACHE_LRU_LIST;
 	this_cpu_dec(nr_dentry_unused);
 	WARN_ON_ONCE(!list_lru_del(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
+	neg_dentry_dec(dentry);
 }
 
 static void d_shrink_del(struct dentry *dentry)
@@ -435,6 +473,7 @@ static void d_lru_isolate(struct list_lru_one *lru, struct dentry *dentry)
 	dentry->d_flags &= ~DCACHE_LRU_LIST;
 	this_cpu_dec(nr_dentry_unused);
 	list_lru_isolate(lru, &dentry->d_lru);
+	neg_dentry_dec(dentry);
 }
 
 static void d_lru_shrink_move(struct list_lru_one *lru, struct dentry *dentry,
@@ -443,6 +482,7 @@ static void d_lru_shrink_move(struct list_lru_one *lru, struct dentry *dentry,
 	D_FLAG_VERIFY(dentry, DCACHE_LRU_LIST);
 	dentry->d_flags |= DCACHE_SHRINK_LIST;
 	list_lru_isolate_move(lru, &dentry->d_lru, list);
+	neg_dentry_dec(dentry);
 }
 
 /**
@@ -1842,6 +1882,11 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	WARN_ON(d_in_lookup(dentry));
 
 	spin_lock(&dentry->d_lock);
+	/*
+	 * Decrement negative dentry count if it was in the LRU list.
+	 */
+	if (dentry->d_flags & DCACHE_LRU_LIST)
+		__neg_dentry_dec(dentry);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_set_inode_and_type(dentry, inode, add_flags);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 66c6e17..6e06d91 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -62,9 +62,10 @@ struct qstr {
 struct dentry_stat_t {
 	long nr_dentry;
 	long nr_unused;
-	long age_limit;          /* age in seconds */
-	long want_pages;         /* pages requested by system */
-	long dummy[2];
+	long age_limit;		/* age in seconds */
+	long want_pages;	/* pages requested by system */
+	long nr_negative;	/* # of unused negative dentries */
+	long dummy;
 };
 extern struct dentry_stat_t dentry_stat;
 
-- 
1.8.3.1

