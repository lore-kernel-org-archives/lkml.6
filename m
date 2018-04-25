Return-Path: <threeearcat@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524662455; cv=none;
        d=google.com; s=arc-20160816;
        b=tbg/YUzw1wo5kBdZyINCcgfQxqktbpjup4HGk5tHp8UQxseDeJC6VOEc4mbkeWj/VJ
         EIQ/R/Dot8xohLlHXT2FIGfOIw9f5beXM2uHTzbc4uyL7IMv7pjKyknqdPk2qf63065/
         hJTiNtHSJv2Ms39hg/vUALNXlH1o9pbe36jyNHjVqQ/weboPfM0dTH7vELBhRDTRIwpB
         XylWiQEI/GH3lJvblxf7+ljUWmyRiitKs8rANRnUIPGHLJLELE1C1+Nl8jzfFvDoB8Sy
         CxWymN0MT2qf4UMPoG7WpGQXBenUxvmqsqPBBQ0XhYARpdOy0/fJZQQ9sTV8hC29HWPX
         0J3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=KJwnLdTPxcprXTSg50TqWcPIF0FJF16NCUN2AlqmgT4=;
        b=CWDiih+KLqBBhoO0Ojw4Z5YSSVBSqns1xOgAjzLTG8AjtZcuMVfNMN1eXLatJ5ekA6
         ayoxQutYbs9UlyQpKtV5znbmdr0EUlfcWwQzmNaxrr5CPtQClvOVLgbzO++VBKhSSe4E
         dDyxpOY6cpwQhKyJS1L0PsvtM7sUMAAXYHNnjEoQLH1AjApFoE/D7dIYelRYdBE31DVc
         WdRXNZ8ucituwIpZ8ahijGrQIbR+NZuRWgSrxJo4lI6iA5FyYV3+oYXyJPCkOVjoWF6C
         DvWkNe0mYfhNBCrD3LfDLzE2Ezm9juw72+Xt4j287TjkAMCi1xpBdU2Fa/0Q69CVg+JV
         KG0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dPXOujyH;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dPXOujyH;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49N0a7Q/ozycWizTlj9+dSR860/tQHjewJSCEO8vEEYEz2OcMPVlqratU/ivjfPWUbYpCbJlA==
Date: Wed, 25 Apr 2018 22:20:50 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tty: Fix data race in tty_insert_flip_string_fixed_flag
Message-ID: <20180425132047.GA20337@dragonet.kaist.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598724459634518298?=
X-GMAIL-MSGID: =?utf-8?q?1598724459634518298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

tty_insert_flip_string_fixed_flag() copies chars to the buffer indicated
by th->used and updates tb->used.
But tty_insert_flip_string_fixed_flag() can be executed concurrently and
tb->used can be updated improperly.
It leads slab-out-of-bound write in tty_insert_flip_string_fixed_flag or
slab-out-of-bounds read in flush_to_ldisc

BUG: KASAN: slab-out-of-bounds in tty_insert_flip_string_fixed_flag+0xb5/
0x130 drivers/tty/tty_buffer.c:316 at addr ffff880114fcc121
Write of size 1792 by task syz-executor0/30017
CPU: 1 PID: 30017 Comm: syz-executor0 Not tainted 4.8.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
 0000000000000000 ffff88011638f888 ffffffff81694cc3 ffff88007d802140
 ffff880114fcb300 ffff880114fcc300 ffff880114fcb300 ffff88011638f8b0
 ffffffff8130075c ffff88011638f940 ffff88007d802140 ffff880194fcc121
Call Trace:
 __dump_stack lib/dump_stack.c:15 [inline]
 dump_stack+0xb3/0x110 lib/dump_stack.c:51
 kasan_object_err+0x1c/0x70 mm/kasan/report.c:156
 print_address_description mm/kasan/report.c:194 [inline]
 kasan_report_error+0x1f7/0x4e0 mm/kasan/report.c:283
 kasan_report+0x36/0x40 mm/kasan/report.c:303
 check_memory_region_inline mm/kasan/kasan.c:292 [inline]
 check_memory_region+0x13e/0x1a0 mm/kasan/kasan.c:299
 memcpy+0x37/0x50 mm/kasan/kasan.c:335
 tty_insert_flip_string_fixed_flag+0xb5/0x130 drivers/tty/tty_buffer.c:316
 tty_insert_flip_string include/linux/tty_flip.h:35 [inline]
 pty_write+0x7f/0xc0 drivers/tty/pty.c:115
 n_hdlc_send_frames+0x1d4/0x3b0 drivers/tty/n_hdlc.c:419
 n_hdlc_tty_wakeup+0x73/0xa0 drivers/tty/n_hdlc.c:496
 tty_wakeup+0x92/0xb0 drivers/tty/tty_io.c:601
 __start_tty.part.26+0x66/0x70 drivers/tty/tty_io.c:1018
 __start_tty+0x34/0x40 drivers/tty/tty_io.c:1013
 n_tty_ioctl_helper+0x146/0x1e0 drivers/tty/tty_ioctl.c:1138
 n_hdlc_tty_ioctl+0xb3/0x2b0 drivers/tty/n_hdlc.c:794
 tty_ioctl+0xa85/0x16d0 drivers/tty/tty_io.c:2992
 vfs_ioctl fs/ioctl.c:43 [inline]
 do_vfs_ioctl+0x13e/0xba0 fs/ioctl.c:679
 SYSC_ioctl fs/ioctl.c:694 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:685
 entry_SYSCALL_64_fastpath+0x1f/0xbd

