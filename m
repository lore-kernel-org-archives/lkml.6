Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsFVLJdmqw7tv0Wk7JfKxv1Nq14ZIZAF2GvCCykRREb+EZxzvosrCR8fvRLmKWCRPPRI6jc
ARC-Seal: i=1; a=rsa-sha256; t=1519831340; cv=none;
        d=google.com; s=arc-20160816;
        b=T9kF3pWpTT8DGyDutHl083UAZUh+D9Ws561As81xg+xq4Jgr6CSGH5EV6hjJOSXKIN
         TqSv+h0Xsmk1D5GsIQrp6q87xuIhWSlRjJRzUT+kUvFKtB/rGziOG+Git9NWrxavgj4j
         0l6id+axAab89sOUrWtKW5ynzH66yPoFPkqpdhhWAMqrnofaBEY8Zbx2euqb4NhBm5xx
         X6eIitZP5ACreEWgw8v+/5MJKJXGkrGdDumC+l5TnQBNB8NxCSeiFtgxM3PXmB2UXE1M
         0QlOZjdJyc5It7vnfDgzreWUmFIseYfIEf+tTGxLZRiuQTnDzjiBw/w93GS7KQc+dKcq
         7HpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=ynJC4YipiN6sPp5+H79hiUFHmZ2Xko/qakkPc2KdBqQ=;
        b=SqAbdhekCGGBSJC1E8tzSDyymo2riSzqyCx5jT/Rdp1kkVfY/JWUjNlFUJpNV4hkEY
         Jp2Bn6+5aYKVrnXydFkqubS1DCZwnPM9WBuB8BjG+3puUATC6aA5oyP/v/QvZ4F41Lvl
         eW+6NiH3va46HidLJ0fxsss8UyYZyxHHWE83Pl6Cgi8ged+p9T25ZizFh0DNUlE0hN6T
         Cgb4nYCdHe8W5FhPi6jlcoDeiCDTOvgkcqZ8nJ6CWH0otVHzg9+q+6lvnHZss76nrdNC
         A6OsLDGLxbWap+WK2Y2Ht9I1Dy5di5jOb97R12ql91CWFbx+dR+CFnT5lVg3qfo03xKS
         AuOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>,
 "syzkaller" <syzkaller@googlegroups.com>,
 "Jiri Slaby" <jslaby@suse.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.121669136@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 064/140] n_tty: fix EXTPROC vs ICANON interaction with
 TIOCINQ (aka FIONREAD)
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658668272179572?=
X-GMAIL-MSGID: =?utf-8?q?1593658668272179572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 966031f340185eddd05affcf72b740549f056348 upstream.

We added support for EXTPROC back in 2010 in commit 26df6d13406d ("tty:
Add EXTPROC support for LINEMODE") and the intent was to allow it to
override some (all?) ICANON behavior.  Quoting from that original commit
message:

         There is a new bit in the termios local flag word, EXTPROC.
         When this bit is set, several aspects of the terminal driver
         are disabled.  Input line editing, character echo, and mapping
         of signals are all disabled.  This allows the telnetd to turn
         off these functions when in linemode, but still keep track of
         what state the user wants the terminal to be in.

but the problem turns out that "several aspects of the terminal driver
are disabled" is a bit ambiguous, and you can really confuse the n_tty
layer by setting EXTPROC and then causing some of the ICANON invariants
to no longer be maintained.

This fixes at least one such case (TIOCINQ) becoming unhappy because of
the confusion over whether ICANON really means ICANON when EXTPROC is set.

This basically makes TIOCINQ match the case of read: if EXTPROC is set,
we ignore ICANON.  Also, make sure to reset the ICANON state ie EXTPROC
changes, not just if ICANON changes.

Fixes: 26df6d13406d ("tty: Add EXTPROC support for LINEMODE")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: syzkaller <syzkaller@googlegroups.com>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1459,7 +1459,7 @@ static void n_tty_set_termios(struct tty
 	BUG_ON(!tty);
 
 	if (old)
-		canon_change = (old->c_lflag ^ tty->termios->c_lflag) & ICANON;
+		canon_change = (old->c_lflag ^ tty->termios->c_lflag) & (ICANON | EXTPROC);
 	if (canon_change) {
 		memset(&tty->read_flags, 0, sizeof tty->read_flags);
 		tty->canon_head = tty->read_tail;
@@ -2096,7 +2096,7 @@ static int n_tty_ioctl(struct tty_struct
 	case TIOCINQ:
 		/* FIXME: Locking */
 		retval = tty->read_cnt;
-		if (L_ICANON(tty))
+		if (L_ICANON(tty) && !L_EXTPROC(tty))
 			retval = inq_canon(tty);
 		return put_user(retval, (unsigned int __user *) arg);
 	default:
