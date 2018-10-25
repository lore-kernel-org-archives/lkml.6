Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F25ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757C520856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="azHcdsJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757C520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeJZAzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:55:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58689 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJZAze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:55:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181025162205euoutp0167ce931a96feb7ba09d7567f4a1314c2~g5oODZGkv2298922989euoutp01E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:22:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181025162205euoutp0167ce931a96feb7ba09d7567f4a1314c2~g5oODZGkv2298922989euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540484525;
        bh=mIOWbUnEL33ySx15J1cbbMLsPVeg3OwxA8tqnh1puZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azHcdsJ93Z1K+rkgCeDUM8kgaqDBPxW2TGxgHoP5CZ6tKFKij0eAmiaxH1kTCMRC8
         LiqZolAfaM4ZWjtE4xbfLzZf5cwlvwAgfBrFSLmrmRQ8cALVJIL3epzGnqpwXLa++6
         6cr9fwtVXNhZ9kT4kQk+Bp/YpgoShU0syvDKsvKc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181025162204eucas1p1e6beb005962c6c5e47243411a769113f~g5oNETT4f1704317043eucas1p1q;
        Thu, 25 Oct 2018 16:22:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B4.25.04294.BADE1DB5; Thu, 25
        Oct 2018 17:22:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181025162203eucas1p1cd2df1e4ee3d44b0dce0ac445a48dfe0~g5oMYhkK-1757217572eucas1p1Z;
        Thu, 25 Oct 2018 16:22:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181025162203eusmtrp1f0fc5457a6e7940f5d53bdcc53d2303b~g5oMJIH771775417754eusmtrp10;
        Thu, 25 Oct 2018 16:22:03 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-ef-5bd1edabec60
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1C.E9.04128.AADE1DB5; Thu, 25
        Oct 2018 17:22:02 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181025162202eusmtip1f01b0a6620533e99d3b27085c647c0f5~g5oLaiFC70691606916eusmtip16;
        Thu, 25 Oct 2018 16:22:02 +0000 (GMT)
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
Subject: [PATCH v4 1/2] drm/exynos: decon: Make plane alpha configurable
Date:   Thu, 25 Oct 2018 18:21:52 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540484513-24274-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTUQDm7D52Hc1uU/CgZbjKUsosjA4lPTDoFhH1p9conXnTyk3ZTc0S
        lAWpM99gassXaqKZOd8zBW20zMdSw3JmKSvxkeW7ByU5r9a/78l3zuFQmKSLcKSuKm+wKqU8
        WEqK8NoXP007yia7ZZ49Bg9kftJFoMSuNgGqzKwgkLGxCKA3899I1DCkF6K0jyk4Gv3QjaNk
        ywSGTKanQtSp/iJEOksfgXr1WhJlmpoFKLm+hUDlhkEhyp+uwdFgugGgzPQx8pAd8zjnMWB0
        pfEkU7cwRDA5baeZjwlGAVNVGM00pDUJGKPeLGSSqksBM6tzPiW6IPIOYIOvhrOqnQf8REHG
        hzoyNGHzzdz+CiIGqJ01wIaCtBcsmIwjNUBESegSABdNapwncwC+KteskFkAX8R8JVcrUxOF
        GG88ArB//ongX2U06yVhTZH0HjgwOLPcsKc3wT+ppcAawuheApoK8nGrYUcz8M1C7lKBonB6
        C3w+tIZfcIb9XfGYFdvQx+D0dJWQ1yeFcMwisGIxHQ6HZ2YwXj8Cy011Kxk7OG6sXsHrYXv6
        veUrQPoOgOa5PoInKQC2lGlwPrUf6t6NC6yHwGg3WKHfycuHYVGxZVmGtC18N7nOKmNLMK32
        PsbLYhh3V8KnXeFEdTW5Ojs6Ow/4CAM1Hdv559EC+FmrxlLAxuz/W3kAlAIHNoxTBLLcbiUb
        4cHJFVyYMtDjcohCB5Z+Wfuica4e6H/7twKaAtI14pdPX8skhDyci1S0AkhhUntx00C3TCIO
        kEfeYlUhvqqwYJZrBU4ULnUQF+dUyiR0oPwGe51lQ1nVqiugbBxjwFlzz9qsiy4RvlEBih7b
        T5B0rflwsjF1xBVPfLA1Q6a99929w01sSI498977OBf/diqs5LzYc++Jztt15ivhLpZtP1yz
        xx74y/ySkp9d61dHhThleZ3rs5ny8TyozMuTZhTlem3zaLjU3KdUa8dHVEcNsT4bmZ40v1/D
        G9K7o933SXEuSL7LHVNx8r8p7gd2YQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7qr3l6MNvhwzMri1rpzrBa9504y
        WWycsZ7V4vjupYwWV76+Z7PY+WAXu8Wk+xNYLF7cu8hi0f/4NbPF+fMb2C3ONr1ht9j0+Bqr
        xeVdc9gsZpzfx2TRv+Mgq8XaI3fZLRZ+3MpicXfyEUaLGZNfsjkIe6yZt4bRY9OqTjaP7d8e
        sHrMOxnocb/7OJPH5iX1Hjsn7WXyOL7rFrtH35ZVjB6fN8kFcEXp2RTll5akKmTkF5fYKkUb
        WhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZRyfu4mtoFulYv7N9awNjE1yXYyc
        HBICJhIfXi9h7mLk4hASWMooceLXBFaIhIzEvLN9bBC2sMSfa11sEEWfGCU+Hm5gAUmwCZhK
        3L77CaxIREBZ4u/EVYwgRcwCD1kl3i/sBEsIC3hIXPk2H2gqBweLgKrE4Qc8IGFeoPD+yR1Q
        C+Qkbp7rZAaxOQU8JT5+3MwOUi4EVHPhhu8ERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLz
        czcxAiNr27GfW3Ywdr0LPsQowMGoxMN7YsOFaCHWxLLiytxDjBIczEoivHtvX4wW4k1JrKxK
        LcqPLyrNSS0+xGgKdNJEZinR5Hxg1OeVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5N
        LUgtgulj4uCUamDcxxQk/cLljYvNz6RNvw1qFRgZ/Eve3OvTr3p+aV6wa0kJ7y0ZCePa2NU7
        a4MTml60RFsqh1bfX9Z8QzX0nmjeqZnzv6a+ubT34hSDjNIkOc5srTluHGePPC0/+CH+26U/
        HvNms2YF2/rdLtT47LVaWMa/oFXrE6dT5pFl3NObru1dLLn+8X8lluKMREMt5qLiRADtV96r
        wgIAAA==
