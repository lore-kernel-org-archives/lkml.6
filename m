Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD347C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6772B21479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6772B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbeIUMIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:08:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:15331 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389205AbeIUMIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:08:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 23:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,283,1534834800"; 
   d="scan'208";a="74799006"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by orsmga007.jf.intel.com with ESMTP; 20 Sep 2018 23:21:25 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 09/12][v4] x86-32, hibernate: Switch to original page table after resumed
Date:   Fri, 21 Sep 2018 14:28:11 +0800
Message-Id: <55f1f33f0fe7963bd63eda4e05b19b68ec4a8d3f.1537448058.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

After all the pages are restored to previous address, the page
table switches back to current swapper_pg_dir. However the
swapper_pg_dir currently in used might not be consistent with
previous page table, which might cause issue after resume.

Fix this issue by switching to original page table after resume,
and the address of the original page table is saved in the hibernation
image header.

Move the manipulation of restore_cr3 into common code blocks.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate.c        |  4 ++--
 arch/x86/power/hibernate_asm_32.S | 10 +++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index e3409e4a9b6a..4935b8139229 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -160,6 +160,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 #ifdef CONFIG_X86_64
 	rdr->jump_address = (unsigned long)restore_registers;
 	rdr->jump_address_phys = __pa_symbol(restore_registers);
+#endif
 
 	/*
 	 * The restore code fixes up CR3 and CR4 in the following sequence:
@@ -179,7 +180,6 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	 * have any of the PCID bits set.
 	 */
 	rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
-#endif
 
 	return hibernation_e820_save(rdr->e820_digest);
 }
@@ -201,8 +201,8 @@ int arch_hibernation_header_restore(void *addr)
 #ifdef CONFIG_X86_64
 	restore_jump_address = rdr->jump_address;
 	jump_address_phys = rdr->jump_address_phys;
-	restore_cr3 = rdr->cr3;
 #endif
+	restore_cr3 = rdr->cr3;
 
 	if (hibernation_e820_mismatch(rdr->e820_digest)) {
 		pr_crit("Hibernate inconsistent memory map detected!\n");
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index f5103ae96582..6b2b94937113 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -25,6 +25,10 @@ ENTRY(swsusp_arch_suspend)
 	pushfl
 	popl saved_context_eflags
 
+	/* save cr3 */
+	movl	%cr3, %eax
+	movl	%eax, restore_cr3
+
 	FRAME_BEGIN
 	call swsusp_save
 	FRAME_END
@@ -32,6 +36,8 @@ ENTRY(swsusp_arch_suspend)
 ENDPROC(swsusp_arch_suspend)
 
 ENTRY(restore_image)
+	movl	restore_cr3, %ebp
+
 	movl	mmu_cr4_features, %ecx
 	movl	temp_pgt, %eax
 	movl	%eax, %cr3
@@ -66,9 +72,7 @@ done:
 	.align PAGE_SIZE
 ENTRY(restore_registers)
 	/* go back to the original page tables */
-	movl	$swapper_pg_dir, %eax
-	subl	$__PAGE_OFFSET, %eax
-	movl	%eax, %cr3
+	movl	%ebp, %cr3
 	movl	mmu_cr4_features, %ecx
 	jecxz	1f	# cr4 Pentium and higher, skip if zero
 	movl	%ecx, %cr4;  # turn PGE back on
-- 
2.17.1

