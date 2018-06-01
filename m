Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeFAMmL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:42:11 -0400
Received: from mail-eopbgr50054.outbound.protection.outlook.com ([40.107.5.54]:49808
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752041AbeFAMmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:42:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com;
From: Lowry Li <lowry.li@arm.com>
To: liviu.dudau@arm.com
Cc: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v3 2/2] drm/mali-dp: Implement plane alpha and pixel blend on malidp
Date: Fri,  1 Jun 2018 20:41:11 +0800
Message-Id: <1527856871-3007-3-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527856871-3007-1-git-send-email-lowry.li@arm.com>
References: <1527856871-3007-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To HE1PR0801MB1977.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1977;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;3:eczxk5gw1CpICafykbKhxi/5i3BUOJ31Uyf5bhTbrWEcSRwOkYGUWdE8zmgHHCKI6n1zggNASM3sSo9J/gKZ0l+BsbVaSfPLCnOp6obzCtsthK3I2C2xjrlpFctGh5Gt6tJdFitThnxehb3OasW9Jf15mIhkpKCT1W75C6mXDd+F1bs4pHST89XcVrHLNvZPr8yWbEM1r5ZagA8wCbt1exN2gsr4qYCUCts/EZDxeNW6GGktM4FJpIMnOa9aMqCI;25:qgVo1sfIyuhrxpE8EMTergkvB57AcvkuFMN/4+4UTWogviJbqf0noJTWH7UjtfjNrEGSIJ7OVhbb4s09+sL75uKJQdRc54Xy18DG8RajPWQUtNwzUbCgOqbmmtXnszvFN9iWxJbcTLIxjO0bzXsV6qxWGNc1txXBGbvdc7bzA/s0F9hRGbmjj0c0UIUNzWWGqdltMCjVmsadqKQ5METisFoAHs9INw5k6JjYVQKnqD4B8AUM6Rtx22TJLhnl77CThPGd5QCgSV+A6c6742cRfTZEm4VU1ZVpvTVFjIvgtYIu324BWy7SBHW0u+yyYgOjSzxZRsGC37OOMDb4D2jE5w==;31:AZek5THdspj5qa1jEi8LGq2OMs/sChSNo1s7PBiMuf+igUwIUmh67vtYPPKu9mi7atP+vHx34WXKRKAf+JapwgxSevmeuqQ87dM2Frju2wuejLG0JlVJJmo1eGZMvLUmg+CCBEV7qLXxCH7fbzdtTMjpSOCGa+BKA2Fb8KO+2JIhJfOD28S7fUVKgWrw8JK+m4JzwLyTxEiD1PZmg9InJa+VfZbtDSer3Wf7nZ/KuQg=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1977:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;20:uFSYdAm+4eHqkmuyGeDqMNurvB2rcCLi8AlCsskJyPA0lrHwR6PO+rKUWIPkX8XrhzXfailWWGLN5xLlJE5EvqBV5tIFl2Uxx/KBaT574nMAs/LHr86wUmYDvJKrVyP0t+RRtMBB9Ydr2GXdLU/Ei9MKSkLy1eN8LHLitox6UwA+KxDzTM+JOAuDEBMSkXSBR1XZPFcZfrSS7l3RPkv2ITSLcjmxtDJ5Qdxp+9/FVY4eCIzKVdb3Caph5Tg+aca3;4:x+UPhPDQs6MDdUzX1IZAGIIgX0tMhf0u7mioUrxQFAjgn1GAEODS12xcT98R9PXs7wUt8M9g+yWyvJNo9bAhkwTrscTAkkiotkmGWb/I07hPO/U79oH1Xs1FqE7DzU9KRMUGjLR1tp2L8cDkx/2cM6xQTN21jBu8GyLkYB3IQrgN5ItjAfipFsIqeKRZwSGIQRcKIsopEL5HJo/MM+LVD7hEl2atCBGbp8On2xYYU+7EizGZem10HgfhGDil130UPOzhAkWzi3gBzPsGziY8ibKaZxzwdockXH5VAWUUk6xow0pQI87hCLXvK7MjbXy/
X-Microsoft-Antispam-PRVS: <HE1PR0801MB197700237164A4C7ED4E7F809F620@HE1PR0801MB1977.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1977;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1977;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(39380400002)(346002)(189003)(199004)(97736004)(478600001)(72206003)(47776003)(6636002)(6666003)(6486002)(66066001)(86362001)(50226002)(76176011)(386003)(105586002)(37006003)(16586007)(45080400002)(5660300001)(305945005)(36756003)(7696005)(52116002)(48376002)(51416003)(2361001)(106356001)(59450400001)(26005)(8676002)(16526019)(11346002)(50466002)(446003)(316002)(53936002)(4326008)(81166006)(2616005)(44832011)(7736002)(486006)(39060400002)(34206002)(476003)(6116002)(3846002)(5890100001)(956004)(25786009)(8936002)(68736007)(2351001)(2906002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1977;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1977;23:48VQrtp1U6ZDdvknSn880bUFsUFojisJELXfmeq?=
 =?us-ascii?Q?3vkSaBgEhSynjzyK3C9mYZiNluSQN1qkUVTJYuMtSxPFcnTaK3fApbbRAnE/?=
 =?us-ascii?Q?H/q8RhjcUWKjXBbCPScau0z49zE7Ut3+jcVO6/JeHjNfZRT6mLYy6BrRj7u8?=
 =?us-ascii?Q?eeYv0Ki1tdMQcvZTDNkK0w3Lq2Lj8wfrUKig0m2MTDJkLq2HErfP7P2vwmZ5?=
 =?us-ascii?Q?1mBfLMDk3TY8sZyQL28ZlJkmW6+0SNyvd4oaQbPk11mlhiESUxlLQ3/4/xX0?=
 =?us-ascii?Q?QRBINaMW9v9C2un4Mgpzrg3KKDZWw87yflXw8VgimPlmtvZR+ZbNyVoKYkuC?=
 =?us-ascii?Q?XqZ8nK4hM6ibxCvyySH3tjcoQxM2BT2AEj09N+YlLBhcqVRgO8aQiSf+weL/?=
 =?us-ascii?Q?vThNFIK6vFo4b5Wa5yO1nyp15Ggoyjkh4oRX+ikR8XNzd6u5Gr6xasmzsaI2?=
 =?us-ascii?Q?7OLgKU4tDmb4vmtkL/t6SCJjx7M7xb7gogYyBYjgxp6DXhMVtJggBdocK0vg?=
 =?us-ascii?Q?rzT7pyGQVjiaADV5NtOZI5l1ZOT4flqqGGBJaZcF6kaKEEp3qHzC5vTyT89D?=
 =?us-ascii?Q?sMDzby7wR/awRLoKuihSEJpq5Hm6eTdF9dwIVjs8OGTnlXXGAtEyuquVK4IJ?=
 =?us-ascii?Q?/NoewXcMZ7IsXwbjX5D4ON//BK2UajUREcHgHigrlPVZhyn8hjCGzV9dj36q?=
 =?us-ascii?Q?1ciTazkieQAqYOoVkWhJW7Stgn/5uj//6cKchKg4ErSpA9CGL+8XNqPA7xeA?=
 =?us-ascii?Q?rc0BF1B8ErkDDTvrLHxHd/83mEuU2/lI1RLF8fIwGOTGmuKh+p+lGt+/2Kav?=
 =?us-ascii?Q?FKZrt+UkEWrqYAyr1EKTCrLAUd0TkxnRAKA3ZZ7SQoKq0H+wWTysiTC7zCZP?=
 =?us-ascii?Q?js3FD0EdXsdRUCFc2jO4eKzmA3zg2PO997lZ+VoLQjqU5fc+8xblXSN5sDfR?=
 =?us-ascii?Q?qh1qNups8lM+YIEPRTmrGA5bN1rpOIQ/BJcr4Pp2w55pHbtjq/EMkZPo00QJ?=
 =?us-ascii?Q?w2r0xvbyMBbu6L8Cqny8fpVbakF5OjM1OVJLZ+b9aQ7Av3SatC9L74RWS+7u?=
 =?us-ascii?Q?00r3zBbCnyz4bfuUU4je5GqPlGewu7zFcD5g+hBCSLsSauameBNnCirwMU+J?=
 =?us-ascii?Q?9WxVt3EioQO2FfGY1g88+i0HhZtJYhH4BbP3jCERYUymiJge23zLOwfu4N8H?=
 =?us-ascii?Q?dVc2z/QWObydm10tnW/lYXEEdeyibzP5gWmlQAqtyoTqtVH75VXsWCjIXXzi?=
 =?us-ascii?Q?PpMkcVP25QUTlUdD0ak9J7gDw7Sg5KOYVWBTDze2B4mqZcDG3b8EP7bHlOn2?=
 =?us-ascii?Q?uFOYZzwQqkKbHMtAUfGPvzzueB0ga9aFUCYoIww4kqGdNQ7iM+l60l99b+6s?=
 =?us-ascii?Q?+t0ADvL7fGeOpne8qD80FYk34fak=3D?=
X-Microsoft-Antispam-Message-Info: j40O4Iv0Xp2Or9Rampa/XXcADDypk1plQZl0MMUaCGH4CyMFWJbci0qAxpl/RayVg+fS28yY+kBHj/baAq+YtgwxLvRL318J8NHPmAiZ/pmJvdgqj4hQvO0XFiD9UmK8ft+r0H0JD8G8f3PbwPbqsqpFRwFuPNzvu4xHeCldbNYd8HLSDyp2GBs1QYObDZeJ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;6:pulIIOXwzSIQ85lCMh/xk7o/xGFNy/vgCWQbtXCnV4jeq0n1gIa6AWk5x5izVBTInor37r4NjwCGd0jdY/V6dmlmkl0fsQo5X1WW1S9IlsWau4c1xdMgWjxCZxAH5RFo8Kb/SxTtpbUnl9/bUpa/gojLSDc13pUSaf97c2R4Rct9Zdrt3Mjzt2Ydfi2JtCataUBeg9MCBPAZ8fvd3vX3spH3xOtj1t09deKOv9znjKpm55drbb4Um0FyYL4Vqga7UQodUQ6B5E8GhtbWaJT6gRBgfsj4XPcIG3volBZaw24UvS42yYFY9oicGG96tN2H3EFMA4c6LNN4FXaF6+NiuFmOGhzuX0U6EB7ckrvO4yWTYwUh+VcrEpUrZvrRI1E0W0EAS9/8Au8h9aOGhpBmZq6DxmH8by0JXyMEs6Z7ttEjOvrLxa2k1CzvcHvLYMK9nvcptIc5+Wh4kW5eQW7hAw==;5:8IRLoHIOFReM8bi6ZaPxNZBTA5Kccke5JINOHAW8h87x+WiphlO1LT8yS9GXYFRl0yXCiXO8Ax2febo3KRCkLJuxLIzHFNx5D0LBAk6JChVsSs1vFNn7WurJ87e5Mc+62w/CSv7fvsNkj97qceqEz8CBu6Go0NnIu5//V8ix8B8=;24:JsJwGtFl8pjpuH3WSGmsd6Fpls5TWn/whDg01HOOfZCA4hbuIgJNaapuSZA5OiHnPY5ZNpdJnR/QQYDPHzE5EY1zbi0rIeL6JEwhwCgMpZI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1977;7:fFe17lq2ZAyDoLSnpM6AxzZYukgngbPMbXRkvH6Nc/Lw9+I5ODM7znvdO2TQgFMV17GGcZmp8kpF4pKb30cuAKEYAo5/mjuTrvo8nHhdGVVYWLNymgTywEp/frQlG/drdVX6An09hPxWyqMED4yoSRduVrY6VNRbXwRNAw3H54pIP91qYzZUeVUYAT+XMVrxxtIC9l6QYYmDK3g4PN/M/ywHJaBZc5ZUvGQxjp1nOYaaDhtJRXysdcsUr+vygsMt
X-MS-Office365-Filtering-Correlation-Id: f32c0789-86d1-4d3f-2909-08d5c7bd11d3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 12:41:55.7246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f32c0789-86d1-4d3f-2909-08d5c7bd11d3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1977
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Check the pixel blending mode and plane alpha value when
do the plane_check. Mali DP supports blending the current plane
with the background either based on the pixel alpha blending
mode or by using the layer's alpha value, but not both at the
same time. If both case, plane_check will return failed.

2. Set the HW when doing plane_update accordingly. If plane alpha
is the 0xffff, set the pixel blending bits accordingly. If not
we'd set ALPHA bit as zero and layer alpha value.

Signed-off-by: Lowry Li <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 76 +++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 7a44897..daa3f4f 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -35,6 +35,7 @@
 #define   LAYER_COMP_MASK		(0x3 << 12)
 #define   LAYER_COMP_PIXEL		(0x3 << 12)
 #define   LAYER_COMP_PLANE		(0x2 << 12)
+#define   LAYER_PMUL_ENABLE		(0x1 << 14)
 #define   LAYER_ALPHA_OFFSET		(16)
 #define   LAYER_ALPHA_MASK		(0xff)
 #define   LAYER_ALPHA(x)		(((x) & LAYER_ALPHA_MASK) << LAYER_ALPHA_OFFSET)
@@ -182,6 +183,7 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 	struct malidp_plane_state *ms = to_malidp_plane_state(state);
 	bool rotated = state->rotation & MALIDP_ROTATED_MASK;
 	struct drm_framebuffer *fb;
+	u16 pixel_alpha = state->pixel_blend_mode;
 	int i, ret;
 
 	if (!state->crtc || !state->fb)
@@ -244,6 +246,11 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 		ms->rotmem_size = val;
 	}
 
