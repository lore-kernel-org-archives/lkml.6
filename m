Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5114C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFED208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFED208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933742AbeGJO2t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:28:49 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37878 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933229AbeGJO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:28:47 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fctd5-0003mn-JN; Tue, 10 Jul 2018 10:28:35 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@intel.com,
        mingo@kernel.org, kernel-team@fb.com, efault@gmx.de,
        tglx@linutronix.de, songliubraving@fb.com, hpa@zytor.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 5/7] x86,tlb: only send page table free TLB flush to lazy TLB CPUs
Date:   Tue, 10 Jul 2018 10:28:31 -0400
Message-Id: <20180710142833.26231-6-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180710142833.26231-1-riel@surriel.com>
References: <20180710142833.26231-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUs in !is_lazy have either received TLB flush IPIs earlier on during
the munmap (when the user memory was unmapped), or have context switched
and reloaded during that stage of the munmap.

Page table free TLB flushes only need to be sent to CPUs in lazy TLB
mode, which TLB contents might not yet be up to date yet.

Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Song Liu <songliubraving@fb.com>
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
 
-- 
2.14.4

