Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F6DC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D46208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hpVlZ6W3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D46208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbeLNM2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:28:50 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35266 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbeLNMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181214121039euoutp027c566b8af25f1946fb1dae7b80991075~wMc_DCh-G0907809078euoutp02F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:10:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181214121039euoutp027c566b8af25f1946fb1dae7b80991075~wMc_DCh-G0907809078euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544789439;
        bh=6ARc7iWdZfumely2HxB8s/ziJnPFxA3nmaIxyF0uLk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpVlZ6W3xIvWn8mrOcxCEypcM2VvOXjmDn/ObyIQ/ycye3Ujf0feIsHIw/5jco7CY
         q+x+kD/ZTFeUsAHjxjPaTITHk/BPzF/XyG5MHX9P/hGSQ3Y9grmHB1arQ9gmPrbWRO
         fnk4D5LRbLdPPKiJ+46I1/ORJwaXCHiFaicXdkI0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181214121038eucas1p1d7dac6bc6d989211d7f26458f232a64d~wMc9M6dk70507605076eucas1p1p;
        Fri, 14 Dec 2018 12:10:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9F.9B.04441.EBD931C5; Fri, 14
        Dec 2018 12:10:38 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181214121037eucas1p2469a23e8e393bdca487a11260b187510~wMc8WEb0k1559015590eucas1p2g;
        Fri, 14 Dec 2018 12:10:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181214121037eusmtrp16e00c00b128e5a7ae4e1df3913b6c1ec~wMc8EJf4I2638626386eusmtrp1c;
        Fri, 14 Dec 2018 12:10:37 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-74-5c139dbecf49
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.91.04128.DBD931C5; Fri, 14
        Dec 2018 12:10:37 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181214121036eusmtip248e6713acb29150c20131270465aac16~wMc7WlgIc3233032330eusmtip2x;
        Fri, 14 Dec 2018 12:10:36 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 5/6] drm/exynos: plane: Add range property to exynos plane
