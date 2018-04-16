Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx499/WfJG9+sxvKyJCbG7N+0bmlhLSXbIBbz9a3nmzjht2K35QdGW1F7cVF/rF4dTTwxtdIT
ARC-Seal: i=1; a=rsa-sha256; t=1523876803; cv=none;
        d=google.com; s=arc-20160816;
        b=gsng7suICsNWExGJzX2rEuQPwFKt899Ccii30OHKJtu1/KrU3zjXcZbrebtXafQcZL
         XV03A5BDEoSt6ek+2UYwY5ZhGVUxTxOvEToqkRLzJBPGa7etOYP1AROXDxu7u+d2n7y0
         lDgA/L5osqAWsBujyjP1KjS4I6wAjWnBrLnQMrGHO1PVRsQu8DDrWwmhQvDrqkLhOMEn
         xkq3dekuL/2lW0CZ6Pc/BseF5aFnuGZfR7USjyXouvSjrLUz38212eYTPnpge0UaRgdS
         LIRLqe73wpdavHDlCRVeguGbLNfLF9jp/8wwEJJg3x+KMvWcgQrIAuHKBWj24UOtUBjq
         1amA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:date:message-id:in-reply-to:references:from:subject:cc
         :to:arc-authentication-results;
        bh=QTRWJDnfwbSn8/4+wdW7/XDfIDabMA/zbabHMD40F4Q=;
        b=tI0A9FXSgdnnFZXbTA9jrV6K9ca9Esr03OT1ZSR9+i9m7ub38y8DzR7S1hg3up49bV
         7z7vVwIeazGy8+IR6Sy1ZmEz7MBZx2UoeKA1iSDK4Ea1C1FT/Pr6hGI5AiZDThvyapDO
         mAcBIuTUuH8bjmd6I2t9q/SaStITnV1KwIwmEX2SP45tNpyqixFa642gaCLEwlnBv4CI
         TWnsS7Op4uUsMeWSjs47LpOPQCMNWPxkXB8Wj43PiR0KrnI55ctsyNkjOTJqVkb6EIs7
         Nb6BIYRueAkNu++iSscJttEQvozrYJNYTfhcBSWmlyS8YsScs9eIlufRWYn5awwUGGP+
         9jDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: alan@llwyncelyn.cymru,
        bot+1a77aeddeaf63317949b59c3df98f139a1ca34f9@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        dvyukov@google.com, hannes@cmpxchg.org, hch@lst.de, mhocko@suse.com
Subject: [PATCH] tty: Avoid possible error pointer dereference at tty_ldisc_restore().
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <001a1141f0c87da52c055d385a4d@google.com>
	<20171105103404.GB1487@kroah.com>
	<2e8fd7a6-6841-d660-8e1c-17b5a07618fa@I-love.SAKURA.ne.jp>
	<20180405142503.627552ca@alans-desktop>
In-Reply-To: <20180405142503.627552ca@alans-desktop>
Message-Id: <201804162006.GBB48461.FFJFSOMOOQHVLt@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Mon, 16 Apr 2018 20:06:34 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597900643311610411?=
X-GMAIL-MSGID: =?utf-8?q?1597900643311610411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

syzbot is reporting crashes [1] triggered by memory allocation failure at
tty_ldisc_get() from tty_ldisc_restore(). While syzbot stops at WARN_ON()
due to panic_on_warn == true, panic_on_warn == false will after all trigger
an OOPS by dereferencing old->ops->num if IS_ERR(old) == true.

We can simplify tty_ldisc_restore() as three calls (old->ops->num, N_TTY,
N_NULL) to tty_ldisc_failto() in addition to avoiding possible error
pointer dereference.

If someone reports kernel panic triggered by forcing all memory allocations
for tty_ldisc_restore() to fail, we can consider adding __GFP_NOFAIL for
tty_ldisc_restore() case.

[1] https://syzkaller.appspot.com/bug?id=6ac359c61e71d22e06db7f8f88243feb11d927e7

Reported-by: syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/tty/tty_ldisc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 08ddb2c..de007e1 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -527,19 +527,16 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 {
 	/* There is an outstanding reference here so this is safe */
-	old = tty_ldisc_get(tty, old->ops->num);
-	WARN_ON(IS_ERR(old));
-	tty->ldisc = old;
-	tty_set_termios_ldisc(tty, old->ops->num);
-	if (tty_ldisc_open(tty, old) < 0) {
-		tty_ldisc_put(old);
+	if (tty_ldisc_failto(tty, old->ops->num) < 0) {
+		const char *name = tty_name(tty);
+
+		pr_warn("Falling back ldisc for %s.\n", name);
 		/* The traditional behaviour is to fall back to N_TTY, we
 		   want to avoid falling back to N_NULL unless we have no
 		   choice to avoid the risk of breaking anything */
 		if (tty_ldisc_failto(tty, N_TTY) < 0 &&
 		    tty_ldisc_failto(tty, N_NULL) < 0)
-			panic("Couldn't open N_NULL ldisc for %s.",
-			      tty_name(tty));
+			panic("Couldn't open N_NULL ldisc for %s.", name);
 	}
 }
 
-- 
1.8.3.1
