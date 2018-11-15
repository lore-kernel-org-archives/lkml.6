Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F9DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311CB2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p24eNzeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311CB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbeKPBVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:21:07 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:38444 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388042AbeKPBVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:21:07 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181115151250epoutp047712ac6fad4a401567e456e2059a6a42~nVOwe1ozT1479214792epoutp04Z;
        Thu, 15 Nov 2018 15:12:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181115151250epoutp047712ac6fad4a401567e456e2059a6a42~nVOwe1ozT1479214792epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542294770;
        bh=5bmAVkGkwX7ChC6XKRyGxkygWUDheHbVXN9lZuKBLao=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=p24eNzeg3yC21AVJQof3tlffWSv/4Wy1Z3jkBPl5lyB/BZ5X4gToPm09L08O9JLGa
         ZOPVKn+n7rmb9NYC0u3sj5UVs18ZnMV/5CKYAFdrfWDkD1v3Cv/9VsSCXiHGsL/+9Z
         Dj0mIkvImJvJiJ8l/uN4SKVpeck4vXfzS49773qQ=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181115151248epcas2p2b6910e3be6e14524965a1e9c2714d96e~nVOvEpGrK0712507125epcas2p2w;
        Thu, 15 Nov 2018 15:12:48 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.DB.04410.0FC8DEB5; Fri, 16 Nov 2018 00:12:48 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181115151247epcas2p4053da2cb28b2414156d2fd0530059c0d~nVOt2EBYB1347513475epcas2p49;
        Thu, 15 Nov 2018 15:12:47 +0000 (GMT)
X-AuditID: b6c32a45-a01ff7000000113a-ee-5bed8cf04fdf
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id D5.28.03702.FEC8DEB5; Fri, 16 Nov
        2018 00:12:47 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI8006WJQ7YQ380@mmp2.samsung.com>; Fri, 16 Nov 2018
        00:12:47 +0900 (KST)
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
Subject: [PATCH 9/9] ARM: EXYNOS: remove <mach/map.h> include
Date:   Thu, 15 Nov 2018 16:11:38 +0100
Message-id: <1542294698-17470-10-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCmqe6HnrfRBl/WW1jcWneO1eLvpGPs
        FhtnrGe1uP7lOavFwmnLGS36H79mtjh/fgO7xabH11gtLu+aw2Yx4/w+JouXR34wWqw9cpfd
        YtHWL+wOvB6/f01i9Lh1p95j06pONo/NS+o93u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6
        dglcGZ/7pQru8FbcnzuRqYHxHHcXIyeHhICJxM6WK6xdjFwcQgI7GCU6tn6Dcr4zSizetI4N
        pqr/x1x2iMQGRon1k1YzQTi/GCV+flvADlLFJmAlMbF9FSOILSKgKXH973dWEJtZ4CizxJIr
        EiC2sICtxMP7R5i7GDk4WARUJXavUgYJ8wp4SqyasJsdYpmcxMljk8FaOYHi28+2M0PEj7BJ
        dPwvg7BdJN4/v8UCYQtLvDq+BapXWuLZqo2MILdJCExnlHjzaykLhLOeUWLNmWNMEFXWEoeP
        X4Q6jk+i4/BfdpCDJAR4JTrahCBKPCRWfnwKNlRIYA6jxP3GygmMkgsYGVYxiqUWFOempxYb
        FRjqFSfmFpfmpesl5+duYgTHsZbrDsYZ53wOMQpwMCrx8BqUv40WYk0sK67MPcQowcGsJMLr
        VgcU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvtIem60kEB6YklqdmpqQWoRTJaJg1OqgXHxgttm
        1dzuR1ds9Xlo8Ng57GzjrmM+PXUbX67XkZdWcj3tLV7w9PEbhaY5ZWsXLfwi73n17sIpwdxL
        vLgOG71cdSFuOvtZ+6kKjVtsjrQUWyyWWXRUwjbj//1sHu+m/69mCyn/2FrbJ9uUYcteLs94
        cYHC4gdnpR6JFJ769P1z24Iy+Yov2z4psRRnJBpqMRcVJwIAQ8Gw398CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsVy+t9jQd33PW+jDVY/U7a4te4cq8XfScfY
        LTbOWM9qcf3Lc1aLhdOWM1r0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBYvj/xgtFh75C67
        xaKtX9gdeD1+/5rE6HHrTr3HplWdbB6bl9R7vN93lc2jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mj73SxXc4a24P3ciUwPjOe4uRk4OCQETif4fc9m7GLk4hATWMUpsXLCTFcL5xSjR/KOL
        BaSKTcBKYmL7KkYQW0RAU+L63+9gRcwCR5klPk/YzgySEBawlXh4/wiQzcHBIqAqsXuVMkiY
        V8BTYtWE3ewQ2+QkTh6bzApicwLFt59tB2sVEvCQ+Pz3DPsERp4FjAyrGCVTC4pz03OLjQqM
        8lLL9YoTc4tL89L1kvNzNzECA3LbYa3+HYyPl8QfYhTgYFTi4TUofxstxJpYVlyZe4hRgoNZ
        SYTXrQ4oxJuSWFmVWpQfX1Sak1p8iFGag0VJnJc//1ikkEB6YklqdmpqQWoRTJaJg1OqgVFp
        J8vM272MPxJtu79ONj4g5+DouoOvklntwbHGM0EVyWrsS2xEoww9jz3rTyhzOSRwddkDs0Qu
        Yy7WP+ozOh58eiajqRx1lvv6ncSA3Yp70tZcfJ79+SNbWlzZutc5IoKZ75s3zg++KGPpLfOF
        dYODhcyrwkOmUcrrtrCvmnneeILl341XnimxFGckGmoxFxUnAgAR/UPmRAIAAA==
X-CMS-MailID: 20181115151247epcas2p4053da2cb28b2414156d2fd0530059c0d
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181115151247epcas2p4053da2cb28b2414156d2fd0530059c0d
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181115151247epcas2p4053da2cb28b2414156d2fd0530059c0d@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove no longer needed <mach/map.h> include.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c           |  2 --
 arch/arm/mach-exynos/include/mach/map.h | 18 ------------------
 arch/arm/mach-exynos/platsmp.c          |  2 --
 3 files changed, 22 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/map.h

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index d98574c..d29f241 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -19,8 +19,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-
 #include "common.h"
 
 static const struct soc_device_attribute exynos3250_soc_id[] = {
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
deleted file mode 100644
index 22ebe36..0000000
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS - Memory map definitions
- */
-
-#ifndef __ASM_ARCH_MAP_H
-#define __ASM_ARCH_MAP_H __FILE__
-
-#include <plat/map-base.h>
-
-#include <plat/map-s5p.h>
-
-#define EXYNOS_PA_CHIPID		0x10000000
-
-#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index e2ba70f..56e2554 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -22,8 +22,6 @@
 #include <asm/smp_scu.h>
 #include <asm/firmware.h>
 
-#include <mach/map.h>
-
 #include "common.h"
 
 extern void exynos4_secondary_startup(void);
-- 
1.9.1

