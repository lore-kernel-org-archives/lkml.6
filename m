Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48v8DU9BQ/queLNNsRhrDZ7ypgIMlfmyuwXeNQtoiQ9ABdik4Z/6HmnpQRnG5+uCflQVnAJ
ARC-Seal: i=1; a=rsa-sha256; t=1523981241; cv=none;
        d=google.com; s=arc-20160816;
        b=JGNtW1kqz+KyYCcbBHeKsjLenll34L+KuNEg4BEVgywy4ONL5jztE/Z+WiMGaxSqld
         I+LTDgZ1gnbEeih2CAUy2vvmr5r83Q1upPMUdkMp7N5fBj4j4mrrgbbr2jS9boGm4r2C
         Aazq7AujoEyinZerYwmz/1zhe7PII1JYU3iqAiG2BtMKNR4KF4ujk+UWFc+vrmG9eY6c
         kHH1EHZ9N2QJ3fl1/d0I8/dhUeix/UbKzQb/iziKvTsPbZWSBxTU3Kri3TA/4/cDDfxM
         d/t9eU4nKd7gfzPs0sulQYm7zlgzJVFCEveLMYmUg1OseSuFIatEPSpzkFtvtLLN6k7h
         7mLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hdrQMBRPZTmpXkehhFXFweNrluZ1VbbrigohmUJ7NcQ=;
        b=Pa82Lwr915q94TgUXQ+ndJdFrIpEmZC0AnVp0+YSF8RzlW3zo9wi1C4L8oi+Tzg30m
         1kwow3EejSsAZyQKX7t1zJcTtyCdJZKkDZdPQEX4l3OwYEYHArHcB4gxTOPZfkF7dUH9
         z8wShvdMmiqgEzqp/0Tl4iwaSxvNMKtVHkDyGG+Q1xpmpCRLb1hCi92wjDTSOU5DASBO
         njUqRm7pRGdRnErpjhzRyzM1BQdQFprtU9fXN+v3WzlyibZPLYvvm7YRgJVbpuoQoigf
         pWetpKPaJrA9MG3hRptHsPic4DWyXB+XN/JJDPHbb8KrUv9w+DncevBrtMPN7VSPVv23
         +9+g==
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
Subject: [PATCH 4.14 44/49] lib: fix stall in __bitmap_parselist()
Date: Tue, 17 Apr 2018 17:59:23 +0200
Message-Id: <20180417155717.139456197@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009776446596481?=
X-GMAIL-MSGID: =?utf-8?q?1598010155172447836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -605,7 +605,7 @@ static int __bitmap_parselist(const char
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
@@ -218,6 +218,10 @@ static const struct test_bitmap_parselis
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
+	{-EINVAL, "0-31:", NULL, 8, 0},
+	{-EINVAL, "0-31:0", NULL, 8, 0},
+	{-EINVAL, "0-31:0/0", NULL, 8, 0},
+	{-EINVAL, "0-31:1/0", NULL, 8, 0},
 	{-EINVAL, "0-31:10/1", NULL, 8, 0},
 };
 
