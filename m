Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6FBECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3DC2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UB2T61lN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3DC2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeJRRgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:36:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45247 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbeJRRgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:36:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181018093639euoutp01fa290d931d50b9fa9039eb7c778669cd~eqlO3nLoI2385423854euoutp01F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:36:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181018093639euoutp01fa290d931d50b9fa9039eb7c778669cd~eqlO3nLoI2385423854euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539855399;
        bh=MXP29HqdI8UKLNhK2kVI/kK+8sPKymxZW50AkWn3eRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UB2T61lN7JVTTgqVXGK4sOUoqMb2gwtARoTy1mUCkTN/JBxyoYWyO+5DVz2V/JoXG
         QS0Qp3wiG6Do2vOHuJSX0n5H9CZtYwndXkZGfhwafiOOX6zsviIt5iYkMcOiHJ3u2X
         fwuId9py9YeMQVq2roAZznIFvQEkDmbOAR68KG50=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018093638eucas1p164a4f8cc484f8290d7a73c513667ddb4~eqlN7-Z0V2535025350eucas1p1y;
        Thu, 18 Oct 2018 09:36:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 73.70.04441.52458CB5; Thu, 18
        Oct 2018 10:36:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181018093637eucas1p20c846b3959514f8c14a167342d53eba4~eqlNE4PfC1414614146eucas1p2R;
        Thu, 18 Oct 2018 09:36:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181018093636eusmtrp279f8df4c99e317e7df7be9305004dbce~eqlMzlzVJ2801628016eusmtrp2Z;
        Thu, 18 Oct 2018 09:36:36 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-a5-5bc8542522d4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.10.04284.42458CB5; Thu, 18
        Oct 2018 10:36:36 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181018093636eusmtip107a31813c0df82f3e73e84f69e3cc6e3~eqlMG8xxY0370003700eusmtip1p;
        Thu, 18 Oct 2018 09:36:36 +0000 (GMT)
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
Subject: [PATCH v2 2/2] drm/exynos: decon: Make pixel blend mode
 configurable
Date:   Thu, 18 Oct 2018 11:36:10 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539855370-15194-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0iTURjHPe9tc7h8nYKHkqKJgVFeION0k4yI14IyyC8NsVWvunJqW1oa
        qJRa2kVngUNMM7q5vOSc6WalruWUcMPMLpqpeWHeiGaKFlqbr9a333Oe/+88D4fDx0VWci1f
        lnCeVSRI48WUgHjetmDZ6nesXRL0azwI9VZbSHTT0oGhWnUNicxNDwF6P/udQvpBAw8VDhQQ
        yPa1i0D5w5M4slqf8VDn5Ske0g5/IFG3oYRCausrDOU3tpKoytTPQ+U/6gnUf9sEkPr2OLXX
        k6ksrQSMVpNLMQ1zgyRT2nGUGbhuxpi6BxmMvvAlxpgNvTzmlk4DmBnt+gjBccHu02y8LIVV
        BIaeEMRl9oySSSNbLo4PmahMoPPLA658SG+DXZYK3Mki+gmAX6p984DAwT8BbMr6SHDFDIDj
        Y0beqlH9uhbjGo8dRtdV4p/S0PKGcKYoOgT29dspJ3vRvnBRpQHOEE53k9B6v3w55EkfgcYG
        jgnaD06P1GPciPXwsyV3eSlXOhxWjS7gThnS0zw4/C1zWRDSKbBV20lwwn7Yu1S3sp8nnDDr
        VtgH/tGXYZx8BcDenx9IrigAsPVp3oq9C2o/TThSfMd+/rDGEOhESIfB640iDtfAT9MezjDu
        wMLnRTh3LITXckTcHZvgpE5HrU61zcwCjhnYoWrjcQ9UAmCxLZsoABuK/8+6B4AGeLPJSnks
        qwxOYC8EKKVyZXJCbMCpRLkWOL7Z2yWzvRHMvjtpBDQfiN2Eg6xZIiKlKcpUuRFAPi72El7a
        3i4RCU9LU9NYRWK0IjmeVRrBOj4h9hY+Kq2ViOhY6Xn2LMsmsYrVLsZ3XZsJmlUFEfPXdt6R
        dW80ZL0A4faD8sg+1ZSlkd0RLXPrGHM1TfkMjFRfjKkYYlyq6OZDHtH6mvlsFDSZDnoWt8fo
        /COiyOScSI3LgTNdZ2Lev2n6vScEZoX5t7jLho3pbYfv2vLOFaX12LujivQZ4SKVP6YOnUPu
        N+z7PDubE8vEhDJOGrwZVyilfwGQvhdjYgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7oqISeiDVpWmFvcWneO1aL33Ekm
        i40z1rNaHN+9lNHiytf3bBY7H+xit5h0fwKLxYt7F1ks+h+/ZrY4f34Du8XZpjfsFpseX2O1
        uLxrDpvFjPP7mCz6dxxktVh75C67xcKPW1ks7k4+wmgxY/JLNgdhjzXz1jB6bFrVyeax/dsD
        Vo95JwM97ncfZ/LYvKTeY+ekvUwex3fdYvfo27KK0ePzJrkArig9m6L80pJUhYz84hJbpWhD
        CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jIarT1kLnuhUvHx4hK2BcYtqFyMn
        h4SAicS6wxuZuhi5OIQEljJK3Nx0hwUiISMx72wfG4QtLPHnWheQzQFU9IlRosERJMwmYCpx
        ++4nsBIRAWWJvxNXMYLMYRZ4yCrxfmEnWEJYwFfi+8IeJhCbRUBV4u2TrWA2r4CHxIX755kg
        5stJ3DzXyQxicwp4Sqx9+hPMFgKqWfOumW0CI98CRoZVjCKppcW56bnFhnrFibnFpXnpesn5
        uZsYgZG17djPzTsYL20MPsQowMGoxMP7IPV4tBBrYllxZe4hRgkOZiUR3mqzE9FCvCmJlVWp
        RfnxRaU5qcWHGE2BjprILCWanA+M+rySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2amp
        BalFMH1MHJxSDYwi/mnvYnZpFescOnzF9PubGUUB4ppObkFd8ezL51yyFb755lF45a2uYLM8
        i/jk3UvXuLHmSqmLvo2/5HfjUeHWdcnW61jqkkw8Pi9cLcEjv0BxUY1k1evPM7oXbP5uuXOm
        osFzr6SaFy53Ll2Oztiyw3Ed9zKGstQU8WXnzsmc364mbClox67EUpyRaKjFXFScCABD+v9A
        wgIAAA==
