Return-Path: <daelyong.jeong@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524210057; cv=none;
        d=google.com; s=arc-20160816;
        b=j0rSYte7WyTP8T/96pqGaTbtTsxXWiWfBDyhYF/DnfLWgT1fXf+jOBHHrTBDe1n9La
         MLhkFVo2YRfAhI3KrBpMjDmcvteuzIvlg1e/cPN/gVr32qdeW6HA0EcoIe7R6omctddp
         Kgamc4n0Us6UzZaEpxWwpNDfI9ToEIyziRKGp/h+46I5bTFldkKNmh2li++BRmvNp8l6
         G0EchQUClYOAaNgO6U3u9ik1NicQkBdGDL7wLlN9v9MURcMQJOqR0Ax+niHTXnebtCDg
         VVAN0WLm197R8ZGLsz3ywXrsHK4dP8DK1bfMjgNaWpbEQigng/OVcpHg3ppU1gASyq7e
         qcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=RqB8thb3hFAxWE3j1EbMLVtXWHysXAErc/RrFLzRGAE=;
        b=rf22aZJLjDE1s4yYfqJf2xW3Gr2DCjbZpAaK7nQYyYEb9Kk5is3WSworUBD4xFY56e
         lJvZh3e4gkmbU7A6w3B733Jyl/JTU+dzLSEjqJYfr5p2DAyaxg07T8tCZ1d49BRqIV5s
         jxqpAKjrqMcHFhYqDM2ROI4Ra9bEUANDUjL0kpo4mq8X+vqTQ3NWch0slyOWiq+k7Qxe
         aY0JzW7dcUfSbSSBa/i4HHU6JJHo2sxqI2BlkGcut4oNsC0Hj9e13gL/bXbkLLtCMyxH
         VLHGb2G098AvStnsbm7CNLU6v+in6uvtMv9PDSIjEsWhm7i5/Za28iHOnHw9pqy1Duiy
         tsug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZhwW4a/4;
       spf=pass (google.com: domain of daelyong.jeong@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=daelyong.jeong@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZhwW4a/4;
       spf=pass (google.com: domain of daelyong.jeong@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=daelyong.jeong@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/wVl6oNAHuasCl+HC6sPAtJATBc0DRdY40TBA4xYO4J433x+gojeOmRrnw9CWIzRkk7Txv+piXfJeDxv6Oi6o=
MIME-Version: 1.0
From: daelyong jeong <daelyong.jeong@gmail.com>
Date: Fri, 20 Apr 2018 16:40:56 +0900
Message-ID: <CAARE==e6obTMLBeo3t2oJuwwtv3zfei7sUhREJwDcqUEGFPdAg@mail.gmail.com>
Subject: [PATCH] tty: Fix data race in tty_insert_flip_string_fixed_flag()
To: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
	LKML <linux-kernel@vger.kernel.org>
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, Kyungtae Kim <kt0755@gmail.com>, basavesh@purdue.edu
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598249520396476716?=
X-GMAIL-MSGID: =?utf-8?q?1598250085141735476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

tty_insert_flip_string_fixed_flag() copies chars to the buffer indicated
by th->used and updates tb->used.
But it is possible that tty_insert_flip_string_fixed_flag() is executed
concurrently and tb->used is updated improperly.
It leads slab-out-of-bound write in tty_insert_flip_string_fixed_flag or
slab-out-of-bounds read in flush_to_ldisc.

BUG: KASAN: slab-out-of-bounds in
tty_insert_flip_string_fixed_flag+0xb5/0x130
drivers/tty/tty_buffer.c:316 at addr ffff880114fcc121
Write of size 1792 by task syz-executor0/30017
CPU: 1 PID: 30017 Comm: syz-executor0 Not tainted 4.8.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
 0000000000000000 ffff88011638f888 ffffffff81694cc3 ffff88007d802140
 ffff880114fcb300 ffff880114fcc300 ffff880114fcb300 ffff88011638f8b0
 ffffffff8130075c ffff88011638f940 ffff88007d802140 ffff880194fcc121
Call Trace:
 [<ffffffff81694cc3>] __dump_stack lib/dump_stack.c:15 [inline]
 [<ffffffff81694cc3>] dump_stack+0xb3/0x110 lib/dump_stack.c:51
 [<ffffffff8130075c>] kasan_object_err+0x1c/0x70 mm/kasan/report.c:156
 [<ffffffff813009f7>] print_address_description mm/kasan/report.c:194 [inline]
 [<ffffffff813009f7>] kasan_report_error+0x1f7/0x4e0 mm/kasan/report.c:283
 [<ffffffff81301076>] kasan_report+0x36/0x40 mm/kasan/report.c:303
 [<ffffffff812ff9ce>] check_memory_region_inline mm/kasan/kasan.c:292 [inline]
 [<ffffffff812ff9ce>] check_memory_region+0x13e/0x1a0 mm/kasan/kasan.c:299
 [<ffffffff812ffea7>] memcpy+0x37/0x50 mm/kasan/kasan.c:335
 [<ffffffff817f19f5>] tty_insert_flip_string_fixed_flag+0xb5/0x130
drivers/tty/tty_buffer.c:316
 [<ffffffff817f4d6f>] tty_insert_flip_string
include/linux/tty_flip.h:35 [inline]
 [<ffffffff817f4d6f>] pty_write+0x7f/0xc0 drivers/tty/pty.c:115
 [<ffffffff817f83c4>] n_hdlc_send_frames+0x1d4/0x3b0 drivers/tty/n_hdlc.c:419
 [<ffffffff817f8613>] n_hdlc_tty_wakeup+0x73/0xa0 drivers/tty/n_hdlc.c:496
 [<ffffffff817dea32>] tty_wakeup+0x92/0xb0 drivers/tty/tty_io.c:601
 [<ffffffff817e06c6>] __start_tty.part.26+0x66/0x70 drivers/tty/tty_io.c:1018
 [<ffffffff817e5114>] __start_tty+0x34/0x40 drivers/tty/tty_io.c:1013
 [<ffffffff817efbb6>] n_tty_ioctl_helper+0x146/0x1e0
drivers/tty/tty_ioctl.c:1138
 [<ffffffff817f9443>] n_hdlc_tty_ioctl+0xb3/0x2b0 drivers/tty/n_hdlc.c:794
 [<ffffffff817e4415>] tty_ioctl+0xa85/0x16d0 drivers/tty/tty_io.c:2992
 [<ffffffff8133500e>] vfs_ioctl fs/ioctl.c:43 [inline]
 [<ffffffff8133500e>] do_vfs_ioctl+0x13e/0xba0 fs/ioctl.c:679
 [<ffffffff81335aff>] SYSC_ioctl fs/ioctl.c:694 [inline]
 [<ffffffff81335aff>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:685
 [<ffffffff8230de3c>] entry_SYSCALL_64_fastpath+0x1f/0xbd

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

Signed-off-by: Daelyong Jeong <daelyong.jeong@gmail.com>
---
Rationale:
- Since tty_wakeup() called by __start_tty() sends frames, call
  tty_write_lock() before __start_tty().
- Since tty_write_lock() might sleep, locate tty_write_lock() before
  spin_lock_irq(&tty->flow_lock).
- Since wake_up_interruptible_poll() is called by both tty_write_unlock()
  and __start_tty(), Prevent calling wake_up_interruptible_poll() twice
  by adding the wakeup flag to tty_write_unlock()

---
 drivers/tty/tty_io.c    | 16 +++++++++-------
 drivers/tty/tty_ioctl.c |  5 +++++
 include/linux/tty.h     |  2 ++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 63114ea..41f83bd 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -873,13 +873,15 @@ static ssize_t tty_read(struct file *file, char
__user *buf, size_t count,
  return i;
 }

-static void tty_write_unlock(struct tty_struct *tty)
+void tty_write_unlock(struct tty_struct *tty, int wakeup)
 {
  mutex_unlock(&tty->atomic_write_lock);
- wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
+ if (wakeup) {
+ wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
+ }
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
- tty_write_unlock(tty);
+ tty_write_unlock(tty, 1);
  return ret;
 }

@@ -997,7 +999,7 @@ void tty_write_message(struct tty_struct *tty, char *msg)
  if (tty->ops->write && tty->count > 0)
  tty->ops->write(tty, msg, strlen(msg));
  tty_unlock(tty);
- tty_write_unlock(tty);
+ tty_write_unlock(tty, 1);
  }
  return;
 }
@@ -1092,7 +1094,7 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
  if (was_stopped)
  stop_tty(tty);
  up_read(&tty->termios_rwsem);
- tty_write_unlock(tty);
+ tty_write_unlock(tty, 1);
  return 0;
 }

