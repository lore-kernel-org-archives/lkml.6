Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159B6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79AC2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfAJKMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:12:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47069 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfAJKMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:12:37 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghXKF-0003ie-6H; Thu, 10 Jan 2019 11:12:35 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <ore@pengutronix.de>)
        id 1ghXKE-0002UY-2L; Thu, 10 Jan 2019 11:12:34 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] drivers/tty: increase priority for tty_buffer_worker
Date:   Thu, 10 Jan 2019 11:12:32 +0100
Message-Id: <20190110101232.9398-4-o.rempel@pengutronix.de>
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

sched_priority = 1 is enough to dramatically reduce latency
on have system load produced by tasks with default user space prio.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/tty/tty_buffer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 18bd7f48a319..7cf42f6570a0 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -13,11 +13,13 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/sched/rt.h>
 #include <linux/wait.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/ratelimit.h>
+#include <uapi/linux/sched/types.h>
 
 
 #define MIN_TTYB_SIZE	256
@@ -567,7 +569,15 @@ bool tty_buffer_queue_work(struct tty_port *port)
 
 void tty_buffer_init_kthread(void)
 {
-	kthread_run(kthread_worker_fn, &tty_buffer_worker, "tty");
+	struct sched_param param = { .sched_priority = 1 };
+	struct task_struct *kworker_task;
+
+	kworker_task = kthread_run(kthread_worker_fn, &tty_buffer_worker, "tty");
+	if (IS_ERR(kworker_task)) {
+		pr_err("failed to create message pump task\n");
+		return;
+	}
+	sched_setscheduler(kworker_task, SCHED_FIFO, &param);
 }
 
 /**
-- 
2.19.1

