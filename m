Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7525ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AA62075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AA62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbeGRVuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:50:09 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:45598 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeGRVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:50:08 -0400
Received: by mail-qt0-f172.google.com with SMTP id y5-v6so5380351qti.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g/OX3VgJjdgzO7seeCrbMw7ezGcq5eUy3GHwluEcB5c=;
        b=P2yo6EZ6D33XojjIkesu0jirRnzTGteJRZKLr0ZIuyjmsVsy41fWfuLJOW7E5XKQz8
         7lCeKOJEObn9VXp7KyH+1XaNtusl2xpt6Q6GhXVNqL6G5e22fKAkylH7WajsRICKFWi8
         +Nvv/pRcKTOI2mAh+RmV1zQK2V34RLNTpC4H+tyRYrvl0IDn++Ui33qFlTkXsm5B3OaD
         Ck+RFyZQIsty/KlAg+XgBVHloAeXqUuWQukPYIyB/XqcLWudEi0EnYRfM/H/zCizciBO
         e/Xmno2JBC1Bs0dwMW/xK0XoyftTbZ8msNiVFv+8l6wnmPD7GpvGusQJWgLX8dhKNRuo
         fIMQ==
X-Gm-Message-State: AOUpUlF7Hi4jtyyG1TJ5l856QaTmu4FMRPO0OOE/zyENSEARgJ3mkjAC
        6+96fqLnruZU4c2ccZ+9DUTUkQ==
X-Google-Smtp-Source: AAOMgpdIv0PZhCXXELQUtUh0J1jgiVgnoxQ/gLwR7BU6QL06DkD8U6X4M2+n+cTqTqDApdoqs9xezg==
X-Received: by 2002:ac8:2cd1:: with SMTP id 17-v6mr7269393qtx.360.1531948225423;
        Wed, 18 Jul 2018 14:10:25 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id k3-v6sm4143463qta.37.2018.07.18.14.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 14:10:24 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 1/2] arm64: Introduce current_stack_type
Date:   Wed, 18 Jul 2018 14:10:12 -0700
Message-Id: <20180718211013.14512-2-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718211013.14512-1-labbott@redhat.com>
References: <20180718211013.14512-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In preparation for enabling the stackleak plugin on arm64,
we need a way to get the bounds of the current stack.
Introduce a new primitive current_stack_type which is similar
to x86's get_stack_info. Utilize that to rework
on_accessible_stack slightly as well.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
So this did end up looking quite a bit like get_stack_info but I didn't
really see the need to integrate this more than this. I do think
actually enumerating the types makes things a bit cleaner.
---
 arch/arm64/include/asm/sdei.h       |  8 ++-
 arch/arm64/include/asm/stacktrace.h | 94 ++++++++++++++++++++++++-----
 arch/arm64/kernel/ptrace.c          |  2 +-
 arch/arm64/kernel/sdei.c            | 21 ++++++-
 4 files changed, 103 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index e073e6886685..34f7b203845b 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -40,15 +40,17 @@ asmlinkage unsigned long __sdei_handler(struct pt_regs *regs,
 unsigned long sdei_arch_get_entry_point(int conduit);
 #define sdei_arch_get_entry_point(x)	sdei_arch_get_entry_point(x)
 
-bool _on_sdei_stack(unsigned long sp);
-static inline bool on_sdei_stack(unsigned long sp)
+bool _on_sdei_stack(unsigned long sp, unsigned long *, unsigned long *);
+static inline bool on_sdei_stack(unsigned long sp,
+				unsigned long *stack_low,
+				unsigned long *stack_high)
 {
 	if (!IS_ENABLED(CONFIG_VMAP_STACK))
 		return false;
 	if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
 		return false;
 	if (in_nmi())
-		return _on_sdei_stack(sp);
+		return _on_sdei_stack(sp, stack_low, stack_high);
 
 	return false;
 }
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 902f9edacbea..9855a0425e64 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -39,7 +39,9 @@ extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk);
 
 DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
 
-static inline bool on_irq_stack(unsigned long sp)
+static inline bool on_irq_stack(unsigned long sp,
+				unsigned long *stack_low,
+				unsigned long *stack_high)
 {
 	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
 	unsigned long high = low + IRQ_STACK_SIZE;
@@ -47,47 +49,109 @@ static inline bool on_irq_stack(unsigned long sp)
 	if (!low)
 		return false;
 
-	return (low <= sp && sp < high);
+	if (sp < low || sp >= high)
+		return false;
+
+	if (stack_low && stack_high) {
+		*stack_low = low;
+		*stack_high = high;
+	}
+
+	return true;
 }
 
