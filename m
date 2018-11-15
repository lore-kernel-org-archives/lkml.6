Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10331C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D20208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uopQ+OEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D20208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbeKPBUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:20:39 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35675 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:20:39 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181115151222epoutp014a29004e76fe15d07e7979ef7595892e~nVOWZJQ-S0564405644epoutp01g;
        Thu, 15 Nov 2018 15:12:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181115151222epoutp014a29004e76fe15d07e7979ef7595892e~nVOWZJQ-S0564405644epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542294742;
        bh=GpBHhxFllghOSCtnxruKtLvFXzlEL/7kNI6p7ER0EuQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=uopQ+OEzFMcOJS0qZMQ/wD14Rv4ujsmcmCNqw8tuSUeiyhp5Yl76iZolI73N3qefd
         GgnN6EFJ3+ztOQlJ9ReGolsIuWNEmH0E04C6XSwNjjCPg1kqcrOh503+ERFDeqmRjf
         THXuSNzfcCdcKwvvGKob1oqUx2CcWwGT4CPKVUmE=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181115151221epcas2p1e6bf67b49f6f701e288c196c91fc5317~nVOVxHpRj2500425004epcas2p1s;
        Thu, 15 Nov 2018 15:12:21 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.64.04218.5DC8DEB5; Fri, 16 Nov 2018 00:12:21 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181115151221epcas2p17b8bbb240f70fdd7c5ecf1c0c27de35f~nVOVQKa1S1292412924epcas2p1p;
        Thu, 15 Nov 2018 15:12:21 +0000 (GMT)
X-AuditID: b6c32a47-be1ff7000000107a-4b-5bed8cd5faad
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B2.28.03702.5DC8DEB5; Fri, 16 Nov
        2018 00:12:21 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI8006WJQ7YQ380@mmp2.samsung.com>; Fri, 16 Nov 2018
        00:12:21 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 3/9] ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
Date:   Thu, 15 Nov 2018 16:11:32 +0100
Message-id: <1542294698-17470-4-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCmue7VnrfRBudOGljcWneO1eLvpGPs
        FhtnrGe1uP7lOavFwmnLGS36H79mtjh/fgO7xabH11gtLu+aw2Yx4/w+JouXR34wWqw9cpfd
        YtHWL+wOvB6/f01i9Lh1p95j06pONo/NS+o93u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6
        dglcGdefZxYsZqv4cXQBawPjctYuRk4OCQETicdXjjJ1MXJxCAnsYJS437SPGcL5zijxbuVU
        uKrW640sEIkNjBIT5k2CavnFKPHl+n92kCo2ASuJie2rGEFsEQFNiet/v4N1MwscZZZYckUC
        xBYWcJPoPXQbKM7BwSKgKtF+0h8kzCvgIXHr106oZXISJ49NBrM5BTwltp9tB7tIQuAAm0TL
        lodQRS4Sy3f3s0DYwhKvjm9hh7ClJZ6t2sgI0TCdUeLNr6UsEM56Rok1Z44xQVRZSxw+fhHq
        Oj6JjsN/2UEukhDglehoE4Io8ZC48nktI8SXcxglfp3ZwzSBUXIBI8MqRrHUguLc9NRiowJj
        veLE3OLSvHS95PzcTYzgWNZy38G47ZzPIUYBDkYlHl6D8rfRQqyJZcWVuYcYJTiYlUR43eqA
        QrwpiZVVqUX58UWlOanFhxilOViUxHkfSs+NFhJITyxJzU5NLUgtgskycXBKNTCmd1YHHZnU
        x77o3yyF0H0mvCrzRWPDy87/tc2bvWf5JP7jDUrfe+Ywfn2/WP3Ea7lkozUxzlbCan0v790+
        LLj/5jP/8M3Guw5ISP2Rn/lhe8pevpLH5klvn67iCOOTezDRhdlW5NK/kvv1Xe/CXS2ui32c
        VTQxveOL8Ck1plUnVx0tlivX29KoxFKckWioxVxUnAgA1V72weECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsVy+t9jQd2rPW+jDf695LW4te4cq8XfScfY
        LTbOWM9qcf3Lc1aLhdOWM1r0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBYvj/xgtFh75C67
        xaKtX9gdeD1+/5rE6HHrTr3HplWdbB6bl9R7vN93lc2jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mq4/zyxYzFbx4+gC1gbG5axdjJwcEgImEq3XG1lAbCGBdYwSy2bIdDFyAdm/GCXmXzgC
        lmATsJKY2L6KEcQWEdCUuP73OytIEbPAUWaJzxO2M4MkhAXcJHoP3QZKcHCwCKhKtJ/0Bwnz
        CnhI3Pq1E2qZnMTJY5PBbE4BT4ntZ9uZIRZ7SHz+e4Z9AiPPAkaGVYySqQXFuem5xUYFRnmp
        5XrFibnFpXnpesn5uZsYgeG47bBW/w7Gx0viDzEKcDAq8fAalL+NFmJNLCuuzD3EKMHBrCTC
        61YHFOJNSaysSi3Kjy8qzUktPsQozcGiJM7Ln38sUkggPbEkNTs1tSC1CCbLxMEp1cAY/v/C
        Q0/Xqkn7+X++59TJe8iv2m521efftSV57Sf1105+e9lFzdruIWsQs6xNfzgjM7OPVNfSx8de
        8YVPjOM81qqzk8/+19efj8PzwgUUv9ervp0dmWUkvpWl36tqwV/16+eFEqTcyquPnn1kPeHB
        9itxMjFlyxMYepv59lscsRCfvjliZbESS3FGoqEWc1FxIgDZpOusQwIAAA==
X-CMS-MailID: 20181115151221epcas2p17b8bbb240f70fdd7c5ecf1c0c27de35f
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181115151221epcas2p17b8bbb240f70fdd7c5ecf1c0c27de35f
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181115151221epcas2p17b8bbb240f70fdd7c5ecf1c0c27de35f@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

As now we have chipid driver to initialize SoC related information
let's include it in build by default.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b40963c..e3e63aa 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -13,6 +13,7 @@ menuconfig ARCH_EXYNOS
 	select ARM_AMBA
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_CHIPID
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
 	select EXYNOS_SROM
-- 
1.9.1

