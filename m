Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF3CECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4BB2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aTgk1rfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4BB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeJRR5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:57:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53116 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeJRR5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:57:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181018095717euoutp0111210dd8069639dc7b4488c71f5a1527~eq3QTbLOQ0107701077euoutp01Z;
        Thu, 18 Oct 2018 09:57:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181018095717euoutp0111210dd8069639dc7b4488c71f5a1527~eq3QTbLOQ0107701077euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539856637;
        bh=zJetpoNhW01GT4Xt0gk6SKTpHAA/tdY/kH9zyQ9f4Ok=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=aTgk1rfPeEW8tqfWTdwSg4TZQyK0mLQm3GVknpbI4DBOGG3NTEGMKLpylEnTksvV/
         CVhXhn0S/KQgn+iD8KChOBSjDnCd2GxjMJsqmDUT2rw7p7sAlXfQaXUOtN3aEjB0ZI
         QTeXf7NYERUX/YClBqN1+KjwT+ZVGdSHIM636Wfw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018095717eucas1p2f656677dcc7d03550eb6c8ca5f12f8a5~eq3PyTstY2351323513eucas1p2E;
        Thu, 18 Oct 2018 09:57:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9D.D1.04294.CF858CB5; Thu, 18
        Oct 2018 10:57:16 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018095716eucas1p192004241424d1cf581f715558b2e67a4~eq3O6tUM92351723517eucas1p1G;
        Thu, 18 Oct 2018 09:57:16 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-fb-5bc858fcf29a
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AB.D2.04284.CF858CB5; Thu, 18
        Oct 2018 10:57:16 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGS00GLZGZA2H50@eusync3.samsung.com>;
        Thu, 18 Oct 2018 10:57:16 +0100 (BST)
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
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 1/6] clocksource: exynos_mct: Remove dead code
Date:   Thu, 18 Oct 2018 11:57:03 +0200
Message-id: <20181018095708.1527-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181018095708.1527-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7djP87p/Ik5EG/xeYWCxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoErY9cq24LJfBV7GhvYGhgfcncxcnJICJhINK84xg5iCwmsYJRoWiLbxcgFZH9m
        lJjy9y4jTNGKZ9uZIYqWMUr8+JYAUdTAJPF3wwk2kASbgKFE19suMFtEIFui8/EDRpAiZoGT
        zBL/bm4CWyEs4Cjx5PZbFhCbRUBV4tnZFrA4r4CNxLGZb5ggtslLrN5wAGwbp4CtxJn571hA
        BkkIHGGTuPehhQWiyEVi+s3NzBC2sMSr41vYIWwZic6Og0wQDc2MEu0zZrFDOD2MElvn7GCD
        qLKWOHz8IiuIzSzAJzFp23SgSRxAcV6JjjYhiBIPicUf1zBD/DmBUeLR2uOsExglFzAyrGIU
        Ty0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAiM69P/jn/ZwbjrT9IhRgEORiUe3gepx6OFWBPL
        iitzDzFKcDArifBWm52IFuJNSaysSi3Kjy8qzUktPsQozcGiJM67bN7GaCGB9MSS1OzU1ILU
        IpgsEwenVAOj97Lugmszlv5WKpisxaUXGyimI3qdecfu23eFRBWXy674uVTtuIFy5bofn8IW
        8fye9nlfUGZYD6uSqYaz4hrpXNmCFzLm6xxm3ard2dVkFLw0Zs3F3bLd7xc8TZBomhZpqtsg
        JiX3auXtuGMmqf+npy2b/9E2IY73y1pHoUmvbKUuT+rN3H1TiaU4I9FQi7moOBEAP1J9oecC
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t/xq7p/Ik5EG6x5wm6xccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoErY9cq24LJfBV7GhvYGhgfcncxcnJICJhIrHi2nbmLkYtDSGAJo8SWif1sEE4T
        k0TXzkYWkCo2AUOJrrddbCC2iEC2xPy93ewgRcwCJ5klLj1+B1YkLOAo8eT2WzCbRUBV4tnZ
        FnYQm1fARuLYzDdMEOvkJVZvOMAMYnMK2EqcmQ/RKwRU0/1nPfsERp4FjAyrGEVSS4tz03OL
        DfWKE3OLS/PS9ZLzczcxAkNy27Gfm3cwXtoYfIhRgINRiYf3QerxaCHWxLLiytxDjBIczEoi
        vNVmJ6KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8543qIwSEkhPLEnNTk0tSC2CyTJxcEo1MKZq
        PuTX/TtZ9fS+w/scdumf6dGIScmIV647EvDz06voB3KCcRa5Yj8UD7Y+stQRKGEycHr/xOy+
        /EznnJCDeq+9NinrTRQ5vjgrvfPftdMzzOcs9Evf+71P9duDx1G376iF7PWSTHr7vLVE6m/+
        hMVbDh42l/Dfl8DxJnrJr5cObtNOKVc7hCqxFGckGmoxFxUnAgBdwqAyRQIAAA==
X-CMS-MailID: 20181018095716eucas1p192004241424d1cf581f715558b2e67a4
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018095716eucas1p192004241424d1cf581f715558b2e67a4
References: <20181018095708.1527-1-m.szyprowski@samsung.com>
        <CGME20181018095716eucas1p192004241424d1cf581f715558b2e67a4@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos Multi-Core Timer driver is used only on device-tree based
systems, so remove non-dt related code. In case of !CONFIG_OF
the code is anyway equal because of_irq_count() has a stub
returning 0. Device node pointer is always provided when driver
has been probed from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..ef18bbf8d20c 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -507,13 +507,12 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	int err, cpu;
 	struct clk *mct_clk, *tick_clk;
 
-	tick_clk = np ? of_clk_get_by_name(np, "fin_pll") :
-				clk_get(NULL, "fin_pll");
+	tick_clk = of_clk_get_by_name(np, "fin_pll");
 	if (IS_ERR(tick_clk))
 		panic("%s: unable to determine tick clock rate\n", __func__);
 	clk_rate = clk_get_rate(tick_clk);
 
-	mct_clk = np ? of_clk_get_by_name(np, "mct") : clk_get(NULL, "mct");
+	mct_clk = of_clk_get_by_name(np, "mct");
 	if (IS_ERR(mct_clk))
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
@@ -581,11 +580,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	 * timer irqs are specified after the four global timer
 	 * irqs are specified.
 	 */
-#ifdef CONFIG_OF
 	nr_irqs = of_irq_count(np);
-#else
-	nr_irqs = 0;
-#endif
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
-- 
2.17.1

