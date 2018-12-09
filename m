Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA85C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A58620855
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A58620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeLISfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:35:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbeLISfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:35:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FCFF406E8A9;
        Sun,  9 Dec 2018 18:35:51 +0000 (UTC)
Received: from master.localdomain.com (unknown [10.64.242.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3086E2027047;
        Sun,  9 Dec 2018 18:35:49 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yamato@redhat.com
Subject: [PATCH resend] eventfd: make eventfd files distinguishable in /proc/$PID/fd
Date:   Mon, 10 Dec 2018 03:35:46 +0900
Message-Id: <20181209183546.5550-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sun, 09 Dec 2018 18:35:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sun, 09 Dec 2018 18:35:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding endpoints of an IPC channel is one of essential task to
understand how a user program works. Procfs and netlink socket provide
enough hints to find endpoints for IPC channels like pipes, unix
sockets, and pseudo terminals. However, there is no simple way to find
endpoints for an eventfd file from userland. An inode number doesn't
hint. Unlike pipe, all eventfd files shares one inode object.

To provide the way to find endpoints of an eventfd file, this patch
adds eventfd identifiers to the output of 'ls -l /proc/$pid/fd' like:

  ...
  lrwx------. 1 qemu qemu 64 May 20 04:49 93 -> 'anon_inode:[eventfd:130]'
  lrwx------. 1 qemu qemu 64 May 20 04:49 94 -> 'anon_inode:[eventfd:131]'
  ...

Here "130" and "131" are added as identifiers newly added.
In the case that ida_simple_get returns an error, this change doesn't add
an identifier; just use "[eventfd]" as before.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 fs/eventfd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 08d3bd602f73..c18952948110 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -21,6 +21,11 @@
 #include <linux/eventfd.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/idr.h>
+
+/* Worst case buffer size needed for holding an integer. */
+#define ITOA_MAX_LEN 12
+DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
 	struct kref kref;
@@ -35,6 +40,7 @@ struct eventfd_ctx {
 	 */
 	__u64 count;
 	unsigned int flags;
+	int id;
 };
 
 /**
@@ -69,6 +75,8 @@ EXPORT_SYMBOL_GPL(eventfd_signal);
 
 static void eventfd_free_ctx(struct eventfd_ctx *ctx)
 {
+	if (ctx->id >= 0)
+		ida_simple_remove(&eventfd_ida, ctx->id);
 	kfree(ctx);
 }
 
@@ -384,6 +392,7 @@ static int do_eventfd(unsigned int count, int flags)
 {
 	struct eventfd_ctx *ctx;
 	int fd;
+	char name[1 + 8 + ITOA_MAX_LEN + 1 + 1] = "[eventfd]";
 
 	/* Check the EFD_* constants for consistency.  */
 	BUILD_BUG_ON(EFD_CLOEXEC != O_CLOEXEC);
@@ -400,8 +409,11 @@ static int do_eventfd(unsigned int count, int flags)
 	init_waitqueue_head(&ctx->wqh);
 	ctx->count = count;
 	ctx->flags = flags;
+	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
 
-	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
+	if (ctx->id >= 0)
+		snprintf(name, sizeof(name), "[eventfd:%d]", ctx->id);
+	fd = anon_inode_getfd(name, &eventfd_fops, ctx,
 			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
 	if (fd < 0)
 		eventfd_free_ctx(ctx);
-- 
2.17.0

