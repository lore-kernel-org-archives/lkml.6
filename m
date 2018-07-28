Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D867BECDFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E94220893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E94220893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeG1XWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:22:37 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44166 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbeG1XWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:22:22 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjXA0-0000QZ-T0; Sat, 28 Jul 2018 17:54:00 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, peterz@infradead.org, luto@kernel.org,
        x86@kernel.org, vkuznets@redhat.com, mingo@kernel.org,
        efault@gmx.de, dave.hansen@intel.com, will.daecon@arm.com,
        catalin.marinas@arm.com, benh@kernel.crashing.org,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 09/10] mm,x86: shoot down lazy TLB references at exit_mmap time
Date:   Sat, 28 Jul 2018 17:53:56 -0400
Message-Id: <20180728215357.3249-10-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180728215357.3249-1-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shooting down lazy TLB references to an mm at exit_mmap time ensures
that no users of the mm_struct will be left anywhere in the system,
allowing it to be torn down and freed immediately.

Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/mmu_context.h |  1 +
 arch/x86/include/asm/tlbflush.h    |  2 ++
 arch/x86/mm/tlb.c                  | 15 +++++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6d4774f203d0..ecdfc6933203 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -75,6 +75,7 @@ config X86
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_NO_ACTIVE_MM_REFCOUNTING
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index eeeb9289c764..529bf7bc5f75 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -238,6 +238,7 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 {
 	paravirt_arch_exit_mmap(mm);
 	ldt_arch_exit_mmap(mm);
+	lazy_tlb_exit_mmap(mm);
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 511bf5fae8b8..3966a45367cd 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -538,6 +538,8 @@ extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 	native_flush_tlb_others(mask, info)
 #endif
 
+extern void lazy_tlb_exit_mmap(struct mm_struct *mm);
+
 extern void tlb_flush_remove_tables(struct mm_struct *mm);
 extern void tlb_flush_remove_tables_local(void *arg);
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ea4ef5ceaba2..7b1add904396 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -713,6 +713,21 @@ void tlb_flush_remove_tables(struct mm_struct *mm)
 	put_cpu();
 }
 
+/*
+ * At exit or execve time, all other threads of a process have disappeared,
+ * but other CPUs could still be referencing this mm in lazy TLB mode.
+ * Get rid of those references before releasing the mm.
+ */
+void lazy_tlb_exit_mmap(struct mm_struct *mm)
+{
+	int cpu = get_cpu();
+
+	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
+		on_each_cpu_mask(mm_cpumask(mm), leave_mm, NULL, 1);
+
+	put_cpu();
+}
+
 static void do_flush_tlb_all(void *info)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
-- 
2.14.4

