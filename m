Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2258Mzh/SGIp/eKiwVoClQHBDtpUodpSf8CxIGFT7h2M3Bkm12+nt3hD9mWqPDwzXuiQTnmN
ARC-Seal: i=1; a=rsa-sha256; t=1519423936; cv=none;
        d=google.com; s=arc-20160816;
        b=CpTZ4op7WaFxs0dFO8oinHu3qzJoUN74khwlxN+i5ZqijQZMWaCw+UFNguwHOOlU6a
         ciE/eX/fhrCVpj+QE0AJroEndorFNpJVg0KdnbIFy9BFp64TbBdkSbAz1SglGgqdwbCc
         VVsMvJjnsJopcSecDgWXR/3iow0vVxmnJqVmOqTf3Fh48beudhvL4ORwS8N7meLeoacW
         IjPb+vcO6XJZhzhH8vwq7F8o2wUTZbvLRXTkCwdwsDxVRoNLoXuALDSIoRJHPQQDMgE+
         CkGQiXpcuz/OzgSGHjqbPsgK++mOTA6ad8DjDaBQ/lDn5IalvSnp15v5fEENDE/GPsRU
         ONpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=jNSwTKV5xhf8qmP46rR4mvUWjZpu9eDhQHXQPtnrxdU=;
        b=XmCj10bSLDypbGeijPTYk8NBIcQgUApZSiH4XcSxb+RtMTpGtfZjT2bslr6SfwRPpy
         CceYv6kXQmVV1KtoGCock6RW71a3Qn8UgftRV4CFLvzgz+I/e2iXBi0dp+s/B86410Gh
         sTZPinFOWtEfQx+GClbz+kN65BZVFSt/r71zgTE+/ldWSUffU9F9Ksqvo7dZdgyLrR5P
         X5hfAlfRn9a8wCGGCYhGnkKGkgLeDNGQs7y+duXfGIe7V9q2rvq+Czrki2YHaEn2ltjj
         95/ga7ldmXr3ExPzIczQOo42SgIuArA+q+NeqdiZA0uMhEPf4MCs4xtm1F1DqaOHphuy
         Q9Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeBWWMP (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Feb 2018 17:12:15 -0500
Received: from osg.samsung.com ([64.30.133.232]:57573 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751707AbeBWWMJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Feb 2018 17:12:09 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: shuah@kernel.org, dvhart@infradead.org, tbird20d@gmail.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/5] selftests: kselftest framework: add handling for TAP header level
Date: Fri, 23 Feb 2018 15:11:36 -0700
Message-Id: <3176a8f2e1aaf19632cece19a7945a12e5ebc35f.1519423340.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1519423340.git.shuahkh@osg.samsung.com>
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1519423340.git.shuahkh@osg.samsung.com>
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231473162736882?=
X-GMAIL-MSGID: =?utf-8?q?1593231473162736882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce environment variable KSFT_TAP_LEVEL to avoid printing
nested TAP headers for each test. lib.mk run_tests target prints
TAP header before invoking the test program or test script. Tests
need a way to suppress TAP headers if it is already printed out.

This new environment variable adds a way for ksft_print_header()
print TAP header only when KSFT_TAP_LEVEL isn't set.

lib.mk run_tests and test program should print TAP header and set
KSFT_TAP_LEVEL to avoid a second TAP header to be printed.

selftests Makefile should export KSFT_TAP_LEVEL and add TAP Header
echo to the run_kselftest.sh script from emit_tests target handling.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/testing/selftests/kselftest.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 1a52b03962a3..1b9d8ecdebce 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -57,7 +57,8 @@ static inline int ksft_get_error_cnt(void) { return ksft_cnt.ksft_error; }
 
 static inline void ksft_print_header(void)
 {
-	printf("TAP version 13\n");
+	if (!(getenv("KSFT_TAP_LEVEL")))
+		printf("TAP version 13\n");
 }
 
 static inline void ksft_print_cnts(void)
-- 
2.14.1

