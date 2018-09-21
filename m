Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103C8ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A840F21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QOMxQSZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A840F21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbeIUSPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:15:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53966 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389634AbeIUSPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:15:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180921122621euoutp0170fe0b8ecfad27b17771615e40bbbf09~Waes1RlMI0246802468euoutp01G
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:26:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180921122621euoutp0170fe0b8ecfad27b17771615e40bbbf09~Waes1RlMI0246802468euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537532781;
        bh=Gc8A4fvoVeATfeVJrujwYupX10uY+pxjztNgKaOOvww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOMxQSZ0EdMSuD8Pp/wAq+H1dBNKSxuYy5L1csQ0OFFE1A71prrAaROB+FjSihacA
         f9CiNPWcNu1MfOcH4MKvxxHe8TIGdsqiBGbYQEcFQ7QlCkIspTi63eApeySkPyw88r
         A/cebMe0V41mLJ4bXFyJ3p5GsSbupZb1igoUn92Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180921122620eucas1p268b98d570a140945ea98e70fb4e51f07~Waer5jTvS1104511045eucas1p2b;
        Fri, 21 Sep 2018 12:26:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 66.7C.04294.C63E4AB5; Fri, 21
        Sep 2018 13:26:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180921122619eucas1p24ab7008bf55e7dbe3eb01e5ad85fc401~Waeq06DpV1393813938eucas1p2k;
        Fri, 21 Sep 2018 12:26:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180921122619eusmtrp1a776d3c7a344257c480150397ea69f62~WaeqjG5Jb2872728727eusmtrp1R;
        Fri, 21 Sep 2018 12:26:19 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-8e-5ba4e36cdc58
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C9.69.04284.B63E4AB5; Fri, 21
        Sep 2018 13:26:19 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180921122618eusmtip1c8a2162f57eedac5f8641d35bdde390d~Waep66Eqt2109621096eusmtip1O;
        Fri, 21 Sep 2018 12:26:18 +0000 (GMT)
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 3/3] drm/exynos: mixer: Make plane alpha configurable
Date:   Fri, 21 Sep 2018 14:24:38 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537532678-4276-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjm27nsaM1OU/FDQ2NilpWaWJxuZmC0ikKQoPJHnfKkkpuyeTdq
        WabOuxZ5yTBdafPaUhM1LRXFSxtiiRdMwbJdElNnZXTbdpT+PZf34X3ej49A+FWYIxEujmYk
        YjpCgFujzb2rmt0Rs4pg79FOe2qiTo1RWep+DvW8sB6j+tqeAOrdygJO5U/nopT2wzBK5cwa
        EEqjaeBSb5O/cCnV7ChGjbQ+xKlCTQeHqu2Z4lKFBTrcf5NQpUzHhS+/zWDC6Yw+jvCF4qYw
        u1EJhMsq50D8gvWhECYiPJaRePldsg5rep0DorK84h/pNLgMdLrLgRUBSV/4vTkbkwNrgk9W
        AZihK+GyxAigsXYGZckygIYOFb4eWV5MQVijEsBS7S2O2bBEJtXxZoyTe+Hk1JIlYEe6wt95
        SmAOIGQTCl/1j1kCtuQxOK/+a8Eo6QYr04bXNjjDcXU6YsZWpBDW/ZhDWb2ZC++rg8yYR8bC
        1NF+wOoBUKXWrc3YQn1fI5fFW+BgQablBEjeBnDCOIqxJBfAN9XytcRBqBrTm1oQpno7YH2r
        Fysfhe33ujGzDEkbODa/2SwjJpjf/ABhZR5Mu8tnp7dBQ2Mjvr5Wu7yyVk0I9Q0dgH2sEgAX
        ZancXOBS/H9ZGQBK4MDESEWhjNRHzMR5SmmRNEYc6nklUqQCpv8z+KfP2AJaf13uAiQBBBt5
        3hUVwXyMjpUmiLoAJBCBHa9Drgjm80LohERGEnlREhPBSLuAE4EKHHg2HleD+WQoHc1cY5go
        RrLucggrRxnYL9uXOS6I6yYPD6Co29z7oER6YnrExb1ooNSvbGj7fP6naX5Bnrb8Tm3RVkXL
        ruKdp3wC9P03HD6f1Y4niz/61ifUZPUcoe1LA4f8n7aNPDiZumHp63H+ZJyHy2PX8z9PEO7u
        q9V+NfIk7+uGpBSnxfL20y3nNAd6s4yVC88GziQLUGkYvccDkUjpfyb5Fc07AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4Xd3sx0uiDd7N5ba4te4cq0XvuZNM
        FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
        MeP8PiaLtUfuslvMmPySzYHfY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEXp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZWw90M9Y0Ktf
        Me/lebYGxv3qXYycHBICJhKfP7YydzFycQgJLGWUmPTsMAtEQkZi3tk+NghbWOLPtS42iKJP
        jBJvTj5gB0mwCZhK3L77CaxIREBZ4u/EVYwgRcwCB1kkWjaeYQRJCAu4Srw9958JxGYRUJVY
        3nERrIFXwF1i0Y9fUBvkJG6e62QGsTkFPCTW/XgGdAUH0DZ3iVPrTSYw8i1gZFjFKJJaWpyb
        nltsqFecmFtcmpeul5yfu4kRGA3bjv3cvIPx0sbgQ4wCHIxKPLwGixdHC7EmlhVX5h5ilOBg
        VhLh3de1JFqINyWxsiq1KD++qDQntfgQoynQTROZpUST84GRmlcSb2hqaG5haWhubG5sZqEk
        znveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgVH9/brmidE+264oOb1d+dKNJ+sFG28Ox5wbak2N
        P66aTfr8KzZXi32/R2/PvDXqLjObBU46LI1cvC3lnOSj44XbeZxEb+0t3qEnI7bw0fQ75rcY
        eq193rxMYxNq2GrlfPHGps/n1fTFhSZ+v7lkwcye104vfMUnZGpLPBR91LlEn2de+3HuikIl
        luKMREMt5qLiRABsazyrnAIAAA==
