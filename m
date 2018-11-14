Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC61C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB49122360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sofo6MX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB49122360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbeKOBeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:34:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59252 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733233AbeKOBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:34:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181114153101euoutp02a0b563e4724b341d0cbcb932dc65a794~nB1WEfljg3122031220euoutp02S
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:31:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181114153101euoutp02a0b563e4724b341d0cbcb932dc65a794~nB1WEfljg3122031220euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542209461;
        bh=tGeLJ0zJAa4AtbzWtUaLXivm2mYwCERxugzHwyHQB3U=;
        h=To:Cc:From:Subject:Date:References:From;
        b=sofo6MX5U7leXBxl06AI02g4g6+maJ24PzMwPbk0wmtBlbpdVk2Y/f8yYpQ7GZTUd
         XR8vtdWLIRYjgONq6ehiptwPtIohAed09Bw92HTZ3F5r8HvpeOjSbJG+m9FIlMVPqZ
         qoGjew9Kh65fRkWtp5L0BfygQhI/fFySXmHQ3RVE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181114153100eucas1p24b3e152fde079455082a3bfaeeb86227~nB1VqGOtk2481024810eucas1p20;
        Wed, 14 Nov 2018 15:31:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9F.32.04441.4BF3CEB5; Wed, 14
        Nov 2018 15:31:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181114153100eucas1p1a48e0febdfacfe40dd08c91a6b0d045e~nB1U7iQu61663516635eucas1p1G;
        Wed, 14 Nov 2018 15:31:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181114153059eusmtrp1cb228619a8d82e577547ec9061296dac~nB1Us_M-f1901319013eusmtrp1U;
        Wed, 14 Nov 2018 15:30:59 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-be-5bec3fb4119d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 59.4E.04128.3BF3CEB5; Wed, 14
        Nov 2018 15:30:59 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181114153059eusmtip1c62ad51d0cf0abd9ffdf39e5a36240f9~nB1UZa6hp0883608836eusmtip1c;
        Wed, 14 Nov 2018 15:30:59 +0000 (GMT)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
Message-ID: <f38311a0-ed37-49e6-cae1-62dfb30c7325@samsung.com>
Date:   Wed, 14 Nov 2018 16:30:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7pb7N9EG3x5qmyxccZ6Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyeLQ1L2MDuwel69dZPbYtKqTzWPzknqPvi2rGD0+b5IL
        YI3isklJzcksSy3St0vgypg1+ydzwVvxite777M3MHaJdDFyckgImEgs2z6ZsYuRi0NIYAWj
        xKLvb9khnC+MEt0Nl6Aynxkl+rduY4Zp+bBqKzNEYjmjxPXZ3awQzntGiXv9i9hBqkQENCWu
        //0OlmAWeMUo0TB7LxNIgk3ASmJi+yqguRwcwgIJEl0TTUHCvAJ2ErPPzGcBCbMIqEqsuekM
        YooKREj0n1GHqBCUODnzCQuIzSwgL7H97RywGyQEutkl/u9+xARxnIvE3icTGCFsYYlXx7ew
        Q9gyEqcn97BANExnlHjzaymUs55RYs2ZY1Dd1hKHj19kBdnMDPTA+l36EGFHiY/vd4KFJQT4
        JG68FYQ4gk9i0rbpzBBhXomONiGIajWJDcs2sMGs7dq5EhpuHhLvZp8De1xIIFbi4fuYCYwK
        s5B8NgvJZ7MQTljAyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMM2c/nf80w7Gr5eS
        DjEKcDAq8fA+uPEqWog1say4MvcQowQHs5IIr7/Bm2gh3pTEyqrUovz4otKc1OJDjNIcLEri
        vNUMD6KFBNITS1KzU1MLUotgskwcnFINjEotVpwG5+Z5bb67W7hDu/aBWsZyplUhcvWGex7o
        O0cdZuX9alVZXbXS/tj9Oe6JB01kvcVyWnYuFn2vOV21w1VEWibgtQvb4Ss2a1NYVi4603h8
        1dW5BQfWTdnR8X9pa6bS9TYHtrLz82akmfx46mPTsvSx9xmZTK0Yxn8ZlsUHjt9MuzTTR4ml
        OCPRUIu5qDgRABjzwmIvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Xd3N9m+iDT40GFhsnLGe1aL/8Wtm
        i/PnN7BbbHp8jdXi8q45bBYzzu9jsjg0dS+jA7vH5WsXmT02repk89i8pN6jb8sqRo/Pm+QC
        WKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MmbN
        /slc8Fa84vXu++wNjF0iXYycHBICJhIfVm1l7mLk4hASWMoo0fb6HXsXIwdQQkbi+PoyiBph
        iT/Xutggat4yShw4vYkNJCEioClx/e93VpAEs8ArRok9E88zgiTYBKwkJravYgQZJCyQINE1
        0RQkzCtgJzH7zHwWkDCLgKrEmpvOIGFRgQiJWw87WCBKBCVOznwCZjMLqEv8mXeJGcKWl9j+
        dg7zBEb+WUjKZiEpm4WkbAEj8ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAeNh27OeWHYxd
        74IPMQpwMCrx8D648SpaiDWxrLgy9xCjBAezkgivv8GbaCHelMTKqtSi/Pii0pzU4kOMpkB3
        T2SWEk3OB8ZqXkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC1CKYPiYOTqkGxnhT
        efl8Xw8H2eVn6j0Dpq23unTrquwUzkNv5hW+n2Zw+PCkpCUXzcw/eB++c+/gxmkmS93/rPh8
        xIVdWi9BeYnZNafdPddm7zn5KnRqt5jox8K67TJljtOrEzx6drMr950zDtZmdu40mnA57BRf
        4eZIzy2zG6zyb9wI6LWW+K1z0barY8cTDSWW4oxEQy3mouJEAAB1SdadAgAA
