Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D10C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902342086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ao/+888S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902342086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeKOQVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:21:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33035 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeKOQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:21:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id v68-v6so9177366pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 22:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+J+EsNf/z/SpprHT37g8tHjBbiQ7WRb1ppTyq2LB+QA=;
        b=Ao/+888SLr/IwF8nFLlynr6E6vYQDTwPatpR97LBjD34PI5hNg6J4Sp6AtkT4lTRKi
         xZPi66MAynNsNWW/eC4yvtm8SUVOktm4Mxypjfuv70WObbESoTBA75DHqtQYuHTwgbSg
         q/j9XZb95xXSmcwcdafB2lmdo/WTrrr/+N0lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+J+EsNf/z/SpprHT37g8tHjBbiQ7WRb1ppTyq2LB+QA=;
        b=rAdeU6EvZWfAyW6Qomuevr5lheo2YIASpbOqva3RJDTonNCcW9yS0bhrdiLCMA8vex
         vE1TOQ8ctHCg5NLHw0IfceFK4/u97da9BUWjtVGw8Dpn7oe8GhLhlloFM3zCZy897Le9
         ps15qIxGDYVPwBkMK8aeQojsCVZpY4iY5llbY6JPQv4NouF2cka3BlH+KN8eMIr0Abva
         7S24F2qj2NYFl3WHX3rYxP7iI+cvC4pko16VqCIWG/p3sRD5eVfs6C3x6G5YH21CTSMJ
         +u0IXWGCk3ch4xBHMhtLj3jQFgFua5PP7jVewjsOwaiETQRjuyuiDf7waZSUX6LooflL
         Ol7g==
X-Gm-Message-State: AGRZ1gJzyhFp0TSALUx9HvDvc3wkplKPJJqYYnL9H5JJE3T3yx89i1oK
        xsZ3/DPWGv5jD6KW81FNMsQZMw==
X-Google-Smtp-Source: AJdET5eS2GULoIlfE4hCIZUEaX0JY6TlRkEb0vjN84guKLocZmlPj2XM58PsNrQ5omzV2IS5YLKKzw==
X-Received: by 2002:a62:1541:: with SMTP id 62mr5148117pfv.230.1542262500723;
        Wed, 14 Nov 2018 22:15:00 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 34sm39861931pgp.90.2018.11.14.22.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 22:15:00 -0800 (PST)
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
Subject: [PATCH v2 2/5] mips: add +1 to __NR_syscalls in uapi header
Date:   Thu, 15 Nov 2018 11:44:18 +0530
Message-Id: <1542262461-29024-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other architectures are hold a value for __NR_syscalls will
be equal to the last system call number +1.

But in mips architecture, __NR_syscalls hold the value equal to
total number of system exits in the architecture. One of the
patch in this patch series will genarate uapi header files.

In order to make the implementation common across all architect-
ures, add +1 to __NR_syscalls, which will be equal to the last
system call number +1.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/asm/unistd.h      | 6 +++---
 arch/mips/include/uapi/asm/unistd.h | 6 +++---
 arch/mips/kernel/ftrace.c           | 6 +++---
 arch/mips/kernel/scall32-o32.S      | 6 +++---
 arch/mips/kernel/scall64-64.S       | 2 +-
 arch/mips/kernel/scall64-n32.S      | 4 ++--
 arch/mips/kernel/scall64-o32.S      | 6 +++---
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index c68b8ae..16f21c3 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -15,11 +15,11 @@
 #include <uapi/asm/unistd.h>
 
 #ifdef CONFIG_MIPS32_N32
-#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls)
+#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls - 1)
 #elif defined(CONFIG_64BIT)
-#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls)
+#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls - 1)
 #else
-#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
+#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls - 1)
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index 0ccf954..9a19b347 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -392,7 +392,7 @@
 #define __NR_io_pgetevents		(__NR_Linux + 368)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			368
