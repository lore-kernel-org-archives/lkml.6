Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbeCNRFQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:05:16 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36715 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbeCNRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:05:12 -0400
X-Google-Smtp-Source: AG47ELu53CL2qmprMR+P519rINolEpM4TDbzp0VlyFyCKDl0s4YBlTcMbDBF28iPSFtOHOm+LvBsww==
From: Sonny Rao <sonnyrao@chromium.org>
To: kvm@vger.kernel.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: fix vhost ioctl signature to build with clang
Date: Wed, 14 Mar 2018 10:05:06 -0700
Message-Id: <20180314170506.121791-1-sonnyrao@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang is particularly anal about signed vs unsigned comparisons and
doesn't like the fact that some ioctl numbers set the MSB, so we get
this error when trying to build vhost on aarch64:

drivers/vhost/vhost.c:1400:7: error: overflow converting case value to
 switch condition type (3221794578 to 18446744072636378898)
 [-Werror, -Wswitch]
        case VHOST_GET_VRING_BASE:

3221794578 is 0xC008AF12 in hex
18446744072636378898 is 0xFFFFFFFFC008AF12 in hex

Fix this by using unsigned ints in the function signature for
vhost_vring_ioctl().

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
 drivers/vhost/vhost.c | 2 +-
 drivers/vhost/vhost.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1b3e8d2d5c8b4..5316319d84081 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1337,7 +1337,7 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
 	return -EFAULT;
 }
 
-long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp)
+long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 {
 	struct file *eventfp, *filep = NULL;
 	bool pollstart = false, pollstop = false;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index ac4b6056f19ae..d8ee85ae8fdcc 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -45,7 +45,7 @@ void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_flush(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
 void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work);
-long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
+long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
 
 struct vhost_log {
 	u64 addr;
@@ -177,7 +177,7 @@ void vhost_dev_reset_owner(struct vhost_dev *, struct vhost_umem *);
 void vhost_dev_cleanup(struct vhost_dev *);
 void vhost_dev_stop(struct vhost_dev *);
 long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
-long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
+long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
 int vhost_vq_access_ok(struct vhost_virtqueue *vq);
 int vhost_log_access_ok(struct vhost_dev *);
 
-- 
2.13.5
