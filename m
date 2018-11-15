Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D21C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45A2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WBkP5uz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E45A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbeKPBVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:21:04 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:32322 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388042AbeKPBVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:21:03 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181115151245epoutp0309b65af1737959b62796cdaf78b6b2ca~nVOrxDkmp0615306153epoutp03Z;
        Thu, 15 Nov 2018 15:12:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181115151245epoutp0309b65af1737959b62796cdaf78b6b2ca~nVOrxDkmp0615306153epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542294765;
        bh=53jrnAIEHMLD+N9qBU0mnqtaMu0kY4ai74T8GgiAMks=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=WBkP5uz/W0kugZUb4DeX3S2kj5wEKylIVH3XP0u4snHGiAGf/xub5A/3VxxI5e4/K
         aukZ+UO2+j1esuWZsGerztKaJVRABvSR4PdGzNpDclUR6evVgeINbsJs3GV+gVwpCF
         etfpViLvcm5XS+yEepE3YFiw41GujIqtyajU+POk=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181115151244epcas1p1e844a94abe3a03cacc9ffa78b525446b~nVOq-rit83268032680epcas1p1C;
        Thu, 15 Nov 2018 15:12:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.FF.04149.CEC8DEB5; Fri, 16 Nov 2018 00:12:44 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181115151243epcas1p382a3d1704a8ee0d1b0e0b7d214d11ec4~nVOpyKR7r3141131411epcas1p3u;
        Thu, 15 Nov 2018 15:12:43 +0000 (GMT)
X-AuditID: b6c32a38-653ff70000001035-f2-5bed8cece776
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 77.B9.03701.BEC8DEB5; Fri, 16 Nov
        2018 00:12:43 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI8006WJQ7YQ380@mmp2.samsung.com>; Fri, 16 Nov 2018
        00:12:43 +0900 (KST)
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
Subject: [PATCH 8/9] ARM: SAMSUNG: remove s5p_init_cpu()
Date:   Thu, 15 Nov 2018 16:11:37 +0100
Message-id: <1542294698-17470-9-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCmvu6bnrfRBp83y1ncWneO1eLvpGPs
        FhtnrGe1uP7lOavFwmnLGS36H79mtjh/fgO7xabH11gtLu+aw2Yx4/w+JouXR34wWqw9cpfd
        YtHWL+wOvB6/f01i9Lh1p95j06pONo/NS+o93u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6
        dglcGffv3GEvWClRsXDebeYGxk0iXYycHBICJhJzb31n6WLk4hAS2MEoceDjNkYI5zujxNFP
        d1hgqmYd+w9VtYFR4sXOHiYI5xejxNtFy1hBqtgErCQmtq9iBLFFBDQlrv/9DhZnFjjKLLHk
        igSILSxgIXFm1xpmEJtFQFXi6MEXYDavgIfErDV7mSC2yUmcPDYZrJdTwFNi+9l2ZpBlEgJH
        2CRuvDzDClHkIjFl+2KoBmGJV8e3sHcxcgDZ0hKXjtpC1E9nlHjzaykLhLOeUWLNmWNQDdYS
        h49fhLqOT+Ld1x5WiGZeiY42IYgSD4k1a05Aw2IOo8SRzlnsExglFzAyrGIUSy0ozk1PLTYs
        MNErTswtLs1L10vOz93ECI5mLYsdjHvO+RxiFOBgVOLhNSh/Gy3EmlhWXJl7iFGCg1lJhNet
        DijEm5JYWZValB9fVJqTWnyIUZqDRUmc94nU3GghgfTEktTs1NSC1CKYLBMHp1QDo9GCR2cM
        vjtkhEx/2p0vmRh7WHJS0sE3tkkfNDju71zQJOy6LTd0xq+il+dvREy8dON/U4qIPs/rOXeF
        z6S43WF9PfN65PbTt4vC/V7JnTAJyaqMne4tXTCH+ZO+QfqNZ6pflFMm7VdU3Fju4HNsnvOp
        O/0RtxpEZtvIS21W/Sqkfv634fMzR5RYijMSDbWYi4oTAdebtJ3iAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsVy+t9jQd3XPW+jDbrn8VrcWneO1eLvpGPs
        FhtnrGe1uP7lOavFwmnLGS36H79mtjh/fgO7xabH11gtLu+aw2Yx4/w+JouXR34wWqw9cpfd
        YtHWL+wOvB6/f01i9Lh1p95j06pONo/NS+o93u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6
        dglcGffv3GEvWClRsXDebeYGxk0iXYycHBICJhKzjv1n6WLk4hASWMcoMfnqUnYI5xejxIrz
        25lAqtgErCQmtq9iBLFFBDQlrv/9zgpSxCxwlFni84TtzCAJYQELiTO71oDZLAKqEkcPvgCz
        eQU8JGat2csEsU5O4uSxyawgNqeAp8T2s+1gNUJANZ//nmGfwMizgJFhFaNkakFxbnpusVGB
        YV5quV5xYm5xaV66XnJ+7iZGYFBuO6zVt4Px/pL4Q4wCHIxKPLwG5W+jhVgTy4orcw8xSnAw
        K4nwutUBhXhTEiurUovy44tKc1KLDzFKc7AoifPezjsWKSSQnliSmp2aWpBaBJNl4uCUamDc
        zpvaXn+svEsiPvqDt5PQ3l1ujZP1WssPfTmuZFHFqf7dsVzpO0vi83dbHLufxdoXG5iaTLyX
        aWvKc+zcq/kWi2byf7zS9F/MaIFo9fkCwxIW69NO9eKmMSf5ur4ytEVKiDsdmXD4Y5+q2b2K
        mtN3zn/xFLZIO35Pet61sokND234X/s5/lRiKc5INNRiLipOBAD+V+SjRgIAAA==
