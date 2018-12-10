Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D569BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9889F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9889F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeLJRNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:13:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbeLJRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78234804E0;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73E045D717;
        Mon, 10 Dec 2018 17:13:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0AE38223A08; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 02/52] fuse: add probe/remove virtio driver
Date:   Mon, 10 Dec 2018 12:12:28 -0500
Message-Id: <20181210171318.16998-3-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Add basic probe/remove functionality for the new virtio-fs device.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/Kconfig                 |   1 +
 fs/fuse/virtio_fs.c             | 160 ++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_fs.h  |  41 ++++++++++
 include/uapi/linux/virtio_ids.h |   1 +
 4 files changed, 195 insertions(+), 8 deletions(-)
 create mode 100644 include/uapi/linux/virtio_fs.h

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 0b1375126420..46e9a8ff9f7a 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -30,6 +30,7 @@ config CUSE
 config VIRTIO_FS
 	tristate "Virtio Filesystem"
 	depends on FUSE_FS
+	select VIRTIO
 	help
 	  The Virtio Filesystem allows guests to mount file systems from the
           host.
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6b7d3973bd85..aac9c3c42827 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -4,13 +4,139 @@
  * Copyright (C) 2018 Red Hat, Inc.
  */
 
-#include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/virtio.h>
+#include <linux/virtio_fs.h>
 
