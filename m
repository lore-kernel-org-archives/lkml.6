Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5C3C676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BD120841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f0l1ajDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BD120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeJHUCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:02:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45231 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJHUCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:02:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008125049euoutp01f8e1d9ad897bdf8c59b4561fe9d5aaf7~box62aSo91950919509euoutp01c;
        Mon,  8 Oct 2018 12:50:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008125049euoutp01f8e1d9ad897bdf8c59b4561fe9d5aaf7~box62aSo91950919509euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539003050;
        bh=u6Fux9B2+gCCVTDUtsb3Uk1X1p5dp09XsTAiT796EMU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=f0l1ajDBjczHRJtWiAwBiGGYoZVR8neWNvm6sYGD/V3lfbicY9NlR8DhNrF8/vJzg
         iGF/KihBv1KfOfSh/hwNiVwxHWx8PIrMnn7cfq+mZOfABGB884h1sZjNETZEKagWBV
         qZEJ338ZKfL4sMLDE5Mou/a5QD2ilaeIUB53UBJw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008125049eucas1p262f8e181df7030cb7ae556e8678702af~box6TP2_60784307843eucas1p2n;
        Mon,  8 Oct 2018 12:50:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 78.21.04806.8A25BBB5; Mon,  8
        Oct 2018 13:50:49 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001~box5elyRs1879418794eucas1p2r;
        Mon,  8 Oct 2018 12:50:48 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-85-5bbb52a8a3c7
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C4.39.04128.8A25BBB5; Mon,  8
        Oct 2018 13:50:48 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGA006EA6BYW230@eusync1.samsung.com>;
        Mon, 08 Oct 2018 13:50:48 +0100 (BST)
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
Subject: [PATCH 4/7] clocksource: arch_timer: Add support for
 not-fw-configured timer on ARM64
Date:   Mon, 08 Oct 2018 14:50:06 +0200
Message-id: <20181008125009.3721-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181008125009.3721-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7djP87org3ZHG7yYwGSxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZUxZdoSx4LJ4xcnDAg2M74S7GDk5JARMJB5tnMbSxcjFISSwglFi8uz9rBDOZ0aJ859+
        MsJU7f18CapqGaPEhatfoKoamCR+NW1jAqliEzCU6HrbxQZiiwhkS3Q+fgDWzSywiFniwDGw
        fcICCRKvN81jBrFZBFQlfu9pBrN5BWwkti7tg9omL7F6wwGwOKeArcSTrlVgmyUE9rBJtK7a
        ywpR5CKx/9A/ZghbWOLV8S3sELaMxOXJ3VANzYwS7TNmsUM4PYwSW+fsYIOospY4fPwiK8R5
        fBKTtk0HmsQBFOeV6GgTgijxkHi2bhk7xJsTGCU2X2phncAouYCRYRWjeGppcW56arFxXmq5
        XnFibnFpXrpecn7uJkZgPJ/+d/zrDsZ9f5IOMQpwMCrx8Ab47YoWYk0sK67MPcQowcGsJMIr
        uh0oxJuSWFmVWpQfX1Sak1p8iFGag0VJnHfZvI3RQgLpiSWp2ampBalFMFkmDk6pBsYgATn/
        qtgFvbr2jv0pHnZTV7SU3o6yfaVU9sakRP6Jp8cyjdXfmpSiXs+dIcL08K8p95FfWpkmC1SX
        e96JmvN+/VKt9R5egX1G63+bFD7IVXyVdG4v6zvbw+f/+E7M3aa0qjXwz/dnKvsC1C43XW9V
        k1A5vHllpLlVjPW6gw7lt17P8F9htliJpTgj0VCLuag4EQA2zswz4wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t/xy7orgnZHG0zrkLHYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4MqYsO8JYcFm84uRhgQbGd8JdjJwcEgImEns/X2LpYuTiEBJYwiix4+0cRginiUli6fKX
        7CBVbAKGEl1vu9hAbBGBbIn5e7vB4swCS5glbt53ALGFBRIk7lyeygRiswioSvze08wMYvMK
        2EhsXdrHCLFNXmL1hgNgcU4BW4knXatYQGwhoJre6RdZJzDyLGBkWMUoklpanJueW2ykV5yY
        W1yal66XnJ+7iREYhtuO/dyyg7HrXfAhRgEORiUe3hUBu6KFWBPLiitzDzFKcDArifCKbgcK
        8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCeWJKanZpakFoEk2Xi4JRqYOw4xb9Lcfrj
        gKS5K7582/f9142or1pbLJStRa4eFt9yxF0x4Pts6U9TEttKn3641Zcq19/+6o6Aqpr/gxVT
        dvR6Hz3Gt/3yHj7hxLehFgdleiY88zAr/3ttTnBkhZnKgZTzT/oOiMxZkn5ZeNayZ1wGX/fc
        Oliucahy8uy9J+oktt6SfXt/yeXnSizFGYmGWsxFxYkA/YrTkz8CAAA=
X-CMS-MailID: 20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
        <CGME20181008125048eucas1p229a94c202596ddd0a65009c15d9e3001@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common infrastructure for ARM Architected Timers erratum to enable
support for systems with broken CPU firmware (timer registers not
properly configured). This mode has been already availabled on ARM
(32bits) architecture. This enables to run Linux kernel on ARM64 boards
using physical architected timers instead of the virtual ones. Examples
of such system with broken firmware are Samsung Exynos5433 SoC based
TM2(e) boards, which is already deployed for years and updating firmware
is not possible.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/Kconfig          | 11 +++++++++++
 drivers/clocksource/arm_arch_timer.c | 15 ++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba98b05..a30752579b03 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -364,6 +364,17 @@ config ARM64_ERRATUM_858921
 	  The workaround will be dynamically enabled when an affected
 	  core is detected.
 
+config ARCH_TIMER_REGISTERS_NOT_FW_CONFIGURED
+	bool "Workaround for arch timer registers not configured by firmware"
+	default y
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
+	depends on ARM_ARCH_TIMER && ARM64
+	help
+	  This option enables a workaround for boards, on which arch timer
+	  registers are not properly configured by the board firmware.
+	  The workaround will be dynamically enabled when an affected
+	  board is detected.
+
 config ARM_GLOBAL_TIMER
 	bool "Support for the ARM global timer" if COMPILE_TEST
 	select TIMER_OF if OF
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc00b6e..b6f109654daf 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -423,6 +423,14 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.read_cntvct_el0 = arm64_1188873_read_cntvct_el0,
 	},
 #endif
+#ifdef CONFIG_ARCH_TIMER_REGISTERS_NOT_FW_CONFIGURED
+	{
+		.match_type = ate_match_dt,
+		.id = "arm,cpu-registers-not-fw-configured",
+		.desc = "broken CPU firmware (timer registers not configured)",
+		.read_cntvct_el0 = arch_counter_get_cntpct,
+	},
+#endif
 };
 
 typedef bool (*ate_match_fn_t)(const struct arch_timer_erratum_workaround *,
@@ -1234,9 +1242,10 @@ static int __init arch_timer_of_init(struct device_node *np)
 	 * If we cannot rely on firmware initializing the timer registers then
 	 * we should use the physical timers instead.
 	 */
-	if (IS_ENABLED(CONFIG_ARM) &&
-	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
-		arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
+	if (of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
+		arch_timer_uses_ppi = IS_ENABLED(CONFIG_ARM64) ?
+					ARCH_TIMER_PHYS_NONSECURE_PPI :
+					ARCH_TIMER_PHYS_SECURE_PPI;
 	else
 		arch_timer_uses_ppi = arch_timer_select_ppi();
 
-- 
2.17.1

