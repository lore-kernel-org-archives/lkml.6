Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E90C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE53213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XhUvNhkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE53213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJCQ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:28:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55592 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeJCQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:28:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181003094102euoutp013e67316c52dd52278c5fd37a99c77a70~aD9yCAcTo2421924219euoutp01O
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 09:41:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181003094102euoutp013e67316c52dd52278c5fd37a99c77a70~aD9yCAcTo2421924219euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538559662;
        bh=9saKoG0uwzzoT2555MEKJ+g1xamHvZuhQxVa8f9dY/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhUvNhkdCvskkEyr8Mt95uUxebagR40ByyySkIVoKfaHkP+Bu2cuOTT3uDQZNUAoR
         daBHIIZc91pIV+zAGhXzBM/O393wZD+PnQyz2BAslKS6J9b4LlwZqzvcAj9Idi/8Ul
         z0aL5B6GyoMEGQZorZSSB2KyIrsM8n/ettsvBObA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181003094101eucas1p13d1ef02473fb848c1180c095a9cfca4f~aD9xI6k_m2300023000eucas1p1M;
        Wed,  3 Oct 2018 09:41:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DE.11.04294.DAE84BB5; Wed,  3
        Oct 2018 10:41:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181003094100eucas1p23bfb9604dbd50ee77f11a85d2c626471~aD9wOUXM61807118071eucas1p2b;
        Wed,  3 Oct 2018 09:41:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181003094100eusmtrp1db12007028d59246689637c222d37353~aD9v8P5a00092600926eusmtrp1j;
        Wed,  3 Oct 2018 09:41:00 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-06-5bb48ead7f73
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 88.7D.04284.CAE84BB5; Wed,  3
        Oct 2018 10:41:00 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181003094059eusmtip19cedd4e12fdc78d6be9d3c5fa76897ce~aD9vKwU-W0809708097eusmtip1D;
        Wed,  3 Oct 2018 09:40:59 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Lowry Li <lowry.li@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 2/2] drm/exynos: decon: Make pixel blend mode configurable
Date:   Wed,  3 Oct 2018 11:40:44 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538559644-30269-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTURzv7N67XZeL2zQ8qBgtDHtphdKBJAqCbkaQfgk1qJk3tXTKrq4s
        MNHwnS4FExVt4qulqXOaTrQc5lJxl9LERz7KIB8TKx+klrR5lb79zu/1/5/DITGpmXAmIxSx
        jFIhj5QJxXhz9xp3vDZbH3xiPXk3Gn1lJtATc48ANRTUEcjUVgHQ4MqiELVOGUQod1KNo5mJ
        DzjKmZ7HEMfVi1B/kkWEdNNDBBowFAtRAdchQDktnQSq7RoXIc3PJhyN53UBVJA3KzznQNeU
        1ABap00X0q9Xpwi6pMefnsw0CejG8kd0a267gDYZRkV0tl4L6CWd21VxkNg3lImMUDFKr7M3
        xeETvd+ImEyX+0ZOjyeCLKcMYEdCyhuq1+qJDCAmpVQ1gJaNeZFNkFLLAKbV4bywBGCZec4q
        kFuJdU7C81UAtuRrMP5gDWxwKZgtLaR84Nj4L6ENO1IH4d+nWmAzYdQAAbkyDW5rcqD84Ke0
        BJsHp9xhdWmhiF/JDY6Y07d67KhLsMZo2FoPUgsi2DsyuGWSUCq4YUrH+cAFWJv6W8BjBzhn
        0m8XucK+vCycDycDOLo8tN2kBrDzZcZ2+gzUDc8JbBth1GFYZ/Di6fNwsdKC81feA4cX9tpo
        zApzm59hPC2BaSlS3n0Izuv1wp2xM0srgMc0fDyQAfgHKgaw1diGq8H+wv/DngOgBU5MHBsV
        xrCnFMw9T1YexcYpwjxvRUfpgPWX9W2alluA4U+IEVAkkNlLWjSNwVJCrmLjo4wAkpjMUZIt
        t1KSUHn8A0YZfUMZF8mwRuBC4jInSWVJQ7CUCpPHMncZJoZR7qgC0s45ERzIDYLERybJGWrN
        fjllDstD8wkBk0WWgCq/qsnuadOcd2NBfgA7MSv7UXrUvvpKeojljjs35dVQ5Pq5YyDh8lh5
        VvE+oJYEXvSXYf3vvuoDH/qqmq/Frh0b2fU99bT/l/c+qqYXet/VN7dLNB6Kzp5gtPnWrrKi
        fdTVo6bi+rAMZ8PlJ49gSlb+D0Dz6/VhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7pr+rZEG8yYxWpxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1nsfLCL3WLS/QksFi/uXWSx6H/8mtni/PkN7BZnm96wW2x6fI3V
        4vKuOWwWM87vY7Lo33GQ1WLtkbvsFgs/bmWxuDv5CKPFjMkv2RyEPdbMW8PosWlVJ5vH9m8P
        WD3mnQz0uN99nMlj85J6j52T9jJ5HN91i92jb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mu6desJa0C1dcej8FpYGxh7xLkYO
        DgkBE4lf53m7GDk5hASWMkp8/FYOYksIyEjMO9vHBmELS/y51gVkcwHVfGKU6Nt7mAUkwSZg
        KnH77iewIhEBZYm/E1cxghQxCzxklXi/sJMNZIGwgJfE1Y46kBoWAVWJFfNnsYPYvAIeEnOf
        7WaBWCAncfNcJzOIzSngKbHm0C5WiIM8JL7+2sA4gZFvASPDKkaR1NLi3PTcYkO94sTc4tK8
        dL3k/NxNjMC42nbs5+YdjJc2Bh9iFOBgVOLh3bFwc7QQa2JZcWXuIUYJDmYlEd6+RKAQb0pi
        ZVVqUX58UWlOavEhRlOgoyYyS4km5wNjPq8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6Yklq
        dmpqQWoRTB8TB6dUA2P2Re1tM5ZLMiUdX2+7zct9Tlmz1jttG7kHIYJbelR3va4WtS+VTlru
        cn/fYT5d9oN2HJP2L7losmBSQO/MzHeiXAa3DjQsXNhglclpqyJn1PzzfmSawaa6C8svMF+U
        OxvxIabEPeTA42WuLb3ZjC1no6z+s/jLK0buk01mTVqXG7D9eFXQMiWW4oxEQy3mouJEAL9O
        6frBAgAA
