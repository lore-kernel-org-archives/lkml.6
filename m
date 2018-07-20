Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FE0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE0F20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE0F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeGTWcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:32:11 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45316 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeGTWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:32:10 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so11560168qti.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 14:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4PUUJocIy0Vhik03VpXajy+Ofvct1wGW0RWAFDSneeU=;
        b=dc6oY1LaoUktwz1ZHG0GAOLqTGWzrBGDcIVetLQJbn+hkr2YML2KLNbSddWZhST46V
         FWFDv/5gjiYnuNsG8quupbQ/5BJV/9J9YOMktYHK+3WfrKi9VJpq5qWIpjLIBj/BWlN7
         0DCbu++5PQxP3rVWX8hTWB+nOH28U3AYuRj9NNO9ZttR6NXi+l84DTRypw6tvIypTIE2
         PYj2xFcoeDekMw/0yrrwh9RJTRPI8RUSgwT7ZKz12RRScySVaSi9jo1VFIN3hFjWGuK/
         SbU8ydnO+TZS05WCoUU9wE4fBmQAePivkF+ZhTFUCIJTdBVXob+O+73Yn73/n5TWmVuO
         1+cA==
X-Gm-Message-State: AOUpUlGs+SdHyxzCqS/L6hdWyRRgXEV6dmwfO9rPnmBdOqlY4zTmCzpX
        GXVohYhwy1yD+Fx4leWpMEn5WA==
X-Google-Smtp-Source: AAOMgpcyRjHlX4G8ZcdhsAPmPol/NJgYFoFi4QOB0gUUni0YAu0BEozhINyKxKFXmGjLLMLLCPasQQ==
X-Received: by 2002:ac8:1881:: with SMTP id s1-v6mr3454123qtj.401.1532122922269;
        Fri, 20 Jul 2018 14:42:02 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id r4-v6sm1617385qtm.10.2018.07.20.14.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 14:42:01 -0700 (PDT)
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
Subject: [PATCHv3 1/2] arm64: Add stack information to on_accessible_stack
Date:   Fri, 20 Jul 2018 14:41:53 -0700
Message-Id: <20180720214154.2940-2-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720214154.2940-1-labbott@redhat.com>
References: <20180720214154.2940-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In preparation for enabling the stackleak plugin on arm64,
we need a way to get the bounds of the current stack. Extend
on_accessible_stack to get this information.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Switched some logic to reduce if nesting
---
 arch/arm64/include/asm/sdei.h       |  9 ++--
 arch/arm64/include/asm/stacktrace.h | 73 ++++++++++++++++++++++++-----
 arch/arm64/kernel/ptrace.c          |  2 +-
 arch/arm64/kernel/sdei.c            | 51 ++++++++++++++++----
 arch/arm64/kernel/stacktrace.c      |  2 +-
 5 files changed, 112 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index e073e6886685..ffe47d766c25 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -40,15 +40,18 @@ asmlinkage unsigned long __sdei_handler(struct pt_regs *regs,
 unsigned long sdei_arch_get_entry_point(int conduit);
 #define sdei_arch_get_entry_point(x)	sdei_arch_get_entry_point(x)
 
-bool _on_sdei_stack(unsigned long sp);
-static inline bool on_sdei_stack(unsigned long sp)
+struct stack_info;
+
+bool _on_sdei_stack(unsigned long sp, struct stack_info *info);
+static inline bool on_sdei_stack(unsigned long sp,
+				struct stack_info *info)
 {
 	if (!IS_ENABLED(CONFIG_VMAP_STACK))
 		return false;
 	if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
 		return false;
 	if (in_nmi())
-		return _on_sdei_stack(sp);
+		return _on_sdei_stack(sp, info);
 
 	return false;
 }
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 902f9edacbea..e86737b7c924 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -32,6 +32,21 @@ struct stackframe {
 #endif
 };
 
+enum stack_type {
+	STACK_TYPE_UNKNOWN,
+	STACK_TYPE_TASK,
+	STACK_TYPE_IRQ,
+	STACK_TYPE_OVERFLOW,
+	STACK_TYPE_SDEI_NORMAL,
+	STACK_TYPE_SDEI_CRITICAL,
+};
+
+struct stack_info {
+	unsigned long low;
+	unsigned long high;
+	enum stack_type type;
+};
+
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
 extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
@@ -39,7 +54,8 @@ extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk);
 
 DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
 
-static inline bool on_irq_stack(unsigned long sp)
+static inline bool on_irq_stack(unsigned long sp,
+				struct stack_info *info)
 {
 	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
 	unsigned long high = low + IRQ_STACK_SIZE;
@@ -47,46 +63,79 @@ static inline bool on_irq_stack(unsigned long sp)
 	if (!low)
 		return false;
 
-	return (low <= sp && sp < high);
+	if (sp < low || sp >= high)
+		return false;
+
+	if (info) {
+		info->low = low;
+		info->high = high;
+		info->type = STACK_TYPE_IRQ;
+	}
+
+	return true;
 }
 
