Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr/DEpO05d3+Nzt2xBnwH6vq8xLpMGj3I38Om/TffSQvS5GYRvK5PjGYqIpB0679FPdnKtG
ARC-Seal: i=1; a=rsa-sha256; t=1525116375; cv=none;
        d=google.com; s=arc-20160816;
        b=zw/QX21D6N4ODid4NE7M34hPuNxBHScOYVGkgnxxdp03lGnSS9HpnLZxTPgq4p5opD
         4nGKfnxq+v+/B9N97JjtDcBJvuYM3Y9ZpkjH2BpWDF8cxaj2LBdESj9pioh9CqWV+GtK
         ftO5tKVZdL7kSjlCpb6pzIwxQJ9YW0jXUmEZK4eQPUuJxE0J7TkleVu7gD+emU3WMUeW
         oxLYpKQuWAdXKfoRBhFazZa4MVn+jG5DrSOBHciJj8i4q3Nd6fJEIwVOGTxQMPk7Jlng
         2IGil9HH9adAkO/v+d2MkCgS79v4PSCYy0lncqoG9EGQm6rg4pLqk30DSKVTNjmi0kpJ
         McIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=gS9kPzm7EMYGvyX/eVlfKuQV0SjiLqMBua/mlqzqWkk=;
        b=kNVoHfsYkIgdbGVpA2x/TSfsiNKKsExxTVozB/jkzyj44kdifgwJcMyX9ccAo8HaOb
         S55hs+3HGCrLVU1ClSCO+WcRXeQPCXOKfjX0jHuJv6N5EveCQlOns37vqJ23k0QJjBLc
         oE7Hp25brztKGteXgNztNIrJFpdJ/1I1hdcC/InIdpPAuBP8h3iqiI8QBLIM5ukZZ+WI
         +gU1nHoKxgLzAu2Q3nyIQO8DODqm7X5Wm33pM9NyHVvqAPB+u8rS7f+FyqU2q8A26EvS
         Dld5wnyv7o1qbp57NT0ny/UI0TjnTPXpEcE5NBGehhqJyOAiQbMm5/TdTInjwc4nGyoX
         n4Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CED522DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzkaller@googlegroups.com>,
	Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 4.4 16/44] tty: Dont call panic() at tty_ldisc_init()
Date: Mon, 30 Apr 2018 12:24:27 -0700
Message-Id: <20180430190946.991889911@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200428340821221?=
X-GMAIL-MSGID: =?utf-8?q?1599200428340821221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3154,7 +3154,10 @@ struct tty_struct *alloc_tty_struct(stru
 
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
@@ -804,12 +804,13 @@ void tty_ldisc_release(struct tty_struct
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
@@ -586,7 +586,7 @@ extern int tty_unregister_ldisc(int disc
 extern int tty_set_ldisc(struct tty_struct *tty, int ldisc);
 extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
 extern void tty_ldisc_release(struct tty_struct *tty);
-extern void tty_ldisc_init(struct tty_struct *tty);
+extern int __must_check tty_ldisc_init(struct tty_struct *tty);
 extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern void tty_ldisc_begin(void);
 
