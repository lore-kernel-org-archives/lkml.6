Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8317C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600F42086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5Qgb6da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600F42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbeKOQVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:21:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40100 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeKOQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:21:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id x2-v6so9158415pfm.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 22:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UOD1rZ76ixX1i+wINT/mXb9qg93tcveUQSdF4DVLxOg=;
        b=j5Qgb6datx6I8r5gBbqyz1u7DqEgvrQZAAVbzPbs9C5F46EZlv1PH9WpcF1s5ZWFRE
         ePdLA/+ukMxSAiQA+TlhpUED4GCqHsCiSZGTo3dVIJXAez7Y/V5by/792WXxQZscNAtC
         EDQ6TAtmLTdWJZ3Mm6/IgAQXYoMhFnDp3mOTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UOD1rZ76ixX1i+wINT/mXb9qg93tcveUQSdF4DVLxOg=;
        b=gX7DUivhN7oOdw4xYdEGVPb329qW6wqus2vh7ep/SFoYPvRHAtp7IF9s9SA5n+jWjX
         5EC4C0bzg7IlCdtFiyBNPBu6riePumtorLpZ/E3r2mnFKkFA9RXsUUDaJ/wO82l69sl8
         LjHPErREdvtH7V9X1cWZHSs3q5FoNw0aOTMPYBDYYu1pFIvoZmpDDPwd1M93obCQ7cNE
         CooqoBQCYfVgaIZ3ar1ERQ5c8r6A6+ocB9PuYoD3FvDgH1TSDbuj7j54hvg9CputRvUn
         f2J4oZu4GS9YdOiiiMnxVYg2QEOhtNY5KpSG0xTG9IJPVOV3cunDXGmwtSUubjJUlFYJ
         YbGg==
X-Gm-Message-State: AGRZ1gKLuHViJWaoE8/kxMgBRg4toF0Jb4Ql1YCS3xT6rkMiSKuYdWrM
        cATGR6K10xmaUroMKFi1qxUI8Q==
X-Google-Smtp-Source: AJdET5ct5FkgdjUjXRCS9ivMWxqjb331jore69P+VV2qW30VbkoV1LvNQQJuWE4WR2TprcuYUvx7rQ==
X-Received: by 2002:a63:f658:: with SMTP id u24mr4659976pgj.267.1542262495383;
        Wed, 14 Nov 2018 22:14:55 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 34sm39861931pgp.90.2018.11.14.22.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 22:14:54 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v2 1/5] mips: add __NR_syscalls along with __NR_Linux_syscalls
Date:   Thu, 15 Nov 2018 11:44:17 +0530
Message-Id: <1542262461-29024-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_Linux_syscalls macro holds the number of system call
exist in mips architecture. We have to change the value of
__NR_Linux_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update __NR-
_Linux_syscalls value.

1. Update __NR_Linux_syscalls in asm/unistd.h manually
   by counting the no.of system calls. No need to update
   __NR_Linux_syscalls until we either add a new system
   call or delete existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update __NR_Linux_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with __NR_Linux_syscalls. The macro __NR_syscalls also
added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/uapi/asm/unistd.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index f25dd1d..0ccf954 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -391,16 +391,19 @@
 #define __NR_rseq			(__NR_Linux + 367)
 #define __NR_io_pgetevents		(__NR_Linux + 368)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			368
+#endif
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		368
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		368
+#define __NR_O32_Linux_syscalls		__NR_syscalls
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -738,15 +741,19 @@
 #define __NR_rseq			(__NR_Linux + 327)
 #define __NR_io_pgetevents		(__NR_Linux + 328)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			328
+#endif
+
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		328
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		328
+#define __NR_64_Linux_syscalls		__NR_syscalls
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1088,14 +1095,18 @@
 #define __NR_rseq			(__NR_Linux + 331)
 #define __NR_io_pgetevents		(__NR_Linux + 332)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			332
+#endif
+
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		332
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		332
+#define __NR_N32_Linux_syscalls		__NR_syscalls
 
 #endif /* _UAPI_ASM_UNISTD_H */
-- 
1.9.1