-static inline bool on_task_stack(struct task_struct *tsk, unsigned long sp)
+static inline bool on_task_stack(struct task_struct *tsk, unsigned long sp,
+				struct stack_info *info)
 {
 	unsigned long low = (unsigned long)task_stack_page(tsk);
 	unsigned long high = low + THREAD_SIZE;
 
-	return (low <= sp && sp < high);
+	if (sp < low || sp >= high)
+		return false;
+
+	if (info) {
+		info->low = low;
+		info->high = high;
+		info->type = STACK_TYPE_TASK;
+	}
+
+	return true;
 }
 
 #ifdef CONFIG_VMAP_STACK
 DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
 
-static inline bool on_overflow_stack(unsigned long sp)
+static inline bool on_overflow_stack(unsigned long sp,
+				struct stack_info *info)
 {
 	unsigned long low = (unsigned long)raw_cpu_ptr(overflow_stack);
 	unsigned long high = low + OVERFLOW_STACK_SIZE;
 
-	return (low <= sp && sp < high);
+	if (sp < low || sp >= high)
+		return false;
+
+	if (info) {
+		info->low = low;
+		info->high = high;
+		info->type = STACK_TYPE_OVERFLOW;
+	}
+
+	return true;
 }
 #else
-static inline bool on_overflow_stack(unsigned long sp) { return false; }
+static inline bool on_overflow_stack(unsigned long sp,
+			struct stack_info *info) { return false; }
 #endif
 
+
 /*
  * We can only safely access per-cpu stacks from current in a non-preemptible
  * context.
  */
-static inline bool on_accessible_stack(struct task_struct *tsk, unsigned long sp)
+static inline bool on_accessible_stack(struct task_struct *tsk,
+					unsigned long sp,
+					struct stack_info *info)
 {
-	if (on_task_stack(tsk, sp))
+	if (on_task_stack(tsk, sp, info))
 		return true;
 	if (tsk != current || preemptible())
 		return false;
-	if (on_irq_stack(sp))
+	if (on_irq_stack(sp, info))
 		return true;
-	if (on_overflow_stack(sp))
+	if (on_overflow_stack(sp, info))
 		return true;
-	if (on_sdei_stack(sp))
+	if (on_sdei_stack(sp, info))
 		return true;
 
 	return false;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5c338ce5a7fa..cf94e1498ba6 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -132,7 +132,7 @@ static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
 {
 	return ((addr & ~(THREAD_SIZE - 1))  ==
 		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1))) ||
-		on_irq_stack(addr);
+		on_irq_stack(addr, NULL);
 }
 
 /**
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 6b8d90d5ceae..7154fee1cb2b 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -88,23 +88,58 @@ static int init_sdei_stacks(void)
 	return err;
 }
 
-bool _on_sdei_stack(unsigned long sp)
+bool on_sdei_normal_stack(unsigned long sp,
+			struct stack_info *info)
+{
+	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
+	unsigned long high = low + SDEI_STACK_SIZE;
+
+	if (sp < low || sp >= high)
+		return false;
+
+	if (info) {
+		info->low = low;
+		info->high = high;
+		info->type = STACK_TYPE_SDEI_NORMAL;
+	}
+
+	return true;
+}
+
+bool on_sdei_critical_stack(unsigned long sp,
+			struct stack_info *info)
+{
+	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
+	unsigned long high = low + SDEI_STACK_SIZE;
+
+	if (sp < low || sp >= high)
+		return false;
+
+	if (info) {
+		info->low = low;
+		info->high = high;
+		info->type = STACK_TYPE_SDEI_CRITICAL;
+	}
+
+	return true;
+}
+
+bool _on_sdei_stack(unsigned long sp,
+		unsigned long *stack_low,
+		unsigned long *stack_high)
 {
 	unsigned long low, high;
 
 	if (!IS_ENABLED(CONFIG_VMAP_STACK))
 		return false;
 
-	low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
-	high = low + SDEI_STACK_SIZE;
-
-	if (low <= sp && sp < high)
+	if (on_sdei_critical_stack(sp, info))
 		return true;
 
-	low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
-	high = low + SDEI_STACK_SIZE;
+	if (on_sdei_normal_stack(sp, info))
+		return true;
 
-	return (low <= sp && sp < high);
+	return false;
 }
 
 unsigned long sdei_arch_get_entry_point(int conduit)
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d5718a060672..4989f7ea1e59 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -50,7 +50,7 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	if (!tsk)
 		tsk = current;
 
-	if (!on_accessible_stack(tsk, fp))
+	if (!on_accessible_stack(tsk, fp, NULL))
 		return -EINVAL;
 
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
-- 
2.17.1

