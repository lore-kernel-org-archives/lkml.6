Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01A8C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD2C2245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FMG11F9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD2C2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbeKPBUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:20:54 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:58259 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388615AbeKPBUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:20:52 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181115151236epoutp021293842fd5b2373005a8a4dc87ed6c06~nVOjP3iw62573825738epoutp02H;
        Thu, 15 Nov 2018 15:12:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181115151236epoutp021293842fd5b2373005a8a4dc87ed6c06~nVOjP3iw62573825738epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542294756;
        bh=69RbD6GTi1cC4wdBdTW6otNhXoInfb9R1q91ZnYeExc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=FMG11F9Kdz0c8OIC0UE78aCIQPPMavE0cFr/d+sUi1MSfNHoQZh7OWpHE46FcY06V
         FnUmwYH/YIStCh2UEiVqcO3FjGEzNeRj3ehvZDH1zDLypZuppcIkeyT7xu50v9ZlWZ
         zKBektNytTV0jyqgkTJ2m3vwgx48i4aLiTz4RgN8=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181115151235epcas1p32a5c7c399985b92ca0f61f1a9f127649~nVOiuJM961924719247epcas1p3P;
        Thu, 15 Nov 2018 15:12:35 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.E3.04072.3EC8DEB5; Fri, 16 Nov 2018 00:12:35 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181115151234epcas1p2006b64ae88567526c855869758ff8b9c~nVOhlq8D01093210932epcas1p2Y;
        Thu, 15 Nov 2018 15:12:34 +0000 (GMT)
X-AuditID: b6c32a37-887ff70000000fe8-5c-5bed8ce3c38b
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 96.B9.03701.2EC8DEB5; Fri, 16 Nov
        2018 00:12:34 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI8006WJQ7YQ380@mmp2.samsung.com>; Fri, 16 Nov 2018
        00:12:34 +0900 (KST)
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
Subject: [PATCH 6/9] ARM: EXYNOS: remove soc_is_exynos*() macros
Date:   Thu, 15 Nov 2018 16:11:35 +0100
Message-id: <1542294698-17470-7-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCmru7jnrfRBrMmaFjcWneO1eLvpGPs
        FhtnrGe1uP7lOavFwmnLGS36H79mtjh/fgO7xabH11gtLu+aw2Yx4/w+JouXR34wWqw9cpfd
        YtHWL+wOvB6/f01i9Lh1p95j06pONo/NS+o93u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6
        dglcGXM2fGIs+Cxa8XrlYeYGxn7hLkZODgkBE4lP+4+wdjFycQgJ7GCU6J1wngUkISTwnVHi
        25YimKK3E78xQRRtYJRY33iXDcL5xSixatNKNpAqNgEriYntqxhBbBEBTYnrf7+zgtjMAkeZ
        JZZckQCxhQUcJC4ceQNWwyKgKvH2ZxsTiM0r4CHx4/dfVohtchInj00GszkFPCW2n21nBlkm
        IXCATeL81DksEEUuEjc3f2CDsIUlXh3fwt7FyAFkS0tcOmoLUT+dUeLNr6UsEM56Rok1Z44x
        QTRYSxw+fhHqOj6Jd197WCGaeSU62oQgSjwkJj5cwAjx5Rygl1+8Y5vAKLmAkWEVo1hqQXFu
        emqxYYGxXnFibnFpXrpecn7uJkZwLGuZ72DccM7nEKMAB6MSD69B+dtoIdbEsuLK3EOMEhzM
        SiK8bnVAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxPpOZGCwmkJ5akZqemFqQWwWSZODilGhgX
        K/yv5rl0TjpzYd3p9docyzM3X7Y4fblGVzwbGK13rA15G50Xr78/YctsOb0n0So619L6dPZk
        HF4ZMufWBB3jhqp//Syzrhr0v/n/evPh0+ePBJU3/Qx17FbhyM8+pSbNdKL0abejj/79DTaO
        8u7zL6s+KTi1ZtpXhy9ba3n2ZewuV1eSP6nEUpyRaKjFXFScCABkiw7Y4QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t9jQd1HPW+jDV69lLC4te4cq8XfScfY
        LTbOWM9qcf3Lc1aLhdOWM1r0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBYvj/xgtFh75C67
        xaKtX9gdeD1+/5rE6HHrTr3HplWdbB6bl9R7vN93lc2jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4MuZs+MRY8Fm04vXKw8wNjP3CXYycHBICJhJvJ35jArGFBNYxSnz7y9bFyAVk/2KU+H54
        MTtIgk3ASmJi+ypGEFtEQFPi+t/vrCBFzAJHmSU+T9jODJIQFnCQuHDkDVgRi4CqxNufbWBT
        eQU8JH78/ssKsU1O4uSxyWA2p4CnxPaz7cwQmz0kPv89wz6BkWcBI8MqRsnUguLc9NxiowLD
        vNRyveLE3OLSvHS95PzcTYzAkNx2WKtvB+P9JfGHGAU4GJV4eA3K30YLsSaWFVfmHmKU4GBW
        EuF1qwMK8aYkVlalFuXHF5XmpBYfYpTmYFES572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwCi2
        8MZtszr3ltuikfpbH4qseLIqnJ1lCVNI4A+h21+33uQWOJ/6eYaL2o6DV27fF5l97WbDQstj
        W67ZbtFPsfDVl9J8us35WqaOTfVjwzONob2zMwpLp9aL2ZxaclCfVWfphz8WsaJ8dYVHNjIH
        mymwn1hTJyenEhPT26cS5RZ/TTb29ju/SiWW4oxEQy3mouJEAIHxlDdFAgAA
