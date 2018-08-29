Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E98EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FB020658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ysUFR3uJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FB020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeH2Tox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbeH2Tox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:44:53 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB4F20647;
        Wed, 29 Aug 2018 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535557640;
        bh=JW3nicCZ8v21dj8YHEC9TzYXSztc7IRaLb6l2RnC05I=;
        h=From:To:Cc:Subject:Date:From;
        b=ysUFR3uJC6/lGLewSqZHrXCiYh0QPcrdFI+90Qmv4CsEbekMWZ5Rgqjfd3sC2ZgS4
         QaxTNXTYufyTgqLtPx2ZOC9RC5I/0VWhRETYguyaFPYDDAuOLhvMa7RjVsrbTA1Tmq
         bVqoGxCfzLFKysoub+AVfCwIDzKZffhG3rhIRlFs=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, Nadav Amit <nadav.amit@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] x86/nmi: Fix some races in NMI uaccess
Date:   Wed, 29 Aug 2018 08:47:18 -0700
Message-Id: <dd956eba16646fd0b15c3c0741269dfd84452dac.1535557289.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In NMI context, we might be in the middle of context switching or in
the middle of switch_mm_irqs_off().  In either case, CR3 might not
match current->mm, which could cause copy_from_user_nmi() and
friends to read the wrong memory.

Fix it by adding a new nmi_uaccess_okay() helper and checking it in
copy_from_user_nmi() and in __copy_from_user_nmi()'s callers.

Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

Nadav, this is intended for your series.  Want to add it right
before the use_temporary_mm() stuff?

Changes from v1:
 - Improved comments
 - Add debugging
 - Fix bugs

arch/x86/events/core.c          |  2 +-
 arch/x86/include/asm/tlbflush.h | 44 +++++++++++++++++++++++++++++++++
 arch/x86/lib/usercopy.c         |  5 ++++
 arch/x86/mm/tlb.c               |  7 ++++++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5f4829f10129..dfb2f7c0d019 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2465,7 +2465,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 
 	perf_callchain_store(entry, regs->ip);
 
-	if (!current->mm)
+	if (!nmi_uaccess_okay())
 		return;
 
 	if (perf_callchain_user32(regs, entry))
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 29c9da6c62fc..183d36a98b04 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -175,8 +175,16 @@ struct tlb_state {
 	 * are on.  This means that it may not match current->active_mm,
 	 * which will contain the previous user mm when we're in lazy TLB
 	 * mode even if we've already switched back to swapper_pg_dir.
+	 *
+	 * During switch_mm_irqs_off(), loaded_mm will be set to
+	 * LOADED_MM_SWITCHING during the brief interrupts-off window
+	 * when CR3 and loaded_mm would otherwise be inconsistent.  This
+	 * is for nmi_uaccess_okay()'s benefit.
 	 */
 	struct mm_struct *loaded_mm;
+
+#define LOADED_MM_SWITCHING ((struct mm_struct *)1)
+
 	u16 loaded_mm_asid;
 	u16 next_asid;
 	/* last user mm's ctx id */
@@ -246,6 +254,42 @@ struct tlb_state {
 };
 DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
 
+/*
+ * Blindly accessing user memory from NMI context can be dangerous
+ * if we're in the middle of switching the current user task or
+ * switching the loaded mm.  It can also be dangerous if we
+ * interrupted some kernel code that was temporarily using a
+ * different mm.
+ */
+static inline bool nmi_uaccess_okay(void)
+{
+	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	struct mm_struct *current_mm = current->mm;
+
+#ifdef CONFIG_DEBUG_VM
+	WARN_ON_ONCE(!loaded_mm);
+#endif
+
+	/*
+	 * The condition we want to check is
+	 * current_mm->pgd == __va(read_cr3_pa()).  This may be slow, though,
+	 * if we're running in a VM with shadow paging, and nmi_uaccess_okay()
+	 * is supposed to be reasonably fast.
+	 *
+	 * Instead, we check the almost equivalent but somewhat conservative
+	 * condition below, and we rely on the fact that switch_mm_irqs_off()
+	 * sets loaded_mm to LOADED_MM_SWITCHING before writing to CR3.
+	 */
+	if (loaded_mm != current_mm)
+		return false;
+
+#ifdef CONFIG_DEBUG_VM
+	WARN_ON_ONCE(current_mm->pgd != __va(read_cr3_pa()));
+#endif
+
+	return true;
+}
+
 /* Initialize cr4 shadow for this CPU. */
 static inline void cr4_init_shadow(void)
 {
diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
index c8c6ad0d58b8..3f435d7fca5e 100644
--- a/arch/x86/lib/usercopy.c
+++ b/arch/x86/lib/usercopy.c
@@ -7,6 +7,8 @@
 #include <linux/uaccess.h>
 #include <linux/export.h>
 
+#include <asm/tlbflush.h>
+
 /*
  * We rely on the nested NMI work to allow atomic faults from the NMI path; the
  * nested NMI paths are careful to preserve CR2.
@@ -19,6 +21,9 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
 	if (__range_not_ok(from, n, TASK_SIZE))
 		return n;
 
+	if (!nmi_uaccess_okay())
+		return n;
+
 	/*
 	 * Even though this function is typically called from NMI/IRQ context
 	 * disable pagefaults so that its behaviour is consistent even when
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e721cf2d4290..707d2b2a333f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -304,6 +304,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
 
+		/* Let nmi_uaccess_okay() know that we're changing CR3. */
+		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+		barrier();
+
 		if (need_flush) {
 			this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 			this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -334,6 +338,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		if (next != &init_mm)
 			this_cpu_write(cpu_tlbstate.last_ctx_id, next->context.ctx_id);
 
+		/* Make sure we write CR3 before loaded_mm. */
+		barrier();
+
 		this_cpu_write(cpu_tlbstate.loaded_mm, next);
 		this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 	}
-- 
2.17.1

