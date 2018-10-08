Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85541C65BD1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4095720878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R1dGkOyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4095720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJHQoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:44:22 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54516 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeJHQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:44:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008093332euoutp0129144fc0ca1c7e96ce04d617fd3d909a~bmFqLwSZM0989509895euoutp01c
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 09:33:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008093332euoutp0129144fc0ca1c7e96ce04d617fd3d909a~bmFqLwSZM0989509895euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538991212;
        bh=oJIWqzJoTPu3KBS8x82f05S+ISr6VPoUzOjp8fpq/Is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1dGkOyYvkUkyWcFLabZ+YlVmc82HzBpYjfGMMDmTs2AalZdeSYyKXJEw9esO11Wr
         qgdUkqZer0+qdBkyd/OCobIXwSc3BCmliMifabyd8HqmKIgmwhyazA0sL8pcYtrfH3
         MTYDitbEaUTaVFNzvonWysPkHCbNCPsgy0ceE+NE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008093331eucas1p23093be3d753100fec65c9dc20e1992f1~bmFpXAwbZ0258802588eucas1p22;
        Mon,  8 Oct 2018 09:33:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3D.64.04441.B642BBB5; Mon,  8
        Oct 2018 10:33:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181008093330eucas1p15363b8acc502292b24a6f6803073accc~bmFojGGtF2363023630eucas1p1_;
        Mon,  8 Oct 2018 09:33:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008093330eusmtrp13abe33998e17c0c36f03b41c63fd88f3~bmFoP9r6Y0079300793eusmtrp19;
        Mon,  8 Oct 2018 09:33:30 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-e9-5bbb246bbc83
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3C.7B.04128.A642BBB5; Mon,  8
        Oct 2018 10:33:30 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181008093329eusmtip2fa7e2f887bf4a4694ec15f0c681c1c34~bmFnmYi5F0447404474eusmtip2S;
        Mon,  8 Oct 2018 09:33:29 +0000 (GMT)
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
Subject: [PATCH 2/2] drm/exynos: fimd: Make pixel blend mode configurable
Date:   Mon,  8 Oct 2018 11:33:02 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538991182-12961-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzv97y7dXoc8Zsa7UpLrcOm7TFSVrOnf25abVpadeXxEnfsHpS2
        Rkw4RNjC9CKpc0KOyFshkZHXZpebl02a19lwlvWy7jzUf5/XfT/77UehEi3uSIWrYji1ShEp
        JURYfdfGwNGIA81B7oNlBDNW1Y8zWf09CFNTUI0z3c1lgPliWiaY3MkcjJmdGMKY7OkFlBkY
        eE0yn5MWSUY/PYozI03FBFMw8A5hKjvHSaYgb444uYvV69IJtmF9CmcnM7oRtvZ5Anu/TgfY
        Vb1TAHFR5BPMRYbHcWo336uisNTlJhA97XircnAdTwS19hpgRUHaE/5sTMI1QERJaC2AKXkT
        iEDWAKxa+EgIZBXAJzm9YLuS+W0EFYyXAK4bh9B/FW3+h80UQR+DxvEVwoLt6P3w9wMdsIRQ
        +g0GW3sMiMWwpc/AVm2R2aAojHaBd9tDhAtO8Gt/OmrBVuZIe4sWs3QhXUXCtaxG0mKI6Tio
        aVlChcJp+KNgBRGwLZzvriMFvBf25mVulZMBHFsbxQWSA2B7hQYTUt5Qb5hHLCtQ2hVWN7kJ
        sh+cKZzbHAdpa2hYsrHIqBnm1j9EBVkM0+5JhPRBuFBXR2yfnV01bb0WC0sqNjZnSuh0BFam
        KXKAc9H/W08B0AEHLpZXhnK8h4q7KeMVSj5WFSq7HqXUA/P/6f3TvfIWmIavdQCaAtKd4vKA
        piAJrojj45UdAFKo1E68u8EsiYMV8bc5ddQVdWwkx3eAPRQmdRC/eFwTJKFDFTFcBMdFc+pt
        F6GsHBPBZX8/TfHiq86zaaMJ5UOlHfJf5U4uvkGPzhn7LoT0fffaWO4afuYRaMouRG44e905
        9UkeP20YgSltZPCUW+64zv+Etx83n+qS36vcly+XlXiy7g4zgRntrPP7wB3JBjE5cqTNRopP
        yPhL8kP9pfZhLkZ312Ufa4+x88niqcfHpRgfpvA4jKp5xV90khT3OwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4Pd0sld3RBnOPclrcWneO1aL33Ekm
        i40z1rNaHN+9lNHiytf3bBaT7k9gsXhx7yKLRf/j18wW589vYLc42/SG3WLT42usFpd3zWGz
        mHF+H5PF2iN32S1mTH7J5sDvsWlVJ5vH9m8PWD3udx9n8ti8pN6jb8sqRo/Pm+QC2KL0bIry
        S0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mtrf72IseCxV
        sfbCN9YGxs1iXYycHBICJhI9Ty4zg9hCAksZJXoPVUDEZSTmne1jg7CFJf5c6wKyuYBqPjFK
        rD49HSzBJmAqcfvuJzBbREBZ4u/EVYwgRcwCB1kkWjaeYQRJCAt4SuxdMQvI5uBgEVCVaDyY
        BhLmFfCQ+PlyEyPEAjmJm+c6wY7gBCo/uGcFC8SyrYwSc/Y2sk5g5FvAyLCKUSS1tDg3PbfY
        SK84Mbe4NC9dLzk/dxMjMBq2Hfu5ZQdj17vgQ4wCHIxKPLwrAnZFC7EmlhVX5h5ilOBgVhLh
        Fd0OFOJNSaysSi3Kjy8qzUktPsRoCnTURGYp0eR8YKTmlcQbmhqaW1gamhubG5tZKInznjeo
        jBISSE8sSc1OTS1ILYLpY+LglGpgZN++NuJNf3CigPDhvQJzXhU7hNjvF9uzzf198gq2lK0r
        FxvcvJqj42hfXvPh3s6+U6/2M6stfcDTsNhiq/28o5s+r2pgCcye+Uis6WOR5P3HDyvdxTfv
        Lf695qUQv/v0BIsZz2bI8qS/Knkup8vx9ufnwmSv5Wvk66euKiw4LrNBTWG9lshmFSWW4oxE
        Qy3mouJEANZcFEScAgAA
