Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1863ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4814A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4814A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbeGWQ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:28:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387831AbeGWQ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:28:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DCCA81A4EAF;
        Mon, 23 Jul 2018 15:26:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 553872026D65;
        Mon, 23 Jul 2018 15:26:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/5] Add sample notification program
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, raven@themaw.net,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Mon, 23 Jul 2018 16:26:18 +0100
Message-ID: <153235957887.32640.8025222191782276269.stgit@warthog.procyon.org.uk>
In-Reply-To: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
References: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 23 Jul 2018 15:26:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 23 Jul 2018 15:26:20 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This needs to be linked with -lkeyutils.

It is run like:

	./watch_test

and watches "/" for mount changes and the current session keyring for key
changes:

	# keyctl add user a a @s
	1035096409
	# keyctl unlink 1035096409 @s
	# mount -t tmpfs none /mnt/nfsv3tcp/
	# umount /mnt/nfsv3tcp

producing:

	# ./watch_test
	ptrs h=4 t=2 m=20003
	NOTIFY[00000004-00000002] ty=0003 sy=0002 i=01000010
	KEY 2ffc2e5d change=2[linked] aux=1035096409
	ptrs h=6 t=4 m=20003
	NOTIFY[00000006-00000004] ty=0003 sy=0003 i=01000010
	KEY 2ffc2e5d change=3[unlinked] aux=1035096409
	ptrs h=8 t=6 m=20003
	NOTIFY[00000008-00000006] ty=0001 sy=0000 i=02000010
	MOUNT 00000013 change=0[new_mount] aux=168
	ptrs h=a t=8 m=20003
	NOTIFY[0000000a-00000008] ty=0001 sy=0001 i=02000010
	MOUNT 00000013 change=1[unmount] aux=168
---

 samples/Kconfig                  |    6 +
 samples/Makefile                 |    2 
 samples/watch_queue/Makefile     |    9 +
 samples/watch_queue/watch_test.c |  232 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 1c5658bc6224..dac30cefe895 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -156,4 +156,10 @@ config SAMPLE_MOUNT_API
 	help
 	  Build example userspace program(s) that use the new mount API.
 
