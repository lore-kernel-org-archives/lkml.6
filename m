Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B3EC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18A9214DE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="faF3/U2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18A9214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeLNMKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:10:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35249 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731599AbeLNMKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:40 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181214121038euoutp02429bb3b16eaad5f62bebf6dcf509787e~wMc82hXME0903709037euoutp02Q
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:10:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181214121038euoutp02429bb3b16eaad5f62bebf6dcf509787e~wMc82hXME0903709037euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544789438;
        bh=jmdJ/NA9nPVJR2QikrVMfECRqgyb9ILMyUSvIDMtSjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faF3/U2nBIfZJYNPieAO1iSWdvzDsq8JAaXjFiS+BF3qU4vHB1H6i6QPCVSgXG9Q3
         TvXOUcm2zEZIcEDdKOEgmS1uil8YzCMP32qXxQBEJPZZiIZiL/0y5f0s+J6rovRSnB
         J4k8exsmttYPF0YrKYQTcKkRJ/IxLSZkUo2YquEE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181214121037eucas1p238e32d7786d5613b2486f19bc3f9538c~wMc8EmS6Z2115021150eucas1p2w;
        Fri, 14 Dec 2018 12:10:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A1.E6.04806.DBD931C5; Fri, 14
        Dec 2018 12:10:37 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181214121036eucas1p13237f995477f1a630c16fb452ba94598~wMc7PuHea1069310693eucas1p1g;
        Fri, 14 Dec 2018 12:10:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181214121036eusmtrp2c7d8bd9319d1a5d896040a86386bb93e~wMc6-4jeo1165211652eusmtrp2i;
        Fri, 14 Dec 2018 12:10:36 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-7c-5c139dbdb0b5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.CC.04284.CBD931C5; Fri, 14
        Dec 2018 12:10:36 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181214121035eusmtip24abcd4c141378a135392b8689b974885~wMc6R8Tqn3233032330eusmtip2w;
        Fri, 14 Dec 2018 12:10:35 +0000 (GMT)
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
Subject: [PATCH 4/6] drm/exynos: plane: Minor cleanup
Date:   Fri, 14 Dec 2018 13:10:19 +0100
Message-Id: <1544789421-5265-5-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvZ2l02rNOCXxBo2aKiaYCCiYXKNRTIzOIxr1QRu1wgSItECn
        4BaVxQUqIEKCKIogi6TI0lpBqihWtCyhlagEaVAUY1gE1FKigAvtgL5955z/P//JzaUwppnw
        paI1Ok6rUcUoSCle9+KnfW3jTbkyqPURhXqq7QTKtLeKkDG/hkC2h2UAvXaPkSjnfTaOBt51
        4uhy/zCGHI5aMepI+SJGpv4uAr2y3CBRvuOxCFU194pR8bf7OOobfAJQb24zQPm5g2Qowxbe
        PcWaDOkkWz/RR7CFrbvY95dsIvZe6VnWZukRs1lmA2BdpmVhkv3SzRFcTHQipw3cclgalfpy
        hIxLmn+8rTAPJIHbEj2QUJAOgRfeFhF6IKUYugLAxpwSIBTjAN6ssuBC4QJwYKKfnLPU52bM
        Wu4AOFX1SvTPUvEx3asi6Q3Q2fvdyz70SvjrisG7F6MtBBztnxR5BvIZ0Vili/AwTvvBzqkf
        M32KktE7YVMLENKWwbf2dMzDEpqF5ZZS7x5IvxPDikyjWBBth+PF5bjAcjhkM8/2l8I/DbdE
        giEVwJ7xLkIosgF8WqmfdWyCpu4hbzJG+8MaS6AHIb0Nfi5hBFwIu0cWecTYDObUXcWEtgym
        XWCEHavhsNlMzqUOuNyz57MwY3RKLLxPAYAdF3+LssHy6/+zigAwgMVcAq+O5PhgDXcsgFep
        +QRNZEB4rNoEZv5W+2+b+wF4PH3ECmgKKBbIWgoYJUOoEvkTaiuAFKbwke07L1cysgjViZOc
        NvaQNiGG461gCYUrFstOzes7wNCRKh13lOPiOO3cVERJfJPAm3hXj7FBpzfJn+t+uR3PkhXG
        6862/RMLnSHJ6+u2BhVMZ/mXWwO509Iwt3pb2J+vS/M+Aj9H1hP+m9h+rWlStX2Y7uWu7S6z
        ys+sCjoTcrDduWciknbvSNwbFRxPGvdtNBR9UH7CEy4n5qWtCN/T7puiQ12VZ6tDudquc8kp
        CpyPUq1bg2l51V/5qJkpVwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7p75grHGMxaz2Vxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1lMuj+BxeLFvYssFv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN
        Ysb5fUwWa4/cZbdY+HEri8WDl/sZLe5OPsJoMWPySzYHIY95a6o9Nq3qZPPY/u0Bq8e8k4Ee
        97uPM3lsXlLvcXzXLXaPvi2rGD0+b5IL4IzSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQy2i+8JatoIG74tS8aYwNjIs4uxg5OSQETCS2T+5h7WLk
        4hASWMoo8effCRaIhIzEvLN9bBC2sMSfa11sEEWfGCWmbj/LDJJgEzCVuH33E1iRiICyxN+J
        qxhBipgFjrFKTHy/ih0kIQxU9H71Z1YQm0VAVeLi7x9MXYwcHLwC7hIHTjBCLJCTuHmuE2wm
        p4CHxLJdS8DiQkAlr2Z+YZzAyLeAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYBRtO/Zz
        8w7GSxuDDzEKcDAq8fAemCIUI8SaWFZcmXuIUYKDWUmEN6xVOEaINyWxsiq1KD++qDQntfgQ
        oynQTROZpUST84ERnlcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1Oq
        gTFEtO2m0Ltd/pPj1FTCJV/u2VkpqiLCcyDC0+ze7nXbwo00U+Z572txvjuXYf5How87mL4r
        /d049fULxXOHJcSfyqU9376SVWe35p/Pgpm2V3mtPjzl5Lj4YOPTgJfrrim9PpP8u0M+47+z
        QKtq25a2w4yTc+KCV55aecfZQYznndC3hz28862UWIozEg21mIuKEwGSfg/KuAIAAA==
