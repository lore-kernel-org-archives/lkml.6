Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983B0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4131926913
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4131926913
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934806AbeFZK1O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:27:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934448AbeFZK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:27:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QAQBTv1648165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:26:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QAQBCT1648162;
        Tue, 26 Jun 2018 03:26:11 -0700
Date:   Tue, 26 Jun 2018 03:26:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-8e983ff9ac02a8fb454ed09c2462bdb3617006a8@git.kernel.org>
Cc:     catalin.marinas@arm.com, ysato@users.sourceforge.jp,
        frederic@kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, jcmvbkbc@gmail.com, jolsa@redhat.com,
        mpe@ellerman.id.au, will.deacon@arm.com, hpa@zytor.com,
        joel.opensrc@gmail.com, chris@zankel.net, paulus@samba.org,
        luto@kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mingo@kernel.org, mark.rutland@arm.com,
        acme@redhat.com, dalias@libc.org, acme@kernel.org,
        namhyung@kernel.org
Reply-To: mingo@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, luto@kernel.org,
          paulus@samba.org, namhyung@kernel.org, acme@kernel.org,
          dalias@libc.org, acme@redhat.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, frederic@kernel.org,
          linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
          ysato@users.sourceforge.jp, catalin.marinas@arm.com,
          chris@zankel.net, mpe@ellerman.id.au, will.deacon@arm.com,
          hpa@zytor.com, joel.opensrc@gmail.com, jolsa@redhat.com,
          jcmvbkbc@gmail.com
In-Reply-To: <1529981939-8231-3-git-send-email-frederic@kernel.org>
References: <1529981939-8231-3-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/hw_breakpoint: Pass arch breakpoint struct to
 arch_check_bp_in_kernelspace()
Git-Commit-ID: 8e983ff9ac02a8fb454ed09c2462bdb3617006a8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8e983ff9ac02a8fb454ed09c2462bdb3617006a8
Gitweb:     https://git.kernel.org/tip/8e983ff9ac02a8fb454ed09c2462bdb3617006a8
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:49 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:54 +0200

perf/hw_breakpoint: Pass arch breakpoint struct to arch_check_bp_in_kernelspace()

We can't pass the breakpoint directly on arch_check_bp_in_kernelspace()
anymore because its architecture internal datas (struct arch_hw_breakpoint)
are not yet filled by the time we call the function, and most
implementation need this backend to be up to date. So arrange the
function to take the probing struct instead.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1529981939-8231-3-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/hw_breakpoint.h     |  2 +-
 arch/arm/kernel/hw_breakpoint.c          | 11 +++--
 arch/arm64/include/asm/hw_breakpoint.h   |  2 +-
 arch/arm64/kernel/hw_breakpoint.c        |  9 ++--
 arch/powerpc/include/asm/hw_breakpoint.h |  2 +-
 arch/powerpc/kernel/hw_breakpoint.c      |  6 +--
 arch/sh/include/asm/hw_breakpoint.h      |  2 +-
 arch/sh/kernel/hw_breakpoint.c           |  9 ++--
 arch/x86/include/asm/hw_breakpoint.h     |  2 +-
 arch/x86/kernel/hw_breakpoint.c          | 71 +++++++++++++++++---------------
 arch/xtensa/include/asm/hw_breakpoint.h  |  2 +-
 arch/xtensa/kernel/hw_breakpoint.c       |  7 ++--
 kernel/events/hw_breakpoint.c            |  2 +-
 13 files changed, 63 insertions(+), 64 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index e46e4e7bdba3..d5a0f52c6755 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -117,7 +117,7 @@ struct pmu;
 
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type);
-extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 629e25152c0d..385dcf45d64b 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -456,14 +456,13 @@ static int get_hbp_len(u8 hbp_len)
 /*
  * Check whether bp virtual address is in kernel space.
  */
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 {
 	unsigned int len;
 	unsigned long va;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
-	va = info->address;
-	len = get_hbp_len(info->ctrl.len);
+	va = hw->address;
+	len = get_hbp_len(hw->ctrl.len);
 
 	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
 }
