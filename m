Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/oYbmf0esZfVKseTCx8eWqXPW/D3WxaqZjlqljccmU262z5YhNmN+QfY5M5TZLMmFb+G5n
ARC-Seal: i=1; a=rsa-sha256; t=1523981072; cv=none;
        d=google.com; s=arc-20160816;
        b=qaQKtHQRN1kJ8nYKvmdaaMeo2KdsWeg50cP3zG///zbZbfKO81WJYzx1HNa7UqhZLE
         ok3Wws0TXYh+P/4jGawEuU7o1Mxy6Y7SNPMUY4Y3hE6MnNkJ1Bk7IqfykvvkLhSuie6B
         P96GkQcE1ABeNxwJI7V/X9W4icWxac9oBvqHF1qgnZiYcdDdeqnZSPE3C1XPtQsTnRRJ
         yXA32y5dDTpCjTAyhu/sqTvRjR+xC0pLhNY1ejH+lLdMZpmj160pektfH9yBNwVhpuWi
         ayT9LhNgoUc+7iGR2p7+U3/v4JmcfyTeqKysvS3TyQjBnkODTSbDnWzj37HOU8q+3HLE
         23Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HLwXOpXo28q8lqdJCz7eB2czef6OHbEmRDt+Jkc3glY=;
        b=RQr1yqpUxQsbmW/KFosHfV8tK7dyfo6EyXt58P0qGXof8Gyj5t2zhHiWawNRE3RB6p
         /Yloq9nxMC7GnT9qrbOGl5Qv0mqcDRwxyRjpwcywLqdXZI+kYMmd5GbEdn9Y4nXaqRte
         mhkWzzdUxQYNpM4iA2AlkDm+xy8RcoJ0c12QgRtzpcxGLd/Y2zn4d2O6zQmslxgoLa+D
         HCBCIVMie2hVVoP3MtlKwqL+fvWR2oR0Yp7GV1Y51JIhE6h7YIryCBS4pLWmUdiXb28F
         wOJuh4YXzBc1fnuVyT5W9Pk/sK4SsJBy525fQzlk4VmDeRtV9GaiOY9U3Cp0tYeUe8as
         9sUQ==
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
Subject: [PATCH 4.15 30/53] lib: fix stall in __bitmap_parselist()
Date: Tue, 17 Apr 2018 17:58:55 +0200
Message-Id: <20180417155724.623157623@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009776446596481?=
X-GMAIL-MSGID: =?utf-8?q?1598009977461684485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
