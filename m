Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83883ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADE320BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADE320BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbeGQKIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:08:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeGQKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:08:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9aiBB1463713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:36:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9ahFF1463710;
        Tue, 17 Jul 2018 02:36:44 -0700
Date:   Tue, 17 Jul 2018 02:36:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-e9d8c61557687b7126101e9550bdf243223f0d8f@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        torvalds@linux-foundation.org, riel@surriel.com,
        songliubraving@fb.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          dave.hansen@intel.com, hpa@zytor.com, peterz@infradead.org,
          mingo@kernel.org, songliubraving@fb.com,
          torvalds@linux-foundation.org, riel@surriel.com
In-Reply-To: <20180716190337.26133-8-riel@surriel.com>
References: <20180716190337.26133-8-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Skip atomic operations for 'init_mm' in
 switch_mm_irqs_off()
Git-Commit-ID: e9d8c61557687b7126101e9550bdf243223f0d8f
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

Commit-ID:  e9d8c61557687b7126101e9550bdf243223f0d8f
Gitweb:     https://git.kernel.org/tip/e9d8c61557687b7126101e9550bdf243223f0d8f
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Mon, 16 Jul 2018 15:03:37 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:35:34 +0200

x86/mm/tlb: Skip atomic operations for 'init_mm' in switch_mm_irqs_off()

Song Liu noticed switch_mm_irqs_off() taking a lot of CPU time in recent
kernels,using 1.8% of a 48 CPU system during a netperf to localhost run.
Digging into the profile, we noticed that cpumask_clear_cpu and
cpumask_set_cpu together take about half of the CPU time taken by
switch_mm_irqs_off().

However, the CPUs running netperf end up switching back and forth
between netperf and the idle task, which does not require changes
to the mm_cpumask. Furthermore, the init_mm cpumask ends up being
the most heavily contended one in the system.

Simply skipping changes to mm_cpumask(&init_mm) reduces overhead.

Reported-and-tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: efault@gmx.de
Cc: kernel-team@fb.com
Cc: luto@kernel.org
Link: http://lkml.kernel.org/r/20180716190337.26133-8-riel@surriel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/tlb.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 493559cae2d5..f086195f644c 100644
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
+		 * Skip kernel threads; we never send init_mm TLB flushing IPIs,
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