-MODULE_AUTHOR("Stefan Hajnoczi <stefanha@redhat.com>");
-MODULE_DESCRIPTION("Virtio Filesystem");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_FS(KBUILD_MODNAME);
+/* List of virtio-fs device instances and a lock for the list */
+static DEFINE_MUTEX(virtio_fs_mutex);
+static LIST_HEAD(virtio_fs_instances);
+
+/* A virtio-fs device instance */
+struct virtio_fs {
+	struct list_head list; /* on virtio_fs_instances */
+	char *tag;
+};
+
+/* Add a new instance to the list or return -EEXIST if tag name exists*/
+static int virtio_fs_add_instance(struct virtio_fs *fs)
+{
+	struct virtio_fs *fs2;
+	bool duplicate = false;
+
+	mutex_lock(&virtio_fs_mutex);
+
+	list_for_each_entry(fs2, &virtio_fs_instances, list) {
+		if (strcmp(fs->tag, fs2->tag) == 0)
+			duplicate = true;
+	}
+
+	if (!duplicate)
+		list_add_tail(&fs->list, &virtio_fs_instances);
+
+	mutex_unlock(&virtio_fs_mutex);
+
+	if (duplicate)
+		return -EEXIST;
+	return 0;
+}
+
+/* Read filesystem name from virtio config into fs->tag (must kfree()). */
+static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
+{
+	char tag_buf[sizeof_field(struct virtio_fs_config, tag)];
+	char *end;
+	size_t len;
+
+	virtio_cread_bytes(vdev, offsetof(struct virtio_fs_config, tag),
+			   &tag_buf, sizeof(tag_buf));
+	end = memchr(tag_buf, '\0', sizeof(tag_buf));
+	if (end == tag_buf)
+		return -EINVAL; /* empty tag */
+	if (!end)
+		end = &tag_buf[sizeof(tag_buf)];
+
+	len = end - tag_buf;
+	fs->tag = devm_kmalloc(&vdev->dev, len + 1, GFP_KERNEL);
+	if (!fs->tag)
+		return -ENOMEM;
+	memcpy(fs->tag, tag_buf, len);
+	fs->tag[len] = '\0';
+	return 0;
+}
+
+static int virtio_fs_probe(struct virtio_device *vdev)
+{
+	struct virtio_fs *fs;
+	int ret;
+
+	fs = devm_kzalloc(&vdev->dev, sizeof(*fs), GFP_KERNEL);
+	if (!fs)
+		return -ENOMEM;
+	vdev->priv = fs;
+
+	ret = virtio_fs_read_tag(vdev, fs);
+	if (ret < 0)
+		goto out;
+
+	ret = virtio_fs_add_instance(fs);
+	if (ret < 0)
+		goto out;
+
+	return 0;
+
+out:
+	vdev->priv = NULL;
+	return ret;
+}
+
+static void virtio_fs_remove(struct virtio_device *vdev)
+{
+	struct virtio_fs *fs = vdev->priv;
+
+	vdev->config->reset(vdev);
+
+	mutex_lock(&virtio_fs_mutex);
+	list_del(&fs->list);
+	mutex_unlock(&virtio_fs_mutex);
+
+	vdev->priv = NULL;
+}
+
+#ifdef CONFIG_PM
+static int virtio_fs_freeze(struct virtio_device *vdev)
+{
+	return 0; /* TODO */
+}
+
+static int virtio_fs_restore(struct virtio_device *vdev)
+{
+	return 0; /* TODO */
+}
+#endif /* CONFIG_PM */
+
+const static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_FS, VIRTIO_DEV_ANY_ID },
+	{},
+};
+
+const static unsigned int feature_table[] = {};
+
+static struct virtio_driver virtio_fs_driver = {
+	.driver.name		= KBUILD_MODNAME,
+	.driver.owner		= THIS_MODULE,
+	.id_table		= id_table,
+	.feature_table		= feature_table,
+	.feature_table_size	= ARRAY_SIZE(feature_table),
+	/* TODO validate config_get != NULL */
+	.probe			= virtio_fs_probe,
+	.remove			= virtio_fs_remove,
+#ifdef CONFIG_PM_SLEEP
+	.freeze			= virtio_fs_freeze,
+	.restore		= virtio_fs_restore,
+#endif
+};
 
 static struct file_system_type virtio_fs_type = {
 	.owner		= THIS_MODULE,
@@ -21,13 +147,31 @@ static struct file_system_type virtio_fs_type = {
 
 static int __init virtio_fs_init(void)
 {
-	return register_filesystem(&virtio_fs_type);
+	int ret;
+
+	ret = register_virtio_driver(&virtio_fs_driver);
+	if (ret < 0)
+		return ret;
+
+	ret = register_filesystem(&virtio_fs_type);
+	if (ret < 0) {
+		unregister_virtio_driver(&virtio_fs_driver);
+		return ret;
+	}
+
+	return 0;
 }
+module_init(virtio_fs_init);
 
 static void __exit virtio_fs_exit(void)
 {
 	unregister_filesystem(&virtio_fs_type);
+	unregister_virtio_driver(&virtio_fs_driver);
 }
-
-module_init(virtio_fs_init);
 module_exit(virtio_fs_exit);
+
+MODULE_AUTHOR("Stefan Hajnoczi <stefanha@redhat.com>");
+MODULE_DESCRIPTION("Virtio Filesystem");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_FS(KBUILD_MODNAME);
+MODULE_DEVICE_TABLE(virtio, id_table);
diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
new file mode 100644
index 000000000000..48f3590dcfbe
--- /dev/null
+++ b/include/uapi/linux/virtio_fs.h
@@ -0,0 +1,41 @@
+#ifndef _UAPI_LINUX_VIRTIO_FS_H
+#define _UAPI_LINUX_VIRTIO_FS_H
+/* This header is BSD licensed so anyone can use the definitions to implement
+ * compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE. */
+#include <linux/types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_types.h>
+
+struct virtio_fs_config {
+	/* Filesystem name (UTF-8, not NUL-terminated, padded with NULs) */
+	__u8 tag[36];
+
+	/* Number of request queues */
+	__u32 num_queues;
+} __attribute__((packed));
+
+#endif /* _UAPI_LINUX_VIRTIO_FS_H */
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 6d5c3b2d4f4d..884b0e2734bb 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -43,5 +43,6 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_FS           26 /* virtio filesystem */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.13.6

