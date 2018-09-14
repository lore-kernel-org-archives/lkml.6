Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35279ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C371F21486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C371F21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeIOBvP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:51:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50763 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIOBvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:51:14 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g0unt-00088n-HE; Fri, 14 Sep 2018 22:35:01 +0200
Date:   Fri, 14 Sep 2018 22:35:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
Message-ID: <20180914203501.qibhpmueosvkr74w@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
 <20180912133353.20595-5-bigeasy@linutronix.de>
 <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While most of a task's FPU state is only needed in user space,
the protection keys need to be in place immediately after a
context switch.

The reason is that any accesses to userspace memory while running
in kernel mode also need to abide by the memory permissions
specified in the protection keys.

The pkru info is put in its own cache line in the fpu struct because
that cache line is accessed anyway at context switch time.
Remove XFEATURE_MASK_PKRU from supported flags. This removes the PKRU
state from XSAVE/XRESTORE and so decouples it from the FPU state.

The initial state of pkru is updated in pkru_set_init_value() via
fpu__clear() - it is no longer affected by fpstate_init().

Signed-off-by: Rik van Riel <riel@surriel.com>
[bigeasy: load PKRU state only if we also load FPU content]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

v1…v2: remove PKRU from xsave/srestore.

On 2018-09-12 16:18:44 [+0200], Paolo Bonzini wrote:

> I think you can go a step further and exclude PKRU state from
> copy_kernel_to_fpregs altogether; you just use RDPKRU/WRPKRU.  This also
> means you don't need to call __fpregs_* functions in write_pkru.

something like this then? It looks like kvm excludes PKRU from
xsave/xrestore, too. This wouldn't be required then. This is (again)
untested since I have no box with this PKRU feature. This only available
on Intel's Xeon Scalable, right?

> Thanks,
> 
> Paolo

 arch/x86/include/asm/fpu/internal.h | 14 ++++++++++++--
 arch/x86/include/asm/fpu/types.h    |  7 +++++++
 arch/x86/include/asm/fpu/xstate.h   |  1 -
 arch/x86/include/asm/pgtable.h      |  7 +++++--
 arch/x86/include/asm/pkeys.h        |  2 +-
 arch/x86/kernel/fpu/core.c          |  2 +-
 arch/x86/kernel/fpu/xstate.c        |  4 ----
 arch/x86/mm/pkeys.c                 | 21 ++++-----------------
 include/linux/pkeys.h               |  2 +-
 9 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 16c4077ffc945..903ee77b6d5b0 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -573,8 +573,18 @@ static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 	bool preload = static_cpu_has(X86_FEATURE_FPU) &&
 		       new_fpu->initialized;
 
-	if (preload)
-		__fpregs_load_activate(new_fpu, cpu);
+	if (!preload)
+		return;
+
+	__fpregs_load_activate(new_fpu, cpu);
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+	/* Protection keys need to be in place right at context switch time. */
+	if (boot_cpu_has(X86_FEATURE_OSPKE)) {
+		if (new_fpu->pkru != __read_pkru())
+			__write_pkru(new_fpu->pkru);
+	}
+#endif
 }
 
 /*
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 202c53918ecfa..257b092bdaa4e 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -293,6 +293,13 @@ struct fpu {
 	 */
 	unsigned int			last_cpu;
 
+	/*
+	 * Protection key bits. The protection key needs to be switched out
+	 * immediately at context switch time, so it is in place for things
+	 * like copy_to_user.
+	 */
+	unsigned int			pkru;
+
 	/*
 	 * @initialized:
 	 *
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 48581988d78c7..abe8793fa50f9 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -29,7 +29,6 @@
 				 XFEATURE_MASK_OPMASK | \
 				 XFEATURE_MASK_ZMM_Hi256 | \
 				 XFEATURE_MASK_Hi16_ZMM	 | \
-				 XFEATURE_MASK_PKRU | \
 				 XFEATURE_MASK_BNDREGS | \
 				 XFEATURE_MASK_BNDCSR)
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 690c0307afed0..d87bdfaf45e56 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -134,8 +134,11 @@ static inline u32 read_pkru(void)
 
 static inline void write_pkru(u32 pkru)
 {
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		__write_pkru(pkru);
+	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+		return;
+
+	current->thread.fpu.pkru = pkru;
+	__write_pkru(pkru);
 }
 
 static inline int pte_young(pte_t pte)
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 19b137f1b3beb..b184f916319e5 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -119,7 +119,7 @@ extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
-extern void copy_init_pkru_to_fpregs(void);
+extern void pkru_set_init_value(void);
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2ea85b32421a0..72cd2e2a07194 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -373,7 +373,7 @@ static inline void copy_init_fpstate_to_fpregs(void)
 		copy_kernel_to_fregs(&init_fpstate.fsave);
 
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		copy_init_pkru_to_fpregs();
+		pkru_set_init_value();
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 87a57b7642d36..11014d841b9f7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -920,10 +920,6 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	int pkey_shift = (pkey * PKRU_BITS_PER_PKEY);
 	u32 new_pkru_bits = 0;
 
-	/*
-	 * This check implies XSAVE support.  OSPKE only gets
-	 * set if we enable XSAVE and we enable PKU in XCR0.
-	 */
 	if (!boot_cpu_has(X86_FEATURE_OSPKE))
 		return -EINVAL;
 
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 6e98e0a7c9231..2f9d95206c741 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -137,26 +137,13 @@ u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
 		      PKRU_AD_KEY(10) | PKRU_AD_KEY(11) | PKRU_AD_KEY(12) |
 		      PKRU_AD_KEY(13) | PKRU_AD_KEY(14) | PKRU_AD_KEY(15);
 
-/*
- * Called from the FPU code when creating a fresh set of FPU
- * registers.  This is called from a very specific context where
- * we know the FPU regstiers are safe for use and we can use PKRU
- * directly.
- */
-void copy_init_pkru_to_fpregs(void)
+void pkru_set_init_value(void)
 {
 	u32 init_pkru_value_snapshot = READ_ONCE(init_pkru_value);
-	/*
-	 * Any write to PKRU takes it out of the XSAVE 'init
-	 * state' which increases context switch cost.  Avoid
-	 * writing 0 when PKRU was already 0.
-	 */
-	if (!init_pkru_value_snapshot && !read_pkru())
+
+	if (init_pkru_value_snapshot == read_pkru())
 		return;
-	/*
-	 * Override the PKRU state that came from 'init_fpstate'
-	 * with the baseline from the process.
-	 */
+
 	write_pkru(init_pkru_value_snapshot);
 }
 
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 2955ba9760489..9a9efecc1388f 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -44,7 +44,7 @@ static inline bool arch_pkeys_enabled(void)
 	return false;
 }
 
-static inline void copy_init_pkru_to_fpregs(void)
+static inline void pkru_set_init_value(void)
 {
 }
 
-- 
2.19.0

