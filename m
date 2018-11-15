Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2539C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9355E22419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kbm/FROG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9355E22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbeKPBU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:20:58 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35720 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388042AbeKPBU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:20:58 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181115151241epoutp019cd3cc2d2447bf64356a4496d8fcb06e~nVOoKZ5w-0617906179epoutp01R;
        Thu, 15 Nov 2018 15:12:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181115151241epoutp019cd3cc2d2447bf64356a4496d8fcb06e~nVOoKZ5w-0617906179epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542294761;
        bh=JBJR81GnQ7cDGFh+5OLXFWkoCbExnC+5nkP6rmhEZgg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Kbm/FROGASnyGfp1S9Nj4TD/gDK79qsdqdHXvmdea5qwARcP+vJNQPOEc+BYoM0q3
         iI3aVLIW3HjsZ2UnydjUa0LMC974zLT7LXw0sVl1/uq4bpYmaJooFh+81DEfac4KDj
         EJmRNt3AQG5R91erUfsIBj/Q11gsV5+QG1ZB4c10=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181115151240epcas2p3b99ee0c45bb26570563668924f0217cd~nVOm1GJvK2217522175epcas2p3L;
        Thu, 15 Nov 2018 15:12:40 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.2C.04407.8EC8DEB5; Fri, 16 Nov 2018 00:12:40 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181115151238epcas2p1dd0da525c3cd2a7a4d153ced264b5b8f~nVOlpdmNH3092430924epcas2p1G;
        Thu, 15 Nov 2018 15:12:38 +0000 (GMT)
X-AuditID: b6c32a46-7a1ff70000001137-4f-5bed8ce82408
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id F4.28.03702.6EC8DEB5; Fri, 16 Nov
        2018 00:12:38 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI8006WJQ7YQ380@mmp2.samsung.com>; Fri, 16 Nov 2018
        00:12:38 +0900 (KST)
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
Subject: [PATCH 7/9] ARM: SAMSUNG: remove samsung_rev()
Date:   Thu, 15 Nov 2018 16:11:36 +0100
Message-id: <1542294698-17470-8-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCmue6LnrfRBt/2slncWneO1eLvpGPs
        FhtnrGe1uP7lOavFwmnLGS36H79mtjh/fgO7xabH11gtLu+aw2Yx4/w+JouXR34wWqw9cpfd
        YtHWL+wOvB6/f01i9Lh1p95j06pONo/NS+o93u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6
        dglcGZsndjEWzFOpuDBrGlsD4065LkZODgkBE4kpr7YzdjFycQgJ7GCUeP94IxOE851R4saF
        T4wwVU/XfoWq2sAocXnGahaQhJDAL0aJxom1IDabgJXExPZVYA0iApoS1/9+ZwWxmQWOMkss
        uSIBYgsLmEs8fLSWGcRmEVCV2P1hAVg9r4CHxJ0bE9gglslJnDw2GayXU8BTYvvZdmaQxRIC
        R9gkLvTdBGrgAHJcJCZct4eoF5Z4dXwLO4QtLfFs1UZGiPrpjBJvfi1lgXDWM0qsOXOMCaLK
        WuLw8YtQ1/FJdBz+yw4xlFeio00IosRD4smEKWwQH89hlNi5agXLBEbJBYwMqxjFUguKc9NT
        i40KjPSKE3OLS/PS9ZLzczcxgmNZy20H45JzPocYBTgYlXh4DcrfRguxJpYVV+YeYpTgYFYS
        4XWrAwrxpiRWVqUW5ccXleakFh9ilOZgURLnfSg9N1pIID2xJDU7NbUgtQgmy8TBKdXAKP9g
        d9jioEOWqtksPVb7rttH9ZaLt3QFbfuz9W5g/8rlFov81r199vzX20NVAcliia7blpS+1OiY
        /LT0MM8J9UknJeOM67fMjajkP7zz/eF5h0odc26/ua1w1iu3zkmMcVlVe0je4WXHZvVz2Dos
        EtYwW7Ho5FWdlAKNCxff7aypX3n+gVxyuBJLcUaioRZzUXEiANAVkdfhAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsVy+t9jQd1nPW+jDe5MMra4te4cq8XfScfY
        LTbOWM9qcf3Lc1aLhdOWM1r0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBYvj/xgtFh75C67
        xaKtX9gdeD1+/5rE6HHrTr3HplWdbB6bl9R7vN93lc2jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4MjZP7GIsmKdScWHWNLYGxp1yXYycHBICJhJP135l7GLk4hASWMcosexUE5Tzi1GifdVf
        FpAqNgEriYntqxhBbBEBTYnrf7+zghQxCxxllvg8YTszSEJYwFzi4aO1YDaLgKrE7g8LwBp4
        BTwk7tyYwAaxTk7i5LHJrCA2p4CnxPaz7WD1QkA1n/+eYZ/AyLOAkWEVo2RqQXFuem6xUYFR
        Xmq5XnFibnFpXrpecn7uJkZgUG47rNW/g/HxkvhDjAIcjEo8vAblb6OFWBPLiitzDzFKcDAr
        ifC61QGFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MK6b
        ePRx2NcSFYkP6bYvTJYLqwjLrPA+ErM59eM2X50SP5/rSwKOeOr+9Uu4uayhJeCHWMSS/XcF
        w2969WwNy/f//vXy3qi362T3lfruNAkV1DkoLtv3+uvhKH12nU+pT1SmfpnPMuXd0sCF1zc4
        1izve7qucZ0x9/F2+6KX4YnsVZfT9vIfSlBiKc5INNRiLipOBADMn1QpRgIAAA==
