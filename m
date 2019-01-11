Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2364BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8B120872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfAKDDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:03:18 -0500
Received: from mx137-tc.baidu.com ([61.135.168.137]:12695 "EHLO
        tc-sys-mailedm01.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729236AbfAKDDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:03:17 -0500
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm01.tc.baidu.com (Postfix) with ESMTP id 4CCBB204004B;
        Fri, 11 Jan 2019 11:03:04 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, gregkh@linuxfoundation.org, gkohli@codeaurora.org,
        alan@linux.intel.com, robh@kernel.org, lirongqing@baidu.com
Subject: [PATCH][V2][resend] tty: fix race between flush_to_ldisc and tty_open
Date:   Fri, 11 Jan 2019 11:03:04 +0800
Message-Id: <1547175784-9192-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There still is a race window after the commit b027e2298bd588
("tty: fix data race between tty_init_dev and flush of buf"),
if receive_buf call comes before tty initialization completes
in n_tty_open and tty->driver_data may be NULL.

CPU0                                    CPU1
----                                    ----
                                 n_tty_open
                                   tty_init_dev
                                     tty_ldisc_unlock
                                       schedule
flush_to_ldisc
  n_tty_receive_buf
    uart_flush_chars
      uart_start
      /*tty->driver_data is NULL*/
                                   tty->ops->open
                                   /*init tty->driver_data*/

Extending ldisc semaphore lock in tty_init_dev to driver_data
initialized completely after tty->ops->open().

Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/staging/speakup/spk_ttyio.c |  1 +
 drivers/tty/pty.c                   |  2 ++
 drivers/tty/serdev/serdev-ttyport.c |  2 ++
 drivers/tty/tty_io.c                | 14 +++++++++++---
 drivers/tty/tty_ldisc.c             |  1 +
 5 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/speakup/spk_ttyio.c b/drivers/staging/speakup/spk_ttyio.c
index 979e3ae249c1..c31f08c98383 100644
--- a/drivers/staging/speakup/spk_ttyio.c
+++ b/drivers/staging/speakup/spk_ttyio.c
@@ -155,6 +155,7 @@ static int spk_ttyio_initialise_ldisc(struct spk_synth *synth)
 	else
 		ret = -ENODEV;
 
+	tty_ldisc_unlock(tty);
 	if (ret) {
 		tty_unlock(tty);
 		return ret;
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 00099a8439d2..1b9684d4f718 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -873,9 +873,11 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 
 	tty_debug_hangup(tty, "opening (count=%d)\n", tty->count);
 
+	tty_ldisc_unlock(tty);
 	tty_unlock(tty);
 	return 0;
 err_release:
+	tty_ldisc_unlock(tty);
 	tty_unlock(tty);
 	// This will also put-ref the fsi
 	tty_release(inode, filp);
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index fa1672993b4c..ce16cb303e28 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -123,6 +123,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	if (ret)
 		goto err_close;
 
+	tty_ldisc_unlock(tty);
 	tty_unlock(serport->tty);
 
 	/* Bring the UART into a known 8 bits no parity hw fc state */
@@ -145,6 +146,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
 err_close:
 	tty->ops->close(tty, NULL);
 err_unlock:
+	tty_ldisc_unlock(tty);
 	tty_unlock(tty);
 	tty_release_struct(tty, serport->tty_idx);
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 687250ec8032..199f45e2e1b1 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1351,7 +1351,6 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 	retval = tty_ldisc_setup(tty, tty->link);
 	if (retval)
 		goto err_release_tty;
-	tty_ldisc_unlock(tty);
 	/* Return the tty locked so that it cannot vanish under the caller */
 	return tty;
 
@@ -1926,7 +1925,7 @@ EXPORT_SYMBOL_GPL(tty_kopen);
  *	  - concurrent tty removal from driver table
  */
 static struct tty_struct *tty_open_by_driver(dev_t device, struct inode *inode,
-					     struct file *filp)
+					     struct file *filp, bool *unlock)
 {
 	struct tty_struct *tty;
 	struct tty_driver *driver = NULL;
@@ -1970,6 +1969,7 @@ static struct tty_struct *tty_open_by_driver(dev_t device, struct inode *inode,
 		}
 	} else { /* Returns with the tty_lock held for now */
 		tty = tty_init_dev(driver, index);
+		*unlock = true;
 		mutex_unlock(&tty_mutex);
 	}
 out:
@@ -2007,6 +2007,7 @@ static int tty_open(struct inode *inode, struct file *filp)
 	int noctty, retval;
 	dev_t device = inode->i_rdev;
 	unsigned saved_flags = filp->f_flags;
+	bool unlock = false;
 
 	nonseekable_open(inode, filp);
 
@@ -2017,7 +2018,7 @@ static int tty_open(struct inode *inode, struct file *filp)
 
 	tty = tty_open_current_tty(device, filp);
 	if (!tty)
-		tty = tty_open_by_driver(device, inode, filp);
+		tty = tty_open_by_driver(device, inode, filp, &unlock);
 
 	if (IS_ERR(tty)) {
 		tty_free_file(filp);
@@ -2042,6 +2043,10 @@ static int tty_open(struct inode *inode, struct file *filp)
 	if (retval) {
 		tty_debug_hangup(tty, "open error %d, releasing\n", retval);
 
+		if (unlock) {
+			unlock = false;
+			tty_ldisc_unlock(tty);
+		}
 		tty_unlock(tty); /* need to call tty_release without BTM */
 		tty_release(inode, filp);
 		if (retval != -ERESTARTSYS)
@@ -2067,6 +2072,9 @@ static int tty_open(struct inode *inode, struct file *filp)
 		  tty->driver->subtype == PTY_TYPE_MASTER);
 	if (!noctty)
 		tty_open_proc_set_tty(filp, tty);
+
+	if (unlock)
+		tty_ldisc_unlock(tty);
 	tty_unlock(tty);
 	return 0;
 }
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index fc4c97cae01e..dd9b41f66c18 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -339,6 +339,7 @@ void tty_ldisc_unlock(struct tty_struct *tty)
 	clear_bit(TTY_LDISC_HALTED, &tty->flags);
 	__tty_ldisc_unlock(tty);
 }
+EXPORT_SYMBOL_GPL(tty_ldisc_unlock);
 
 static int
 tty_ldisc_lock_pair_timeout(struct tty_struct *tty, struct tty_struct *tty2,
-- 
2.16.2

