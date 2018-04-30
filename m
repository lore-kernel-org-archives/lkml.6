Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp6Oj/zZs/Td/CGSp3IoBL2Xc8ktz9NrchCl9UCKSsQXx9KNm83+bj0szuYdi9jm/P0/VND
ARC-Seal: i=1; a=rsa-sha256; t=1525116385; cv=none;
        d=google.com; s=arc-20160816;
        b=c9dgCY7R1gMy/H8/zJV/UbNT0FAfHFunJzD+PstADhTulT0kCXlOiwysUVxSslZx8L
         OOU0fi/LYmEYFDkktQEQ5j9AW+xbFqsYGyYvCP2APk7GZi6QYXSTuEg+oUaqdbiSxWSL
         4xtoK+5SNbNZSTnyTnWiD4GRoVSh8Mw82w+09rC5aWkQjqrJEdprn6s0QSBdXplsOKm2
         V7833IvSjJBCb0fnoK0HbjwLPVEeDCONN2+quemkxMB2Iq+gTuaVg0r7pIs8g3QZbUZc
         SH+kd44PH+LygY5iUvScAqNRagOkmJEP3XKY3w7R7ks5pdfIRUN5M5JqmfwOny9e1pTu
         oR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=YdkX13b8iSCcZ2b+e1okolvRpPFOWkIASMm95cO9u80=;
        b=LJIASifzAbzOX1la1pNlQs3lwmQLerXgiq6QV36b0MroKI7P0Wk0Dsut5nXZIAwclU
         1+wfMJ+ccAkHxWcxpygttgmBUBMIq7Iiz7H3HIAXff+yR0gq19dynEfnEVChzJXXgR9T
         HCCDRLtFbP8pTITZa20v/nXfl+pSLwZEeUu2vXTrYZJkH2j+yeyB/MtPIUQtVvCIl7Md
         BB0KyqxMmqv9aV3f7Ot4IbPat0ku9EpBZAFdF4LJZcasiCWYSj9ZOsvj/TBhvuEguLbA
         KmHYyZNB2h7A4IZeIwP1TaPGLqJ9oTkOpHh76HJXlDmDb/t+OW1vpZo0EYAYHAZ0Xue5
         GHCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9413422DC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Vegard Nossum <vegard.nossum@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jiri Slaby <jslaby@suse.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 23/61] tty: Use __GFP_NOFAIL for tty_ldisc_get()
Date: Mon, 30 Apr 2018 12:24:26 -0700
Message-Id: <20180430183953.271720856@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200280833625701?=
X-GMAIL-MSGID: =?utf-8?q?1599200438421331694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit bcdd0ca8cb8730573afebcaae4138f8f4c8eaa20 upstream.

syzbot is reporting crashes triggered by memory allocation fault injection
at tty_ldisc_get() [1]. As an attempt to handle OOM in a graceful way, we
have tried commit 5362544bebe85071 ("tty: don't panic on OOM in
tty_set_ldisc()"). But we reverted that attempt by commit a8983d01f9b7d600
("Revert "tty: don't panic on OOM in tty_set_ldisc()"") due to reproducible
crash. We should spend resource for finding and fixing race condition bugs
rather than complicate error paths for 2 * sizeof(void *) bytes allocation
failure.

[1] https://syzkaller.appspot.com/bug?id=489d33fa386453859ead58ff5171d43772b13aa3

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_ldisc.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -175,12 +175,11 @@ static struct tty_ldisc *tty_ldisc_get(s
 			return ERR_CAST(ldops);
 	}
 
-	ld = kmalloc(sizeof(struct tty_ldisc), GFP_KERNEL);
-	if (ld == NULL) {
-		put_ldops(ldops);
-		return ERR_PTR(-ENOMEM);
-	}
-
+	/*
+	 * There is no way to handle allocation failure of only 16 bytes.
+	 * Let's simplify error handling and save more memory.
+	 */
+	ld = kmalloc(sizeof(struct tty_ldisc), GFP_KERNEL | __GFP_NOFAIL);
 	ld->ops = ldops;
 	ld->tty = tty;
 
