Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FACECDE37
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90EC2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ifijoEIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90EC2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJQVh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:37:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57640 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeJQVhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:37:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181017134208euoutp01ceba8569d860510361e51091384e9e6b~eaSSgAW3Q1251312513euoutp01D;
        Wed, 17 Oct 2018 13:42:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181017134208euoutp01ceba8569d860510361e51091384e9e6b~eaSSgAW3Q1251312513euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539783728;
        bh=5+5MtfY6OsS9nIIyl7W+JZvvkhN7JVG2GisE3EjsluE=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ifijoEISTcKrYxWpDkG7RbifMCK91rCLHBbTLbTNR6ZILwgrhMuCvuWmlvgnhJVAK
         GzlEW/qa2Sw8XOz6Uhj0cj/+piNGTDLwaYiAbAS4emPFU47omnxySO9skL6RAlIbWm
         orSnwH0UZxoGoeDb76Z7IzNtiAt9BgDebyNoadpg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017134207eucas1p2ddd72a7f9c9f8a6cfa44305722f2ad76~eaSR3wbLZ1291812918eucas1p24;
        Wed, 17 Oct 2018 13:42:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.4E.04441.F2C37CB5; Wed, 17
        Oct 2018 14:42:07 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134207eucas1p1b938eefe31fc47baaf538c9ebafc1a7e~eaSRGtc5e1609116091eucas1p1p;
        Wed, 17 Oct 2018 13:42:07 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-97-5bc73c2f66a6
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.22.04284.F2C37CB5; Wed, 17
        Oct 2018 14:42:07 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ001A0WQ1IZ80@eusync4.samsung.com>;
        Wed, 17 Oct 2018 14:42:07 +0100 (BST)
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
Subject: [PATCH v3 4/6] clocksource: exynos_mct: Add arch_timer cooperation
 mode for ARM64
Date:   Wed, 17 Oct 2018 15:41:57 +0200
Message-id: <20181017134159.9656-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181017134159.9656-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7djP87r6NsejDWbOUbHYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mubf0S5YxVWxYOJipgbGgxxdjJwcEgImEqubnzB3MXJxCAmsYJTYcG0HC4TzmVFizbyn
        LDBV0xY8g0osY5R4dHUblNPAJPHg10M2kCo2AUOJrrddYLaIQLZE5+MHjCA2s8AiZokDx4RB
        bGGBGIlzzz+CTWURUJXY+PYzE4jNK2AjMWfbGlaIbfISqzccALqJg4NTwFZibX8VyC4JgT1s
        Ej9+TmeEqHGR+HZwNTOELSzx6vgWdghbRqKz4yATREMzo0T7jFnsEE4Po8TWOTvYIKqsJQ4f
        v8gKcR2fxKRt08G2SQjwSnS0CUGUeEhceHCTEeLLCYwSG9fMYJ3AKLmAkWEVo3hqaXFuemqx
        YV5quV5xYm5xaV66XnJ+7iZGYDSf/nf80w7Gr5eSDjEKcDAq8fDuEDsWLcSaWFZcmXuIUYKD
        WUmEt0rxeLQQb0piZVVqUX58UWlOavEhRmkOFiVx3mXzNkYLCaQnlqRmp6YWpBbBZJk4OKUa
        GFvT3lxdsoX3wDdh3j5jSd/Tb8Klt4m2athN5U6t+hcX67pRLkT8kNf+FqGpM42uii7YZe87
        uzJA8MuelVn2Ma28y67NCFrFM//Q0WMex5i+zWNrK3XLOqGZm/pv5jsm/t612V9u7n++dd2P
        +bfieBW/aAmwujW0eQb8VBAu/Liqjy02YHWLtBJLcUaioRZzUXEiALv+u7ziAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVy+t/xa7r6NsejDY7vZ7PYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mubf0S5YxVWxYOJipgbGgxxdjJwcEgImEtMWPGPpYuTiEBJYwiix6cQWZginiUniwcYJ
        bCBVbAKGEl1vu8BsEYFsifl7u9lBbGaBJcwSN+87gNjCAjES555/ZAGxWQRUJTa+/cwEYvMK
        2EjM2baGFWKbvMTqDQeAFnBwcArYSqztrwIJCwGVvPw8l2kCI88CRoZVjCKppcW56bnFhnrF
        ibnFpXnpesn5uZsYgUG47djPzTsYL20MPsQowMGoxMO7Q+xYtBBrYllxZe4hRgkOZiUR3irF
        49FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEec8bVEYJCaQnlqRmp6YWpBbBZJk4OKUaGLt9a83L
        t2Qs6vrD/Nw8+GnnZlfZ/q267hftF5ic+FJ8sdlO66q1XKfw1xeapXXiMswyHQdMX2rMOhc6
        y5g94GOu+8WDCxNYNL//2iHO8sxiltnWiM8LyifV1R2s2ffhwh+Z2mlps46dO2z1Q1mYZ7Xb
        JDM3id/GGbypvb27TCfwyxv1XxX7rsRSnJFoqMVcVJwIAFVxb4w+AgAA
X-CMS-MailID: 20181017134207eucas1p1b938eefe31fc47baaf538c9ebafc1a7e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017134207eucas1p1b938eefe31fc47baaf538c9ebafc1a7e
References: <20181017134159.9656-1-m.szyprowski@samsung.com>
        <CGME20181017134207eucas1p1b938eefe31fc47baaf538c9ebafc1a7e@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
first configure and enable Exynos Multi-Core Timer, because they both
share some common hardware blocks (global system counter). This patch
adds a mode of cooperation with arch_timer driver, so kernel can use
CP15 based timer interface via arch_timer driver, which is mandatory
on ARM64. In such mode MCT driver only enables its clocks and starts
global timer. Everything else will be handled by arch_timer driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 02ad55db390b..1b19a4f03929 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -606,6 +606,15 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
+		struct device_node *np = of_find_compatible_node(NULL, NULL,
+							     "arm,armv8-timer");
+		if (np) {
+			of_node_put(np);
+			exynos4_mct_frc_start();
+			return 0;
+		}
+	}
 
 	ret = exynos4_timer_interrupts(np, int_type);
 	if (ret)
-- 
2.17.1

