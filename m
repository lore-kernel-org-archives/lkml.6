Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF862C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8576C20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8576C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeJNXSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:18:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36732 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728153AbeJNXSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:18:50 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLx-0004cS-Ec; Sun, 14 Oct 2018 16:30:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000P8-Na; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dmitry Vyukov" <dvyukov@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alan Cox" <alan@linux.intel.com>,
        "Alan Cox" <alan@llwyncelyn.cymru>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.472039018@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 195/366] tty: handle the case where we cannot restore
 a line discipline
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Cox <alan@llwyncelyn.cymru>

commit 8a8dabf2dd68caff842d38057097c23bc514ea6e upstream.

Historically the N_TTY driver could never fail but this has become broken over
time. Rather than trying to rewrite half the ldisc layer to fix the breakage
introduce a second level of fallback with an N_NULL ldisc which cannot fail,
and thus restore the guarantees required by the ldisc layer.

We still try and fail to N_TTY first. It's much more useful to find yourself
back in your old ldisc (first attempt) or in N_TTY (second attempt), and while
I'm not aware of any code out there that makes those assumptions it's good to
drive(r) defensively.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_TTY)		+= tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
-				   tty_buffer.o tty_port.o tty_mutex.o tty_ldsem.o
+				   tty_buffer.o tty_port.o tty_mutex.o \
+				   tty_ldsem.o n_null.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-$(CONFIG_AUDIT)		+= tty_audit.o
--- /dev/null
+++ b/drivers/tty/n_null.c
@@ -0,0 +1,80 @@
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/tty.h>
+#include <linux/module.h>
+
+/*
+ *  n_null.c - Null line discipline used in the failure path
+ *
+ *  Copyright (C) Intel 2017
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+static int n_null_open(struct tty_struct *tty)
+{
+	return 0;
+}
+
+static void n_null_close(struct tty_struct *tty)
+{
+}
+
+static ssize_t n_null_read(struct tty_struct *tty, struct file *file,
+			   unsigned char __user * buf, size_t nr)
+{
+	return -EOPNOTSUPP;
+}
+
+static ssize_t n_null_write(struct tty_struct *tty, struct file *file,
+			    const unsigned char *buf, size_t nr)
+{
+	return -EOPNOTSUPP;
+}
+
+static void n_null_receivebuf(struct tty_struct *tty,
+				 const unsigned char *cp, char *fp,
+				 int cnt)
+{
+}
+
+static struct tty_ldisc_ops null_ldisc = {
+	.owner		=	THIS_MODULE,
+	.magic		=	TTY_LDISC_MAGIC,
+	.name		=	"n_null",
+	.open		=	n_null_open,
+	.close		=	n_null_close,
+	.read		=	n_null_read,
+	.write		=	n_null_write,
+	.receive_buf	=	n_null_receivebuf
+};
+
+static int __init n_null_init(void)
+{
+	BUG_ON(tty_register_ldisc(N_NULL, &null_ldisc));
+	return 0;
+}
+
+static void __exit n_null_exit(void)
+{
+	tty_unregister_ldisc(N_NULL);
+}
+
+module_init(n_null_init);
+module_exit(n_null_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alan Cox");
+MODULE_ALIAS_LDISC(N_NULL);
+MODULE_DESCRIPTION("Null ldisc driver");
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -474,6 +474,29 @@ static void tty_ldisc_close(struct tty_s
 }
 
 /**
+ *	tty_ldisc_failto	-	helper for ldisc failback
+ *	@tty: tty to open the ldisc on
+ *	@ld: ldisc we are trying to fail back to
+ *
+ *	Helper to try and recover a tty when switching back to the old
+ *	ldisc fails and we need something attached.
+ */
+
+static int tty_ldisc_failto(struct tty_struct *tty, int ld)
+{
+	struct tty_ldisc *disc = tty_ldisc_get(tty, ld);
+	int r;
+
+	if (IS_ERR(disc))
+		return PTR_ERR(disc);
+	tty->ldisc = disc;
+	tty_set_termios_ldisc(tty, ld);
+	if ((r = tty_ldisc_open(tty, disc)) < 0)
+		tty_ldisc_put(disc);
+	return r;
+}
+
+/**
  *	tty_ldisc_restore	-	helper for tty ldisc change
  *	@tty: tty to recover
  *	@old: previous ldisc
@@ -485,8 +508,6 @@ static void tty_ldisc_close(struct tty_s
 static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 {
 	char buf[64];
-	struct tty_ldisc *new_ldisc;
-	int r;
 
 	/* There is an outstanding reference here so this is safe */
 	old = tty_ldisc_get(tty, old->ops->num);
@@ -495,17 +516,13 @@ static void tty_ldisc_restore(struct tty
 	tty_set_termios_ldisc(tty, old->ops->num);
 	if (tty_ldisc_open(tty, old) < 0) {
 		tty_ldisc_put(old);
-		/* This driver is always present */
-		new_ldisc = tty_ldisc_get(tty, N_TTY);
-		if (IS_ERR(new_ldisc))
-			panic("n_tty: get");
-		tty->ldisc = new_ldisc;
-		tty_set_termios_ldisc(tty, N_TTY);
-		r = tty_ldisc_open(tty, new_ldisc);
-		if (r < 0)
-			panic("Couldn't open N_TTY ldisc for "
-			      "%s --- error %d.",
-			      tty_name(tty, buf), r);
+		/* The traditional behaviour is to fall back to N_TTY, we
+		   want to avoid falling back to N_NULL unless we have no
+		   choice to avoid the risk of breaking anything */
+		if (tty_ldisc_failto(tty, N_TTY) < 0 &&
+		    tty_ldisc_failto(tty, N_NULL) < 0)
+			panic("Couldn't open N_NULL ldisc for %s.",
+			      tty_name(tty, buf));
 	}
 }
 
--- a/include/uapi/linux/tty.h
+++ b/include/uapi/linux/tty.h
@@ -34,5 +34,6 @@
 #define N_TI_WL		22	/* for TI's WL BT, FM, GPS combo chips */
 #define N_TRACESINK	23	/* Trace data routing for MIPI P1149.7 */
 #define N_TRACEROUTER	24	/* Trace data routing for MIPI P1149.7 */
+#define N_NULL		27	/* Null ldisc used for error handling */
 
 #endif /* _UAPI_LINUX_TTY_H */

