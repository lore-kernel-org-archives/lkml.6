Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx4/puZs30xVHSn/Skls1/SdLxrpuiZqjR9Jc/pbX6IMuHyKdAAUb+XEHdBCUpUdX/feEe+on
ARC-Seal: i=1; a=rsa-sha256; t=1522924826; cv=none;
        d=google.com; s=arc-20160816;
        b=WmC6TRCBeKF8NBWIb7mb+KJ2YwewjwxcBh8EvegZXjt+WYH65xJ/fJQGjbXFkFGim2
         r2Rw7x5/a89QKE72blq5clYR5LtxrUCbnNV7DNEwbQND99pVELB3fLvdc+FJnVNd3URg
         sTzLr6c2EV2HGhwo8tMsAe2nL8poav6U+fNf4D9b4V0s3dEa4vqNA/B/mXtbZMwc9W/2
         AI+XHF2672dg4mFqpY8UQxpQ2uaqwscetMemcKodkrLHrBtPDb8ypO2VEm5MntCSI30I
         OoLBfeBA0h6yRlfbPt0t8X9OFZUZbbT2/XwsO3Tyyik7+uOFSN1U/L1ICotFHdoEQ2PW
         I43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=smI5J8EPpSxNEkpc2IgwlT++mGWTUGMTCkNT/lX4s3s=;
        b=fVWsSSA+EzM/x2Yqrpv8hGMy/dwUImq0uSboTBOimNJdlc0ynac23mfMb4dw1762At
         oxafZwc+ZkDhnH36+o6F1OlLNH3RKMS3UKfd9Bgv3kLKCOjGjW0DUJM+CO5jQKqCwf8r
         XhconO33zk5QOfTab3q5SyncvD10TEbPUNQAPVWJQBHXfNC+/3M4y+NEh19tcwZv/Ij/
         HcH68I8o4yZnWQ/Bd0+c7qSjopDdlBeO8nVRtB2WPS9GXzUiQWDqUpwvXEH0YtlwVHuQ
         FMjXbJ11BDWAzirLyC2MkEyvroLUyKMJT0f6hKynlYTjpkrT03vkQNvjx7PSXFpZBJQG
         mHlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: [PATCH] tty: Don't call panic() at tty_ldisc_init()
To: Greg KH <gregkh@linuxfoundation.org>,
        syzbot
 <bot+57840b4d2cc5c46981d5b9e07c9b7b06d5bcf064@syzkaller.appspotmail.com>,
        jslaby@suse.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <94eb2c0630b4161a5e055d38a2e3@google.com>
 <20171105103434.GC1487@kroah.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <15c6c6bc-6592-8f0c-db84-647c5760f1d2@I-love.SAKURA.ne.jp>
Date: Thu, 5 Apr 2018 19:40:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20171105103434.GC1487@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1583216279267837963?=
X-GMAIL-MSGID: =?utf-8?q?1596902422633775295?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

syzbot is reporting kernel panic [1] triggered by memory allocation failure
at tty_ldisc_get() from tty_ldisc_init(). But since both tty_ldisc_get()
and caller of tty_ldisc_init() can cleanly handle errors, tty_ldisc_init()
does not need to call panic() when tty_ldisc_get() failed.

[1] https://syzkaller.appspot.com/bug?id=883431818e036ae6a9981156a64b821110f39187

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/tty/tty_io.c    | 5 ++++-
 drivers/tty/tty_ldisc.c | 5 +++--
 include/linux/tty.h     | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 63114ea..7c838b9 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2816,7 +2816,10 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 
 	kref_init(&tty->kref);
 	tty->magic = TTY_MAGIC;
-	tty_ldisc_init(tty);
+	if (tty_ldisc_init(tty)) {
+		kfree(tty);
+		return NULL;
+	}
 	tty->session = NULL;
 	tty->pgrp = NULL;
 	mutex_init(&tty->legacy_mutex);
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 050f4d6..08ddb2c 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -824,12 +824,13 @@ void tty_ldisc_release(struct tty_struct *tty)
  *	the tty structure is not completely set up when this call is made.
  */
 
-void tty_ldisc_init(struct tty_struct *tty)
+int tty_ldisc_init(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld = tty_ldisc_get(tty, N_TTY);
 	if (IS_ERR(ld))
-		panic("n_tty: init_tty");
+		return PTR_ERR(ld);
 	tty->ldisc = ld;
+	return 0;
 }
 
 /**
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 47f8af2..1dd587ba 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -701,7 +701,7 @@ static inline int tty_port_users(struct tty_port *port)
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
 extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
 extern void tty_ldisc_release(struct tty_struct *tty);
-extern void tty_ldisc_init(struct tty_struct *tty);
+extern int __must_check tty_ldisc_init(struct tty_struct *tty);
 extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 				 char *f, int count);
-- 
1.8.3.1
