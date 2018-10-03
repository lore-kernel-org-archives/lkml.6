Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A333C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5973F21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5973F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJCVLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:11:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37587 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:11:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w93ELrur2374031
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 07:21:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w93ELrnp2374028;
        Wed, 3 Oct 2018 07:21:53 -0700
Date:   Wed, 3 Oct 2018 07:21:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Peter Zijlstra (Intel)" <tipbot@zytor.com>
Message-ID: <tip-3a387c6d96e69f1710a3804eb68e1253263298f2@git.kernel.org>
Cc:     peterz@infradead.org, bhe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, m.mizuma@jp.fujitsu.com,
        torvalds@linux-foundation.org, hpa@zytor.com, bp@suse.de,
        mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
          bp@suse.de, tglx@linutronix.de, m.mizuma@jp.fujitsu.com,
          linux-kernel@vger.kernel.org, bhe@redhat.com,
          peterz@infradead.org
In-Reply-To: <20181003123402.GA15494@hirez.programming.kicks-ass.net>
References: <20181003123402.GA15494@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/kaslr, ACPI/NUMA: Fix KASLR build error
Git-Commit-ID: 3a387c6d96e69f1710a3804eb68e1253263298f2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3a387c6d96e69f1710a3804eb68e1253263298f2
Gitweb:     https://git.kernel.org/tip/3a387c6d96e69f1710a3804eb68e1253263298f2
Author:     Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate: Wed, 3 Oct 2018 14:41:27 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 3 Oct 2018 16:15:49 +0200

x86/kaslr, ACPI/NUMA: Fix KASLR build error

There is no point in trying to compile KASLR-specific code when there is
no KASLR.

 [ bp: Move the whole crap into kaslr.c and make
   rand_mem_physical_padding static. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <m.mizuma@jp.fujitsu.com>
Cc: <bhe@redhat.com>
Cc: <torvalds@linux-foundation.org>
Cc: <tglx@linutronix.de>
Cc: <mingo@kernel.org>
Cc: <hpa@zytor.com>
Link: http://lkml.kernel.org/r/20181003123402.GA15494@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/kaslr.h |  2 ++
 arch/x86/include/asm/setup.h |  2 --
 arch/x86/mm/kaslr.c          | 19 ++++++++++++++++++-
 drivers/acpi/numa.c          | 15 +++------------
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kaslr.h b/arch/x86/include/asm/kaslr.h
index db7ba2feb947..95ef3fc01d12 100644
--- a/arch/x86/include/asm/kaslr.h
+++ b/arch/x86/include/asm/kaslr.h
@@ -6,8 +6,10 @@ unsigned long kaslr_get_random_long(const char *purpose);
 
 #ifdef CONFIG_RANDOMIZE_MEMORY
 void kernel_randomize_memory(void);
+void kaslr_check_padding(void);
 #else
 static inline void kernel_randomize_memory(void) { }
+static inline void kaslr_check_padding(void) { }
 #endif /* CONFIG_RANDOMIZE_MEMORY */
 
 #endif
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 65a5bf8f6aba..ae13bc974416 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -80,8 +80,6 @@ static inline unsigned long kaslr_offset(void)
 	return (unsigned long)&_text - __START_KERNEL;
 }
 
-extern int rand_mem_physical_padding;
-
 /*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 00cf4cae38f5..b3471388288d 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/random.h>
+#include <linux/bootmem.h>
 
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
@@ -40,7 +41,7 @@
  */
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
-int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+static int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 /*
  * Memory regions randomized by KASLR (except modules that use a separate logic
  * earlier during boot). The list is ordered based on virtual addresses. This
@@ -70,6 +71,22 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+/*
+ * Check the padding size for KASLR is enough.
+ */
+void __init kaslr_check_padding(void)
+{
+	u64 max_possible_phys, max_actual_phys, threshold;
+
+	max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << 40);
+	max_possible_phys = roundup(PFN_PHYS(max_possible_pfn), 1ULL << 40);
+	threshold = max_actual_phys + ((u64)rand_mem_physical_padding << 40);
+
+	if (max_possible_phys > threshold)
+		pr_warn("Set 'rand_mem_physical_padding=%llu' to avoid memory hotadd failure.\n",
+			(max_possible_phys - max_actual_phys) >> 40);
+}
+
 static int __init rand_mem_physical_padding_setup(char *str)
 {
 	int max_padding = (1 << (MAX_PHYSMEM_BITS - TB_SHIFT)) - 1;
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 3d69834c692f..4408e37600ef 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -32,7 +32,7 @@
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
-#include <asm/setup.h>
+#include <asm/kaslr.h>
 
 static nodemask_t nodes_found_map = NODE_MASK_NONE;
 
@@ -436,7 +436,6 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 int __init acpi_numa_init(void)
 {
 	int cnt = 0;
-	u64 max_possible_phys, max_actual_phys, threshold;
 
 	if (acpi_disabled)
 		return -EINVAL;
@@ -466,17 +465,9 @@ int __init acpi_numa_init(void)
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity, 0);
 
-		/* check the padding size for KASLR is enough. */
-		if (parsed_numa_memblks && kaslr_enabled()) {
-			max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << 40);
-			max_possible_phys = roundup(PFN_PHYS(max_possible_pfn), 1ULL << 40);
-			threshold = max_actual_phys + ((u64)rand_mem_physical_padding << 40);
+		if (parsed_numa_memblks)
+			kaslr_check_padding();
 
-			if (max_possible_phys > threshold) {
-				pr_warn("Set 'rand_mem_physical_padding=%llu' to avoid memory hotadd failure.\n",
-				  (max_possible_phys - max_actual_phys) >> 40);
-			}
-		}
 	}
 
 	/* SLIT: System Locality Information Table */
