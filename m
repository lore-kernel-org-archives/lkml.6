Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeEKIKX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:10:23 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49510 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752153AbeEKIKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:10:21 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39809424"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/vector: Merge the allocate_vector() into assign_vector_locked()
Date: Fri, 11 May 2018 16:09:56 +0800
Message-ID: <20180511080956.6316-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: F34DB4B3EF11.A1995
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assign_vector_locked() calls allocate_vector to get a real vector for
an IRQ. If the current target CPU is online and in the new requested
affinity mask, allocate_vector() will return 0 and nothing should be done.

But, the assign_vector_locked() always call the apic_update_irq_cfg(). it's
pointless.

Merge the two function to avoid this situation and make the code simplify.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/apic/vector.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bb6f7a2148d7..a75de0792942 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -218,7 +218,8 @@ static int reserve_irq_vector(struct irq_data *irqd)
 	return 0;
 }
 
-static int allocate_vector(struct irq_data *irqd, const struct cpumask *dest)
+static int
+assign_vector_locked(struct irq_data *irqd, const struct cpumask *dest)
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	bool resvd = apicd->has_reserved;
@@ -236,22 +237,12 @@ static int allocate_vector(struct irq_data *irqd, const struct cpumask *dest)
 		return 0;
 
 	vector = irq_matrix_alloc(vector_matrix, dest, resvd, &cpu);
-	if (vector > 0)
-		apic_update_vector(irqd, vector, cpu);
 	trace_vector_alloc(irqd->irq, vector, resvd, vector);
-	return vector;
-}
-
-static int assign_vector_locked(struct irq_data *irqd,
-				const struct cpumask *dest)
-{
-	struct apic_chip_data *apicd = apic_chip_data(irqd);
-	int vector = allocate_vector(irqd, dest);
-
 	if (vector < 0)
 		return vector;
+	apic_update_vector(irqd, vector, cpu);
+	apic_update_irq_cfg(irqd, vector, cpu);
 
-	apic_update_irq_cfg(irqd, apicd->vector, apicd->cpu);
 	return 0;
 }
 
-- 
2.14.3
