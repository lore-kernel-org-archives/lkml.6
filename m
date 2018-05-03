Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeECNVH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:21:07 -0400
Received: from foss.arm.com ([217.140.101.70]:41664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbeECNVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:21:01 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        catalin.marinas@arm.com, christoffer.dall@arm.com, drjones@redhat.com,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        ramana.radhakrishnan@arm.com, suzuki.poulose@arm.com,
        will.deacon@arm.com, awallis@codeaurora.org
Subject: [PATCHv4 08/10] arm64: perf: strip PAC when unwinding userspace
Date: Thu,  3 May 2018 14:20:29 +0100
Message-Id: <20180503132031.25705-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180503132031.25705-1-mark.rutland@arm.com>
References: <20180503132031.25705-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is unwinding userspace callchains, we can't expect that
the userspace consumer of these callchains has the data necessary to
strip the PAC from the stored LR.

This patch has the kernel strip the PAC from user stackframes when the
in-kernel unwinder is used. This only affects the LR value, and not the
FP.

This only affects the in-kernel unwinder. When userspace performs
unwinding, it is up to userspace to strip PACs as necessary (which can
be determined from DWARF information).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pointer_auth.h | 7 +++++++
 arch/arm64/kernel/perf_callchain.c    | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 0263b87f95f7..284db173ae5d 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -65,6 +65,12 @@ static inline void ptrauth_keys_dup(struct ptrauth_keys *old,
  */
 #define ptrauth_pac_mask() 	GENMASK(54, VA_BITS)
 
+/* Only valid for EL0 TTBR0 instruction pointers */
+static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
+{
+	return ptr & ~ptrauth_pac_mask();
+}
+
 #define mm_ctx_ptrauth_init(ctx) \
 	ptrauth_keys_init(&(ctx)->ptrauth_keys)
 
@@ -75,6 +81,7 @@ static inline void ptrauth_keys_dup(struct ptrauth_keys *old,
 	ptrauth_keys_dup(&(oldctx)->ptrauth_keys, &(newctx)->ptrauth_keys)
 
 #else
+#define ptrauth_strip_insn_pac(lr)	(lr)
 #define mm_ctx_ptrauth_init(ctx)
 #define mm_ctx_ptrauth_switch(ctx)
 #define mm_ctx_ptrauth_dup(oldctx, newctx)
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index bcafd7dcfe8b..928204f6ab08 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -35,6 +35,7 @@ user_backtrace(struct frame_tail __user *tail,
 {
 	struct frame_tail buftail;
 	unsigned long err;
+	unsigned long lr;
 
 	/* Also check accessibility of one struct frame_tail beyond */
 	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
@@ -47,7 +48,9 @@ user_backtrace(struct frame_tail __user *tail,
 	if (err)
 		return NULL;
 
-	perf_callchain_store(entry, buftail.lr);
+	lr = ptrauth_strip_insn_pac(buftail.lr);
+
+	perf_callchain_store(entry, lr);
 
 	/*
 	 * Frame pointers should strictly progress back up the stack
-- 
2.11.0
