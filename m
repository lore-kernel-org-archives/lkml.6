Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D286EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843E420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BsHmYv5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843E420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJYX5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:57:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45624 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeJYX5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:57:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181025152413euoutp01fa82ad6293ca58aff67d236ecb587e6b~g41tTE5Pz2929729297euoutp01t
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:24:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181025152413euoutp01fa82ad6293ca58aff67d236ecb587e6b~g41tTE5Pz2929729297euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540481053;
        bh=CGAsXnZsd8ZQlCgwY0KT2+/UO5LSFMfTF0ySQJfbuvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsHmYv5ifRXm1pmYdgARtYilbM570yNRvZd9GFbysNssCX0kXDhN7aDOylara649D
         1wGJZwFafXRDHF///xSeu9AZn8tQOv/FWRuieSWAf7AurWxZVql0Z2EUw7NgVY2CZT
         63GW00/u/tBCHxUgcM4UH0d8NU3eJzyAUYlufLSI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181025152413eucas1p215536958f8d5074c9c3d9efdeb13c5b7~g41so3QMZ0198101981eucas1p2c;
        Thu, 25 Oct 2018 15:24:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 09.71.04441.C10E1DB5; Thu, 25
        Oct 2018 16:24:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181025152412eucas1p290814b0ac4ce25e64fa166b691819e69~g41r7Mkz81123611236eucas1p2W;
        Thu, 25 Oct 2018 15:24:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181025152412eusmtrp178c22e8758df13130918aa3c28aca94b~g41rrzKcJ0121301213eusmtrp1p;
        Thu, 25 Oct 2018 15:24:12 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-39-5bd1e01cb098
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.95.04128.C10E1DB5; Thu, 25
        Oct 2018 16:24:12 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181025152411eusmtip1dc7e3ee2b38a2b41204320933548daec~g41rBkQyw2540325403eusmtip1y;
        Thu, 25 Oct 2018 15:24:11 +0000 (GMT)
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
Subject: [PATCH v2 2/2] drm/exynos: fimd: Make pixel blend mode configurable
Date:   Thu, 25 Oct 2018 17:23:50 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540481030-15019-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjm27kqLY9T8vOS0qwoI00qOFGEgeGi6PKnH02rk550pFN33EwJ
        HCrivaVEoiLD8tI0L8u7KKnVUmlmXprOG1h5y8IrJSW5Ha1/z/s87/M+7/vxkYioDHMhZfIY
        ViFnwsW4Ldrw9pfxqNtUv/RYavoperTKiNFZxm4BXZtXjdGG1hJAD679wOmcSQ1Kz070o/TD
        6QWE7uurIej3id8IWj89jNEDLYU4ndfXLqBfvB4n6LzcOdzPTqLXpeGSxvUpTDKZYRBIXj5L
        kGTX6YBkRe9+Fb9heyaEDZepWIXP2du2YdnD9SBqw+t+V3eVQA2aPdOBDQmpE9Cs3QDpwJYU
        UeUA5nw3E3yxCuDy45VtZQXAL5vaLYW0WvQlly1uEVUG4FDBxX+GN61jmEXAqZPQPL6MW7Aj
        5Qn/PNJZByFUPQrbuk0Ci+BAXYJJbd1WjFIHYM1SPuB3cocjxjTEEmZDXYCvRnwsXkg1ELC0
        Msc6VEip4GaNabvfHy4Xp+A8doDzhjqCx26wNzcT5c1JAI6uDmN8oQGwoyId5btOQ71pXmBJ
        Q6jDsLrFh6fPwcEhI85fvBuaFu0tNLIFcxqeIDwthKkpIr77IFyoq8N3YmdX1rZXk8CujiyE
        f6BCAMvVE6gGeOT/D9MCoANOrJKLCGU5Xzkb680xEZxSHuodHBmhB1vfp3fTsNwE1j7e6QQU
        CcS7hO9qPkhFGKPi4iI6ASQRsaOwzdwvFQlDmLh4VhF5S6EMZ7lO4EqiYidhaVGtVESFMjHs
        PZaNYhU7qoC0cVGDBO3S0yY4W/t575z2d/Ihv6C4oj1Vsb6yENVX++PZQTMVY5lBaLvSH1sM
        nJFd6UeavJrUP/2iiQmNa6lhLiAwau5Irm4k8eYn/wzxebXzYDQX30zLCq4FJCs9elrGrg8M
        BdsRXT3JyuIHGiYSrtcPdyqem+/u29/ovLAaXRkuRrkwxtcLUXDMXz4qsDQ6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4XV2ZBxejDbpaWS1urTvHatF77iST
        xcYZ61ktju9eymhx5et7NotJ9yewWLy4d5HFov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZ
        zDi/j8li7ZG77BYzJr9kc+D32LSqk81j+7cHrB73u48zeWxeUu/Rt2UVo8fnTXIBbFF6NkX5
        pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GX3XtjIW/NKq
        OHxyHVMD407lLkYODgkBE4lNS/26GLk4hASWMkq83LWErYuREyguIzHvbB+ULSzx51oXG0TR
        J0aJ7zteMYIk2ARMJW7f/QRWJCKgLPF34ipGkCJmgYMsEi0bz4AVCQv4SDTvPckEYrMIqEps
        +DgLLM4r4CExd801FogNchI3z3Uyg1zEKeApceCmPkhYCKjk9cknrBMY+RYwMqxiFEktLc5N
        zy020itOzC0uzUvXS87P3cQIjIVtx35u2cHY9S74EKMAB6MSD++JDReihVgTy4orcw8xSnAw
        K4nw7r19MVqINyWxsiq1KD++qDQntfgQoynQTROZpUST84FxmlcSb2hqaG5haWhubG5sZqEk
        znveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgXHdWWnjP5Iv8icpr7luNnHhYfuzSbXyYWIhD8Vm
        qT0U1kq0fxV47n1lcqjgAqGpG3TrThufrE5T5mi76inicvOHKF9OwPlA71lBOsJXhKJe+Zwz
        Y+X8p39j6pPzE7+7GbHkp+5x37VqyWHrnjvGB4tqbNMe5YofDfjY/Ubn3qYdM7Z73VB43anE
        UpyRaKjFXFScCACmjOMFmwIAAA==