Message-Id: <20181025162203eucas1p1cd2df1e4ee3d44b0dce0ac445a48dfe0~g5oMYhkK-1757217572eucas1p1Z@eucas1p1.samsung.com>
X-CMS-MailID: 20181025162203eucas1p1cd2df1e4ee3d44b0dce0ac445a48dfe0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181025162203eucas1p1cd2df1e4ee3d44b0dce0ac445a48dfe0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181025162203eucas1p1cd2df1e4ee3d44b0dce0ac445a48dfe0
References: <1540484513-24274-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181025162203eucas1p1cd2df1e4ee3d44b0dce0ac445a48dfe0@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decon hardware supports variable plane alpha. Currently planes
are opaque, make this configurable.

Tested on TM2 with Exynos 5433 CPU, on top of linux-next-20181019.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
v2 changes:
 - remove window blend property for the first (0) layer
 (currently zpos is immutable),
 - remove unused parameter in decon_win_set_bldmod,
 - move local variables to decon_win_set_pixfmt,
 - add alpha parameter in decon_win_set_bldmod,
 - don't call decon_win_set_bldmod for the first (0) layer,
 - move decon_win_set_bldmod call to bottom of decon_win_set_pixfmt,

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 33 +++++++++++++++++++++++++++
 drivers/gpu/drm/exynos/regs-decon5433.h       |  7 ++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 94529aa82339..2578db16750d 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -84,6 +84,14 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	[CURSON_WIN] = DRM_PLANE_TYPE_CURSOR,
 };
 
+static const unsigned int capabilities[WINDOWS_NR] = {
+	0,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+};
+
 static inline void decon_set_bits(struct decon_context *ctx, u32 reg, u32 mask,
 				  u32 val)
 {
@@ -259,9 +267,30 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	decon_set_bits(ctx, DECON_UPDATE, STANDALONE_UPDATE_F, ~0);
 }
 
