Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FF9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BDD206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BDD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeGTLRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:17:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727216AbeGTLRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:17:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4963ADA7;
        Fri, 20 Jul 2018 10:30:15 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] fs/seq_file: remove kmalloc(ops) for single_open seqfiles
Date:   Fri, 20 Jul 2018 12:29:52 +0200
Message-Id: <20180720102952.30935-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

single_open() currently allocates seq_operations with kmalloc(). This is
suboptimal, because that's four pointers, of which three are constant, and
only the 'show' op differs. We also have to be careful to use single_release()
to avoid leaking the ops structure.

Instead of this we can have a fixed single_show() function and constant ops
structure for these seq_files. We can store the pointer to the 'show' op as
a new field of struct seq_file. That's also not terribly elegant, because the
field is there also for non-single_open() seq files, but it's a single pointer
in an already existing (and already relatively large) structure instead of
an extra kmalloc of four pointers, so the tradeoff is OK.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/filesystems/seq_file.txt |  5 +++-
 fs/seq_file.c                          | 40 ++++++++++++--------------
 include/linux/seq_file.h               |  5 ++--
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/filesystems/seq_file.txt b/Documentation/filesystems/seq_file.txt
index 9de4303201e1..ed61495abee8 100644
--- a/Documentation/filesystems/seq_file.txt
+++ b/Documentation/filesystems/seq_file.txt
@@ -335,4 +335,7 @@ When output time comes, the show() function will be called once. The data
 value given to single_open() can be found in the private field of the
 seq_file structure. When using single_open(), the programmer should use
 single_release() instead of seq_release() in the file_operations structure
-to avoid a memory leak.
+to avoid a memory leak. Note that the implementation has changed and current
+kernels will not leak anymore, but it's better to keep using single_release()
+in case the implementation details change again.
+
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 4cc090b50cc5..3fd2ded04d93 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -563,22 +563,27 @@ static void single_stop(struct seq_file *p, void *v)
 {
 }
 
+static int single_show(struct seq_file *p, void *v)
+{
+	return p->single_show_op(p, v);
+}
+
+static const struct seq_operations single_seq_op = {
+	.start	= single_start,
+	.next	= single_next,
+	.stop	= single_stop,
+	.show	= single_show
+};
+
 int single_open(struct file *file, int (*show)(struct seq_file *, void *),
 		void *data)
 {
-	struct seq_operations *op = kmalloc(sizeof(*op), GFP_KERNEL_ACCOUNT);
-	int res = -ENOMEM;
-
-	if (op) {
-		op->start = single_start;
-		op->next = single_next;
-		op->stop = single_stop;
-		op->show = show;
-		res = seq_open(file, op);
-		if (!res)
-			((struct seq_file *)file->private_data)->private = data;
-		else
-			kfree(op);
+	int res;
+
+	res = seq_open(file, &single_seq_op);
+	if (!res) {
+		((struct seq_file *)file->private_data)->private = data;
+		((struct seq_file *)file->private_data)->single_show_op = show;
 	}
 	return res;
 }
@@ -602,15 +607,6 @@ int single_open_size(struct file *file, int (*show)(struct seq_file *, void *),
 }
 EXPORT_SYMBOL(single_open_size);
 
-int single_release(struct inode *inode, struct file *file)
-{
-	const struct seq_operations *op = ((struct seq_file *)file->private_data)->op;
-	int res = seq_release(inode, file);
-	kfree(op);
-	return res;
-}
-EXPORT_SYMBOL(single_release);
-
 int seq_release_private(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = file->private_data;
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index a121982af0f5..c9a70c584a7d 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -24,9 +24,10 @@ struct seq_file {
 	u64 version;
 	struct mutex lock;
 	const struct seq_operations *op;
-	int poll_event;
+	int (*single_show_op)(struct seq_file *, void *);
 	const struct file *file;
 	void *private;
+	int poll_event;
 };
 
 struct seq_operations {
@@ -140,7 +141,7 @@ int seq_path_root(struct seq_file *m, const struct path *path,
 
 int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
 int single_open_size(struct file *, int (*)(struct seq_file *, void *), void *, size_t);
-int single_release(struct inode *, struct file *);
+#define single_release	seq_release
 void *__seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_release_private(struct inode *, struct file *);
-- 
2.18.0