+config SAMPLE_WATCH_QUEUE
+	bool "Build example /dev/watch_queue notification consumer"
+	help
+	  Build example userspace program to use the new mount_notify(),
+	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index 31d08cc71a5c..ed545cbf65c8 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ \
-			   vfio-mdev/ statx/ qmi/ mount_api/
+			   vfio-mdev/ statx/ qmi/ mount_api/ watch_queue/
diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
new file mode 100644
index 000000000000..1f20ee2b0add
--- /dev/null
+++ b/samples/watch_queue/Makefile
@@ -0,0 +1,9 @@
+# List of programs to build
+hostprogs-$(CONFIG_SAMPLE_WATCH_QUEUE) := watch_test
+
+# Tell kbuild to always build the programs
+always := $(hostprogs-y)
+
+HOSTCFLAGS_watch_test.o += -I$(objtree)/usr/include
+
+HOSTLOADLIBES_watch_test += -lkeyutils
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
new file mode 100644
index 000000000000..cdbaaf5a1163
--- /dev/null
+++ b/samples/watch_queue/watch_test.c
@@ -0,0 +1,232 @@
+/* Use /dev/watch_queue to watch for keyring and mount topology changes.
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <stdbool.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <errno.h>
+#include <sys/wait.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <poll.h>
+#include <limits.h>
+#include <linux/watch_queue.h>
+#include <linux/unistd.h>
+#include <linux/keyctl.h>
+
+#define BUF_SIZE 4
+
+static const char *key_subtypes[] = {
+	[notify_key_instantiated]	= "instantiated",
+	[notify_key_updated]		= "updated",
+	[notify_key_linked]		= "linked",
+	[notify_key_unlinked]		= "unlinked",
+	[notify_key_cleared]		= "cleared",
+	[notify_key_revoked]		= "revoked",
+	[notify_key_invalidated]	= "invalidated",
+	[notify_key_setattr]		= "setattr",
+};
+
+static void saw_key_change(struct watch_notification *n)
+{
+	struct key_notification *k = (struct key_notification *)n;
+	unsigned int len = n->info & WATCH_INFO_LENGTH;
+
+	if (len != sizeof(struct key_notification))
+		return;
+
+	printf("KEY %08x change=%u[%s] aux=%u\n",
+	       k->key_id, n->subtype, key_subtypes[n->subtype], k->aux);
+}
+
+static const char *mount_subtypes[] = {
+	[notify_mount_new_mount]	= "new_mount",
+	[notify_mount_unmount]		= "unmount",
+	[notify_mount_expiry]		= "expiry",
+	[notify_mount_readonly]		= "readonly",
+	[notify_mount_setattr]		= "setattr",
+	[notify_mount_move_from]	= "move_from",
+	[notify_mount_move_to]		= "move_to",
+};
+
+static long keyctl_watch_key(int key, int watch_fd, int watch_id)
+{
+	return syscall(__NR_keyctl, KEYCTL_WATCH_KEY, key, watch_fd, watch_id);
+}
+
+static void saw_mount_change(struct watch_notification *n)
+{
+	struct mount_notification *m = (struct mount_notification *)n;
+	unsigned int len = n->info & WATCH_INFO_LENGTH;
+
+	if (len != sizeof(struct mount_notification))
+		return;
+
+	printf("MOUNT %08x change=%u[%s] aux=%u\n",
+	       m->triggered_on, n->subtype, mount_subtypes[n->subtype], m->changed_mount);
+}
+
+static const char *super_subtypes[] = {
+	[notify_superblock_readonly]	= "readonly",
+	[notify_superblock_error]	= "error",
+	[notify_superblock_edquot]	= "edquot",
+	[notify_superblock_network]	= "network",
+};
+
+static void saw_super_change(struct watch_notification *n)
+{
+	struct superblock_notification *s = (struct superblock_notification *)n;
+	unsigned int len = n->info & WATCH_INFO_LENGTH;
+
+	if (len < sizeof(struct superblock_notification))
+		return;
+
+	printf("SUPER %08llx change=%u[%s]\n",
+	       s->sb_id, n->subtype, super_subtypes[n->subtype]);
+}
+
+/*
+ * Consume and display events.
+ */
+static int consumer(int fd, struct watch_queue_buffer *buf)
+{
+	struct watch_notification *n;
+	struct pollfd p[1];
+	unsigned int head, tail, mask = buf->meta.mask;
+
+	for (;;) {
+		p[0].fd = fd;
+		p[0].events = POLLIN | POLLERR;
+		p[0].revents = 0;
+
+		if (poll(p, 1, -1) == -1) {
+			perror("poll");
+			break;
+		}
+
+		printf("ptrs h=%x t=%x m=%x\n",
+		       buf->meta.head, buf->meta.tail, buf->meta.mask);
+
+		while (head = buf->meta.head,
+		       tail = buf->meta.tail,
+		       tail != head
+		       ) {
+			asm ("lfence" : : : "memory" );
+			n = &buf->slots[tail & mask];
+			printf("NOTIFY[%08x-%08x] ty=%04x sy=%04x i=%08x\n",
+			       head, tail, n->type, n->subtype, n->info);
+			if ((n->info & WATCH_INFO_LENGTH) == 0)
+				goto out;
+
+			switch (n->type) {
+			case WATCH_TYPE_META:
+				if (n->subtype == watch_meta_removal_notification)
+					printf("REMOVAL of watchpoint %08x\n",
+					       n->info & WATCH_INFO_ID);
+				break;
+			case WATCH_TYPE_MOUNT_NOTIFY:
+				saw_mount_change(n);
+				break;
+			case WATCH_TYPE_SB_NOTIFY:
+				saw_super_change(n);
+				break;
+			case WATCH_TYPE_KEY_NOTIFY:
+				saw_key_change(n);
+				break;
+			}
+
+			tail += (n->info & WATCH_INFO_LENGTH) >> WATCH_LENGTH_SHIFT;
+			asm("mfence" ::: "memory");
+			buf->meta.tail = tail;
+		}
+	}
+
+out:
+	return 0;
+}
+
+static struct watch_notification_filter filter = {
+	.nr_filters	= 3,
+	.__reserved	= 0,
+	.filters = {
+		[0] = {
+			.type			= WATCH_TYPE_MOUNT_NOTIFY,
+			// Reject move-from notifications
+			.subtype_filter[0]	= UINT_MAX & ~(1 << notify_mount_move_from),
+		},
+		[1]	= {
+			.type			= WATCH_TYPE_SB_NOTIFY,
+			// Only accept notification of changes to R/O state
+			.subtype_filter[0]	= (1 << notify_superblock_readonly),
+			// Only accept notifications of change-to-R/O
+			.info_mask		= WATCH_INFO_FLAG_0,
+			.info_filter		= WATCH_INFO_FLAG_0,
+		},
+		[2]	= {
+			.type			= WATCH_TYPE_KEY_NOTIFY,
+			.subtype_filter[0]	= UINT_MAX,
+		},
+	},
+};
+
+int main(int argc, char **argv)
+{
+	struct watch_queue_buffer *buf;
+	size_t page_size;
+	int fd;
+
+	fd = open("/dev/watch_queue", O_RDWR);
+	if (fd == -1) {
+		perror("/dev/watch_queue");
+		exit(1);
+	}
+
+	if (ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE) == -1) {
+		perror("/dev/watch_queue(size)");
+		exit(1);
+	}
+
+	if (ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter) == -1) {
+		perror("/dev/watch_queue(filter)");
+		exit(1);
+	}
+
+	page_size = sysconf(_SC_PAGESIZE);
+	buf = mmap(NULL, BUF_SIZE * page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, fd, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	if (keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01) == -1) {
+		perror("keyctl");
+		exit(1);
+	}
+
+	if (syscall(__NR_mount_notify, AT_FDCWD, "/", 0, fd, 0x02) == -1) {
+		perror("mount_notify");
+		exit(1);
+	}
+
+	if (syscall(__NR_sb_notify, AT_FDCWD, "/mnt", 0, fd, 0x03) == -1) {
+		perror("sb_notify");
+		exit(1);
+	}
+
+	return consumer(fd, buf);
+}

