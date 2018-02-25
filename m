Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeBYRXN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:23:13 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46422 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeBYRXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:00 -0500
X-Google-Smtp-Source: AH8x225k5jd7jEEbaTc/U3RnsOB+GIKApk6058h/IqCPy9SXhYvYtEmAs1V0zV8keFEcJ+2qcTjOZQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in pfn_valid
Date: Sun, 25 Feb 2018 18:22:20 +0100
Message-Id: <20180225172236.29650-6-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite comparison since all values compared are of type `unsigned long`.

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
Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/page.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 8da5d4c1cab2..19dea64e7ed2 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -126,7 +126,8 @@ extern long long virt_phys_offset;
 
 #ifdef CONFIG_FLATMEM
 #define ARCH_PFN_OFFSET		((unsigned long)(MEMORY_START >> PAGE_SHIFT))
-#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
+#define pfn_valid(pfn) \
+		(((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))
 #endif
 
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
-- 
2.11.0
