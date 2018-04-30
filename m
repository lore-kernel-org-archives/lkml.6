Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqaaHG5ewg/JkvUNl5/W8vJm6Oiz1iLVhB1FKvyED4IeRycCBg2G6vkgmEBN/k24c0qwY6e
ARC-Seal: i=1; a=rsa-sha256; t=1525116453; cv=none;
        d=google.com; s=arc-20160816;
        b=qdolvTOB5DTGlPqXxvx4wgDZCkLcVy1XZwmL/4cxv0kAb/vpnAmHUG6o3BWK2tKLlk
         UI3l+owC6uNtcT6M5ykcNWVYHRkkMNHRD7MyIbDBTXCBpbmi9mWAc3uW59czAWbu0wti
         T65Q72yEqFZFQNuSQUB27/fRq1CF9kY9v9iXyH7MsmVWMOG3uTjF8BoZJQHe/iDvT6w8
         MKVQJvWjIfhr3esn5RfKqEyd8PZOAwtnt4Yf5HlX/BKE51BHDPKwxbUOFnV6NwUcUd9z
         FpaudcBoSFmoAidPS4vleSKrYtnnSVYuEiz+f6/pSZNUDHio2WPSPMV8XawQKnMh6+yQ
         v8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=BKh7Ir1/RlNzX4r9lKuHZTU9m4ccm2bEi2PNbj59Vq8=;
        b=XIvhN4V5xV8FyNjJB/cLQHnGHayx/vYrIiJUPFxbzBlNHGYbu0ixhPM64UO7anvtdf
         iOwd+17fKQMuJBeJxBPwRjFimp3F4FsTzUfFS1I/nDDEemPSscsEawAgFXmA/PPjJxJ7
         8WP1l8h93v773W57Y017Y0Ludb1NN/ThftaeX6HO/GHhFvyl1XK2gFnzUz8iDMf08UVR
         dMrTsTkVSPlNJTzgvgkNzkbEdqXzOH4pubfj4BQwwRJPC3LDSCY66A20owILOpdkR/Xm
         7XkulJ38z8KzwxHzf0Jy+iMyAwCLYdY/V3BWGT0uBWu8vkBQnrNHYqcaYs5baPL1ykQ9
         cjPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D359522DCB
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
Subject: [PATCH 4.14 33/91] tty: Use __GFP_NOFAIL for tty_ldisc_get()
Date: Mon, 30 Apr 2018 12:24:15 -0700
Message-Id: <20180430184005.898132642@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200280833625701?=
X-GMAIL-MSGID: =?utf-8?q?1599200510624173444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
