Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87783C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D65256A2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D65256A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeGBFx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752908AbeGBFxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B747D307D865;
        Mon,  2 Jul 2018 05:53:23 +0000 (UTC)
Received: from llong.com (ovpn-116-112.phx2.redhat.com [10.3.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BC8F1001F41;
        Mon,  2 Jul 2018 05:53:13 +0000 (UTC)
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
Subject: [PATCH v5 6/6] fs/dcache: Make negative dentry limit enforcement sysctl parameter
Date:   Mon,  2 Jul 2018 13:52:03 +0800
Message-Id: <1530510723-24814-7-git-send-email-longman@redhat.com>
In-Reply-To: <1530510723-24814-1-git-send-email-longman@redhat.com>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 02 Jul 2018 05:53:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful to make negative dentry limit enformcement a runtime
tuning parameter instead of just a boot time option. This allows system
administrator to disable limit enforcement in normal use, but turn it
on under certain circumstances.

A new /proc/sys/fs/enforce-neg-dentry-limit sysctl parameter is now
added. This is a boolean flag that accept a value of either 0 or 1
for disabling and enabling enforcement of negative dentry limit
respectively.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/sysctl/fs.txt | 11 +++++++++++
 fs/dcache.c                 |  4 +++-
 include/linux/dcache.h      |  4 ++++
 kernel/sysctl.c             | 11 +++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
index a8e3f1f..ef8fd32 100644
--- a/Documentation/sysctl/fs.txt
+++ b/Documentation/sysctl/fs.txt
@@ -24,6 +24,7 @@ Currently, these files are in /proc/sys/fs:
 - dentry-state
 - dquot-max
 - dquot-nr
+- enforce-neg-dentry-limit
 - file-max
 - file-nr
 - inode-max
@@ -97,6 +98,16 @@ you might want to raise the limit.
 
 ==============================================================
 
+enforce-neg-dentry-limit:
+
+The file enforce-neg-dentry-limit, if present, contains a boolean
+flag (0 or 1) indicating if the negative dentries limit set by
+the "neg_dentry_pc" kernel parameter should be enforced or not.
+If enforced, excess negative dentries over the limit will be killed
+immediately after use.
+
+==============================================================
+
 file-max & file-nr:
 
 The value in file-max denotes the maximum number of file-
diff --git a/fs/dcache.c b/fs/dcache.c
index 77910c9..f50886e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -146,7 +146,9 @@ struct dentry_stat_t dentry_stat = {
 	unlikely(!(sb)->s_root || !((sb)->s_flags & MS_ACTIVE))
 
 #ifdef CONFIG_DCACHE_TRACK_NEG_ENTRY
-static int enforce_neg_dentry_limit __read_mostly;
+int enforce_neg_dentry_limit __read_mostly;
+EXPORT_SYMBOL_GPL(enforce_neg_dentry_limit);
+
 static int neg_dentry_pc __read_mostly = NEG_DENTRY_PC_DEFAULT;
 static long neg_dentry_percpu_limit __read_mostly;
 static long neg_dentry_nfree_init __read_mostly; /* Free pool initial value */
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 69b8cb3..bd7238a0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -610,4 +610,8 @@ struct name_snapshot {
 void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
 void release_dentry_name_snapshot(struct name_snapshot *);
 
+#ifdef CONFIG_DCACHE_TRACK_NEG_ENTRY
+extern int enforce_neg_dentry_limit;
+#endif
+
 #endif	/* __LINUX_DCACHE_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2d9837c..94f6f6c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1849,6 +1849,17 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &one,
 	},
+#ifdef CONFIG_DCACHE_TRACK_NEG_ENTRY
+	{
+		.procname	= "enforce-neg-dentry-limit",
+		.data		= &enforce_neg_dentry_limit,
+		.maxlen		= sizeof(enforce_neg_dentry_limit),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+#endif
 	{ }
 };
 
-- 
1.8.3.1

