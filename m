Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E9C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB59520837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnKqAAjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB59520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLGGMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:12:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36454 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeLGGMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:12:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so1339444plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O2M3lHo2o6XYI5wC/7SaWlJ8PncIq3R9Hnh0sXXFTvk=;
        b=cnKqAAjP9jlcqhK6twsk51NnWoOU1mUU3AlEKlOGoX96vdmfeoQGwkb2BbHX9pgjI5
         WDfCkFh8PRfUHQrpz54MaqzDVovc3snXdLFEUR9/wWP36UKcNgJs6CnqNN7jG0xtISGB
         dC+QNUMl0vMjOX8U9s0Mq7q4f2RU+LoNtWnF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O2M3lHo2o6XYI5wC/7SaWlJ8PncIq3R9Hnh0sXXFTvk=;
        b=FUVGkNUuFHkq7X9NUTtZEpZK3V8rIl947GT3HPmMBOCn0EUiiy4fUJQf6g0/Zj9FYU
         Nx7umwg+MmW44yWk9a4QvnGWew4eA9qRdrg/QeoDltZqiLfNIaJf0wZ1HTRiKvjDgKtW
         28TpIo32VcDpKnfGmtLt2vBNr+kp2pURde7eSqNuF0+WOP1s6d5dw4S27uhJs2kIp5Ik
         or0ZJjgJQOIamMHC9g9oaZlLzIO+Mx+Lvb5p+P4/CyddwuLq4A0XW015Um5guLnqoFiu
         Fg/H72Yc1sUtHP3b1cOl3JOYlv+HSjwAnWXd4iGyoxIsjrCaiZ9r4tBl/uk7Z3hjj8Tb
         sepA==
X-Gm-Message-State: AA+aEWauVF0qHvenzHFO2sWXRQnJsPlAbCsDIXwCC30t/PF7EDyYz5dz
        kSoJONT6Zx1B6b0q784Gp2KJwA==
X-Google-Smtp-Source: AFSGD/U7KXOPNgEZ4stindDXT0VzsqzBQDeAbU7ZNLspO3NYrzHO7zhVDZ42SCiUbL8qbIHakiFWOw==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr993058plf.202.1544163152372;
        Thu, 06 Dec 2018 22:12:32 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.25])
        by smtp.gmail.com with ESMTPSA id r4sm5719862pgn.54.2018.12.06.22.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 22:12:31 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 4/5] powerpc: split compat syscall table out from native table
Date:   Fri,  7 Dec 2018 11:41:39 +0530
Message-Id: <1544163100-15510-5-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PowerPC uses a syscall table with native and compat calls
interleaved, which is a slightly simpler way to define two
matching tables.

As we move to having the tables generated, that advantage
is no longer important, but the interleaved table gets in
the way of using the same scripts as on the other archit-
ectures.

Split out a new compat_sys_call_table symbol that contains
all the compat calls, and leave the main table for the nat-
ive calls, to more closely match the method we use every-
where else.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/include/asm/syscall.h |  3 +--
 arch/powerpc/kernel/entry_64.S     |  7 +++++--
 arch/powerpc/kernel/systbl.S       | 35 ++++++++++++++++++++++++++++-------
 arch/powerpc/kernel/vdso.c         |  7 +++++--
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index ab9f3f0..1a0e7a8 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -18,9 +18,8 @@
 #include <linux/thread_info.h>
 
 /* ftrace syscalls requires exporting the sys_call_table */
-#ifdef CONFIG_FTRACE_SYSCALLS
 extern const unsigned long sys_call_table[];
-#endif /* CONFIG_FTRACE_SYSCALLS */
+extern const unsigned long compat_sys_call_table[];
 
 static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 {
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7b1693a..5574d92 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -54,6 +54,9 @@
 SYS_CALL_TABLE:
 	.tc sys_call_table[TC],sys_call_table
 
+COMPAT_SYS_CALL_TABLE:
+	.tc compat_sys_call_table[TC],compat_sys_call_table
+
 /* This value is used to mark exception frames on the stack. */
 exception_marker:
 	.tc	ID_EXC_MARKER[TC],STACK_FRAME_REGS_MARKER
@@ -173,7 +176,7 @@ system_call:			/* label this so stack traces look sane */
 	ld	r11,SYS_CALL_TABLE@toc(2)
 	andis.	r10,r10,_TIF_32BIT@h
 	beq	15f
-	addi	r11,r11,8	/* use 32-bit syscall entries */
+	ld	r11,COMPAT_SYS_CALL_TABLE@toc(2)
 	clrldi	r3,r3,32
 	clrldi	r4,r4,32
 	clrldi	r5,r5,32
@@ -181,7 +184,7 @@ system_call:			/* label this so stack traces look sane */
 	clrldi	r7,r7,32
 	clrldi	r8,r8,32
 15:
-	slwi	r0,r0,4
+	slwi	r0,r0,3
 
 	barrier_nospec_asm
 	/*
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 9ff1913..0fa84e1 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -17,13 +17,13 @@
 #include <asm/ppc_asm.h>
 
 #ifdef CONFIG_PPC64
-#define SYSCALL(func)		.8byte	DOTSYM(sys_##func),DOTSYM(sys_##func)
-#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func),DOTSYM(compat_sys_##func)
-#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(ppc_##func)
-#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(sys_ni_syscall)
-#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(compat_sys_##func)
-#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(sys_ni_syscall)
-#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f),DOTSYM(f3264)
+#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
+#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func)
+#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
+#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func)
+#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f)
 #else
 #define SYSCALL(func)		.long	sys_##func
 #define COMPAT_SYS(func)	.long	sys_##func
@@ -46,6 +46,27 @@
 
 .globl sys_call_table
 sys_call_table:
+#include <asm/systbl.h>
+
+#undef SYSCALL
+#undef COMPAT_SYS
+#undef PPC_SYS
+#undef OLDSYS
+#undef SYS32ONLY
+#undef PPC64ONLY
+#undef SYSX
 
+#ifdef CONFIG_COMPAT
+#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
+#define COMPAT_SYS(func)	.8byte	DOTSYM(compat_sys_##func)
+#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
+#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYS32ONLY(func)		.8byte	DOTSYM(compat_sys_##func)
+#define PPC64ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f3264)
+
+.globl compat_sys_call_table
+compat_sys_call_table:
 #define compat_sys_sigsuspend	sys_sigsuspend
 #include <asm/systbl.h>
+#endif
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 65b3bdb..7725a97 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -671,15 +671,18 @@ static void __init vdso_setup_syscall_map(void)
 {
 	unsigned int i;
 	extern unsigned long *sys_call_table;
+#ifdef CONFIG_PPC64
+	extern unsigned long *compat_sys_call_table;
+#endif
 	extern unsigned long sys_ni_syscall;
 
 
 	for (i = 0; i < NR_syscalls; i++) {
 #ifdef CONFIG_PPC64
-		if (sys_call_table[i*2] != sys_ni_syscall)
+		if (sys_call_table[i] != sys_ni_syscall)
 			vdso_data->syscall_map_64[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
-		if (sys_call_table[i*2+1] != sys_ni_syscall)
+		if (compat_sys_call_table[i] != sys_ni_syscall)
 			vdso_data->syscall_map_32[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 #else /* CONFIG_PPC64 */
-- 
1.9.1

