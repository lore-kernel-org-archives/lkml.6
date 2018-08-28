Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E9AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA76520851
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA76520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeH1Vty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:49:54 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35546 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbeH1Vtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:49:53 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fuiEb-0002mq-LD; Tue, 28 Aug 2018 13:56:57 -0400
Date:   Tue, 28 Aug 2018 13:56:47 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2] x86/nmi: Fix some races in NMI uaccess
Message-ID: <20180828135647.6d516048@imladris.surriel.com>
In-Reply-To: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 16:04:16 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> The 0day bot is still chewing on this, but I've tested it a bit locally
> and it seems to do the right thing.

Hi Andy,

the version of the patch below should fix the bug we talked about
in email yesterday.  It should automatically cover kernel threads
in lazy TLB mode, because current->mm will be NULL, while the
cpu_tlbstate.loaded_mm should never be NULL.

---8<---
From: Andy Lutomirski <luto@kernel.org>
Subject: x86/nmi: Fix some races in NMI uaccess

In NMI context, we might be in the middle of context switching or in
the middle of switch_mm_irqs_off().  In either case, CR3 might not
match current->mm, which could cause copy_from_user_nmi() and
friends to read the wrong memory.

Fix it by adding a new nmi_uaccess_okay() helper and checking it in
copy_from_user_nmi() and in __copy_from_user_nmi()'s callers.

Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/events/core.c          |  2 +-
 arch/x86/include/asm/tlbflush.h | 15 +++++++++++++++
 arch/x86/lib/usercopy.c         |  5 +++++
 arch/x86/mm/tlb.c               |  9 ++++++++-
 4 files changed, 29 insertions(+), 2 deletions(-)

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
index 29c9da6c62fc..dafe649b18e1 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -246,6 +246,21 @@ struct tlb_state {
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
+	return (loaded_mm == current_mm);
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
index 9517d1b2a281..5b75e2fed2b6 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -305,6 +305,14 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
 
+		/*
+		 * Ensure cpu_tlbstate.loaded_mm differs from current.mm
+		 * until the context switch is complete, so NMI handlers
+		 * do not try to access userspace. See nmi_uaccess_okay.
+		 */
+		this_cpu_write(cpu_tlbstate.loaded_mm, next);
+		smp_wmb();
+
 		if (need_flush) {
 			this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 			this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -335,7 +343,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		if (next != &init_mm)
 			this_cpu_write(cpu_tlbstate.last_ctx_id, next->context.ctx_id);
 
-		this_cpu_write(cpu_tlbstate.loaded_mm, next);
 		this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 	}
 

