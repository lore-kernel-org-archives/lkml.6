Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CBDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465DE20811
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465DE20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeKQDbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:31:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbeKQDbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:31:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26ADB3082AFA;
        Fri, 16 Nov 2018 17:18:04 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A58F5D759;
        Fri, 16 Nov 2018 17:17:59 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH] audit: remove WATCH and TREE config options
Date:   Fri, 16 Nov 2018 12:17:35 -0500
Message-Id: <a00bbc558e81d18cb9d36211fa2e2aee033aa191.1542218518.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 16 Nov 2018 17:18:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CONFIG_AUDIT_WATCH and CONFIG_AUDIT_TREE config options since
they are both dependent on CONFIG_AUDITSYSCALL and force
CONFIG_FSNOTIFY.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 init/Kconfig     |  9 ---------
 kernel/Makefile  |  4 +---
 kernel/audit.h   |  6 +++---
 kernel/auditsc.c | 10 ----------
 4 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a4112e95724a..7eb2538e6ca0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -335,15 +335,6 @@ config HAVE_ARCH_AUDITSYSCALL
 config AUDITSYSCALL
 	def_bool y
 	depends on AUDIT && HAVE_ARCH_AUDITSYSCALL
-
-config AUDIT_WATCH
-	def_bool y
-	depends on AUDITSYSCALL
-	select FSNOTIFY
-
-config AUDIT_TREE
-	def_bool y
-	depends on AUDITSYSCALL
 	select FSNOTIFY
 
 source "kernel/irq/Kconfig"
diff --git a/kernel/Makefile b/kernel/Makefile
index 7343b3a9bff0..9dc7f519129d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -76,9 +76,7 @@ obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_SMP) += stop_machine.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
-obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
-obj-$(CONFIG_AUDIT_WATCH) += audit_watch.o audit_fsnotify.o
-obj-$(CONFIG_AUDIT_TREE) += audit_tree.o
+obj-$(CONFIG_AUDITSYSCALL) += auditsc.o audit_watch.o audit_fsnotify.o audit_tree.o
 obj-$(CONFIG_GCOV_KERNEL) += gcov/
 obj-$(CONFIG_KCOV) += kcov.o
 obj-$(CONFIG_KPROBES) += kprobes.o
diff --git a/kernel/audit.h b/kernel/audit.h
index 9a3828bd387b..0b5295aeaebb 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -268,7 +268,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 extern void audit_put_tty(struct tty_struct *tty);
 
 /* audit watch functions */
-#ifdef CONFIG_AUDIT_WATCH
+#ifdef CONFIG_AUDITSYSCALL
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
 extern int audit_to_watch(struct audit_krule *krule, char *path, int len, u32 op);
@@ -301,9 +301,9 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 #define audit_mark_compare(m, i, d) 0
 #define audit_exe_compare(t, m) (-EINVAL)
 #define audit_dupe_exe(n, o) (-EINVAL)
-#endif /* CONFIG_AUDIT_WATCH */
+#endif /* CONFIG_AUDITSYSCALL */
 
-#ifdef CONFIG_AUDIT_TREE
+#ifdef CONFIG_AUDITSYSCALL
 extern struct audit_chunk *audit_tree_lookup(const struct inode *inode);
 extern void audit_put_chunk(struct audit_chunk *chunk);
 extern bool audit_tree_match(struct audit_chunk *chunk, struct audit_tree *tree);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 1513873e23bd..605f2d825204 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -200,7 +200,6 @@ static int audit_match_filetype(struct audit_context *ctx, int val)
  * References in it _are_ dropped - at the same time we free/drop aux stuff.
  */
 
-#ifdef CONFIG_AUDIT_TREE
 static void audit_set_auditable(struct audit_context *ctx)
 {
 	if (!ctx->prio) {
@@ -245,12 +244,10 @@ static int grow_tree_refs(struct audit_context *ctx)
 	ctx->tree_count = 31;
 	return 1;
 }
-#endif
 
 static void unroll_tree_refs(struct audit_context *ctx,
 		      struct audit_tree_refs *p, int count)
 {
-#ifdef CONFIG_AUDIT_TREE
 	struct audit_tree_refs *q;
 	int n;
 	if (!p) {
@@ -274,7 +271,6 @@ static void unroll_tree_refs(struct audit_context *ctx,
 	}
 	ctx->trees = p;
 	ctx->tree_count = count;
-#endif
 }
 
 static void free_tree_refs(struct audit_context *ctx)
@@ -288,7 +284,6 @@ static void free_tree_refs(struct audit_context *ctx)
 
 static int match_tree_refs(struct audit_context *ctx, struct audit_tree *tree)
 {
-#ifdef CONFIG_AUDIT_TREE
 	struct audit_tree_refs *p;
 	int n;
 	if (!tree)
@@ -305,7 +300,6 @@ static int match_tree_refs(struct audit_context *ctx, struct audit_tree *tree)
 			if (audit_tree_match(p->c[n], tree))
 				return 1;
 	}
-#endif
 	return 0;
 }
 
@@ -1602,7 +1596,6 @@ void __audit_syscall_exit(int success, long return_code)
 
 static inline void handle_one(const struct inode *inode)
 {
-#ifdef CONFIG_AUDIT_TREE
 	struct audit_context *context;
 	struct audit_tree_refs *p;
 	struct audit_chunk *chunk;
@@ -1627,12 +1620,10 @@ static inline void handle_one(const struct inode *inode)
 		return;
 	}
 	put_tree_ref(context, chunk);
-#endif
 }
 
 static void handle_path(const struct dentry *dentry)
 {
-#ifdef CONFIG_AUDIT_TREE
 	struct audit_context *context;
 	struct audit_tree_refs *p;
 	const struct dentry *d, *parent;
@@ -1685,7 +1676,6 @@ static void handle_path(const struct dentry *dentry)
 		return;
 	}
 	rcu_read_unlock();
-#endif
 }
 
 static struct audit_names *audit_alloc_name(struct audit_context *context,
-- 
1.8.3.1

