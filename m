Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeFAL3f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:29:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50300 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeFALZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:02 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Martin <dave.martin@arm.com>
Subject: [PATCHv2 06/19] arm64: move sve_user_{enable,disable} to <asm/fpsimd.h>
Date: Fri,  1 Jun 2018 12:24:28 +0100
Message-Id: <20180601112441.37810-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In subsequent patches, we'll want to make use of sve_user_enable() and
sve_user_disable() outside of kernel/fpsimd.c. Let's move these to
<asm/fpsimd.h> where we can make use of them.

To avoid ifdeffery in sequences like:

if (system_supports_sve() && some_condition
	sve_user_disable();

... empty stubs are provided when support for SVE is not enabled. Note
that system_supports_sve() contains as IS_ENABLED(CONFIG_ARM64_SVE), so
the sve_user_disable() call should be optimized away entirely when
CONFIG_ARM64_SVE is not selected.

To ensure that this is the case, the stub definitions contain a
BUILD_BUG(), as we do for other stubs for which calls should always be
optimized away when the relevant config option is not selected.

At the same time, the include list of <asm/fpsimd.h> is sorted while
adding <asm/sysreg.h>.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fpsimd.h | 17 ++++++++++++++++-
 arch/arm64/kernel/fpsimd.c      | 10 ----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index aa7162ae93e3..c9acc6ad9b75 100644
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
 
+static inline void sve_user_disable(void) { BUILD_BUG(); }
+static inline void sve_user_enable(void) { BUILD_BUG(); }
+
 static inline void sve_init_vq_map(void) { }
 static inline void sve_update_vq_map(void) { }
 static inline int sve_verify_vq_map(void) { return 0; }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index c135cff8f882..86f2eef428e0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -171,16 +171,6 @@ static void *sve_pffr(struct task_struct *task)
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