@@ -2395,7 +2397,7 @@ static int send_break(struct tty_struct *tty,
unsigned int duration)
  msleep_interruptible(duration);
  retval = tty->ops->break_ctl(tty, 0);
 out:
- tty_write_unlock(tty);
+ tty_write_unlock(tty, 1);
  if (signal_pending(current))
  retval = -EINTR;
  }
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index d9b561d..a54ab91 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -911,12 +911,17 @@ int n_tty_ioctl_helper(struct tty_struct *tty,
struct file *file,
  spin_unlock_irq(&tty->flow_lock);
  break;
  case TCOON:
+ if (tty_write_lock(tty, 0) < 0)
+ return -ERESTARTSYS;
+
  spin_lock_irq(&tty->flow_lock);
  if (tty->flow_stopped) {
  tty->flow_stopped = 0;
  __start_tty(tty);
  }
  spin_unlock_irq(&tty->flow_lock);
+
+ tty_write_unlock(tty, 0);
  break;
  case TCIOFF:
  if (STOP_CHAR(tty) != __DISABLED_CHAR)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 47f8af2..5bdf928 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -458,6 +458,8 @@ static inline struct tty_struct
*tty_kref_get(struct tty_struct *tty)
  return tty;
 }

+extern void tty_write_unlock(struct tty_struct *tty, int wakeup);
+extern int tty_write_lock(struct tty_struct *tty, int ndelay);
 extern const char *tty_driver_name(const struct tty_struct *tty);
 extern void tty_wait_until_sent(struct tty_struct *tty, long timeout);
 extern int __tty_check_change(struct tty_struct *tty, int sig);
