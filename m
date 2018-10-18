Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47987ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058A92083E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="krfirxAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058A92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeJRR6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:58:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53145 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeJRR5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:57:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181018095719euoutp011b840002f9645bdc3babcb8f38f7bdc4~eq3R1SW150108101081euoutp01U;
        Thu, 18 Oct 2018 09:57:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181018095719euoutp011b840002f9645bdc3babcb8f38f7bdc4~eq3R1SW150108101081euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539856639;
        bh=7RzFxofNGfgWBQtiHbTFe9TEVqpCi1g2karnmb1X59I=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=krfirxAzO7Qq5s/ssVN+WwSU3qIg0R/JW2QqcVPuuVdbjb6OZgXY+JXsg/etwYgza
         spT2ReJCudf3/zRXmgQNZCwri4td8ZebkrQIx0Au62PDD5jkGVu8LLuph2IggccQlW
         VjMWdDmrMWh0V8+B8+BeD3DoXHRuPBgadnre/9GU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018095718eucas1p195d0397d91b2620e70fb24d070d38f04~eq3RR8IuI2351723517eucas1p1L;
        Thu, 18 Oct 2018 09:57:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.B1.04806.EF858CB5; Thu, 18
        Oct 2018 10:57:18 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018095717eucas1p20a7d2d2b1b18ae60a4893a8e3d8c19f9~eq3Qh5W422119521195eucas1p2U;
        Thu, 18 Oct 2018 09:57:17 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-b4-5bc858fe9a3d
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.C2.04128.DF858CB5; Thu, 18
        Oct 2018 10:57:17 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGS00GLZGZA2H50@eusync3.samsung.com>;
        Thu, 18 Oct 2018 10:57:17 +0100 (BST)
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
Subject: [PATCH v4 4/6] clocksource: exynos_mct: Add arch_timer cooperation
 mode for ARM64
Date:   Thu, 18 Oct 2018 11:57:06 +0200
Message-id: <20181018095708.1527-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181018095708.1527-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7djPc7r/Ik5EG9w6IGaxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoEro3lVcMFC7opt1/cxNjCu5Oxi5OCQEDCR2LU/v4uRi0NIYAWjxJ9nB1ggnM+M
        ErMvzGLuYuQEK1o/8w1UYhmjxNulC6GcBiaJna2PWUCq2AQMJbredrGB2CIC2RKdjx8wghQx
        C5xklvh3cxM7yD5hgRiJN/tjQGpYBFQlVr2fxAwS5hWwkZjf5gOxTF5i9YYDYIs5BWwlzsx/
        B7ZLQuAEm8SJZRdZIIpcJOa8/gp1nbDEq+Nb2CFsGYnLk7uhGpoZJdpnzGKHcHoYJbbO2cEG
        UWUtcfj4RVYQm1mAT2LStunMkMDglehoE4Io8ZCYeHkJI8SXExglzt1YwTSBUXIBI8MqRvHU
        0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwKg+/e/41x2M+/4kHWIU4GBU4uF9kHo8Wog1say4
        MvcQowQHs5IIb7XZiWgh3pTEyqrUovz4otKc1OJDjNIcLErivMvmbYwWEkhPLEnNTk0tSC2C
        yTJxcEo1MCYE8N0If+Fw4W1yoO0Ox2vcsi8XNovtqw5nyqzxdZ+ekll6W+yosMHCv/KvzL5F
        Nizmv3fD5YT1y86FwSGqD2eLrHD0+GIZf/xqxqlVCp8cLgXc/dI++dpWYZGf2o1nDl1+VrPh
        17vef+Y7T/vrTLR7c0DrwrUJGoXv278eP+414YeGZ+q/i6eUWIozEg21mIuKEwELsIgY5gIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsVy+t/xq7p/I05EGxz/YGKxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoEro3lVcMFC7opt1/cxNjCu5Oxi5OSQEDCRWD/zDUsXIxeHkMASRokpb3czQjhN
        TBJX3qxlB6liEzCU6HrbxQZiiwhkS8zf280OUsQscJJZ4tLjd0DtHBzCAjESb/bHgNSwCKhK
        rHo/iRkkzCtgIzG/zQdimbzE6g0HmEFsTgFbiTPzQTo5gXbZSHT/Wc8+gZFnASPDKkaR1NLi
        3PTcYiO94sTc4tK8dL3k/NxNjMBw3Hbs55YdjF3vgg8xCnAwKvHwPkg9Hi3EmlhWXJl7iFGC
        g1lJhLfa7ES0EG9KYmVValF+fFFpTmrxIUZpDhYlcd7zBpVRQgLpiSWp2ampBalFMFkmDk6p
        Bkb3bVcfTa+Zu+WtUOMefcEJOj9uTDpg6nNZXTs+4jj7wcP/9qS926Dk7P5E9Puchh72m5es
        +H7u8OqUkGj7Wa/Ump90s7riQMirQ1VPGUubHXe5mN4+/O5idjvjl6OZihEVUyWO2517V2l5
        rObTAtmyNXW+qTpfa+0C9vXN2eHT/3DFg2sNub5KLMUZiYZazEXFiQC2MYxoQwIAAA==
X-CMS-MailID: 20181018095717eucas1p20a7d2d2b1b18ae60a4893a8e3d8c19f9
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018095717eucas1p20a7d2d2b1b18ae60a4893a8e3d8c19f9
References: <20181018095708.1527-1-m.szyprowski@samsung.com>
        <CGME20181018095717eucas1p20a7d2d2b1b18ae60a4893a8e3d8c19f9@eucas1p2.samsung.com>
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
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 4c886ff2941a..1f5249fb25fd 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -606,6 +606,16 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
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
+
 	ret = exynos4_timer_interrupts(np, int_type);
 	if (ret)
 		return ret;
-- 
2.17.1

