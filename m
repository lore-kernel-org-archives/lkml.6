Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAFDC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEEA2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hH+rmRAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEEA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJOURG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:17:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37110 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOUQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:16:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181015123137euoutp02959350a1d04b8d6962a3d0574a94aa65~dyCI95cyV0736707367euoutp02m;
        Mon, 15 Oct 2018 12:31:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181015123137euoutp02959350a1d04b8d6962a3d0574a94aa65~dyCI95cyV0736707367euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539606697;
        bh=dLPRR3RFOQ7kx3DZxcRUOiHe8ffhAjgtdf+LPKBKU48=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=hH+rmRAeBcnGYaAhI6Zj3nRvGl28IjbF0XOjv83X3GUp8K5EoTnR8kvb02F7g0bU9
         NvntQs4UiCjq6r5G99XIakWC8lYsUd+JwQwkmzJESfovX/NRQmYm56jLtX35vgKbC3
         nKAMcZ9Gtzr3ADd2b9tkWh+qduHROByTl20qJe/Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015123136eucas1p1eac06665ec0f052d8220f51f63d43e26~dyCIlCOG_1204612046eucas1p1o;
        Mon, 15 Oct 2018 12:31:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 29.DE.04294.8A884CB5; Mon, 15
        Oct 2018 13:31:36 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d~dyCH61tfm1990719907eucas1p1p;
        Mon, 15 Oct 2018 12:31:35 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-2b-5bc488a893a4
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.DE.04128.7A884CB5; Mon, 15
        Oct 2018 13:31:35 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGN00GZC4490K70@eusync1.samsung.com>;
        Mon, 15 Oct 2018 13:31:35 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH v2 3/6] clocksource: exynos_mct: Add arch_timer cooperation
 mode for ARM64
Date:   Mon, 15 Oct 2018 14:31:09 +0200
Message-id: <20181015123112.9379-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181015123112.9379-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7djPc7orOo5EGyy8KWqxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZcxefpi54IhyxeS2eWwNjHdluhg5OSQETCT+9n1m6mLk4hASWMEo8eDBbyaQhJDAZ0aJ
        G7/LYIpurJvNBhFfxijRucwboqGBSWLbyeOsIAk2AUOJrrddYEUiAtkSnY8fMILYzAKLmCUO
        HBMGsYUFYiR6HvxkBrFZBFQlDl/ZD1TDwcErYCNxfmsSxC55idUbDoCVcArYShz+v4oFZJeE
        wB42iXNdM9ggilwkfi3pZYewhSVeHd8CZctIXJ7cDdXQzCjRPmMWO4TTwyixdc4OqG5ricPH
        L7JCXMcnMWnbdGaQKyQEeCU62oQgSjwkXq9bwgbx5QRGiUMPFrNNYJRcwMiwilE8tbQ4Nz21
        2CgvtVyvODG3uDQvXS85P3cTIzCWT/87/mUH464/SYcYBTgYlXh4BXiORAuxJpYVV+YeYpTg
        YFYS4ZUIORQtxJuSWFmVWpQfX1Sak1p8iFGag0VJnHfZvI3RQgLpiSWp2ampBalFMFkmDk6p
        BsbVb1637b8+VSLlakmqk1PFop43elFCfJ1JHy/OKpG7LKz4dwGzZJ+41IxvXWxh32XkSzJ8
        3IP1Cm2v7xG6lhagvoixzev199cuwlWCG1J+RPsV3RIvNxcwPWdzMu9t8M+4AG3jz2ZJW4K/
        eORJ3LdyXxCTk5H2+up9rzJT/fqDrKpzLK+WK7EUZyQaajEXFScCADT6AJPhAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVy+t/xy7rLO45EG3R/NbDYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4MmYvP8xccES5YnLbPLYGxrsyXYycHBICJhI31s1mA7GFBJYwSnx/qtLFyAVkNzFJnL5+
        hREkwSZgKNH1tgusSEQgW2L+3m52EJtZYAmzxM37DiC2sECMRM+Dn8wgNouAqsThK/uBejk4
        eAVsJM5vTYLYJS+xesMBsBJOAVuJw/9XsUDstZG4cOwv4wRGngWMDKsYRVJLi3PTc4uN9IoT
        c4tL89L1kvNzNzECg3DbsZ9bdjB2vQs+xCjAwajEwyvAcyRaiDWxrLgy9xCjBAezkgivRMih
        aCHelMTKqtSi/Pii0pzU4kOM0hwsSuK85w0qo4QE0hNLUrNTUwtSi2CyTBycUg2MJes2fr3b
        qLd82jKhkncfTr26OvOh3wnnGc7P33//q77kpO/WjlPLOWafUVx5/WJ9l0GtIuOhD7qdWVzz
        7KfIMKSsbziyz027e8v1WauaorSuMXluE5U41Csw113Kre605kzDOl6lWw8/Pg66NuOpscu7
        jDBpa53J1XzHr531YPhm+2df7xrVGCWW4oxEQy3mouJEAGHAIBs+AgAA
