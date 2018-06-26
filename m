Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40B8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B26526EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B26526EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbeFZRbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:31:46 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36922 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933734AbeFZRbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:31:43 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fXroS-0005n2-Lz; Tue, 26 Jun 2018 13:31:32 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        efault@gmx.de, songliubraving@fb.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 6/6] x86,switch_mm: skip atomic operations for init_mm
Date:   Tue, 26 Jun 2018 13:31:26 -0400
Message-Id: <20180626173126.12296-7-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626173126.12296-1-riel@surriel.com>
References: <20180626173126.12296-1-riel@surriel.com>
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
the most heavily contended one in the system.`

Skipping cpumask_clear_cpu and cpumask_set_cpu for init_mm
(mostly the idle task) reduced CPU use of switch_mm_irqs_off
from 1.8% of the CPU to 0.9% of the CPU, with the following
netperf commandline:

./super_netperf 300 -P 0 -t TCP_RR -p 8888 -H <host> -l 30 \
     -- -r 300,300 -o -s 1M,1M -S 1M,1M

w/o patchset:

Throughput: 1.71264e+06

perf profile:

0.95%  swapper          [kernel.vmlinux]          [k] switch_mm_irqs_off
0.77%  netserver        [kernel.vmlinux]          [k] switch_mm_irqs_off

w/ patchset:

Throughput: 1.74075e+06
0.87%  swapper          [kernel.vmlinux]          [k] switch_mm_irqs_off

CPU use by enter_lazy_tlb is negligible. The bulk of the
savings from switch_mm_irqs_off seem to go towards higher
netperf throughput.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reported-and-tested-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/mm/tlb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 96ab4eacda95..ab3992d82c40 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -300,12 +300,15 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		}
 
 		/* Stop remote flushes for the previous mm */
-		VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu, mm_cpumask(real_prev)) &&
-				real_prev != &init_mm);
-		cpumask_clear_cpu(cpu, mm_cpumask(real_prev));
+		if (real_prev != &init_mm) {
+			VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu,
+					mm_cpumask(real_prev)));
+			cpumask_clear_cpu(cpu, mm_cpumask(real_prev));
+		}
 
 		/* Start remote flushes. */
-		cpumask_set_cpu(cpu, mm_cpumask(next));
+		if (next != &init_mm)
+			cpumask_set_cpu(cpu, mm_cpumask(next));
 	}
 
 	/* Read the tlb_gen to check whether a flush is needed. */
-- 
2.14.4