+	/* HW can't support plane + pixel blending */
+	if ((state->alpha != DRM_BLEND_ALPHA_OPAQUE) &&
+	    (pixel_alpha != DRM_MODE_BLEND_PIXEL_NONE))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -325,31 +332,33 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 {
 	struct malidp_plane *mp;
 	struct malidp_plane_state *ms = to_malidp_plane_state(plane->state);
+	struct drm_plane_state *state = plane->state;
+	u16 pixel_alpha = state->pixel_blend_mode;
+	u8 plane_alpha = state->alpha >> 8;
 	u32 src_w, src_h, dest_w, dest_h, val;
 	int i;
-	bool format_has_alpha = plane->state->fb->format->has_alpha;
 
 	mp = to_malidp_plane(plane);
 
 	/* convert src values from Q16 fixed point to integer */
-	src_w = plane->state->src_w >> 16;
-	src_h = plane->state->src_h >> 16;
-	dest_w = plane->state->crtc_w;
-	dest_h = plane->state->crtc_h;
+	src_w = state->src_w >> 16;
+	src_h = state->src_h >> 16;
+	dest_w = state->crtc_w;
+	dest_h = state->crtc_h;
 
 	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
 
 	for (i = 0; i < ms->n_planes; i++) {
 		/* calculate the offset for the layer's plane registers */
 		u16 ptr = mp->layer->ptr + (i << 4);
-		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(plane->state->fb,
-							     plane->state, i);
+		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(state->fb,
+							     state, i);
 
 		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
 		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
 	}
 	malidp_de_set_plane_pitches(mp, ms->n_planes,
-				    plane->state->fb->pitches);
+				    state->fb->pitches);
 
 	if ((plane->state->color_encoding != old_state->color_encoding) ||
 	    (plane->state->color_range != old_state->color_range))