X-CMS-MailID: 20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
first configure and enable Exynos Multi-Core Timer, because they both
share some common hardware blocks. This patch adds a mode of cooperation
with arch_timer driver, so kernel can use CP15 based timer interface via
arch_timer driver, which is mandatory on ARM64. In such mode driver only
configures MCT registers and starts the timer but don't register any
clocksource or events in the system. Those are left to be handled by
arch_timer driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 52 +++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index a379f11fad2d..06cd30a6d59a 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -57,6 +57,7 @@
 #define TICK_BASE_CNT	1
 
 enum {
+	MCT_INT_NONE = 0,
 	MCT_INT_SPI,
 	MCT_INT_PPI
 };
@@ -238,6 +239,9 @@ static int __init exynos4_clocksource_init(void)
 {
 	exynos4_mct_frc_start();
 
+	if (!mct_int_type)
+		return 0;
+
 #if defined(CONFIG_ARM)
 	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
 	exynos4_delay_timer.freq = clk_rate;
@@ -343,6 +347,9 @@ static struct irqaction mct_comp_event_irq = {
 
 static int exynos4_clockevent_init(void)
 {
+	if (!mct_int_type)
+		return 0;
+
 	mct_comp_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&mct_comp_device, clk_rate,
 					0xf, 0xffffffff);
@@ -476,12 +483,12 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 
 		irq_force_affinity(evt->irq, cpumask_of(cpu));
 		enable_irq(evt->irq);
-	} else {
+	} else if (mct_int_type == MCT_INT_PPI) {
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
-	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
-					0xf, 0x7fffffff);
-
+	if (mct_int_type)
+		clockevents_config_and_register(evt,
+			       clk_rate / (TICK_BASE_CNT + 1), 0xf, 0x7fffffff);
 	return 0;
 }
 
@@ -496,7 +503,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 		if (evt->irq != -1)
 			disable_irq_nosync(evt->irq);
 		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
-	} else {
+	} else if (mct_int_type == MCT_INT_PPI) {
 		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 	}
 	return 0;
@@ -529,7 +536,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 					 &percpu_mct_tick);
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
 		     mct_irqs[MCT_L0_IRQ], err);
-	} else {
+	} else if (mct_int_type == MCT_INT_SPI) {
 		for_each_possible_cpu(cpu) {
 			int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
 			struct mct_clock_event_device *pcpu_mevt =
@@ -564,7 +571,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 out_irq:
 	if (mct_int_type == MCT_INT_PPI) {
 		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
-	} else {
+	} else if (mct_int_type == MCT_INT_SPI) {
 		for_each_possible_cpu(cpu) {
 			struct mct_clock_event_device *pcpu_mevt =
 				per_cpu_ptr(&percpu_mct_tick, cpu);
@@ -585,17 +592,28 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 
 	mct_int_type = int_type;
 
-	/* This driver uses only one global timer interrupt */
-	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
+	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
+		struct device_node *np = of_find_compatible_node(NULL, NULL,
+							     "arm,armv8-timer");
+		if (np) {
+			mct_int_type = MCT_INT_NONE;
+			of_node_put(np);
+		}
+	}
 
-	/*
-	 * Find out the number of local irqs specified. The local
-	 * timer irqs are specified after the four global timer
-	 * irqs are specified.
-	 */
-	nr_irqs = of_irq_count(np);
-	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
-		mct_irqs[i] = irq_of_parse_and_map(np, i);
+	if (mct_int_type) {
+		/* This driver uses only one global timer interrupt */
+		mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
+
+		/*
+		 * Find out the number of local irqs specified. The local
+		 * timer irqs are specified after the four global timer
+		 * irqs are specified.
+		 */
+		nr_irqs = of_irq_count(np);
+		for (i = MCT_L0_IRQ; i < nr_irqs; i++)
+			mct_irqs[i] = irq_of_parse_and_map(np, i);
+	}
 
 	ret = exynos4_timer_resources(np, of_iomap(np, 0));
 	if (ret)
-- 
2.17.1

