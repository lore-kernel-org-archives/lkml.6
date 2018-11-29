Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBFFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B6A20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhrhxN5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B6A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeK2Ts5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:48:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45579 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeK2Ts5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:48:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so665387plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YFkH6BiVFMb84PF3sgPw/qdfk9RQVU5JUMVa27R0rjA=;
        b=DhrhxN5n8teCFA7v8nZRiQu16yHWm1E4p6mrtVuf/P10ftxWDObBJJR5NPa7K0cRDY
         z74dFrJzVBD6MChogCw7s96gRNgenl9iJwFeADIfvp3jrq3PZjcS+nZXFnQE08eJiT1C
         91AjGDL7+Kx7ZAR2tzKkGNPqTeTc/Y0gU0JWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YFkH6BiVFMb84PF3sgPw/qdfk9RQVU5JUMVa27R0rjA=;
        b=GmpgsHvfJ9UVbR6IJKlFYy0jTuYfK1o+/TBeOhLk+LOsfXjbXiLx5bP9rU70WKq82Q
         nE2dt7/9mT/cKp8bumksqrY7Y76gMUHgLj1ykNxXOfCpt4kLxflj+kZ6bv0jACCUmMMC
         oSLkFrUYU7qtfgXIcOi1wnSgG9TRnpyTeaBXquur0VKZr8frHX6DDW1HYGjw+rXdhZkk
         M/37llIQODJ3DxOCbIotRpuXOP2zFwQuUhOb1sTosRyXrsjTmfwE+/juht0rDWl8Md+t
         xL74IwO0sozqAgFid0rtkW7s4e3nBakrt4Wipnls8ZgNarYfQJlW51Jg9ZawyItR18ur
         KcyA==
X-Gm-Message-State: AA+aEWajQeTEIKSitxPUF3aNg0JW6XqED365qEeG7ocWHdy+i/1oPYrh
        LLFTaGKZAmulibXkgquERG+LEA==
X-Google-Smtp-Source: AFSGD/UToNvbgbixRAgaD1C4sQ4TtJ/u0i0e1pOJzoEuiuwD0fZS3vZcMn6NqMx14c2Yg7fvyxBVXw==
X-Received: by 2002:a17:902:25ab:: with SMTP id y40-v6mr586719pla.258.1543481060271;
        Thu, 29 Nov 2018 00:44:20 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2322683pfl.142.2018.11.29.00.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 00:44:19 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v3 1/6] mips: add __NR_syscalls along with __NR_Linux_syscalls
Date:   Thu, 29 Nov 2018 14:13:31 +0530
Message-Id: <1543481016-18500-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
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
 arch/mips/include/uapi/asm/unistd.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index f25dd1d..6914be5 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -391,11 +391,14 @@
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
 
@@ -738,10 +741,14 @@
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
 
@@ -1088,10 +1095,14 @@
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
 
-- 
1.9.1