Message-Id: <20180921122619eucas1p24ab7008bf55e7dbe3eb01e5ad85fc401~Waeq06DpV1393813938eucas1p2k@eucas1p2.samsung.com>
X-CMS-MailID: 20180921122619eucas1p24ab7008bf55e7dbe3eb01e5ad85fc401
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180921122619eucas1p24ab7008bf55e7dbe3eb01e5ad85fc401
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180921122619eucas1p24ab7008bf55e7dbe3eb01e5ad85fc401
References: <1537532678-4276-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180921122619eucas1p24ab7008bf55e7dbe3eb01e5ad85fc401@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mixer hardware supports variable plane alpha. Currently planes are
opaque, make this configurable.

Tested on Odroid-U3 with Exynos 4412 CPU, kernel next-20180913
using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 +
 drivers/gpu/drm/exynos/exynos_drm_plane.c |  3 +++
 drivers/gpu/drm/exynos/exynos_mixer.c     | 37 ++++++++++++++++++-------------
 drivers/gpu/drm/exynos/regs-mixer.h       |  5 ++++-
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index 1cb26d8c66f9..ec1d5bcac61a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -93,6 +93,7 @@ struct exynos_drm_plane {
 #define EXYNOS_DRM_PLANE_CAP_ZPOS	(1 << 2)
 #define EXYNOS_DRM_PLANE_CAP_TILE	(1 << 3)
 #define EXYNOS_DRM_PLANE_CAP_PIX_BLEND	(1 << 4)
+#define EXYNOS_DRM_PLANE_CAP_WIN_BLEND	(1 << 5)
 
 /*
  * Exynos DRM plane configuration structure.
diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index 236408906f1f..df0508e0e49e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -325,5 +325,8 @@ int exynos_plane_init(struct drm_device *dev,
 	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_PIX_BLEND)
 		drm_plane_create_blend_mode_property(plane, supported_modes);
 
+	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_WIN_BLEND)
+		drm_plane_create_alpha_property(plane);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 721b63e92b28..e3a4ecbc503b 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -132,7 +132,8 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.num_pixel_formats = ARRAY_SIZE(mixer_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_DOUBLE |
 				EXYNOS_DRM_PLANE_CAP_ZPOS |
-				EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+				EXYNOS_DRM_PLANE_CAP_PIX_BLEND |
+				EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
 	}, {
 		.zpos = 1,
 		.type = DRM_PLANE_TYPE_CURSOR,
@@ -140,7 +141,8 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.num_pixel_formats = ARRAY_SIZE(mixer_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_DOUBLE |
 				EXYNOS_DRM_PLANE_CAP_ZPOS |
-				EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+				EXYNOS_DRM_PLANE_CAP_PIX_BLEND |
+				EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
 	}, {
 		.zpos = 2,
 		.type = DRM_PLANE_TYPE_OVERLAY,
@@ -148,7 +150,8 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.num_pixel_formats = ARRAY_SIZE(vp_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_SCALE |
 				EXYNOS_DRM_PLANE_CAP_ZPOS |
-				EXYNOS_DRM_PLANE_CAP_TILE,
+				EXYNOS_DRM_PLANE_CAP_TILE |
+				EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
 	},
 };
 
@@ -311,8 +314,9 @@ static void vp_default_filter(struct mixer_context *ctx)
 }
 
 static void mixer_cfg_gfx_blend(struct mixer_context *ctx, unsigned int win,
-				unsigned int pixel_alpha)
+				unsigned int pixel_alpha, unsigned int alpha)
 {
+	u32 win_alpha = alpha >> 8;
 	u32 val;
 
 	val  = MXR_GRP_CFG_COLOR_KEY_DISABLE; /* no blank key */
@@ -328,21 +332,24 @@ static void mixer_cfg_gfx_blend(struct mixer_context *ctx, unsigned int win,
 		val |= MXR_GRP_CFG_PIXEL_BLEND_EN;
 		break;
 	}
+
+	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+		val |= MXR_GRP_CFG_WIN_BLEND_EN;
+		val |= win_alpha;
+	}
 	mixer_reg_writemask(ctx, MXR_GRAPHIC_CFG(win),
 			    val, MXR_GRP_CFG_MISC_MASK);
 }
 
