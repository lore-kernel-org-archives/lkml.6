Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZouaW4LTbk1ST9lAY0+5U3DcUtbQ9LkJaAU5K9BYwMTDFd3Phn06/grj7yA6ok/KnVD7Dzh
ARC-Seal: i=1; a=rsa-sha256; t=1526280946; cv=none;
        d=google.com; s=arc-20160816;
        b=hkKUQk5C3kPCgiq4J0OKPGeA3yeXsKUh+wMxsu9aCbL/ZTgFxxYN6k7IcZDIheI3X4
         BuVmxa3qXhEnIymLdtw8Skx8CfqkMJUTiXNYWHJjdLk1OOQBe8zNsa1wvar3de672/JP
         gAPx3erf9ehOt6Vwurc1+T+hGZydr9Z3uLwk76E87QGV/gSMBJ6RJqtt0x+awiJnZ1X7
         HTyET6gu7bQ7QlyHZl4oPaNhEtzVJrmbqhRraPmSDQL7KLhkkco1xzk9PXXQ1DBFuD9u
         h40P094j17VXfzY0CulzVQOW/3MO1JsW+BKyYMIEuk6xEyQ3BrV9ILMW8I2i3kqErS/p
         Sq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AQovNuWYcCY2ltXrpKFYycmK9iyB2wWuWL7NH7MTJ1I=;
        b=sLd7+2Um0VjGmvtT66Dcr+96K2eeEnZT0i8Zf26ngNB9sXXL6vvEFt4xvdN3Ks+yB9
         u2rArfQQxaRLFQfdIzkBe3QM6RQBR5durH2Wt9qWAoQFiMLhFse31Tf6TmqfnWNowGah
         epnCrw9st4GuMOMzQmOt5xN0OkguHfzGEHQ8d58ZkrMatFb4QVmnLBdXI9yWeX3/GoA6
         0dAZ9KUAhi+tJeWgm/zGiwYIRODLrtLt+NNJeBfKWChvxGF/tsHdyUP4UfQsWap0BARp
         CvF2Qajw2QIU28ZRFLbd15Izftadc0T2kMqyySWvB9o+my2wqrf3wmGL8H1dA9MEBvaL
         Dr8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bP0b1wSQ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bP0b1wSQ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Kees Cook <keescook@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 22/62] compat: fix 4-byte infoleak via uninitialized struct field
Date: Mon, 14 May 2018 08:48:38 +0200
Message-Id: <20180514064817.636193564@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421570040873746?=
X-GMAIL-MSGID: =?utf-8?q?1600421570040873746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 0a0b98734479aa5b3c671d5190e86273372cab95 upstream.

Commit 3a4d44b61625 ("ntp: Move adjtimex related compat syscalls to
native counterparts") removed the memset() in compat_get_timex().  Since
then, the compat adjtimex syscall can invoke do_adjtimex() with an
uninitialized ->tai.

If do_adjtimex() doesn't write to ->tai (e.g.  because the arguments are
invalid), compat_put_timex() then copies the uninitialized ->tai field
to userspace.

Fix it by adding the memset() back.

Fixes: 3a4d44b61625 ("ntp: Move adjtimex related compat syscalls to native counterparts")
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/compat.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -34,6 +34,7 @@ int compat_get_timex(struct timex *txc,
 {
 	struct compat_timex tx32;
 
+	memset(txc, 0, sizeof(struct timex));
 	if (copy_from_user(&tx32, utp, sizeof(struct compat_timex)))
 		return -EFAULT;
 
