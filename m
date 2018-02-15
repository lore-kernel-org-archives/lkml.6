Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226PHq4onG2G9sqATrmiivQCg0VC/gKrpfsiW/QwnQpEDI8c4u2x8YmUxnSF6kl9V65JY/JU
ARC-Seal: i=1; a=rsa-sha256; t=1518708022; cv=none;
        d=google.com; s=arc-20160816;
        b=mhFomIZ+lIMTwvKR3zgZfdoy1b7PgPKdMdUuSkki7Ie6Zlb6DaA58vpPggnOyW9UI0
         gzkqnthRNZ48+avcH9SmI1opzSNyjSSUZBexpY6JneloQqo3UKXLDs7Bk0ZeF0EAWa1H
         j+IFayOZMg3hyM0WZb8Xc0rESGbriHOIuTFX6zO6cIgZsDdI8oBaZs26in5RgSUnWEq4
         kEX1et15xhC4dFagj5Dl4gaG8z8+pLnhqm8Z31ZUx1iHMz6+lptVLyD204gECXP773vw
         ZViYxRu3DeT5oT9G/Hxuajy0OlHIJvTig86qjy8gVcfcV+4o3f7ZngJ0UhnJ8gv1oKni
         Cs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sSd6ysWcox7mhawq4IK+lObiaD9lHSzGR74hROgK2v4=;
        b=pGzxAWIulzwUZBjX2JtOQ2hnthX/7tH/L3NzM/6kLTGPwlv6NAwN3KRSo+b2oElUHE
         P1sFDBWQU6X+EMSFwdqK3bm6aJgi6DmN64zLJg5l9ekGn26PqxxYGsTd/lWqfqqm3tB1
         yJ15t6YhNM+V7BCkwKtddZ/+yvb5frBHmB/g0BuOSdtSXegNZqBVeabuP3qmNxa0whk0
         ID2oYcbR7+ErCuJJNdaM2xIYDjY+4mEf0mDj9jbn9ueM6Gs7V/mV92PJ5KUlzCyKGt6K
         9SQ1P9nEY5Y51pNvnz4f7v1hY3PwU8YZ5GxF8dDyKK9zT8p4gKt1/245x0s9pZ+wSfPf
         gSiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Masakazu Urade <urade.masakazu@jp.panasonic.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3.18 45/45] mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy
Date: Thu, 15 Feb 2018 16:17:36 +0100
Message-Id: <20180215144125.485663072@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480783215634672?=
X-GMAIL-MSGID: =?utf-8?q?1592480783215634672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 6ac1dc736b323011a55ecd1fc5897c24c4f77cbd upstream.

Setting si_code to 0 is the same a setting si_code to SI_USER which is definitely
not correct.  With si_code set to SI_USER si_pid and si_uid will be copied to
userspace instead of si_addr.  Which is very wrong.

So fix this by using a sensible si_code (SEGV_MAPERR) for this failure.

Fixes: b920de1b77b7 ("mn10300: add the MN10300/AM33 architecture to the kernel")
Cc: David Howells <dhowells@redhat.com>
Cc: Masakazu Urade <urade.masakazu@jp.panasonic.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mn10300/mm/misalignment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mn10300/mm/misalignment.c
+++ b/arch/mn10300/mm/misalignment.c
@@ -437,7 +437,7 @@ transfer_failed:
 
 	info.si_signo	= SIGSEGV;
 	info.si_errno	= 0;
-	info.si_code	= 0;
+	info.si_code	= SEGV_MAPERR;
 	info.si_addr	= (void *) regs->pc;
 	force_sig_info(SIGSEGV, &info, current);
 	return;
