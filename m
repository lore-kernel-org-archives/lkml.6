Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpGV4MtazXkrx3SetimT1L/BIFiWUwU1Uy57Weec1VGdtZpqXVDvN9giYFimtMpCYYjf5cj
ARC-Seal: i=1; a=rsa-sha256; t=1525116452; cv=none;
        d=google.com; s=arc-20160816;
        b=majKGpXxxqjArrsGe+7emuS7K7l0/BqOiqfKNOTkmgcjDFCGv1TCkqabi2uJ5jbv66
         3XA4B4wRtHyS4/T+ZpSCRuLt/SBXS+kDnwbpCzqNGvroaMAG5MlmAWZFPIK7nRUZ8BzW
         PAeiX1Gllrq/Rnvh1qWYQvzRxpeRWU1n4/l1F4zkkiUfToNafEGpcqyU7JD9tHwcFs2Y
         rOiBxYQFSP/2Tj2AyQi1Fq40dCgFvgPMeoVsTaOA162/PJnaHCmc+ZfnwdUVhQGmheC3
         PlKaR+df69RZYOJhf9Mkj+w++oAEsKSU0Kvu2RQ20ccJs1YfLs2YS3cBwSf38+FWFegi
         8NYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Kw+n2UISrW/jaVgI2BwNqyohNgQM5v2p7dXBY0+FRuQ=;
        b=mGwY4oOZVWlZGbmIcXfD5H6kmtM0Jztz43VwdfHjwVgq/3Ci+berjhqVHhAMrc4s1W
         PQJgEHvsyJY6P7AC2y5RKtdys8h6/nHi1joyP0zTEgC0HiS4CLh46SmC8StDeGxslEBo
         /9bi0OG+ECraTNNr9nWiN2AZ9UDKTbjrVuNo/2D3oFd3TKJxNvaRmeRm0VD74Ny+lZCK
         WrWCDtiqNujBYamh1gY0B9FcE88EGJmEVZdbL/Te3jbHuHqVavRXiHO3Teq0NXwx1SQr
         W02ZInczK5zPGat8kXsqMJlnMtRWINpaODZbHaPHNIhIapPBnyUFfLehyUpI8Uf61YCv
         Paew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7F722DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jiri Slaby <jslaby@suse.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alan Cox <alan@llwyncelyn.cymru>,
	Christoph Hellwig <hch@lst.de>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 4.14 32/91] tty: Avoid possible error pointer dereference at tty_ldisc_restore().
Date: Mon, 30 Apr 2018 12:24:14 -0700
Message-Id: <20180430184005.847588872@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200577624150021?=
X-GMAIL-MSGID: =?utf-8?q?1599200509148199259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 598c2d41ff44889dd8eced4f117403e472158d85 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_ldisc.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -526,19 +526,16 @@ static int tty_ldisc_failto(struct tty_s
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
 
