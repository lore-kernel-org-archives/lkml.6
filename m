Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4595FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D114218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfAXNia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:38:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727556AbfAXNia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:38:30 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6AC12CF927D2602464EB;
        Thu, 24 Jan 2019 21:38:28 +0800 (CST)
Received: from linux-fhAnjn.huawei.com (10.175.104.222) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Thu, 24 Jan 2019 21:38:18 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <wanghaibin.wang@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH v2] irqchip/gic-v4: fix occasional VLPI drop
Date:   Thu, 24 Jan 2019 21:37:08 +0800
Message-ID: <1548337028-21801-1-git-send-email-guoheyi@huawei.com>
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
programming gets left in and causes memory corrupting. A new function
its_clear_vpend_valid() is added to reuse the code in
its_vpe_deschedule().

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Heyi Guo <heyi.guo@linaro.org>
---

Notes:
    v2:
    - Also wait GICR_VPENDBASER.Dirty bit to be 0 in initialization [Marc]
    - Add a new function to reuse the code in its_vpe_deschedule() [Marc]

 drivers/irqchip/irq-gic-v3-its.c | 66 +++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3365d44..531e945 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2060,6 +2060,29 @@ static int __init allocate_lpi_tables(void)
 	return 0;
 }
 
+static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
+{
+	u32 count = 1000000;	/* 1s! */
+	bool clean;
+	u64 val;
+
+	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+	val &= ~GICR_VPENDBASER_Valid;
+	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	do {
+		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+		clean = !(val & GICR_VPENDBASER_Dirty);
+		if (!clean) {
+			count--;
+			cpu_relax();
+			udelay(1);
+		}
+	} while (!clean && count);
+
+	return val;
+}
+
 static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
@@ -2145,6 +2168,30 @@ static void its_cpu_init_lpis(void)
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
+		val = its_clear_vpend_valid(vlpi_base);
+		WARN_ON(val & GICR_VPENDBASER_Dirty);
+	}
+
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
@@ -2757,26 +2804,11 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 static void its_vpe_deschedule(struct its_vpe *vpe)
 {
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
-	u32 count = 1000000;	/* 1s! */
-	bool clean;
 	u64 val;
 
-	/* We're being scheduled out */
-	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
-	val &= ~GICR_VPENDBASER_Valid;
-	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
-
-	do {
-		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
-		clean = !(val & GICR_VPENDBASER_Dirty);
-		if (!clean) {
-			count--;
-			cpu_relax();
-			udelay(1);
-		}
-	} while (!clean && count);
+	val = its_clear_vpend_valid(vlpi_base);
 
-	if (unlikely(!clean && !count)) {
+	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
 		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
 		vpe->idai = false;
 		vpe->pending_last = true;
-- 
1.8.3.1

