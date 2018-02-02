Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeBBD5B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:57:01 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33100 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeBBDzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:20 -0500
X-Google-Smtp-Source: AH8x2247jrcxex/KedXqWHy56fTThZzH106A+BIjUJjxf0fdJ07S/kE5rwtwgmndM1Y1MWK/24xSmw==
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
Subject: [PATCH v2 12/15] MIPS: memblock: Print out kernel virtual mem layout
Date: Fri,  2 Feb 2018 06:54:55 +0300
Message-Id: <20180202035458.30456-13-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to have the kernel virtual memory layout printed
at boot time so to have the full information about the booted
kernel. In some cases it might be unsafe to have virtual
addresses freely visible in logs, so the %pK format is used if
one want to hide them.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/mm/init.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 84b7b592b834..eec92194d4dc 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -32,6 +32,7 @@
 #include <linux/kcore.h>
 #include <linux/export.h>
 #include <linux/initrd.h>
+#include <linux/sizes.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
@@ -60,6 +61,53 @@ EXPORT_SYMBOL_GPL(empty_zero_page);
 EXPORT_SYMBOL(zero_page_mask);
 
 /*
+ * Print out the kernel virtual memory layout
+ */
+#define MLK(b, t) (void *)b, (void *)t, ((t) - (b)) >> 10
+#define MLM(b, t) (void *)b, (void *)t, ((t) - (b)) >> 20
+#define MLK_ROUNDUP(b, t) (void *)b, (void *)t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
+static void __init mem_print_kmap_info(void)
+{
+#ifdef CONFIG_DEBUG_KERNEL
+	pr_notice("Kernel virtual memory layout:\n"
+		  "    lowmem  : 0x%px - 0x%px  (%4ld MB)\n"
+		  "      .text : 0x%px - 0x%px  (%4td kB)\n"
+		  "      .data : 0x%px - 0x%px  (%4td kB)\n"
+		  "      .init : 0x%px - 0x%px  (%4td kB)\n"
+		  "      .bss  : 0x%px - 0x%px  (%4td kB)\n"
+		  "    vmalloc : 0x%px - 0x%px  (%4ld MB)\n"
+#ifdef CONFIG_HIGHMEM
+		  "    pkmap   : 0x%px - 0x%px  (%4ld MB)\n"
+#endif
+		  "    fixmap  : 0x%px - 0x%px  (%4ld kB)\n",
+		  MLM(PAGE_OFFSET, (unsigned long)high_memory),
+		  MLK_ROUNDUP(_text, _etext),
+		  MLK_ROUNDUP(_sdata, _edata),
+		  MLK_ROUNDUP(__init_begin, __init_end),
+		  MLK_ROUNDUP(__bss_start, __bss_stop),
+		  MLM(VMALLOC_START, VMALLOC_END),
+#ifdef CONFIG_HIGHMEM
+		  MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE)),
+#endif
+		  MLK(FIXADDR_START, FIXADDR_TOP));
+
+	/* Check some fundamental inconsistencies. May add something else? */
+#ifdef CONFIG_HIGHMEM
+	BUILD_BUG_ON(VMALLOC_END < PAGE_OFFSET);
+	BUG_ON(VMALLOC_END < (unsigned long)high_memory);
+	BUILD_BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) < PAGE_OFFSET);
+	BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) <
+		(unsigned long)high_memory);
+#endif
+	BUILD_BUG_ON(FIXADDR_TOP < PAGE_OFFSET);
+	BUG_ON(FIXADDR_TOP < (unsigned long)high_memory);
+#endif /* CONFIG_DEBUG_KERNEL */
+}
+#undef MLK
+#undef MLM
+#undef MLK_ROUNDUP
+
+/*
  * Not static inline because used by IP27 special magic initialization code
  */
 void setup_zero_pages(void)
@@ -468,6 +516,7 @@ void __init mem_init(void)
 	free_all_bootmem();
 	setup_zero_pages();	/* Setup zeroed pages.  */
 	mem_init_free_highmem();
+	mem_print_kmap_info();
 	mem_init_print_info(NULL);
 
 #ifdef CONFIG_64BIT
-- 
2.12.0