Message-Id: <20181025152412eucas1p290814b0ac4ce25e64fa166b691819e69~g41r7Mkz81123611236eucas1p2W@eucas1p2.samsung.com>
X-CMS-MailID: 20181025152412eucas1p290814b0ac4ce25e64fa166b691819e69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181025152412eucas1p290814b0ac4ce25e64fa166b691819e69
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181025152412eucas1p290814b0ac4ce25e64fa166b691819e69
References: <1540481030-15019-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181025152412eucas1p290814b0ac4ce25e64fa166b691819e69@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fimd hardware supports different blend modes. Add pixel blend mode
property and make it configurable, by modifying the blend equation.

Tested on TRATS2 with Exynos 4412 CPU, on top of linux-next-20181019.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
changes in v2:
 - add premultiplied mode by setting blending equation accordingly,

 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 68 ++++++++++++++++++++++++++------
 include/video/samsung_fimd.h             |  9 +++++
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 9c4ff60326b9..fbf9bfa20e9a 100644
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
@@ -567,13 +567,52 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
 	writel(val, ctx->regs + VIDCON0);
 }
 
+static void fimd_win_set_bldeq(struct fimd_context *ctx, unsigned int win,
+			       unsigned int alpha, unsigned int pixel_alpha)
+{
+	u32 mask = BLENDEQ_A_FUNC_F(0xf) | BLENDEQ_B_FUNC_F(0xf);
+	u32 val = 0;
+
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+	case DRM_MODE_BLEND_COVERAGE:
+		val |= BLENDEQ_A_FUNC_F(BLENDEQ_ALPHA_A);
+		val |= BLENDEQ_B_FUNC_F(BLENDEQ_ONE_MINUS_ALPHA_A);
+		break;
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
+		if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+			val |= BLENDEQ_A_FUNC_F(BLENDEQ_ALPHA0);
+			val |= BLENDEQ_B_FUNC_F(BLENDEQ_ONE_MINUS_ALPHA_A);
+		} else {
+			val |= BLENDEQ_A_FUNC_F(BLENDEQ_ONE);
+			val |= BLENDEQ_B_FUNC_F(BLENDEQ_ONE_MINUS_ALPHA_A);
+		}
+		break;
+	}
+	fimd_set_bits(ctx, BLENDEQx(win), mask, val);
+}
+
 static void fimd_win_set_bldmod(struct fimd_context *ctx, unsigned int win,
-				unsigned int alpha)
+				unsigned int alpha, unsigned int pixel_alpha)
 {
 	u32 win_alpha_l = (alpha >> 8) & 0xf;
 	u32 win_alpha_h = alpha >> 12;
 	u32 val = 0;
 
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		break;
+	case DRM_MODE_BLEND_COVERAGE:
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
+		val |= WINCON1_ALPHA_SEL;
+		val |= WINCON1_BLD_PIX;
+		val |= WINCON1_ALPHA_MUL;
+		break;
+	}
+	fimd_set_bits(ctx, WINCON(win), WINCONx_BLEND_MODE_MASK, val);
+
 	/* OSD alpha */
 	val = VIDISD14C_ALPHA0_R(win_alpha_h) |
 		VIDISD14C_ALPHA0_G(win_alpha_h) |
