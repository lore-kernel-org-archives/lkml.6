Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD077ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D9E2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SV8IQMt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D9E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeJRUxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:53:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34653 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbeJRUxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:53:04 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181018125210euoutp01923c018516d749e3176b31714999692b~etP8tOenq3110431104euoutp014
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:52:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181018125210euoutp01923c018516d749e3176b31714999692b~etP8tOenq3110431104euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539867130;
        bh=9E02YJ4gWL+PlXXstPIqUYWhzDbY8POwv7pBCqjPVIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SV8IQMt96sL+mSmanOQB2YzLVgF2X2dUvx5IFrrDqUQzf/TDInXDnxGbBgyyC4tbo
         zNqc3zB6pdbbZUcYfVMBNbULKCDwr3mx53VDT464AgvXlZewlf8Pz/AkkCiFMyzx1c
         uSz3dN5cQebVVftPiS8AQJHC4Bz+U/PbnI+VWEzA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018125209eucas1p27fa2dc771969ba7beff7048d6e73143c~etP72vwS_3028930289eucas1p2B;
        Thu, 18 Oct 2018 12:52:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 70.BC.04441.9F188CB5; Thu, 18
        Oct 2018 13:52:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181018125208eucas1p1e78fba86800edc4ceae4bbda95871ea1~etP6-rVKA0658506585eucas1p1y;
        Thu, 18 Oct 2018 12:52:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181018125208eusmtrp244e9552c7eb8443e3b3ac010982631e6~etP6pNYN61293212932eusmtrp2B;
        Thu, 18 Oct 2018 12:52:08 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c7-5bc881f999a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 94.CA.04128.8F188CB5; Thu, 18
        Oct 2018 13:52:08 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181018125207eusmtip1366519199472d40711b8a5b6ca56ec80~etP5mSVBa2139821398eusmtip1f;
        Thu, 18 Oct 2018 12:52:07 +0000 (GMT)
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
Subject: [PATCH v3 1/2] drm/exynos: decon: Make plane alpha configurable
Date:   Thu, 18 Oct 2018 14:51:46 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539867107-3383-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0iTYRTHefbuvWw0e5sDH1ZZrJJu3ro+UZRCH94vQYlFNShXvUxJl2xq
        2YeaM0pNUxeRlLcuatrSNufKRcnmcorkUkNLU2eDUivEa5qkbW7Wt/95zu9//pzDQ2FCBy6m
        4hRJrFIhi5cQfK6padYRPJvWLA0z/oKop7oNRzltLRykL6jBkf1VGUAfpkYJVO80k0g7kMdF
        Q/3tXJTr+o4hh+M5id5pfpDI4OrCUae5kEAFjjcclPvSgqNntj4SPRir46K+2zaACm4PExH+
        jK5YBxhDVSbBvJh24kxxyxFm4Kadw9Q+vsrUa19zGLu5h2RuGasAM2EIPMw/yd93jo2PS2GV
        oftj+LHOL5+xxKL1lzTzIWqQH5gFeBSkd0DHQhOeBfiUkH4CoKnJ5CsmASwyNZPeYgLAxhIX
        d8nSsPDBR1UAmN39GvyzGLvTFimC3gl7+8YJjxbR6+Cf/KpFCKM7ceh4+GAR8qcZ+K15Gng0
        l94AB9V3gTciEH5qy8Q8mudm+t9WLsZBepiEX+v0pKchoFPgTN8PN0S5Gwdhpnmn1+sPR+xG
        0qtXwYX6Eo7Xmw5gz2SXb1AegJanWb6F9kLDxxGOZxBGb4I15lDvcyTsmKsmvfP94MefKzzP
        mFtqTXd9sQKYcV3opYPgd6ORWIodmpjyrcLAOUu570D33QeuGAR5YM29/2GlAFSBADZZlSBn
        VeEK9mKISpagSlbIQ85eSDAA9zdrnbePvwRTHWesgKaAZJnAydqlQlyWokpNsAJIYRKRYFbd
        LBUKzslSL7PKC6eVyfGsygpWUlxJgKC8WC8V0nJZEnueZRNZ5VKXQ/HEalAbVhkjHtBFr74m
        bj3KCT4xvnwsudHKk0sjd+iOuZh5W0GEYEgvb58pfLybKUv0O3R1o62Xn5OW3pTRiVoiotJO
        bduirz2+Pa7uzh55bjVfWzoaTc2F/WYpzfsOjU4YpanUNlhEuwIPOCliQPQp+8qwYmuQMzrI
        GHPjkXWtVMJVxcrCN2NKlewvlNw7DGIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7o/Gk9EG0x7wmxxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1nsfLCL3WLS/QksFi/uXWSx6H/8mtni/PkN7BZnm96wW2x6fI3V
        4vKuOWwWM87vY7Lo33GQ1WLtkbvsFgs/bmWxuDv5CKPFjMkv2RyEPdbMW8PosWlVJ5vH9m8P
        WD3mnQz0uN99nMlj85J6j52T9jJ5HN91i92jb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mh48usNcMFeloumfXgPjRLkuRk4O
        CQETif3/r7B2MXJxCAksZZRYf/shO0RCRmLe2T42CFtY4s+1LjaIok+MEi/eLGQFSbAJmErc
        vvsJrEhEQFni78RVjCBFzAIPWSXeL+wESwgLeEg8P/GNEcRmEVCVeNgwHczmFXCXOHt7CdQ2
        OYmb5zqZQWxOoPp7R1eCLRACqnmxYQvrBEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3
        MQJja9uxn1t2MHa9Cz7EKMDBqMTD+yD1eLQQa2JZcWXuIUYJDmYlEV7nhhPRQrwpiZVVqUX5
        8UWlOanFhxhNgY6ayCwlmpwPjPu8knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWp
        RTB9TBycUg2MgnV3J/81nc0+d8K8+1HL2Rq8Jk59lRxnyLRnikVrTyq77SFVzfm/r7G/Lxdp
        yL/LKvAosi9NzaX+TEDMj/qDL74rr7QKuDM/hOmqYfYlUfblm+RXb9YxqBEJMei4x9fFpbHy
        mYx0TJxaqsv5IzUlv1KOdV2K/30nxWCpzGL2G7PXMJ8U3LRKiaU4I9FQi7moOBEA7RV+t8MC
        AAA=
Message-Id: <20181018125208eucas1p1e78fba86800edc4ceae4bbda95871ea1~etP6-rVKA0658506585eucas1p1y@eucas1p1.samsung.com>
X-CMS-MailID: 20181018125208eucas1p1e78fba86800edc4ceae4bbda95871ea1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181018125208eucas1p1e78fba86800edc4ceae4bbda95871ea1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018125208eucas1p1e78fba86800edc4ceae4bbda95871ea1
References: <1539867107-3383-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181018125208eucas1p1e78fba86800edc4ceae4bbda95871ea1@eucas1p1.samsung.com>
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