@@ -576,7 +575,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 
 	/* Privilege */
 	info->ctrl.privilege = ARM_BREAKPOINT_USER;
-	if (arch_check_bp_in_kernelspace(bp))
+	if (arch_check_bp_in_kernelspace(info))
 		info->ctrl.privilege |= ARM_BREAKPOINT_PRIV;
 
 	/* Enabled? */
@@ -640,7 +639,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 			return -EINVAL;
 
 		/* We don't allow mismatch breakpoints in kernel space. */
-		if (arch_check_bp_in_kernelspace(bp))
+		if (arch_check_bp_in_kernelspace(info))
 			return -EPERM;
 
 		/*
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 41770766d964..9f4a3d48762e 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -124,7 +124,7 @@ struct pmu;
 
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type, int *offset);
-extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 413dbe530da8..6a90d12e4ff2 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -343,14 +343,13 @@ static int get_hbp_len(u8 hbp_len)
 /*
  * Check whether bp virtual address is in kernel space.
  */
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 {
 	unsigned int len;
 	unsigned long va;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
-	va = info->address;
-	len = get_hbp_len(info->ctrl.len);
+	va = hw->address;
+	len = get_hbp_len(hw->ctrl.len);
 
 	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
 }
@@ -502,7 +501,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * Note that we disallow combined EL0/EL1 breakpoints because
 	 * that would complicate the stepping code.
 	 */
-	if (arch_check_bp_in_kernelspace(bp))
+	if (arch_check_bp_in_kernelspace(info))
 		info->ctrl.privilege = AARCH64_BREAKPOINT_EL1;
 	else
 		info->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 8e7b09703ca4..4d0b1bfcdfd0 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -60,7 +60,7 @@ struct perf_sample_data;
 
 extern int hw_breakpoint_slots(int type);
 extern int arch_bp_generic_fields(int type, int *gen_bp_type);
-extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 						unsigned long val, void *data);
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 80547dad37da..899bcec3f3c8 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -119,11 +119,9 @@ void arch_unregister_hw_breakpoint(struct perf_event *bp)
 /*
  * Check for virtual address in kernel space.
  */
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
-	return is_kernel_addr(info->address);
+	return is_kernel_addr(hw->address);
 }
 
 int arch_bp_generic_fields(int type, int *gen_bp_type)
diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index 7431c172c0cb..8a88ed0b3cd7 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -54,7 +54,7 @@ static inline int hw_breakpoint_slots(int type)
 }
 
 /* arch/sh/kernel/hw_breakpoint.c */
-extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index 8648ed05ccf0..38791fefdd0c 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -124,14 +124,13 @@ static int get_hbp_len(u16 hbp_len)
 /*
  * Check for virtual address in kernel space.
  */
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 {
 	unsigned int len;
 	unsigned long va;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
-	va = info->address;
-	len = get_hbp_len(info->len);
+	va = hw->address;
+	len = get_hbp_len(hw->len);
 
 	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
 }
@@ -346,7 +345,7 @@ static int __kprobes hw_breakpoint_handler(struct die_args *args)
 		perf_bp_event(bp, args->regs);
 
 		/* Deliver the signal to userspace */
-		if (!arch_check_bp_in_kernelspace(bp)) {
+		if (!arch_check_bp_in_kernelspace(&bp->hw.info)) {
 			force_sig_fault(SIGTRAP, TRAP_HWBKPT,
 					(void __user *)NULL, current);
 		}
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index f59c39835a5a..78924596f51f 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -52,7 +52,7 @@ static inline int hw_breakpoint_slots(int type)
 struct perf_event;
 struct pmu;
 
-extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
+extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 8771766d46b6..c43379188f4f 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -169,28 +169,29 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 		set_dr_addr_mask(0, i);
 }
 
