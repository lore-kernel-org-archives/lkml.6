Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518536292; cv=none;
        d=google.com; s=arc-20160816;
        b=lTlwwhjX1TqkIqkHr3Ya2KRiLkj9hOs8io/RSVqsA6nm+yTUSeUEMURhdg0rtjcTnS
         Ghw45oSxrSDZqi8CllM/EdB7+xll3MxGVXRnIRO+dvMsbhCN1XFWb2tCVtpDQ3eqMhFV
         0Xu8+7zMbINoiNjJDoqm2qEr3nDcLXOYaMWTxAkTioXnPw6I9h548+oMi0iqtHjg/4cN
         daMSXo6dACqIGIs7nbopDNBCv5ISu2hMgYSiRg5TEcuSC9Sk2+fgDlpyufK6mZlF/2aa
         trS686W0YPj/8p4YdLQTZZBJAL7xKSvg3wx1DAKK+OYUKMZhgXgqbYz52UZgUfJvdnCl
         BEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=sUV6/tEzIdIetwOTU7EUgUUgf/VV68gEP0qWguTOGGs=;
        b=un8keIsVFvMXcs+fS96Vey8Xyxxgg5tRU4QLJFmrMqK36+ofYBrnRno24NtKp9REfn
         xCj7tpOh2W3bbEQV89hEFUpf3Ul+LryiqVQUYFwCHutDvGhP3V9y8eSakhidZbAeKp3p
         hcdlUUDjFdeNTOgSFdCPLVJ0/qQeiw4JcKxyERiz2JKrstlvjx8am4MxbtelH3ia1Zvh
         icP3s+GH8ORaXMCD1d+t0qn/WncH2jTNIqzFZBrHdeSjH5QVOUyIhYHh7PBS4psNmUBQ
         2UVu6WY60mARN77OqrYZjXEdBp/2kbKJAU7VEf1mFJmtGsZLhYk/SbCe8vZoaTTjcYp6
         DWyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=prwJB8hU;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=prwJB8hU;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AH8x2273xYiOGEj58hk80g2xF7VFw+ifmBO2E3qpgOfKAZiQomQGNekQ4kLKkuvjk1bvS/ZBPxlY2w==
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Feb 2018 07:38:08 -0800
From: Tejun Heo <tj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Alan Cox <alan@llwyncelyn.cymru>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] tty: make n_tty_read() always abort if hangup is in progress
Message-ID: <20180213153808.GQ695913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592300711224042623?=
X-GMAIL-MSGID: =?utf-8?q?1592300711224042623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A tty is hung up by __tty_hangup() setting file->f_op to
hung_up_tty_fops, which is skipped on ttys whose write operation isn't
tty_write().  This means that, for example, /dev/console whose write
op is redirected_tty_write() is never actually marked hung up.

Because n_tty_read() uses the hung up status to decide whether to
abort the waiting readers, the lack of hung-up marking can lead to the
following scenario.

 1. A session contains two processes.  The leader and its child.  The
    child ignores SIGHUP.

 2. The leader exits and starts disassociating from the controlling
    terminal (/dev/console).

 3. __tty_hangup() skips setting f_op to hung_up_tty_fops.

 4. SIGHUP is delivered and ignored.

 5. tty_ldisc_hangup() is invoked.  It wakes up the waits which should
    clear the read lockers of tty->ldisc_sem.

 6. The reader wakes up but because tty_hung_up_p() is false, it
    doesn't abort and goes back to sleep while read-holding
    tty->ldisc_sem.

 7. The leader progresses to tty_ldisc_lock() in tty_ldisc_hangup()
    and is now stuck in D sleep indefinitely waiting for
    tty->ldisc_sem.

The following is Alan's explanation on why some ttys aren't hung up.

 http://lkml.kernel.org/r/20171101170908.6ad08580@alans-desktop

 1. It broke the serial consoles because they would hang up and close
    down the hardware. With tty_port that *should* be fixable properly
    for any cases remaining.

 2. The console layer was (and still is) completely broken and doens't
    refcount properly. So if you turn on console hangups it breaks (as
    indeed does freeing consoles and half a dozen other things).

As neither can be fixed quickly, this patch works around the problem
by introducing a new flag, TTY_HUPPING, which is used solely to tell
n_tty_read() that hang-up is in progress for the console and the
readers should be aborted regardless of the hung-up status of the
device.


The following is a sample hung task warning caused by this issue.

  INFO: task agetty:2662 blocked for more than 120 seconds.
        Not tainted 4.11.3-dbg-tty-lockup-02478-gfd6c7ee-dirty #28
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
      0  2662      1 0x00000086
  Call Trace:
   __schedule+0x267/0x890
   schedule+0x36/0x80
   schedule_timeout+0x23c/0x2e0
   ldsem_down_write+0xce/0x1f6
   tty_ldisc_lock+0x16/0x30
   tty_ldisc_hangup+0xb3/0x1b0
   __tty_hangup+0x300/0x410
   disassociate_ctty+0x6c/0x290
   do_exit+0x7ef/0xb00
   do_group_exit+0x3f/0xa0
   get_signal+0x1b3/0x5d0
   do_signal+0x28/0x660
   exit_to_usermode_loop+0x46/0x86
   do_syscall_64+0x9c/0xb0
   entry_SYSCALL64_slow_path+0x25/0x25

