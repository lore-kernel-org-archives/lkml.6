Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeBBDzV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:55:21 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36949 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBDzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:06 -0500
X-Google-Smtp-Source: AH8x224WYVT19Yp4McHdbCsAsTbv8a3F5ZzMARLgIgtQ3Gl0E5MiizOHg3YYasumFha7nPe+D7GhzA==
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
Subject: [PATCH v2 01/15] MIPS: memblock: Add RESERVED_NOMAP memory flag
Date: Fri,  2 Feb 2018 06:54:44 +0300
Message-Id: <20180202035458.30456-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if nomap flag is specified the reserved memory declared in dts
isn't really discarded from the buddy allocator in the current code.
We'll fix it by adding the no-map MIPS memory flag. Additionally
lets add the RESERVED_NOMAP memory regions handling to the methods,
which aren't going to be changed in the further patches.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/include/asm/bootinfo.h | 1 +
 arch/mips/kernel/prom.c          | 8 ++++++--
 arch/mips/kernel/setup.c         | 8 ++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index e26a093bb17a..276618b5319d 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -90,6 +90,7 @@ extern unsigned long mips_machtype;
 #define BOOT_MEM_ROM_DATA	2
 #define BOOT_MEM_RESERVED	3
 #define BOOT_MEM_INIT_RAM	4
+#define BOOT_MEM_RESERVED_NOMAP	5
 
 /*
  * A memory map that's built upon what was determined
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 0dbcd152a1a9..b123eb8279cd 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -41,7 +41,7 @@ char *mips_get_machine_name(void)
 #ifdef CONFIG_USE_OF
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
-	return add_memory_region(base, size, BOOT_MEM_RAM);
+	add_memory_region(base, size, BOOT_MEM_RAM);
 }
 
 void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
@@ -52,7 +52,11 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
 					phys_addr_t size, bool nomap)
 {
-	add_memory_region(base, size, BOOT_MEM_RESERVED);
+	if (!nomap)
+		add_memory_region(base, size, BOOT_MEM_RESERVED);
+	else
+		add_memory_region(base, size, BOOT_MEM_RESERVED_NOMAP);
+
 	return 0;
 }
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 702c678de116..1a4d64410303 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -172,6 +172,7 @@ bool __init memory_region_available(phys_addr_t start, phys_addr_t size)
 				in_ram = true;
 			break;
 		case BOOT_MEM_RESERVED:
+		case BOOT_MEM_RESERVED_NOMAP:
 			if ((start >= start_ && start < end_) ||
 			    (start < start_ && start + size >= start_))
 				free = false;
@@ -207,6 +208,9 @@ static void __init print_memory_map(void)
 		case BOOT_MEM_RESERVED:
 			printk(KERN_CONT "(reserved)\n");
 			break;
+		case BOOT_MEM_RESERVED_NOMAP:
+			printk(KERN_CONT "(reserved nomap)\n");
+			break;
 		default:
 			printk(KERN_CONT "type %lu\n", boot_mem_map.map[i].type);
 			break;
@@ -955,9 +959,13 @@ static void __init resource_init(void)
 			res->name = "System RAM";
 			res->flags |= IORESOURCE_SYSRAM;
 			break;
+		case BOOT_MEM_RESERVED_NOMAP:
+			res->name = "reserved nomap";
+			break;
 		case BOOT_MEM_RESERVED:
 		default:
 			res->name = "reserved";
+			break;
 		}
 
 		request_resource(&iomem_resource, res);
-- 
2.12.0
