Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 56610C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F8F208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F8F208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935537AbeFMSnX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:43:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935117AbeFMSnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:43:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3A2E873C3;
        Wed, 13 Jun 2018 18:43:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F0361C640;
        Wed, 13 Jun 2018 18:43:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] proc: Make inline name size calculation automatic
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Jun 2018 19:43:19 +0100
Message-ID: <152891539958.23512.10618044594537218194.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 13 Jun 2018 18:43:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 13 Jun 2018 18:43:20 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make calculation of the size of the inline name in struct proc_dir_entry
automatic, rather than having to manually encode the numbers and failing to
allow for lockdep.

Require a minimum inline name size of 33+1 to allow for names that look
like two hex numbers with a dash between.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/proc/generic.c  |    2 +-
 fs/proc/inode.c    |    5 ++---
 fs/proc/internal.h |   18 ++++++++++++------
 fs/proc/root.c     |    3 +--
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index fa5b28f0a3a3..6ac1c92997ea 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -409,7 +409,7 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	if (!ent)
 		goto out;
 
-	if (qstr.len + 1 <= sizeof(ent->inline_name)) {
+	if (qstr.len + 1 <= SIZEOF_PDE_INLINE_NAME) {
 		ent->name = ent->inline_name;
 	} else {
 		ent->name = kmalloc(qstr.len + 1, GFP_KERNEL);
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 7aa86dd65ba8..38155bec4a54 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -104,9 +104,8 @@ void __init proc_init_kmemcache(void)
 		kmem_cache_create("pde_opener", sizeof(struct pde_opener), 0,
 				  SLAB_ACCOUNT|SLAB_PANIC, NULL);
 	proc_dir_entry_cache = kmem_cache_create_usercopy(
-		"proc_dir_entry", sizeof(struct proc_dir_entry), 0, SLAB_PANIC,
-		offsetof(struct proc_dir_entry, inline_name),
-		sizeof_field(struct proc_dir_entry, inline_name), NULL);
+		"proc_dir_entry", SIZEOF_PDE_SLOT, 0, SLAB_PANIC,
+		OFFSETOF_PDE_NAME, SIZEOF_PDE_INLINE_NAME, NULL);
 }
 
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 0644b29e53b7..539c6566752a 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -62,14 +62,20 @@ struct proc_dir_entry {
 	char *name;
 	umode_t mode;
 	u8 namelen;
-#ifdef CONFIG_64BIT
-#define SIZEOF_PDE_INLINE_NAME	(192-155)
-#else
-#define SIZEOF_PDE_INLINE_NAME	(128-95)
-#endif
-	char inline_name[SIZEOF_PDE_INLINE_NAME];
+	char inline_name[];
 } __randomize_layout;
 
+#define OFFSETOF_PDE_NAME offsetof(struct proc_dir_entry, inline_name)
+#define SIZEOF_PDE_SLOT					\
+	(OFFSETOF_PDE_NAME + 34 <= 64 ? 64 :		\
+	 OFFSETOF_PDE_NAME + 34 <= 128 ? 128 :		\
+	 OFFSETOF_PDE_NAME + 34 <= 192 ? 192 :		\
+	 OFFSETOF_PDE_NAME + 34 <= 256 ? 256 :		\
+	 OFFSETOF_PDE_NAME + 34 <= 512 ? 512 :		\
+	 0)
+
+#define SIZEOF_PDE_INLINE_NAME (SIZEOF_PDE_SLOT - OFFSETOF_PDE_NAME)
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index a379edccd880..efbdc08a3c86 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -288,8 +288,7 @@ struct proc_dir_entry proc_root = {
 	.proc_fops	= &proc_root_operations,
 	.parent		= &proc_root,
 	.subdir		= RB_ROOT,
-	.name		= proc_root.inline_name,
-	.inline_name	= "/proc",
+	.name		= "/proc",
 };
 
 int pid_ns_prepare_proc(struct pid_namespace *ns)

