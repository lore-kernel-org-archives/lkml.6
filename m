Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBAKna (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:43:30 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36047 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751936AbeBAKnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:43:10 -0500
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
Subject: [PATCH v1 2/2] drm/stm: ltdc: remove non-alpha color formats on layer 2 for older hw
Date: Thu, 1 Feb 2018 11:42:43 +0100
Message-ID: <20180201104243.20726-3-philippe.cornu@st.com>
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

Hw older versions support non-alpha color formats derived
from native alpha color formats only on the primary layer.
For instance, RG16 native format without alpha works fine
on 2nd layer but XR24 (derived color format from AR24)
does not work on 2nd layer.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/stm/ltdc.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index f6f26fc0ae9e..1a3277e483d5 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -703,6 +703,11 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
 	if (!fb->format->has_alpha)
 		val = BF1_CA | BF2_1CA;
 
+	/* Manage hw-specific capabilities */
+	if (ldev->caps.non_alpha_only_l1 &&
+	    plane->type != DRM_PLANE_TYPE_PRIMARY)
+		val = BF1_PAXCA | BF2_1PAXCA;
+
 	reg_update_bits(ldev->regs, LTDC_L1BFCR + lofs,
 			LXBFCR_BF2 | LXBFCR_BF1, val);
 
@@ -785,6 +790,12 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 		drm_fmt_no_alpha = get_pixelformat_without_alpha(drm_fmt);
 		if (!drm_fmt_no_alpha)
 			continue;
+
+		/* Manage hw-specific capabilities */
+		if (ldev->caps.non_alpha_only_l1 &&
+		    type != DRM_PLANE_TYPE_PRIMARY)
+			continue;
+
 		formats[nb_fmt++] = drm_fmt_no_alpha;
 	}
 
@@ -913,10 +924,19 @@ static int ltdc_get_caps(struct drm_device *ddev)
 	case HWVER_10300:
 		ldev->caps.reg_ofs = REG_OFS_NONE;
 		ldev->caps.pix_fmt_hw = ltdc_pix_fmt_a0;
+		/*
+		 * Hw older versions support non-alpha color formats derived
+		 * from native alpha color formats only on the primary layer.
+		 * For instance, RG16 native format without alpha works fine
+		 * on 2nd layer but XR24 (derived color format from AR24)
+		 * does not work on 2nd layer.
+		 */
+		ldev->caps.non_alpha_only_l1 = true;
 		break;
 	case HWVER_20101:
 		ldev->caps.reg_ofs = REG_OFS_4;
 		ldev->caps.pix_fmt_hw = ltdc_pix_fmt_a1;
+		ldev->caps.non_alpha_only_l1 = false;
 		break;
 	default:
 		return -ENODEV;
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index edd1c0a446d1..edb268129c54 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -17,6 +17,7 @@ struct ltdc_caps {
 	u32 reg_ofs;		/* register offset for applicable regs */
 	u32 bus_width;		/* bus width (32 or 64 bits) */
 	const u32 *pix_fmt_hw;	/* supported pixel formats */
+	bool non_alpha_only_l1; /* non-native no-alpha formats on layer 1 */
 };
 
 struct ltdc_device {
-- 
2.15.1
