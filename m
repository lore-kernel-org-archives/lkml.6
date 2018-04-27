Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757340AbeD0F2z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 01:28:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45505 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeD0F2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 01:28:53 -0400
X-Google-Smtp-Source: AB8JxZowp0dY6iB5wM1Jx/g756XvJX7CLHA/zgWfukXzx2ePz46MGPU5sjihbfZNw8OsuaNJ8VJ8Eg==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: "David S. Miller" <davem@davemloft.net>,
        Chris Lew <clew@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3] net: qrtr: Expose tunneling endpoint to user space
Date: Thu, 26 Apr 2018 22:28:49 -0700
Message-Id: <20180427052849.24899-1-bjorn.andersson@linaro.org>
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

Changes since v2:
- Add support for read poll

Changes since v1:
- Dropped queue lock

 net/qrtr/Kconfig  |   7 +++
 net/qrtr/Makefile |   2 +
 net/qrtr/tun.c    | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
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
index 000000000000..ccff1e544c21
--- /dev/null
+++ b/net/qrtr/tun.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Linaro Ltd */
+
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/skbuff.h>
+#include <linux/uaccess.h>
+
+#include "qrtr.h"
+
+struct qrtr_tun {
+	struct qrtr_endpoint ep;
+
+	struct sk_buff_head queue;
+	wait_queue_head_t readq;
+};
+
+static int qrtr_tun_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
+{
+	struct qrtr_tun *tun = container_of(ep, struct qrtr_tun, ep);
+
+	skb_queue_tail(&tun->queue, skb);
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
+	while (!(skb = skb_dequeue(&tun->queue))) {
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		/* Wait until we get data or the endpoint goes away */
+		if (wait_event_interruptible(tun->readq,
+					     !skb_queue_empty(&tun->queue)))
+			return -ERESTARTSYS;
+	}
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
+static __poll_t qrtr_tun_poll(struct file *filp, poll_table *wait)
+{
+	struct qrtr_tun *tun = filp->private_data;
+	__poll_t mask = 0;
+
+	poll_wait(filp, &tun->readq, wait);
+
+	if (!skb_queue_empty(&tun->queue))
+		mask |= EPOLLIN | EPOLLRDNORM;
+
+	return mask;
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
+	.poll = qrtr_tun_poll,
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
