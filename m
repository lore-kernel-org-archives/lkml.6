Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD87C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 18:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172A92086C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 18:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GBxBORGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172A92086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeIHWqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 18:46:36 -0400
Received: from m12-17.163.com ([220.181.12.17]:35740 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbeIHWqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 18:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=8ZeKYwXzx3KXfXUqyO
        KWSCeIeKJVfVOZ9RSbEgkrtQU=; b=GBxBORGscPYduUFrPBBSZvcJGoWUPw4aLW
        klnPiU8Umljc5EMRf8TqDS1DWf3CkggvfEHi1EV9tfyLRKL8ILg9GVTBMsXUs/RO
        O2Pfj29Y/gUxzdKivvvyOr0O61oV4HXs4jJvFssQT02r0AJRm70+ys+mFA2b1vAk
        CxyXKOucU=
Received: from localhost.localdomain (unknown [49.65.59.196])
        by smtp13 (Coremail) with SMTP id EcCowAA3HDLYDZRboDKXDQ--.70S4;
        Sun, 09 Sep 2018 01:59:02 +0800 (CST)
From:   Dou Liyang <dou_liyang@163.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com
Subject: [PATCH v3 1/2] irq/matrix: Split out the CPU finding code into a helper
Date:   Sun,  9 Sep 2018 01:58:37 +0800
Message-Id: <20180908175838.14450-1-dou_liyang@163.com>
X-Mailer: git-send-email 2.14.3
X-CM-TRANSID: EcCowAA3HDLYDZRboDKXDQ--.70S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1fKF13GFWxCryxWF4DJwb_yoW5Wr4Upr
        4kCr1avr4UX3W2gw13taykJFyfZw1kXFs5Kw4avr1SvFZ7Xr1agr1jvryUZFy8GF95Ca4j
        yF98Xr18CF4UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jQjjDUUUUU=
X-Originating-IP: [49.65.59.196]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiMQa7olUMHvEq5wAAsV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

Linux finds the CPU which has the lowest vector allocation count to spread
out the non managed interrupt across the possible target CPUs.

This common CPU finding code will also be used in managed case,

So Split it out into a helper for preparation.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
Changelog v3 --> v2

 - Make the matrix_find_best_cpu() simple and obvious suggested by tglx
 - Remove the indentation totally suggested by tglx

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
-- 
2.14.3


