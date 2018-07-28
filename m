Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8138C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1B720862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1B720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeG1XWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:22:20 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44082 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731345AbeG1XWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:22:20 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjXA0-0000QZ-Qa; Sat, 28 Jul 2018 17:54:00 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, peterz@infradead.org, luto@kernel.org,
        x86@kernel.org, vkuznets@redhat.com, mingo@kernel.org,
        efault@gmx.de, dave.hansen@intel.com, will.daecon@arm.com,
        catalin.marinas@arm.com, benh@kernel.crashing.org,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 07/10] x86,mm: remove leave_mm cpu argument
Date:   Sat, 28 Jul 2018 17:53:54 -0400
Message-Id: <20180728215357.3249-8-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180728215357.3249-1-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function leave_mm does not use its cpu argument, but always works on
the CPU where it is called.  Change the argument to a void *, so leave_mm
can be called directly from smp_call_function_mask, and stop looking up the
CPU number in current leave_mm callers.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/include/asm/mmu.h    | 2 +-
 arch/x86/mm/tlb.c             | 2 +-
 arch/x86/xen/mmu_pv.c         | 2 +-
 drivers/acpi/processor_idle.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5ff3e8af2c20..ec27966f338f 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -61,6 +61,6 @@ typedef struct {
 		.ctx_id = 1,						\
 	}
 
-void leave_mm(int cpu);
+void leave_mm(void * dummy);
 
 #endif /* _ASM_X86_MMU_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 149fb64e4bf4..ea4ef5ceaba2 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -121,7 +121,7 @@ static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
 	write_cr3(new_mm_cr3);
 }
 
-void leave_mm(int cpu)
+void leave_mm(void *dummy)
 {
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 52206ad81e4b..3402d2bf4ae0 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -984,7 +984,7 @@ static void drop_mm_ref_this_cpu(void *info)
 	struct mm_struct *mm = info;
 
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm)
-		leave_mm(smp_processor_id());
+		leave_mm(NULL);
 
 	/*
 	 * If this cpu still has a stale cr3 reference, then make sure
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index abb559cd28d7..675ffacdd82b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -714,7 +714,7 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
 static void acpi_idle_enter_bm(struct acpi_processor *pr,
 			       struct acpi_processor_cx *cx, bool timer_bc)
 {
-	acpi_unlazy_tlb(smp_processor_id());
+	acpi_unlazy_tlb(NULL);
 
 	/*
 	 * Must be done before busmaster disable as we might need to
-- 
2.14.4

