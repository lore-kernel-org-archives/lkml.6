Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933866AbeE2MMI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:12:08 -0400
Received: from foss.arm.com ([217.140.101.70]:38576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933793AbeE2ML7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:11:59 -0400
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
Subject: [PATCH v2 11/17] arm64: KVM: Add HYP per-cpu accessors
Date: Tue, 29 May 2018 13:11:15 +0100
Message-Id: <20180529121121.24927-12-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180529121121.24927-1-marc.zyngier@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're going to require to access per-cpu variables at EL2,
let's craft the minimum set of accessors required to implement
reading a per-cpu variable, relying on tpidr_el2 to contain the
per-cpu offset.

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_asm.h | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index f6648a3e4152..fefd8cf42c35 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -71,14 +71,37 @@ extern u32 __kvm_get_mdcr_el2(void);
 
 extern u32 __init_stage2_translation(void);
 
+/* Home-grown __this_cpu_{ptr,read} variants that always work at HYP */
+#define __hyp_this_cpu_ptr(sym)						\
+	({								\
+		void *__ptr = hyp_symbol_addr(sym);			\
+		__ptr += read_sysreg(tpidr_el2);			\
+		(typeof(&sym))__ptr;					\
+	 })
+
+#define __hyp_this_cpu_read(sym)					\
+	({								\
+		*__hyp_this_cpu_ptr(sym);				\
+	 })
+
 #else /* __ASSEMBLY__ */
 
-.macro get_host_ctxt reg, tmp
-	adr_l	\reg, kvm_host_cpu_state
+.macro hyp_adr_this_cpu reg, sym, tmp
+	adr_l	\reg, \sym
 	mrs	\tmp, tpidr_el2
 	add	\reg, \reg, \tmp
 .endm
 
+.macro hyp_ldr_this_cpu reg, sym, tmp
+	adr_l	\reg, \sym
+	mrs	\tmp, tpidr_el2
+	ldr	\reg,  [\reg, \tmp]
+.endm
+
+.macro get_host_ctxt reg, tmp
+	hyp_adr_this_cpu \reg, kvm_host_cpu_state, \tmp
+.endm
+
 .macro get_vcpu_ptr vcpu, ctxt
 	get_host_ctxt \ctxt, \vcpu
 	ldr	\vcpu, [\ctxt, #HOST_CONTEXT_VCPU]
-- 
2.14.2
