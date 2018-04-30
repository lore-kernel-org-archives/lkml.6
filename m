Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo0aWQQj5PG/mPfxOJVYhhRAm7/Pjaojg67wJG3k/5dQfN34Nq63h0XgsmKywCTzKPW9RCr
ARC-Seal: i=1; a=rsa-sha256; t=1525116487; cv=none;
        d=google.com; s=arc-20160816;
        b=d8fUjU8NIY/R2no2lrj4zvtrtTw7F7qOIqI5Ch5Fw8BMCvOd1I3J1sqyGXZup5qN1p
         meJHABacb7xLMqCJanQ2OyxYABCUnSrytKQC8Fn9CJqFmvZpailmxtjEY3aCgsmnLxKa
         CxqCwcylBi30dv6g3gQgJ4ukVnEcDhRnNdnMj+FwsihwR4MTCbgrYpIPXXc4Uu76pmcs
         fIqPWUK1etGUvL4OmcFY0VntvcPrvTqIIphdX/Q13/GAt4eIEHI1aSJVFSyySfEBjoom
         cQgmGMSLod7wFkye+SWqBOmk1KOg8ck7SIPJn/fSnjZuuu/eCIP3C7GSqHb9kxmgUmNV
         kN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=LAOXkOdbAVuQ3uoYzodTFfllowpOstsTPg6lKgubdaY=;
        b=l9pXcj6Z1/ASybCzOg/a3wTIN6AYvL5OcfQcVnOrePNpcLK3Cu2RXqaUH7el/gUOmI
         nYuW9xVSnSIVa2TTc/NTXqBTN0Lqlq23YdoePZEil4yMnsXMip2qEcNF0i2jITJ0J/69
         +OpmUzyPahgHNcaVf744FR39wZ3c4acToX8nJVBr9t20+KKl7d0J4PE5mfSqNd+lBumT
         0QY/ef56DDomyIsgt133HJYCYI32ulDtov+iBLfZ3Uws83Q9Tu/aInGK2+LK/KUqtEfc
         W06UVw/ChspdJdsZFn0s0znSKnlumeuvrCdCUvlrO+6j9S6cX/yn/fnNe5uaAiXe/Z4u
         r+2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3A322DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzkaller@googlegroups.com>,
	Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 4.16 031/113] tty: Dont call panic() at tty_ldisc_init()
Date: Mon, 30 Apr 2018 12:24:02 -0700
Message-Id: <20180430184016.382970214@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200428340821221?=
X-GMAIL-MSGID: =?utf-8?q?1599200546500592168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 903f9db10f18f735e62ba447147b6c434b6af003 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c    |    5 ++++-
 drivers/tty/tty_ldisc.c |    5 +++--
 include/linux/tty.h     |    2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2816,7 +2816,10 @@ struct tty_struct *alloc_tty_struct(stru
 
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
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -824,12 +824,13 @@ EXPORT_SYMBOL_GPL(tty_ldisc_release);
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
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -701,7 +701,7 @@ extern int tty_unregister_ldisc(int disc
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
 extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
 extern void tty_ldisc_release(struct tty_struct *tty);
-extern void tty_ldisc_init(struct tty_struct *tty);
+extern int __must_check tty_ldisc_init(struct tty_struct *tty);
 extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 				 char *f, int count);