Message-Id: <20181008093330eucas1p15363b8acc502292b24a6f6803073accc~bmFojGGtF2363023630eucas1p1_@eucas1p1.samsung.com>
X-CMS-MailID: 20181008093330eucas1p15363b8acc502292b24a6f6803073accc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181008093330eucas1p15363b8acc502292b24a6f6803073accc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008093330eucas1p15363b8acc502292b24a6f6803073accc
References: <20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B@eucas1p1.samsung.com>
        <1538991182-12961-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181008093330eucas1p15363b8acc502292b24a6f6803073accc@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently blend mode is set accordingly to pixel format.
Add pixel blend mode property and make that configurable.
Fimd hardware doesn't support premultiplied mode,
choose coverage as default.

Tested on TRATS2 with Exynos 4412 CPU, on top of
exynos-drm-next using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---

Similar to exynos5433_drm_decon, the driver exposes
the "premultiplied" option for pixel blend mode property,
although hardware doesn't support it, and it's hanlded
by the driver as "coverage". Again, that's because the premultiplied
mode is required and used as default.

 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 28 ++++++++++++++++++++++------
 include/video/samsung_fimd.h             |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 06d5d2422246..c4b0fb05a19b 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -231,10 +231,10 @@ static const uint32_t fimd_formats[] = {
 
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
 
 static inline void fimd_set_bits(struct fimd_context *ctx, u32 reg, u32 mask,
@@ -576,6 +576,23 @@ static void fimd_win_set_bldmod(struct fimd_context *ctx, unsigned int win,
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
+		val |= WINCON1_ALPHA_SEL;
+		val |= WINCON1_BLD_PIX;
+		val |= WINCON1_ALPHA_MUL;
+	}
+	fimd_set_bits(ctx, WINCON(win), WINCONx_BLEND_MODE_MASK, val);
 
 	/* OSD alpha */
 	val = VIDISD14C_ALPHA0_R(alpha >> 4) |
@@ -639,7 +656,6 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 			| WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
 		val |= WINCONx_WSWP;
 		val |= WINCONx_BURSTLEN_16WORD;
-		val |= WINCON1_ALPHA_MUL;
 		break;
 	}
 
@@ -656,7 +672,7 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 		val |= WINCONx_BURSTLEN_4WORD;
 	}
 
-	writel(val, ctx->regs + WINCON(win));
+	fimd_set_bits(ctx, WINCON(win), ~WINCONx_BLEND_MODE_MASK, val);
 
 	/* hardware window 0 doesn't support alpha channel. */
 	if (win != 0)
diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index f070b7c0d2cf..bb1d5baa74d6 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -198,6 +198,7 @@
 #define WINCONx_BURSTLEN_8WORD			(0x1 << 9)
 #define WINCONx_BURSTLEN_4WORD			(0x2 << 9)
 #define WINCONx_ENWIN				(1 << 0)
+#define WINCONx_BLEND_MODE_MASK			(0xc2)
 
 #define WINCON0_BPPMODE_MASK			(0xf << 2)
 #define WINCON0_BPPMODE_SHIFT			2
-- 
2.7.4

