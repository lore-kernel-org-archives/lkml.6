Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BADCC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEB521476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kFS0GhsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEB521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeJRRgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:36:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45232 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeJRRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:36:47 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181018093637euoutp01773eafc282cf9851497cf3e9ff967cb7~eqlNaSLOf2286722867euoutp01b
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:36:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181018093637euoutp01773eafc282cf9851497cf3e9ff967cb7~eqlNaSLOf2286722867euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539855397;
        bh=9E02YJ4gWL+PlXXstPIqUYWhzDbY8POwv7pBCqjPVIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kFS0GhsX6QNx7msNPo+NwBz8OV7YU/JVd2uzaMRXpJsBaHKatFSDlQNCLoJqrVk/2
         O7ygz/xHFnIFHfhmJBmKlDUIyJcEQcb9XXZwI81Q07pWfd+lGKYaV/yEvzORmavayh
         RM6JlVnqbeiFJ5R3P/KfQCg8LGLZ6Yszi2aV3jvo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018093636eucas1p1e5dbf1a1d67c87b5c4575920e5422920~eqlMgjynu2418924189eucas1p1_;
        Thu, 18 Oct 2018 09:36:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8F.AE.04806.42458CB5; Thu, 18
        Oct 2018 10:36:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181018093635eucas1p271a3ad07fc32284696272a811bfc5542~eqlLqvBj11414614146eucas1p2P;
        Thu, 18 Oct 2018 09:36:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181018093635eusmtrp2eab7b62f3f979ee142186d21dcc76ffd~eqlLZQski2801628016eusmtrp2X;
        Thu, 18 Oct 2018 09:36:35 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-c2-5bc85424c72a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.10.04284.32458CB5; Thu, 18
        Oct 2018 10:36:35 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181018093634eusmtip1351370cdc8d17a061d87f611b5905859~eqlKrWeeM0370003700eusmtip1n;
        Thu, 18 Oct 2018 09:36:34 +0000 (GMT)
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
Subject: [PATCH v2 1/2] drm/exynos: decon: Make plane alpha configurable
Date:   Thu, 18 Oct 2018 11:36:09 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539855370-15194-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUyMcRzf757Xbs4ed6yvl5051DAlrz80icbjHy8b/SGmo0c1lds9ytsW
        aqwXpzebZomQl9OLTtJdi107rnbrLi9LenEpTYmFCi1F1yP++7zu891vP5ZQNlAz2Oi4I4I+
        ThujoeVkxbMh1+J5O2vDlmQNqnBziZPCBmedDJflllLYXlWI8KvBPhqb2y0MznZnkrj77XMS
        Z3T2Etjlus/g+qRPDDZ1NlL4pSWPxrmuxzKcUWmlcLGtjcEFXx+SuC3HhnBuTg+9XsUX5Rch
        3mRMpflH39spPr9uB+9Ot8v4BzdP8ebsahlvtzQz/IVyI+L7Tert8t3ywAghJjpB0PuvC5dH
        tXe0Eror844ljfqdRlnqNOTFArccOq0GMg3JWSV3B0Fp3xNaIgMIqt81IYn0IxjpKCEmKjcy
        +gjJuI1g+IcN/atUvi6mPCmaWwEtbd9oD57KzYWRLON4iOBeUuC6XkB6DBXHw/syN/JgkpsP
        T68+p6QJNbxxpo7PeXFboLhraHwOuA4GrLYUmcdQcAlga7HQUiEEbj90Igmr4KO9nJHwLPht
        viqTyskImgcaKYlkIrDeSyOl1FowNX0cS7Fj9y2AUou/JAfDmRdnKY8M3GRo+jzFIxNjMLvi
        EiHJCkg5p5TSPtBbXk5PzHb3D/49h4dPJcOM9EJ5CFpudNGZaPbl/2PXEDIibyFejI0UxGVx
        wlE/URsrxsdF+h04HGtCY//MMWofrESPf+2vQRyLNJMU7YI9TElpE8TjsTUIWEIzVXFyZW2Y
        UhGhPX5C0B/ep4+PEcQaNJMlNd6KW/llYUouUntEOCQIOkE/4cpYrxmn0cIgh04drg3NGxLc
        iXs2jzRb65a0Glo/LPL5uWmN40LRRl3DxQAdu/Tgjp6iOaGlhi/H6g1Nz2zTHd0pe9OnXTc7
        I6xVaxc0RPvCTS5+K9h/7Gq9FtJTkKfyTV6tbkxsu3u5MHWuObDrSmBI77acDczJ8zkOtxj0
        5JsjuGzUuIrRkGKUNmAhoRe1fwDboVurYwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7rKISeiDTbOF7O4te4cq0XvuZNM
        FhtnrGe1OL57KaPFla/v2Sx2PtjFbjHp/gQWixf3LrJY9D9+zWxx/vwGdouzTW/YLTY9vsZq
        cXnXHDaLGef3MVn07zjIarH2yF12i4Uft7JY3J18hNFixuSXbA7CHmvmrWH02LSqk81j+7cH
        rB7zTgZ63O8+zuSxeUm9x85Je5k8ju+6xe7Rt2UVo8fnTXIBXFF6NkX5pSWpChn5xSW2StGG
        FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GQ8e3WEumKtS0fRPr4FxolwXIyeH
        hICJxOL+98wgtpDAUkaJfz/VIOIyEvPO9rFB2MISf651AdlcQDWfGCUmrJsKlmATMJW4ffcT
        mC0ioCzxd+IqRpAiZoGHrBLvF3aCJYQFPCSebLzPCGKzCKhKHJ1/kRXE5gWKP726jx1ig5zE
        zXOdYFdwCnhKrH36E+oiD4k175rZJjDyLWBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREY
        WduO/dy8g/HSxuBDjAIcjEo8vA9Sj0cLsSaWFVfmHmKU4GBWEuGtNjsRLcSbklhZlVqUH19U
        mpNafIjRFOioicxSosn5wKjPK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTT
        x8TBKdXAqLv/8t7g4yKPclrrd+wVtryxXNX4z9ci49uB3OcrNIrm7fmVdCv9crVKgZPImq0Z
        NxfNsL4rusflEXccl81NzecXGE549301el30undVSMBWqUu7pog9/PD+U/p1MaHj77Imd1YF
        Lvhze43noc8ufwt2PNVPt7+sI/mi/fanLtlwuf8J2YGqC5RYijMSDbWYi4oTAXpYe67CAgAA
Message-Id: <20181018093635eucas1p271a3ad07fc32284696272a811bfc5542~eqlLqvBj11414614146eucas1p2P@eucas1p2.samsung.com>
X-CMS-MailID: 20181018093635eucas1p271a3ad07fc32284696272a811bfc5542
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181018093635eucas1p271a3ad07fc32284696272a811bfc5542
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018093635eucas1p271a3ad07fc32284696272a811bfc5542
References: <1539855370-15194-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181018093635eucas1p271a3ad07fc32284696272a811bfc5542@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decon hardware supports variable plane alpha. Currently planes
are opaque, make this configurable.

Tested on TM2 with Exynos 5433 CPU, on top of exynos-drm-next,
commit: c530174b90fa

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

