Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E31C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BA320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BA320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeILSlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:41:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43891 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:40:32 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g05JC-0001Ap-R0; Wed, 12 Sep 2018 15:35:55 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 04/10] x86/fpu: eager switch PKRU state
Date:   Wed, 12 Sep 2018 15:33:47 +0200
Message-Id: <20180912133353.20595-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912133353.20595-1-bigeasy@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

While most of a task's FPU state is only needed in user space,
the protection keys need to be in place immediately after a
context switch.

The reason is that any accesses to userspace memory while running
in kernel mode also need to abide by the memory permissions
specified in the protection keys.

The pkru info is put in its own cache line in the fpu struct because
that cache line is accessed anyway at context switch time, and the
location of the pkru info in the xsave buffer changes depending on
what other FPU registers are in use if the CPU uses compressed xsave
state (on by default).

The initial state of pkru is zeroed out automatically by fpstate_init.

Signed-off-by: Rik van Riel <riel@surriel.com>
[bigeasy: load PKRU state only if we also load FPU content]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 11 +++++++++--
 arch/x86/include/asm/fpu/types.h    | 10 ++++++++++
 arch/x86/include/asm/pgtable.h      |  6 +-----
 arch/x86/mm/pkeys.c                 | 14 ++++++++++++++
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 16c4077ffc945..57bd1576e033d 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -573,8 +573,15 @@ static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 	bool preload = static_cpu_has(X86_FEATURE_FPU) &&
 		       new_fpu->initialized;
 
-	if (preload)
-		__fpregs_load_activate(new_fpu, cpu);
+	if (!preload)
+		return;
+
+	__fpregs_load_activate(new_fpu, cpu);
+	/* Protection keys need to be in place right at context switch time. */
+	if (boot_cpu_has(X86_FEATURE_OSPKE)) {
+		if (new_fpu->pkru != __read_pkru())
+			__write_pkru(new_fpu->pkru);
+	}
 }
 
 /*
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 202c53918ecfa..6fa58d37938d2 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -293,6 +293,16 @@ struct fpu {
 	 */
 	unsigned int			last_cpu;
 
+	/*
+	 * Protection key bits. These also live inside fpu.state.xsave,
+	 * but the location varies if the CPU uses the compressed format
+	 * for XSAVE(OPT).
+	 *
+	 * The protection key needs to be switched out immediately at context
+	 * switch time, so it is in place for things like copy_to_user.
+	 */
+	unsigned int			pkru;
+
 	/*
 	 * @initialized:
 	 *
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 690c0307afed0..cc36f91011ad7 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -132,11 +132,7 @@ static inline u32 read_pkru(void)
 	return 0;
 }
 
-static inline void write_pkru(u32 pkru)
-{
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		__write_pkru(pkru);
-}
+extern void write_pkru(u32 pkru);
 
 static inline int pte_young(pte_t pte)
 {
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 6e98e0a7c9231..c7a7b6bd64009 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -18,6 +18,20 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
+#include <asm/fpu/internal.h>
+
+void write_pkru(u32 pkru)
+{
+	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+		return;
+
+	current->thread.fpu.pkru = pkru;
+
+	__fpregs_changes_begin();
+	__fpregs_load_activate(&current->thread.fpu, smp_processor_id());
+	__write_pkru(pkru);
+	__fpregs_changes_end();
+}
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
-- 
2.19.0

