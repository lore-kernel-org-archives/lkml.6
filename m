Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95019C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF0A20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9sup2H1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF0A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeLMJI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:08:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45313 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbeLMJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:08:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so780961pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kGl5LFLSs0dA190vDRXrA6LLA8QGbgKzTjmcNEweksU=;
        b=W9sup2H1E2eFlgrTQLauQ+0ZVjxsEREldGHtWrNJ32jaZY0A13/6/wx6AvpscznjQh
         /qptG89xcYXA64nIqnlH+pjeQlXUj79fBynEfRSt/qHaj7hernCAhqIGvOQQEDlggNew
         sPjkJuUH6/8ZkFAyQm95n2qJgYwdUHA1Zc//M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kGl5LFLSs0dA190vDRXrA6LLA8QGbgKzTjmcNEweksU=;
        b=IHqFNsySCxO6hCGYc0Awtbu4VoxQvHiTeRavjCgUlcclhP7QhDMhWErzlAspAChvM+
         JrmMhsXOvCzEXcML522BUYZ6Fh0EBe5z8321faAvvXhxKKINeiwNSRDuOxNOfVhsw6II
         bvAIVZdRBCyiLdd4iOr1sjhfcmTeK2z2nOCp/8ym/15izy8ers1QXdEHjQJeKMM6L7qY
         rrfeXL28WMKxfGp05cMcIafw8m4JAjCI814D6pYLwKlI9oybaraqzqz7UKFkwptsjD+u
         iWtJ5L3WnfPoDd0j3/qId2qFhWcH847l6XEozwk/emu68rYfpVVpjrnsW862+SReYAPM
         QL5w==
X-Gm-Message-State: AA+aEWY0DtCKCCVxgav55AwFYR0r3SRgRu6qLembNpcQzg8SbwPyy7k/
        2i+7TwX17CxQhe6YO5mJMYOFGA==
X-Google-Smtp-Source: AFSGD/Uxeyjk1Xk90iAyQ82/sA8AzLI/l+yZmVymlH1t8hsKYd7dQ8UzaIg8dxim3ONze3YxHTs0mw==
X-Received: by 2002:a62:6cc8:: with SMTP id h191mr24392547pfc.89.1544692106723;
        Thu, 13 Dec 2018 01:08:26 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id m11sm1650533pgh.51.2018.12.13.01.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 01:08:26 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 2/7] mips: remove unused macros
Date:   Thu, 13 Dec 2018 14:37:34 +0530
Message-Id: <1544692059-9728-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove NR_syscalls from asm/unistd.h as there is no
users to use NR_syscalls macro in mips kernel.

Remove __NR_Linux_syscalls from uapi/asm/unistd.h as
there is no users to use NR_syscalls macro in mips
kernel.

MAX_SYSCALL_NO can also remove as there is commit
2957c9e61ee9 ("[MIPS] IRIX: Goodbye and thanks for
all the fish"), eight years ago.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/asm/unistd.h      |  8 --------
 arch/mips/include/uapi/asm/unistd.h | 15 ---------------
 arch/mips/kernel/scall32-o32.S      |  3 ---
 3 files changed, 26 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index c68b8ae..d7ee846 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -14,14 +14,6 @@
 
 #include <uapi/asm/unistd.h>
 
-#ifdef CONFIG_MIPS32_N32
-#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls)
-#elif defined(CONFIG_64BIT)
-#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls)
-#else
-#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #define __ARCH_WANT_NEW_STAT
diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index 6914be5..c897195 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -395,11 +395,6 @@
 #define __NR_syscalls			368
 #endif
 
-/*
- * Offset of the last Linux o32 flavoured syscall
- */
-#define __NR_Linux_syscalls		__NR_syscalls
-
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
@@ -745,11 +740,6 @@
 #define __NR_syscalls			328
 #endif
 
-/*
- * Offset of the last Linux 64-bit flavoured syscall
- */
-#define __NR_Linux_syscalls		__NR_syscalls
-
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
@@ -1099,11 +1089,6 @@
 #define __NR_syscalls			332
 #endif
 
-/*
- * Offset of the last N32 flavoured syscall
- */
-#define __NR_Linux_syscalls		__NR_syscalls
-
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 91d3c8c..fea6edb 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -22,9 +22,6 @@
 #include <asm/war.h>
 #include <asm/asm-offsets.h>
 
-/* Highest syscall used of any syscall flavour */
-#define MAX_SYSCALL_NO	__NR_O32_Linux + __NR_O32_Linux_syscalls
-
 	.align	5
 NESTED(handle_sys, PT_SIZE, sp)
 	.set	noat
-- 
1.9.1

