Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8B6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7B2257C6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y7zzreDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7B2257C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965397AbeFZC7u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:32884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965362AbeFZC7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:59:47 -0400
Received: from localhost.localdomain (h2133.porttelecom.ru [193.189.69.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD63126474;
        Tue, 26 Jun 2018 02:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529981986;
        bh=QxREJcBmi03ahWBD7Qje7OFMxp8ddABRh6mAha/fRi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7zzreDHSMgDBTG9StM4KK67W+wp0t3uVn/3zWgonelJDijvZ2qdwdDZfHs+x7ZK4
         t056K1oTkkKS8s8YSDUAcJ3HhSnU8OKPcKMZKYOTk/pDSgcIwKXEp03VpODvf34q1m
         Qu4Vbr60AwHQqP71WXUsfMy0R71lkq9P4wM7O4W8=
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
Subject: [PATCH 05/12] arm: Implement hw_breakpoint_arch_parse()
Date:   Tue, 26 Jun 2018 04:58:52 +0200
Message-Id: <1529981939-8231-6-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529981939-8231-1-git-send-email-frederic@kernel.org>
References: <1529981939-8231-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit.

Acked-by: Mark Rutland <mark.rutland@arm.com>
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
 arch/arm/include/asm/hw_breakpoint.h |  6 ++-
 arch/arm/kernel/hw_breakpoint.c      | 71 ++++++++++++++++++------------------
 2 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index d5a0f52..1e02925 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -111,6 +111,7 @@ static inline void decode_ctrl_reg(u32 reg,
 	asm volatile("mcr p14, 0, %0, " #N "," #M ", " #OP2 : : "r" (VAL));\
 } while (0)
 
+struct perf_event_attr;
 struct notifier_block;
 struct perf_event;
 struct pmu;
@@ -118,7 +119,10 @@ struct pmu;
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type);
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_parse(struct perf_event *bp,
+				    const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 385dcf4..1d5fbf1 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -517,42 +517,42 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 /*
  * Construct an arch_hw_breakpoint from a perf_event.
  */
-static int arch_build_bp_info(struct perf_event *bp)
+static int arch_build_bp_info(struct perf_event *bp,
+			      const struct perf_event_attr *attr,
+			      struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_X:
-		info->ctrl.type = ARM_BREAKPOINT_EXECUTE;
+		hw->ctrl.type = ARM_BREAKPOINT_EXECUTE;
 		break;
 	case HW_BREAKPOINT_R:
-		info->ctrl.type = ARM_BREAKPOINT_LOAD;
+		hw->ctrl.type = ARM_BREAKPOINT_LOAD;
 		break;
 	case HW_BREAKPOINT_W:
-		info->ctrl.type = ARM_BREAKPOINT_STORE;
+		hw->ctrl.type = ARM_BREAKPOINT_STORE;
 		break;
 	case HW_BREAKPOINT_RW:
-		info->ctrl.type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
+		hw->ctrl.type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* Len */
-	switch (bp->attr.bp_len) {
+	switch (attr->bp_len) {
 	case HW_BREAKPOINT_LEN_1:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_1;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_1;
 		break;
 	case HW_BREAKPOINT_LEN_2:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_2;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_2;
 		break;
 	case HW_BREAKPOINT_LEN_4:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_4;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
 		break;
 	case HW_BREAKPOINT_LEN_8:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_8;
-		if ((info->ctrl.type != ARM_BREAKPOINT_EXECUTE)
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_8;
+		if ((hw->ctrl.type != ARM_BREAKPOINT_EXECUTE)
 			&& max_watchpoint_len >= 8)
 			break;
 	default:
@@ -565,24 +565,24 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * by the hardware and must be aligned to the appropriate number of
 	 * bytes.
 	 */
-	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE &&
-	    info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
-	    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
+	if (hw->ctrl.type == ARM_BREAKPOINT_EXECUTE &&
+	    hw->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
+	    hw->ctrl.len != ARM_BREAKPOINT_LEN_4)
 		return -EINVAL;
 
 	/* Address */
-	info->address = bp->attr.bp_addr;
+	hw->address = attr->bp_addr;
 
 	/* Privilege */
-	info->ctrl.privilege = ARM_BREAKPOINT_USER;
-	if (arch_check_bp_in_kernelspace(info))
-		info->ctrl.privilege |= ARM_BREAKPOINT_PRIV;
+	hw->ctrl.privilege = ARM_BREAKPOINT_USER;
+	if (arch_check_bp_in_kernelspace(hw))
+		hw->ctrl.privilege |= ARM_BREAKPOINT_PRIV;
 
 	/* Enabled? */
-	info->ctrl.enabled = !bp->attr.disabled;
+	hw->ctrl.enabled = !attr->disabled;
 
 	/* Mismatch */
-	info->ctrl.mismatch = 0;
+	hw->ctrl.mismatch = 0;
 
 	return 0;
 }
@@ -590,9 +590,10 @@ static int arch_build_bp_info(struct perf_event *bp)
 /*
  * Validate the arch-specific HW Breakpoint register settings.
  */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	int ret = 0;
 	u32 offset, alignment_mask = 0x3;
 
@@ -601,14 +602,14 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 		return -ENODEV;
 
 	/* Build the arch_hw_breakpoint. */
-	ret = arch_build_bp_info(bp);
+	ret = arch_build_bp_info(bp, attr, hw);
 	if (ret)
 		goto out;
 
 	/* Check address alignment. */
-	if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
+	if (hw->ctrl.len == ARM_BREAKPOINT_LEN_8)
 		alignment_mask = 0x7;
-	offset = info->address & alignment_mask;
+	offset = hw->address & alignment_mask;
 	switch (offset) {
 	case 0:
 		/* Aligned */
@@ -616,19 +617,19 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	case 1:
 	case 2:
 		/* Allow halfword watchpoints and breakpoints. */
-		if (info->ctrl.len == ARM_BREAKPOINT_LEN_2)
+		if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
 			break;
 	case 3:
 		/* Allow single byte watchpoint. */
-		if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
+		if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
 			break;
 	default:
 		ret = -EINVAL;
 		goto out;
 	}
 
-	info->address &= ~alignment_mask;
-	info->ctrl.len <<= offset;
+	hw->address &= ~alignment_mask;
+	hw->ctrl.len <<= offset;
 
 	if (is_default_overflow_handler(bp)) {
 		/*
@@ -639,7 +640,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 			return -EINVAL;
 
 		/* We don't allow mismatch breakpoints in kernel space. */
-		if (arch_check_bp_in_kernelspace(info))
+		if (arch_check_bp_in_kernelspace(hw))
 			return -EPERM;
 
 		/*
@@ -654,8 +655,8 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 		 * reports them.
 		 */
 		if (!debug_exception_updates_fsr() &&
-		    (info->ctrl.type == ARM_BREAKPOINT_LOAD ||
-		     info->ctrl.type == ARM_BREAKPOINT_STORE))
+		    (hw->ctrl.type == ARM_BREAKPOINT_LOAD ||
+		     hw->ctrl.type == ARM_BREAKPOINT_STORE))
 			return -EINVAL;
 	}
 
-- 
2.7.4

