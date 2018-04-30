Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeD3JEB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:04:01 -0400
Received: from mail.sysgo.com ([176.9.12.79]:36266 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752103AbeD3JD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:03:59 -0400
From: David Engraf <david.engraf@sysgo.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] Input: serio - add writing multiple bytes at once
Date: Mon, 30 Apr 2018 11:03:24 +0200
Message-Id: <20180430090324.30845-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version only supports forwarding a single byte to the tty
layer.

This patch adds serio_write_length() to allow a serport driver writing
multiple bytes at once. The patch also includes a fallback to
serio_write_length() when a driver did not register a single byte function.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 drivers/input/serio/serport.c |  7 ++++---
 include/linux/serio.h         | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index f8ead9f9c77e..209343f636a3 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -45,10 +45,11 @@ struct serport {
  * Callback functions from the serio code.
  */
 
-static int serport_serio_write(struct serio *serio, unsigned char data)
+static int serport_serio_write_length(struct serio *serio,
+				      const unsigned char *data, int count)
 {
 	struct serport *serport = serio->port_data;
-	return -(serport->tty->ops->write(serport->tty, &data, 1) != 1);
+	return -(serport->tty->ops->write(serport->tty, data, count) != count);
 }
 
 static int serport_serio_open(struct serio *serio)
@@ -176,7 +177,7 @@ static ssize_t serport_ldisc_read(struct tty_struct * tty, struct file * file, u
 	snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", tty_name(tty));
 	serio->id = serport->id;
 	serio->id.type = SERIO_RS232;
-	serio->write = serport_serio_write;
+	serio->write_length = serport_serio_write_length;
 	serio->open = serport_serio_open;
 	serio->close = serport_serio_close;
 	serio->port_data = serport;
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 138a5efe863a..6f5cb92d0f22 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -35,6 +35,8 @@ struct serio {
 	spinlock_t lock;
 
 	int (*write)(struct serio *, unsigned char);
+	int (*write_length)(struct serio *serio, const unsigned char *data,
+			    int count);
 	int (*open)(struct serio *);
 	void (*close)(struct serio *);
 	int (*start)(struct serio *);
@@ -122,12 +124,21 @@ void serio_unregister_driver(struct serio_driver *drv);
 	module_driver(__serio_driver, serio_register_driver, \
 		       serio_unregister_driver)
 
+static inline int serio_write_length(struct serio *serio,
+				     const unsigned char *data, int count)
+{
+	if (serio->write_length)
+		return serio->write_length(serio, data, count);
+	else
+		return -1;
+}
+
 static inline int serio_write(struct serio *serio, unsigned char data)
 {
 	if (serio->write)
 		return serio->write(serio, data);
 	else
-		return -1;
+		return serio_write_length(serio, &data, 1);
 }
 
 static inline void serio_drv_write_wakeup(struct serio *serio)
-- 
2.14.1
