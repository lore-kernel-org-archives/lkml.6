Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeBAKnN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:43:13 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37287 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751761AbeBAKnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:43:07 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Fabien Dessenne <fabien.dessenne@st.com>,
        Mickael Reulier <mickael.reulier@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v1 1/2] drm/stm: ltdc: add non-alpha color formats
Date: Thu, 1 Feb 2018 11:42:42 +0100
Message-ID: <20180201104243.20726-2-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180201104243.20726-1-philippe.cornu@st.com>
References: <20180201104243.20726-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ltdc supports natively some color formats with alpha (like
ARGB8888, ARGB1555, ARGB4444...). Related non-alpha formats are
supported too (ARGB8888->XRGB8888, ARGB4444->XRGB4444...) by
adjusting ltdc blending factors.

Note: Wayland/Weston requests by default the non-alpha XRGB8888
color format.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 90b3de516c91..f6f26fc0ae9e 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -328,6 +328,26 @@ static inline u32 to_drm_pixelformat(enum ltdc_pix_fmt pf)
 	}
 }
 
+static inline u32 get_pixelformat_without_alpha(u32 drm)
+{
+	switch (drm) {
+	case DRM_FORMAT_ARGB4444:
+		return DRM_FORMAT_XRGB4444;
+	case DRM_FORMAT_RGBA4444:
+		return DRM_FORMAT_RGBX4444;
+	case DRM_FORMAT_ARGB1555:
+		return DRM_FORMAT_XRGB1555;
+	case DRM_FORMAT_RGBA5551:
+		return DRM_FORMAT_RGBX5551;
+	case DRM_FORMAT_ARGB8888:
+		return DRM_FORMAT_XRGB8888;
+	case DRM_FORMAT_RGBA8888:
+		return DRM_FORMAT_RGBX8888;
+	default:
+		return 0;
+	}
+}
+
 static irqreturn_t ltdc_irq_thread(int irq, void *arg)
 {
 	struct drm_device *ddev = arg;
@@ -680,6 +700,9 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
 
 	/* Specifies the blending factors */
 	val = BF1_PAXCA | BF2_1PAXCA;
+	if (!fb->format->has_alpha)
+		val = BF1_CA | BF2_1CA;
+
 	reg_update_bits(ldev->regs, LTDC_L1BFCR + lofs,
 			LXBFCR_BF2 | LXBFCR_BF1, val);
 
@@ -747,8 +770,8 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 	struct device *dev = ddev->dev;
 	struct drm_plane *plane;
 	unsigned int i, nb_fmt = 0;
-	u32 formats[NB_PF];
-	u32 drm_fmt;
+	u32 formats[NB_PF * 2];
+	u32 drm_fmt, drm_fmt_no_alpha;
 	int ret;
 
 	/* Get supported pixel formats */
@@ -757,6 +780,12 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 		if (!drm_fmt)
 			continue;
 		formats[nb_fmt++] = drm_fmt;
+
+		/* Add the no-alpha related format if any & supported */
+		drm_fmt_no_alpha = get_pixelformat_without_alpha(drm_fmt);
+		if (!drm_fmt_no_alpha)
+			continue;
+		formats[nb_fmt++] = drm_fmt_no_alpha;
 	}
 
 	plane = devm_kzalloc(dev, sizeof(*plane), GFP_KERNEL);
-- 
2.15.1
