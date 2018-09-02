Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BC0C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C03B20843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C03B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeIBVuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 17:50:18 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:48413 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbeIBVuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 17:50:17 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 2 Sep 2018 10:33:41 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id D41B64070E;
        Sun,  2 Sep 2018 10:33:42 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v2 4/6] x86/alternatives: initializing temporary mm for patching
Date:   Sun, 2 Sep 2018 10:32:22 -0700
Message-ID: <20180902173224.30606-5-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180902173224.30606-1-namit@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
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
 arch/x86/mm/init_64.c                | 29 ++++++++++++++++++++++++++++
 init/main.c                          |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e4ffa565a69f..3de9a1fb7a9a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1022,6 +1022,9 @@ static inline void __meminit init_trampoline_default(void)
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
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dd519f372169..db33a724a054 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -54,6 +54,7 @@
 #include <asm/init.h>
 #include <asm/uv/uv.h>
 #include <asm/setup.h>
+#include <asm/text-patching.h>
 
 #include "mm_internal.h"
 
@@ -1389,6 +1390,34 @@ unsigned long memory_block_size_bytes(void)
 	return memory_block_size_probed;
 }
 
+/*
+ * Initialize an mm_struct to be used during poking and a pointer to be used
+ * during patching. If anything fails during initialization, poking will be done
+ * using the fixmap, which is unsafe, so warn the user about it.
+ */
+void __init poking_init(void)
+{
+	unsigned long poking_addr;
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
+}
+
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 /*
  * Initialise the sparsemem vmemmap using huge-pages at the PMD level.
diff --git a/init/main.c b/init/main.c
index 18f8f0140fa0..8c6dd8d88fca 100644
--- a/init/main.c
+++ b/init/main.c
@@ -496,6 +496,8 @@ void __init __weak thread_stack_cache_init(void)
 
 void __init __weak mem_encrypt_init(void) { }
 
+void __init __weak poking_init(void) { }
+
 bool initcall_debug;
 core_param(initcall_debug, initcall_debug, bool, 0644);
 
@@ -725,6 +727,7 @@ asmlinkage __visible void __init start_kernel(void)
 	taskstats_init_early();
 	delayacct_init();
 
+	poking_init();
 	check_bugs();
 
 	acpi_subsystem_init();
-- 
2.17.1