@@ -362,8 +371,8 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	malidp_hw_write(mp->hwdev, LAYER_H_VAL(dest_w) | LAYER_V_VAL(dest_h),
 			mp->layer->base + MALIDP_LAYER_COMP_SIZE);
 
-	malidp_hw_write(mp->hwdev, LAYER_H_VAL(plane->state->crtc_x) |
-			LAYER_V_VAL(plane->state->crtc_y),
+	malidp_hw_write(mp->hwdev, LAYER_H_VAL(state->crtc_x) |
+			LAYER_V_VAL(state->crtc_y),
 			mp->layer->base + MALIDP_LAYER_OFFSET);
 
 	if (mp->layer->id == DE_SMART)
@@ -376,38 +385,35 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	val &= ~LAYER_ROT_MASK;
 
 	/* setup the rotation and axis flip bits */
-	if (plane->state->rotation & DRM_MODE_ROTATE_MASK)
+	if (state->rotation & DRM_MODE_ROTATE_MASK)
 		val |= ilog2(plane->state->rotation & DRM_MODE_ROTATE_MASK) <<
 		       LAYER_ROT_OFFSET;
-	if (plane->state->rotation & DRM_MODE_REFLECT_X)
+	if (state->rotation & DRM_MODE_REFLECT_X)
 		val |= LAYER_H_FLIP;
-	if (plane->state->rotation & DRM_MODE_REFLECT_Y)
+	if (state->rotation & DRM_MODE_REFLECT_Y)
 		val |= LAYER_V_FLIP;
 
-	val &= ~LAYER_COMP_MASK;
-	if (format_has_alpha) {
-
-		/*
-		 * always enable pixel alpha blending until we have a way
-		 * to change blend modes
-		 */
-		val |= LAYER_COMP_PIXEL;
-	} else {
-
-		/*
-		 * do not enable pixel alpha blending as the color channel
-		 * does not have any alpha information
-		 */
-		val |= LAYER_COMP_PLANE;
-
-		/* Set layer alpha coefficient to 0xff ie fully opaque */
+	val &= ~(LAYER_COMP_MASK | LAYER_PMUL_ENABLE);
+
+	if (state->alpha != DRM_BLEND_ALPHA_OPAQUE) {
+		val |= LAYER_COMP_PLANE | LAYER_ALPHA(plane_alpha);
+	} else if (state->fb->format->has_alpha) {
+		/* We only care about blend mode if the format has alpha */
+		switch (pixel_alpha) {
+		case DRM_MODE_BLEND_PREMULTI:
+			val |= LAYER_COMP_PIXEL | LAYER_PMUL_ENABLE;
+			break;
+		case DRM_MODE_BLEND_COVERAGE:
+			val |= LAYER_COMP_PIXEL;
+			break;
+		}
 		val |= LAYER_ALPHA(0xff);
 	}
 
 	val &= ~LAYER_FLOWCFG(LAYER_FLOWCFG_MASK);
-	if (plane->state->crtc) {
+	if (state->crtc) {
 		struct malidp_crtc_state *m =
-			to_malidp_crtc_state(plane->state->crtc->state);
+			to_malidp_crtc_state(state->crtc->state);
 
 		if (m->scaler_config.scale_enable &&
 		    m->scaler_config.plane_src_id == mp->layer->id)
@@ -446,6 +452,9 @@ int malidp_de_planes_init(struct drm_device *drm)
 	unsigned long crtcs = 1 << drm->mode_config.num_crtc;
 	unsigned long flags = DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_180 |
 			      DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
+	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+				  BIT(DRM_MODE_BLEND_PREMULTI)   |
+				  BIT(DRM_MODE_BLEND_COVERAGE);
 	u32 *formats;
 	int ret, i, j, n;
 
@@ -498,6 +507,9 @@ int malidp_de_planes_init(struct drm_device *drm)
 		malidp_hw_write(malidp->dev, MALIDP_ALPHA_LUT,
 				plane->layer->base + MALIDP_LAYER_COMPOSE);
 
+		drm_plane_create_alpha_property(&plane->base);
+		drm_plane_create_blend_mode_property(&plane->base, blend_caps);
+
 		/* Attach the YUV->RGB property only to video layers */
 		if (id & (DE_VIDEO1 | DE_VIDEO2)) {
 			/* default encoding for YUV->RGB is BT601 NARROW */
-- 
1.9.1
