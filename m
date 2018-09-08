Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A840CC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 07:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6281120869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 07:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DCTEugh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6281120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeIHLrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 07:47:46 -0400
Received: from m12-17.163.com ([220.181.12.17]:60086 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbeIHLrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 07:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=zxnrLSkGc6vUvHXjdY
        NhYiVzCTuPTVbe0X3E3QH9XfU=; b=DCTEugh94tf1t/lL0tj5Uz/ecQbr4AVzpW
        tjlGzRO96awf1KXwroHjbUGQs8o08VJo+1UL8LajNV0hjNy0eanqAGQliiO+rE1u
        N5PPi5eIRIwnCw4hteI84Wm63Cff27fNZ7xjo8+glXH6gZ6LvoYkYhQ9/SvTAyzg
        0wJ8L2Ayc=
Received: from localhost.localdomain (unknown [49.65.59.196])
        by smtp13 (Coremail) with SMTP id EcCowACndQqfc5Nb2qF5DQ--.34S5;
        Sat, 08 Sep 2018 15:01:48 +0800 (CST)
From:   Dou Liyang <dou_liyang@163.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com
Subject: [PATCH v2 2/2] irq/matrix: Spread managed interrupts on allocation
Date:   Sat,  8 Sep 2018 15:00:37 +0800
Message-Id: <20180908070037.31154-2-dou_liyang@163.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180908070037.31154-1-dou_liyang@163.com>
References: <20180908070037.31154-1-dou_liyang@163.com>
X-CM-TRANSID: EcCowACndQqfc5Nb2qF5DQ--.34S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1fWryrGF45Gr1rtrWrZrb_yoWrGw4xpF
        WkJry7ZFWUJ3Wqgw17ZayDAFZIy3s7ArsFv3s5u3sa9r93tr1IqF1qqw1DZF15Ar4rCayU
        CFWDtryrZ3WUJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jm-eOUUUUU=
X-Originating-IP: [49.65.59.196]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiWR67olWBeyA9ywAAsn
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
Changelog v2 --> v1

 -Avoid a churn and the extra indentation suggested by tglx

 arch/x86/kernel/apic/vector.c |  8 +++-----
 include/linux/irq.h           |  3 ++-
 kernel/irq/matrix.c           | 14 +++++++++++---
 3 files changed, 16 insertions(+), 9 deletions(-)

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
index 0cbcdef9337a..753b8b0ba045 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -259,11 +259,18 @@ void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
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
 
+	if (!matrix_find_best_cpu(m, msk, &best_cpu))
+		return -ENOSPC;
+
+	cm = per_cpu_ptr(m->maps, best_cpu);
+	end = m->alloc_end;
 	/* Get managed bit which are not allocated */
 	bitmap_andnot(m->scratch_map, cm->managed_map, cm->alloc_map, end);
 	bit = find_first_bit(m->scratch_map, end);
@@ -272,7 +279,8 @@ int irq_matrix_alloc_managed(struct irq_matrix *m, unsigned int cpu)
 	set_bit(bit, cm->alloc_map);
 	cm->allocated++;
 	m->total_allocated++;
-	trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
+	*mapped_cpu = best_cpu;
+	trace_irq_matrix_alloc_managed(bit, best_cpu, m, cm);
 	return bit;
 }
 
-- 
2.14.3


