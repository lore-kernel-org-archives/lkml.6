Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2D4C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2F8214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2F8214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeIRWKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:10:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbeIRWKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:10:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8IGbPQA848179
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 09:37:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8IGbP6L848176;
        Tue, 18 Sep 2018 09:37:25 -0700
Date:   Tue, 18 Sep 2018 09:37:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-76f99ae5b54d48430d1f0c5512a84da0ff9761e0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, mingo@kernel.org
Reply-To: douly.fnst@cn.fujitsu.com, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180908175838.14450-2-dou_liyang@163.com>
References: <20180908175838.14450-2-dou_liyang@163.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] irq/matrix: Spread managed interrupts on allocation
Git-Commit-ID: 76f99ae5b54d48430d1f0c5512a84da0ff9761e0
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

Commit-ID:  76f99ae5b54d48430d1f0c5512a84da0ff9761e0
Gitweb:     https://git.kernel.org/tip/76f99ae5b54d48430d1f0c5512a84da0ff9761e0
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Sun, 9 Sep 2018 01:58:38 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Sep 2018 18:27:24 +0200

irq/matrix: Spread managed interrupts on allocation

Linux spreads out the non managed interrupt across the possible target CPUs
to avoid vector space exhaustion.

Managed interrupts are treated differently, as for them the vectors are
reserved (with guarantee) when the interrupt descriptors are initialized.

When the interrupt is requested a real vector is assigned. The assignment
logic uses the first CPU in the affinity mask for assignment. If the
interrupt has more than one CPU in the affinity mask, which happens when a
multi queue device has less queues than CPUs, then doing the same search as
for non managed interrupts makes sense as it puts the interrupt on the
least interrupt plagued CPU. For single CPU affine vectors that's obviously
a NOOP.

Restructre the matrix allocation code so it does the 'best CPU' search, add
the sanity check for an empty affinity mask and adapt the call site in the
x86 vector management code.

[ tglx: Added the empty mask check to the core and improved change log ]

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180908175838.14450-2-dou_liyang@163.com

---
 arch/x86/kernel/apic/vector.c |  9 ++++-----
 include/linux/irq.h           |  3 ++-
 kernel/irq/matrix.c           | 17 ++++++++++++++---
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 7654febd5102..652e7ffa9b9d 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -313,14 +313,13 @@ assign_managed_vector(struct irq_data *irqd, const struct cpumask *dest)
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
+	vector = irq_matrix_alloc_managed(vector_matrix, vector_searchmask,
+					  &cpu);
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
index 67768bbe736e..6e6d467f3dec 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -260,11 +260,21 @@ void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
  * @m:		Matrix pointer
  * @cpu:	On which CPU the interrupt should be allocated
  */
-int irq_matrix_alloc_managed(struct irq_matrix *m, unsigned int cpu)
+int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
+			     unsigned int *mapped_cpu)
 {
-	struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
-	unsigned int bit, end = m->alloc_end;
+	unsigned int bit, cpu, end = m->alloc_end;
+	struct cpumap *cm;
+
+	if (cpumask_empty(msk))
+		return -EINVAL;
 
+	cpu = matrix_find_best_cpu(m, msk);
+	if (cpu == UINT_MAX)
+		return -ENOSPC;
+
+	cm = per_cpu_ptr(m->maps, cpu);
+	end = m->alloc_end;
 	/* Get managed bit which are not allocated */
 	bitmap_andnot(m->scratch_map, cm->managed_map, cm->alloc_map, end);
 	bit = find_first_bit(m->scratch_map, end);
@@ -273,6 +283,7 @@ int irq_matrix_alloc_managed(struct irq_matrix *m, unsigned int cpu)
 	set_bit(bit, cm->alloc_map);
 	cm->allocated++;
 	m->total_allocated++;
+	*mapped_cpu = cpu;
 	trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
 	return bit;
 }
