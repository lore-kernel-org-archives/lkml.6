Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeBBD5y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:57:54 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44396 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeBBDzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:15 -0500
X-Google-Smtp-Source: AH8x224ciKAmbmbQ+zEOrFc54y/TjR6tZxlxtP5Ll7cSyZGU5XVWIcYq9ySVdhL75YCnu+LSPezzEw==
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
Subject: [PATCH v2 08/15] MIPS: memblock: Mark present sparsemem sections
Date: Fri,  2 Feb 2018 06:54:51 +0300
Message-Id: <20180202035458.30456-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If sparsemem is activated all sections with present pages must
be accordingly marked after memblock is fully initialized.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b2a5b89ae6b2..54302319ce1c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -837,6 +837,11 @@ static void __init arch_mem_init(char **cmdline_p)
 				 crashk_res.end - crashk_res.start + 1);
 #endif
 	device_tree_init();
+#ifdef CONFIG_SPARSEMEM
+	for_each_memblock(memory, reg)
+		memory_present(0, memblock_region_memory_base_pfn(reg),
+				memblock_region_memory_end_pfn(reg));
+#endif /* CONFIG_SPARSEMEM */
 	sparse_init();
 	plat_swiotlb_setup();
 
-- 
2.12.0
