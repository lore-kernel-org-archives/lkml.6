Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37467C46473
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EDE21C3D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIsgpav1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EDE21C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeHIH2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:28:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44478 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeHIH2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:28:45 -0400
Received: by mail-pl0-f66.google.com with SMTP id ba4-v6so2013916plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tUQofjQwIHm19E9WSrQWhbeSjRncQSUoHtDvIO9CX5Y=;
        b=cIsgpav1KCxMzwQB2u0SVEClPtZgsjfv1yTaDv/aLCI8Ack1U3RgU+YSox2BZL/gwY
         AGSg/wax9jjqWh+PjU4Pi1ZTysQeSbjWPRgD59Zx58lRNfxlP16rNHvaHutORs9uoGJv
         /i01e6kf0YzZ1ZeXfSHrSxSKLPj2GmDX1jHAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tUQofjQwIHm19E9WSrQWhbeSjRncQSUoHtDvIO9CX5Y=;
        b=fZRyDggt11GwEI4bkiwHP9k1bXAsj/0GcZ45AaoWVIHkmtBBbE7ScnD/ys3yBh/3UT
         zHt1zo+VL4xXfOZ26BSa1kiu+8zQjHmA2jxcG+hjSW7W+mF2AaSZSQ567UpGcwCdeMqe
         xrhff54+iGsFnzUlAOE3ZHScOtQ63QMPBUKhxIvnCaBzHxHYQ3tc5j6Ndea7vgK6Gd/c
         hj/dGiFz8a/3hkkEJInMiPtkxe0FSKOPSP9cNot3Msik5h3NjvsKDH6iYy+cFzAilaLi
         LkZhnu4nGFe5HXHmSNgAvi89t9IeE50RCaxrLeKBeJmujz5dQlj/HbL28wBAkfQ6NYXr
         ic1A==
X-Gm-Message-State: AOUpUlGPSLNdxsYNeJ4zHkKv+WjNtM1FuKog0Q+qQvynLC2NGKGsSkh7
        K5+ExUDT53vpvXhMEeRynL9Wew==
X-Google-Smtp-Source: AA+uWPzStULxTZKGc3iPTPWr1ehzLO4FX5+jwdE2HHxhpDgksn3rQ6ZJZPb+caOLU5ClpfMVkYSgnw==
X-Received: by 2002:a17:902:6e16:: with SMTP id u22-v6mr595286plk.13.1533791148369;
        Wed, 08 Aug 2018 22:05:48 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id c1-v6sm6919419pfi.142.2018.08.08.22.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 22:05:47 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/5] ia64: Replace NR_syscalls macro from asm/unistd.h
Date:   Thu,  9 Aug 2018 10:35:11 +0530
Message-Id: <1533791115-3681-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533791115-3681-1-git-send-email-firoz.khan@linaro.org>
References: <1533791115-3681-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_syscalls macro holds the number of system call exist in IA64
architecture. This macro is currently the part of asm/unistd.h file.
We have to change the value of __NR_syscalls, if we add or delete a
system call.

One of the patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file contains
the number of system call information. So we have two option to update
__NR_syscalls value.

1. Update __NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update __NR_syscalls untill
   we either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update __NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
name also changed form NR_syscalls to __NR_syscalls for making the
name convention same across all architecture. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/include/asm/unistd.h      | 4 ----
 arch/ia64/include/uapi/asm/unistd.h | 2 ++
 arch/ia64/kernel/entry.S            | 4 ++--
 arch/ia64/kernel/fsys.S             | 2 +-
 arch/ia64/kernel/gate.S             | 4 ++--
 arch/ia64/kernel/ivt.S              | 2 +-
 arch/ia64/kernel/patch.c            | 2 +-
 arch/ia64/mm/init.c                 | 6 +++---
 8 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index ffb705d..6d1b047 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -10,10 +10,6 @@
 
 #include <uapi/asm/unistd.h>
 
-
-
-#define NR_syscalls			326 /* length of syscall table */
-
 /*
  * The following defines stop scripts/checksyscalls.sh from complaining about
  * unimplemented system calls.  Glibc provides for each of these by using
diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index 5fe71d4..52c6712 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -341,4 +341,6 @@
 #define __NR_preadv2			1348
 #define __NR_pwritev2			1349
 
+#define __NR_syscalls			326 /* length of syscall table */
+
 #endif /* _UAPI_ASM_IA64_UNISTD_H */
diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index 68362b3..f40d9fd 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -501,7 +501,7 @@ GLOBAL_ENTRY(ia64_trace_syscall)
 	adds r15=PT(R15)+16,sp			// r15 = &pt_regs.r15 (syscall #)
 	;;
 	ld8 r15=[r15]
-	mov r3=NR_syscalls - 1
+	mov r3=__NR_syscalls - 1
 	;;
 	adds r15=-1024,r15
 	movl r16=sys_call_table
@@ -1757,4 +1757,4 @@ sys_call_table:
 	data8 sys_preadv2
 	data8 sys_pwritev2
 
-	.org sys_call_table + 8*NR_syscalls	// guard against failures to increase NR_syscalls
+	.org sys_call_table + 8*__NR_syscalls	// guard against failures to increase __NR_syscalls
diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
index fe742ff..2d33cff 100644
--- a/arch/ia64/kernel/fsys.S
+++ b/arch/ia64/kernel/fsys.S
@@ -834,4 +834,4 @@ fsyscall_table:
 
 	// fill in zeros for the remaining entries
 	.zero:
-	.space fsyscall_table + 8*NR_syscalls - .zero, 0
+	.space fsyscall_table + 8*__NR_syscalls - .zero, 0
diff --git a/arch/ia64/kernel/gate.S b/arch/ia64/kernel/gate.S
index 9f235cd..eeafa31 100644
--- a/arch/ia64/kernel/gate.S
+++ b/arch/ia64/kernel/gate.S
@@ -331,12 +331,12 @@ GLOBAL_ENTRY(__kernel_syscall_via_epc)
 	;;
 	mov r16=IA64_KR(CURRENT)		// M2 (12 cyc)
 	shladd r18=r17,3,r14			// A
-	mov r19=NR_syscalls-1			// A
+	mov r19=__NR_syscalls-1			// A
 	;;
 	lfetch [r18]				// M0|1
 	MOV_FROM_PSR(p0, r29, r8)		// M2 (12 cyc)
 	// If r17 is a NaT, p6 will be zero
-	cmp.geu p6,p7=r19,r17			// A    (sysnr > 0 && sysnr < 1024+NR_syscalls)?
+	cmp.geu p6,p7=r19,r17			// A    (sysnr > 0 && sysnr < 1024+__NR_syscalls)?
 	;;
 	mov r21=ar.fpsr				// M2 (12 cyc)
 	tnat.nz p10,p9=r15			// I0
diff --git a/arch/ia64/kernel/ivt.S b/arch/ia64/kernel/ivt.S
index 1efcbe5..93ddc00 100644
--- a/arch/ia64/kernel/ivt.S
+++ b/arch/ia64/kernel/ivt.S
@@ -763,7 +763,7 @@ ENTRY(break_fault)
 
 	adds r16=IA64_TASK_THREAD_ON_USTACK_OFFSET,r16
 	adds r15=-1024,r15			// A    subtract 1024 from syscall number
-	mov r3=NR_syscalls - 1
+	mov r3=__NR_syscalls - 1
 	;;
 	ld1.bias r17=[r16]			// M0|1 r17 = current->thread.on_ustack flag
 	ld4 r9=[r9]				// M0|1 r9 = current_thread_info()->flags
diff --git a/arch/ia64/kernel/patch.c b/arch/ia64/kernel/patch.c
index 7f21a8c..d2e7e31 100644
--- a/arch/ia64/kernel/patch.c
+++ b/arch/ia64/kernel/patch.c
@@ -172,7 +172,7 @@
 static void __init
 patch_fsyscall_table (unsigned long start, unsigned long end)
 {
-	extern unsigned long fsyscall_table[NR_syscalls];
+	extern unsigned long fsyscall_table[__NR_syscalls];
 	s32 *offp = (s32 *) start;
 	u64 ip;
 
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 3b85c3e..0096be4 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -635,9 +635,9 @@ int __init register_active_ranges(u64 start, u64 len, int nid)
 	 * (heavy-weight) handler, but mark it by setting bit 0, so the fsyscall entry
 	 * code can tell them apart.
 	 */
-	for (i = 0; i < NR_syscalls; ++i) {
-		extern unsigned long fsyscall_table[NR_syscalls];
-		extern unsigned long sys_call_table[NR_syscalls];
+	for (i = 0; i < __NR_syscalls; ++i) {
+		extern unsigned long fsyscall_table[__NR_syscalls];
+		extern unsigned long sys_call_table[__NR_syscalls];
 
 		if (!fsyscall_table[i] || nolwsys)
 			fsyscall_table[i] = sys_call_table[i] | 1;
-- 
1.9.1

