Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/JbnJr/CnzxMAC3jo2ZwYxEemUeZe42b9oeEoiYMaXMdZAmWQ5RyffzG2tqGKTzRZ/fdLc
ARC-Seal: i=1; a=rsa-sha256; t=1523980880; cv=none;
        d=google.com; s=arc-20160816;
        b=EeA65owiTcbg3Gg6sbXArowDudgxVAADU+6RLptLN/tGck1QW395pD02Ht1B6qrzRz
         dmKdcqMgH3aXtTXADQSs6wFSJ+zJg13Xu5Z39urcdaiPMy++FVfTgMA0Uh2oJP/fHvUw
         3GHUvoxJQ0eeLEICLOmezJYN3BEKmPNS4OZVeWfAt+1R11jvenbFptKrMirfgKoFuWiN
         RIaoI4I0FOigT4Nq8ZnsZNn6CEKy1HxxUwbJ5+PZzcPU1xgFu0smJJ67FSKzSkx4Mbbz
         +oqZiEJCpk5Xl1l9buAqa4JiNolU2VHNUahm8N09CSByI5yiIAe/2C6z9SbTomQGtVXv
         vd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dYjatGIVYRooaD0N65JEolTfe+EIAQhPez8cY7RitD0=;
        b=JEBcfS0GnfA/5rfuAFAfcC62lc5ZfMDYsIuKaB8ApNVVen9QbxXPLkl1VDQt8zZDM5
         g7l5HwuIRvD12gpWWrwHGf9rpM6NIi70Y12oLm9Dch9oLeQrcjdt0K4bOLjPP99AARxa
         pe6uz9LqM7DPrfUpmtH9IlYF3liXREJIw67ZMZAz7FsC3dmCxS81XAOTefwVtg0kAu/X
         17xGbMg6GSKqpX2v0XwBO8uOemwmPUN07C2mv1t94Yrw1j258MUaWqv8DdUwsmTZFU9g
         4uYmCpbStC2cDG/Xkyk8Ugz2gtbOZTKoCBtIuIJQ7mnXu3dUTIedASyhED7STmn0Lj/S
         jBXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yury Norov <ynorov@caviumnetworks.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+6887cbb011c8054e8a3d@syzkaller.appspotmail.com>,
	Noam Camus <noamca@mellanox.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 38/68] lib: fix stall in __bitmap_parselist()
Date: Tue, 17 Apr 2018 17:57:51 +0200
Message-Id: <20180417155750.883936738@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009776446596481?=
X-GMAIL-MSGID: =?utf-8?q?1598009776446596481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yury Norov <ynorov@caviumnetworks.com>

commit 8351760ff5b2042039554b4948ddabaac644a976 upstream.

syzbot is catching stalls at __bitmap_parselist()
(https://syzkaller.appspot.com/bug?id=ad7e0351fbc90535558514a71cd3edc11681997a).
The trigger is

  unsigned long v = 0;
  bitmap_parselist("7:,", &v, BITS_PER_LONG);

which results in hitting infinite loop at

    while (a <= b) {
	    off = min(b - a + 1, used_size);
	    bitmap_set(maskp, a, off);
	    a += group_size;
    }

due to used_size == group_size == 0.

Link: http://lkml.kernel.org/r/20180404162647.15763-1-ynorov@caviumnetworks.com
Fixes: 0a5ce0831d04382a ("lib/bitmap.c: make bitmap_parselist() thread-safe and much faster")
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+6887cbb011c8054e8a3d@syzkaller.appspotmail.com>
Cc: Noam Camus <noamca@mellanox.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/bitmap.c      |    2 +-
 lib/test_bitmap.c |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -607,7 +607,7 @@ static int __bitmap_parselist(const char
 		/* if no digit is after '-', it's wrong*/
 		if (at_start && in_range)
 			return -EINVAL;
-		if (!(a <= b) || !(used_size <= group_size))
+		if (!(a <= b) || group_size == 0 || !(used_size <= group_size))
 			return -EINVAL;
 		if (b >= nmaskbits)
 			return -ERANGE;
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -255,6 +255,10 @@ static const struct test_bitmap_parselis
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
+	{-EINVAL, "0-31:", NULL, 8, 0},
+	{-EINVAL, "0-31:0", NULL, 8, 0},
+	{-EINVAL, "0-31:0/0", NULL, 8, 0},
+	{-EINVAL, "0-31:1/0", NULL, 8, 0},
 	{-EINVAL, "0-31:10/1", NULL, 8, 0},
 };
 
