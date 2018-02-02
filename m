Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBBD4I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:56:08 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40651 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBBDzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:11 -0500
X-Google-Smtp-Source: AH8x224A3n1jcAS5KmVhcRUSYx0YYqPGhhmt8nK3Fynn9g0t/yVPPstyC6uqoKxsZVo8i2MU2YWuug==
From: Serge Semin <fancer.lancer@gmail.com>
To: ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc: alexander.sverdlin@nokia.com, matt.redfearn@mips.com, kumba@gentoo.org,
        marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/15] MIPS: KASLR: Drop relocatable fixup from reservation_init
Date: Fri,  2 Feb 2018 06:54:48 +0300
Message-Id: <20180202035458.30456-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Redfearn <matt.redfearn@mips.com>

A recent change ("MIPS: memblock: Discard bootmem initialization")
removed the reservation of all memory below the kernel's _end symbol in
bootmem. This makes the call to free_bootmem unnecessary, since the
memory region is no longer marked reserved.

Additionally, ("MIPS: memblock: Print out kernel virtual mem
layout") added a display of the kernel's virtual memory layout, so
printing the relocation information at this point is redundant.

Remove this section of code.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---
 arch/mips/kernel/setup.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b5fcacf71b3f..cf3674977170 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -528,29 +528,6 @@ static void __init bootmem_init(void)
 		memory_present(0, start, end);
 	}
 
-#ifdef CONFIG_RELOCATABLE
-	/*
-	 * The kernel reserves all memory below its _end symbol as bootmem,
-	 * but the kernel may now be at a much higher address. The memory
-	 * between the original and new locations may be returned to the system.
-	 */
-	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
-		unsigned long offset;
-		extern void show_kernel_relocation(const char *level);
-
-		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
-		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
-
-#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
-		/*
-		 * This information is necessary when debugging the kernel
-		 * But is a security vulnerability otherwise!
-		 */
-		show_kernel_relocation(KERN_INFO);
-#endif
-	}
-#endif
-
 	/*
 	 * Reserve initrd memory if needed.
 	 */
-- 
2.12.0