The following is the repro.  Run "$PROG /dev/console".  The parent
process hangs in D state.

  #include <sys/types.h>
  #include <sys/stat.h>
  #include <sys/wait.h>
  #include <sys/ioctl.h>
  #include <fcntl.h>
  #include <unistd.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <errno.h>
  #include <signal.h>
  #include <time.h>
  #include <termios.h>

  int main(int argc, char **argv)
  {
	  struct sigaction sact = { .sa_handler = SIG_IGN };
	  struct timespec ts1s = { .tv_sec = 1 };
	  pid_t pid;
	  int fd;

	  if (argc < 2) {
		  fprintf(stderr, "test-hung-tty /dev/$TTY\n");
		  return 1;
	  }

	  /* fork a child to ensure that it isn't already the session leader */
	  pid = fork();
	  if (pid < 0) {
		  perror("fork");
		  return 1;
	  }

	  if (pid > 0) {
		  /* top parent, wait for everyone */
		  while (waitpid(-1, NULL, 0) >= 0)
			  ;
		  if (errno != ECHILD)
			  perror("waitpid");
		  return 0;
	  }

	  /* new session, start a new session and set the controlling tty */
	  if (setsid() < 0) {
		  perror("setsid");
		  return 1;
	  }

	  fd = open(argv[1], O_RDWR);
	  if (fd < 0) {
		  perror("open");
		  return 1;
	  }

	  if (ioctl(fd, TIOCSCTTY, 1) < 0) {
		  perror("ioctl");
		  return 1;
	  }

	  /* fork a child, sleep a bit and exit */
	  pid = fork();
	  if (pid < 0) {
		  perror("fork");
		  return 1;
	  }

	  if (pid > 0) {
		  nanosleep(&ts1s, NULL);
		  printf("Session leader exiting\n");
		  exit(0);
	  }

	  /*
	   * The child ignores SIGHUP and keeps reading from the controlling
	   * tty.  Because SIGHUP is ignored, the child doesn't get killed on
	   * parent exit and the bug in n_tty makes the read(2) block the
	   * parent's control terminal hangup attempt.  The parent ends up in
	   * D sleep until the child is explicitly killed.
	   */
	  sigaction(SIGHUP, &sact, NULL);
	  printf("Child reading tty\n");
	  while (1) {
		  char buf[1024];

		  if (read(fd, buf, sizeof(buf)) < 0) {
			  perror("read");
			  return 1;
		  }
	  }

	  return 0;
  }


Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: stable@vger.kernel.org
---
Hello,

This patch was initially posted several months ago as a sort of RFC.

 http://lkml.kernel.org/r/20171101020651.GK3252168@devbig577.frc2.facebook.com

IIUC Alan's explanation correctly, this workaround actually seems like
the right thing to do, so I refreshed the patch, added some comments
and updated the patch description accordingly.

We've been running this in the fleet for the past couple months to
avoid the process hang issues and it hasn't caused any issues.  Greg,
can you please pick it up?

Thanks.

 drivers/tty/n_tty.c  |    6 ++++++
 drivers/tty/tty_io.c |    9 +++++++++
 include/linux/tty.h  |    1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 5c0e59e..cbe98bc 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2180,6 +2180,12 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 				}
 				if (tty_hung_up_p(file))
 					break;
+				/*
+				 * Abort readers for ttys which never actually
+				 * get hung up.  See __tty_hangup().
+				 */
+				if (test_bit(TTY_HUPPING, &tty->flags))
+					break;
 				if (!timeout)
 					break;
 				if (file->f_flags & O_NONBLOCK) {
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index eb9133b..63114ea 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -586,6 +586,14 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 		return;
 	}
 
+	/*
+	 * Some console devices aren't actually hung up for technical and
+	 * historical reasons, which can lead to indefinite interruptible
+	 * sleep in n_tty_read().  The following explicitly tells
+	 * n_tty_read() to abort readers.
+	 */
+	set_bit(TTY_HUPPING, &tty->flags);
+
 	/* inuse_filps is protected by the single tty lock,
 	   this really needs to change if we want to flush the
 	   workqueue with the lock held */
@@ -640,6 +648,7 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 	 * from the ldisc side, which is now guaranteed.
 	 */
 	set_bit(TTY_HUPPED, &tty->flags);
+	clear_bit(TTY_HUPPING, &tty->flags);
 	tty_unlock(tty);
 
 	if (f)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 0a6c71e..47f8af2 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -364,6 +364,7 @@ struct tty_file_private {
 #define TTY_PTY_LOCK 		16	/* pty private */
 #define TTY_NO_WRITE_SPLIT 	17	/* Preserve write boundaries to driver */
 #define TTY_HUPPED 		18	/* Post driver->hangup() */
+#define TTY_HUPPING		19	/* Hangup in progress */
 #define TTY_LDISC_HALTED	22	/* Line discipline is halted */
 
 /* Values for tty->flow_change */
