Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226UPnocCZjygtUfwUDaxjlKJciWZ7Dj/x5/Q41eocu5wCOY+3a6E7010X5R0TsCfvJ2zIbD
ARC-Seal: i=1; a=rsa-sha256; t=1518708516; cv=none;
        d=google.com; s=arc-20160816;
        b=ByAdw0Au0V2KUNzeTnX6I8qvXQm/8lOvzAFk/2qOYcQtBj8cEKSbC5ZjnUQKM0+lM/
         C3iW+gS3xq3jkzJSJJUlDMdDoGNdON+TmrJOMWBSZIN8SQPAEeb7BARuAQ4HQkQPZhMJ
         DR2HCiACKTYRU096CcAyDfQOKjkK5lMJTZZxKVose5NjvVF7NQMmftKsujqznPIwIpHM
         kBoXoSp8veiaRwXie2eC3yGXaSk4Xn05+2S3qYutB7eJqbdqRgskBx51A1hXLSw1jVQP
         3ypsQj/wSLRdT9jdIEq/XrT6RLx1jDqAH8XZjwnPEkUYTabfkDYf9J8mG14qIbtKAhsG
         8YUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=x4GGauzCsLA/Rx9Wv0otDWvRHw1KNUK5p1wKq8Xb9YA=;
        b=t4r3XjJIAI4M5w7Gco56Wecqe5PYSAYq+ynpVLY9kTWyz03gLRmC+1kYkDhGgwtxqF
         3cCk/W3FTCw24UkJ+xjZWZ7EETG95yMM5l2MC8qBPVTdnXpTcDwrpz2cZ5PZ4nCWHqCZ
         ZjbZ2GMs7WVG+qLiS12oda/FDsF6YqdsB6VYxL+wBolj13jFjEpdaC+DsNT+AAsguxAm
         h7s7A5THoyxIT9rP1RHipQfoY+QpoRDP2TNRWd1XO1hSMto4KQip9Kdh5RYlVJ4ydzKo
         QDzQCqX4vtnj0MVsSvTaFlV46aVpoCJm6krdx3/2nOM4r/7FyLCFNdlMggxIrMwMqSMx
         jZRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.9 71/88] signal/sh: Ensure si_signo is initialized in do_divide_error
Date: Thu, 15 Feb 2018 16:17:38 +0100
Message-Id: <20180215151232.348585765@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480758766631562?=
X-GMAIL-MSGID: =?utf-8?q?1592481302193881600?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 0e88bb002a9b2ee8cc3cc9478ce2dc126f849696 upstream.

Set si_signo.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Fixes: 0983b31849bb ("sh: Wire up division and address error exceptions on SH-2A.")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sh/kernel/traps_32.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -607,7 +607,8 @@ asmlinkage void do_divide_error(unsigned
 		break;
 	}
 
-	force_sig_info(SIGFPE, &info, current);
+	info.si_signo = SIGFPE;
+	force_sig_info(info.si_signo, &info, current);
 }
 #endif
 
