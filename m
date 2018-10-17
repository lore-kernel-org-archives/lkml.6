Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE9ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7254B2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cslwrbih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7254B2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJQVh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:37:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57662 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbeJQVh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:37:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181017134209euoutp011e723b5f25dca56b42f2fb63d5895412~eaSTasaTQ1247812478euoutp01F;
        Wed, 17 Oct 2018 13:42:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181017134209euoutp011e723b5f25dca56b42f2fb63d5895412~eaSTasaTQ1247812478euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539783729;
        bh=JbawqqnuJmBPjDcr8q+jVFNwx8wHm3+63GETfeiWmM0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Cslwrbihf4Qh9yWmfIn0qVLkbBZj5DaqlO60KNjnvsAyRlDZ4zoH89EraP7uZs4r4
         C28IdAJpP9vqQUh3wPg1rGlWhqnks6PKm+b2IXvgLtkus5GEjpdwGPS0BDsldHKmF0
         gORccETx6aVxNG4FFpsTLvEYVOQsORBJ+aqjFXAs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017134209eucas1p2d71dfa82326b8459cab3baa065f0d34f~eaSS_S21_1254712547eucas1p2t;
        Wed, 17 Oct 2018 13:42:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 40.5E.04441.03C37CB5; Wed, 17
        Oct 2018 14:42:08 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134208eucas1p19c81d1ce9050be1b78e386d8a349f441~eaSSInvIn0909309093eucas1p1l;
        Wed, 17 Oct 2018 13:42:08 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-9a-5bc73c30cd54
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8B.22.04284.03C37CB5; Wed, 17
        Oct 2018 14:42:08 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ001A0WQ1IZ80@eusync4.samsung.com>;
        Wed, 17 Oct 2018 14:42:08 +0100 (BST)
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
Subject: [PATCH v3 6/6] arm64: platform: Add enable Exynos Multi-Core Timer
 driver
Date:   Wed, 17 Oct 2018 15:41:59 +0200
Message-id: <20181017134159.9656-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181017134159.9656-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7djPc7oGNsejDa5O1bLYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mg5tucVWMIe94s//r0wNjJPYuhg5OSQETCRmnJ4LZHNxCAmsYJTo/XCHGcL5zCixbkIz
        E0zV3P6H7BCJZYwSW9cugWppYJK4sHAuO0gVm4ChRNfbLrC5IgLZEp2PHzCC2MwCi5glDhwT
        BrGFBUIkFjzbxAxiswioSry42gBWwytgI7Hy0hF2iG3yEqs3HACq4eDgFLCVWNtfBbJLQmAP
        m8ThldcYIWpcJI6sPAr1g7DEq+NboHplJDo7DjJBNDQzSrTPmMUO4fQAnT1nB1SHtcTh4xdZ
        Ia7jk5i0bTrYNgkBXomONiGIEg+J1Y8OgZUICUxglGha7TuBUXIBI8MqRvHU0uLc9NRiw7zU
        cr3ixNzi0rx0veT83E2MwGg+/e/4px2MXy8lHWIU4GBU4uHdIXYsWog1say4MvcQowQHs5II
        b5Xi8Wgh3pTEyqrUovz4otKc1OJDjNIcLErivMvmbYwWEkhPLEnNTk0tSC2CyTJxcEo1MK5g
        spDZVbvF2Ww+i++6Qw86qp1fWac90lxwdv4Ovk6/dXc8ty5+dbXb40FD98LChrKry1brs1jm
        Cv4rCS4WeRYlw9O8P/nDtnfiCsc+FgbYdgcovm6yYPkyxa1Z5lzrh1eX/6h83eDzRqB5Z9Ur
        m2npy2N2uRs35l3ptDz7nK2kRbK/d8mPUCWW4oxEQy3mouJEAM574DjiAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t/xa7oGNsejDWZu5bbYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mg5tucVWMIe94s//r0wNjJPYuhg5OSQETCTm9j9k72Lk4hASWMIose3pVyiniUli4pw9
        zCBVbAKGEl1vu8A6RASyJebv7WYHsZkFljBL3LzvAGILC4RILHi2CayeRUBV4sXVBkYQm1fA
        RmLlpSPsENvkJVZvOABUw8HBKWArsba/CiQsBFTy8vNcpgmMPAsYGVYxiqSWFuem5xYb6hUn
        5haX5qXrJefnbmIEhuG2Yz8372C8tDH4EKMAB6MSD+8OsWPRQqyJZcWVuYcYJTiYlUR4qxSP
        RwvxpiRWVqUW5ccXleakFh9ilOZgURLnPW9QGSUkkJ5YkpqdmlqQWgSTZeLglGpgZKu1ydwn
        b5suVVjDLmq7IkxdK/TN7NK8FotVF9zKF0RNZDRIObEtlJ9T82xU3ofs4/I1FoLcKZe3vMnk
        5fqUVn9e/vC5yRY/GtlVjz+S1F/L/7Ls6FeBmS2Hpt3c7i3+2cjfPCYlnluV794e9StPbnDk
        HyrN3VVaJasQoL/tzhWTsI7oHXeUWIozEg21mIuKEwHmOmvZPwIAAA==
X-CMS-MailID: 20181017134208eucas1p19c81d1ce9050be1b78e386d8a349f441
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017134208eucas1p19c81d1ce9050be1b78e386d8a349f441
References: <20181017134159.9656-1-m.szyprowski@samsung.com>
        <CGME20181017134208eucas1p19c81d1ce9050be1b78e386d8a349f441@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Exynos SoCs enabling MCT driver is required even if ARM Architected
Timer driver is used to for managing timer hardware and clock source
events.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
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

