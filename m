Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5BEC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF3120661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF3120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeLIWDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:03:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35686 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbeLIVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72r-0002ih-9t; Sun, 09 Dec 2018 21:55:25 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003fT-PO; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.165113920@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 299/328] Make file credentials available to the
 seqfile interfaces
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 34dbbcdbf63360661ff7bda6c5f52f99ac515f92 upstream.

A lot of seqfile users seem to be using things like %pK that uses the
credentials of the current process, but that is actually completely
wrong for filesystem interfaces.

The unix semantics for permission checking files is to check permissions
at _open_ time, not at read or write time, and that is not just a small
detail: passing off stdin/stdout/stderr to a suid application and making
the actual IO happen in privileged context is a classic exploit
technique.

So if we want to be able to look at permissions at read time, we need to
use the file open credentials, not the current ones.  Normal file
accesses can just use "f_cred" (or any of the helper functions that do
that, like file_ns_capable()), but the seqfile interfaces do not have
any such options.

It turns out that seq_file _does_ save away the user_ns information of
the file, though.  Since user_ns is just part of the full credential
information, replace that special case with saving off the cred pointer
instead, and suddenly seq_file has all the permission information it
needs.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/seq_file.c            |  7 ++++---
 include/linux/seq_file.h | 13 ++++---------
 2 files changed, 8 insertions(+), 12 deletions(-)

--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -69,9 +69,10 @@ int seq_open(struct file *file, const st
 	memset(p, 0, sizeof(*p));
 	mutex_init(&p->lock);
 	p->op = op;
-#ifdef CONFIG_USER_NS
-	p->user_ns = file->f_cred->user_ns;
-#endif
+
+	// No refcounting: the lifetime of 'p' is constrained
+	// to the lifetime of the file.
+	p->file = file;
 
 	/*
 	 * Wrappers around seq_open(e.g. swaps_open) need to be
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -7,13 +7,10 @@
 #include <linux/mutex.h>
 #include <linux/cpumask.h>
 #include <linux/nodemask.h>
+#include <linux/fs.h>
+#include <linux/cred.h>
 
 struct seq_operations;
-struct file;
-struct path;
-struct inode;
-struct dentry;
-struct user_namespace;
 
 struct seq_file {
 	char *buf;
@@ -27,9 +24,7 @@ struct seq_file {
 	struct mutex lock;
 	const struct seq_operations *op;
 	int poll_event;
-#ifdef CONFIG_USER_NS
-	struct user_namespace *user_ns;
-#endif
+	const struct file *file;
 	void *private;
 };
 
@@ -151,7 +146,7 @@ int seq_put_decimal_ll(struct seq_file *
 static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
 {
 #ifdef CONFIG_USER_NS
-	return seq->user_ns;
+	return seq->file->f_cred->user_ns;
 #else
 	extern struct user_namespace init_user_ns;
 	return &init_user_ns;