X-CMS-MailID: 20181114153100eucas1p1a48e0febdfacfe40dd08c91a6b0d045e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181114153100eucas1p1a48e0febdfacfe40dd08c91a6b0d045e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181114153100eucas1p1a48e0febdfacfe40dd08c91a6b0d045e
References: <CGME20181114153100eucas1p1a48e0febdfacfe40dd08c91a6b0d045e@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
config option) is not working properly (debug messages are not
displayed after resume) on Exynos platforms because GPIOs restore
code is not implemented.

Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
Then convert Exynos code to not require <plat/pm-common.h>
header (use pr_debug() directly instead of S3C_PMDBG() macro and
remove redundant s3c_pm_*() calls).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v4:
- rebased on top of next-20181114

v3:
- don't move PM to the line below in Kconfig

v2:
- convert Exynos code to not require <plat/pm-common.h> header

 arch/arm/mach-exynos/suspend.c |   14 ++++----------
 arch/arm/plat-samsung/Kconfig  |    1 +
 2 files changed, 5 insertions(+), 10 deletions(-)

Index: b/arch/arm/mach-exynos/suspend.c
===================================================================
--- a/arch/arm/mach-exynos/suspend.c	2018-11-14 16:01:05.095080862 +0100
+++ b/arch/arm/mach-exynos/suspend.c	2018-11-14 16:03:36.699084680 +0100
@@ -30,8 +30,6 @@
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
-#include <plat/pm-common.h>
-
 #include "common.h"
 
 #define REG_TABLE_END (-1U)
@@ -498,11 +496,9 @@ static int exynos_suspend_enter(suspend_
 	u32 eint_wakeup_mask = exynos_read_eint_wakeup_mask();
 	int ret;
 
-	s3c_pm_debug_init();
-
-	S3C_PMDBG("%s: suspending the system...\n", __func__);
+	pr_debug("%s: suspending the system...\n", __func__);
 
-	S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
+	pr_debug("%s: wakeup masks: %08x,%08x\n", __func__,
 		  exynos_irqwake_intmask, eint_wakeup_mask);
 
 	if (exynos_irqwake_intmask == -1U
@@ -512,7 +508,6 @@ static int exynos_suspend_enter(suspend_
 		return -EINVAL;
 	}
 
-	s3c_pm_save_uarts();
 	if (pm_data->pm_prepare)
 		pm_data->pm_prepare();
 	flush_cache_all();
@@ -525,12 +520,11 @@ static int exynos_suspend_enter(suspend_
 
 	if (pm_data->pm_resume_prepare)
 		pm_data->pm_resume_prepare();
-	s3c_pm_restore_uarts();
 
-	S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
+	pr_debug("%s: wakeup stat: %08x\n", __func__,
 			pmu_raw_readl(S5P_WAKEUP_STAT));
 
-	S3C_PMDBG("%s: resuming the system...\n", __func__);
+	pr_debug("%s: resuming the system...\n", __func__);
 
 	return 0;
 }
Index: b/arch/arm/plat-samsung/Kconfig
===================================================================
--- a/arch/arm/plat-samsung/Kconfig	2018-11-14 16:01:05.095080862 +0100
+++ b/arch/arm/plat-samsung/Kconfig	2018-11-14 16:01:05.055080861 +0100
@@ -239,6 +239,7 @@ comment "Power management"
 config SAMSUNG_PM_DEBUG
 	bool "Samsung PM Suspend debug"
 	depends on PM && DEBUG_KERNEL
+	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