+
+static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
+				 unsigned int alpha)
+{
+	u32 win_alpha = alpha >> 8;
+	u32 val = 0;
+
+	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+		val = VIDOSD_Wx_ALPHA_R_F(win_alpha) |
+		      VIDOSD_Wx_ALPHA_G_F(win_alpha) |
+		      VIDOSD_Wx_ALPHA_B_F(win_alpha);
+		decon_set_bits(ctx, DECON_VIDOSDxC(win),
+			       VIDOSDxC_ALPHA0_RGB_MASK, val);
+		decon_set_bits(ctx, DECON_BLENDCON, BLEND_NEW, BLEND_NEW);
+	}
+}
+
 static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 				 struct drm_framebuffer *fb)
 {
+	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane_state *state =
+		to_exynos_plane_state(plane.base.state);
+	unsigned int alpha = state->base.alpha;
 	unsigned long val;
 
 	val = readl(ctx->addr + DECON_WINCONx(win));
@@ -288,6 +317,7 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		val |= WINCONx_BPPMODE_32BPP_A8888;
 		val |= WINCONx_WSWP_F | WINCONx_BLD_PIX_F | WINCONx_ALPHA_SEL_F;
 		val |= WINCONx_BURSTLEN_16WORD;
+		val |= WINCONx_ALPHA_MUL_F;
 		break;
 	}
 
@@ -307,6 +337,8 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	}
 
 	writel(val, ctx->addr + DECON_WINCONx(win));
+	if (win > 0)
+		decon_win_set_bldmod(ctx, win, alpha);
 }
 
 static void decon_shadow_protect(struct decon_context *ctx, bool protect)
@@ -561,6 +593,7 @@ static int decon_bind(struct device *dev, struct device *master, void *data)
 		ctx->configs[win].num_pixel_formats = ARRAY_SIZE(decon_formats);
 		ctx->configs[win].zpos = win - ctx->first_win;
 		ctx->configs[win].type = decon_win_types[win];
+		ctx->configs[win].capabilities = capabilities[win];
 
 		ret = exynos_plane_init(drm_dev, &ctx->planes[win], win,
 					&ctx->configs[win]);
diff --git a/drivers/gpu/drm/exynos/regs-decon5433.h b/drivers/gpu/drm/exynos/regs-decon5433.h
index 19ad9e47945e..72648bda3142 100644
--- a/drivers/gpu/drm/exynos/regs-decon5433.h
+++ b/drivers/gpu/drm/exynos/regs-decon5433.h
@@ -104,6 +104,7 @@
 #define WINCONx_BURSTLEN_16WORD		(0x0 << 10)
 #define WINCONx_BURSTLEN_8WORD		(0x1 << 10)
 #define WINCONx_BURSTLEN_4WORD		(0x2 << 10)
+#define WINCONx_ALPHA_MUL_F		(1 << 7)
 #define WINCONx_BLD_PIX_F		(1 << 6)
 #define WINCONx_BPPMODE_MASK		(0xf << 2)
 #define WINCONx_BPPMODE_16BPP_565	(0x5 << 2)
@@ -121,6 +122,9 @@
 #define SHADOWCON_PROTECT_MASK		GENMASK(14, 10)
 #define SHADOWCON_Wx_PROTECT(n)		(1 << (10 + (n)))
 
+/* VIDOSDxC */
+#define VIDOSDxC_ALPHA0_RGB_MASK	(0xffffff)
+
 /* VIDOSDxD */
 #define VIDOSD_Wx_ALPHA_R_F(n)		(((n) & 0xff) << 16)
 #define VIDOSD_Wx_ALPHA_G_F(n)		(((n) & 0xff) << 8)
@@ -206,4 +210,7 @@
 #define CRCCTRL_CRCEN			(0x1 << 0)
 #define CRCCTRL_MASK			(0x7)
 
+/* BLENDCON */
+#define BLEND_NEW			(1 << 0)
+
 #endif /* EXYNOS_REGS_DECON5433_H */
-- 
2.7.4

