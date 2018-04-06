Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx49FC4q+cSJNhRXtFoFkIITOaT+Twb2dnl5UBFEI3/KeIYmuw+ReW1yk8mzFmCWsk1cDcJ+G
ARC-Seal: i=1; a=rsa-sha256; t=1523009225; cv=none;
        d=google.com; s=arc-20160816;
        b=AzESGj5GuGbTvl/UG8jX6U+ZafSRpehsPmP8m+1JbuY8nDbgCF9nmXtMnzJ4TuZQ4I
         Bnews+HUok26lfW0fN3QKeuxnSou/fQrfXTqYbNXTQSDmwMnHorfDNJgXB4HzZGLhJBB
         6W6l9M3+mVpfXemjJoGrXzu8wthQI3m7GRoIoJ5K5xC+cBXNiXcZLpSxbkiV2Nm5lo+y
         n2z1ISr07mutSqOlRJyq3nxrZHdaKcgSd3gFW758sfTyEOqVXk5AcZH5dT7uBaXLzCDb
         XCTIpJp37JjDCy3H6USLtYn1pzzRAGUA/0kErSw0+7pH884c16DuDoSJEV0ossABGF/x
         SLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=DeG+IoBF5H0ZNXWDO9YHG2UT5t08If2xkjQyXOy+6lo=;
        b=yQweCrAa5AsE797FCCAumzDhBwTNYLk4q9F3hZx8k75Cb3/Yo5v/k3FkBCuuMXYI2z
         P9weekzg2HlvxvKZBW6A9kOJXN+UT+5kGjBON/AGdeg763QMtP2rb3hMzBbLb36eOHxV
         Xx0TvKQR3VsSZ2SCXAFhBmD/Ky0zr2WCVD/R0NG2OGtra2fJBZjojdfjaOoLHmB9kZgp
         69VHCTf5rPS0Pr1MAd8otTEnie4YsXri9ADxytLjb+aAG54335UDmcd2P/9W1FX27CVc
         CRR/pI0tHbEUZxPTnuoJ9rOaygkMuuLGF4o27OMPHZ4WTHy6RrbchyoAVJdEQ8jZPJKK
         LUAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: KASAN: user-memory-access Write in n_tty_set_termios
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: syzbot <syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <001a113ed31a122ced0568cc6be1@google.com>
 <db45a090-593d-23d2-e6b2-ede5b308f02f@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <35d649ce-0c22-f839-aa4d-19733bf31a9c@I-love.SAKURA.ne.jp>
Date: Fri, 6 Apr 2018 19:06:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <db45a090-593d-23d2-e6b2-ede5b308f02f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563981043488445?=
X-GMAIL-MSGID: =?utf-8?q?1596990920952013607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/04/05 19:31, Tetsuo Handa wrote:
> Hello.
> 
> I manually simplified the reproducer. Since the bug is timing dependent,
> this reproducer might fail to reproducer the bug. Anyway, I guess that
> there is a race condition between
> 
> 	vfree(ldata);
> 	tty->disc_data = NULL;
> 
> at n_tty_close() by something (ioctl(TIOCVHANGUP) ?) and
> 
> 	struct n_tty_data *ldata = tty->disc_data;
> 
> 	if (!old || (old->c_lflag ^ tty->termios.c_lflag) & (ICANON | EXTPROC)) {
> 		bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
> 
> at n_tty_set_termios() by ioctl(TCSETS), for the report says that ldata == NULL
> ("Write of size 512 at addr 0000000000001060").

I confirmed that ioctl(TIOCVHANGUP) versus ioctl(TCSETS) can race.
We need some lock for protecting tty->disc_data.

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1861,6 +1861,7 @@ static void n_tty_close(struct tty_struct *tty)

        vfree(ldata);
        tty->disc_data = NULL;
+       WARN_ON(1);
 }

 /**

ioctl(TIOCVHANGUP):
[   75.176171] RIP: 0010:n_tty_close+0x34/0x40   /* drivers/tty/n_tty.c:1863 */
[   75.176193] Call Trace:
[   75.176200]  tty_ldisc_kill+0x15/0x30         /* drivers/tty/tty_ldisc.c:641 */
[   75.176204]  tty_ldisc_hangup+0xfa/0x1c0      /* drivers/tty/tty_ldisc.c:758 */
[   75.176209]  __tty_hangup.part.26+0x16b/0x280 /* drivers/tty/tty_io.c:623 */
[   75.176216]  tty_ioctl+0x61f/0x950            /* drivers/tty/tty_io.c:2585 */
[   75.176244]  do_vfs_ioctl+0xa7/0x6d0          /* fs/ioctl.c:686 */
[   75.176257]  ksys_ioctl+0x6b/0x80             /* fs/ioctl.c:701 */
[   75.176266]  SyS_ioctl+0x5/0x10               /* fs/ioctl.c:706 */
[   75.176268]  do_syscall_64+0x6e/0x270         /* arch/x86/entry/common.c:287 */

ioctl(TCSETS):
[   75.783367] BUG: unable to handle kernel paging request at 0000000000001060
[   75.934024] RIP: 0010:n_tty_set_termios+0x17c/0x2a0 /* drivers/tty/n_tty.c:1766 */
[   75.950549] Call Trace:
[   75.952733]  tty_set_termios+0x18a/0x200            /* drivers/tty/tty_ioctl.c:342 */
[   75.954915]  set_termios+0x14a/0x250                /* drivers/tty/tty_ioctl.c:414 */
[   75.956823]  tty_mode_ioctl+0x42e/0x4f0             /* drivers/tty/tty_ioctl.c:749 */
[   75.958632]  tty_ioctl+0x128/0x950                  /* drivers/tty/tty_io.c:2655 */
[   75.968883]  do_vfs_ioctl+0xa7/0x6d0                /* fs/ioctl.c:686 */
[   75.972892]  ksys_ioctl+0x6b/0x80                   /* fs/ioctl.c:701 */
[   75.977031]  SyS_ioctl+0x5/0x10                     /* fs/ioctl.c:706 */
[   75.977036]  do_syscall_64+0x6e/0x270               /* arch/x86/entry/common.c:287 */
