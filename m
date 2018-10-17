Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37959ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44472150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vK4GJoe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44472150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJQViW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:38:22 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57629 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJQVhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:37:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181017134207euoutp0129c077156823e2c56f9087c500c86609~eaSRa75CD1247812478euoutp01C;
        Wed, 17 Oct 2018 13:42:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181017134207euoutp0129c077156823e2c56f9087c500c86609~eaSRa75CD1247812478euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539783727;
        bh=23R/J6B8yoCfPOWlxldxP5D7mXL7n7ZMaMuWjzEhIWQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=vK4GJoe0lqjIm5ziF9DFt545bus3f0k0FiWc9s8fZmceiC/LW1OUsEfvcnVQ5wbeG
         u0KJjuUuDPtStaxCSylPMvAOFlO1vslhgpLrpTP0I3sO5UUKjYw9e9JARhjaDVVnei
         9qQiclf/0/BZumD7TMlfpwyYi4bFAuwWcs9cNwd8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017134206eucas1p225968760428d7ad78a8ca89943294b73~eaSQ2Fg2T1242212422eucas1p23;
        Wed, 17 Oct 2018 13:42:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CC.4E.04441.E2C37CB5; Wed, 17
        Oct 2018 14:42:06 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134206eucas1p1caf7cdec20ec620a5bf52fb9e060a7de~eaSQFvfjE1608716087eucas1p1Y;
        Wed, 17 Oct 2018 13:42:06 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-90-5bc73c2e1115
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3D.12.04128.D2C37CB5; Wed, 17
        Oct 2018 14:42:06 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ001A0WQ1IZ80@eusync4.samsung.com>;
        Wed, 17 Oct 2018 14:42:05 +0100 (BST)
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
Subject: [PATCH v3 2/6] clocksource: exynos_mct: Fix error path in timer
 resources initialization
Date:   Wed, 17 Oct 2018 15:41:55 +0200
Message-id: <20181017134159.9656-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181017134159.9656-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7djP87p6NsejDV7fUrLYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mn5uuMhe8JWr4u6JXUwNjHM5uxg5OSQETCTm3mtm7WLk4hASWMEocWXabSjnM6PE7afv
        mGGqHm86wQiRWMYo0dl1lwnCaWCSuLdwKStIFZuAoUTX2y42EFtEIFui8/EDRhCbWWARs8SB
        Y8IgtrBAskTH//9gU1kEVCX6Tj9iAbF5BWwk3k5azgSxTV5i9YYDQDUcHJwCthJr+6tAdkkI
        7GGTuLZ+OjtEjYvEzB8nWCBsYYlXx7dAxWUkLk/uZoFoaGaUaJ8xix3C6WGU2DpnBxtElbXE
        4eMXWSGu45OYtG062DYJAV6JjjYhiBIPiTlzm6G+nMAo8a5zJeMERskFjAyrGMVTS4tz01OL
        DfNSy/WKE3OLS/PS9ZLzczcxAuP59L/jn3Ywfr2UdIhRgINRiYd3h9ixaCHWxLLiytxDjBIc
        zEoivFWKx6OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8y6btzFaSCA9sSQ1OzW1ILUIJsvEwSnV
        wLhh36KXe/kZzc1POmzZLiX05rq86786/eOWb7Y3/p+88/Y3xnvpafVyv/fMF1jC+PzPoreq
        11vWWN39O/OXnF9aT2qx+uOWqnMBzC3xG3q54tT3sBt/T5PavPGYDLfzSrEAlmmud0t2is3T
        /eSfYDJt0yfeUjGTq/XRql4ZcftmfWOeHRnxXFiJpTgj0VCLuag4EQBKz7I+4wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t/xa7p6NsejDU51MlpsnLGe1eL9sh5G
        i+tfnrNazPssazHp/gQWi/PnN7BbbHp8jdXi8q45bBYzzu9jslh75C67xd87/9gsNm+aymzx
        8uMJFgdejzXz1jB6bFrVyeZx59oeNo93586xe2xeUu/Rt2UVo8fnTXIB7FFcNimpOZllqUX6
        dglcGT83XGQv+MpVcffELqYGxrmcXYycHBICJhKPN51g7GLk4hASWMIosXv9TCiniUmis6uT
        DaSKTcBQouttF5gtIpAtMX9vNzuIzSywhFni5n0HEFtYIFmi4/9/ZhCbRUBVou/0IxYQm1fA
        RuLtpOVMENvkJVZvOABUw8HBKWArsba/CiQsBFTy8vNcpgmMPAsYGVYxiqSWFuem5xYb6RUn
        5haX5qXrJefnbmIEhuG2Yz+37GDsehd8iFGAg1GJh3eH2LFoIdbEsuLK3EOMEhzMSiK8VYrH
        o4V4UxIrq1KL8uOLSnNSiw8xSnOwKInznjeojBISSE8sSc1OTS1ILYLJMnFwSjUwRu7svsDa
        9/BUyfs402WVf3bb9wcxv1R+smcZv4a8i9/MS4JWE/Pfv33drz2jwe5VeI6UtbZ/6z7VhGgL
        ZmfPNxUdL8OSVk/Z98+x4Vl/UdEbcZuo5Z/WTM1+OvXEx74vB9bM2f7cvVdz7jkOtxtP4q+I
        7Px7Tfruhw7uL60Kzvn1Z28wMkV9UGIpzkg01GIuKk4EADtcOmQ/AgAA
X-CMS-MailID: 20181017134206eucas1p1caf7cdec20ec620a5bf52fb9e060a7de
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017134206eucas1p1caf7cdec20ec620a5bf52fb9e060a7de
References: <20181017134159.9656-1-m.szyprowski@samsung.com>
        <CGME20181017134206eucas1p1caf7cdec20ec620a5bf52fb9e060a7de@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While freeing interrupt handlers in error path, don't assume that all
requested interrupts are per-processor interrupts and properly release
standard interrupts too.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index ef18bbf8d20c..49413900b24c 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -561,7 +561,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
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