X-CMS-MailID: 20181214121036eucas1p13237f995477f1a630c16fb452ba94598
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181214121036eucas1p13237f995477f1a630c16fb452ba94598
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214121036eucas1p13237f995477f1a630c16fb452ba94598
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181214121036eucas1p13237f995477f1a630c16fb452ba94598@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use available drm_plane pointer, for consistency.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index df0508e0e49e..cf352d980eee 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -303,7 +303,7 @@ int exynos_plane_init(struct drm_device *dev,
 				       BIT(DRM_MODE_BLEND_COVERAGE);
 	struct drm_plane *plane = &exynos_plane->base;
 
-	err = drm_universal_plane_init(dev, &exynos_plane->base,
+	err = drm_universal_plane_init(dev, plane,
 				       1 << dev->mode_config.num_crtc,
 				       &exynos_plane_funcs,
 				       config->pixel_formats,
@@ -314,12 +314,12 @@ int exynos_plane_init(struct drm_device *dev,
 		return err;
 	}
 
-	drm_plane_helper_add(&exynos_plane->base, &plane_helper_funcs);
+	drm_plane_helper_add(plane, &plane_helper_funcs);
 
 	exynos_plane->index = index;
 	exynos_plane->config = config;
 
-	exynos_plane_attach_zpos_property(&exynos_plane->base, config->zpos,
+	exynos_plane_attach_zpos_property(plane, config->zpos,
 			   !(config->capabilities & EXYNOS_DRM_PLANE_CAP_ZPOS));
 
 	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_PIX_BLEND)
-- 
2.7.4

