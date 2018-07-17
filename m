Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7395ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5C420BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5C420BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbeGQKHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:07:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbeGQKHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:07:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9ZfHq1463459
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:35:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9Zf3x1463456;
        Tue, 17 Jul 2018 02:35:41 -0700
Date:   Tue, 17 Jul 2018 02:35:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-64482aafe55fc7e84d0741c356f8176ee7bde357@git.kernel.org>
Cc:     riel@surriel.com, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        songliubraving@fb.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com
Reply-To: dave.hansen@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, songliubraving@fb.com, hpa@zytor.com,
          tglx@linutronix.de, peterz@infradead.org,
          torvalds@linux-foundation.org, riel@surriel.com
In-Reply-To: <20180716190337.26133-6-riel@surriel.com>
References: <20180716190337.26133-6-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Only send page table free TLB flush to
 lazy TLB CPUs
Git-Commit-ID: 64482aafe55fc7e84d0741c356f8176ee7bde357
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

Commit-ID:  64482aafe55fc7e84d0741c356f8176ee7bde357
Gitweb:     https://git.kernel.org/tip/64482aafe55fc7e84d0741c356f8176ee7bde357
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Mon, 16 Jul 2018 15:03:35 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:35:33 +0200

x86/mm/tlb: Only send page table free TLB flush to lazy TLB CPUs

CPUs in !is_lazy have either received TLB flush IPIs earlier on during
the munmap (when the user memory was unmapped), or have context switched
and reloaded during that stage of the munmap.

Page table free TLB flushes only need to be sent to CPUs in lazy TLB
mode, which TLB contents might not yet be up to date yet.

Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: efault@gmx.de
Cc: kernel-team@fb.com
Cc: luto@kernel.org
Link: http://lkml.kernel.org/r/20180716190337.26133-6-riel@surriel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/tlb.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 26542cc17043..e4156e37aa71 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -712,15 +712,50 @@ void tlb_flush_remove_tables_local(void *arg)
 	}
 }
 
+static void mm_fill_lazy_tlb_cpu_mask(struct mm_struct *mm,
+				      struct cpumask *lazy_cpus)
+{
+	int cpu;
+
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		if (!per_cpu(cpu_tlbstate.is_lazy, cpu))
+			cpumask_set_cpu(cpu, lazy_cpus);
+	}
+}
+
 void tlb_flush_remove_tables(struct mm_struct *mm)
 {
 	int cpu = get_cpu();
+	cpumask_var_t lazy_cpus;
+
+	if (cpumask_any_but(mm_cpumask(mm), cpu) >= nr_cpu_ids) {
+		put_cpu();
+		return;
+	}
+
+	if (!zalloc_cpumask_var(&lazy_cpus, GFP_ATOMIC)) {
+		/*
+		 * If the cpumask allocation fails, do a brute force flush
+		 * on all the CPUs that have this mm loaded.
+		 */
+		smp_call_function_many(mm_cpumask(mm),
+				tlb_flush_remove_tables_local, (void *)mm, 1);
+		put_cpu();
+		return;
+	}
+
 	/*
-	 * XXX: this really only needs to be called for CPUs in lazy TLB mode.
+	 * CPUs with !is_lazy either received a TLB flush IPI while the user
+	 * pages in this address range were unmapped, or have context switched
+	 * and reloaded %CR3 since then.
+	 *
+	 * Shootdown IPIs at page table freeing time only need to be sent to
+	 * CPUs that may have out of date TLB contents.
 	 */
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
-		smp_call_function_many(mm_cpumask(mm), tlb_flush_remove_tables_local, (void *)mm, 1);
-
+	mm_fill_lazy_tlb_cpu_mask(mm, lazy_cpus);
+	smp_call_function_many(lazy_cpus,
+				tlb_flush_remove_tables_local, (void *)mm, 1);
+	free_cpumask_var(lazy_cpus);
 	put_cpu();
 }
 
