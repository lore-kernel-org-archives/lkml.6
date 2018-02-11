Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2246ZV1VLxK6cBF6zig7khWC4u2fGpBOHzsVPtKt/po2J5iYZ7/3eGaf+6G1KM47mJ1JNqmB
ARC-Seal: i=1; a=rsa-sha256; t=1518347541; cv=none;
        d=google.com; s=arc-20160816;
        b=CZpwleHNHRa87JQHNuItaWSxqJZ5A9nTWxvpLl+HBE+03bZy9NyD62+m4v8gqfIdjg
         kuvnK3t61mf4gXg5INXOHEL66k7y/XIP5vw2+Do1ojZvf/+GYZEHpqIK4WHMIBGiJ1tP
         0xlEWnR9H2kmlvmo20Idl4RUN04lf8VdN0mmRT9uOKsVtRdJXy9rXDpFg9I8hmLfcwvQ
         tzyMLfUqCwmsuzs1+wdbadoRUEyvYq/JXnGQ7dtNWVxhqUlLUvWGIJhmRQv51Gxger1K
         w+UIgdn77zVNHbPx76YxZtKHXja2wHd1ZxqOv9/Ljv9cujTmpe+PdTHRNk4ATHtUkfi5
         PSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pD2MztHt1CF2q4FQS0mL68PPNjomUTRlNmjy4XaN7qo=;
        b=0HLEhvui2pGdq7uHj0KXmyknxueTVVeIm0cqrPy347MNw5vCt/kD+audC5rBtlSrKy
         8DL6Vc/KamGbuGqT9vBSmiVOB5rxqESZm9Y8JBRhhu40vr9RFCtippOeyGG1wE5M6bGl
         Knyueg71t2KD3W6tcMfo9fEYckw9iyEJjOD1vfdQukkN+9lZcE+JC6YYWgqYpRDQ/IEo
         pLPzG36szIHXr46W0r11mAlpZpOnDejkM/43KHy647GvaPbOfSZFuygfYGwCHDPNcN1g
         DpyGr5PLxnJH36D00Kc23FpZESq/B46kx2CY+YIf1yb7Y3lZd5Hx5zlWm3ZdF82Exzru
         v3dA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeBKLLD (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 06:11:03 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:40608 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBKLLC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 06:11:02 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/5] selftests/x86: do not rely on int $0x80 in test_mremap_vdso.c
Date: Sun, 11 Feb 2018 12:10:11 +0100
Message-Id: <20180211111013.16888-4-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180211111013.16888-1-linux@dominikbrodowski.net>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102791320835718?=
X-GMAIL-MSGID: =?utf-8?q?1592102791320835718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 64bit builds, we should not rely on int $0x80 working (it only does if
CONFIG_IA32_EMULATION is enabled). Without this patch, the move test may
succeed, but the int $0x80 cause a segfault, resulting in a false negative
output of this selftest.

CC: Dmitry Safonov <dsafonov@virtuozzo.com>
CC: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 tools/testing/selftests/x86/test_mremap_vdso.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index bf0d687c7db7..64f11c8d9b76 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -90,8 +90,12 @@ int main(int argc, char **argv, char **envp)
 			vdso_size += PAGE_SIZE;
 		}
 
+#ifdef __i386__
 		/* Glibc is likely to explode now - exit with raw syscall */
 		asm volatile ("int $0x80" : : "a" (__NR_exit), "b" (!!ret));
+#else /* __x86_64__ */
+		syscall(SYS_exit, ret);
+#endif
 	} else {
 		int status;
 
-- 
2.16.1