X-CMS-MailID: 20181115151243epcas1p382a3d1704a8ee0d1b0e0b7d214d11ec4
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181115151243epcas1p382a3d1704a8ee0d1b0e0b7d214d11ec4
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181115151243epcas1p382a3d1704a8ee0d1b0e0b7d214d11ec4@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove no longer needed s5p_init_cpu() & co.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c                | 28 ----------------------------
 arch/arm/plat-samsung/cpu.c                  |  7 -------
 arch/arm/plat-samsung/include/plat/cpu.h     |  1 -
 arch/arm/plat-samsung/include/plat/map-s5p.h |  2 --
 4 files changed, 38 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index ca367b7..d98574c 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -20,7 +20,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/map.h>
-#include <plat/cpu.h>
 
 #include "common.h"
 
@@ -99,36 +98,9 @@ void __init exynos_sysram_init(void)
 	}
 }
 
-static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
-					int depth, void *data)
-{
-	struct map_desc iodesc;
-	const __be32 *reg;
-	int len;
-
-	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid"))
-		return 0;
-
-	reg = of_get_flat_dt_prop(node, "reg", &len);
-	if (reg == NULL || len != (sizeof(unsigned long) * 2))
-		return 0;
-
-	iodesc.pfn = __phys_to_pfn(be32_to_cpu(reg[0]));
-	iodesc.length = be32_to_cpu(reg[1]) - 1;
-	iodesc.virtual = (unsigned long)S5P_VA_CHIPID;
-	iodesc.type = MT_DEVICE;
-	iotable_init(&iodesc, 1);
-	return 1;
-}
-
 static void __init exynos_init_io(void)
 {
 	debug_ll_io_init();
-
-	of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
-
-	/* detect cpu id and rev. */
-	s5p_init_cpu(S5P_VA_CHIPID);
 }
 
 /*
diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
index c633a24..8acba21 100644
--- a/arch/arm/plat-samsung/cpu.c
+++ b/arch/arm/plat-samsung/cpu.c
@@ -29,10 +29,3 @@ void __init s3c64xx_init_cpu(void)
 
 	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
 }
-
-void __init s5p_init_cpu(const void __iomem *cpuid_addr)
-{
-	samsung_cpu_id = readl_relaxed(cpuid_addr);
-
-	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
-}
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 02d7f99..93ecd71 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -109,7 +109,6 @@ extern void s3c_init_cpu(unsigned long idcode,
 extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
 
 extern void s3c64xx_init_cpu(void);
-extern void s5p_init_cpu(const void __iomem *cpuid_addr);
 
 extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index d69a0ca..3812085 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -9,8 +9,6 @@
 #ifndef __ASM_PLAT_MAP_S5P_H
 #define __ASM_PLAT_MAP_S5P_H __FILE__
 
-#define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
-
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
 #define VA_VIC1			VA_VIC(1)
-- 
1.9.1

