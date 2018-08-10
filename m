Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94224C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A052240A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A052240A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeHJOWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:22:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:38772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727666AbeHJOWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:22:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B83CAECD;
        Fri, 10 Aug 2018 11:52:59 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 09/10] x86/paravirt: move the Xen-only pv_irq_ops under the PARAVIRT_XXL umbrella
Date:   Fri, 10 Aug 2018 13:52:51 +0200
Message-Id: <20180810115252.18213-10-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180810115252.18213-1-jgross@suse.com>
References: <20180810115252.18213-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the paravirt ops defined in pv_irq_ops are for Xen PV guests
only. Define them only if CONFIG_PARAVIRT_XXL is set.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/irqflags.h       | 38 ++++++++++++++++++-----------------
 arch/x86/include/asm/paravirt.h       |  2 --
 arch/x86/include/asm/paravirt_types.h |  2 ++
 arch/x86/kernel/paravirt.c            |  2 ++
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 03bb451e4e6b..205e43e55144 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -88,24 +88,6 @@ static inline notrace void arch_local_irq_enable(void)
 }
 
 /*
- * Used in the idle loop; sti takes one instruction cycle
- * to complete:
- */
-static inline __cpuidle void arch_safe_halt(void)
-{
-	native_safe_halt();
-}
-
-/*
- * Used when interrupts are already enabled or to
- * shutdown the processor:
- */
-static inline __cpuidle void halt(void)
-{
-	native_halt();
-}
-
-/*
  * For spinlocks, etc:
  */
 static inline notrace unsigned long arch_local_irq_save(void)
@@ -154,6 +136,26 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #define INTERRUPT_RETURN		iret
 #endif
 
+#else
+
+/*
+ * Used in the idle loop; sti takes one instruction cycle
+ * to complete:
+ */
+static inline __cpuidle void arch_safe_halt(void)
+{
+	native_safe_halt();
+}
+
+/*
+ * Used when interrupts are already enabled or to
+ * shutdown the processor:
+ */
+static inline __cpuidle void halt(void)
+{
+	native_halt();
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_PARAVIRT_XXL */
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index bc9a72a767c8..220c13d7e846 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -91,7 +91,6 @@ static inline void write_cr8(unsigned long x)
 	PVOP_VCALL1(pv_cpu_ops.write_cr8, x);
 }
 #endif
-#endif
 
 static inline void arch_safe_halt(void)
 {
@@ -103,7 +102,6 @@ static inline void halt(void)
 	PVOP_VCALL0(pv_irq_ops.halt);
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
 static inline void wbinvd(void)
 {
 	PVOP_VCALL0(pv_cpu_ops.wbinvd);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index be356aacc82c..938ac2bece81 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -197,8 +197,10 @@ struct pv_irq_ops {
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
 
+#ifdef CONFIG_PARAVIRT_XXL
 	void (*safe_halt)(void);
 	void (*halt)(void);
+#endif
 
 } __no_randomize_layout;
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 437be9454cab..19bfb3d2083f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -379,8 +379,10 @@ struct paravirt_patch_template pv_ops = {
 	.pv_irq_ops.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
 	.pv_irq_ops.irq_disable = __PV_IS_CALLEE_SAVE(native_irq_disable),
 	.pv_irq_ops.irq_enable = __PV_IS_CALLEE_SAVE(native_irq_enable),
+#ifdef CONFIG_PARAVIRT_XXL
 	.pv_irq_ops.safe_halt = native_safe_halt,
 	.pv_irq_ops.halt = native_halt,
+#endif
 
 	/* Mmu ops. */
 	.pv_mmu_ops.read_cr2 = native_read_cr2,
-- 
2.13.7

