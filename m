Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D19C677E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB272087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p3DLqI8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB272087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeJHUC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:02:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51696 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJHUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:02:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181008125052euoutp02ff594312c9b501219e40c8e49eb52305~box80ArmN2603426034euoutp02Z;
        Mon,  8 Oct 2018 12:50:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181008125052euoutp02ff594312c9b501219e40c8e49eb52305~box80ArmN2603426034euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539003052;
        bh=Dc2Hb6mBnlg8niGEf308TABPHOcuaLijU2lrM6USfRs=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=p3DLqI8W/uIchoLfaltrJaadPEusrVARkkpOZrmrQb7WADYw8XUhbEIuzO6UQ49vj
         6cEY36Bw81McPneE4XPJJFhfa0pcTSTe69r6I1ap+iWjIVQg9CqKiEE/BWTeWsoJLX
         DHzMvuP7ZxY0Cksd0AuKnmRlbOa6Tc/yDrUpnlJ0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008125051eucas1p1a502fb1e4e9b28379d7c8544a7a513e4~box8V6Lgp1752717527eucas1p1f;
        Mon,  8 Oct 2018 12:50:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2C.1C.04294.BA25BBB5; Mon,  8
        Oct 2018 13:50:51 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008125050eucas1p2da1c1ace904a331c149f5add71c72af2~box7n0Wy30355603556eucas1p2m;
        Mon,  8 Oct 2018 12:50:50 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-4e-5bbb52ab3e4e
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F7.39.04128.AA25BBB5; Mon,  8
        Oct 2018 13:50:50 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGA006EA6BYW230@eusync1.samsung.com>;
        Mon, 08 Oct 2018 13:50:50 +0100 (BST)
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
Subject: [PATCH 7/7] arm64: platform: Add enable Exynos Multi-Core Timer
 driver
Date:   Mon, 08 Oct 2018 14:50:09 +0200
Message-id: <20181008125009.3721-8-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181008125009.3721-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7djP87qrg3ZHG7R/47fYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mg63/WEveM5acXtOWgPjZ5YuRk4OCQETiYcnjzGB2EICKxglvq0P62LkArI/M0rs6TzH
        DlN0rmsiC0RiGaPEyTPHoZwGJomb+9aDVbEJGEp0ve1iA7FFBLIlOh8/YASxmQUWMUscOCYM
        YgsLBEqsXXMYrJ5FQFWi6+kMMJtXwEbi64sNjBDb5CVWbzjADGJzCthKPOlaBbZMQmALm8TN
        LbeYIIpcJJYtusYMYQtLvDq+BepUGYnLk7uhGpoZJdpnzGKHcHoYJbbO2cEGUWUtcfj4RVaI
        8/gkJm2bDjSJAyjOK9HRJgRR4iGxrO8zM8SbExglTi3YzziBUXIBI8MqRvHU0uLc9NRio7zU
        cr3ixNzi0rx0veT83E2MwGg+/e/4lx2Mu/4kHWIU4GBU4uFdEbArWog1say4MvcQowQHs5II
        r+h2oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeZfM2RgsJpCeWpGanphakFsFkmTg4pRoYEwsd
        NzI7x5n+38/OqXja4ahzglvZVQn/41Fm1555feHYvbSn97Pxlrdp+Veqnu8O2vVZtKGwQq0g
        SlX7svuB7V9uHb/nVhBu4P3JfG7oRL/sq5tKurbe1Musb/taenfTt3uzZ0sfZNy1e3bmc4v/
        R6Ya+N9Pd4/dNTfitsVmLRtNRz+RtpwEJZbijERDLeai4kQA2sfc5+ICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVy+t/xy7qrgnZHG/xbqWexccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZRxu+8Ne8Jy14vactAbGzyxdjJwcEgImEue6JoLZQgJLGCW+v7XoYuQCspuYJK48nsAM
        kmATMJToetvFBmKLCGRLzN/bzQ5iMwssYZa4ed8BxBYW8Jf4Nfkv2CAWAVWJrqczwGp4BWwk
        vr7YwAixTF5i9YYDYDM5BWwlnnStglpsI9E7/SLrBEaeBYwMqxhFUkuLc9Nzi430ihNzi0vz
        0vWS83M3MQKDcNuxn1t2MHa9Cz7EKMDBqMTDuyJgV7QQa2JZcWXuIUYJDmYlEV7R7UAh3pTE
        yqrUovz4otKc1OJDjNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFINjBtS2652+MtuY67t
        4rRye7Xrq+rRJVmyz6UnL0p0Elxsd+pv9/lsC2+LlJvn3dblrn27zWjatxuhournZJIX13s9
        6NaLbhCaFLiAsd3VVvanZkritmVPJe8KLDG5u77x2ptPwbYK53N9lsbP6j2wPOC7hM7VTB3N
        5J+ThNs3aj25fktL7sHj3UosxRmJhlrMRcWJAPAmntE+AgAA
X-CMS-MailID: 20181008125050eucas1p2da1c1ace904a331c149f5add71c72af2
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008125050eucas1p2da1c1ace904a331c149f5add71c72af2
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
        <CGME20181008125050eucas1p2da1c1ace904a331c149f5add71c72af2@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos MCT driver is required even if ARM Architected Timer driver
is used to properly configure common timer hardware.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479334a4..7cc687580fad 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -62,6 +62,7 @@ config ARCH_BRCMSTB
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-- 
2.17.1

