Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7A4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FAD218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeLUJEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:04:20 -0500
Received: from mx139-tc.baidu.com ([61.135.168.139]:17600 "EHLO
        tc-sys-mailedm06.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbeLUJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:04:18 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2018 04:04:16 EST
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm06.tc.baidu.com (Postfix) with ESMTP id E3ED3263C007;
        Fri, 21 Dec 2018 16:57:01 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-kernel@vger.kernel.org, jslaby@suse.com,
        gregkh@linuxfoundation.org, gkohli@codeaurora.org,
        alan@linux.intel.com
Subject: [PATCH] tty: fix race between flush_to_ldisc and tty_open
Date:   Fri, 21 Dec 2018 16:57:01 +0800
Message-Id: <1545382621-2093-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There still can be a race after the commit b027e2298bd588
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

Extending ldisc semaphore lock in tty_init_dev till driver_data
initializes completely after tty->ops->open().

Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
we see this bug in centos 7.4, and think b027e2298bd588 can not
fix it, since driver_data is NULL;

the trace is that:

    [exception RIP: uart_start+24]
    RIP: ffffffff814908b8  RSP: ffff881c23ab7d18  RFLAGS: 00010282
    RAX: 0000000000000000  RBX: ffff88182bafc400  RCX: 0000000000000000
    RDX: 0000000000020001  RSI: 000000000000001d  RDI: ffff88182bafc400
    RBP: ffff881c23ab7d30   R8: ffff881fff956060   R9: ffffffff81b5dc20
    R10: 0000000000005a07  R11: 0000000000000001  R12: ffff88182bafc400
    R13: ffff881ff90c852d  R14: ffff88182baff400  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#11 [ffff881c23ab7d38] uart_flush_chars at ffffffff81490ade
#12 [ffff881c23ab7d48] n_tty_receive_buf at ffffffff81478b1d
#13 [ffff881c23ab7de0] flush_to_ldisc at ffffffff8147bdc4
#14 [ffff881c23ab7e28] process_one_work at ffffffff8109e210
#15 [ffff881c23ab7e70] worker_thread at ffffffff8109e69e
#16 [ffff881c23ab7ec8] kthread at ffffffff810a62d1
#17 [ffff881c23ab7f50] ret_from_fork at ffffffff8171d677

other one

PID: 922    TASK: ffff881c7fbc1f40  CPU: 29  COMMAND: "agetty"
 #0 [ffff8818e9677a20] __schedule at ffffffff817114f2
 #1 [ffff8818e9677a78] preempt_schedule at ffffffff81711f4f
 #2 [ffff8818e9677a90] _raw_spin_unlock_irqrestore at ffffffff81713f7d
 #3 [ffff8818e9677aa8] __wake_up at ffffffff810b03c4
 #4 [ffff8818e9677ae0] n_tty_set_termios at ffffffff814770d3
 #5 [ffff8818e9677b10] n_tty_open at ffffffff814772ec` 
 
 
 drivers/staging/speakup/spk_ttyio.c |  1 +
 drivers/tty/pty.c                   |  2 ++
 drivers/tty/serdev/serdev-ttyport.c |  2 ++
 drivers/tty/tty_io.c                | 14 +++++++++++---
 4 files changed, 16 insertions(+), 3 deletions(-)

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
-- 
2.16.2

