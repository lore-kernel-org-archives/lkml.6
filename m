Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8E7ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437EF21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kQqw06VZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437EF21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJQViI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:38:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37386 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQVhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:37:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181017134208euoutp02d4a410fdf8256252a1865accb1ba45c9~eaSR9I68r1192811928euoutp02o;
        Wed, 17 Oct 2018 13:42:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181017134208euoutp02d4a410fdf8256252a1865accb1ba45c9~eaSR9I68r1192811928euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539783728;
        bh=oel99Mp9meQQ4+STkZabHx/+KTVTtlGBaiezJPYNJsY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=kQqw06VZBtPPZCP663Qs5jxm9kqRAeG0pi26bcNe061EGneUTsgli8NT50+hX2xSt
         N/GIpnz0/7sajk6KlQwSgtp6uvySPZ2WEVxyAFV/DYD5h6OHllKt8IRG5/TE8o5Jke
         6vHk/456+GM9m8iEdgBere9FLXIszAKqeJYfl7pw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134207eucas1p105a6fc6c211349ed1f213f0ac74092c1~eaSRZ34r21606816068eucas1p1b;
        Wed, 17 Oct 2018 13:42:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6E.4E.04441.F2C37CB5; Wed, 17
        Oct 2018 14:42:07 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3~eaSQn7isL1609216092eucas1p1A;
        Wed, 17 Oct 2018 13:42:06 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-96-5bc73c2f86cb
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AE.12.04128.E2C37CB5; Wed, 17
        Oct 2018 14:42:06 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ001A0WQ1IZ80@eusync4.samsung.com>;
        Wed, 17 Oct 2018 14:42:06 +0100 (BST)
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
Subject: [PATCH v3 3/6] clocksource: exynos_mct: Refactor resources
 allocation
Date:   Wed, 17 Oct 2018 15:41:56 +0200
Message-id: <20181017134159.9656-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181017134159.9656-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRb0gTcRjH/e1ud7fV4tgsf2kWDgoqnBlFl5oYBB2BaL1IbC905eG/bcrO
        WfqmhaltaZk1Hf6ZGmbhf885h4qahjMENQVtMLFYEQoluqyEtJyn7z4Pz+fh+/A8BCKdRgOJ
        dG0Oo9Oq1HJMjNrHNiZDw6KcyjOeWhHVZekQUitNJYCa//lNSFm9wVT5YhlKTU114hTnmRNS
        s301GGWZGhRQbe8WcGrTvYVR3ZwZoZZWx9EYCd1qbQU012zEaPfcAEb/mJzE6e7G+/QTWzOg
        vdzRePyWOCqFUafnMrqw6GRx2p+VDiy7FN57OF0lMIB5mQmICEiegzMFy7gJiAkp+QZAS+8a
        4AsvgP3GNnTPWiqeQPhGE4AVQy92LYMAjj7bxH0WRoZD03cT5mN/MhMaPZ+AjxHyJQKHx3by
        ZGQ87GlvR3yMkseh4YFtx5GQUfCL3Szg047Bls7hbYcgROQl2PY035cFyQEM1s0U7250BZps
        rwDPMrjstOE8H4Gzzx+j/EABgMWWKpwvSgDsqXFgvBUJR50fhPx2B2C5vXInDZIS+KhIyis0
        dLsNu4cpA9Db4hKWgcP1wK8ZBDB6VpPKsOFa5q6CVWlYvTZVcSdLw4HtP09sOdccYH3m9ggg
        CSDfL3EcGlNKhapcNk8zAiCByP0l+SFOpVSSosrLZ3RZSTq9mmFHQBCBygMkTdYupZRMVeUw
        mQyTzej2ugJCFGgAjTfro8nYzx8zBvHr/aGxlHuw8pc5A9movigraGl37Yv42xBx1c//vc16
        4qSlPuhgokuBLMw6GsSrOcnGosK4a63uxLh1k+eGi7NVvw4JLE8u1L4F58cV/5J6YtI9CaFc
        6ZClYlRtDr7wW3+5q84e2Xe6t/us+WstsShNGEblKJumCj+F6FjVf3G8cCzjAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t/xa7p6NsejDToalCw2zljPavF+WQ+j
        xfUvz1kt5n2WtZh0fwKLxfnzG9gtNj2+xmpxedccNosZ5/cxWaw9cpfd4u+df2wWmzdNZbZ4
        +fEEiwOvx5p5axg9Nq3qZPO4c20Pm8e7c+fYPTYvqffo27KK0ePzJrkA9igum5TUnMyy1CJ9
        uwSujB/v17MV9EpUtFyYxdTAeF24i5GTQ0LAROJl+2nmLkYuDiGBJYwS6w83s0M4TUwSUyY+
        YASpYhMwlOh628UGYosIZEvM39vNDmIzCyxhlrh53wHEFhbwk5hx8xBYnEVAVaKhcQtYL6+A
        jcSTbVOZILbJS6zecABoGwcHp4CtxNr+KpCwEFDJy89zmSYw8ixgZFjFKJJaWpybnltspFec
        mFtcmpeul5yfu4kRGIbbjv3csoOx613wIUYBDkYlHt4dYseihVgTy4orcw8xSnAwK4nwVike
        jxbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe96gMkpIID2xJDU7NbUgtQgmy8TBKdXAyCrz44Dq
        3ESDm8+fW6xbGey3LkVkd+y7Ap/NKRLaTB+OT9tWGJahM2f3LraSzUlvwxbMPhN4qjHZ9uKc
        +i3+DUkSG8NO/oq3+hEXeuQ6s0rerOxcgxvMt1nzD5j5qMap8riFveOYKW3Ts5T38/nL9at2
        2WpEF3v6J71OmKD7p8L12M2Zd4RVlFiKMxINtZiLihMBsgbrDD8CAAA=