-static void mixer_cfg_vp_blend(struct mixer_context *ctx)
+static void mixer_cfg_vp_blend(struct mixer_context *ctx, unsigned int alpha)
 {
-	u32 val;
+	u32 win_alpha = alpha >> 8;
+	u32 val = 0;
 
-	/*
-	 * No blending at the moment since the NV12/NV21 pixelformats don't
-	 * have an alpha channel. However the mixer supports a global alpha
-	 * value for a layer. Once this functionality is exposed, we can
-	 * support blending of the video layer through this.
-	 */
-	val = 0;
+	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+		val |= MXR_VID_CFG_BLEND_EN;
+		val |= win_alpha;
+	}
 	mixer_reg_write(ctx, MXR_VIDEO_CFG, val);
 }
 
@@ -538,7 +545,7 @@ static void vp_video_buffer(struct mixer_context *ctx,
 	vp_reg_write(ctx, VP_BOT_C_PTR, chroma_addr[1]);
 
 	mixer_cfg_layer(ctx, plane->index, priority, true);
-	mixer_cfg_vp_blend(ctx);
+	mixer_cfg_vp_blend(ctx, state->base.alpha);
 
 	spin_unlock_irqrestore(&ctx->reg_slock, flags);
 
@@ -631,7 +638,7 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 	mixer_reg_write(ctx, MXR_GRAPHIC_BASE(win), dma_addr);
 
 	mixer_cfg_layer(ctx, win, priority, true);
-	mixer_cfg_gfx_blend(ctx, win, pixel_alpha);
+	mixer_cfg_gfx_blend(ctx, win, pixel_alpha, state->base.alpha);
 
 	/* layer update mandatory for mixer 16.0.33.0 */
 	if (ctx->mxr_ver == MXR_VER_16_0_33_0 ||
diff --git a/drivers/gpu/drm/exynos/regs-mixer.h b/drivers/gpu/drm/exynos/regs-mixer.h
index 189cfa2470a8..d2b8194a07bf 100644
--- a/drivers/gpu/drm/exynos/regs-mixer.h
+++ b/drivers/gpu/drm/exynos/regs-mixer.h
@@ -109,12 +109,15 @@
 #define MXR_CFG_SCAN_HD			(1 << 0)
 #define MXR_CFG_SCAN_MASK		0x47
 
+/* bits for MXR_VIDEO_CFG */
+#define MXR_VID_CFG_BLEND_EN		(1 << 16)
+
 /* bits for MXR_GRAPHICn_CFG */
 #define MXR_GRP_CFG_COLOR_KEY_DISABLE	(1 << 21)
 #define MXR_GRP_CFG_BLEND_PRE_MUL	(1 << 20)
 #define MXR_GRP_CFG_WIN_BLEND_EN	(1 << 17)
 #define MXR_GRP_CFG_PIXEL_BLEND_EN	(1 << 16)
-#define MXR_GRP_CFG_MISC_MASK		((3 << 16) | (3 << 20))
+#define MXR_GRP_CFG_MISC_MASK		((3 << 16) | (3 << 20) | 0xff)
 #define MXR_GRP_CFG_FORMAT_VAL(x)	MXR_MASK_VAL(x, 11, 8)
 #define MXR_GRP_CFG_FORMAT_MASK		MXR_GRP_CFG_FORMAT_VAL(~0)
 #define MXR_GRP_CFG_ALPHA_VAL(x)	MXR_MASK_VAL(x, 7, 0)
-- 
2.7.4

