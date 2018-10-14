Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB53C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B1B20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B1B20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbeJNXU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:20:57 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36877 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbeJNXU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:20:56 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLx-0004cD-Ba; Sun, 14 Oct 2018 16:30:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000P3-Lw; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.287802176@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 194/366] drivers: tty: Merge alloc_tty_struct and
 initialize_tty_struct
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

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 2c964a2f4191f2229566895f1a0e85f8339f5dd1 upstream.

The two functions alloc_tty_struct and initialize_tty_struct are
always called together. Merge them into alloc_tty_struct, updating its
prototype and the only two callers of these functions.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/pty.c    | 19 +++++++++----------
 drivers/tty/tty_io.c | 37 +++++++++++++------------------------
 include/linux/tty.h  |  4 +---
 3 files changed, 23 insertions(+), 37 deletions(-)

--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -319,7 +319,7 @@ done:
  *	pty_common_install		-	set up the pty pair
  *	@driver: the pty driver
  *	@tty: the tty being instantiated
- *	@bool: legacy, true if this is BSD style
+ *	@legacy: true if this is BSD style
  *
  *	Perform the initial set up for the tty/pty pair. Called from the
  *	tty layer when the port is first opened.
@@ -334,18 +334,17 @@ static int pty_common_install(struct tty
 	int idx = tty->index;
 	int retval = -ENOMEM;
 
-	o_tty = alloc_tty_struct();
-	if (!o_tty)
-		goto err;
 	ports[0] = kmalloc(sizeof **ports, GFP_KERNEL);
 	ports[1] = kmalloc(sizeof **ports, GFP_KERNEL);
 	if (!ports[0] || !ports[1])
-		goto err_free_tty;
+		goto err;
 	if (!try_module_get(driver->other->owner)) {
 		/* This cannot in fact currently happen */
-		goto err_free_tty;
+		goto err;
 	}
-	initialize_tty_struct(o_tty, driver->other, idx);
+	o_tty = alloc_tty_struct(driver->other, idx);
+	if (!o_tty)
+		goto err_put_module;
 
 	if (legacy) {
 		/* We always use new tty termios data so we can do this
@@ -390,12 +389,12 @@ err_free_termios:
 		tty_free_termios(tty);
 err_deinit_tty:
 	deinitialize_tty_struct(o_tty);
+	free_tty_struct(o_tty);
+err_put_module:
 	module_put(o_tty->driver->owner);
-err_free_tty:
+err:
 	kfree(ports[0]);
 	kfree(ports[1]);
-	free_tty_struct(o_tty);
-err:
 	return retval;
 }
 
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -157,20 +157,6 @@ static void __proc_set_tty(struct task_s
 static void proc_set_tty(struct task_struct *tsk, struct tty_struct *tty);
 
 /**
- *	alloc_tty_struct	-	allocate a tty object
- *
- *	Return a new empty tty structure. The data fields have not
- *	been initialized in any way but has been zeroed
- *
- *	Locking: none
- */
-
-struct tty_struct *alloc_tty_struct(void)
-{
-	return kzalloc(sizeof(struct tty_struct), GFP_KERNEL);
-}
-
-/**
  *	free_tty_struct		-	free a disused tty
  *	@tty: tty struct to free
  *
@@ -1455,12 +1441,11 @@ struct tty_struct *tty_init_dev(struct t
 	if (!try_module_get(driver->owner))
 		return ERR_PTR(-ENODEV);
 
-	tty = alloc_tty_struct();
+	tty = alloc_tty_struct(driver, idx);
 	if (!tty) {
 		retval = -ENOMEM;
 		goto err_module_put;
 	}
-	initialize_tty_struct(tty, driver, idx);
 
 	tty_lock(tty);
 	retval = tty_driver_install_tty(driver, tty);
@@ -3034,19 +3019,21 @@ static struct device *tty_get_device(str
 
 
 /**
- *	initialize_tty_struct
- *	@tty: tty to initialize
+ *	alloc_tty_struct
  *
- *	This subroutine initializes a tty structure that has been newly
- *	allocated.
+ *	This subroutine allocates and initializes a tty structure.
  *
- *	Locking: none - tty in question must not be exposed at this point
+ *	Locking: none - tty in question is not exposed at this point
  */
 
-void initialize_tty_struct(struct tty_struct *tty,
-		struct tty_driver *driver, int idx)
+struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 {
-	memset(tty, 0, sizeof(struct tty_struct));
+	struct tty_struct *tty;
+
+	tty = kzalloc(sizeof(*tty), GFP_KERNEL);
+	if (!tty)
+		return NULL;
+
 	kref_init(&tty->kref);
 	tty->magic = TTY_MAGIC;
 	tty_ldisc_init(tty);
@@ -3070,6 +3057,8 @@ void initialize_tty_struct(struct tty_st
 	tty->index = idx;
 	tty_line_name(driver, idx, tty->name);
 	tty->dev = tty_get_device(tty);
+
+	return tty;
 }
 
 /**
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -477,13 +477,11 @@ extern int tty_mode_ioctl(struct tty_str
 			unsigned int cmd, unsigned long arg);
 extern int tty_perform_flush(struct tty_struct *tty, unsigned long arg);
 extern void tty_default_fops(struct file_operations *fops);
-extern struct tty_struct *alloc_tty_struct(void);
+extern struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx);
 extern int tty_alloc_file(struct file *file);
 extern void tty_add_file(struct tty_struct *tty, struct file *file);
 extern void tty_free_file(struct file *file);
 extern void free_tty_struct(struct tty_struct *tty);
-extern void initialize_tty_struct(struct tty_struct *tty,
-		struct tty_driver *driver, int idx);
 extern void deinitialize_tty_struct(struct tty_struct *tty);
 extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
 extern int tty_release(struct inode *inode, struct file *filp);