X-CMS-MailID: 20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3
References: <20181017134159.9656-1-m.szyprowski@samsung.com>
        <CGME20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move interrupts allocation from exynos4_timer_resources() into separate
function together with the interrupt number parsing code from
mct_init_dt(), so the code for managing interrupts is kept together.
While touching exynos4_timer_resources() function, move of_iomap() to it.
No functional changes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 49 +++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 49413900b24c..02ad55db390b 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -502,11 +502,14 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
+static int __init exynos4_timer_resources(struct device_node *np)
 {
-	int err, cpu;
 	struct clk *mct_clk, *tick_clk;
 
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: unable to ioremap mct address space\n", __func__);
+
 	tick_clk = of_clk_get_by_name(np, "fin_pll");
 	if (IS_ERR(tick_clk))
 		panic("%s: unable to determine tick clock rate\n", __func__);
@@ -517,9 +520,27 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
 
-	reg_base = base;
-	if (!reg_base)
-		panic("%s: unable to ioremap mct address space\n", __func__);
+	return 0;
+}
+
+static int __init exynos4_timer_interrupts(struct device_node *np,
+					   unsigned int int_type)
+{
+	int i, err, cpu;
+
+	mct_int_type = int_type;
+
+	/* This driver uses only one global timer interrupt */
+	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
+
+	/*
+	 * Find out the number of local irqs specified. The local
+	 * timer irqs are specified after the four global timer
+	 * irqs are specified.
+	 */
+	nr_irqs = of_irq_count(np);
+	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
+		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
 	if (mct_int_type == MCT_INT_PPI) {
 
@@ -579,24 +600,14 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 
 static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
-	u32 nr_irqs, i;
 	int ret;
 
-	mct_int_type = int_type;
-
-	/* This driver uses only one global timer interrupt */
-	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
+	ret = exynos4_timer_resources(np);
+	if (ret)
+		return ret;
 
-	/*
-	 * Find out the number of local irqs specified. The local
-	 * timer irqs are specified after the four global timer
-	 * irqs are specified.
-	 */
-	nr_irqs = of_irq_count(np);
-	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
-		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
-	ret = exynos4_timer_resources(np, of_iomap(np, 0));
+	ret = exynos4_timer_interrupts(np, int_type);
 	if (ret)
 		return ret;
 
-- 
2.17.1

