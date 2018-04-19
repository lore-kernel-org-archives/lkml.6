Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbeDSNVD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:21:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40116 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeDSNUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:20:11 -0400
X-Google-Smtp-Source: AIpwx4+vpZ4Yi64cy/kMV9EB171pbntY4wkTSmTD+Bsp3rjqWocffGiKEfkcwh/T20s7cPe7Kl4mYg==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net
Subject: [PATCH 6/9] nds32: Fix the symbols undefined issue by exporting them.
Date: Thu, 19 Apr 2018 21:18:12 +0800
Message-Id: <b80a4634cf77694dd90d510175a6633a93ea639d.1524143428.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It broke the 'allmodconfig' build.
  LD      vmlinux
  SYSMAP  System.map
  Building modules, stage 2.
  MODPOST 5028 modules
ERROR: "flush_dcache_page" [net/sunrpc/xprtrdma/rpcrdma.ko] undefined!
ERROR: "empty_zero_page" [net/ceph/libceph.ko] undefined!
ERROR: "save_stack_trace" [kernel/backtracetest.ko] undefined!
ERROR: "clear_page" [fs/ocfs2/dlm/ocfs2_dlm.ko] undefined!
ERROR: "copy_page" [fs/nilfs2/nilfs2.ko] undefined!
...

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/Kbuild  |  1 +
 arch/nds32/include/asm/page.h  |  3 +++
 arch/nds32/kernel/stacktrace.c |  1 +
 arch/nds32/lib/copy_page.S     |  3 +++
 arch/nds32/mm/cacheflush.c     | 22 ++++++++++++++++++++++
 arch/nds32/mm/init.c           |  1 +
 6 files changed, 31 insertions(+)

diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index a64e87cc8b49..142e612aa639 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -16,6 +16,7 @@ generic-y += dma.h
 generic-y += emergency-restart.h
 generic-y += errno.h
 generic-y += exec.h
+generic-y += export.h
 generic-y += fb.h
 generic-y += fcntl.h
 generic-y += ftrace.h
diff --git a/arch/nds32/include/asm/page.h b/arch/nds32/include/asm/page.h
index e27365c097b6..947f0491c9a7 100644
--- a/arch/nds32/include/asm/page.h
+++ b/arch/nds32/include/asm/page.h
@@ -27,6 +27,9 @@ extern void copy_user_highpage(struct page *to, struct page *from,
 			       unsigned long vaddr, struct vm_area_struct *vma);
 extern void clear_user_highpage(struct page *page, unsigned long vaddr);
 
+void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
+		    struct page *to);
+void clear_user_page(void *addr, unsigned long vaddr, struct page *page);
 #define __HAVE_ARCH_COPY_USER_HIGHPAGE
 #define clear_user_highpage	clear_user_highpage
 #else
diff --git a/arch/nds32/kernel/stacktrace.c b/arch/nds32/kernel/stacktrace.c
index bc70113c0e84..168562eb3ad2 100644
--- a/arch/nds32/kernel/stacktrace.c
+++ b/arch/nds32/kernel/stacktrace.c
@@ -9,6 +9,7 @@ void save_stack_trace(struct stack_trace *trace)
 {
 	save_stack_trace_tsk(current, trace);
 }
+EXPORT_SYMBOL(save_stack_trace);
 
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
diff --git a/arch/nds32/lib/copy_page.S b/arch/nds32/lib/copy_page.S
index 4a2ff85f17ee..f8701ed161a8 100644
--- a/arch/nds32/lib/copy_page.S
+++ b/arch/nds32/lib/copy_page.S
@@ -2,6 +2,7 @@
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #include <linux/linkage.h>
+#include <asm/export.h>
 #include <asm/page.h>
 
 	.text
@@ -16,6 +17,7 @@ ENTRY(copy_page)
 	popm	$r2, $r10
 	ret
 ENDPROC(copy_page)
+EXPORT_SYMBOL(copy_page)
 
 ENTRY(clear_page)
 	pushm	$r1, $r9
@@ -35,3 +37,4 @@ ENTRY(clear_page)
 	popm	$r1, $r9
         ret
 ENDPROC(clear_page)
+EXPORT_SYMBOL(clear_page)
diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index bd52918d5923..ee44ad96b6ed 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -147,6 +147,25 @@ void flush_cache_vunmap(unsigned long start, unsigned long end)
 	cpu_icache_inval_all();
 }
 
+void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
+		    struct page *to)
+{
+	cpu_dcache_wbinval_page((unsigned long)vaddr);
+	cpu_icache_inval_page((unsigned long)vaddr);
+	copy_page(vto, vfrom);
+	cpu_dcache_wbinval_page((unsigned long)vto);
+	cpu_icache_inval_page((unsigned long)vto);
+}
+
+void clear_user_page(void *addr, unsigned long vaddr, struct page *page)
+{
+	cpu_dcache_wbinval_page((unsigned long)vaddr);
+	cpu_icache_inval_page((unsigned long)vaddr);
+	clear_page(addr);
+	cpu_dcache_wbinval_page((unsigned long)addr);
+	cpu_icache_inval_page((unsigned long)addr);
+}
+
 void copy_user_highpage(struct page *to, struct page *from,
 			unsigned long vaddr, struct vm_area_struct *vma)
 {
@@ -213,6 +232,7 @@ void flush_dcache_page(struct page *page)
 		local_irq_restore(flags);
 	}
 }
+EXPORT_SYMBOL(flush_dcache_page);
 
 void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		       unsigned long vaddr, void *dst, void *src, int len)
@@ -272,6 +292,7 @@ void flush_kernel_dcache_page(struct page *page)
 	cpu_dcache_wbinval_page((unsigned long)page_address(page));
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(flush_kernel_dcache_page);
 
 void flush_kernel_vmap_range(void *addr, int size)
 {
@@ -301,6 +322,7 @@ void flush_icache_range(unsigned long start, unsigned long end)
 	cpu_cache_wbinval_range(start, end, 1);
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(flush_icache_range);
 
 void flush_icache_page(struct vm_area_struct *vma, struct page *page)
 {
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index 93ee0160720b..c713d2ad55dc 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -30,6 +30,7 @@
  * zero-initialized data and COW.
  */
 struct page *empty_zero_page;
+EXPORT_SYMBOL(empty_zero_page);
 
 static void __init zone_sizes_init(void)
 {
-- 
1.9.5
