Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD33AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605EE208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBwLaKPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605EE208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeH1CxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeH1CxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:53:05 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9EE4208B4;
        Mon, 27 Aug 2018 23:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535411060;
        bh=bf/smKm0XruB+xEAFXs4VNj68sROk4pHonkMI1K/Jl0=;
        h=From:To:Cc:Subject:Date:From;
        b=aBwLaKPoXx28t6UitT3Ie/L5v69vdeX17sJnfDbhovih3pwx9txxr4SpumzoDQOEx
         QbW0YS9Phk67g14B0GaWxikbPuHvPWo/mbci0wl8n8dbdw5aFkdLxqwdyNk3PHsLXB
         8fLdX0rrfArf3VKRMeuOPlNjLwNeb0UYXITgbGoc=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH] x86/nmi: Fix some races in NMI uaccess
Date:   Mon, 27 Aug 2018 16:04:16 -0700
Message-Id: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
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

The 0day bot is still chewing on this, but I've tested it a bit locally
and it seems to do the right thing.

I've never observed the bug it fixes, but it does appear to fix a bug
unless I've missed something.  It's also a prerequisite for Nadav's
fixmap bugfix.

arch/x86/events/core.c          |  2 +-
 arch/x86/include/asm/tlbflush.h | 16 ++++++++++++++++
 arch/x86/lib/usercopy.c         |  5 +++++
 arch/x86/mm/tlb.c               |  3 +++
 4 files changed, 25 insertions(+), 1 deletion(-)

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
index 89a73bc31622..b23b2625793b 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -230,6 +230,22 @@ struct tlb_state {
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
+	return current_mm && loaded_mm == current_mm &&
+		loaded_mm->pgd == __va(read_cr3_pa());
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
index 457b281b9339..f4b41d5a93dd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -345,6 +345,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 */
 		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 	} else {
+		/* Let NMI code know that CR3 may not match expectations. */
+		this_cpu_write(cpu_tlbstate.loaded_mm, NULL);
+
 		/* The new ASID is already up to date. */
 		load_new_mm_cr3(next->pgd, new_asid, false);
 
-- 
2.17.1

