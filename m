Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C669CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7889421476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FNvtW6+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7889421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJRUxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:53:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40049 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeJRUxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:53:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181018125211euoutp027a054c8ca4aa306bb83b666aef04226b~etP9LAvxC3002130021euoutp02B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:52:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181018125211euoutp027a054c8ca4aa306bb83b666aef04226b~etP9LAvxC3002130021euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539867131;
        bh=jSuiCXcApiuEnFxS3MssmQrYHGlUkcGAKWcj/scsU+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNvtW6+xm5cUfnQVmxvune28iCGC4FmYc47dh3GJMjnC8ixz9lN5D2WpoHPxRnmgW
         iqAjwSGIp7QVchEqK1YTpB4wEZ8onyff5wqjjwqRi63xy8draRoHgwuXFxP9baTlV7
         pnossScGqCcsjoJAtBZbLc9tD7bUx1YLHO+uU6nE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018125210eucas1p1994790d83dcfb57e3f28bbbbdb500349~etP8Z-eTa0071600716eucas1p1N;
        Thu, 18 Oct 2018 12:52:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 69.DA.04294.AF188CB5; Thu, 18
        Oct 2018 13:52:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181018125209eucas1p199f2790a05546e2bbb306e97ee102b51~etP7nkA4R0072400724eucas1p1J;
        Thu, 18 Oct 2018 12:52:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181018125209eusmtrp2cfba1c5c09f3ac75cd302b1b17d528f3~etP7lcvnX1293212932eusmtrp2F;
        Thu, 18 Oct 2018 12:52:09 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-d8-5bc881fa2edd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 37.CA.04128.9F188CB5; Thu, 18
        Oct 2018 13:52:09 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181018125208eusmtip18cdebe893952cabf49e8bcc9d6cfb4a0~etP6zKvte2139821398eusmtip1g;
        Thu, 18 Oct 2018 12:52:08 +0000 (GMT)
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
Subject: [PATCH v3 2/2] drm/exynos: decon: Make pixel blend mode
 configurable
Date:   Thu, 18 Oct 2018 14:51:47 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539867107-3383-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUzMcRzH973fYzfH16+2PsNi1zRCYtjXotiwn9nCZkb9ocNPmR7vuiNs
        zjN5OmWraHmYp05U51CHVMrV6I6kuHYVrZaSULGap65f8d/r8/6839/PZ599eUpwMhP47fHJ
        kjZeE6tmlfT9ZwPOWYP7qyKDzX8o4rrjYMgpR7WCFGbmM8T+8Boidf09LClusXEkrdlEk46m
        VzQ509pFEaezgCM1Bz5xxNJaz5DXtmyWZDpLFORMURlDble4OXL56z2auNMrEMlM/8gu8Rbz
        cvKQaDEfZ8UH31sYMad6rdh8wq4Q717dJxanPVaIdpuLE09bzUjstfitUUYoF22VYrcbJO3s
        0ChlzGnreyaxbNaunp8vOSM6FpCKvHjA86CstZ5NRUpewDcRPK+pRXLRh+BzfzUlF70IHAds
        aDTiqmtWeFjANxBUZm3+l8gudNGeBovnQ6P7G+thH+wPv86ah5+l8GsGnFcuD5u88Wr40WGl
        PEzjqXCqXGbAfvDOcXyYvbAITZW5jCcMuJuD7P1XhtdQYQMUNrwYCSyDyi/nGJm9odNu5WSe
        BH+KLyrk8EEErr76kZdMCMpupdKyKwQsbzuHXPzQftMh3zZblpdCxmET7ZEBj4W33eM9MjWE
        afczKFlWwbEjguwOgC6rlR0d29HbP3ItEdrevKfla11A8OWzaEKTz/+fdQkhM/KV9Lq4aEk3
        N17aGaTTxOn08dFBWxLiLGjomz3/be8rQrafm8sR5pF6jKpFskcKjMagS4krR8BTah/VgLEq
        UlBt1aTslrQJm7T6WElXjibytNpXdT2nMFLA0ZpkaYckJUra0a6C95pgRDuCT4ZnTDO8PMuZ
        rUklq55sdK8o8PcNe5HprEtfnBwCUWlihmPd0ymlRnxUWHi3NqzhomnbTPejcEPbk4blM8YZ
        NxxqrP+wYUHSoNDuIusrSxZ2Yb1XtD7IvXKvb/Oehgh/EsyG5vZ4m1DNzNCQ9l1ZgVWWgNI3
        +VZM2vorsJrWxWjmBFJaneYvTRFEBWIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7o/G09EG/w8LGpxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1nsfLCL3WLS/QksFi/uXWSx6H/8mtni/PkN7BZnm96wW2x6fI3V
        4vKuOWwWM87vY7Lo33GQ1WLtkbvsFgs/bmWxuDv5CKPFjMkv2RyEPdbMW8PosWlVJ5vH9m8P
        WD3mnQz0uN99nMlj85J6j52T9jJ5HN91i92jb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mvq2PGQtOKhb8f7PBfYGxg61LkZO
        DgkBE4lbV+4zdTFycQgJLGWUWLPqBTNEQkZi3tk+NghbWOLPtS42iKJPjBLbvk8FK2ITMJW4
        ffcTWJGIgLLE34mrGEGKmAUeskq8X9gJlhAW8JVY1DEDzGYRUJXoPbQFrJlXwF2iedUpRogN
        chI3z3WCxTkFPCTuHV3JCmILAdW82LCFdQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5
        mxiB0bXt2M8tOxi73gUfYhTgYFTi4X2QejxaiDWxrLgy9xCjBAezkgivc8OJaCHelMTKqtSi
        /Pii0pzU4kOMpkBHTWSWEk3OB0Z+Xkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC
        1CKYPiYOTqkGRuHLn9eqrz9by6F7PNPtgSLr/vfTL+wJyWK6NvX/w2OFzxIEar0+Na6MX9R0
        u3JSzZmUgqq8fcxuAk2ufTIOmTfKTv26NeGvrO/aCSo9x1o/v2G+sb/i8rQXE3mPn+0TmHj4
        m8/RbyzeMVtlj5x9Gi01ecZ9szftCyMZhQrN565Z08VunSv/LFiJpTgj0VCLuag4EQD1FojZ
        xAIAAA==