@@ -604,6 +643,12 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 	uint32_t pixel_format = fb->format->format;
 	unsigned int alpha = state->base.alpha;
 	u32 val = WINCONx_ENWIN;
+	unsigned int pixel_alpha;
+
+	if (fb->format->has_alpha)
+		pixel_alpha = state->base.pixel_blend_mode;
+	else
+		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
 
 	/*
 	 * In case of s3c64xx, window 0 doesn't support alpha channel.
@@ -637,11 +682,9 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 		break;
 	case DRM_FORMAT_ARGB8888:
 	default:
-		val |= WINCON1_BPPMODE_25BPP_A1888
-			| WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
+		val |= WINCON1_BPPMODE_25BPP_A1888;
 		val |= WINCONx_WSWP;
 		val |= WINCONx_BURSTLEN_16WORD;
-		val |= WINCON1_ALPHA_MUL;
 		break;
 	}
 
@@ -657,12 +700,13 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 		val &= ~WINCONx_BURSTLEN_MASK;
 		val |= WINCONx_BURSTLEN_4WORD;
 	}
-
-	writel(val, ctx->regs + WINCON(win));
+	fimd_set_bits(ctx, WINCON(win), ~WINCONx_BLEND_MODE_MASK, val);
 
 	/* hardware window 0 doesn't support alpha channel. */
-	if (win != 0)
-		fimd_win_set_bldmod(ctx, win, alpha);
+	if (win != 0) {
+		fimd_win_set_bldmod(ctx, win, alpha, pixel_alpha);
+		fimd_win_set_bldeq(ctx, win, alpha, pixel_alpha);
+	}
 }
 
 static void fimd_win_set_colkey(struct fimd_context *ctx, unsigned int win)
diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index f070b7c0d2cf..4ba5efe8d086 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -198,6 +198,7 @@
 #define WINCONx_BURSTLEN_8WORD			(0x1 << 9)
 #define WINCONx_BURSTLEN_4WORD			(0x2 << 9)
 #define WINCONx_ENWIN				(1 << 0)
+#define WINCONx_BLEND_MODE_MASK			(0xc2)
 
 #define WINCON0_BPPMODE_MASK			(0xf << 2)
 #define WINCON0_BPPMODE_SHIFT			2
@@ -438,6 +439,14 @@
 #define WPALCON_W0PAL_16BPP_565			(0x6 << 0)
 
 /* Blending equation control */
+#define BLENDEQx(_win)				(0x244 + ((_win - 1) * 4))
+#define BLENDEQ_ZERO				0x0
+#define BLENDEQ_ONE				0x1
+#define BLENDEQ_ALPHA_A				0x2
+#define BLENDEQ_ONE_MINUS_ALPHA_A		0x3
+#define BLENDEQ_ALPHA0				0x6
+#define BLENDEQ_B_FUNC_F(_x)			(_x << 6)
+#define BLENDEQ_A_FUNC_F(_x)			(_x << 0)
 #define BLENDCON				0x260
 #define BLENDCON_NEW_MASK			(1 << 0)
 #define BLENDCON_NEW_8BIT_ALPHA_VALUE		(1 << 0)
-- 
2.7.4

