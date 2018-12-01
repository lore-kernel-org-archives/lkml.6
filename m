Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCE5C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F5220867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMkAsAkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F5220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeLAMhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:37:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40095 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeLAMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:37:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so3611260plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 17:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rjOJ0gcpN7vcpNDoRpKDAhgJaOilaT/ZAkTfyJeS0r4=;
        b=SMkAsAkTkVWnBZlb8Jr8zaq8djMobXsa9w9P0cjRnV/WolMEcOdBY8rnvhG8NvaTok
         KuXaZ4RREL8lktUKxkYpwXCahcMIs3AQlg8e0z7FnOW9brs1WYRo8H/XwX6u9cCYeCkF
         K0ZP9yqpBfo/GQP80rSiFj13jb2+fK2vsv5EQaVd9fmg+S59Jlo4avajtvJ7ROgxD7SB
         ZamkUbxI+Xghmm1vfu/tUbailLVg3HGy5IMd3k6Ak4gghqDcWb9tTAITAYoH7SkRtOnd
         o7PbNN6ox4snlha5kyDV0AG4hjW15V8cYFNX0SxlUopRcwCe1cXWHiBQbbs7h4wf0I5d
         548A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rjOJ0gcpN7vcpNDoRpKDAhgJaOilaT/ZAkTfyJeS0r4=;
        b=eRFZm/Z7QIC4Yim4wvUkX5pVYVeBRKj9y42ixi7wI2kAwCiEjZ1sBk7mRiq4mVRs6M
         k0mWeoKsJNYoj3VZ7ZJow68xHt1+YTtOr88YbihA7+eczoVbwWuzLuorINlIr7tBIUnt
         RR0ksDx4FJNDrT/DqYfp0A32/rqWwhDUpyOd0gVItb+YYcAb3gFAzwoa99XED+sha2TD
         sThcMKPid4zyss3a1lVIhJ/afjxdFcdUYw/BBmFMbIE5hqaoiSP1j+LSm9jFr1u9F+oe
         5eadWoB+SuY0hFHujcCVJXGCx0P9feilDP2KPwS+mP36NXFpCi/ZFLpE1RGZk/HuMdKE
         3nrA==
X-Gm-Message-State: AA+aEWayatfFG8OuD4bMDJ9asos2P6PU40qgVwWKWlgLG+saKE7y/14m
        9iw09MpwNW8luW0KCA/o2Qc=
X-Google-Smtp-Source: AFSGD/WNwzJdV3h4e2BVoSmHcG5bACt3pXvfGe398XzOrHQ9FF3OOJ44v2bPc4nskHpN6jCj6yev5Q==
X-Received: by 2002:a17:902:728c:: with SMTP id d12mr7650876pll.284.1543627594158;
        Fri, 30 Nov 2018 17:26:34 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id m198sm7220674pga.10.2018.11.30.17.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 17:26:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] binder: remove BINDER_DEBUG_ENTRY()
Date:   Fri, 30 Nov 2018 20:26:30 -0500
Message-Id: <20181201012630.4459-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
such a macro,so remove BINDER_DEBUG_ENTRY.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/android/binder.c | 48 ++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cb30a524d16d..5496b8e07234 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -94,22 +94,8 @@ static struct dentry *binder_debugfs_dir_entry_root;
 static struct dentry *binder_debugfs_dir_entry_proc;
 static atomic_t binder_last_id;
 
-#define BINDER_DEBUG_ENTRY(name) \
-static int binder_##name##_open(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, binder_##name##_show, inode->i_private); \
-} \
-\
-static const struct file_operations binder_##name##_fops = { \
-	.owner = THIS_MODULE, \
-	.open = binder_##name##_open, \
-	.read = seq_read, \
-	.llseek = seq_lseek, \
-	.release = single_release, \
-}
-
-static int binder_proc_show(struct seq_file *m, void *unused);
-BINDER_DEBUG_ENTRY(proc);
+static int proc_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(proc);
 
 /* This is only defined in include/asm-arm/sizes.h */
 #ifndef SZ_1K
@@ -4964,7 +4950,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 		proc->debugfs_entry = debugfs_create_file(strbuf, 0444,
 			binder_debugfs_dir_entry_proc,
 			(void *)(unsigned long)proc->pid,
-			&binder_proc_fops);
+			&proc_fops);
 	}
 
 	return 0;
@@ -5592,7 +5578,7 @@ static void print_binder_proc_stats(struct seq_file *m,
 }
 
 
-static int binder_state_show(struct seq_file *m, void *unused)
+static int state_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 	struct binder_node *node;
@@ -5631,7 +5617,7 @@ static int binder_state_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static int binder_stats_show(struct seq_file *m, void *unused)
+static int stats_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 
@@ -5647,7 +5633,7 @@ static int binder_stats_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static int binder_transactions_show(struct seq_file *m, void *unused)
+static int transactions_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 
@@ -5660,7 +5646,7 @@ static int binder_transactions_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static int binder_proc_show(struct seq_file *m, void *unused)
+static int proc_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *itr;
 	int pid = (unsigned long)m->private;
@@ -5703,7 +5689,7 @@ static void print_binder_transaction_log_entry(struct seq_file *m,
 			"\n" : " (incomplete)\n");
 }
 
-static int binder_transaction_log_show(struct seq_file *m, void *unused)
+static int transaction_log_show(struct seq_file *m, void *unused)
 {
 	struct binder_transaction_log *log = m->private;
 	unsigned int log_cur = atomic_read(&log->cur);
@@ -5735,10 +5721,10 @@ static const struct file_operations binder_fops = {
 	.release = binder_release,
 };
 
-BINDER_DEBUG_ENTRY(state);
-BINDER_DEBUG_ENTRY(stats);
-BINDER_DEBUG_ENTRY(transactions);
-BINDER_DEBUG_ENTRY(transaction_log);
+DEFINE_SHOW_ATTRIBUTE(state);
+DEFINE_SHOW_ATTRIBUTE(stats);
+DEFINE_SHOW_ATTRIBUTE(transactions);
+DEFINE_SHOW_ATTRIBUTE(transaction_log);
 
 static int __init init_binder_device(const char *name)
 {
@@ -5792,27 +5778,27 @@ static int __init binder_init(void)
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    NULL,
-				    &binder_state_fops);
+				    &state_fops);
 		debugfs_create_file("stats",
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    NULL,
-				    &binder_stats_fops);
+				    &stats_fops);
 		debugfs_create_file("transactions",
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    NULL,
-				    &binder_transactions_fops);
+				    &transactions_fops);
 		debugfs_create_file("transaction_log",
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    &binder_transaction_log,
-				    &binder_transaction_log_fops);
+				    &transaction_log_fops);
 		debugfs_create_file("failed_transaction_log",
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    &binder_transaction_log_failed,
-				    &binder_transaction_log_fops);
+				    &transaction_log_fops);
 	}
 
 	/*
-- 
2.17.0