Message-Id: <20181018125209eucas1p199f2790a05546e2bbb306e97ee102b51~etP7nkA4R0072400724eucas1p1J@eucas1p1.samsung.com>
X-CMS-MailID: 20181018125209eucas1p199f2790a05546e2bbb306e97ee102b51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181018125209eucas1p199f2790a05546e2bbb306e97ee102b51
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018125209eucas1p199f2790a05546e2bbb306e97ee102b51
References: <1539867107-3383-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181018125209eucas1p199f2790a05546e2bbb306e97ee102b51@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently blend mode is set accordingly to pixel format.
Add pixel blend mode property and make it configurable,
by modifying the blend equation.

Tested on TM2 with Exynos 5433 CPU, on top of exynos-drm-next,
commit: c530174b90fa

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
v3 changes:
 - fix compilation errors (previouslsy wrong patch was sent);
v2 changes:
 - add premultiplied mode by setting blending equation accordingly,
 - remove no longer used blend mode settings from decon_win_set_pixfmt,

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 67 +++++++++++++++++++++++----
 drivers/gpu/drm/exynos/regs-decon5433.h       | 15 ++++++
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 2578db16750d..bc080064b6b4 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -86,10 +86,10 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 
 static const unsigned int capabilities[WINDOWS_NR] = {
 	0,
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
@@ -267,13 +267,53 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	decon_set_bits(ctx, DECON_UPDATE, STANDALONE_UPDATE_F, ~0);
 }
 
+static void decon_win_set_bldeq(struct decon_context *ctx, unsigned int win,
+				unsigned int alpha, unsigned int pixel_alpha)
+{
+	u32 mask = BLENDERQ_A_FUNC_F(0xf) | BLENDERQ_B_FUNC_F(0xf);
+	u32 val = 0;
+
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		break;
+	case DRM_MODE_BLEND_COVERAGE:
+		val |= BLENDERQ_A_FUNC_F(BLENDERQ_ALPHA_A);
+		val |= BLENDERQ_B_FUNC_F(BLENDERQ_ONE_MINUS_ALPHA_A);
+		decon_set_bits(ctx, DECON_BLENDERQx(win), mask, val);
+		break;
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
+		if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+			val |= BLENDERQ_A_FUNC_F(BLENDERQ_ALPHA0);
+			val |= BLENDERQ_B_FUNC_F(BLENDERQ_ONE_MINUS_ALPHA_A);
+		} else {
+			val |= BLENDERQ_A_FUNC_F(BLENDERQ_ONE);
+			val |= BLENDERQ_B_FUNC_F(BLENDERQ_ONE_MINUS_ALPHA_A);
+		}
+		decon_set_bits(ctx, DECON_BLENDERQx(win), mask, val);
+		break;
+	}
+}
 
 static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
