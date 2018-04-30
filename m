Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZom6g3qcsOiXFHZMydqT2NZsDeV2ey1+dVNFlxjwslu4z0mXFWV5VvR7w1m0kqRGqXu62H0
ARC-Seal: i=1; a=rsa-sha256; t=1525116517; cv=none;
        d=google.com; s=arc-20160816;
        b=YAKPTSFlAJNO1qRpzSPxeIwsZqQtgCEgADNATm12r1cwzFjw6hKQCU5/3c783IyOrs
         yzF+2Cym5hnpOFnV/ytmJ0/45e3cGzNXc3IFhwolDmZehPawGxJCJB2xhHObu+CR/U50
         FOthS1Ck0U/uuDrwLDSvWZZyyam2+QUPuU5QCeU9ojuoSf6lX2lrRAVb1/Dp9BlgaSxz
         zza5ojO01wxrN6XkWaYlKgTjXNAbxe13Q1L2XxXxD3uJguaXXzyGgAu+h5im6SOuFe82
         SxCjBCxenhwN8U4vPzcnhDvscmfupDR4RvNpFlO5EiKy9C+XtPNZozMW1e33ZOyYpU/O
         sIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=6R9Og3qVgjfLzH/90ShcVVyLnox5KMBd0h/CUQZkl6Q=;
        b=C78y9pfknVW14leZGlKgeqtzzSOayRunTJrKUcAfnjEKPpznDTUp/+TLUkwTefcdcJ
         f9Kj2XvNc9ivM+T1UF6aQnz/H3VGiWjfr5VLgoo0JSmm1GVOdcd3s8Ep86gepJk+/mz0
         +nZSQ95LHorbgwKYoCVQddTPRLrrbXkxYB/e9FoPn+10hNeB5XbNfv+ar+HHuRjZNoSF
         yww87ZyzskqYzmZktM7bIUeMM8BUti8fTr1paH2pwAjOs3VPFy3qGQdZ+hhAY1wzSzYP
         kWxHhs5Cnh7RhGlupMrnFw+RBz1Mke3Xbh8jUatUokqmveXdecfE0pfepQL+dVRasF9C
         k4nQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA07B22DC1
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
Subject: [PATCH 4.16 034/113] tty: Avoid possible error pointer dereference at tty_ldisc_restore().
Date: Mon, 30 Apr 2018 12:24:05 -0700
Message-Id: <20180430184016.495545202@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200577624150021?=
X-GMAIL-MSGID: =?utf-8?q?1599200577624150021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -527,19 +527,16 @@ static int tty_ldisc_failto(struct tty_s
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
 
