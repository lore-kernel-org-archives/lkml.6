Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3zVPCqpEGVtKFAAAmS7hNA
	; Thu, 07 Jun 2018 14:43:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 190876089E; Thu,  7 Jun 2018 14:43:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0363F602FC;
	Thu,  7 Jun 2018 14:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0363F602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934876AbeFGOnr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:43:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40685 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934145AbeFGOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:43:32 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbw-0005Zq-Sz; Thu, 07 Jun 2018 15:09:57 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002l6-K6; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, linux@dominikbrodowski.net,
        "Tim Chen" <tim.c.chen@linux.intel.com>, pbonzini@redhat.com,
        bp@alien8.de, "David Woodhouse" <dwmw@amazon.co.uk>,
        peterz@infradead.org, gregkh@linux-foundation.org, luto@kernel.org,
        ak@linux.intel.com, arjan@linux.intel.com,
        "Thomas Gleixner" <tglx@linutronix.de>,
        torvalds@linux-foundation.org, karahmed@amazon.de
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.341833345@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 062/410] x86/speculation: Use Indirect Branch
 Prediction Barrier in context switch
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Chen <tim.c.chen@linux.intel.com>

commit 18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7 upstream.

Flush indirect branches when switching into a process that marked itself
non dumpable. This protects high value processes like gpg better,
without having too high performance overhead.

If done naïvely, we could switch to a kernel idle thread and then back
to the original process, such as:

    process A -> idle -> process A

In such scenario, we do not have to do IBPB here even though the process
is non-dumpable, as we are switching back to the same process after a
hiatus.

To avoid the redundant IBPB, which is expensive, we track the last mm
user context ID. The cost is to have an extra u64 mm context id to track
the last mm we were using before switching to the init_mm used by idle.
Avoiding the extra IBPB is probably worth the extra memory for this
common scenario.

For those cases where tlb_defer_switch_to_init_mm() returns true (non
PCID), lazy tlb will defer switch to init_mm, so we will not be changing
the mm for the process A -> idle -> process A switch. So IBPB will be
skipped for this case.

Thanks to the reviewers and Andy Lutomirski for the suggestion of
using ctx_id which got rid of the problem of mm pointer recycling.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: linux@dominikbrodowski.net
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: luto@kernel.org
Cc: pbonzini@redhat.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1517263487-3708-1-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.16: Drop the optimisation for switching via the idle
 task, since we don't have mm_context_t::ctx_id here]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -10,6 +10,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
+#include <asm/nospec-branch.h>
 #include <asm/cache.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
@@ -100,6 +101,24 @@ void switch_mm_irqs_off(struct mm_struct
 	unsigned cpu = smp_processor_id();
 
 	if (likely(prev != next)) {
+		/*
+		 * Avoid user/user BTB poisoning by flushing the branch
+		 * predictor when switching between processes. This stops
+		 * one process from doing Spectre-v2 attacks on another.
+		 *
+		 * As an optimization, flush indirect branches only when
+		 * switching into processes that disable dumping. This
+		 * protects high value processes like gpg, without having
+		 * too high performance overhead. IBPB is *expensive*!
+		 *
+		 * This will not flush branches when switching into kernel
+		 * threads. It will flush if we switch to a different non-
+		 * dumpable process.
+		 */
+		if (tsk && tsk->mm &&
+		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
+			indirect_branch_prediction_barrier();
+
 		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
 		this_cpu_write(cpu_tlbstate.active_mm, next);
 		cpumask_set_cpu(cpu, mm_cpumask(next));
