Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeBVJ4o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:56:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753076AbeBVJ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:56:43 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <james.morse@arm.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <christoffer.dall@linaro.org>,
        <marc.zyngier@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
CC: <gengdongjiu@huawei.com>, <huangshaoyu@huawei.com>
Subject: [PATCH] arm64: rename the function arm64_is_ras_serror() to avoid confusion
Date: Fri, 23 Feb 2018 02:02:32 +0800
Message-ID: <1519322552-7374-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RAS SError Syndrome can be Implementation-Defined,
arm64_is_ras_serror() is used to judge whether it is RAS SError,
but arm64_is_ras_serror() does not include this judgement. In order
to avoid function name confusion, we rename the arm64_is_ras_serror()
to arm64_is_categorized_ras_serror(), this function is used to
judge whether it is categorized RAS Serror.

Change some code notes, unrecoverable RAS errors is imprecise, but
Recoverable RAS errors is precise.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/include/asm/traps.h | 20 ++++++++------------
 arch/arm64/kernel/traps.c      |  9 +++++----
 arch/arm64/kvm/handle_exit.c   |  3 ++-
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 178e338..2a02b64 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -72,18 +72,23 @@ static inline int in_entry_text(unsigned long ptr)
  * CPUs with the RAS extensions have an Implementation-Defined-Syndrome bit
  * to indicate whether this ESR has a RAS encoding. CPUs without this feature
  * have a ISS-Valid bit in the same position.
- * If this bit is set, we know its not a RAS SError.
+ * If this bit is set, we know it is not a categorized RAS SError.
  * If its clear, we need to know if the CPU supports RAS. Uncategorized RAS
  * errors share the same encoding as an all-zeros encoding from a CPU that
  * doesn't support RAS.
  */
-static inline bool arm64_is_ras_serror(u32 esr)
+static inline bool arm64_is_categorized_ras_serror(u32 esr)
 {
 	WARN_ON(preemptible());
 
+	/* This is Implementation-Defined Syndrome */
 	if (esr & ESR_ELx_IDS)
 		return false;
 
+	if ((esr & ESR_ELx_FSC) != ESR_ELx_FSC_SERROR)
+		/* No severity information : Uncategorized */
+		return false;
+
 	if (this_cpu_has_cap(ARM64_HAS_RAS_EXTN))
 		return true;
 	else
@@ -101,20 +106,11 @@ static inline u32 arm64_ras_serror_get_severity(u32 esr)
 {
 	u32 aet = esr & ESR_ELx_AET;
 
-	if (!arm64_is_ras_serror(esr)) {
+	if (!arm64_is_categorized_ras_serror(esr)) {
 		/* Not a RAS error, we can't interpret the ESR. */
 		return ESR_ELx_AET_UC;
 	}
 
-	/*
-	 * AET is RES0 if 'the value returned in the DFSC field is not
-	 * [ESR_ELx_FSC_SERROR]'
-	 */
-	if ((esr & ESR_ELx_FSC) != ESR_ELx_FSC_SERROR) {
-		/* No severity information : Uncategorized */
-		return ESR_ELx_AET_UC;
-	}
-
 	return aet;
 }
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index bbb0fde..e88096a 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -689,12 +689,12 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
 		 * a more severe error.
 		 */
 		return false;
-
+	/* The exception has been imprecise */
 	case ESR_ELx_AET_UEU:	/* Uncorrected Unrecoverable */
+	/* The exception is precise */
 	case ESR_ELx_AET_UER:	/* Uncorrected Recoverable */
 		/*
-		 * The CPU can't make progress. The exception may have
-		 * been imprecise.
+		 * The CPU can't make progress.
 		 */
 		return true;
 
@@ -710,7 +710,8 @@ asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
 	nmi_enter();
 
 	/* non-RAS errors are not containable */
-	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
+	if (!arm64_is_categorized_ras_serror(esr) ||
+			arm64_is_fatal_ras_serror(regs, esr))
 		arm64_serror_panic(regs, esr);
 
 	nmi_exit();
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e5e741b..913c19e 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -40,7 +40,8 @@
 
 static void kvm_handle_guest_serror(struct kvm_vcpu *vcpu, u32 esr)
 {
-	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(NULL, esr))
+	if (!arm64_is_categorized_ras_serror(esr) ||
+			arm64_is_fatal_ras_serror(NULL, esr))
 		kvm_inject_vabt(vcpu);
 }
 
-- 
1.9.1
