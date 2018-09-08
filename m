Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DBC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 07:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FB8206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 07:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="phERi2AM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FB8206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeIHLrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 07:47:15 -0400
Received: from m12-17.163.com ([220.181.12.17]:57596 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbeIHLrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 07:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=4+VoZ0djJB2YGUEDKz
        3cEdCICv6LrzLq7yg2jO5KS6U=; b=phERi2AMlpxWrFDZ7NTRRrJaFn7EVn9W+P
        wseWFeyWWGG7MI52pHCDvBiiJXDG0ndXkSoOp7HSQYlwgpk0TEPSsWjWJ5WoYfHF
        2xKaXhH+FOBbsPm0DFrjVuI6DZuqVGvfRhv6kPTdqIN6epqKWg0Ne9sDhfq73iCo
        e4JXHI+qI=
Received: from localhost.localdomain (unknown [49.65.59.196])
        by smtp13 (Coremail) with SMTP id EcCowACndQqfc5Nb2qF5DQ--.34S4;
        Sat, 08 Sep 2018 15:01:16 +0800 (CST)
From:   Dou Liyang <dou_liyang@163.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com
Subject: [PATCH v2 1/2] irq/matrix: Split out the CPU finding code into a helper
Date:   Sat,  8 Sep 2018 15:00:36 +0800
Message-Id: <20180908070037.31154-1-dou_liyang@163.com>
X-Mailer: git-send-email 2.14.3
X-CM-TRANSID: EcCowACndQqfc5Nb2qF5DQ--.34S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1fKF13GFWxCryxGFW8Xrb_yoW5XryDpr
        s7Kr1avr4UX3WIgw13tayDJFySvw1kXFs5Kw4Svr1SvFWxXr1aqr10vryUZFyUGF95Ca4j
        yF90qr18Ca1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jv6wZUUUUU=
X-Originating-IP: [49.65.59.196]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiMR27olUMHupwJwAAsP
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
Changelog v2 --> v1

 -Avoid a churn and the extra indentation suggested by tglx

 kernel/irq/matrix.c | 60 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 5092494bf261..0cbcdef9337a 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -124,6 +124,26 @@ static unsigned int matrix_alloc_area(struct irq_matrix *m, struct cpumap *cm,
 	return area;
 }
 
+/* Find the best CPU which has the lowest vector allocation count */
+static int matrix_find_best_cpu(struct irq_matrix *m,
+				const struct cpumask *msk, int *best_cpu)
+{
+	unsigned int cpu, maxavl = 0;
+	struct cpumap *cm;
+
+	for_each_cpu(cpu, msk) {
+		cm = per_cpu_ptr(m->maps, cpu);
+
+		if (!cm->online || cm->available <= maxavl)
+			continue;
+
+		*best_cpu = cpu;
+		maxavl = cm->available;
+	}
+
+	return maxavl;
+}
+
 /**
  * irq_matrix_assign_system - Assign system wide entry in the matrix
  * @m:		Matrix pointer
@@ -322,35 +342,25 @@ void irq_matrix_remove_reserved(struct irq_matrix *m)
 int irq_matrix_alloc(struct irq_matrix *m, const struct cpumask *msk,
 		     bool reserved, unsigned int *mapped_cpu)
 {
-	unsigned int cpu, best_cpu, maxavl = 0;
+	unsigned int best_cpu = UINT_MAX;
 	struct cpumap *cm;
 	unsigned int bit;
 
-	best_cpu = UINT_MAX;
-	for_each_cpu(cpu, msk) {
-		cm = per_cpu_ptr(m->maps, cpu);
-
-		if (!cm->online || cm->available <= maxavl)
-			continue;
-
-		best_cpu = cpu;
-		maxavl = cm->available;
-	}
+	if (!matrix_find_best_cpu(m, msk, &best_cpu))
+		return -ENOSPC;
 
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
+	cm = per_cpu_ptr(m->maps, best_cpu);
+	bit = matrix_alloc_area(m, cm, 1, false);
+	if (bit < m->alloc_end) {
+		cm->allocated++;
+		cm->available--;
+		m->total_allocated++;
+		m->global_available--;
+		if (reserved)
+			m->global_reserved--;
+		*mapped_cpu = best_cpu;
+		trace_irq_matrix_alloc(bit, best_cpu, m, cm);
+		return bit;
 	}
 	return -ENOSPC;
 }
-- 
2.14.3


