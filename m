Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E194EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24CE2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24CE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeLJRNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:13:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbeLJRNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A1762D7F8;
        Mon, 10 Dec 2018 17:13:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D53A105B1E1;
        Mon, 10 Dec 2018 17:13:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 07D912239C4; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 01/52] fuse: add skeleton virtio_fs.ko module
Date:   Mon, 10 Dec 2018 12:12:27 -0500
Message-Id: <20181210171318.16998-2-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 10 Dec 2018 17:13:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Add a basic file system module for virtio-fs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/Kconfig     | 10 ++++++++++
 fs/fuse/Makefile    |  1 +
 fs/fuse/virtio_fs.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 fs/fuse/virtio_fs.c

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 76f09ce7e5b2..0b1375126420 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -26,3 +26,13 @@ config CUSE
 
 	  If you want to develop or use a userspace character device
 	  based on CUSE, answer Y or M.
+
+config VIRTIO_FS
+	tristate "Virtio Filesystem"
+	depends on FUSE_FS
+	help
+	  The Virtio Filesystem allows guests to mount file systems from the
+          host.
+
+	  If you want to share files between guests or with the host, answer Y
+          or M.
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index f7b807bc1027..47b78fac5809 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -4,5 +4,6 @@
 
 obj-$(CONFIG_FUSE_FS) += fuse.o
 obj-$(CONFIG_CUSE) += cuse.o
+obj-$(CONFIG_VIRTIO_FS) += virtio_fs.o
 
 fuse-objs := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
new file mode 100644
index 000000000000..6b7d3973bd85
--- /dev/null
+++ b/fs/fuse/virtio_fs.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * virtio-fs: Virtio Filesystem
+ * Copyright (C) 2018 Red Hat, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+
+MODULE_AUTHOR("Stefan Hajnoczi <stefanha@redhat.com>");
+MODULE_DESCRIPTION("Virtio Filesystem");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_FS(KBUILD_MODNAME);
+
+static struct file_system_type virtio_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= KBUILD_MODNAME,
+	.mount		= NULL,
+	.kill_sb	= NULL,
+};
+
+static int __init virtio_fs_init(void)
+{
+	return register_filesystem(&virtio_fs_type);
+}
+
+static void __exit virtio_fs_exit(void)
+{
+	unregister_filesystem(&virtio_fs_type);
+}
+
+module_init(virtio_fs_init);
+module_exit(virtio_fs_exit);
-- 
2.13.6