-				 unsigned int alpha)
+				 unsigned int alpha, unsigned int pixel_alpha)
 {
 	u32 win_alpha = alpha >> 8;
 	u32 val = 0;
 
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		break;
+	case DRM_MODE_BLEND_COVERAGE:
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
+		val |= WINCONx_ALPHA_SEL_F;
+		val |= WINCONx_BLD_PIX_F;
+		val |= WINCONx_ALPHA_MUL_F;
+		break;
+	}
+	decon_set_bits(ctx, DECON_WINCONx(win), WINCONx_BLEND_MODE_MASK, val);
+
 	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
 		val = VIDOSD_Wx_ALPHA_R_F(win_alpha) |
 		      VIDOSD_Wx_ALPHA_G_F(win_alpha) |
@@ -291,8 +331,14 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	struct exynos_drm_plane_state *state =
 		to_exynos_plane_state(plane.base.state);
 	unsigned int alpha = state->base.alpha;
+	unsigned int pixel_alpha;
 	unsigned long val;
 
+	if (fb->format->has_alpha)
+		pixel_alpha = state->base.pixel_blend_mode;
+	else
+		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
+
 	val = readl(ctx->addr + DECON_WINCONx(win));
 	val &= WINCONx_ENWIN_F;
 
@@ -315,9 +361,8 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	case DRM_FORMAT_ARGB8888:
 	default:
 		val |= WINCONx_BPPMODE_32BPP_A8888;
-		val |= WINCONx_WSWP_F | WINCONx_BLD_PIX_F | WINCONx_ALPHA_SEL_F;
+		val |= WINCONx_WSWP_F;
 		val |= WINCONx_BURSTLEN_16WORD;
-		val |= WINCONx_ALPHA_MUL_F;
 		break;
 	}
 
@@ -335,10 +380,12 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		val &= ~WINCONx_BURSTLEN_MASK;
 		val |= WINCONx_BURSTLEN_8WORD;
 	}
+	decon_set_bits(ctx, DECON_WINCONx(win), ~WINCONx_BLEND_MODE_MASK, val);
 
-	writel(val, ctx->addr + DECON_WINCONx(win));
-	if (win > 0)
-		decon_win_set_bldmod(ctx, win, alpha);
+	if (win > 0) {
+		decon_win_set_bldmod(ctx, win, alpha, pixel_alpha);
+		decon_win_set_bldeq(ctx, win, alpha, pixel_alpha);
+	}
 }
 
 static void decon_shadow_protect(struct decon_context *ctx, bool protect)
diff --git a/drivers/gpu/drm/exynos/regs-decon5433.h b/drivers/gpu/drm/exynos/regs-decon5433.h
index 72648bda3142..63db6974bf14 100644
--- a/drivers/gpu/drm/exynos/regs-decon5433.h
+++ b/drivers/gpu/drm/exynos/regs-decon5433.h
@@ -117,6 +117,7 @@
 #define WINCONx_BPPMODE_16BPP_A4444	(0xe << 2)
 #define WINCONx_ALPHA_SEL_F		(1 << 1)
 #define WINCONx_ENWIN_F			(1 << 0)
+#define WINCONx_BLEND_MODE_MASK		(0xc2)
 
 /* SHADOWCON */
 #define SHADOWCON_PROTECT_MASK		GENMASK(14, 10)
@@ -213,4 +214,18 @@
 /* BLENDCON */
 #define BLEND_NEW			(1 << 0)
 
+/* BLENDERQx */
+#define BLENDERQ_ZERO			0x0
+#define BLENDERQ_ONE			0x1
+#define BLENDERQ_ALPHA_A		0x2
+#define BLENDERQ_ONE_MINUS_ALPHA_A	0x3
+#define BLENDERQ_ALPHA0			0x6
+#define BLENDERQ_Q_FUNC_F(n)		(n << 18)
+#define BLENDERQ_P_FUNC_F(n)		(n << 12)
+#define BLENDERQ_B_FUNC_F(n)		(n << 6)
+#define BLENDERQ_A_FUNC_F(n)		(n << 0)
+
+/* BLENDCON */
+#define BLEND_NEW			(1 << 0)
+
 #endif /* EXYNOS_REGS_DECON5433_H */
-- 
2.7.4