Call sequences are as follows.
CPU0                                    CPU1
n_tty_ioctl_helper                      n_tty_ioctl_helper
__start_tty                             tty_send_xchar
tty_wakeup                              pty_write
n_hdlc_tty_wakeup                       tty_insert_flip_string
n_hdlc_send_frames                      tty_insert_flip_string_fixed_flag
pty_write
tty_insert_flip_string
tty_insert_flip_string_fixed_flag

Acquire tty->atomic_write_lock by calling tty_write_lock() before
__start_tty() since __start_tty() can sends frames.

Signed-off-by: DaeRyong Jeong <threeearcat@gmail.com>
---
 drivers/tty/tty_io.c    | 16 +++++++++-------
 drivers/tty/tty_ioctl.c |  5 +++++
 include/linux/tty.h     |  2 ++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 63114ea35ec1..41f83bd4cc40 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -873,13 +873,15 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 	return i;
 }

-static void tty_write_unlock(struct tty_struct *tty)
+void tty_write_unlock(struct tty_struct *tty, int wakeup)
 {
 	mutex_unlock(&tty->atomic_write_lock);
-	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
+	if (wakeup) {
+		wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
+	}
 }

-static int tty_write_lock(struct tty_struct *tty, int ndelay)
+int tty_write_lock(struct tty_struct *tty, int ndelay)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
@@ -973,7 +975,7 @@ static inline ssize_t do_tty_write(
 		ret = written;
 	}
 out:
-	tty_write_unlock(tty);
+	tty_write_unlock(tty, 1);
 	return ret;
 }

@@ -997,7 +999,7 @@ void tty_write_message(struct tty_struct *tty, char *msg)
 		if (tty->ops->write && tty->count > 0)
 			tty->ops->write(tty, msg, strlen(msg));
 		tty_unlock(tty);
-		tty_write_unlock(tty);
+		tty_write_unlock(tty, 1);
 	}
 	return;
 }
@@ -1092,7 +1094,7 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
 	if (was_stopped)
 		stop_tty(tty);
 	up_read(&tty->termios_rwsem);
-	tty_write_unlock(tty);
+	tty_write_unlock(tty, 1);
 	return 0;
 }

@@ -2395,7 +2397,7 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 			msleep_interruptible(duration);
 		retval = tty->ops->break_ctl(tty, 0);
 out:
-		tty_write_unlock(tty);
+		tty_write_unlock(tty, 1);
 		if (signal_pending(current))
 			retval = -EINTR;
 	}
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index d9b561d89432..a54ab91aec90 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -911,12 +911,17 @@ int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 			spin_unlock_irq(&tty->flow_lock);
 			break;
 		case TCOON:
+			if (tty_write_lock(tty, 0) < 0)
+				return -ERESTARTSYS;
+
 			spin_lock_irq(&tty->flow_lock);
 			if (tty->flow_stopped) {
 				tty->flow_stopped = 0;
 				__start_tty(tty);
 			}
 			spin_unlock_irq(&tty->flow_lock);
+
+			tty_write_unlock(tty, 0);
 			break;
 		case TCIOFF:
 			if (STOP_CHAR(tty) != __DISABLED_CHAR)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 47f8af22f216..9b18393d2f95 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -458,6 +458,8 @@ static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
 	return tty;
 }

+void tty_write_unlock(struct tty_struct *tty, int wakeup);
+int tty_write_lock(struct tty_struct *tty, int ndelay);
 extern const char *tty_driver_name(const struct tty_struct *tty);
 extern void tty_wait_until_sent(struct tty_struct *tty, long timeout);
 extern int __tty_check_change(struct tty_struct *tty, int sig);
--
2.14.3
