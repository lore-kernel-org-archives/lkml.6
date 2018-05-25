Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965074AbeEYDvL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 23:51:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934498AbeEYDvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 23:51:08 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/modules: remove unused mod_arch_specific.toc field
Date: Thu, 24 May 2018 22:48:34 -0500
Message-Id: <2892e4f57d03caf1b3d6c14bc456b2f9a116b32a.1527220066.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The toc field in the mod_arch_specific struct isn't actually used
anywhere, so remove it.

Also the ftrace-specific fields are now common between 32-bit and
64-bit, so simplify the struct definition a bit by moving them out of
the __powerpc64__ #ifdef.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/powerpc/include/asm/module.h | 13 +++++--------
 arch/powerpc/kernel/module_64.c   |  1 -
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index 18f7214d68b7..d8374f984f39 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -50,13 +50,6 @@ struct mod_arch_specific {
 	unsigned int stubs_section;	/* Index of stubs section in module */
 	unsigned int toc_section;	/* What section is the TOC? */
 	bool toc_fixed;			/* Have we fixed up .TOC.? */
-#ifdef CONFIG_DYNAMIC_FTRACE
-	unsigned long toc;
-	unsigned long tramp;
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	unsigned long tramp_regs;
-#endif
-#endif
 
 	/* For module function descriptor dereference */
 	unsigned long start_opd;
@@ -65,10 +58,14 @@ struct mod_arch_specific {
 	/* Indices of PLT sections within module. */
 	unsigned int core_plt_section;
 	unsigned int init_plt_section;
+#endif /* powerpc64 */
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 	unsigned long tramp;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	unsigned long tramp_regs;
+#endif
 #endif
-#endif /* powerpc64 */
 
 	/* List of BUG addresses, source line numbers and filenames */
 	struct list_head bug_list;
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index f7667e2ebfcb..1b7419579820 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -823,7 +823,6 @@ static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs,
 
 int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
 {
-	mod->arch.toc = my_r2(sechdrs, mod);
 	mod->arch.tramp = create_ftrace_stub(sechdrs, mod,
 					(unsigned long)ftrace_caller);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-- 
2.17.0
