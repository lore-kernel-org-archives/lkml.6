Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E447C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11AD2646C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB6yfrIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11AD2646C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965345AbeFZC7i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965232AbeFZC7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:59:35 -0400
Received: from localhost.localdomain (h2133.porttelecom.ru [193.189.69.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BEEC26470;
        Tue, 26 Jun 2018 02:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529981975;
        bh=5YW+JhPUxTcoMPOm7alUcUDpb0kZMHG0WxVzVdEvgU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pB6yfrIufV7XJsi9CSY6obT7oRqyV5uWFlsV6qAjA2GytRDxAaEABQuZVBtXSQ1go
         drw/EbKOA4s6/Ja6YHT77vphc3gbnij4uB3snP/FwJB2BNW48ntTeJj3ISPjVX7Ocl
         UuyntQQkHd+8j7maZl618XfjJJ5L0ipe+keS/1FE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 03/12] x86: Implement hw_breakpoint_arch_parse()
Date:   Tue, 26 Jun 2018 04:58:50 +0200
Message-Id: <1529981939-8231-4-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529981939-8231-1-git-send-email-frederic@kernel.org>
References: <1529981939-8231-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit.

Original-patch-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h |  6 +++-
 arch/x86/kernel/hw_breakpoint.c      | 60 ++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 7892459..6c88e8e2 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -49,11 +49,15 @@ static inline int hw_breakpoint_slots(int type)
 	return HBP_NUM;
 }
 
+struct perf_event_attr;
 struct perf_event;
 struct pmu;
 
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_parse(struct perf_event *bp,
+				    const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index c433791..34a5c17 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -239,19 +239,20 @@ int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 	return (va >= TASK_SIZE_MAX) || ((va + len - 1) >= TASK_SIZE_MAX);
 }
 
-static int arch_build_bp_info(struct perf_event *bp)
+static int arch_build_bp_info(struct perf_event *bp,
+			      const struct perf_event_attr *attr,
+			      struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
-	info->address = bp->attr.bp_addr;
+	hw->address = attr->bp_addr;
+	hw->mask = 0;
 
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_W:
-		info->type = X86_BREAKPOINT_WRITE;
+		hw->type = X86_BREAKPOINT_WRITE;
 		break;
 	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
-		info->type = X86_BREAKPOINT_RW;
+		hw->type = X86_BREAKPOINT_RW;
 		break;
 	case HW_BREAKPOINT_X:
 		/*
@@ -259,23 +260,23 @@ static int arch_build_bp_info(struct perf_event *bp)
 		 * acceptable for kprobes.  On non-kprobes kernels, we don't
 		 * allow kernel breakpoints at all.
 		 */
-		if (bp->attr.bp_addr >= TASK_SIZE_MAX) {
+		if (attr->bp_addr >= TASK_SIZE_MAX) {
 #ifdef CONFIG_KPROBES
-			if (within_kprobe_blacklist(bp->attr.bp_addr))
+			if (within_kprobe_blacklist(attr->bp_addr))
 				return -EINVAL;
 #else
 			return -EINVAL;
 #endif
 		}
 
-		info->type = X86_BREAKPOINT_EXECUTE;
+		hw->type = X86_BREAKPOINT_EXECUTE;
 		/*
 		 * x86 inst breakpoints need to have a specific undefined len.
 		 * But we still need to check userspace is not trying to setup
 		 * an unsupported length, to get a range breakpoint for example.
 		 */
-		if (bp->attr.bp_len == sizeof(long)) {
-			info->len = X86_BREAKPOINT_LEN_X;
+		if (attr->bp_len == sizeof(long)) {
+			hw->len = X86_BREAKPOINT_LEN_X;
 			return 0;
 		}
 	default:
@@ -283,28 +284,26 @@ static int arch_build_bp_info(struct perf_event *bp)
 	}
 
 	/* Len */
-	info->mask = 0;
-
-	switch (bp->attr.bp_len) {
+	switch (attr->bp_len) {
 	case HW_BREAKPOINT_LEN_1:
-		info->len = X86_BREAKPOINT_LEN_1;
+		hw->len = X86_BREAKPOINT_LEN_1;
 		break;
 	case HW_BREAKPOINT_LEN_2:
-		info->len = X86_BREAKPOINT_LEN_2;
+		hw->len = X86_BREAKPOINT_LEN_2;
 		break;
 	case HW_BREAKPOINT_LEN_4:
-		info->len = X86_BREAKPOINT_LEN_4;
+		hw->len = X86_BREAKPOINT_LEN_4;
 		break;
 #ifdef CONFIG_X86_64
 	case HW_BREAKPOINT_LEN_8:
-		info->len = X86_BREAKPOINT_LEN_8;
+		hw->len = X86_BREAKPOINT_LEN_8;
 		break;
 #endif
 	default:
 		/* AMD range breakpoint */
-		if (!is_power_of_2(bp->attr.bp_len))
+		if (!is_power_of_2(attr->bp_len))
 			return -EINVAL;
-		if (bp->attr.bp_addr & (bp->attr.bp_len - 1))
+		if (attr->bp_addr & (attr->bp_len - 1))
 			return -EINVAL;
 
 		if (!boot_cpu_has(X86_FEATURE_BPEXT))
@@ -317,8 +316,8 @@ static int arch_build_bp_info(struct perf_event *bp)
 		 * breakpoints, then we'll have to check for kprobe-blacklisted
 		 * addresses anywhere in the range.
 		 */
-		info->mask = bp->attr.bp_len - 1;
-		info->len = X86_BREAKPOINT_LEN_1;
+		hw->mask = attr->bp_len - 1;
+		hw->len = X86_BREAKPOINT_LEN_1;
 	}
 
 	return 0;
@@ -327,22 +326,23 @@ static int arch_build_bp_info(struct perf_event *bp)
 /*
  * Validate the arch-specific HW Breakpoint register settings
  */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	unsigned int align;
 	int ret;
 
 
-	ret = arch_build_bp_info(bp);
+	ret = arch_build_bp_info(bp, attr, hw);
 	if (ret)
 		return ret;
 
-	switch (info->len) {
+	switch (hw->len) {
 	case X86_BREAKPOINT_LEN_1:
 		align = 0;
-		if (info->mask)
-			align = info->mask;
+		if (hw->mask)
+			align = hw->mask;
 		break;
 	case X86_BREAKPOINT_LEN_2:
 		align = 1;
@@ -363,7 +363,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * Check that the low-order bits of the address are appropriate
 	 * for the alignment implied by len.
 	 */
-	if (info->address & align)
+	if (hw->address & align)
 		return -EINVAL;
 
 	return 0;
-- 
2.7.4

