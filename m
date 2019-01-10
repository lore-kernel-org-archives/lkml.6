Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0934DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DF1214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfAJKMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:12:47 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55883 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbfAJKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:12:38 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghXKF-0003ic-6P; Thu, 10 Jan 2019 11:12:35 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <ore@pengutronix.de>)
        id 1ghXKD-0002U9-Vx; Thu, 10 Jan 2019 11:12:33 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Steven Walter <stevenrwalter@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] drivers/tty: refactor functions for flushing/queuing work
Date:   Thu, 10 Jan 2019 11:12:30 +0100
Message-Id: <20190110101232.9398-2-o.rempel@pengutronix.de>
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

Preparation for converting to kthread_worker

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/tty/tty_buffer.c | 12 +++++++++---
 include/linux/tty.h      |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 77070c2d1240..e0090e65d83a 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -72,7 +72,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
 	atomic_dec(&buf->priority);
 	mutex_unlock(&buf->lock);
 	if (restart)
-		queue_work(system_unbound_wq, &buf->work);
+		tty_buffer_queue_work(port);
 }
 EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 
@@ -410,7 +410,7 @@ void tty_schedule_flip(struct tty_port *port)
 	 * flush_to_ldisc() sees buffer data.
 	 */
 	smp_store_release(&buf->tail->commit, buf->tail->used);
-	queue_work(system_unbound_wq, &buf->work);
+	tty_buffer_queue_work(port);
 }
 EXPORT_SYMBOL(tty_schedule_flip);
 
@@ -557,6 +557,12 @@ void tty_flip_buffer_push(struct tty_port *port)
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
+bool tty_buffer_queue_work(struct tty_port *port)
+{
+	struct tty_bufhead *buf = &port->buf;
+	return schedule_work(&buf->work);
+}
+
 /**
  *	tty_buffer_init		-	prepare a tty buffer structure
  *	@tty: tty to initialise
@@ -605,7 +611,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
 
 bool tty_buffer_restart_work(struct tty_port *port)
 {
-	return queue_work(system_unbound_wq, &port->buf.work);
+	return tty_buffer_queue_work(port);
 }
 
 bool tty_buffer_cancel_work(struct tty_port *port)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index bfa4e2ee94a9..226a9eff0766 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -507,6 +507,7 @@ extern void session_clear_tty(struct pid *session);
 extern void no_tty(void);
 extern void tty_buffer_free_all(struct tty_port *port);
 extern void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld);
+extern bool tty_buffer_queue_work(struct tty_port *port);
 extern void tty_buffer_init(struct tty_port *port);
 extern void tty_buffer_set_lock_subclass(struct tty_port *port);
 extern bool tty_buffer_restart_work(struct tty_port *port);
-- 
2.19.1

