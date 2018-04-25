Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx49adnCl1vIK5EaDl2xh9Zwlw6YJp6GnlKUZDGEehh3fKgX9mBt0W3aWpNtzzqR4NMhyAUJq
ARC-Seal: i=1; a=rsa-sha256; t=1524654763; cv=none;
        d=google.com; s=arc-20160816;
        b=OzggKCa85gIgEEBBPL1ERCnwZnWm8JqIte+UtJXXWESy0+9/O0ryvdVmIMt1fsUCUh
         Ury+10IXZTD1VzYEwZBqjkWD9Ix2meMp2n55qieHe1GXyzRpfo3Ybuj7Qh73/ywOuMbN
         imzJ0E6uEeUn5oVa1MGB1nO2QnCGgp+OAR7VucxrEsc3O4INBYU3htRsu11GfVi42vwY
         H0HWZFMCurPEzediButlOVIQuTvkoddSQ+MUoCN53QPJq2AGB9zVjfhzVSS/g5s9a3ON
         ArP9Y7uPb8U4FgC/xaAWth1o7tiCIT3zTgd/NlPmbYnDwlMi3kkZajQCaNde5cl/47wz
         B64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=1isAPTDt5JL5XLQmQcuRakanohJUyV9uJObJBVB5E/c=;
        b=J7I3B5+4go5I+s+NRYcPDK4TfpFbt0wBXOsyfY56DIUokpc4r8HIOfRC8YdxxVVQDB
         y43ziy4LWyiKLmnUfj1n6H77rC2scL/2dOiP59nzuHPexX2CiBCbVcMQIwvw5pUciMt1
         XkHNMY79HdIhtOkk2+9adXPL1NjYwRy8OMkM47kJ7/+ppn/zJ+8/lEiJ+5OeRL5Odd1f
         L+CuZLYcCsMU6NHy30IE7r53Blew+JHweQsXaWC7SQuEcYigxzgxAvoFEExKSOkohmLF
         SQGMoiYS6Ac+bOxf9+J86QTU1+pRa0vp5vIH4ThCj+iBSroS2okGRJt+yn2CryKz68Z0
         bPSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: [PATCH] tty: Use __GFP_NOFAIL for tty_ldisc_get()
To: syzbot <syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Michal Hocko <mhocko@suse.com>
References: <0000000000003471d40568c520bc@google.com>
Cc: linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
 <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <172ab7af-23ac-0989-c132-e474a0ff11b6@I-love.SAKURA.ne.jp>
Date: Wed, 25 Apr 2018 20:12:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000003471d40568c520bc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596531138218511116?=
X-GMAIL-MSGID: =?utf-8?q?1598716393069114914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

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
---
 drivers/tty/tty_ldisc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 050f4d6..971a37e 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -176,12 +176,11 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
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
 
-- 
1.8.3.1
