Return-Path: <threeearcat@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524140709; cv=none;
        d=google.com; s=arc-20160816;
        b=FMvtl+6/4lPTeO5Z631QWez1DgOAd10F0KRs6j52+3RFx0fqoMYZeBbYjW4E/rrcN4
         7NQ+7XeLJeetT9jUBooUsysJIdVNveegr5IUjl2AV5bXZQFgLiqTaVtQuKzf+4fdkrte
         OAS7sUjOXJcAQnLvtTBxqRZW5lIQyOlLjQeNMxlDqecvGfIqBxI/iz/tbU0qeUgyBzj7
         a50Nar4LtF7lAP+L/o18Ss4E0CDBqJjZaSRsj0KX4SjVTioHWH4vbelDFQzg2tg+wDjh
         lkRJOmexscetN0t6FEfm2mcq/vciAR8rDrWhbju0g3DRlo7a4ZG2focFddFt054h6kYV
         8ovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=RyNqm1FJxJ9GGtpWmNONgnlXsdC0Vq6Q8eccFXJYxoA=;
        b=yf/L2haCLah7NSi538YhvMiZccvu4yyCoTMf4wD7J+jMGqlBKGJ7go0d3QUdaHIp7c
         4k0WcsV2yK/6N3qfK+63qtkz2oHQIdEuzG+pbGahbNfHMv6MoJubEyl5vPYuxoKyTgdb
         hco46hLoZp9690Boe8EavXWCLV4gieNiWD9JfPD5gdcSSAbjKFamUoo2Q8zeChjjlgU7
         cmohXGXrYFNIWVlRTjCzpCzqwpgJTgRNJpnncrK5dELX2mjAPRqfIUNT4YIQPurBFypL
         h4dbrUnAMWUZJDFAtJB0nRoMOvSYmYVkfbVRoM6VkoSpv/ec6Tu58u4NWXEV0cwuvWou
         QxQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gyx/ahU/;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gyx/ahU/;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZra2Xspmpcv8mgHddgPP0JKLdleS3CUAgo48jxOctJyym8xe4XYfu1Xkgx5RymzDopTdSLkqMkaZQfD1abYEg4=
MIME-Version: 1.0
In-Reply-To: <20180419081735.GA28287@kroah.com>
References: <CACsK=jfSRSLYvPJKzFrRQgNa10DsF8xLLKGYfqqE_hF9ucX-yw@mail.gmail.com>
 <20180419081735.GA28287@kroah.com>
From: DaeRyong Jeong <threeearcat@gmail.com>
Date: Thu, 19 Apr 2018 21:25:08 +0900
Message-ID: <CACsK=jfmwcLA9bsPAPEgvg72C2Cpc-U1oGhi+fO-rN543RKUbQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in tty_insert_flip_string_fixed_flag
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Byoungyoung Lee <byoungyoung@purdue.edu>, Kyungtae Kim <kt0755@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, basavesh@purdue.edu
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598161270730760907?=
X-GMAIL-MSGID: =?utf-8?q?1598177369371321696?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch is attached at the end of this email and can be downloaded from here.
https://kiwi.cs.purdue.edu/static/race-fuzzer/tty_insert_flip_string_fixed_flag.patch

We applied the patch to v4.16 and tested our reproducer. we can't see the
crash any longer.

Our rationale is
  - Since tty_wakeup() called by __start_tty() sends frames, call
    tty_write_lock() before __start_tty().
  - Since tty_write_lock() might sleep, locate tty_write_lock() before
    spin_lock_irq(&tty->flow_lock).
  - Since wake_up_interruptible_poll() is called by both tty_write_unlock()
    and __start_tty(), Prevent calling wake_up_interruptible_poll() twice by
    adding the wakeup flag to tty_write_unlock()

If there is something that we are missing or we are wrong, please let us know.


Thank you.

Best regards,
Daeryong Jeong



diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 63114ea..09c76d3 100644
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
index d9b561d..f331e99 100644
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

On Thu, Apr 19, 2018 at 5:17 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Apr 19, 2018 at 05:09:16PM +0900, DaeRyong Jeong wrote:
>> We report the crash:
>> KASAN: slab-out-of-bounds Write in tty_insert_flip_string_fixed_flag
>>
>> This crash has been found in v4.16 using RaceFuzzer (a modified
>> version of Syzkaller), which we describe more at the end of this
>> report. Our analysis shows that the race occurs when invoking two
>> syscalls concurrently, ioctl$TCXONC(r0, 0x540a, 0x2) and
>> ioctl$TCXONC(r0, 0x540a, 0x1).
>
> Nice!
>
> Do you have a kernel patch to resolve this issue?
>
> thanks,
>
> greg k-h