-/*
- * Check for virtual address in kernel space.
- */
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+static int arch_bp_generic_len(int x86_len)
 {
-	unsigned int len;
-	unsigned long va;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
-	va = info->address;
-	len = bp->attr.bp_len;
-
-	/*
-	 * We don't need to worry about va + len - 1 overflowing:
-	 * we already require that va is aligned to a multiple of len.
-	 */
-	return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
+	switch (x86_len) {
+	case X86_BREAKPOINT_LEN_1:
+		return HW_BREAKPOINT_LEN_1;
+	case X86_BREAKPOINT_LEN_2:
+		return HW_BREAKPOINT_LEN_2;
+	case X86_BREAKPOINT_LEN_4:
+		return HW_BREAKPOINT_LEN_4;
+#ifdef CONFIG_X86_64
+	case X86_BREAKPOINT_LEN_8:
+		return HW_BREAKPOINT_LEN_8;
+#endif
+	default:
+		return -EINVAL;
+	}
 }
 
 int arch_bp_generic_fields(int x86_len, int x86_type,
 			   int *gen_len, int *gen_type)
 {
+	int len;
+
 	/* Type */
 	switch (x86_type) {
 	case X86_BREAKPOINT_EXECUTE:
@@ -211,28 +212,32 @@ int arch_bp_generic_fields(int x86_len, int x86_type,
 	}
 
 	/* Len */
-	switch (x86_len) {
-	case X86_BREAKPOINT_LEN_1:
-		*gen_len = HW_BREAKPOINT_LEN_1;
-		break;
-	case X86_BREAKPOINT_LEN_2:
-		*gen_len = HW_BREAKPOINT_LEN_2;
-		break;
-	case X86_BREAKPOINT_LEN_4:
-		*gen_len = HW_BREAKPOINT_LEN_4;
-		break;
-#ifdef CONFIG_X86_64
-	case X86_BREAKPOINT_LEN_8:
-		*gen_len = HW_BREAKPOINT_LEN_8;
-		break;
-#endif
-	default:
+	len = arch_bp_generic_len(x86_len);
+	if (len < 0)
 		return -EINVAL;
-	}
+	*gen_len = len;
 
 	return 0;
 }
 
+/*
+ * Check for virtual address in kernel space.
+ */
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
+{
+	unsigned long va;
+	int len;
+
+	va = hw->address;
+	len = arch_bp_generic_len(hw->len);
+	WARN_ON_ONCE(len < 0);
+
+	/*
+	 * We don't need to worry about va + len - 1 overflowing:
+	 * we already require that va is aligned to a multiple of len.
+	 */
+	return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
+}
 
 static int arch_build_bp_info(struct perf_event *bp)
 {
diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/asm/hw_breakpoint.h
index dbe3053b284a..2525bf6816a6 100644
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -35,7 +35,7 @@ struct pt_regs;
 struct task_struct;
 
 int hw_breakpoint_slots(int type);
-int arch_check_bp_in_kernelspace(struct perf_event *bp);
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 int arch_validate_hwbkpt_settings(struct perf_event *bp);
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data);
diff --git a/arch/xtensa/kernel/hw_breakpoint.c b/arch/xtensa/kernel/hw_breakpoint.c
index b35656ab7dbd..6e34c3848885 100644
--- a/arch/xtensa/kernel/hw_breakpoint.c
+++ b/arch/xtensa/kernel/hw_breakpoint.c
@@ -33,14 +33,13 @@ int hw_breakpoint_slots(int type)
 	}
 }
 
-int arch_check_bp_in_kernelspace(struct perf_event *bp)
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 {
 	unsigned int len;
 	unsigned long va;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
-	va = info->address;
-	len = bp->attr.bp_len;
+	va = hw->address;
+	len = hw->len;
 
 	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
 }
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 314e2a9040c7..89fe94c9214c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -427,7 +427,7 @@ static int hw_breakpoint_parse(struct perf_event *bp,
 	if (err)
 		return err;
 
-	if (arch_check_bp_in_kernelspace(bp)) {
+	if (arch_check_bp_in_kernelspace(hw)) {
 		if (attr->exclude_kernel)
 			return -EINVAL;
 		/*
