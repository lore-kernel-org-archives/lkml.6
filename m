Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964819AbeCGUfC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:35:02 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35663 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934327AbeCGUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:34:59 -0500
X-Google-Smtp-Source: AG47ELtRBodsIKw9syRI1qJGOpTCoyVZ71WHcPL2rJa9ccBOuDIjhgZq9buvZ2Ng2LGiXljIjbzpIA==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Balbir Singh <bsingharora@gmail.com>,
        linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
        64-BIT)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/21] powerpc: Avoid comparison of unsigned long >= 0 in pfn_valid
Date: Wed,  7 Mar 2018 21:34:35 +0100
Message-Id: <20180307203436.23696-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-6-malat@debian.org>
References: <20180225172236.29650-6-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite comparison since all values compared are of type `unsigned long`.

Instead of using unsigned properties and rewriting the original code as:
(originally suggested by Segher Boessenkool <segher@kernel.crashing.org>)

  #define pfn_valid(pfn) \
               (((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))

Prefer a static inline function to make code as readable as possible.

Fix a warning (treated as error in W=1):

  CC      arch/powerpc/kernel/irq.o
In file included from ./include/linux/bug.h:5:0,
                 from ./include/linux/cpumask.h:13,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/kernel_stat.h:5,
                 from arch/powerpc/kernel/irq.c:35:
./include/linux/dma-mapping.h: In function ‘dma_map_resource’:
./arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
 #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
                                ^
Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/page.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 8da5d4c1cab2..6f74938483b7 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -126,7 +126,15 @@ extern long long virt_phys_offset;
 
 #ifdef CONFIG_FLATMEM
 #define ARCH_PFN_OFFSET		((unsigned long)(MEMORY_START >> PAGE_SHIFT))
-#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
+#ifndef __ASSEMBLY__
+extern unsigned long max_mapnr;
+static inline bool pfn_valid(unsigned long pfn)
+{
+	unsigned long min_pfn = ARCH_PFN_OFFSET;
+
+	return pfn >= min_pfn && pfn < max_mapnr;
+}
+#endif
 #endif
 
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
-- 
2.11.0
