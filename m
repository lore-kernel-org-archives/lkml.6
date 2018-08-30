Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A5FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A08020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A08020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeHaB7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:59:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727810AbeHaB7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:59:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80BB67DAC2;
        Thu, 30 Aug 2018 21:55:29 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAFEE2157F4A;
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
Subject: [PATCH v2 4/4] fs/dcache: Eliminate branches in nr_dentry_negative accounting
Date:   Thu, 30 Aug 2018 17:55:07 -0400
Message-Id: <1535666107-25699-5-git-send-email-longman@redhat.com>
In-Reply-To: <1535666107-25699-1-git-send-email-longman@redhat.com>
References: <1535666107-25699-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 21:55:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 21:55:29 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the accounting of nr_dentry_negative depends on whether a dentry
is a negative one or not, branch instructions are introduced to handle
the accounting conditionally. That may potentially slow down the task
by a noticeable amount if that introduces sizeable amount of additional
branch mispredictions.

To avoid that, the accounting code is now modified to use conditional
move instructions instead, if supported by the architecture.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c1cc956..dfd5628 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -171,6 +171,29 @@ int proc_nr_dentry(struct ctl_table *table, int write, void __user *buffer,
 	dentry_stat.nr_negative = get_nr_dentry_negative();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
+
+/*
+ * Increment/Decrement nr_dentry_negative if the condition is true.
+ * For architectures that support some kind of conditional move, compiler
+ * should be able generate code to inc/dec negative dentry counter
+ * without any branch instruction.
+ */
+static inline void cond_negative_dentry_inc(bool cond)
+{
+	int val = !!cond;
+
+	this_cpu_add(nr_dentry_negative, val);
+}
+
+static inline void cond_negative_dentry_dec(bool cond)
+{
+	int val = !!cond;
+
+	this_cpu_sub(nr_dentry_negative, val);
+}
+#else
+static inline void cond_negative_dentry_inc(bool cond) { }
+static inline void cond_negative_dentry_dec(bool cond) { }
 #endif
 
 /*
@@ -343,8 +366,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
-	if (dentry->d_flags & DCACHE_LRU_LIST)
-		this_cpu_inc(nr_dentry_negative);
+	cond_negative_dentry_inc(dentry->d_flags & DCACHE_LRU_LIST);
 }
 
 static void dentry_free(struct dentry *dentry)
@@ -412,8 +434,7 @@ static void d_lru_add(struct dentry *dentry)
 	D_FLAG_VERIFY(dentry, 0);
 	dentry->d_flags |= DCACHE_LRU_LIST;
 	this_cpu_inc(nr_dentry_unused);
-	if (d_is_negative(dentry))
-		this_cpu_inc(nr_dentry_negative);
+	cond_negative_dentry_inc(d_is_negative(dentry));
 	WARN_ON_ONCE(!list_lru_add(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
 }
 
@@ -422,8 +443,7 @@ static void d_lru_del(struct dentry *dentry)
 	D_FLAG_VERIFY(dentry, DCACHE_LRU_LIST);
 	dentry->d_flags &= ~DCACHE_LRU_LIST;
 	this_cpu_dec(nr_dentry_unused);
-	if (d_is_negative(dentry))
-		this_cpu_dec(nr_dentry_negative);
+	cond_negative_dentry_dec(d_is_negative(dentry));
 	WARN_ON_ONCE(!list_lru_del(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
 }
 
@@ -454,8 +474,7 @@ static void d_lru_isolate(struct list_lru_one *lru, struct dentry *dentry)
 	D_FLAG_VERIFY(dentry, DCACHE_LRU_LIST);
 	dentry->d_flags &= ~DCACHE_LRU_LIST;
 	this_cpu_dec(nr_dentry_unused);
-	if (d_is_negative(dentry))
-		this_cpu_dec(nr_dentry_negative);
+	cond_negative_dentry_dec(d_is_negative(dentry));
 	list_lru_isolate(lru, &dentry->d_lru);
 }
 
@@ -464,8 +483,7 @@ static void d_lru_shrink_move(struct list_lru_one *lru, struct dentry *dentry,
 {
 	D_FLAG_VERIFY(dentry, DCACHE_LRU_LIST);
 	dentry->d_flags |= DCACHE_SHRINK_LIST;
-	if (d_is_negative(dentry))
-		this_cpu_dec(nr_dentry_negative);
+	cond_negative_dentry_dec(d_is_negative(dentry));
 	list_lru_isolate_move(lru, &dentry->d_lru, list);
 }
 
@@ -1865,8 +1883,7 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	/*
 	 * Decrement negative dentry count if it was in the LRU list.
 	 */
-	if (dentry->d_flags & DCACHE_LRU_LIST)
-		this_cpu_dec(nr_dentry_negative);
+	cond_negative_dentry_dec(dentry->d_flags & DCACHE_LRU_LIST);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_set_inode_and_type(dentry, inode, add_flags);
-- 
1.8.3.1

