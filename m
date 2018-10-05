Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E450C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0928F208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0928F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeJEPsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:48:31 -0400
Received: from foss.arm.com ([217.140.101.70]:48042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbeJEPsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:48:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 881E21650;
        Fri,  5 Oct 2018 01:50:46 -0700 (PDT)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52E713F5B3;
        Fri,  5 Oct 2018 01:50:43 -0700 (PDT)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 14/17] arm64: unwind: strip PAC from kernel addresses
Date:   Fri,  5 Oct 2018 09:47:51 +0100
Message-Id: <20181005084754.20950-15-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

When we enable pointer authentication in the kernel, LR values saved to
the stack will have a PAC which we must strip in order to retrieve the
real return address.

Strip PACs when unwinding the stack in order to account for this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/pointer_auth.h | 10 +++++++---
 arch/arm64/kernel/ptrace.c            |  2 +-
 arch/arm64/kernel/stacktrace.c        |  3 +++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 5e40533f4ea2..e60f225d9fa2 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -55,12 +55,16 @@ static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
  * The EL0 pointer bits used by a pointer authentication code.
  * This is dependent on TBI0 being enabled, or bits 63:56 would also apply.
  */
-#define ptrauth_pac_mask() 	GENMASK(54, VA_BITS)
+#define ptrauth_pac_mask_ttbr0()	GENMASK(54, VA_BITS)
+
+#define ptrauth_pac_mask_ttbr1()	(GENMASK(63, 56) | GENMASK(54, VA_BITS))
 
-/* Only valid for EL0 TTBR0 instruction pointers */
 static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 {
-	return ptr & ~ptrauth_pac_mask();
+	if (ptr & BIT_ULL(55))
+		return ptr | ptrauth_pac_mask_ttbr1();
+	else
+		return ptr & ~ptrauth_pac_mask_ttbr0();
 }
 
 #define ptrauth_task_init_user(tsk)	\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index cb8246f8c603..bf4d6d384e4f 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -970,7 +970,7 @@ static int pac_mask_get(struct task_struct *target,
 	 * depending on TCR_EL1.TBID*, which we may make use of in future, so
 	 * we expose separate masks.
 	 */
-	unsigned long mask = ptrauth_pac_mask();
+	unsigned long mask = ptrauth_pac_mask_ttbr0();
 	struct user_pac_mask uregs = {
 		.data_mask = mask,
 		.insn_mask = mask,
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 4989f7ea1e59..44f6a64a8006 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -24,6 +24,7 @@
 #include <linux/stacktrace.h>
 
 #include <asm/irq.h>
+#include <asm/pointer_auth.h>
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
@@ -56,6 +57,8 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
 
+	frame->pc = ptrauth_strip_insn_pac(frame->pc);
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
 			(frame->pc == (unsigned long)return_to_handler)) {
-- 
2.11.0

