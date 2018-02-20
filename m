Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBTKd0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:33:26 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:45721 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeBTKdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:33:24 -0500
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        "Ying Huang" <ying.huang@intel.com>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>,
        "Matija Glavinic Pecotic" <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH 1/2] MIPS: SMP: Group CONFIG_GENERIC_IRQ_IPI together
Date: Tue, 20 Feb 2018 10:32:22 +0000
Message-ID: <1519122743-4847-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519122743-4847-1-git-send-email-matt.redfearn@mips.com>
References: <1519122743-4847-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1519122795-321458-16165-46969-2
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190214
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing selection of a single IPI / CPU, group
affected code together to minimise ifdeffery.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/kernel/smp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index d84b9066b465..5b25e181cefe 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -84,11 +84,6 @@ static cpumask_t cpu_core_setup_map;
 
 cpumask_t cpu_coherent_mask;
 
-#ifdef CONFIG_GENERIC_IRQ_IPI
-static struct irq_desc *call_desc;
-static struct irq_desc *sched_desc;
-#endif
-
 static inline void set_cpu_sibling_map(int cpu)
 {
 	int i;
@@ -157,6 +152,10 @@ void register_smp_ops(const struct plat_smp_ops *ops)
 }
 
 #ifdef CONFIG_GENERIC_IRQ_IPI
+static unsigned int call_virq, sched_virq;
+static struct irq_desc *call_desc;
+static struct irq_desc *sched_desc;
+
 void mips_smp_send_ipi_single(int cpu, unsigned int action)
 {
 	mips_smp_send_ipi_mask(cpumask_of(cpu), action);
@@ -240,8 +239,6 @@ static void smp_ipi_init_one(unsigned int virq,
 	BUG_ON(ret);
 }
 
-static unsigned int call_virq, sched_virq;
-
 int mips_smp_ipi_allocate(const struct cpumask *mask)
 {
 	int virq;
-- 
2.7.4
