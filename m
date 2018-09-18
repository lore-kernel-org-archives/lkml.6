Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD52FECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7466B214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7466B214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbeIRWK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:10:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37233 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbeIRWK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:10:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8IGarWb848133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 09:36:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8IGarks848130;
        Tue, 18 Sep 2018 09:36:53 -0700
Date:   Tue, 18 Sep 2018 09:36:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-8ffe4e61c06a48324cfd97f1199bb9838acce2f2@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, douly.fnst@cn.fujitsu.com
Reply-To: hpa@zytor.com, mingo@kernel.org, douly.fnst@cn.fujitsu.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180908175838.14450-1-dou_liyang@163.com>
References: <20180908175838.14450-1-dou_liyang@163.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] irq/matrix: Split out the CPU selection code into a
 helper
Git-Commit-ID: 8ffe4e61c06a48324cfd97f1199bb9838acce2f2
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

Commit-ID:  8ffe4e61c06a48324cfd97f1199bb9838acce2f2
Gitweb:     https://git.kernel.org/tip/8ffe4e61c06a48324cfd97f1199bb9838acce2f2
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Sun, 9 Sep 2018 01:58:37 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Sep 2018 18:27:24 +0200

irq/matrix: Split out the CPU selection code into a helper

Linux finds the CPU which has the lowest vector allocation count to spread
out the non managed interrupts across the possible target CPUs, but does
not do so for managed interrupts.

Split out the CPU selection code into a helper function for reuse. No
functional change.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180908175838.14450-1-dou_liyang@163.com

---
 kernel/irq/matrix.c | 65 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 5092494bf261..67768bbe736e 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -124,6 +124,27 @@ static unsigned int matrix_alloc_area(struct irq_matrix *m, struct cpumap *cm,
 	return area;
 }
 
+/* Find the best CPU which has the lowest vector allocation count */
+static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
+					const struct cpumask *msk)
+{
+	unsigned int cpu, best_cpu, maxavl = 0;
+	struct cpumap *cm;
+
+	best_cpu = UINT_MAX;
+
+	for_each_cpu(cpu, msk) {
+		cm = per_cpu_ptr(m->maps, cpu);
+
+		if (!cm->online || cm->available <= maxavl)
+			continue;
+
+		best_cpu = cpu;
+		maxavl = cm->available;
+	}
+	return best_cpu;
+}
+
 /**
  * irq_matrix_assign_system - Assign system wide entry in the matrix
  * @m:		Matrix pointer
@@ -322,37 +343,27 @@ void irq_matrix_remove_reserved(struct irq_matrix *m)
 int irq_matrix_alloc(struct irq_matrix *m, const struct cpumask *msk,
 		     bool reserved, unsigned int *mapped_cpu)
 {
-	unsigned int cpu, best_cpu, maxavl = 0;
+	unsigned int cpu, bit;
 	struct cpumap *cm;
-	unsigned int bit;
 
-	best_cpu = UINT_MAX;
-	for_each_cpu(cpu, msk) {
-		cm = per_cpu_ptr(m->maps, cpu);
-
-		if (!cm->online || cm->available <= maxavl)
-			continue;
+	cpu = matrix_find_best_cpu(m, msk);
+	if (cpu == UINT_MAX)
+		return -ENOSPC;
 
-		best_cpu = cpu;
-		maxavl = cm->available;
-	}
+	cm = per_cpu_ptr(m->maps, cpu);
+	bit = matrix_alloc_area(m, cm, 1, false);
+	if (bit >= m->alloc_end)
+		return -ENOSPC;
+	cm->allocated++;
+	cm->available--;
+	m->total_allocated++;
+	m->global_available--;
+	if (reserved)
+		m->global_reserved--;
+	*mapped_cpu = cpu;
+	trace_irq_matrix_alloc(bit, cpu, m, cm);
+	return bit;
 
-	if (maxavl) {
-		cm = per_cpu_ptr(m->maps, best_cpu);
-		bit = matrix_alloc_area(m, cm, 1, false);
-		if (bit < m->alloc_end) {
-			cm->allocated++;
-			cm->available--;
-			m->total_allocated++;
-			m->global_available--;
-			if (reserved)
-				m->global_reserved--;
-			*mapped_cpu = best_cpu;
-			trace_irq_matrix_alloc(bit, best_cpu, m, cm);
-			return bit;
-		}
-	}
-	return -ENOSPC;
 }
 
 /**
