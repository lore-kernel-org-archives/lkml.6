Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2730AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F240420861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfAWJAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:00:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfAWJAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:00:23 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 42158B0B4B805E195329;
        Wed, 23 Jan 2019 17:00:21 +0800 (CST)
Received: from linux-fhAnjn.huawei.com (10.175.104.222) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 17:00:14 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <wanghaibin.wang@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH] irqchip/gic-v4: fix occasional VLPI drop
Date:   Wed, 23 Jan 2019 16:59:08 +0800
Message-ID: <1548233948-7450-1-git-send-email-guoheyi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.222]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. In current implementation, every VLPI will temporarily be mapped to
the first CPU in system (normally CPU0) and then moved to the real
scheduled CPU later.

2. So there is a time window and a VLPI may be sent to CPU0 instead of
the real scheduled vCPU, in a multi-CPU virtual machine.

3. However, CPU0 may have not been scheduled as a virtual CPU after
system boots up, so the value of its GICR_VPROPBASER is unknown at
that moment.

4. If the INTID of VLPI is larger than 2^(GICR_VPROPBASER.IDbits+1),
while IDbits is also in unknown state, GIC will behave as if the VLPI
is out of range and simply drop it, which results in interrupt missing
in Guest.

As no code will clear GICR_VPROPBASER at runtime, we can safely
initialize the IDbits field at boot time for each CPU to get rid of
this issue.

We also clear Valid bit of GICR_VPENDBASER in case any ancient
programming gets left in and causes memory corrupting.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Heyi Guo <heyi.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3365d44..634c8a7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2145,6 +2145,31 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
+	if (gic_rdists->has_vlpis) {
+		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+
+		/*
+		 * It's possible for CPU to receive VLPIs before it is
+		 * sheduled as a vPE, especially for the first CPU, and the
+		 * VLPI with INTID larger than 2^(IDbits+1) will be considered
+		 * as out of range and dropped by GIC.
+		 * So we initialize IDbits to known value to avoid VLPI drop.
+		 */
+		val = (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
+		pr_debug("GICv4: CPU%d: Init IDbits to 0x%llx for GICR_VPROPBASER\n",
+			smp_processor_id(), val);
+		gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+
+		/*
+		 * Also clear Valid bit of GICR_VPENDBASER, in case some
+		 * ancient programming gets left in and has possibility of
+		 * corrupting memory.
+		 */
+		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+		val &= ~GICR_VPENDBASER_Valid;
+		gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+	}
+
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
-- 
1.8.3.1