Date:   Fri, 14 Dec 2018 13:10:20 +0100
Message-Id: <1544789421-5265-6-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+3YuOxsuj5vkh4bBouyipqTwQRFFSgcjqD+SKMNmnpzozHam
        5aUSw2yWaRuRXbRCLZmmOZfFJDO1pnkrs6WrqWCB1/I2oejmdpT++73P+7w87/vxUZj0FeFN
        xSdpWHWSIlFOivH61z96AhqLZVFBg39lyFbdTaD87nYBqi2qIZCloRygPsd3EumGCnE0OvgO
        RwUjExjq6XksRF3Zk0JkHLES6L35DomKehoF6FGrXYjuzzzB0fDYC4Ds+laAivRj5E4pU1KV
        wRgNWpJ5ujBMMCXtB5ihyxYBU1d2nrGYbULmqskAmDmj737RYfH2WDYxPpVVb9lxTKzsyikn
        k6vczkw3m/EsUC/OAyIK0iHwUrYVzwNiSkpXAPgrd4Lgi3kAB0r1JF/MAZj1YgFbHtFa8gV8
        4yGAtRNd/0e0vTdJp4ukQ+En+6yLPem18Pc1A3CaMNpMwG8jPwXOhoyOgNX2v8DJOL0ODna+
        xJ0soffAaWMO4ON84UC31hUtohn4wFy2pFuF8JZjA89hsK/utpBnGRy3mJZ4NezQX3FdB+kL
        ANrmrQRfFAL4sjIP513boLF/fHEjanG9jbDGvIWXd8HPudMuGdIrYf+Uh1PGFlFXfwPjZQm8
        dFHKu9fDCZOJXI4dnXMsrclAc7tNyD/QbQC/1tqIQrDm1v+wewAYgBebwqniWC44iT0dyClU
        XEpSXODxkyojWPxcHX8ss8+AozemGdAUkLtJlDpplJRQpHJpqmYAKUzuKYnMkUVJJbGKtHRW
        fTJanZLIcs3Ah8LlXpKMFcNHpHScQsMmsGwyq17uCiiRdxbQhUVPnUtv6Wy7bi17W2GvDPJf
        2RqU6NMU/tgRG67UWnJDT2mysi+ciNyd8PvsbDrTibtrWjra7sobvhQf9belN0U0xU+alAXK
        EU+fuY37D4a5P9/L+QWo8reGlHtkRoR8bBvOjhktQW9EvqUVboc+zKhRuxzT7du8qu2XX6ay
        Wo5zSkXwJkzNKf4BozHju1gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7p75wrHGGw4IWJxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1lMuj+BxeLFvYssFv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN
        Ysb5fUwWa4/cZbdY+HEri8WDl/sZLe5OPsJoMWPySzYHIY95a6o9Nq3qZPPY/u0Bq8e8k4Ee
        97uPM3lsXlLvcXzXLXaPvi2rGD0+b5IL4IzSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQyzjbupStYA1PxYdDu1gaGLdxdTFyckgImEh0Hu9lArGF
        BJYySnw4ywgRl5GYd7aPDcIWlvhzrYsNouYTo0Tzd3YQm03AVOL23U9gcREBZYm/E1cB9XJx
        MAscY5WY+H4VWJGwgJfEurv/wYayCKhK3DtzkAXE5hVwl/iwqRVqmZzEzXOdzCA2p4CHxLJd
        SxghlrlLvJr5hXECI98CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgTG07djPLTsYu94F
        H2IU4GBU4uE9MEUoRog1say4MvcQowQHs5IIb1ircIwQb0piZVVqUX58UWlOavEhRlOgoyYy
        S4km5wPjO68k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA+M8/YpV
        OoHX5aztqv2OMux5sl20t/jetbScY9sK3t/8s+68xtFPzxeyv7/3sNf5T0aT9t+VK9vvr/fK
        7tzH//mOsKbVW4XCTT0Zns4ZjzbfSl/E9I2v4lX1vtzTVXe9jTrKuLev/RtkK+2yyShiRm3K
        dNN9k72v7g3hfFP59ey1y+8fLerduIlBiaU4I9FQi7moOBEAzvQinrcCAAA=
X-CMS-MailID: 20181214121037eucas1p2469a23e8e393bdca487a11260b187510
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181214121037eucas1p2469a23e8e393bdca487a11260b187510
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214121037eucas1p2469a23e8e393bdca487a11260b187510
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181214121037eucas1p2469a23e8e393bdca487a11260b187510@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create range property within exynos_drm_plane_init and set to default value
in exynos_drm_plane_reset.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index cf352d980eee..a6ab0e7277f0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -140,6 +140,7 @@ static void exynos_drm_plane_reset(struct drm_plane *plane)
 	if (exynos_state) {
 		__drm_atomic_helper_plane_reset(plane, &exynos_state->base);
 		plane->state->zpos = exynos_plane->config->zpos;
+		plane->state->color_range = exynos_plane->config->range;
 	}
 }
 
@@ -301,6 +302,10 @@ int exynos_plane_init(struct drm_device *dev,
 	unsigned int supported_modes = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 				       BIT(DRM_MODE_BLEND_PREMULTI) |
 				       BIT(DRM_MODE_BLEND_COVERAGE);
+
+	u32 supported_ranges = BIT(DRM_COLOR_LIMITED_RANGE) |
+			       BIT(DRM_COLOR_FULL_RANGE);
+
 	struct drm_plane *plane = &exynos_plane->base;
 
 	err = drm_universal_plane_init(dev, plane,
@@ -328,5 +333,9 @@ int exynos_plane_init(struct drm_device *dev,
 	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_WIN_BLEND)
 		drm_plane_create_alpha_property(plane);
 
+	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_RANGE)
+		drm_plane_create_range_property(plane, supported_ranges,
+						config->range);
+
 	return 0;
 }
-- 
2.7.4

