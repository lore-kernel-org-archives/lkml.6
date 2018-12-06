Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB60C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0D52146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3EqLnqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0D52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeLFFTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:19:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35749 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeLFFTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:19:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so11195379pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 21:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7iI/vWBVEqeCEDADJAjCU0rFf7OvEua9a8NIT2lyY8g=;
        b=C3EqLnqnVBqvRrUseu2zzyVgmfnxooEuAz3qkfBJtopvw1WBQAvI+O0ssTDsHnkiuj
         NOGt7zXC5KR4aOoEosFzuagBEIFqs8APfnLR6eD025dfCNOb602k63NTz9Lr/QT5dslE
         TiJo/tm32hsobkeQlIDPQU9Mzl3zzRIlovC+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7iI/vWBVEqeCEDADJAjCU0rFf7OvEua9a8NIT2lyY8g=;
        b=UbomUO756DgPijugqBl5AFCc1oQ2BxDB2DdBKKVtqwF374R4jSVL/ZbRytEdHovYZn
         IV15GaRRm63DdEqTL0b5AyVdWOZwdtCduhYQ+mGmP8q1cV9rK18CnItybbb2l545U8z6
         yqhE0dIYVjKycrcidDCJ47jy12VnLH3TWSxwztIJND3qwSkRDGCUL7FwNwlW1AUjNvUW
         vyhvnG7IZNhe4e2aHMkG9X5CB3qQbDCBfiMSvFty5nc5s/C6zdQOUNTXk4Q4O+7UvmEF
         L6wEYt+gFHGPNViM8xWz3ug2p4uNu/DH2e9am1eYf7fQoEg93hLX5rBnVPCQwLibh269
         eqCQ==
X-Gm-Message-State: AA+aEWbgfEWe3zJnAublFpcdOhvNxVD5bpEIkmcxveVlssuMYtIoK4Qw
        8ulI1sMGA9Tpn7DDzr1ehnVmgw==
X-Google-Smtp-Source: AFSGD/UaZY+U9gVMvN/A/4VFRoDgm6BXoGHnCmZLEVtKU6NBMNKdpljtBxNhLrHKzvhDxpJnaAVEtw==
X-Received: by 2002:a62:d885:: with SMTP id e127mr27041995pfg.197.1544073579519;
        Wed, 05 Dec 2018 21:19:39 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id r66sm32877803pfk.157.2018.12.05.21.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 21:19:39 -0800 (PST)
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
Subject: [PATCH v4 4/7] mips: add +1 to __NR_syscalls in uapi header
Date:   Thu,  6 Dec 2018 10:48:25 +0530
Message-Id: <1544073508-13720-5-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
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
 arch/mips/include/uapi/asm/unistd.h | 12 ++++++------
 arch/mips/kernel/ftrace.c           |  6 +++---
 arch/mips/kernel/scall32-o32.S      |  4 ++--
 arch/mips/kernel/scall64-n32.S      |  4 ++--
 arch/mips/kernel/scall64-n64.S      |  2 +-
 arch/mips/kernel/scall64-o32.S      |  6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index b997f43..b10e94c 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -392,13 +392,13 @@
 #define __NR_io_pgetevents		(__NR_Linux + 368)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			368
+#define __NR_syscalls			369
 #endif
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		368
+#define __NR_O32_Linux_syscalls		369
 
 #if _MIPS_SIM == _MIPS_SIM_ABIN64
 
@@ -737,13 +737,13 @@
 #define __NR_io_pgetevents		(__NR_Linux + 328)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			328
+#define __NR_syscalls			329
 #endif
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABIN64 */
 
 #define __NR_N64_Linux			5000
-#define __NR_N64_Linux_syscalls		328
+#define __NR_N64_Linux_syscalls		329
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1086,12 +1086,12 @@
 #define __NR_io_pgetevents		(__NR_Linux + 332)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			332
+#define __NR_syscalls			333
 #endif
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		332
+#define __NR_N32_Linux_syscalls		333
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index d91a6e7..be8e69f 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -400,13 +400,13 @@ unsigned long __init arch_syscall_addr(int nr)
 unsigned long __init arch_syscall_addr(int nr)
 {
 #ifdef CONFIG_MIPS32_N32
-	if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls)
+	if (nr >= __NR_N32_Linux && nr < __NR_N32_Linux + __NR_N32_Linux_syscalls)
 		return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
 #endif
-	if (nr >= __NR_N64_Linux  && nr <= __NR_N64_Linux + __NR_N64_Linux_syscalls)
+	if (nr >= __NR_N64_Linux  && nr < __NR_N64_Linux + __NR_N64_Linux_syscalls)
 		return (unsigned long)sys_call_table[nr - __NR_N64_Linux];
 #ifdef CONFIG_MIPS32_O32
-	if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls)
+	if (nr >= __NR_O32_Linux && nr < __NR_O32_Linux + __NR_O32_Linux_syscalls)
 		return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
 #endif
 
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index fea6edb..10f6367 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -86,7 +86,7 @@ loads_done:
 	bnez	t0, syscall_trace_entry # -> yes
 syscall_common:
 	subu	v0, v0, __NR_O32_Linux	# check syscall number
-	sltiu	t0, v0, __NR_O32_Linux_syscalls + 1
+	sltiu	t0, v0, __NR_O32_Linux_syscalls
 	beqz	t0, illegal_syscall
 
 	sll	t0, v0, 2
@@ -182,7 +182,7 @@ illegal_syscall:
 
 	LEAF(sys_syscall)
 	subu	t0, a0, __NR_O32_Linux	# check syscall number
-	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	v0, t0, __NR_O32_Linux_syscalls
 	beqz	t0, einval		# do not recurse
 	sll	t1, t0, 2
 	beqz	v0, einval
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
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index 497cd62..0bded19 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -54,7 +54,7 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 syscall_common:
 	dsubu	t2, v0, __NR_N64_Linux
-	sltiu   t0, t2, __NR_N64_Linux_syscalls + 1
+	sltiu   t0, t2, __NR_N64_Linux_syscalls
 	beqz	t0, illegal_syscall
 
 	dsll	t0, t2, 3		# offset into table
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

