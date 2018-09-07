Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E52C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0970E2086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AmNCP4xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0970E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeIGNFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:05:49 -0400
Received: from m12-13.163.com ([220.181.12.13]:45911 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeIGNFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=j27uu8pCPRpxKJXn+B
        7L5naymltUs4aAtlORruMdu3Q=; b=AmNCP4xqB7fpUIqRs95m2dwnbFM92BEnXR
        hfdOB8tz9bT1lE/B4s3RRr/n+5G+t/H23ywiX5UtCfy6umba7gczh7PyOWmB0PK4
        ZJo7ed3z65PXUVGg4CNx2AoM8eirBzzKrXfHAWBrAfz3JLdmhvE/ZdsNiCuGxifQ
        jNTf71St8=
Received: from localhost.localdomain (unknown [49.65.59.196])
        by smtp9 (Coremail) with SMTP id DcCowABHrooFNpJbiI7ZIg--.39791S5;
        Fri, 07 Sep 2018 16:25:48 +0800 (CST)
From:   Dou Liyang <dou_liyang@163.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com
Subject: [PATCH 2/2] irq/matrix: Spread managed interrupts on allocation
Date:   Fri,  7 Sep 2018 16:25:09 +0800
Message-Id: <20180907082509.11083-2-dou_liyang@163.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180907082509.11083-1-dou_liyang@163.com>
References: <20180907082509.11083-1-dou_liyang@163.com>
X-CM-TRANSID: DcCowABHrooFNpJbiI7ZIg--.39791S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1fWryrGryxGrWxZrWrKrg_yoWrWF4kpr
        WkJFy7urWUJ3ZrWw17ZayDAFZIy3s7ArsIkas5u3sa9ryftr12qF1qqFyDZF15Ar1rCayU
        CFWqqryru3WUJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBFALUUUUU=
X-Originating-IP: [49.65.59.196]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiLgy6olSIcLjKMwAAsX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

Linux has spread out the non managed interrupt across the possible
target CPUs to avoid vector space exhaustion.

But, the same situation may happen on the managed interrupts.

Spread managed interrupt on allocation as well.

Fixes: a0c9259dc4e1("irq/matrix: Spread interrupts on allocation")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/apic/vector.c |  8 +++-----
 include/linux/irq.h           |  3 ++-
 kernel/irq/matrix.c           | 32 ++++++++++++++++++++------------
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 9f148e3d45b4..b7fc290b4b98 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -313,14 +313,12 @@ assign_managed_vector(struct irq_data *irqd, const struct cpumask *dest)
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	int vector, cpu;
 
-	cpumask_and(vector_searchmask, vector_searchmask, affmsk);
-	cpu = cpumask_first(vector_searchmask);
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+	cpumask_and(vector_searchmask, dest, affmsk);
+
 	/* set_affinity might call here for nothing */
 	if (apicd->vector && cpumask_test_cpu(apicd->cpu, vector_searchmask))
 		return 0;
-	vector = irq_matrix_alloc_managed(vector_matrix, cpu);
+	vector = irq_matrix_alloc_managed(vector_matrix, vector_searchmask, &cpu);
 	trace_vector_alloc_managed(irqd->irq, vector, vector);
 	if (vector < 0)
 		return vector;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 201de12a9957..c9bffda04a45 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1151,7 +1151,8 @@ void irq_matrix_offline(struct irq_matrix *m);
 void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit, bool replace);
 int irq_matrix_reserve_managed(struct irq_matrix *m, const struct cpumask *msk);
 void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk);
-int irq_matrix_alloc_managed(struct irq_matrix *m, unsigned int cpu);
+int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
+				unsigned int *mapped_cpu);
 void irq_matrix_reserve(struct irq_matrix *m);
 void irq_matrix_remove_reserved(struct irq_matrix *m);
 int irq_matrix_alloc(struct irq_matrix *m, const struct cpumask *msk,
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 5eb0c8b857f0..b449a749b354 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -259,21 +259,29 @@ void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
  * @m:		Matrix pointer
  * @cpu:	On which CPU the interrupt should be allocated
  */
-int irq_matrix_alloc_managed(struct irq_matrix *m, unsigned int cpu)
+int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
+				unsigned int *mapped_cpu)
 {
-	struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
 	unsigned int bit, end = m->alloc_end;
+	unsigned int best_cpu = UINT_MAX;
+	struct cpumap *cm;
 
-	/* Get managed bit which are not allocated */
-	bitmap_andnot(m->scratch_map, cm->managed_map, cm->alloc_map, end);
-	bit = find_first_bit(m->scratch_map, end);
-	if (bit >= end)
-		return -ENOSPC;
-	set_bit(bit, cm->alloc_map);
-	cm->allocated++;
-	m->total_allocated++;
-	trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
-	return bit;
+	if (matrix_find_best_cpu(m, msk, &best_cpu)) {
+		cm = per_cpu_ptr(m->maps, best_cpu);
+		end = m->alloc_end;
+		/* Get managed bit which are not allocated */
+		bitmap_andnot(m->scratch_map, cm->managed_map, cm->alloc_map, end);
+		bit = find_first_bit(m->scratch_map, end);
+		if (bit >= end)
+			return -ENOSPC;
+		set_bit(bit, cm->alloc_map);
+		cm->allocated++;
+		m->total_allocated++;
+		*mapped_cpu = best_cpu;
+		trace_irq_matrix_alloc_managed(bit, best_cpu, m, cm);
+		return bit;
+	}
+	return -ENOSPC;
 }
 
 /**
-- 
2.14.3


