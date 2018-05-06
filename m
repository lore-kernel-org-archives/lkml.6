Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeEFAam (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 20:30:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:58221 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbeEFAak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 20:30:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,367,1520924400";
   d="scan'208";a="226149309"
From: changbin.du@intel.com
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH v3 1/5] x86/mm: surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif
Date: Sun,  6 May 2018 08:20:12 +0800
Message-Id: <1525566016-30172-2-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525566016-30172-1-git-send-email-changbin.du@intel.com>
References: <1525566016-30172-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

The level4_kernel_pgt is only defined when X86_5LEVEL is enabled. So
surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif to
make code correct.

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 arch/x86/include/asm/pgtable_64.h |  2 ++
 arch/x86/kernel/head64.c          | 13 ++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 877bc27..9e7f667 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -15,7 +15,9 @@
 #include <linux/bitops.h>
 #include <linux/threads.h>
 
+#ifdef CONFIG_X86_5LEVEL
 extern p4d_t level4_kernel_pgt[512];
+#endif
 extern p4d_t level4_ident_pgt[512];
 extern pud_t level3_kernel_pgt[512];
 extern pud_t level3_ident_pgt[512];
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c408f8..775d7a6 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -143,16 +143,15 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pgd = fixup_pointer(&early_top_pgt, physaddr);
 	p = pgd + pgd_index(__START_KERNEL_map);
-	if (la57)
-		*p = (unsigned long)level4_kernel_pgt;
-	else
-		*p = (unsigned long)level3_kernel_pgt;
-	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
-
+#ifdef CONFIG_X86_5LEVEL
 	if (la57) {
+		*p = (unsigned long)level4_kernel_pgt;
 		p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
 		p4d[511] += load_delta;
-	}
+	} else
+#endif
+		*p = (unsigned long)level3_kernel_pgt;
+	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
 
 	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
 	pud[510] += load_delta;
-- 
2.7.4
