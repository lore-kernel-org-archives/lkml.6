Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED85C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E7220878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E7220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeH1OaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:30:22 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:35172 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1OaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:30:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id E11D6183A0;
        Tue, 28 Aug 2018 12:39:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id BAoW5Ap7omb3; Tue, 28 Aug 2018 12:39:18 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 076BF1839E;
        Tue, 28 Aug 2018 12:39:17 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBB271E07E;
        Tue, 28 Aug 2018 12:39:17 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D07521E07C;
        Tue, 28 Aug 2018 12:39:17 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Tue, 28 Aug 2018 12:39:17 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id C44F02150;
        Tue, 28 Aug 2018 12:39:17 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id BEE958016F; Tue, 28 Aug 2018 12:39:17 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 1/2] kmemleak: dump all objects for slab usage analysis
Date:   Tue, 28 Aug 2018 12:39:13 +0200
Message-Id: <20180828103914.30434-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to analyse the kernel's slab usage, we'd need a list
of allocated objects and their allocation stacks.  Kmemleak already
maintains such a list internally, so we expose it via debugfs file.

This file can be post-processed in userspace and converted to a suitable
format for slab usage analysis.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 mm/kmemleak.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 17dd883198ae..7bef05c690d6 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1759,6 +1759,34 @@ static int kmemleak_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
+static void kmemleak_print_object(struct seq_file *seq,
+				  struct kmemleak_object *object)
+{
+	int i;
+
+	seq_printf(seq, "object 0x%08lx (size %zu):\n",
+		   object->pointer, object->size);
+	seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
+		   object->comm, object->pid, object->jiffies);
+
+	for (i = 0; i < object->trace_len; i++) {
+		void *ptr = (void *)object->trace[i];
+
+		seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
+	}
+}
+
+static int kmemleak_all_seq_show(struct seq_file *seq, void *v)
+{
+	struct kmemleak_object *object = v;
+	unsigned long flags;
+
+	spin_lock_irqsave(&object->lock, flags);
+	kmemleak_print_object(seq, object);
+	spin_unlock_irqrestore(&object->lock, flags);
+	return 0;
+}
+
 static const struct seq_operations kmemleak_seq_ops = {
 	.start = kmemleak_seq_start,
 	.next  = kmemleak_seq_next,
@@ -1766,11 +1794,23 @@ static const struct seq_operations kmemleak_seq_ops = {
 	.show  = kmemleak_seq_show,
 };
 
+static const struct seq_operations kmemleak_all_seq_ops = {
+	.start = kmemleak_seq_start,
+	.next  = kmemleak_seq_next,
+	.stop  = kmemleak_seq_stop,
+	.show  = kmemleak_all_seq_show,
+};
+
 static int kmemleak_open(struct inode *inode, struct file *file)
 {
 	return seq_open(file, &kmemleak_seq_ops);
 }
 
+static int kmemleak_all_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &kmemleak_all_seq_ops);
+}
+
 static int dump_str_object_info(const char *str)
 {
 	unsigned long flags;
@@ -1911,6 +1951,14 @@ static const struct file_operations kmemleak_fops = {
 	.release	= seq_release,
 };
 
+static const struct file_operations kmemleak_all_fops = {
+	.owner		= THIS_MODULE,
+	.open		= kmemleak_all_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static void __kmemleak_do_cleanup(void)
 {
 	struct kmemleak_object *object;
@@ -2102,6 +2150,11 @@ static int __init kmemleak_late_init(void)
 	if (!dentry)
 		pr_warn("Failed to create the debugfs kmemleak file\n");
 
+	dentry = debugfs_create_file("kmemleak_all", 0400, NULL, NULL,
+				     &kmemleak_all_fops);
+	if (!dentry)
+		pr_warn("Failed to create the debugfs kmemleak_all file\n");
+
 	if (kmemleak_error) {
 		/*
 		 * Some error occurred and kmemleak was disabled. There is a
-- 
2.11.0

