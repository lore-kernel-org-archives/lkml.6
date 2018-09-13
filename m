Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2325C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54A72133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54A72133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeIMHwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:52:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43608 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeIMHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYo-0006Po-GS; Thu, 13 Sep 2018 02:40:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/50] ipwireless: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:10 +0100
Message-Id: <20180913024049.24567-11-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/tty/ipwireless/tty.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index 1ef751c27ac6..fad3401e604d 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -248,22 +248,29 @@ static int ipw_write_room(struct tty_struct *linux_tty)
 	return room;
 }
 
-static int ipwireless_get_serial_info(struct ipw_tty *tty,
-				      struct serial_struct __user *retinfo)
+static int ipwireless_get_serial_info(struct tty_struct *linux_tty,
+				      struct serial_struct *ss)
 {
-	struct serial_struct tmp;
+	struct ipw_tty *tty = linux_tty->driver_data;
 
-	memset(&tmp, 0, sizeof(tmp));
-	tmp.type = PORT_UNKNOWN;
-	tmp.line = tty->index;
-	tmp.baud_base = 115200;
+	if (!tty)
+		return -ENODEV;
 
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
+	if (!tty->port.count)
+		return -EINVAL;
 
+	ss->type = PORT_UNKNOWN;
+	ss->line = tty->index;
+	ss->baud_base = 115200;
 	return 0;
 }
 
+static int ipwireless_set_serial_info(struct tty_struct *linux_tty,
+				      struct serial_struct *ss)
+{
+	return 0;	/* Keeps the PCMCIA scripts happy. */
+}
+
 static int ipw_chars_in_buffer(struct tty_struct *linux_tty)
 {
 	struct ipw_tty *tty = linux_tty->driver_data;
@@ -386,15 +393,6 @@ static int ipw_ioctl(struct tty_struct *linux_tty,
 		return -EINVAL;
 
 	/* FIXME: Exactly how is the tty object locked here .. */
-
-	switch (cmd) {
-	case TIOCGSERIAL:
-		return ipwireless_get_serial_info(tty, (void __user *) arg);
-
-	case TIOCSSERIAL:
-		return 0;	/* Keeps the PCMCIA scripts happy. */
-	}
-
 	if (tty->tty_type == TTYTYPE_MODEM) {
 		switch (cmd) {
 		case PPPIOCGCHAN:
@@ -561,6 +559,8 @@ static const struct tty_operations tty_ops = {
 	.chars_in_buffer = ipw_chars_in_buffer,
 	.tiocmget = ipw_tiocmget,
 	.tiocmset = ipw_tiocmset,
+	.set_serial = ipwireless_set_serial_info,
+	.get_serial = ipwireless_get_serial_info,
 };
 
 int ipwireless_tty_init(void)
-- 
2.11.0

