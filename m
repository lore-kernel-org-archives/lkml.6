Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2069C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BEB2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BEB2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeKCIlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:41:22 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:8611 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbeKCIk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:40:56 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 2 Nov 2018 16:31:32 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id BC4F4B14CF;
        Fri,  2 Nov 2018 19:31:42 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v3 5/7] x86/alternatives: initializing temporary mm for patching
Date:   Fri, 2 Nov 2018 16:29:44 -0700
Message-ID: <20181102232946.98461-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181102232946.98461-1-namit@vmware.com>
References: <20181102232946.98461-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent improper use of the PTEs that are used for text patching, we
want to use a temporary mm struct. We initailize it by copying the init
mm.

The address that will be used for patching is taken from the lower area
that is usually used for the task memory. Doing so prevents the need to
frequently synchronize the temporary-mm (e.g., when BPF programs are
installed), since different PGDs are used for the task memory.

Finally, we randomize the address of the PTEs to harden against exploits
that use these PTEs.

Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/pgtable.h       |  3 +++
 arch/x86/include/asm/text-patching.h |  2 ++
 arch/x86/kernel/alternative.c        |  3 +++
 arch/x86/mm/init_64.c                | 39 ++++++++++++++++++++++++++++
 init/main.c                          |  3 +++
 5 files changed, 50 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 40616e805292..e8f630d9a2ed 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1021,6 +1021,9 @@ static inline void __meminit init_trampoline_default(void)
 	/* Default trampoline pgd value */
 	trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
 }
+
+void __init poking_init(void);
+
 # ifdef CONFIG_RANDOMIZE_MEMORY
 void __meminit init_trampoline(void);
 # else
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index e85ff65c43c3..ffe7902cc326 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -38,5 +38,7 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 extern int after_bootmem;
+extern __ro_after_init struct mm_struct *poking_mm;
+extern __ro_after_init unsigned long poking_addr;
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 1511d96d2e69..9ceae28db1af 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -678,6 +678,9 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 	return addr;
 }
 
+__ro_after_init struct mm_struct *poking_mm;
+__ro_after_init unsigned long poking_addr;
+
 /**
  * text_poke - Update instructions on a live kernel
  * @addr: address to modify
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dd519f372169..612d17760e20 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -54,6 +54,7 @@
 #include <asm/init.h>
 #include <asm/uv/uv.h>
 #include <asm/setup.h>
+#include <asm/text-patching.h>
 
 #include "mm_internal.h"
 
@@ -1389,6 +1390,44 @@ unsigned long memory_block_size_bytes(void)
 	return memory_block_size_probed;
 }
 
+/*
+ * Initialize an mm_struct to be used during poking and a pointer to be used
+ * during patching. If anything fails during initialization, poking will be done
+ * using the fixmap, which is unsafe, so warn the user about it.
+ */
+void __init poking_init(void)
+{
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+	poking_mm = copy_init_mm();
+	if (!poking_mm) {
+		pr_err("x86/mm: error setting a separate poking address space");
+		return;
+	}
+
+	/*
+	 * Randomize the poking address, but make sure that the following page
+	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
+	 * and adjust the address if the PMD ends after the first one.
+	 */
+	poking_addr = TASK_UNMAPPED_BASE +
+		(kaslr_get_random_long("Poking") & PAGE_MASK) %
+		(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
+
+	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) == 0)
+		poking_addr += PAGE_SIZE;
+
+	/*
+	 * We need to trigger the allocation of the page-tables that will be
+	 * needed for poking now. Later, poking may be performed in an atomic
+	 * section, which might cause allocation to fail.
+	 */
+	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
+	if (!WARN_ON(!ptep))
+		pte_unmap_unlock(ptep, ptl);
+}
+
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 /*
  * Initialise the sparsemem vmemmap using huge-pages at the PMD level.
diff --git a/init/main.c b/init/main.c
index b0fa26637496..2c7ceffcf805 100644
--- a/init/main.c
+++ b/init/main.c
@@ -498,6 +498,8 @@ void __init __weak thread_stack_cache_init(void)
 
 void __init __weak mem_encrypt_init(void) { }
 
+void __init __weak poking_init(void) { }
+
 bool initcall_debug;
 core_param(initcall_debug, initcall_debug, bool, 0644);
 
@@ -727,6 +729,7 @@ asmlinkage __visible void __init start_kernel(void)
 	taskstats_init_early();
 	delayacct_init();
 
+	poking_init();
 	check_bugs();
 
 	acpi_subsystem_init();
-- 
2.17.1

