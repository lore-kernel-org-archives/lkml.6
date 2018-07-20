Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADFECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA94820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA94820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390151AbeGTNbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:31:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389761AbeGTNbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:08 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 08CFACB7;
        Fri, 20 Jul 2018 12:39:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.17 094/101] arm64: ssbd: Add prctl interface for per-thread mitigation
Date:   Fri, 20 Jul 2018 14:14:40 +0200
Message-Id: <20180720121427.215562534@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 9cdc0108baa8ef87c76ed834619886a46bd70cbe upstream.

If running on a system that performs dynamic SSBD mitigation, allow
userspace to request the mitigation for itself. This is implemented
as a prctl call, allowing the mitigation to be enabled or disabled at
will for this particular thread.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/Makefile |    1 
 arch/arm64/kernel/ssbd.c   |  110 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 arch/arm64/kernel/ssbd.c

--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -54,6 +54,7 @@ arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+=
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
+arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
 obj-m					+= $(arm64-obj-m)
--- /dev/null
+++ b/arch/arm64/kernel/ssbd.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 ARM Ltd, All Rights Reserved.
+ */
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/thread_info.h>
+
+#include <asm/cpufeature.h>
+
+/*
+ * prctl interface for SSBD
+ * FIXME: Drop the below ifdefery once merged in 4.18.
+ */
+#ifdef PR_SPEC_STORE_BYPASS
+static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+	int state = arm64_get_ssbd_state();
+
+	/* Unsupported */
+	if (state == ARM64_SSBD_UNKNOWN)
+		return -EINVAL;
+
+	/* Treat the unaffected/mitigated state separately */
+	if (state == ARM64_SSBD_MITIGATED) {
+		switch (ctrl) {
+		case PR_SPEC_ENABLE:
+			return -EPERM;
+		case PR_SPEC_DISABLE:
+		case PR_SPEC_FORCE_DISABLE:
+			return 0;
+		}
+	}
+
+	/*
+	 * Things are a bit backward here: the arm64 internal API
+	 * *enables the mitigation* when the userspace API *disables
+	 * speculation*. So much fun.
+	 */
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		/* If speculation is force disabled, enable is not allowed */
+		if (state == ARM64_SSBD_FORCE_ENABLE ||
+		    task_spec_ssb_force_disable(task))
+			return -EPERM;
+		task_clear_spec_ssb_disable(task);
+		clear_tsk_thread_flag(task, TIF_SSBD);
+		break;
+	case PR_SPEC_DISABLE:
+		if (state == ARM64_SSBD_FORCE_DISABLE)
+			return -EPERM;
+		task_set_spec_ssb_disable(task);
+		set_tsk_thread_flag(task, TIF_SSBD);
+		break;
+	case PR_SPEC_FORCE_DISABLE:
+		if (state == ARM64_SSBD_FORCE_DISABLE)
+			return -EPERM;
+		task_set_spec_ssb_disable(task);
+		task_set_spec_ssb_force_disable(task);
+		set_tsk_thread_flag(task, TIF_SSBD);
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
+			     unsigned long ctrl)
+{
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssbd_prctl_set(task, ctrl);
+	default:
+		return -ENODEV;
+	}
+}
+
+static int ssbd_prctl_get(struct task_struct *task)
+{
+	switch (arm64_get_ssbd_state()) {
+	case ARM64_SSBD_UNKNOWN:
+		return -EINVAL;
+	case ARM64_SSBD_FORCE_ENABLE:
+		return PR_SPEC_DISABLE;
+	case ARM64_SSBD_KERNEL:
+		if (task_spec_ssb_force_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (task_spec_ssb_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	case ARM64_SSBD_FORCE_DISABLE:
+		return PR_SPEC_ENABLE;
+	default:
+		return PR_SPEC_NOT_AFFECTED;
+	}
+}
+
+int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
+{
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssbd_prctl_get(task);
+	default:
+		return -ENODEV;
+	}
+}
+#endif	/* PR_SPEC_STORE_BYPASS */


