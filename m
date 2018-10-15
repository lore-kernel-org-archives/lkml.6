Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B7C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E37120652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hzieEwHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E37120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeJOUQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:16:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51540 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeJOUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:16:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181015123136euoutp01f8f16327ec9e5fcc6111a2bd66984e0b~dyCIhAdf20681706817euoutp01i;
        Mon, 15 Oct 2018 12:31:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181015123136euoutp01f8f16327ec9e5fcc6111a2bd66984e0b~dyCIhAdf20681706817euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539606696;
        bh=cse+VOAcgPmNGKk2EiPdVIoBwnoLUK7Ug9Nh0R0rQ0I=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=hzieEwHKdRa1jnW2qU+jETDgRm8gMH4DoyIeC76q2U5TE4YRGS5pVRBEpz20q8Mdp
         8ePV+nAfQcqIBHUclhr5jxg6fbOLJ4QcRgoT/G7pyMmVv79w93J7lFScO4o6ZBtj93
         Ua8Jl+YGefuIzjhpSh8j1bNx0S6XeM7MAngh8MlE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181015123136eucas1p23e5fa00af4b528e2e093ab9b12a19347~dyCIFpbMe2085720857eucas1p2f;
        Mon, 15 Oct 2018 12:31:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6C.6F.04806.7A884CB5; Mon, 15
        Oct 2018 13:31:35 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015123135eucas1p18df135504c9476cead8da6463226cdec~dyCHW-NcF1986619866eucas1p1v;
        Mon, 15 Oct 2018 12:31:35 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-91-5bc488a7f632
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.DE.04128.7A884CB5; Mon, 15
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
Subject: [PATCH v2 2/6] clocksource: exynos_mct: Fix error path in timer
 resources initialization
Date:   Mon, 15 Oct 2018 14:31:08 +0200
Message-id: <20181015123112.9379-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181015123112.9379-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7djP87rLO45EG5xsMrLYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mg4umcdY0M9VcWL2dvYGxoMcXYycHBICJhKz7k1i6mLk4hASWMEosXjuPmYI5zOjxKTJ
        79lhqk7vXwaVWMYosXDaChYIp4FJYtvJ46wgVWwChhJdb7vYQGwRgWyJzscPGEFsZoFFzBIH
        jgmD2MICyRL3r68HinNwsAioSnzfB3YGr4CNxJ8v+1gglslLrN5wgBnE5hSwlTj8fxXYLgmB
        A2wSGyctYoMocpHYdqATyhaWeHV8C9SlMhKXJ3dDNTQzSrTPmMUO4fQwSmydswOqw1ri8PGL
        rBDX8UlM2jadGeQiCQFeiY42IYgSD4kJqxdCvTyBUeLJii+sExglFzAyrGIUTy0tzk1PLTbO
        Sy3XK07MLS7NS9dLzs/dxAiM59P/jn/dwbjvT9IhRgEORiUeXgGeI9FCrIllxZW5hxglOJiV
        RHglQg5FC/GmJFZWpRblxxeV5qQWH2KU5mBREuddNm9jtJBAemJJanZqakFqEUyWiYNTqoFx
        Q4hB4Hr2F2Hb9s/ac+164xyO3imO/zZUX06+9mnL7l8LnhU6zpx9dFftqW+atur39N66v9Pq
        fPX77LwtF1cLrPv9dklf7HvluPDWfYsdY5cIPSj8xxvL81vz+5mDNotm3DTMsFp+LuREtfbH
        twfW1OybufWLx7QMRum389fN7bu4hZu18uul8uVKLMUZiYZazEXFiQCf2oQb4wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t/xy7rLO45EG3z6zm+xccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZRxcMo+xoJ+r4sTs7ewNjAc5uhg5OSQETCRO71/G3MXIxSEksIRR4smfW2wQThOTxOnr
        VxhBqtgEDCW63naxgdgiAtkS8/d2s4PYzAJLmCVu3ncAsYUFkiXuX18PVM/BwSKgKvF9H9gC
        XgEbiT9f9rFALJOXWL3hADOIzSlgK3H4/yqwuBBQzYVjfxknMPIsYGRYxSiSWlqcm55bbKRX
        nJhbXJqXrpecn7uJERiG24793LKDsetd8CFGAQ5GJR5eAZ4j0UKsiWXFlbmHGCU4mJVEeCVC
        DkUL8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCeWJKanZpakFoEk2Xi4JRqYJxf3PB0
        obOzjvIEf+8NS5eJrpundEyD5WHSpKuqU55+vZUtarC7zu+CzPED1pNXeJxZN3VTaErCxtj/
        Dbnyobs9KjYtmTupR0SuuFTx8IP5uoLFr17+rX7RXax368eUq6XL9l8V3dX2nTv75o3GgvLi
        eAPj2M9Gn6Zk72f69uv4gX2cijySF74qsRRnJBpqMRcVJwIAH7huSz8CAAA=
X-CMS-MailID: 20181015123135eucas1p18df135504c9476cead8da6463226cdec
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015123135eucas1p18df135504c9476cead8da6463226cdec
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123135eucas1p18df135504c9476cead8da6463226cdec@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While freeing interrupt handlers in error path, don't assume that all
requested interrupts are per-processor interrupts and properly release
standard interrupts too.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 43b335ff4a96..a379f11fad2d 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -562,7 +562,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	return 0;
 
 out_irq:
-	free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	if (mct_int_type == MCT_INT_PPI) {
+		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	} else {
+		for_each_possible_cpu(cpu) {
+			struct mct_clock_event_device *pcpu_mevt =
+				per_cpu_ptr(&percpu_mct_tick, cpu);
+
+			if (pcpu_mevt->evt.irq != -1) {
+				free_irq(pcpu_mevt->evt.irq, pcpu_mevt);
+				pcpu_mevt->evt.irq = -1;
+			}
+		}
+	}
 	return err;
 }
 
-- 
2.17.1

