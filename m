Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3583CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC6820652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMeXlaSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC6820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbeJKXH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJKXH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:07:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B433C20652;
        Thu, 11 Oct 2018 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272412;
        bh=cAtpnss532Jq9saECfA1Yy7MbKG5NixrSQ9RMFE8Ia0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMeXlaSvXfOckBlBSPjNGXDJuA2vSeDXGVkMU1RMfs9IrGea5B8C3sZBA9lvuxT3A
         oYR6LnDEf7yjRBNHTg2ClvjzhiSOCMKL/t12xjpem7P787rAia4k5i39MsD5rGdPpj
         AoKK6slnzFZbeTGDQG5zCQS6ldH4fmzPLkbJ8cz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH 3.18 099/120] Make file credentials available to the seqfile interfaces
Date:   Thu, 11 Oct 2018 17:34:40 +0200
Message-Id: <20181011152553.881703248@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/seq_file.c            |    7 ++++---
 include/linux/seq_file.h |   13 ++++---------
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


