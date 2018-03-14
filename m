Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCNVgg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:36:36 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34209 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCNVgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:36:35 -0400
X-Google-Smtp-Source: AG47ELtE+erruIBDQFcxIBSgZdhdjIydBJNG5HB6QpcANPOcr4xY1zQC+5EMU6Yb8+6aqIHJAUp9TQ==
From: Sonny Rao <sonnyrao@chromium.org>
To: kvm@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost: add vsock compat ioctl
Date: Wed, 14 Mar 2018 14:36:25 -0700
Message-Id: <20180314213625.119211-1-sonnyrao@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow usage of vsock from 32-bit binaries on a 64-bit
kernel.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
 drivers/vhost/vsock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0d14e2ff19f16..ee0c385d9fe54 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -699,12 +699,23 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 	}
 }
 
+#ifdef CONFIG_COMPAT
+static long vhost_vsock_dev_compat_ioctl(struct file *f, unsigned int ioctl,
+					 unsigned long arg)
+{
+	return vhost_vsock_dev_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static const struct file_operations vhost_vsock_fops = {
 	.owner          = THIS_MODULE,
 	.open           = vhost_vsock_dev_open,
 	.release        = vhost_vsock_dev_release,
 	.llseek		= noop_llseek,
 	.unlocked_ioctl = vhost_vsock_dev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = vhost_vsock_dev_compat_ioctl,
+#endif
 };
 
 static struct miscdevice vhost_vsock_misc = {
-- 
2.13.5
