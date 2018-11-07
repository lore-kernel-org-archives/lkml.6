Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8DBC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE8D20892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A8UKzSEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE8D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbeKHCmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:42:06 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57282 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387748AbeKHCmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:42:05 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171048euoutp029aae1b606b099d2ffce7941c7e361254~k5reMmh9Y0487204872euoutp02G
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181107171048euoutp029aae1b606b099d2ffce7941c7e361254~k5reMmh9Y0487204872euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610648;
        bh=j2GktXyQbjXJYo/9DZqWr6nunDcw0w3TtES28PEn4n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8UKzSEcsW+CXBacrKjXXa9BOLD791qG8NHs5CpxRxhGJ9qlhO5J46jgZsXZ/LSn7
         QPrTEa4POyYvlzURBgE0ZnttEvkfQhRzWYhECb+qgqYA5ndLbTv8wuiGgTvvTG4rdl
         QmxEPG+6/flVL3nssCNgOhvlWMOMvv5i+pu0r+pc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181107171047eucas1p11341124036157577ee4258431daa8dea~k5rdRrNsa2905829058eucas1p1t;
        Wed,  7 Nov 2018 17:10:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8B.64.04294.79C13EB5; Wed,  7
        Nov 2018 17:10:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181107171046eucas1p1649bcf14a88ef9dd183724dde3a98f8c~k5rcmCZCe2318323183eucas1p1L;
        Wed,  7 Nov 2018 17:10:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181107171046eusmtrp2d86b72f3c56e5455a1cbf811218cfc0b~k5rcZx1or0545505455eusmtrp2n;
        Wed,  7 Nov 2018 17:10:46 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-cf-5be31c9779a5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.8F.04284.69C13EB5; Wed,  7
        Nov 2018 17:10:46 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171045eusmtip2fab1dd73faf596046862e328f3716137~k5rbzAmhG0340803408eusmtip2W;
        Wed,  7 Nov 2018 17:10:45 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 11/11] arm: dts: exynos5410: add support for thermal trip
 irq-mode
Date:   Wed,  7 Nov 2018 18:09:53 +0100
Message-Id: <1541610593-28542-12-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87rTZR5HG7T947PYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFv2PXzNbnD+/gd3iVoOMxabHQKGFbUtYLC7vmsNm8bn3CKPFjPP7
        mCyWXr/IZNG69wi7xZOHfWwOAh5r5q1h9Ng56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUei/sm
        s3ocfLeHyaNvyypGj8+b5AK4orhsUlJzMstSi/TtErgyNs39wVwwkadi+c1nTA2Mlzm7GDk5
        JARMJOY0TWHpYuTiEBJYwShx+uhMNgjnC6PE1oOXoDKfGSXmLm5kg2mZeGkDE0RiOaPE49ON
        zHAtz1sPAzkcHGwCehI7VhWCxEUEZjNKfN63mB3EYRZYwCTx8fdaFpBRwgLhEtubDjCB2CwC
        qhInP/wEs3kFvCXu/f/ICLFOTuLmuU5mEJsTKD7v8luwQRIC19glJn+eyA5R5CKx+2oT1H3C
        Eq+Ob4GKy0j83zmfCcIuljjbsQqqpkai/eQOqBpricPHL7KCXM0soCmxfpc+RNhRYs+Dr2Bh
        CQE+iRtvBUHCzEDmpG3TmSHCvBIdbUIQ1RoSW3ouQC0Sk1i+ZhrUcA+Jb+v3s0LCZx6jxJLe
        w6wTGOVnISxbwMi4ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzBZnf53/MsOxl1/kg4x
        CnAwKvHwXtj6MFqINbGsuDL3EKMEB7OSCG/v6kfRQrwpiZVVqUX58UWlOanFhxilOViUxHmr
        GR5ECwmkJ5akZqemFqQWwWSZODilGhhtz+x0bVwwP9W/RJf/dNujLauknKJMb+f809oQbqyy
        o/i2Stui2DDmpa+2Cc5u2pTwwkzpkG/+X1H7VyHtByVqvjr3PMpICD+7auo+pgdmZ7Vd/5nM
        kXV7na0aK32kNP9pRU5lKSvHx22iruymZfrHemLcZD5a7WMxfeScLzbbnLVLqqb6jBJLcUai
        oRZzUXEiAJxfI3RSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7rTZB5HGzxcomCxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLfofv2a2OH9+A7vFrQYZi02PgUIL25awWFzeNYfN4nPvEUaLGef3
        MVksvX6RyaJ17xF2iycP+9gcBDzWzFvD6LFz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9FvdN
        ZvU4+G4Pk0ffllWMHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlbJr7g7lgIk/F8pvPmBoYL3N2MXJySAiYSEy8tIGpi5GLQ0hgKaPE
        3RO32CASYhKT9m1nh7CFJf5c62KDKPrEKLH3TDNrFyMHB5uAnsSOVYUgcRGB+YwSRzddBiti
        FljDJLH10HlGkG5hgVCJNx1bWEFsFgFViZMffjKB2LwC3hL3/n9khNggJ3HzXCcziM0JFJ93
        +S3YZiEBL4nvs9azTWDkW8DIsIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwerYd+7l5B+Ol
        jcGHGAU4GJV4eDV2PIwWYk0sK67MPcQowcGsJMLbu/pRtBBvSmJlVWpRfnxRaU5q8SFGU6Cj
        JjJLiSbnAyM7ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDY/OR
        z+6HG5Vskqf6bp3Xaa4nU9W9XkNl0VxWr80NetVSd2adne5lfmmOknjKNoH0g1sTFHU5b4tu
        2M3qd+Ko6KFnT0z3KBS1hdz4k3AhL/VW/jnLZN/sANNaRhHGFTdX7npbe3BWWubyFguDPr13
        p96+bTqflMO72H9NydeLWdWHTBJn6vbMVmIpzkg01GIuKk4EAEHuFfG0AgAA
X-CMS-MailID: 20181107171046eucas1p1649bcf14a88ef9dd183724dde3a98f8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171046eucas1p1649bcf14a88ef9dd183724dde3a98f8c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171046eucas1p1649bcf14a88ef9dd183724dde3a98f8c
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171046eucas1p1649bcf14a88ef9dd183724dde3a98f8c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for new flag which indicates
that trip point triggers IRQ when temperature is met.
Change existing trip points to be expicitly marked with the new flag.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 434a759..e85a5d6 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -121,22 +121,26 @@
 		cpu_alert0: cpu-alert-0 {
 			temperature = <50000>; /* millicelsius */
 			hysteresis = <5000>; /* millicelsius */
-			type = "active";
+			type = "passive";
+			irq-mode;
 		};
 		cpu_alert1: cpu-alert-1 {
 			temperature = <60000>; /* millicelsius */
 			hysteresis = <5000>; /* millicelsius */
-			type = "active";
+			type = "passive";
+			irq-mode;
 		};
 		cpu_alert2: cpu-alert-2 {
 			temperature = <70000>; /* millicelsius */
 			hysteresis = <5000>; /* millicelsius */
-			type = "active";
+			type = "passive";
+			irq-mode;
 		};
 		cpu_crit0: cpu-crit-0 {
 			temperature = <120000>; /* millicelsius */
 			hysteresis = <0>; /* millicelsius */
 			type = "critical";
+			irq-mode;
 		};
 	};
 
-- 
2.7.4