Message-Id: <20181003094100eucas1p23bfb9604dbd50ee77f11a85d2c626471~aD9wOUXM61807118071eucas1p2b@eucas1p2.samsung.com>
X-CMS-MailID: 20181003094100eucas1p23bfb9604dbd50ee77f11a85d2c626471
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181003094100eucas1p23bfb9604dbd50ee77f11a85d2c626471
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181003094100eucas1p23bfb9604dbd50ee77f11a85d2c626471
References: <1538559644-30269-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181003094100eucas1p23bfb9604dbd50ee77f11a85d2c626471@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently blend mode is set accordingly to pixel format.
Add pixel blend mode property and make that configurable.
Decon hardware doesn't support premultiplied mode,
chose coverage as default.

Tested on TM2 with Exynos 5433 CPU, on top of exynos-drm-next
using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---

Currently, the driver exposes the "premultiplied" option for
pixel blend mode property, and handles it as "coverage".
This is due to the fact, that "premultiplied" mode is mandatory
and is used as default. The question is - how to correctly deal with
hardare that doesn't support premultiplied mode?

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 29 ++++++++++++++++++++++-----
 drivers/gpu/drm/exynos/regs-decon5433.h       |  1 +
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index dff540160199..15609c9f2fda 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -84,12 +84,13 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	[CURSON_WIN] = DRM_PLANE_TYPE_CURSOR,
 };
 
+
 static const unsigned int capabilities[WINDOWS_NR] = {
 	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
 };
 
 static inline void decon_set_bits(struct decon_context *ctx, u32 reg, u32 mask,
@@ -276,6 +277,24 @@ static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
 	unsigned int alpha = state->base.alpha;
 	u32 win_alpha = alpha >> 8;
 	u32 val = 0;
+	unsigned int pixel_alpha;
+
+	if (fb->format->has_alpha)
+		pixel_alpha = state->base.pixel_blend_mode;
+	else
+		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
+
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		break;
+	case DRM_MODE_BLEND_COVERAGE:
+	default:
+		val |= WINCONx_ALPHA_SEL_F;
+		val |= WINCONx_BLD_PIX_F;
+		val |= WINCONx_ALPHA_MUL_F;
+		break;
+	}
+	decon_set_bits(ctx, DECON_WINCONx(win), WINCONx_BLEND_MODE_MASK, val);
 
 	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
 		val = VIDOSD_Wx_ALPHA_R_F(win_alpha) | VIDOSD_Wx_ALPHA_G_F(win_alpha) |
@@ -335,7 +354,7 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		val |= WINCONx_BURSTLEN_8WORD;
 	}
 
-	writel(val, ctx->addr + DECON_WINCONx(win));
+	decon_set_bits(ctx, DECON_WINCONx(win), ~WINCONx_BLEND_MODE_MASK, val);
 }
 
 static void decon_shadow_protect(struct decon_context *ctx, bool protect)
diff --git a/drivers/gpu/drm/exynos/regs-decon5433.h b/drivers/gpu/drm/exynos/regs-decon5433.h
index f42d8f0adf5d..17b7324922c1 100644
--- a/drivers/gpu/drm/exynos/regs-decon5433.h
+++ b/drivers/gpu/drm/exynos/regs-decon5433.h
@@ -117,6 +117,7 @@
 #define WINCONx_BPPMODE_16BPP_A4444	(0xe << 2)
 #define WINCONx_ALPHA_SEL_F		(1 << 1)
 #define WINCONx_ENWIN_F			(1 << 0)
+#define WINCONx_BLEND_MODE_MASK		(0xc2)
 
 /* SHADOWCON */
 #define SHADOWCON_PROTECT_MASK		GENMASK(14, 10)
-- 
2.7.4

