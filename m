Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeFAM2W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:28:22 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35500 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeFAM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:28:21 -0400
Date: Fri, 1 Jun 2018 08:28:11 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, kernel-team@fb.com, mingo@redhat.com,
        luto@kernel.org, tglx@linutronix.de, x86@kernel.org
Subject: [PATCH] x86,switch_mm: skip atomic operations for init_mm
Message-ID: <20180601082811.4c0d33ba@imladris.surriel.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song noticed switch_mm_irqs_off taking a lot of CPU time in recent
kernels,using 2.4% of a 48 CPU system during a netperf to localhost run.
Digging into the profile, we noticed that cpumask_clear_cpu and
cpumask_set_cpu together take about half of the CPU time taken by
switch_mm_irqs_off.

However, the CPUs running netperf end up switching back and forth
between netperf and the idle task, which does not require changes
to the mm_cpumask. Furthermore, the init_mm cpumask ends up being
the most heavily contended one in the system.`

Skipping cpumask_clear_cpu and cpumask_set_cpu for init_mm
(mostly the idle task) reduced CPU use of switch_mm_irqs_off
from 2.4% of the CPU to 1.9% of the CPU, with the following
netperf commandline:

./super_netperf 300 -P 0 -t TCP_RR -p 8888 -H kerneltest008.09.atn1 -l 30 \
     -- -r 300,300 -o -s 1M,1M -S 1M,1M

perf output w/o this patch:
    1.26%  netserver        [kernel.vmlinux]          [k] switch_mm_irqs_off
    1.17%  swapper          [kernel.vmlinux]          [k] switch_mm_irqs_off

perf output w/ this patch:
    1.01%  swapper          [kernel.vmlinux]          [k] switch_mm_irqs_off
    0.88%  netserver        [kernel.vmlinux]          [k] switch_mm_irqs_off

Netperf throughput is about the same before and after.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reported-and-tested-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/mm/tlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e055d1a06699..c8f9c550f7ec 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -288,12 +288,14 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		/* Stop remote flushes for the previous mm */
 		VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu, mm_cpumask(real_prev)) &&
 				real_prev != &init_mm);
-		cpumask_clear_cpu(cpu, mm_cpumask(real_prev));
+		if (real_prev != &init_mm)
+			cpumask_clear_cpu(cpu, mm_cpumask(real_prev));
 
 		/*
 		 * Start remote flushes and then read tlb_gen.
 		 */
-		cpumask_set_cpu(cpu, mm_cpumask(next));
+		if (next != &init_mm)
+			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
