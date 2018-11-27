Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8347CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3F120873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3F120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeK1Gnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:43:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46952 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbeK1Gnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:43:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 351E336BA;
        Tue, 27 Nov 2018 11:44:45 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 055C73F777;
        Tue, 27 Nov 2018 11:44:45 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D5DC11AE0B68; Tue, 27 Nov 2018 19:45:02 +0000 (GMT)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, rml@tech9.net, tglx@linutronix.de,
        peterz@infradead.org, schwidefsky@de.ibm.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/2] arm64: preempt: Provide our own implementation of asm/preempt.h
Date:   Tue, 27 Nov 2018 19:45:02 +0000
Message-Id: <1543347902-21170-3-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
References: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm-generic/preempt.h implementation doesn't make use of the
PREEMPT_NEED_RESCHED flag, since this can interact badly with load/store
architectures which rely on the preempt_count word being unchanged across
an interrupt.

However, since we're a 64-bit architecture and the preempt count is
only 32 bits wide, we can simply pack it next to the resched flag and
load the whole thing in one go, so that a dec-and-test operation doesn't
need to load twice.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/preempt.h     | 78 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/thread_info.h | 13 +++++-
 3 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/preempt.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 6cd5d77b6b44..33498f900390 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -14,7 +14,6 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += msi.h
-generic-y += preempt.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += rwsem.h
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
new file mode 100644
index 000000000000..832227d5ebc0
--- /dev/null
+++ b/arch/arm64/include/asm/preempt.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_PREEMPT_H
+#define __ASM_PREEMPT_H
+
+#include <linux/thread_info.h>
+
+#define PREEMPT_NEED_RESCHED	BIT(32)
+#define PREEMPT_ENABLED	(PREEMPT_NEED_RESCHED)
+
+static inline int preempt_count(void)
+{
+	return READ_ONCE(current_thread_info()->preempt.count);
+}
+
+static inline void preempt_count_set(u64 pc)
+{
+	/* Preserve existing value of PREEMPT_NEED_RESCHED */
+	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+}
+
+#define init_task_preempt_count(p) do { \
+	task_thread_info(p)->preempt_count = FORK_PREEMPT_COUNT; \
+} while (0)
+
+#define init_idle_preempt_count(p, cpu) do { \
+	task_thread_info(p)->preempt_count = PREEMPT_ENABLED; \
+} while (0)
+
+static inline void set_preempt_need_resched(void)
+{
+	current_thread_info()->preempt.need_resched = 0;
+}
+
+static inline void clear_preempt_need_resched(void)
+{
+	current_thread_info()->preempt.need_resched = 1;
+}
+
+static inline bool test_preempt_need_resched(void)
+{
+	return !current_thread_info()->preempt.need_resched;
+}
+
+static inline void __preempt_count_add(int val)
+{
+	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
+	pc += val;
+	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+}
+
+static inline void __preempt_count_sub(int val)
+{
+	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
+	pc -= val;
+	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+}
+
+static inline bool __preempt_count_dec_and_test(void)
+{
+	u64 pc = READ_ONCE(current_thread_info()->preempt_count);
+	WRITE_ONCE(current_thread_info()->preempt.count, --pc);
+	return !pc;
+}
+
+static inline bool should_resched(int preempt_offset)
+{
+	u64 pc = READ_ONCE(current_thread_info()->preempt_count);
+	return pc == preempt_offset;
+}
+
+#ifdef CONFIG_PREEMPT
+void preempt_schedule(void);
+#define __preempt_schedule() preempt_schedule()
+void preempt_schedule_notrace(void);
+#define __preempt_schedule_notrace() preempt_schedule_notrace()
+#endif /* CONFIG_PREEMPT */
+
+#endif /* __ASM_PREEMPT_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index cb2c10a8f0a8..bbca68b54732 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -42,7 +42,18 @@ struct thread_info {
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	u64			ttbr0;		/* saved TTBR0_EL1 */
 #endif
-	int			preempt_count;	/* 0 => preemptable, <0 => bug */
+	union {
+		u64		preempt_count;	/* 0 => preemptible, <0 => bug */
+		struct {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+			u32	need_resched;
+			u32	count;
+#else
+			u32	count;
+			u32	need_resched;
+#endif
+		} preempt;
+	};
 };
 
 #define thread_saved_pc(tsk)	\
-- 
2.1.4

