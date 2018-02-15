Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2254cxJZzgY3szIpHKVwJMV3bqXmgwV63DPU/JTVutMdzmvio7gn7bioVqe1kiEFJvcjxEZL
ARC-Seal: i=1; a=rsa-sha256; t=1518709099; cv=none;
        d=google.com; s=arc-20160816;
        b=mhwSDlllO/fIQOGeWDdV0fLZRycIiL39gRBRWZP2JGNvBFFe/g1Ny7WKvE9rjlofks
         JO7Dq9/5T82Cq0yHqSOFeZtLO0WWp99c6OmBqxEGjORqKZdiUJOnYBqEgERkdgakYl/C
         evugto/cV9Aqz4SfeHkWmF6vsLLue7Dr/psTbdhU2CSlxELrH2asQ7HyEvXrDLVGzLgO
         J1j6OZjPPZxwNCgVK7tqXmprn0mrC374aO7u/px5QJs/WzZkNiP6q4qxZbHql5u8T+yU
         XNZf/k3RcHZi1ysHzj+VTqWEce0orN/sI8yqKxcNXzAaFZRxR3qSdi8LHBdO8gxXs9P0
         ngxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5MFXlZkG3fDaeMhXOcNyF30Fi1eifq0RYRSp0gQ/z9g=;
        b=veEGkEp9Wo9CYSv7KYEalw4zA9r11DtMoyIszwh5LVzJizeNhrbU48i8tbzcwPIneM
         FYuxJLmEVBkxpgWmlWarz09reYYSPwWYjDVt43eKcWimSP+f3Mcotb1+Z0VxU/16KAAp
         b2ylcmFwcjxOqjNJTWmLHv/6f3jdCX3y+wLmUiyX4iO/kMBU7+ljNx0A3OnJhD6KXDBF
         jZk6O0V90n2ff1EsKdLWGXlivv8XGv7gGyJhzg15htOGIqKaY0bc6O9D2RoqOmfB9ot6
         /N1cq14CN3YHgLQdXrFwlnyh4POF8ZPR9E09L9XTJIczd8vAxcNTEoFXMbNeteW/FgnD
         gkuA==
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
Subject: [PATCH 4.14 190/195] mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy
Date: Thu, 15 Feb 2018 16:18:01 +0100
Message-Id: <20180215151715.817169623@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480783215634672?=
X-GMAIL-MSGID: =?utf-8?q?1592481913186469772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
