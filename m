Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZps1KfrvBwN6uU9s3gd0d40PyypTNZjbiN3tryXRPwgpUX+MbT/QXf/WlbqS3mfn0leC+Fo
ARC-Seal: i=1; a=rsa-sha256; t=1525116368; cv=none;
        d=google.com; s=arc-20160816;
        b=JGwvskDFXwf6qPx9tGX2jAmX7oaK4BdDNATWCcnvhVwZyINKvvogfRy3euvCzq92NU
         WvmpDlAp8vuxCOgdvfecAxmkjrMG/UI68GZpZUHZBcE4x1LjRqby8cyp3GTBujaNYJfk
         rM5smNeuaBypQCV6fvY6daZgRf/3htpHA0PSs2q6lbk9B2+XAhbUlBghmg/I0O44lDw2
         DxH8cQQeVHTmLXO9PzRrbFjcLhf3AOB+Fggv6opWGdICDNvsBTINCEsP/kkVko95ThoE
         k+bmQlvrKegBFU8ssGB0R9xr/WgWs+F3MZL1qgdIvGm2A6FNHLWnUAy0uVvlpMFmA9cd
         /nBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=HjzndYgWAxmyz00ycVK6o2yyr26VrC7ZxcOxvL9lhYM=;
        b=HqZpTZUsmFt4d+w/KZ3qHM5xEP4onCWLm3VEQJiuDkQPYUL1f7xMpwI+xPoRornFqn
         PxeUkgSe5yOXKTarzJdOkZKjZkwJebV/UqrqgW1KY8BOFFS0X3tQc39m19cgObvhzQp3
         401LXkxwd+FJgCVjBMrJ200h9T695wy2aRbcgq4gA/juBXOjuZuYbjzY3ynY3WAB5EkM
         cqC+8nsg5DsHCZP+I8aji6KT6wtVQ9map6CsMn0YnGbWgtX1AOkQmiWZeC0QuZrep8F0
         erWqDhsQRuLOEfSijUzyoPCyP+tEjeMPG4DcLkpcho2hBLd9KdOhOciBQUSud5+G6RG3
         J0tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3502322DCC
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
Subject: [PATCH 4.4 19/44] tty: Use __GFP_NOFAIL for tty_ldisc_get()
Date: Mon, 30 Apr 2018 12:24:30 -0700
Message-Id: <20180430190947.110953301@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200280833625701?=
X-GMAIL-MSGID: =?utf-8?q?1599200421515415711?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -168,12 +168,11 @@ static struct tty_ldisc *tty_ldisc_get(s
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
 
