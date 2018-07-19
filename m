Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AB7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A082020673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A082020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbeGTANj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:13:39 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32781 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbeGTANi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:13:38 -0400
Received: by mail-qk0-f195.google.com with SMTP id 27-v6so5301839qkv.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 16:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fBabB29QkCUWDmAYSjnnQuwE5ckz2qn5sPmx5AWbtm4=;
        b=J74Gc8eJWSXpCFFo7oCQEIfFOLLONMzDzI0HL87MVnpLVxWESF9sHmZrBNdq5nWcbK
         yMn7/HUyD0VM9oRU4PbuBAVElqKP9NQnbGfBTmDZFgwIxYFtY16a87qjHNFeMfqXJC0n
         6qWGi5BsKOyJPjFdtxRm4NLazb0JWlTY4aWKsplgrl8zVBufkC1hpHb1MPt7kW4frOBM
         KIhQTaWQ3xJ9qFoeGOJZ+Q7lXyxByxspgLS1G28cMR/LMaEXktAE4Fkyhjdg9D2H81pO
         PZLMaZ615U5PErUShag0HEwSleDGPB7JDUqcpZ2j5K/LyeQzdO3GA11OJ/l08vf01vkQ
         0eFQ==
X-Gm-Message-State: AOUpUlH0whdDGwd1m/6wvGLJ22Mv0HRTp9EaHTZb4Xmk/FjMH99d6Hpj
        hrnJZvraw4IB7t3x1GLAYuFBIQ==
X-Google-Smtp-Source: AAOMgpdxa/BwXlDIumg3TZKP5MNGclW7kVZDJqUwH9GnT2MC+ZS9CNzuybuiiPsMliXd4zKEuO/Xtg==
X-Received: by 2002:a37:1999:: with SMTP id 25-v6mr10825309qkz.405.1532042895544;
        Thu, 19 Jul 2018 16:28:15 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id f70-v6sm258205qke.77.2018.07.19.16.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 16:28:14 -0700 (PDT)
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
Subject: [PATCHv2 1/2] arm64: Add stack information to on_accessible_stack
Date:   Thu, 19 Jul 2018 16:28:05 -0700
Message-Id: <20180719232806.3397-2-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719232806.3397-1-labbott@redhat.com>
References: <20180719232806.3397-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In preparation for enabling the stackleak plugin on arm64,
we need a way to get the bounds of the current stack. Extend
on_accessible_stack to get this information.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Switched to using struct stack_info for argument passing.
on_accessible_stack is now the primary API. Split STACK_TYPE_SDEI
into STACK_TYPE_SDEI_NORMAL and STACK_TYPE_SDEI_CRITICAL.
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
index 6b8d90d5ceae..f0787610f82e 100644
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
+	if (low <= sp && sp < high) {
+		if (info) {
+			info->low = low;
+			info->high = high;
+			info->type = STACK_TYPE_SDEI_NORMAL;
+		}
+		return true;
+	}
+
+	return false;
+}
+
+bool on_sdei_critical_stack(unsigned long sp,
+			struct stack_info *info)
+{
+	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
+	unsigned long high = low + SDEI_STACK_SIZE;
+
+	if (low <= sp && sp < high) {
+		if (info) {
+			info->low = low;
+			info->high = high;
+			info->type = STACK_TYPE_SDEI_CRITICAL;
+		}
+		return true;
+	}
+
+	return false;
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

