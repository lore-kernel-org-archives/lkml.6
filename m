Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeBBD5j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:57:39 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41218 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeBBDzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:16 -0500
X-Google-Smtp-Source: AH8x227CsG8UaJtqNjezaOwtDnAwgFYFOwQmAZvJwtTWhrw2vJCo4JRMDy/ifr/PmdTu4bk4miTycQ==
From: Serge Semin <fancer.lancer@gmail.com>
To: ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc: alexander.sverdlin@nokia.com, matt.redfearn@mips.com, kumba@gentoo.org,
        marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 09/15] MIPS: memblock: Simplify DMA contiguous reservation
Date: Fri,  2 Feb 2018 06:54:52 +0300
Message-Id: <20180202035458.30456-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMA reserves it areas in the memblock allocator. Since we aren't
using bootmem anymore, the reservations copying should be discarded.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 54302319ce1c..158a52c17e29 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -755,7 +755,7 @@ static void __init request_crashkernel(struct resource *res)
 
 static void __init arch_mem_init(char **cmdline_p)
 {
-	struct memblock_region *reg;
+	struct memblock_region *reg __maybe_unused;
 	extern void plat_mem_setup(void);
 
 	/* call board setup routine */
@@ -846,10 +846,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	plat_swiotlb_setup();
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
-	/* Tell bootmem about cma reserved memblock section */
-	for_each_memblock(reserved, reg)
-		if (reg->size != 0)
-			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
 }
 
 static void __init resource_init(void)
-- 
2.12.0
