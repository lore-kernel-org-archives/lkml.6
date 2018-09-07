Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB761C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAD72075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WzFJUeU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAD72075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeIGNFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:05:46 -0400
Received: from m12-13.163.com ([220.181.12.13]:45793 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbeIGNFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=XkCVdkX5o+KHdXvAbf
        fjCJ8+EVUj1VcfL/SxL83a3NQ=; b=WzFJUeU8zZkqHfVuhTqQFJ3KhYveQ6ATrp
        8SXGcCzABt5umEYiQs/Sq2vIR9GwSKMOrT9T8v+3a5wBn88Hbv9laGW9Lw9woH6q
        2FAG0ZX98QXYSvtXmuXzywkPdCwc+igPQe5aL0dllL97nYyJ3Lqj2C5E+DAFnomC
        q9v3/VigM=
Received: from localhost.localdomain (unknown [49.65.59.196])
        by smtp9 (Coremail) with SMTP id DcCowABHrooFNpJbiI7ZIg--.39791S4;
        Fri, 07 Sep 2018 16:25:41 +0800 (CST)
From:   Dou Liyang <dou_liyang@163.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com
Subject: [PATCH 1/2] irq/matrix: Split out the CPU finding code into a helper
Date:   Fri,  7 Sep 2018 16:25:08 +0800
Message-Id: <20180907082509.11083-1-dou_liyang@163.com>
X-Mailer: git-send-email 2.14.3
X-CM-TRANSID: DcCowABHrooFNpJbiI7ZIg--.39791S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1DAw17WF4DCF17CryfWFg_yoW8ZrWfpr
        4UCw1a9r4UX3Wagw13taykJr9ayw1kXFn5tw4avr1SvF97Xr1aqr1jvryUZF1UWFZ5CayY
        kF90qr1kGw48JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jy388UUUUU=
X-Originating-IP: [49.65.59.196]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiIAW6olWBjPk2OQAAsT
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
 kernel/irq/matrix.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 5092494bf261..5eb0c8b857f0 100644
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
@@ -322,22 +342,11 @@ void irq_matrix_remove_reserved(struct irq_matrix *m)
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
-
-	if (maxavl) {
+	if (matrix_find_best_cpu(m, msk, &best_cpu)) {
 		cm = per_cpu_ptr(m->maps, best_cpu);
 		bit = matrix_alloc_area(m, cm, 1, false);
 		if (bit < m->alloc_end) {
-- 
2.14.3


