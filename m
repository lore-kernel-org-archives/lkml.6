Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C40C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0343920684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0343920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJCTgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:36:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45552 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbeJCTgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:36:37 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 78MBlQjtoeAk; Wed,  3 Oct 2018 14:48:19 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B82B1EC04DE;
        Wed,  3 Oct 2018 14:48:19 +0200 (CEST)
Date:   Wed, 3 Oct 2018 14:48:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     m.mizuma@jp.fujitsu.com, bhe@redhat.com,
        torvalds@linux-foundation.org, msys.mizuma@gmail.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] ACPI/NUMA: Add warning message if the padding
 size for KASLR is not enough
Message-ID: <20181003124814.GA4227@zn.tnic>
References: <20181001140843.26137-3-msys.mizuma@gmail.com>
 <tip-3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41@git.kernel.org>
 <20181003123402.GA15494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181003123402.GA15494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 02:34:02PM +0200, Peter Zijlstra wrote:
> 
> Subject: ACPI/NUMA: Fix KASLR build error
> 
> There is no point in trying to compile KASLR specific code when there is
> no KASLR.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Yeah, Peter and I were just talking on IRC and he gave me a much better
idea how to fix this, see below. I'll run this through the *config builder and
commit it if no complaints.

---
From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Date: Wed, 3 Oct 2018 14:41:27 +0200
Subject: [PATCH] ACPI/NUMA: Fix KASLR build error

There is no point in trying to compile KASLR specific code when there is
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
 arch/x86/mm/kaslr.c          | 18 +++++++++++++++++-
 drivers/acpi/numa.c          | 15 +++------------
 4 files changed, 22 insertions(+), 15 deletions(-)

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
index 00cf4cae38f5..d58b7da0d55c 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -40,7 +40,7 @@
  */
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
-int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+static int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 /*
  * Memory regions randomized by KASLR (except modules that use a separate logic
  * earlier during boot). The list is ordered based on virtual addresses. This
@@ -70,6 +70,22 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+/*
+ * Check the padding size for KASLR is enough.
+ */
+void kaslr_check_padding(void)
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
-- 
2.19.0.271.gfe8321ec057f

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