+#define __NR_syscalls			369
 #endif
 
 /*
@@ -742,7 +742,7 @@
 #define __NR_io_pgetevents		(__NR_Linux + 328)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			328
+#define __NR_syscalls			329
 #endif
 
 /*
@@ -1096,7 +1096,7 @@
 #define __NR_io_pgetevents		(__NR_Linux + 332)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			332
+#define __NR_syscalls			333
 #endif
 
 /*
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 7f3dfdb..add4301 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -410,13 +410,13 @@ unsigned long __init arch_syscall_addr(int nr)
 unsigned long __init arch_syscall_addr(int nr)
 {
 #ifdef CONFIG_MIPS32_N32
-	if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls)
+	if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls - 1)
 		return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
 #endif
-	if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls)
+	if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls - 1)
 		return (unsigned long)sys_call_table[nr - __NR_64_Linux];
 #ifdef CONFIG_MIPS32_O32
-	if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls)
+	if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls - 1)
 		return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
 #endif
 
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 91d3c8c..a9b895f 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -23,7 +23,7 @@
 #include <asm/asm-offsets.h>
 
 /* Highest syscall used of any syscall flavour */
-#define MAX_SYSCALL_NO	__NR_O32_Linux + __NR_O32_Linux_syscalls
+#define MAX_SYSCALL_NO	__NR_O32_Linux + __NR_O32_Linux_syscalls - 1
 
 	.align	5
 NESTED(handle_sys, PT_SIZE, sp)
@@ -89,7 +89,7 @@ loads_done:
 	bnez	t0, syscall_trace_entry # -> yes
 syscall_common:
 	subu	v0, v0, __NR_O32_Linux	# check syscall number
-	sltiu	t0, v0, __NR_O32_Linux_syscalls + 1
+	sltiu	t0, v0, __NR_O32_Linux_syscalls
 	beqz	t0, illegal_syscall
 
 	sll	t0, v0, 2
@@ -185,7 +185,7 @@ illegal_syscall:
 
 	LEAF(sys_syscall)
 	subu	t0, a0, __NR_O32_Linux	# check syscall number
-	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	v0, t0, __NR_O32_Linux_syscalls
 	beqz	t0, einval		# do not recurse
 	sll	t1, t0, 2
 	beqz	v0, einval
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 358d959..0b67fed 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -54,7 +54,7 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 syscall_common:
 	dsubu	t2, v0, __NR_64_Linux
-	sltiu   t0, t2, __NR_64_Linux_syscalls + 1
+	sltiu   t0, t2, __NR_64_Linux_syscalls
 	beqz	t0, illegal_syscall
 
 	dsll	t0, t2, 3		# offset into table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index c65eaac..6468546 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -33,7 +33,7 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 #endif
 
 	dsubu	t0, v0, __NR_N32_Linux	# check syscall number
-	sltiu	t0, t0, __NR_N32_Linux_syscalls + 1
+	sltiu	t0, t0, __NR_N32_Linux_syscalls
 
 #ifndef CONFIG_MIPS32_O32
 	ld	t1, PT_EPC(sp)		# skip syscall on return
@@ -87,7 +87,7 @@ n32_syscall_trace_entry:
 	ld	a5, PT_R9(sp)
 
 	dsubu	t2, v0, __NR_N32_Linux	# check (new) syscall number
-	sltiu   t0, t2, __NR_N32_Linux_syscalls + 1
+	sltiu   t0, t2, __NR_N32_Linux_syscalls
 	beqz	t0, not_n32_scall
 
 	j	syscall_common
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 73913f0..eb53d8ea 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -34,7 +34,7 @@ NESTED(handle_sys, PT_SIZE, sp)
 	ld	t1, PT_EPC(sp)		# skip syscall on return
 
 	dsubu	t0, v0, __NR_O32_Linux	# check syscall number
-	sltiu	t0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	t0, t0, __NR_O32_Linux_syscalls
 	daddiu	t1, 4			# skip to next instruction
 	sd	t1, PT_EPC(sp)
 	beqz	t0, not_o32_scall
@@ -144,7 +144,7 @@ trace_a_syscall:
 	ld	a7, PT_R11(sp)		# For indirect syscalls
 
 	dsubu	t0, v0, __NR_O32_Linux	# check (new) syscall number
-	sltiu	t0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	t0, t0, __NR_O32_Linux_syscalls
 	beqz	t0, not_o32_scall
 
 	j	syscall_common
@@ -193,7 +193,7 @@ not_o32_scall:
 
 LEAF(sys32_syscall)
 	subu	t0, a0, __NR_O32_Linux	# check syscall number
-	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	v0, t0, __NR_O32_Linux_syscalls
 	beqz	t0, einval		# do not recurse
 	dsll	t1, t0, 3
 	beqz	v0, einval
-- 
1.9.1

