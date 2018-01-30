Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeA3OuD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:50:03 -0500
Received: from terminus.zytor.com ([65.50.211.136]:39781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeA3OuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:50:02 -0500
Date: Tue, 30 Jan 2018 06:48:54 -0800
From: tip-bot for William Grant <tipbot@zytor.com>
Message-ID: <tip-55f49fcb879fbeebf2a8c1ac7c9e6d90df55f798@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        william.grant@canonical.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, william.grant@canonical.com
In-Reply-To: <7041d181-a019-e8b9-4e4e-48215f841e2c@canonical.com>
References: <7041d181-a019-e8b9-4e4e-48215f841e2c@canonical.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Fix overlap of i386 CPU_ENTRY_AREA with
 FIX_BTMAP
Git-Commit-ID: 55f49fcb879fbeebf2a8c1ac7c9e6d90df55f798
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  55f49fcb879fbeebf2a8c1ac7c9e6d90df55f798
Gitweb:     https://git.kernel.org/tip/55f49fcb879fbeebf2a8c1ac7c9e6d90df55f798
Author:     William Grant <william.grant@canonical.com>
AuthorDate: Tue, 30 Jan 2018 22:22:55 +1100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 15:30:35 +0100

x86/mm: Fix overlap of i386 CPU_ENTRY_AREA with FIX_BTMAP

Since commit 92a0f81d8957 ("x86/cpu_entry_area: Move it out of the
fixmap"), i386's CPU_ENTRY_AREA has been mapped to the memory area just
below FIXADDR_START. But already immediately before FIXADDR_START is the
FIX_BTMAP area, which means that early_ioremap can collide with the entry
area.

It's especially bad on PAE where FIX_BTMAP_BEGIN gets aligned to exactly
match CPU_ENTRY_AREA_BASE, so the first early_ioremap slot clobbers the
IDT and causes interrupts during early boot to reset the system.

The overlap wasn't a problem before the CPU entry area was introduced,
as the fixmap has classically been preceded by the pkmap or vmalloc
areas, neither of which is used until early_ioremap is out of the
picture.

Relocate CPU_ENTRY_AREA to below FIX_BTMAP, not just below the permanent
fixmap area.

Fixes: commit 92a0f81d8957 ("x86/cpu_entry_area: Move it out of the fixmap")
Signed-off-by: William Grant <william.grant@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/7041d181-a019-e8b9-4e4e-48215f841e2c@canonical.com

---
 arch/x86/include/asm/fixmap.h           | 6 ++++--
 arch/x86/include/asm/pgtable_32_types.h | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 64c4a30..e203169 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -137,8 +137,10 @@ enum fixed_addresses {
 
 extern void reserve_top_address(unsigned long reserve);
 
-#define FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_SIZE		(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_TOT_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_TOT_START	(FIXADDR_TOP - FIXADDR_TOT_SIZE)
 
 extern int fixmaps_set;
 
diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index ce245b0..0777e18 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -44,8 +44,9 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
  */
 #define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 40)
 
-#define CPU_ENTRY_AREA_BASE				\
-	((FIXADDR_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1)) & PMD_MASK)
+#define CPU_ENTRY_AREA_BASE						\
+	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
+	 & PMD_MASK)
 
 #define PKMAP_BASE		\
 	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
