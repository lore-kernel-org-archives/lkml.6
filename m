Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeENJrk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:47:40 -0400
Received: from foss.arm.com ([217.140.101.70]:38254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeENJrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:47:37 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: [PATCH 06/18] arm64: move sve_user_{enable,disable} to <asm/fpsimd.h>
Date: Mon, 14 May 2018 10:46:28 +0100
Message-Id: <20180514094640.27569-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In subsequent patches, we'll want to make use of sve_user_enable() and
sve_user_disable() outside of kernel/fpsimd.c. Let's move these to
<asm/fpsimd.h> where we can make use of them.

To avoid ifdeffery in sequences like:

if (system_supports_sve() && some_condition
	sve_user_disable();

... empty stubs are provided when support for SVE is not enabled.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fpsimd.h | 17 ++++++++++++++++-
 arch/arm64/kernel/fpsimd.c      | 11 -----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index aa7162ae93e3..7377d7593c06 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -16,11 +16,13 @@
 #ifndef __ASM_FP_H
 #define __ASM_FP_H
 
-#include <asm/ptrace.h>
 #include <asm/errno.h>
+#include <asm/ptrace.h>
+#include <asm/sysreg.h>
 
 #ifndef __ASSEMBLY__
 
+#include <linux/build_bug.h>
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/stddef.h>
@@ -81,6 +83,16 @@ extern int sve_set_vector_length(struct task_struct *task,
 extern int sve_set_current_vl(unsigned long arg);
 extern int sve_get_current_vl(void);
 
+static inline void sve_user_disable(void)
+{
+	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
+}
+
+static inline void sve_user_enable(void)
+{
+	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
+}
+
 /*
  * Probing and setup functions.
  * Calls to these functions must be serialised with one another.
@@ -107,6 +119,9 @@ static inline int sve_get_current_vl(void)
 	return -EINVAL;
 }
 
+static inline void sve_user_disable(void) { }
+static inline void sve_user_enable(void) { }
+
 static inline void sve_init_vq_map(void) { }
 static inline void sve_update_vq_map(void) { }
 static inline int sve_verify_vq_map(void) { return 0; }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 088940387a4d..79a81c7d85c6 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -159,7 +159,6 @@ static void sve_free(struct task_struct *task)
 	__sve_free(task);
 }
 
-
 /* Offset of FFR in the SVE register dump */
 static size_t sve_ffr_offset(int vl)
 {
@@ -172,16 +171,6 @@ static void *sve_pffr(struct task_struct *task)
 		sve_ffr_offset(task->thread.sve_vl);
 }
 
-static void sve_user_disable(void)
-{
-	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
-}
-
-static void sve_user_enable(void)
-{
-	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
-}
-
 /*
  * TIF_SVE controls whether a task can use SVE without trapping while
  * in userspace, and also the way a task's FPSIMD/SVE state is stored
-- 
2.11.0