X-CMS-MailID: 20181115151234epcas1p2006b64ae88567526c855869758ff8b9c
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181115151234epcas1p2006b64ae88567526c855869758ff8b9c
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181115151234epcas1p2006b64ae88567526c855869758ff8b9c@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove no longer needed soc_is_exynos*() macros & co.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/common.h | 71 -------------------------------------------
 1 file changed, 71 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 20d205e..1dfd434 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -17,81 +17,10 @@
 extern bool soc_dev_is_exynos4412(void);
 extern bool soc_dev_is_exynos542x(void);
 
-#define EXYNOS3250_SOC_ID	0xE3472000
-#define EXYNOS3_SOC_MASK	0xFFFFF000
-
-#define EXYNOS4210_CPU_ID	0x43210000
-#define EXYNOS4412_CPU_ID	0xE4412200
-#define EXYNOS4_CPU_MASK	0xFFFE0000
-
-#define EXYNOS5250_SOC_ID	0x43520000
-#define EXYNOS5410_SOC_ID	0xE5410000
-#define EXYNOS5420_SOC_ID	0xE5420000
-#define EXYNOS5800_SOC_ID	0xE5422000
-#define EXYNOS5_SOC_MASK	0xFFFFF000
-
-extern unsigned long samsung_cpu_id;
-
-#define IS_SAMSUNG_CPU(name, id, mask)		\
-static inline int is_samsung_##name(void)	\
-{						\
-	return ((samsung_cpu_id & mask) == (id & mask));	\
-}
-
-IS_SAMSUNG_CPU(exynos3250, EXYNOS3250_SOC_ID, EXYNOS3_SOC_MASK)
-IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5410, EXYNOS5410_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
-
-#if defined(CONFIG_SOC_EXYNOS3250)
-# define soc_is_exynos3250()	is_samsung_exynos3250()
-#else
-# define soc_is_exynos3250()	0
-#endif
-
-#if defined(CONFIG_CPU_EXYNOS4210)
-# define soc_is_exynos4210()	is_samsung_exynos4210()
-#else
-# define soc_is_exynos4210()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS4412)
-# define soc_is_exynos4412()	is_samsung_exynos4412()
-#else
-# define soc_is_exynos4412()	0
-#endif
-
 #define EXYNOS4210_REV_0	(0x0)
 #define EXYNOS4210_REV_1_0	(0x10)
 #define EXYNOS4210_REV_1_1	(0x11)
 
-#if defined(CONFIG_SOC_EXYNOS5250)
-# define soc_is_exynos5250()	is_samsung_exynos5250()
-#else
-# define soc_is_exynos5250()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5410)
-# define soc_is_exynos5410()	is_samsung_exynos5410()
-#else
-# define soc_is_exynos5410()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5420)
-# define soc_is_exynos5420()	is_samsung_exynos5420()
-#else
-# define soc_is_exynos5420()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5800)
-# define soc_is_exynos5800()	is_samsung_exynos5800()
-#else
-# define soc_is_exynos5800()	0
-#endif
-
 extern u32 cp15_save_diag;
 extern u32 cp15_save_power;
 
-- 
1.9.1

