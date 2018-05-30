Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbeE3LYp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:24:45 -0400
Received: from mail-ve1eur01on0081.outbound.protection.outlook.com ([104.47.1.81]:12793
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751441AbeE3LYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:24:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com;
From: Lowry Li <lowry.li@arm.com>
To: liviu.dudau@arm.com
Cc: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        brian.starkey@arm.com, malidp@foss.arm.com, nd@arm.com
Subject: [PATCH v2 2/2] drm/mali-dp: Implement plane alpha and pixel blend on malidp
Date: Wed, 30 May 2018 19:23:54 +0800
Message-Id: <1527679434-13228-3-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527679434-13228-1-git-send-email-lowry.li@arm.com>
References: <1527679434-13228-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:3:1::15) To DB6PR0801MB1975.eurprd08.prod.outlook.com
 (2603:10a6:4:75::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1975;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;3:gG53Vh61eTds2+/l1LCSCp0CXwm/pwM3VSo4/QyymQHf43CKPKAySiF4eTmwB7yQkZqLA9P7JMQjEavK6cAVcaJC0Hn/CW7YkGkQekKfQH5xJVsoqTlaD3rw0b1y/5t3yKIwZLyv9LegZEk8sduDMJvdF+2hlWadLh+QI2Glk0bvc1xWXiHfOKnlt2+OmcEhujYFmVSK38MB922FiTyfC/VbCpe9X4n0MIWo/B/yVJBVWVbZq268qUGdc4mSkckN;25:f/q1Iwtb+aOvbFsshMmHspcGmxEjdnVz+yEaqEGGRhvgdLmSEAEQ0bno0KOtaKbavl5zJ2NESc6Yr2M+rHzeNfE0GlBgXAK53Z2LMaFiSrQYCVZVZX00MJk21fSsDDruYAwUCCGwYUDXIKfZKL54tLvPYzdje7Rt+bg61v9v0lrLWvX9G5C6v7SZeamxwyL57EvCvFngii01Itfq4NWqnxzFUEj/wAGfedkCbobwsU9Zt5PMrS0WcQlshHPHaKUOk1brz5Q9JA1G/7wENVOt3uxgV/KLjYSCk1UzHdLYced04OQ2lMfDEdsY1s095KZ4DYtaHmRhwiT+PuFzy2YGow==;31:cJbmND+DyK79d8AFySZKjcm3L81/gjEsXP10gBr/xzuMolvyC6driWssqk9yiAVwMNQEVL9dTNtz+wF2UsPechZ2Npsagri1hDbi2uyVfIZ2cH9Pk+XM1llpbmwFON2Mr0YS5RvpJpmpafzPJP4SIZnsAG1BSlw946GjAoxL7nW8ONmKCJWBXY6geT1jr2GsBoGMZqhnT4LkCOeJf61oAa+6hpxYFYrjac03etBKSNA=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1975:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;20:d8WGRvvb+oG7CPHzQz71K9J4Tgzinq723OKi70NRMegHsAKiC9vU9fb916fhyLVUu+OdiHsn4xQi4VzHg3Z1cAmmuAdAZCVVNKebbukDRfNkIPwUpCBuDzCiTLVMu4+RQ3ADHGLCKkdJyXRRi9cHtBgSZrioOzIEAVo4fj2h+//RAAg7MaZYRJjUzhbUzoGfPOa8sg+RJX977T77tunZcvk3h9qXmN+MHY3IXQfsrUWGtyeZfb1NghA4rofDHQRN;4:RxJyU/BcfAYpa+71+9LE2wNWDHBr5fLCgIwEpFFWwGcBG9WJNsWAUhdBxeo8kXGfWpZzavDXC8X/VeEXENq+JolMqdF7szqQu0bdZF7oUQsdGkY51jd43N4Erbe5v9lq4MJQKRp77qOoscT0YnQv8pFBTGYGb8IPJ3gFI47WFGGkWAfnlBUyXuPuYqWyE2l8XG604+/+Oj+gv8r75X1JT37Zsjgy9YdVMccTlYLRqyin85uZogWGEZ8HeEUnDA2aYzjeLmqVUYMUoxCXWq+2YgOAu7tpnC330a2JDNpyF5gJ09gntoT3Sgjwoys68++x
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1975C18635BE4418FBCCE5A09F6C0@DB6PR0801MB1975.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1975;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1975;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(6636002)(6666003)(48376002)(8936002)(8676002)(105586002)(50466002)(68736007)(2361001)(97736004)(2351001)(106356001)(50226002)(81166006)(5660300001)(6116002)(3846002)(25786009)(305945005)(81156014)(86362001)(7736002)(36756003)(47776003)(76176011)(51416003)(7696005)(4326008)(16586007)(478600001)(476003)(2616005)(956004)(44832011)(5890100001)(45080400002)(486006)(37006003)(386003)(16526019)(59450400001)(316002)(11346002)(26005)(446003)(2906002)(53936002)(66066001)(72206003)(34206002)(52116002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1975;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1975;23:0DqHrIIXYDz5FwuJPyitZ14u2JHzEHuhIyLjheg?=
 =?us-ascii?Q?Po0FdYTe93j5Ino8g+jDQ2RCVnYnlMUocKyY+SG35gWCzAKxEy3l6tlYtF5F?=
 =?us-ascii?Q?/9xb3LmaQuv0I3FS3xYOpfikNqPjBiUbiaXdKxqxQYCxW/dbs6DpipJBB0kJ?=
 =?us-ascii?Q?eyLlHRlmXXzBl93W0JInNXSO23kpEavnGeMkn7yhDqbodSBvTwGPJ5X63j7G?=
 =?us-ascii?Q?wFWrSI2dRnv6651/h/m+JmuhqKZMgwMGU2bko6gjECcJLTuzKGdQsZ414qH1?=
 =?us-ascii?Q?ybgsMp9hI5Rm7dUw0dmcXR14v5grg5F8iTezU6LUjb4FabgofjJv4Nv1LHgc?=
 =?us-ascii?Q?rVNpVSkJIqan0Vlx8n70pRKkJhpiirpu1yFt50U9wrQ1yjq7BdBatZEiC1VC?=
 =?us-ascii?Q?+013lSACu4rDpVGusFIjy31WDc7AySbiOX4EJMuw52d+ye9MIJM3o2PLA6o0?=
 =?us-ascii?Q?joN5YEFIRCF/UjTD+uxcr0cp2T4mLyEyGHvtqI5GOw/ehGJlnyArJVjwjLin?=
 =?us-ascii?Q?MjyHGVvzIbNA84fpFi30YO8zyCGg6oRadTgkpdjmddeDi9PTwCUGZzuvwfNT?=
 =?us-ascii?Q?+8vRZevTXY5nv0daZp6/cDiynoi5TxVlKdsdf/dcpaZLFqQW7PUydTwvn/8j?=
 =?us-ascii?Q?kNTLQXlKQmlT9vk0UERqFyvcOwpNBf6l/GS4JAk+kUDgyvaTypPlo46wEiuQ?=
 =?us-ascii?Q?KqQXZfsHmQkaKaW4gaNPQMfCW8dKeU7amRH04W3j3eOQbgan1RAtkL+VjX8b?=
 =?us-ascii?Q?Hzw9OdQpH8i0ZxZklROhOwyn1NCRmseDeU0ax4FLsiwb4NobbQbxn9pplTO1?=
 =?us-ascii?Q?h8taTtjgUQJZJJ76eN+h/dR/tJcWQNx1YWodI/MbgvpPUBLmhvvnEHG7e1Qs?=
 =?us-ascii?Q?mq8BvUzxRns3oiZEGVNI00yR/aBv9YG6WogUaiFwiDNoUjJX5jizuelCFlix?=
 =?us-ascii?Q?JNjYahXA9PJKUMFRuPcpH+i00SJuHwsSKh5y0R+thQeL4BfDcFhxMEnn60gE?=
 =?us-ascii?Q?z6aIBSuLYxPWfMbvmyGS2mG2sm4We+SUYJJQ+iD44vySeweJVAN57f6PeHyJ?=
 =?us-ascii?Q?ZAx5Y9gFYcmLBEZ4+33tVYqWYBZbaxLAFXWtsx3eD+wznl34rYeFe2pXpUZz?=
 =?us-ascii?Q?1ENC27jPCeq5BlUlKanKo5oYvAGZLSJY4lkrAVnKbfrF8aqfptOb+nJ7Nbk+?=
 =?us-ascii?Q?epSqbHE8k6FCIjYFXX6/ERgGFKqTIpaJaOoyksYPtTNzLg8UrLPOiwLegNJR?=
 =?us-ascii?Q?OB6nwuEHVlWRyBeS/EnIXczCmVtIwrMrKkS/W980SNsjbXvCQfbBUvSMhgBj?=
 =?us-ascii?Q?IvVJYBcLOwT+qojdvXyFMIDi1p9OxkKj6HnNYSOFCXyzW58kfsvx29WhFrA1?=
 =?us-ascii?Q?qLbsf4Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: TM2FXDa8YlR3xTg1QpNtRsR+e6SeLk1SVgY803FAk/dehPQq7nxCMTafXyAG2pUTTEac69kH/7zku3PfvIQNMJHO+SjLuEIWNVWKamP2vKIlx2XjYX0djSR1BbCAltOUagFWdy95Y/4qaTvy6mZIQsxu+icbm9P0wPiaFWhl1KNCoxMekpb83IUTW1tEyejG
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;6:uRfDyALPTlWZJVEVAeVdQS25r4ElniV/IamPCOFg+mbzxAulW9c+BMOO9JZuDGiX+n0EaxjpEektBtLVnkHzBoWue57dyyoXkK2Pj39ij9ubFnH6sy/ZRVLzh9e0GEOG/oa1AfI+kknroh5OzH3FwgBXthoksfoCr4PXrUI1U+0i9/41YeOQrvYS6oBvMV7vR72h08dXeJojo43QIexUprWBmoCicqKyhRwcAPFHajYXNIZC53n8ZFFwpRJtStwhRnbRq0ANYTMMrFQEKkKIPTSjcQ4G5ymJQoCQEIWDYq/Uy6U4GNCspnKDaYSnKDF5iaBqurfsBPr8qOpNJShZ7bGd1m4meWFtDCTmimihmFDBFLu0pwBl6+ysfswS56Q5ihxTVUtZNMI15yQW1Z9o2FD+w/oJxybTe4CebrTvHMZIEr35jI+gE4OzG5Bl/Zn4TGNRIomH69fyo4SCza8SLg==;5:K5fMu5KSaCqowJRPs9xk9YnCnHhs4vFmTxoRB40zcO4dDsOJ7ik/ZMV+VGUVCempVRhs8cNexUgj+UzpOFl7PcbTHaUsRn9xaJ/yLd8EOuod1OZ8Vnl6UuLOU1Tzy1+rjGebMnXFi1q9plAS1dB5nK/hxSmBghD/atNPQXtk88M=;24:3ZZG4aI1UFXdOnZN0mX6TtMKO69QyeqUnxTemNOEv3bcvbQiPN7t9XJZLdFw0WQQv3o9UUMb3u3VW6g/77qWCy5E67X4MAFMqH5nm5b/nk0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1975;7:HnV8Ux118iBl70MDCFsTrLWkhegrQQWPB1RzvijZoCIggp3zntTIT59OIwMYS4zUdoQpI0L7e2k9Bn4WOo+pOgq5GpRxmqgBGQXisrK1xrhCg/wxEAdDeP3trS8E0rB7QXjdZtTf9I2oTGUDjrNt2fzHiWOrS5AqjK0lWdbh5mzvW7fUdkXY/RjBINIixLu9hhraY9MaCDJiXJNXhSjSSpOXw7ss+lqy/GA7Fh/DBf3UfPqd7oth/Dr1ApYJBEbc
X-MS-Office365-Filtering-Correlation-Id: f725fa65-e232-4233-b95f-08d5c61fed8c
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 11:24:33.0294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f725fa65-e232-4233-b95f-08d5c61fed8c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1975
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the pixel blending mode and plane alpha value when
do the plane_check. Mali DP supports blending the current plane
with the background either based on the pixel alpha blending
mode or by using the layer's alpha value, but not both at the
same time. If both case, plane_check will return failed.

Set the HW when doing plane_update accordingly. If plane alpha
is the 0xffff, set the PREM bit accordingly. If not we'd set
ALPHA bit as zero and layer alpha value.

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
