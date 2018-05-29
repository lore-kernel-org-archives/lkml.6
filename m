Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933665AbeE2MT0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:19:26 -0400
Received: from foss.arm.com ([217.140.101.70]:38394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933635AbeE2MLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:11:36 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Julien Grall <julien.grall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 02/17] arm64: Call ARCH_WORKAROUND_2 on transitions between EL0 and EL1
Date: Tue, 29 May 2018 13:11:06 +0100
Message-Id: <20180529121121.24927-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180529121121.24927-1-marc.zyngier@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the kernel to protect itself, let's call the SSBD mitigation
implemented by the higher exception level (either hypervisor or firmware)
on each transition between userspace and kernel.

We must take the PSCI conduit into account in order to target the
right exception level, hence the introduction of a runtime patching
callback.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/entry.S      | 22 ++++++++++++++++++++++
 include/linux/arm-smccc.h      |  5 +++++
 3 files changed, 51 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index e4a1182deff7..d98d8ce29533 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -232,6 +232,30 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
+#ifdef CONFIG_ARM64_SSBD
+void __init arm64_update_smccc_conduit(struct alt_instr *alt,
+				       __le32 *origptr, __le32 *updptr,
+				       int nr_inst)
+{
+	u32 insn;
+
+	BUG_ON(nr_inst != 1);
+
+	switch (psci_ops.conduit) {
+	case PSCI_CONDUIT_HVC:
+		insn = aarch64_insn_get_hvc_value();
+		break;
+	case PSCI_CONDUIT_SMC:
+		insn = aarch64_insn_get_smc_value();
+		break;
+	default:
+		return;
+	}
+
+	*updptr = cpu_to_le32(insn);
+}
+#endif	/* CONFIG_ARM64_SSBD */
+
 #define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
 	.matches = is_affected_midr_range,			\
 	.midr_range = MIDR_RANGE(model, v_min, r_min, v_max, r_max)
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ec2ee720e33e..f33e6aed3037 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -18,6 +18,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
 
@@ -137,6 +138,18 @@ alternative_else_nop_endif
 	add	\dst, \dst, #(\sym - .entry.tramp.text)
 	.endm
 
+	// This macro corrupts x0-x3. It is the caller's duty
+	// to save/restore them if required.
+	.macro	apply_ssbd, state
+#ifdef CONFIG_ARM64_SSBD
+	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2
+	mov	w1, #\state
+alternative_cb	arm64_update_smccc_conduit
+	nop					// Patched to SMC/HVC #0
+alternative_cb_end
+#endif
+	.endm
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
@@ -163,6 +176,13 @@ alternative_else_nop_endif
 	ldr	x19, [tsk, #TSK_TI_FLAGS]	// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 
+	apply_ssbd 1
+
+#ifdef CONFIG_ARM64_SSBD
+	ldp	x0, x1, [sp, #16 * 0]
+	ldp	x2, x3, [sp, #16 * 1]
+#endif
+
 	mov	x29, xzr			// fp pointed to user-space
 	.else
 	add	x21, sp, #S_FRAME_SIZE
@@ -303,6 +323,8 @@ alternative_if ARM64_WORKAROUND_845719
 alternative_else_nop_endif
 #endif
 3:
+	apply_ssbd 0
+
 	.endif
 
 	msr	elr_el1, x21			// set up the return data
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index c89da86de99f..ca1d2cc2cdfa 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -80,6 +80,11 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 0x8000)
 
+#define ARM_SMCCC_ARCH_WORKAROUND_2					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 0x7fff)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
-- 
2.14.2
