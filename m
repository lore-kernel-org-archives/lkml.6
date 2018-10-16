Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D1EC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6621D20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PFQ0Vjt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6621D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJPWrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57190 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeJPWrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145652euoutp01c02ac10f2132f26dd9de8a62f98e2e26~eHqPzpvwl0464804648euoutp01b
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016145652euoutp01c02ac10f2132f26dd9de8a62f98e2e26~eHqPzpvwl0464804648euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701812;
        bh=y7MF9kAG/z4G8E42/Z3AEQeoUsGLouZid29J2XiBp+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFQ0Vjt0WhKD3sxtO4KCaWuOHhQd7eGmHMYtdUKThlXD4P3s6iWJqSZzTD+KnMn6k
         4qlmusR5OQEUJi0LXWTlfN3BXydPM79N003enmtjFpf+yAbFRWheSVuBfQBVOBvV5L
         VwDrrvKAQCNng6qzUFl3bgMpW62x8H7S6V+Ur/l8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016145651eucas1p1d65fd75ab153f72c55aed77baf105318~eHqPHWgua2005420054eucas1p1g;
        Tue, 16 Oct 2018 14:56:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.31.04806.23CF5CB5; Tue, 16
        Oct 2018 15:56:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0~eHqOSKKqJ2135421354eucas1p2J;
        Tue, 16 Oct 2018 14:56:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016145650eusmtrp264e52f5fdb23d28255e0c19e252e3dd6~eHqODLtlz3061930619eusmtrp2c;
        Tue, 16 Oct 2018 14:56:50 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-95-5bc5fc326091
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 92.BA.04128.13CF5CB5; Tue, 16
        Oct 2018 15:56:49 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145649eusmtip2c629b262ada1726386114c335e522aa0~eHqNR6rL92834528345eusmtip2G;
        Tue, 16 Oct 2018 14:56:49 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 08/11] DT: arm: exynos4: add support for thermal trip
 irq-mode
Date:   Tue, 16 Oct 2018 16:56:19 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzv9zz3PPe4dXkc049U27U22iKj9mzJWP3xTLXpz7o/dPIMyx3d
        g7AW2nCMk2pe607JS5eSIzviEofKvEXI0AsuoVYdW+Yij+eq/z7fz8v389t3PwKVGDF3IloZ
        z6iU8hgpLhI0da/2H/SzdckOlS4hVH1xHUbNtmcBSmvdTenM/RilGxnFqPyZRZQaGHgipCbS
        PCjDzCZ1N/O+gBpuuY1T1jwzoCrHhhAqo80spGY/avAgR7pWWwvo5tIpIV3R+gWhDfpsnJ4c
        bcXphvupdIXmJka/+NaK0JpGPaCthj2honOigAgmJjqRUfkEnhdFLY8Exv0WJ90zO6SBDVEO
        cCAg6Q/nF6cEOUBESMgaANeaLfZhGcBb08UYP1gBfJjOKXxkoWJSyAvVANoW1MJ/kcXn35Ec
        QBA46Q2N+ksc70KWAWg1VWyZULIAgQXVFoxb5UyGwrmlMZzDAnI/NKebhHzFHviuPxvlsAN5
        Ek6Ml6NcGJKvhfDZgG7LJCYTobrqMcYHTsCy6ULAY2e40NNoX+QBN5p1CI9Z2KfW4zy+ArNe
        Ge2eo7CzZwjjXo2SXrCuxYeng2HRShXO0ZDcAce/OnE0uglvNBWhPC2G6kwJ7/aEjbmD9iJX
        WF1baF9Ow7YbjxD+PtrNk65okOtgb+n/snIA9GAnk8AqIhnWT8lc9mblCjZBGel9IVZhAJv/
        qXe9Z8UITLbwDkASQLpd/GvMLJNg8kQ2WdEBIIFKXcSRb7pkEnGEPDmFUcWGqRJiGLYD7CIE
        0p3iKm29TEJGyuOZiwwTx6j+qgjh4J4GgoZNVzOn1rp1xzvvKLK80BnPB7KclvmwypmkkrNB
        LwNSlkd8W/P02Y5uxo/kj7kP25zcg7Vn1ntTTqf6t4tcG6TKa5VHSsJRS2nI3X2IpfZwVs3t
        zxPH+tj3ubP5V0XjpwaRK58ET01uKxndOkeJBvysDLG5riEZhlVc0+P3Vipgo+S+B1AVK/8D
        xSQhNUsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7qGf45GG/SssbHYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFv2PXzNbnD+/gd3iVoOMxabHQKGFbUtYLC7vmsNm8bn3CKPF0usX
        mSxa9x5ht3jysI/Ngd9jzbw1jB47Z91l91i85yWTx6ZVnWwed67tYfPYvKTeY3HfZFaPg+/2
        MHn0bVnF6PF5k1wAV5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpq
        TmZZapG+XYJexpcrdgV/eSsWHeFsYPzP1cXIySEhYCLxavEd9i5GLg4hgaWMEjcW/2GESIhJ
        TNq3nR3CFpb4c62LDcQWEvjEKPHosXcXIwcHm4CexI5VhSC9IgLzGSWObrrMBuIwC8xlkljZ
        sJwJpEFYwE9i0v93rCA2i4CqxJHGfWBDeQW8JPa/fwG1TE7i5rlOZhCbU8Bb4taNBcwgC4SA
        ai4uZpzAyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYKxsO/Zzyw7GrnfBhxgFOBiV
        eHh/XD8SLcSaWFZcmXuIUYKDWUmEN/3S0Wgh3pTEyqrUovz4otKc1OJDjKZAN01klhJNzgfG
        cV5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsaWbSKLeHjZQ3om
        ltbN1ImbrtT+atUKgWh+x311ZziXa+ckHtfNvMZzWu9m0rqg2utvO2xWByzcqxdvt2JG9qJ/
        kizFGUxyTU8ufNNdFS2meLFwy653xZL8pTo6Ew4F/q5Q8X4sfe3/h1UTZQycnCp/6PvU7Dvk
        ctzoqFDR/qe/bk9NPqNzJ1QJaESioRZzUXEiANFOkrCrAgAA
Message-Id: <20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0~eHqOSKKqJ2135421354eucas1p2J@eucas1p2.samsung.com>
X-CMS-MailID: 20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for new flash which indicates
that trip point triggers irq when temperature is met.
Exynos5433 supports 8 trip point which will trigger irq.
Above that number other trip points should be registered
without 'irq-mode' flag.
That will force the thermal framework to start polling
the temperature sensor under configured conditions and
handle the trip point.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
index 021d9fc..5e07289 100644
--- a/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
@@ -17,22 +17,26 @@ thermal-zones {
 			cpu_alert0: cpu-alert-0 {
 				temperature = <70000>; /* millicelsius */
 				hysteresis = <10000>; /* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			cpu_alert1: cpu-alert-1 {
 				temperature = <95000>; /* millicelsius */
 				hysteresis = <10000>; /* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			cpu_alert2: cpu-alert-2 {
 				temperature = <110000>; /* millicelsius */
 				hysteresis = <10000>; /* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			cpu_crit0: cpu-crit-0 {
 				temperature = <120000>; /* millicelsius */
 				hysteresis = <0>; /* millicelsius */
 				type = "critical";
+				irq-mode;
 			};
 		};
 		cooling-maps {
-- 
2.7.4

