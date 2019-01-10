Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4682173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfAJKMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:12:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49613 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfAJKMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:12:37 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghXKF-0003id-6O; Thu, 10 Jan 2019 11:12:35 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <ore@pengutronix.de>)
        id 1ghXKE-0002UP-1a; Thu, 10 Jan 2019 11:12:34 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Steven Walter <stevenrwalter@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] drivers/tty: convert tty_port to use kthread_worker
Date:   Thu, 10 Jan 2019 11:12:31 +0100
Message-Id: <20190110101232.9398-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110101232.9398-1-o.rempel@pengutronix.de>
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Walter <stevenrwalter@gmail.com>

Use kthread_worker instead of workqueues.  For now there is only a
single workqueue, but the intention is to bring back the "low_latency"
tty option, along with a second high-priority kthread worker.

Even without a second worker this patch allows to give a higher priority
to tty processing by modifying the priority of the corresponding
kthread.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/tty/tty_buffer.c | 21 ++++++++++++++-------
 drivers/tty/tty_io.c     |  1 +
 include/linux/tty.h      |  7 ++++---
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index e0090e65d83a..18bd7f48a319 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/kthread.h>
 #include <linux/errno.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
@@ -497,7 +498,7 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
  *		 'consumer'
  */
 
-static void flush_to_ldisc(struct work_struct *work)
+static void flush_to_ldisc(struct kthread_work *work)
 {
 	struct tty_port *port = container_of(work, struct tty_port, buf.work);
 	struct tty_bufhead *buf = &port->buf;
@@ -557,10 +558,16 @@ void tty_flip_buffer_push(struct tty_port *port)
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
+static DEFINE_KTHREAD_WORKER(tty_buffer_worker);
+
 bool tty_buffer_queue_work(struct tty_port *port)
 {
-	struct tty_bufhead *buf = &port->buf;
-	return schedule_work(&buf->work);
+	return kthread_queue_work(&tty_buffer_worker, &port->buf.work);
+}
+
+void tty_buffer_init_kthread(void)
+{
+	kthread_run(kthread_worker_fn, &tty_buffer_worker, "tty");
 }
 
 /**
@@ -582,7 +589,7 @@ void tty_buffer_init(struct tty_port *port)
 	init_llist_head(&buf->free);
 	atomic_set(&buf->mem_used, 0);
 	atomic_set(&buf->priority, 0);
-	INIT_WORK(&buf->work, flush_to_ldisc);
+	kthread_init_work(&buf->work, flush_to_ldisc);
 	buf->mem_limit = TTYB_DEFAULT_MEM_LIMIT;
 }
 
@@ -614,12 +621,12 @@ bool tty_buffer_restart_work(struct tty_port *port)
 	return tty_buffer_queue_work(port);
 }
 
-bool tty_buffer_cancel_work(struct tty_port *port)
+void tty_buffer_cancel_work(struct tty_port *port)
 {
-	return cancel_work_sync(&port->buf.work);
+	tty_buffer_flush_work(port);
 }
 
 void tty_buffer_flush_work(struct tty_port *port)
 {
-	flush_work(&port->buf.work);
+	kthread_flush_work(&port->buf.work);
 }
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index bfe9ad85b362..5fd7cecbe4e7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3476,6 +3476,7 @@ void console_sysfs_notify(void)
  */
 int __init tty_init(void)
 {
+	tty_buffer_init_kthread();
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 226a9eff0766..924c1093967e 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -3,9 +3,9 @@
 #define _LINUX_TTY_H
 
 #include <linux/fs.h>
+#include <linux/kthread.h>
 #include <linux/major.h>
 #include <linux/termios.h>
-#include <linux/workqueue.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
 #include <linux/mutex.h>
@@ -84,7 +84,7 @@ static inline char *flag_buf_ptr(struct tty_buffer *b, int ofs)
 
 struct tty_bufhead {
 	struct tty_buffer *head;	/* Queue head */
-	struct work_struct work;
+	struct kthread_work work;
 	struct mutex	   lock;
 	atomic_t	   priority;
 	struct tty_buffer sentinel;
@@ -510,8 +510,9 @@ extern void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld);
 extern bool tty_buffer_queue_work(struct tty_port *port);
 extern void tty_buffer_init(struct tty_port *port);
 extern void tty_buffer_set_lock_subclass(struct tty_port *port);
+extern void tty_buffer_init_kthread(void);
 extern bool tty_buffer_restart_work(struct tty_port *port);
-extern bool tty_buffer_cancel_work(struct tty_port *port);
+extern void tty_buffer_cancel_work(struct tty_port *port);
 extern void tty_buffer_flush_work(struct tty_port *port);
 extern speed_t tty_termios_baud_rate(struct ktermios *termios);
 extern speed_t tty_termios_input_baud_rate(struct ktermios *termios);
-- 
2.19.1

