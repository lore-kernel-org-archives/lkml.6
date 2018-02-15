Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227QEmeQx/DI3O3LJmYpu9E6YYfwPEkE/mUK/mB9MDwE/qYIGfCf5bKq41+ZwtGdy2y4Ts8R
ARC-Seal: i=1; a=rsa-sha256; t=1518708566; cv=none;
        d=google.com; s=arc-20160816;
        b=Ux1GPsonaWtb5/FG6StQgjWmTEFEf4LiZ7hr6TgueCWRo985VvvYZnJkJBvzMSvWBb
         tdueGRp1kmuHsyBgxCWG/KocC9Tx9JrCzEf2deBPCYkV2TSoOJ9Ue8PkDiudk5zMGGYP
         vu/eUEYnDlfad8kgl6Jiel4XWhubXCkhLwXBWtFrrx3Rs9w8UsUVFYnHj9uF5cXfGRYB
         1TIXCTy8FyelZALuao1sgXn7jpPsMeJYAzcPwR3eLtllBuWvzn2jpVKWm5+rpwjc7Ey9
         V3RRQ/FvfayxyzvXG8gHhnoUi7VVK8dGq2RXCGIEpsdRvnfN6IJAUt5lPcRdjpPPrFQf
         I0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1duEUWwgqa3sA/4G+wS6wTETtawBh8ltI/SDqKqxFE8=;
        b=lgrqSeccP+jvoCXbrV6aadlGApAiDS8HO0hOQozlruM9hJvhSdE35Vt5m0gDS50zGX
         7JQ4DTSLQIcZC33Gr7o5useGlriI8W6IsVJyPDAfFHW7xAj/yIcMT70/1FJUKc+6BjEc
         HpXBPSIJ1yvg8eb+ApYf6t1XYkdFtfH8D5EzkSsXv2XadEBub6bRBmGcMpV8vGrvECdE
         fE5P6I09muMdbj7v/dVOkHl7JYzOrkFI8Wql6A/XJB0eh4kq6h2lsD2k587qr1KZ4rXr
         gVOtV5v07pG0FCFh9u7epqwD4pCTfBWWN8YvEenmo9fubk3dRshp+wbJ3czXwjagEtwC
         q/2w==
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
Subject: [PATCH 4.9 87/88] mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy
Date: Thu, 15 Feb 2018 16:17:54 +0100
Message-Id: <20180215151234.496094414@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480783215634672?=
X-GMAIL-MSGID: =?utf-8?q?1592481353988924179?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
