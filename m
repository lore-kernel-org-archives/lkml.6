Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC43C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A5D2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j3omjP0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A5D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbeKPBUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:20:45 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:38399 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:20:45 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181115151227epoutp0467cfab910f50b3cf6c960533d5290cf5~nVOapOAJn1320613206epoutp048;
        Thu, 15 Nov 2018 15:12:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181115151227epoutp0467cfab910f50b3cf6c960533d5290cf5~nVOapOAJn1320613206epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542294747;
        bh=5GbDmz+oy4esatK4+k1/hnhgzRRda1luQ/7q8+U3NQY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=j3omjP0Ld5bTDM0BBWQK9aIakXowOe+K82gdQOLkf885G6LE68Ao3jY1U7PUlofGD
         JCIGuW/XG6mcnW/zZrRY1iJMOk2QLR2OP6o4paEuCTXlQzRmbjTh1Vyb/iI6iVtEyK
         z4sbNDtSv2GpLyi+17noN8FSwgMKtZWCysmVphss=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181115151226epcas2p16826183e4bc68aefa84950e6a67eabf7~nVOZyj6Qr2502025020epcas2p1t;
        Thu, 15 Nov 2018 15:12:26 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.64.04218.ADC8DEB5; Fri, 16 Nov 2018 00:12:26 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181115151225epcas2p4244fba019e0509d480f7953a05097105~nVOZcWuXU0890008900epcas2p4z;
        Thu, 15 Nov 2018 15:12:25 +0000 (GMT)
X-AuditID: b6c32a47-bf9ff7000000107a-52-5bed8cdaaac4
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 93.28.03702.9DC8DEB5; Fri, 16 Nov
        2018 00:12:25 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI8006WJQ7YQ380@mmp2.samsung.com>; Fri, 16 Nov 2018
        00:12:25 +0900 (KST)
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
Subject: [PATCH 4/9] ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
Date:   Thu, 15 Nov 2018 16:11:33 +0100
Message-id: <1542294698-17470-5-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCmme6tnrfRBu9fs1rcWneO1eLvpGPs
        FhtnrGe1uP7lOavFwmnLGS36H79mtjh/fgO7xabH11gtLu+aw2Yx4/w+JouXR34wWqw9cpfd
        YtHWL+wOvB6/f01i9Lh1p95j06pONo/NS+o93u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6
        dglcGXN2r2IqmMZWsfvubuYGxgWsXYycHBICJhLvH84Asrk4hAR2MEocvLwIyvnOKDHl6xM2
        mKoJ098yQSQ2MEo8WzCLDcL5xShx7NspRpAqNgEriYntq8BsEQFNiet/v4PtYBY4yiyx5IoE
        iC0s4CFx9tUjJhCbRUBV4u22ecwgNi9QfOabiSwQ2+QkTh6bDNbLKeApsf1sOzPIMgmBA2wS
        284fgjrJReJi6zx2CFtY4tXxLVC2tMSzVRsZIRqmM0q8+bWUBcJZzyix5swxJogqa4nDxy9C
        nccn0XH4L1A3B1CcV6KjTQiixEPiZvMnqDfnMEoc+rqceQKj5AJGhlWMYqkFxbnpqcVGBcZ6
        xYm5xaV56XrJ+bmbGMHxrOW+g3HbOZ9DjAIcjEo8vAblb6OFWBPLiitzDzFKcDArifC61QGF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ8z6UnhstJJCeWJKanZpakFoEk2Xi4JRqYNw/s4JXNbPr
        78/vk+UclNqjFpf+VGXx2Hk5xb3t5BGn//lSd39deJLYLzV5p4rFsfXXbs6a6HeQUX+S4/S+
        nPz0wuePOV/0HPp09OPPQAnxhbu6D6ut2reuQq7N5+CunI8bji3Pu+z+WFNj9vLp1zvub7vv
        tbA7reHym5fW3ZdD+jOUXoVUdG5TYinOSDTUYi4qTgQAjWLWfOMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsVy+t9jQd2bPW+jDf5/1LS4te4cq8XfScfY
        LTbOWM9qcf3Lc1aLhdOWM1r0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBYvj/xgtFh75C67
        xaKtX9gdeD1+/5rE6HHrTr3HplWdbB6bl9R7vN93lc2jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4MubsXsVUMI2tYvfd3cwNjAtYuxg5OSQETCQmTH/L1MXIxSEksI5RYu/cacwQzi9GiRdP
        tjKBVLEJWElMbF/FCGKLCGhKXP/7nRWkiFngKLPE5wnbmUESwgIeEmdfPQJrYBFQlXi7bR5Y
        nBcoPvPNRBaIdXISJ49NBlvNKeApsf1sO1iNEFDN579n2Ccw8ixgZFjFKJlaUJybnltsVGCU
        l1quV5yYW1yal66XnJ+7iREYlNsOa/XvYHy8JP4QowAHoxIPr0H522gh1sSy4srcQ4wSHMxK
        IrxudUAh3pTEyqrUovz4otKc1OJDjNIcLErivPz5xyKFBNITS1KzU1MLUotgskwcnFINjP3a
        f082rDwQvfDQvo2nNkoen+MTYfGf2froty+ioaY+j7q2tDTFnXqgPH+dPZ+beXOX2zzTw+wn
        9OOkVI+krTmzUYbXK/6w1F8VB7uuYqMi9uyI8zZLeT7c9D74+9k9PpObx0Od7ye+fzjbpIax
        4cPy0/kv7WTObbVLDZ9Rc+HL8uZANluJJCWW4oxEQy3mouJEAHZj+bRGAgAA
X-CMS-MailID: 20181115151225epcas2p4244fba019e0509d480f7953a05097105
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181115151225epcas2p4244fba019e0509d480f7953a05097105
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181115151225epcas2p4244fba019e0509d480f7953a05097105@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

This patch enables exynos_chipid driver for ARCH_EXYNOS
based SoC.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479..84b88ab7 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -62,6 +62,7 @@ config ARCH_BRCMSTB
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_CHIPID
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-- 
1.9.1

