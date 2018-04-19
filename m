Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeDSFDx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:03:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36781 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbeDSFDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:03:50 -0400
X-Google-Smtp-Source: AIpwx48PYz6FI5WpuFN9h/AOoE0CVq3OrVSZn5dbJcKl/9m2l8MbIdMcSBUJgvEPkRWsaYQylDoSYw==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Chris Lew <clew@codeaurora.org>
Subject: [PATCH] net: qrtr: Expose tunneling endpoint to user space
Date: Wed, 18 Apr 2018 22:03:46 -0700
Message-Id: <20180419050346.17054-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements a misc character device named "qrtr-tun" for the purpose
of allowing user space applications to implement endpoints in the qrtr
network.

This allows more advanced (and dynamic) testing of the qrtr code as well
as opens up the ability of tunneling qrtr over a network or USB link.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 net/qrtr/Kconfig  |   7 +++
 net/qrtr/Makefile |   2 +
 net/qrtr/tun.c    | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 net/qrtr/tun.c

diff --git a/net/qrtr/Kconfig b/net/qrtr/Kconfig
index 326fd97444f5..1944834d225c 100644
--- a/net/qrtr/Kconfig
+++ b/net/qrtr/Kconfig
@@ -21,4 +21,11 @@ config QRTR_SMD
 	  Say Y here to support SMD based ipcrouter channels.  SMD is the
 	  most common transport for IPC Router.
 
+config QRTR_TUN
+	tristate "TUN device for Qualcomm IPC Router"
+	---help---
+	  Say Y here to expose a character device that allows user space to
+	  implement endpoints of QRTR, for purpose of tunneling data to other
+	  hosts or testing purposes.
+
 endif # QRTR
diff --git a/net/qrtr/Makefile b/net/qrtr/Makefile
index ab09e40f7c74..be012bfd3e52 100644
--- a/net/qrtr/Makefile
+++ b/net/qrtr/Makefile
@@ -2,3 +2,5 @@ obj-$(CONFIG_QRTR) := qrtr.o
 
 obj-$(CONFIG_QRTR_SMD) += qrtr-smd.o
 qrtr-smd-y	:= smd.o
+obj-$(CONFIG_QRTR_TUN) += qrtr-tun.o
+qrtr-tun-y	:= tun.o
diff --git a/net/qrtr/tun.c b/net/qrtr/tun.c
new file mode 100644
index 000000000000..ab87a12cbb17
--- /dev/null
+++ b/net/qrtr/tun.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Linaro Ltd */
+
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/uaccess.h>
+
+#include "qrtr.h"
+
+struct qrtr_tun {
+	struct qrtr_endpoint ep;
+
+	struct mutex queue_lock;
+	struct sk_buff_head queue;
+	wait_queue_head_t readq;
+};
+
+static int qrtr_tun_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
+{
+	struct qrtr_tun *tun = container_of(ep, struct qrtr_tun, ep);
+
+	mutex_lock(&tun->queue_lock);
+	skb_queue_tail(&tun->queue, skb);
+	mutex_unlock(&tun->queue_lock);
+
+	/* wake up any blocking processes, waiting for new data */
+	wake_up_interruptible(&tun->readq);
+
+	return 0;
+}
+
+static int qrtr_tun_open(struct inode *inode, struct file *filp)
+{
+	struct qrtr_tun *tun;
+
+	tun = kzalloc(sizeof(*tun), GFP_KERNEL);
+	if (!tun)
+		return -ENOMEM;
+
+	mutex_init(&tun->queue_lock);
+	skb_queue_head_init(&tun->queue);
+	init_waitqueue_head(&tun->readq);
+
+	tun->ep.xmit = qrtr_tun_send;
+
+	filp->private_data = tun;
+
+	return qrtr_endpoint_register(&tun->ep, QRTR_EP_NID_AUTO);
+}
+
+static ssize_t qrtr_tun_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct file *filp = iocb->ki_filp;
+	struct qrtr_tun *tun = filp->private_data;
+	struct sk_buff *skb;
+	int count;
+
+	mutex_lock(&tun->queue_lock);
+
+	/* Wait for data in the queue */
+	if (skb_queue_empty(&tun->queue)) {
+		mutex_unlock(&tun->queue_lock);
+
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		/* Wait until we get data or the endpoint goes away */
+		if (wait_event_interruptible(tun->readq,
+					     !skb_queue_empty(&tun->queue)))
+			return -ERESTARTSYS;
+
+		mutex_lock(&tun->queue_lock);
+	}
+
+	skb = skb_dequeue(&tun->queue);
+	mutex_unlock(&tun->queue_lock);
+	if (!skb)
+		return -EFAULT;
+
+	count = min_t(size_t, iov_iter_count(to), skb->len);
+	if (copy_to_iter(skb->data, count, to) != count)
+		count = -EFAULT;
+
+	kfree_skb(skb);
+
+	return count;
+}
+
+static ssize_t qrtr_tun_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *filp = iocb->ki_filp;
+	struct qrtr_tun *tun = filp->private_data;
+	size_t len = iov_iter_count(from);
+	ssize_t ret;
+	void *kbuf;
+
+	kbuf = kzalloc(len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	if (!copy_from_iter_full(kbuf, len, from))
+		return -EFAULT;
+
+	ret = qrtr_endpoint_post(&tun->ep, kbuf, len);
+
+	return ret < 0 ? ret : len;
+}
+
+static int qrtr_tun_release(struct inode *inode, struct file *filp)
+{
+	struct qrtr_tun *tun = filp->private_data;
+	struct sk_buff *skb;
+
+	qrtr_endpoint_unregister(&tun->ep);
+
+	/* Discard all SKBs */
+	while (!skb_queue_empty(&tun->queue)) {
+		skb = skb_dequeue(&tun->queue);
+		kfree_skb(skb);
+	}
+
+	kfree(tun);
+
+	return 0;
+}
+
+static const struct file_operations qrtr_tun_ops = {
+	.owner = THIS_MODULE,
+	.open = qrtr_tun_open,
+	.read_iter = qrtr_tun_read_iter,
+	.write_iter = qrtr_tun_write_iter,
+	.release = qrtr_tun_release,
+};
+
+static struct miscdevice qrtr_tun_miscdev = {
+	MISC_DYNAMIC_MINOR,
+	"qrtr-tun",
+	&qrtr_tun_ops,
+};
+
+static int __init qrtr_tun_init(void)
+{
+	int ret;
+
+	ret = misc_register(&qrtr_tun_miscdev);
+	if (ret)
+		pr_err("failed to register Qualcomm IPC Router tun device\n");
+
+	return ret;
+}
+
+static void __exit qrtr_tun_exit(void)
+{
+	misc_deregister(&qrtr_tun_miscdev);
+}
+
+module_init(qrtr_tun_init);
+module_exit(qrtr_tun_exit);
+
+MODULE_DESCRIPTION("Qualcomm IPC Router TUN device");
+MODULE_LICENSE("GPL v2");
-- 
2.16.2