X-CMS-MailID: 20181115151238epcas2p1dd0da525c3cd2a7a4d153ced264b5b8f
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181115151238epcas2p1dd0da525c3cd2a7a4d153ced264b5b8f
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181115151238epcas2p1dd0da525c3cd2a7a4d153ced264b5b8f@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add soc_dev_is_exynos4210_rev11() helper.

* Convert exynos_boot_vector_{addr,flag}() to use chipid driver.

* Remove no longer needed samsung_rev() & co.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/common.h            |  6 +-----
 arch/arm/mach-exynos/exynos.c            |  6 ++++++
 arch/arm/mach-exynos/pm.c                |  8 ++++----
 arch/arm/plat-samsung/cpu.c              | 10 ----------
 arch/arm/plat-samsung/include/plat/cpu.h |  2 --
 5 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 1dfd434..322d6eb 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -13,14 +13,11 @@
 #include <linux/platform_data/cpuidle-exynos.h>
 
 extern bool soc_dev_is_exynos3250(void);
+extern bool soc_dev_is_exynos4210_rev10(void);
 extern bool soc_dev_is_exynos4210_rev11(void);
 extern bool soc_dev_is_exynos4412(void);
 extern bool soc_dev_is_exynos542x(void);
 
-#define EXYNOS4210_REV_0	(0x0)
-#define EXYNOS4210_REV_1_0	(0x10)
-#define EXYNOS4210_REV_1_1	(0x11)
-
 extern u32 cp15_save_diag;
 extern u32 cp15_save_power;
 
@@ -81,7 +78,6 @@ static inline void exynos_scu_enable(void) { }
 
 extern void exynos_set_delayed_reset_assertion(bool enable);
 
-extern unsigned int samsung_rev(void);
 extern void exynos_core_restart(u32 core_id);
 extern int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr);
 extern int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr);
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 463e457..ca367b7 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -29,6 +29,11 @@
 	{ /* sentinel */ }
 };
 
+static const struct soc_device_attribute exynos4210_rev10_soc_id[] = {
+	{ .soc_id = "EXYNOS4210", .revision = "10" },
+	{ /* sentinel */ }
+};
+
 static const struct soc_device_attribute exynos4210_rev11_soc_id[] = {
 	{ .soc_id = "EXYNOS4210", .revision = "11" },
 	{ /* sentinel */ }
@@ -59,6 +64,7 @@
 }
 
 SOC_DEV_IS_EXYNOS(3250);
+SOC_DEV_IS_EXYNOS(4210_rev10);
 SOC_DEV_IS_EXYNOS(4210_rev11);
 SOC_DEV_IS_EXYNOS(4412);
 SOC_DEV_IS_EXYNOS(542x);
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 88c1bce..0109dc4 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -26,18 +26,18 @@
 
 static inline void __iomem *exynos_boot_vector_addr(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
+	if (soc_dev_is_exynos4210_rev11())
 		return pmu_base_addr + S5P_INFORM7;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+	else if (soc_dev_is_exynos4210_rev10())
 		return sysram_base_addr + 0x24;
 	return pmu_base_addr + S5P_INFORM0;
 }
 
 static inline void __iomem *exynos_boot_vector_flag(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
+	if (soc_dev_is_exynos4210_rev11())
 		return pmu_base_addr + S5P_INFORM6;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+	else if (soc_dev_is_exynos4210_rev10())
 		return sysram_base_addr + 0x20;
 	return pmu_base_addr + S5P_INFORM1;
 }
diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
index e1ba88b..c633a24 100644
--- a/arch/arm/plat-samsung/cpu.c
+++ b/arch/arm/plat-samsung/cpu.c
@@ -14,13 +14,6 @@
 #include <plat/cpu.h>
 
 unsigned long samsung_cpu_id;
-static unsigned int samsung_cpu_rev;
-
-unsigned int samsung_rev(void)
-{
-	return samsung_cpu_rev;
-}
-EXPORT_SYMBOL(samsung_rev);
 
 void __init s3c64xx_init_cpu(void)
 {
@@ -34,15 +27,12 @@ void __init s3c64xx_init_cpu(void)
 		samsung_cpu_id = readl_relaxed(S3C_VA_SYS + 0xA1C);
 	}
 
-	samsung_cpu_rev = 0;
-
 	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
 }
 
 void __init s5p_init_cpu(const void __iomem *cpuid_addr)
 {
 	samsung_cpu_id = readl_relaxed(cpuid_addr);
-	samsung_cpu_rev = samsung_cpu_id & 0xFF;
 
 	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
 }
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index fadcddb..02d7f99 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -111,8 +111,6 @@ extern void s3c_init_cpu(unsigned long idcode,
 extern void s3c64xx_init_cpu(void);
 extern void s5p_init_cpu(const void __iomem *cpuid_addr);
 
-extern unsigned int samsung_rev(void);
-
 extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 
 extern void s3c24xx_init_clocks(int xtal);
-- 
1.9.1

