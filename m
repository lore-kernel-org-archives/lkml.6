Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E696CC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDD320652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDD320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeJWKOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:14:48 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:39826
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbeJWKOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:14:48 -0400
X-Greylist: delayed 676 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2018 06:14:47 EDT
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ElhFgTHw6CT0vElhFgtcMA; Mon, 22 Oct 2018 18:41:25 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1gElhF-00048x-EW; Mon, 22 Oct 2018 18:41:25 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH] Choose CPU based on allocated IRQs
Date:   Tue, 23 Oct 2018 01:40:44 +0000
Message-Id: <20181023014044.15888-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfJllns5Ec/1NuvHl4RswYpC+FtOtcfOynHRxFqc5wr0+AoCgJGcyBNegFmDB6z6FwmwvVioRGeCGsnx8UQ8srRO0sx2lPXxHHve75Dbpvm2nuJGvMRgd
 EAgl5p9A13QIkHqq7ELswR+YXxOYf/f98ZXg6wG41Uu/aJalf0sXZFachBvc2Y6H3kq1HIleYzDILcqDEwzgy92+BRHiX+rsty3zTxSkwAyo2BFm5/4OH1j4
 ZQfoAzkpFxK0XKxjL8KBqoObZJ7p0+Uv4HuIcVlilb8R17AuxqvDLGdpUcqifpOo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

In irq_matrix, "available" is set when IRQs are allocated earlier in the IRQ
assigning process.

Later, when IRQs are activated those values are not good indicators of what
CPU to choose to assign to this IRQ.

Change to choose CPU for an IRQ based on how many IRQs are already allocated
on this CPU.

Signed-off-by: Long Li <longli@microsoft.com>
---
 kernel/irq/matrix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 6e6d467f3dec..a51689e3e7c0 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -128,7 +128,7 @@ static unsigned int matrix_alloc_area(struct irq_matrix *m, struct cpumap *cm,
 static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
 					const struct cpumask *msk)
 {
-	unsigned int cpu, best_cpu, maxavl = 0;
+	unsigned int cpu, best_cpu, min_allocated = UINT_MAX;
 	struct cpumap *cm;
 
 	best_cpu = UINT_MAX;
@@ -136,11 +136,11 @@ static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
 	for_each_cpu(cpu, msk) {
 		cm = per_cpu_ptr(m->maps, cpu);
 
-		if (!cm->online || cm->available <= maxavl)
+		if (!cm->online || cm->allocated > min_allocated)
 			continue;
 
 		best_cpu = cpu;
-		maxavl = cm->available;
+		min_allocated = cm->allocated;
 	}
 	return best_cpu;
 }
-- 
2.14.1