Message-Id: <20181018093637eucas1p20c846b3959514f8c14a167342d53eba4~eqlNE4PfC1414614146eucas1p2R@eucas1p2.samsung.com>
X-CMS-MailID: 20181018093637eucas1p20c846b3959514f8c14a167342d53eba4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181018093637eucas1p20c846b3959514f8c14a167342d53eba4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018093637eucas1p20c846b3959514f8c14a167342d53eba4
References: <1539855370-15194-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181018093637eucas1p20c846b3959514f8c14a167342d53eba4@eucas1p2.samsung.com>
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
After further studying the documentation, it turned out that decon
supports premultiplied pixel blend mode by using blend equation,
make use of this.

v2 changes:
 - add premultiplied mode by setting blending equation accordingly,
 - remove no longer used blend mode settings from decon_win_set_pixfmt,

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 64 +++++++++++++++++++++++----
 drivers/gpu/drm/exynos/regs-decon5433.h       | 15 +++++++
 2 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 2578db16750d..bc1339d63aed 100644
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
@@ -293,6 +333,11 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	unsigned int alpha = state->base.alpha;
 	unsigned long val;
 
+	if (fb->format->has_alpha)
+		pixel_alpha = state->base.pixel_blend_mode;
+	else
+		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
+
 	val = readl(ctx->addr + DECON_WINCONx(win));
 	val &= WINCONx_ENWIN_F;
 
@@ -315,9 +360,8 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	case DRM_FORMAT_ARGB8888:
 	default:
 		val |= WINCONx_BPPMODE_32BPP_A8888;
-		val |= WINCONx_WSWP_F | WINCONx_BLD_PIX_F | WINCONx_ALPHA_SEL_F;
+		val |= WINCONx_WSWP_F;
 		val |= WINCONx_BURSTLEN_16WORD;
-		val |= WINCONx_ALPHA_MUL_F;
 		break;
 	}
 
@@ -335,10 +379,12 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		val &= ~WINCONx_BURSTLEN_MASK;
 		val |= WINCONx_BURSTLEN_8WORD;
 	}
+	decon_set_bits(ctx, DECON_WINCONx(win), ~WINCONx_BLEND_MODE_MASK, val);
 
-	writel(val, ctx->addr + DECON_WINCONx(win));
-	if (win > 0)
+	if (win > 0) {
 		decon_win_set_bldmod(ctx, win, alpha);
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

