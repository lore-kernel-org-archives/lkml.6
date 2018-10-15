Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30814C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD7820652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hombqJbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD7820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeJOUQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:16:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51555 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeJOUQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:16:44 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181015123137euoutp01470b4f3fab724f194434fcfef1932e5d~dyCJmcZ3y0681706817euoutp01j;
        Mon, 15 Oct 2018 12:31:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181015123137euoutp01470b4f3fab724f194434fcfef1932e5d~dyCJmcZ3y0681706817euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539606697;
        bh=P5wI1ifO1zqgHAbKZBI+jz0znA3KVWd2lDiGG6h9IJ4=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=hombqJbMpm2Nq3hx1gOSsSkLA0w4la7ll3gdYPCljake9Yxwlnt0UvF30qP6yVQ/+
         hPIcA/0Y97qIMv/AAdbUb5siuZi2fhOa40TiwC90i3QbFCdjsTe20P9uDjABPAN/mR
         gig/pH92huZObnnkLdBWMAYLQq/woxRJ8wEfg4EA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015123137eucas1p1c44665123538fb3d494118016cdc2416~dyCJL_lDU1988219882eucas1p1p;
        Mon, 15 Oct 2018 12:31:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FD.6F.04806.8A884CB5; Mon, 15
        Oct 2018 13:31:36 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181015123136eucas1p2f7d4ae86ba3547b891749b01514cd335~dyCIYINp_3197531975eucas1p2e;
        Mon, 15 Oct 2018 12:31:36 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-98-5bc488a81a6a
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C7.EE.04284.8A884CB5; Mon, 15
        Oct 2018 13:31:36 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGN00GZC4490K70@eusync1.samsung.com>;
        Mon, 15 Oct 2018 13:31:36 +0100 (BST)
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
Subject: [PATCH v2 4/6] clocksource: Change CPU hotplug priority of
 exynos_mct driver
Date:   Mon, 15 Oct 2018 14:31:10 +0200
Message-id: <20181015123112.9379-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181015123112.9379-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7djPc7orOo5EGxybYWaxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZbw/tYC9YAFHxZ6uyawNjFPYuxg5OSQETCS2LdjC2MXIxSEksIJRort9GTuE85lRYl/P
        B2aYqhN/J7BBJJYxSryacxjKaWCSWH57PitIFZuAoUTX2y42EFtEIFui8/EDRhCbWWARs8SB
        Y8IgtrBAuMShly1gU1kEVCXuzLwIdgevgI3EjOYTTBDb5CVWbzgAVsMpYCtx+P8qFpBlEgJ7
        2CQuN32GOslFYva8bihbWOLV8S1QD8lIdHYcZIJoaGaUaJ8xix3C6WGU2DpnBxtElbXE4eMX
        WSHO45OYtG060CQOoDivREebEESJh8T0qRvASoQEJjBKNF3UmcAouYCRYRWjeGppcW56arFx
        Xmq5XnFibnFpXrpecn7uJkZgPJ/+d/zrDsZ9f5IOMQpwMCrx8ArwHIkWYk0sK67MPcQowcGs
        JMIrEXIoWog3JbGyKrUoP76oNCe1+BCjNAeLkjjvsnkbo4UE0hNLUrNTUwtSi2CyTBycUg2M
        OikTG2o26jOGPP/OcqGz+v1msS2adn27sj7mHXlRvfm8k/OxLxNm3O3tzFPtbd3M1chV3LQ2
        Qj9jq6v67yUmxucUtk62WqlueSNUmrW4nvHDhKm88id5mGefVHv0p9jpluOFlZv4DgX0T37o
        0l+4/73s40PqPzbYOvd1hPtMPZleKZ0wt+aZEktxRqKhFnNRcSIALAvtHOMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVy+t/xy7orOo5EG/S9FLHYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mt6fWsBesICjYk/XZNYGxinsXYycHBICJhIn/k5gA7GFBJYwSvy8CWRzAdlNTBLbrp5g
        AUmwCRhKdL3tAisSEciWmL+3G6yZWWAJs8TN+w5djBwcwgLhEjPb7EDCLAKqEndmXgQr4RWw
        kZjRfIIJYpe8xOoNB5hBbE4BW4nD/1exQOy1kbhw7C/jBEaeBYwMqxhFUkuLc9Nziw31ihNz
        i0vz0vWS83M3MQKDcNuxn5t3MF7aGHyIUYCDUYmHV4DnSLQQa2JZcWXuIUYJDmYlEV6JkEPR
        QrwpiZVVqUX58UWlOanFhxilOViUxHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhjl1efr7nlQ
        nz5BxI2vm+/L/FtqbdtjOy7VvVJb8Wx2cNWyK4J9F6+clZ5qtMnnhXSER+Uu8yDZaX9aFr6a
        OumuIUM/34OL56MKzSUzP1XNveCby8SxKiRnodDBf/7a8r8WlfewOGkzFnoITL7m5ukb8kCe
        Z/vUQ/ufJC5Uvx9ofotxoeJcwyglluKMREMt5qLiRAAzhsi7PgIAAA==
X-CMS-MailID: 20181015123136eucas1p2f7d4ae86ba3547b891749b01514cd335
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015123136eucas1p2f7d4ae86ba3547b891749b01514cd335
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123136eucas1p2f7d4ae86ba3547b891749b01514cd335@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos Multi-Core Timer driver (exynos_mct) must be started before
ARM Architected Timers (arch_timer), because both timers share common
hardware block and turning on MCT is needed to get ARM Architected
Timer working properly.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/linux/cpuhotplug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index caf40ad0bbc6..5d9e4a6ea299 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -115,10 +115,10 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_ACPI_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
+	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_JCORE_TIMER_STARTING,
-	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_ARMADA_TIMER_STARTING,
-- 
2.17.1

