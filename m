Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F9FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA3A22ACC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA3A22ACC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754415AbeGFV6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:58:50 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35304 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932783AbeGFV5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:57:14 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fbYir-0003ql-Uy; Fri, 06 Jul 2018 17:57:01 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        efault@gmx.de, songliubraving@fb.com, hpa@zytor.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 7/7] x86,switch_mm: skip atomic operations for init_mm
Date:   Fri,  6 Jul 2018 17:56:58 -0400
Message-Id: <20180706215658.18018-8-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706215658.18018-1-riel@surriel.com>
References: <20180706215658.18018-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song noticed switch_mm_irqs_off taking a lot of CPU time in recent
kernels,using 1.8% of a 48 CPU system during a netperf to localhost run.
Digging into the profile, we noticed that cpumask_clear_cpu and
cpumask_set_cpu together take about half of the CPU time taken by
switch_mm_irqs_off.

However, the CPUs running netperf end up switching back and forth
between netperf and the idle task, which does not require changes
to the mm_cpumask. Furthermore, the init_mm cpumask ends up being
the most heavily contended one in the system.

Simply skipping changes to mm_cpumask(&init_mm) reduces overhead.

Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Reported-and-tested-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/mm/tlb.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e7c6de7eb903..c8644aa12abd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -310,15 +310,22 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			sync_current_stack_to_mm(next);
 		}
 
-		/* Stop remote flushes for the previous mm */
-		VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu, mm_cpumask(real_prev)) &&
-				real_prev != &init_mm);
-		cpumask_clear_cpu(cpu, mm_cpumask(real_prev));
+		/*
+		 * Stop remote flushes for the previous mm.
+		 * Skip the idle task; we never send init_mm TLB flushing IPIs,
+		 * but the bitmap manipulation can cause cache line contention.
+		 */
+		if (real_prev != &init_mm) {
+			VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu,
+						mm_cpumask(real_prev)));
+			cpumask_clear_cpu(cpu, mm_cpumask(real_prev));
+		}
 
 		/*
 		 * Start remote flushes and then read tlb_gen.
 		 */
-		cpumask_set_cpu(cpu, mm_cpumask(next));
+		if (next != &init_mm)
+			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
-- 
2.14.4