-static inline bool on_task_stack(struct task_struct *tsk, unsigned long sp)
+static inline bool on_task_stack(struct task_struct *tsk, unsigned long sp,
+				unsigned long *stack_low,
+				unsigned long *stack_high)
 {
 	unsigned long low = (unsigned long)task_stack_page(tsk);
 	unsigned long high = low + THREAD_SIZE;
 
-	return (low <= sp && sp < high);
+	if (sp < low || sp >= high)
+		return false;
+
+	if (stack_low && stack_high) {
+		*stack_low = low;
+		*stack_high = high;
+	}
+
+	return true;
 }
 
 #ifdef CONFIG_VMAP_STACK
 DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
 
-static inline bool on_overflow_stack(unsigned long sp)
+static inline bool on_overflow_stack(unsigned long sp,
+				unsigned long *stack_low,
+				unsigned long *stack_high)
 {
 	unsigned long low = (unsigned long)raw_cpu_ptr(overflow_stack);
 	unsigned long high = low + OVERFLOW_STACK_SIZE;
 
-	return (low <= sp && sp < high);
+	if (sp < low || sp >= high)
+		return false;
+
+	if (stack_low && stack_high) {
+		*stack_low = low;
+		*stack_high = high;
+	}
+
+	return true;
 }
 #else
-static inline bool on_overflow_stack(unsigned long sp) { return false; }
+static inline bool on_overflow_stack(unsigned long sp,
+			unsigned long *stack_low,
+			unsigned long *stack_high) { return false; }
 #endif
 
+enum stack_type {
+	STACK_TYPE_UNKNOWN,
+	STACK_TYPE_TASK,
+	STACK_TYPE_IRQ,
+	STACK_TYPE_OVERFLOW,
+	STACK_TYPE_SDEI,
+};
+
+static inline enum stack_type current_stack_type(struct task_struct *tsk,
+						unsigned long sp,
+						unsigned long *stack_low,
+						unsigned long *stack_high)
+{
+	if (on_task_stack(tsk, sp, stack_low, stack_high))
+		return STACK_TYPE_TASK;
+	if (on_irq_stack(sp, stack_low, stack_high))
+		return STACK_TYPE_IRQ;
+	if (on_overflow_stack(sp, stack_low, stack_high))
+		return STACK_TYPE_OVERFLOW;
+	if (on_sdei_stack(sp, stack_low, stack_high))
+		return STACK_TYPE_SDEI;
+	return STACK_TYPE_UNKNOWN;
+}
+
 /*
  * We can only safely access per-cpu stacks from current in a non-preemptible
  * context.
  */
 static inline bool on_accessible_stack(struct task_struct *tsk, unsigned long sp)
 {
-	if (on_task_stack(tsk, sp))
+	enum stack_type type;
+	unsigned long low, high;
+
+	type = current_stack_type(tsk, sp, &low, &high);
+
+	switch (type) {
+	case STACK_TYPE_TASK:
 		return true;
-	if (tsk != current || preemptible())
+	case STACK_TYPE_IRQ:
+	case STACK_TYPE_OVERFLOW:
+	case STACK_TYPE_SDEI:
+		if (tsk != current || preemptible())
+			return false;
+		else
+			return true;
+	case STACK_TYPE_UNKNOWN:
 		return false;
-	if (on_irq_stack(sp))
-		return true;
-	if (on_overflow_stack(sp))
-		return true;
-	if (on_sdei_stack(sp))
-		return true;
+	}
 
 	return false;
 }
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5c338ce5a7fa..a6b3a2be7561 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -132,7 +132,7 @@ static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
 {
 	return ((addr & ~(THREAD_SIZE - 1))  ==
 		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1))) ||
-		on_irq_stack(addr);
+		on_irq_stack(addr, NULL, NULL);
 }
 
 /**
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 6b8d90d5ceae..8e18913a53fd 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -88,7 +88,9 @@ static int init_sdei_stacks(void)
 	return err;
 }
 
-bool _on_sdei_stack(unsigned long sp)
+bool _on_sdei_stack(unsigned long sp,
+		unsigned long *stack_low,
+		unsigned long *stack_high)
 {
 	unsigned long low, high;
 
@@ -98,13 +100,26 @@ bool _on_sdei_stack(unsigned long sp)
 	low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
 	high = low + SDEI_STACK_SIZE;
 
-	if (low <= sp && sp < high)
+	if (low <= sp && sp < high) {
+		if (stack_low && stack_high) {
+			*stack_low = low;
+			*stack_high = high;
+		}
 		return true;
+	}
 
 	low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
 	high = low + SDEI_STACK_SIZE;
 
-	return (low <= sp && sp < high);
+	if (low <= sp && sp < high) {
+		if (stack_low && stack_high) {
+			*stack_low = low;
+			*stack_high = high;
+		}
+		return true;
+	}
+
+	return false;
 }
 
 unsigned long sdei_arch_get_entry_point(int conduit)
-- 
2.17.1

