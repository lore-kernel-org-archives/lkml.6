Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932957AbeEHPA2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:00:28 -0400
Received: from ozlabs.org ([203.11.71.1]:35025 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932897AbeEHPAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:00:03 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxram@us.ibm.com
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: [PATCH 8/8] mm/pkeys, x86, powerpc: Display pkey in smaps if arch supports pkeys
Date: Wed,  9 May 2018 00:59:48 +1000
Message-Id: <20180508145948.9492-9-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180508145948.9492-1-mpe@ellerman.id.au>
References: <20180508145948.9492-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

Currently the architecture specific code is expected to display the
protection keys in smap for a given vma. This can lead to redundant
code and possibly to divergent formats in which the key gets
displayed.

This patch changes the implementation. It displays the pkey only if
the architecture support pkeys, i.e arch_pkeys_enabled() returns true.

x86 arch_show_smap() function is not needed anymore, delete it.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
[mpe: Split out from larger patch, rebased on header changes]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/x86/kernel/setup.c | 8 --------
 fs/proc/task_mmu.c      | 8 +++-----
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 5c623dfe39d1..2f86d883dd95 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1312,11 +1312,3 @@ static int __init register_kernel_offset_dumper(void)
 	return 0;
 }
 __initcall(register_kernel_offset_dumper);
-
-void arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
-{
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
-		return;
-
-	seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
-}
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c2163606e6fb..93cea7b07a80 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -18,6 +18,7 @@
 #include <linux/page_idle.h>
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
+#include <linux/pkeys.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -730,10 +731,6 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 }
 #endif /* HUGETLB_PAGE */
 
-void __weak arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
-{
-}
-
 #define SEQ_PUT_DEC(str, val) \
 		seq_put_decimal_ull_width(m, str, (val) >> 10, 8)
 static int show_smap(struct seq_file *m, void *v, int is_pid)
@@ -838,7 +835,8 @@ static int show_smap(struct seq_file *m, void *v, int is_pid)
 		seq_puts(m, " kB\n");
 	}
 	if (!rollup_mode) {
-		arch_show_smap(m, vma);
+		if (arch_pkeys_enabled())
+			seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
 		show_smap_vma_flags(m, vma);
 	}
 	m_cache_vma(m, vma);
-- 
2.14.1
