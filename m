Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38618C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FC220892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dgMzxd/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FC220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbeLNLe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:34:28 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52290 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeLNLeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:34:22 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181214113421euoutp027691d5e7e27151177ea999a65bd24741~wL9RRZcz02204822048euoutp02j;
        Fri, 14 Dec 2018 11:34:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181214113421euoutp027691d5e7e27151177ea999a65bd24741~wL9RRZcz02204822048euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544787261;
        bh=0FWSvMwPOmMdRNz3JtGp6Ji4fysLQt8HrzqwtmH+LV4=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=dgMzxd/MNFXB11ZnbmHPOrbdLuBfknPSQimRBI+X46o/9dGL1smfTDdegcf0pUjQD
         q0sertXfbkzXC2pj0ji2kBBjKuwTUQqOiYfkotefKw3L+dC81osWwsPeHpcAJ6pvd4
         FoNxf4WSOBUatTVB5qntPdN33uDD13PdE/9X1G8M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181214113420eucas1p28210e3a107bb598bd0e9c0e60ffd1bae~wL9QpVXnj0452304523eucas1p2l;
        Fri, 14 Dec 2018 11:34:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CD.A2.04806.C35931C5; Fri, 14
        Dec 2018 11:34:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181214113419eucas1p2473172a49bf798ddd95265fa31125d96~wL9P_sm9Y0434104341eucas1p2d;
        Fri, 14 Dec 2018 11:34:19 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-7d-5c13953ca0b4
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1E.D8.04284.B35931C5; Fri, 14
        Dec 2018 11:34:19 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PJQ004655GZZA10@eusync3.samsung.com>;
        Fri, 14 Dec 2018 11:34:19 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/4] arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards
Date:   Fri, 14 Dec 2018 12:34:10 +0100
Message-id: <20181214113410.22848-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181214113410.22848-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7djPc7o2U4VjDG5P47HYOGM9q8XpT9vY
        LZoXr2ezOH9+A7vF/a9HGS0u75rDZjHj/D4mizOLe9kt1h65y25x+E07q8WMyS/ZHLg9Nq3q
        ZPO4c20Pm8f+uWvYPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugSvjxabTjAVPOCquPN3F1sC4
        mr2LkZNDQsBE4viCrSwgtpDACkaJJxdyuhi5gOzPjBKrP9xmgSk6u6CVBSKxjFGi/+IuNgin
        gUmiZ9ENNpAqNgFDia63XWC2iECyxLO5RxhBipgFHjJJdFz8BjZKWMBHYl7DUWYQm0VAVeL1
        6itgNq+ArcSKpRNZIdbJS6zecAAszilgJ3FsyyZ2kEESAkvYJO7/2ckMUeQisfpvExOELSzx
        6vgWqIdkJDo7DjJBNDQzSrTPmAXV3cMosXXODjaIKmuJw8cvgq1jFuCTmLRtOtBUDqA4r0RH
        mxBEiYfE3vXToP6cyCjx8u9+lgmMkgsYGVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIE
        Ruvpf8e/7mDc9yfpEKMAB6MSD++J2UIxQqyJZcWVuYcYJTiYlUR4w1qFY4R4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUwinvuzbS9bB645tJv6RzmU2fa
        KzSduY6s2rH2zqcfPDsjI3c/dmPbumi5FqcBl9OEdX6nn9b97y6TUNz+QHf3K259zemvZZTl
        75Uevet88KFI19RvNVt4WflPOWo98Jt1N1fp9JtX8dJxv14aXIkqb4nP/aPy12pufe+VlZe+
        P/62oaX3dcaqJ0osxRmJhlrMRcWJAKtCvJTSAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsVy+t/xq7rWU4VjDFb+1rTYOGM9q8XpT9vY
        LZoXr2ezOH9+A7vF/a9HGS0u75rDZjHj/D4mizOLe9kt1h65y25x+E07q8WMyS/ZHLg9Nq3q
        ZPO4c20Pm8f+uWvYPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugSvjxabTjAVPOCquPN3F1sC4
        mr2LkZNDQsBE4uyCVpYuRi4OIYEljBLv9k+FcpqYJG5d+8EIUsUmYCjR9baLDcQWEUiW2PX3
        BStIEbPAYyaJKS0vWEASwgI+EvMajjKD2CwCqhKvV18Bs3kFbCVWLJ3ICrFOXmL1hgNgcU4B
        O4ljWzaBnSEEVPN1+hfGCYw8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgSG2bZjPzfv
        YLy0MfgQowAHoxIP74EpQjFCrIllxZW5hxglOJiVRHjDWoVjhHhTEiurUovy44tKc1KLDzFK
        c7AoifOeN6iMEhJITyxJzU5NLUgtgskycXBKNTDyOz9S0/m/VPrK7IUaSQzP2DY/eulia7no
        naRK4u6tPteY2OfZhWsbuz14vb2h8VX5np+X08v3R3D/Klw678wd35mqbbE1V1y3HbS+xbTX
        4K3ZwVvCX3d9n2i18VubipqR25vKXS5PDPO3b1etuGzIVCm+/1gMH5tnR8vC4ljrM7/iz7T9
        5uJSYinOSDTUYi4qTgQAPGyTdS8CAAA=
X-CMS-MailID: 20181214113419eucas1p2473172a49bf798ddd95265fa31125d96
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214113419eucas1p2473172a49bf798ddd95265fa31125d96
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
        <CGME20181214113419eucas1p2473172a49bf798ddd95265fa31125d96@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TM2(e) boards have a Broadcom Bluetooth chip connected to 3rd UART port.
Add a device tree node describing it and its resources (control GPIO lines
and clock).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index f3ed4c078ba5..d88e2f0e179a 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1202,6 +1202,20 @@
 	status = "okay";
 };
 
+&serial_3 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
+		shutdown-gpios = <&gpd4 0 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpr3 7 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpa2 2 GPIO_ACTIVE_HIGH>;
+		clocks = <&s2mps13_osc S2MPS11_CLK_BT>;
+		clock-names = "extclk";
+	};
+};
+
 &spi_1 {
 	cs-gpios = <&gpd6 3 GPIO_ACTIVE_HIGH>;
 	status = "okay";
-- 
2.17.1

