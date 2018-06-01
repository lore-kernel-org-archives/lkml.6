Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbeFAPVg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:21:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52176 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeFAPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:21:30 -0400
X-Google-Smtp-Source: ADUXVKJsRyrmEvkAz6iEJVVtbE5glBb5vEy3XRcAHYZ79N+ktb0sHSsfbvYIRemEATosACU2/l3QUA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] riscv: use NULL instead of a plain 0
Date: Fri,  1 Jun 2018 17:21:21 +0200
Message-Id: <20180601152123.47256-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601152123.47256-1-luc.vanoostenryck@gmail.com>
References: <20180601152123.47256-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sbi_remote_sfence_vma() & sbi_remote_fence_i() takes
a pointer as first argument but some macros call them with
a plain 0 which, while legal C, is frowned upon in the kernel.

Change this by replacing the 0 by NULL.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/riscv/include/asm/cacheflush.h | 2 +-
 arch/riscv/include/asm/tlbflush.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index efd89a88d..8f1307441 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -47,7 +47,7 @@ static inline void flush_dcache_page(struct page *page)
 
 #else /* CONFIG_SMP */
 
-#define flush_icache_all() sbi_remote_fence_i(0)
+#define flush_icache_all() sbi_remote_fence_i(NULL)
 void flush_icache_mm(struct mm_struct *mm, bool local);
 
 #endif /* CONFIG_SMP */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 7b209aec3..85c2d8bae 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -49,7 +49,7 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 
 #include <asm/sbi.h>
 
-#define flush_tlb_all() sbi_remote_sfence_vma(0, 0, -1)
+#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
 #define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
 #define flush_tlb_range(vma, start, end) \
 	sbi_remote_sfence_vma(mm_cpumask((vma)->vm_mm)->bits, \
-- 
2.17.1
