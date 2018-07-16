Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31E7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B0A208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROWB7pI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B0A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeGPKvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:51:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39752 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730828AbeGPKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:51:41 -0400
Received: by mail-pl0-f67.google.com with SMTP id p23-v6so3803033plo.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=neSAGVXnkgfmfF2JbJ/3Z6g1CJPAkxbDQqAy5Rka0h8=;
        b=ROWB7pI+nsGz4cQ3eNyjLykGlZlHtIdQjNcjgIJ9zmkh2GokBBQI8yxvGATZLjgNz3
         8iBg90uE2uClRYOEAUA38XQ90dkpYnpv4JItofbM/KsnZ7zJgSkDzJvc7Qve7H7onnoL
         fhXd2mkE6dzyOS4E7g3AOYJ5PIIOrhzyyM68M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=neSAGVXnkgfmfF2JbJ/3Z6g1CJPAkxbDQqAy5Rka0h8=;
        b=evsjGL/vXVixkEcfafMbWESf66kjfHetvyN3JTehUnkLheWMxD02cbbld9OY6Z2OLw
         jZm0lt5ZhKLDumaXt5VGUkzMc7ptEKh7pB1YQNSMPXibhxatVBEQLNNMTz6e7fxsiDQV
         40ifKc3sIB3uNZfDSHN8z0rhVv8jqDTdKzSFbKiPE5cnc58wjQVwRXDso8VM1KRRpXr6
         ygLK/ditvRrNFy+940+PJRtQKAZzDSQmWJ5rm4B0eAt9hciQoxm6JVeoV37/E85zcXc0
         6+dbzIZs59FQhz7kPlXbujgSCrql8e/rhSTFve8/1n9/Bk+vCeFWFQcfVyV+4lmnWD9j
         rH2g==
X-Gm-Message-State: AOUpUlGW1AUeTiAZ22ZFYxKC3+Bh8aDucyM0IS8JqQgcIc9VzbQ9p0D7
        +k3pAUft/bEykFry/VBU5tCDQQ==
X-Google-Smtp-Source: AAOMgpf1rf83GyVb2b33zf3mHY6nK6S+24LxF9C7D431xqc+RaLISiPRPPQSz1HLNvKIWZzCvqM71Q==
X-Received: by 2002:a17:902:7e06:: with SMTP id b6-v6mr4504086plm.230.1531736696390;
        Mon, 16 Jul 2018 03:24:56 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id l27-v6sm17808087pfi.42.2018.07.16.03.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 03:24:56 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-alpha@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 4/6] alpha: Replace NR_SYSCALLS macro from asm/unistd.h
Date:   Mon, 16 Jul 2018 15:53:56 +0530
Message-Id: <1531736638-15294-5-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace NR_SYSCALLS from asm/unistd.h and keep equivalent macro
__NR_syscalls in uapi/asm/unistd.h and this will make a unified
implementation across all the architecture and we can use a system
call generation script to generate __NR_syscalls.

While __NR_syscalls isn't strictly part of the uapi, having it as
part of the generated header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/include/asm/unistd.h      | 2 --
 arch/alpha/include/uapi/asm/unistd.h | 2 ++
 arch/alpha/kernel/entry.S            | 4 ++--
 arch/alpha/kernel/systbls.S          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 1d19087..92c3f2e 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -4,8 +4,6 @@
 
 #include <uapi/asm/unistd.h>
 
-#define NR_SYSCALLS			523
-
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 3bb6ac1..5d4b51e 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -481,4 +481,6 @@
 #define __NR_pwritev2			521
 #define __NR_statx			522
 
+#define __NR_syscalls                   523
+
 #endif /* _UAPI_ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index c64806a..8f0d706 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -454,7 +454,7 @@ entSys:
 	SAVE_ALL
 	lda	$8, 0x3fff
 	bic	$sp, $8, $8
-	lda	$4, NR_SYSCALLS($31)
+	lda	$4, __NR_syscalls($31)
 	stq	$16, SP_OFF+24($sp)
 	lda	$5, sys_call_table
 	lda	$27, sys_ni_syscall
@@ -585,7 +585,7 @@ strace:
 	ldq	$21, 88($sp)
 
 	/* get the system call pointer.. */
-	lda	$1, NR_SYSCALLS($31)
+	lda	$1, __NR_syscalls($31)
 	lda	$2, sys_call_table
 	lda	$27, alpha_ni_syscall
 	cmpult	$0, $1, $1
diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
index 7ef6925..de79de3 100644
--- a/arch/alpha/kernel/systbls.S
+++ b/arch/alpha/kernel/systbls.S
@@ -544,6 +544,6 @@ sys_call_table:
 	.type sys_call_table, @object
 
 /* Remember to update everything, kids.  */
-.ifne (. - sys_call_table) - (NR_SYSCALLS * 8)
+.ifne (. - sys_call_table) - (__NR_syscalls * 8)
 .err
 .endif
-- 
2.7.4

