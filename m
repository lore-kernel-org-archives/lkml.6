Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeBBDz1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:55:27 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41193 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbeBBDzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:08 -0500
X-Google-Smtp-Source: AH8x226Rl4P1HQ2oKFKkMpLwqzlPq64dI4WTPTOSZKd5UZoPglMgP+AZtiJbkWzQqEUigeEF5JF5ig==
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
Subject: [PATCH v2 02/15] MIPS: memblock: Surely map BSS kernel memory section
Date: Fri,  2 Feb 2018 06:54:45 +0300
Message-Id: <20180202035458.30456-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current MIPS code makes sure the kernel code/data/init
sections are in the maps, but BSS should also be there.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 1a4d64410303..f502cd702fa7 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -845,6 +845,9 @@ static void __init arch_mem_init(char **cmdline_p)
 	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
 			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
 			 BOOT_MEM_INIT_RAM);
+	arch_mem_addpart(PFN_DOWN(__pa_symbol(&__bss_start)) << PAGE_SHIFT,
+			 PFN_UP(__pa_symbol(&__bss_stop)) << PAGE_SHIFT,
+			 BOOT_MEM_RAM);
 
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
-- 
2.12.0
