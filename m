Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4A5C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2C62084E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KzdRUZPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2C62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbeHNOUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:20:22 -0400
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:64474
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730759AbeHNOUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsB4EIxZFMiD2C7gSfpBDJlno5iGLQhlh6lRCqtCIYU=;
 b=KzdRUZPrGir/fCaw/jchk6i1bGyqHQtlJ347MH5BgN+QykNmQMSa9g8PvE1smFQ51pUvsa/cdVEh4nI5x/8zzXoYLqeqwNQXXmcjVjvskwN8htXFTp2CFMo3KcGRpVC4oNQ8usKijMoRND1w9WjDBTb9HZtDcaamIyhnTgKtonQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 VI1PR08MB3533.eurprd08.prod.outlook.com (2603:10a6:803:84::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.22; Tue, 14 Aug 2018 11:33:25 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v4 2/2] drm/mali-dp: Implement plane alpha and pixel blend on malidp
Date:   Tue, 14 Aug 2018 19:32:57 +0800
Message-Id: <1534246377-31346-3-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534246377-31346-1-git-send-email-lowry.li@arm.com>
References: <1534246377-31346-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR0302CA0016.apcprd03.prod.outlook.com
 (2603:1096:3:2::26) To VI1PR08MB3533.eurprd08.prod.outlook.com
 (2603:10a6:803:84::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fab10f3-394d-4554-6a02-08d601d9c27e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3533;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3533;3:Zv20y0gJYnvEo9whPJ2yfuIGiWNTGqDagJqCwGf3HOl6KI8TFEOf9e0a+ElLFq4mWx2zoXgkJYXSE8Un4uEbZsW/71jcjFASLcOyRLWpI3fW+gJ4nKCB3FMpJiC60kTjn/R3ZZ/YmxYenY016Uw4jVPVDKN7UpQXeuBuZZocduaoRsxTrkWDiFdAhqV71YnGF7ME57vWGecMhg9SVxLzcNSuvTXZA8AcdBOu/poOaWT0StuX/AKABOAyrrzd+5gd;25:xaPSRR3QXTbrB6u4hRZjXKzpgJFGGJBCC7Nvcf7XZCtCI0h9ChiYxmGgoI23711NpiqszIh5yUWiVLpc2u/WcH6FcTYGy6K/6kAZ+doJx9ocBC7c2WLHl1Ms+W/7tvEvMniL5pDzCkp92x0fNav3VE8IT7ZD5Btmrhx6iMk4qUq6CnXQqeGJIkD6edsEC9pRKQu6vLCwZPymKDk25T+kCUVFYSMkxPdo/8VeDJr+uWUol0MI3JUumu/15RQ2vtTD/Z6Qe/zuNpuQPVVVOdMPdZmo35LwQeaDOxsp4nukIZxvRBA9qpYw/sT2f0OODKX6aeKpCSLdIZR3B/+N9gU28w==;31:YMi+YP+2Mvd+ES63UM0ObK7ylCSCtj7CPQ7GpgdIT37KtCjGZQ+GlUdRSEwj2xaS5YV2/xnw7x8qoTT2vMauZ6rykn1sJ/uIrGOUAAgrFk6h3prQ/dvhRnjnQzlFYWlTyHqrppu06TRmBwB7qCn2W6Q7iHfQD6smQtDWHw43Dz3ixYzUHDr9MiTmNYFMp+T/nEk9uRzaAWiKjRUDlBI0Qrwxyy/Qz6KvYK+t9lQa9ew=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3533:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3533;20:3jhJpxxq+yGQRJ9MVyCUs2nEKmPjJSBy/hLBblyEDN6Ud0bDJvG8Kr681sWN1tRKj19/3PrTsbK1vUEycPfbgy7lSkA5eXQ6V9RTHZkFhoWNOMu10sa8b1iI3RFruqDd2lOWmfQSb3mvdgLAxyivQ5TMTcGUQ8fh0a8sdlXBJQ5mQaW5aoiwZuY8vsZtZOjZppQlNOOr7/4Y0XvhLgPGDR3YdHzwweicgYkFLtZVkl88qXMmzLQevlcMtjq+q6bd1Za2PKSXVL8soOw4gZiVOMRVNp94fZm09wzntms8Vi7EQ4WM0tYBpohYhyjpvfo3U0Y+BQzfYAkzO+YPYAmL7w==;4:Atlj8hGtUWd41HrkCCjVFq7oobc6tP3/mOo8H7O/RjJ+n7UGsdnZSs65JCYPd8tnf2ewDhchLNPnAFnDiaQCs6+Y8nnGarEUj9lARvLTXdglEvHLRbt6OYXn4t87LABSxl5hevdhewNKH+tDyCuzbB+3Q8BmyVrn8kYUicgQbLrSkNmDLM8kDWMbq0PcQ1Ij6pphyOW04ZuIUN+lhCvXhhY+Nga9fJY/tsq+VQ8L8S3JImbz2goV/o99QnClHcsJ+wUviyTmi2KlWXLgtj2rBm8QfPUH8zRHxOe+e0rdnBPmommrGqlm+7k6kOe8BI8m
X-Microsoft-Antispam-PRVS: <VI1PR08MB353341D41925CF5456B4DD139F380@VI1PR08MB3533.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3533;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3533;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(8676002)(6486002)(25786009)(386003)(68736007)(2351001)(2361001)(2906002)(36756003)(316002)(53936002)(34206002)(39060400002)(50226002)(8936002)(44832011)(16526019)(81156014)(6636002)(81166006)(4326008)(6666003)(105586002)(106356001)(26005)(7696005)(51416003)(446003)(5660300001)(76176011)(52116002)(305945005)(7736002)(11346002)(476003)(66066001)(45080400002)(3846002)(37006003)(956004)(16586007)(486006)(14444005)(5024004)(478600001)(72206003)(6116002)(97736004)(50466002)(47776003)(2616005)(86362001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3533;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3533;23:GApA5PqmCxDrOj5ytDvG+9CC9i/sSjXe9bzWwNAzZ?=
 =?us-ascii?Q?pPcrw4NTvC/C1mtyNyKRCnGtXCERuZCL5bmsB7fhzIA3gQdtmpA5BxOIZWdA?=
 =?us-ascii?Q?sc+qr81PCcVF01eyOtoiqoapY0jLO21qdh8WnZbkyebqZu805cf2B3DLdYRU?=
 =?us-ascii?Q?mR3q5aQUP+q06tXL1sqpkGvL4JtNWxUO45XVlvXp+qYm+1hbe3my1PxFnJ6t?=
 =?us-ascii?Q?ifLzn9nfM0gQvc58Smpjio2N+MUgpxvlW6DLpWfa+fZMzeql6nO+qmqGropQ?=
 =?us-ascii?Q?1OxUVRrRqEb9skcNRnCQgKEhB3O65yQxgRdCK3I07Qj3FRRhPhCprKWIxQFn?=
 =?us-ascii?Q?5dDjETeMPppOoj7jelgafR5HI40GcCq1tY00wgUB2TPAM7w+EYAt0oPgGjYe?=
 =?us-ascii?Q?evs2I+4UEGcf/LqWQBBpcYIH7q8tuvEqkSiZTXj4JoBzXWOEaaTsWJcshPlI?=
 =?us-ascii?Q?ShMyrAzWErThd384pb7l+fHOKDgH8WNaEBNvBEcsxJ+yE+9pPC0ZbW09Fori?=
 =?us-ascii?Q?2R5vRW0EXkzelITWnOFJPNXTLq3t3oUNiJ8lsDJ8s6Dvg2QfQpKKtRUiG7xZ?=
 =?us-ascii?Q?93NvEKGBzxIY0+rM5kKjQyqwSNzRndWtm1RnMUgOfPD63Yrd7nWskX/irru1?=
 =?us-ascii?Q?eGu/TkulhLx/moiU3sASVCc7ZLyrARD31XR+vswIMjnS+H4py09xp8jXj+Pu?=
 =?us-ascii?Q?NmDR2RUBwNB6R/W6YnS/D8kxYBfnS0RfCd0Q1n9z1+VxeTBIREgFrRDC4kRy?=
 =?us-ascii?Q?lVD9RY/Agy926YwtV2F7dSgrap1PXgwEnNNHSrupBV97mWYF+i9q6cei1RPU?=
 =?us-ascii?Q?7HFUw6ZLB11FvkpxDSEItz1dr69DU6+B6I9lo8Amn4dd4eIy1NSeZabUKSy0?=
 =?us-ascii?Q?Q16+MxRuB+/5TW9TdVexpr7hQLlGhDSR8MHjDcKyg1Lfcw81H0I6ITpycPlE?=
 =?us-ascii?Q?roP8HwHIctIG2WCjdIn7tK/ifxJAbonVRWHFBjKnoXibXmfqITc3aCGKdVYg?=
 =?us-ascii?Q?mMmi3hvy29l3ILtQMp7VrvO7i16/nj5oYqs+Zh1S1kMCj4jM8qWJCFxycooW?=
 =?us-ascii?Q?c8x5dByGo/yg43Z7PAnp0PB5fNpcQ15mSrWDMqDQxej7phMH1NvqXRK/PrQW?=
 =?us-ascii?Q?zpiXfqYh5zaIe8F5oVEEnVnoAY5USEd7GwqnXl9LAybYLPmBDVmGuTNboANl?=
 =?us-ascii?Q?U72ARsWnTDcI7sHXjOmLwmvm3qoNEi3bkN2szZ+Qgjpg+y663BuvzmU/ynWl?=
 =?us-ascii?Q?5+McZuUDZjxqR1ZB+ytUOeesZ8KHQD9ZqDBriSKyPFyk6ztQBp/q9TszD7Cy?=
 =?us-ascii?Q?I2E1QsKjm6H2WJj0xInttqMX5kvzRdhxlyvQGEcc4UWDmWNc7EDA5s2XLGDG?=
 =?us-ascii?Q?Ylfog=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5Zd7d+a953cg7/y8qvTKCkjAmdE0wugl5ggbxspcFSE1e2kFzDcnG6+193Ozuharp5CmlBtbnFBaw8f0WqizcFf/hjuNf/mZvCPr9wRU01fkvK8NhkD200zknP+ud9aGkrTLyRrHbGOh+0si71KpQ9NlbSewdsWuvgmCANxIPNaO66tQZxcFGzaiqnfJC47lnMD89HJVW/lSRs2NRlhz7fUhGZsOUlOnWzykxNLhnPTOobEwEkRJZs1Dg252SmkbtvL5BedXaNUbk2m3/lQK5Lm+fsb+sUe7O1BQtS9VfNsgQilYKXEtx0c9gZBU/fU0jdKi9R10ZQeiKdOToOrHmFcQ5Dg/RmObd98zLhADrDM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3533;6:tnszzjUZ2ZI31TDFi4Q+F4hC0tX1GAOoOE1xHooLeA+kj6AY5loCgArL0ijL9Ui/akHEppVJWRO87aAX8vNXHguSepg76O62rGsW8PZDWl9FEtQOEnw6JxXYLDIQpOWeUVqUUkolPDfxahCui1X/Uo6fNJcH3nVq2o/YIyHnnXj0yETzSMEqqrLDF4AJAeUoTcqjjndNUGXvO6gGkEr4PYSHt48ZaiPcKqNNh2BIYTXo00HH/8UuC1E28W6PmfcMEjsdxzkBbzZ4WBHk31fSzEV4OnhueBD6Lx3ZQO6q22Gad9ajr2BJkw/GHx3TQ8T/rixKSp1GpOqDGvt9VV3BdfpAhv9s1v6bSNtcipvd1txDgVSOY3GqTM5nRNC1nKKBuMuWZszulVK0d3s901/OGjosuyzVKmGrpy8/bX0umFRSMIwCcyc4e79HNfxMXIUFKHZgpP8OSWRdia7aAx8hMA==;5:DmvNKlGex9HvavlVS5fTWwk6uBWq/BpKlI6aVsUW0IgiLOjCFedqmWDSKUPICxc+uVS5ikyPch5s0cU1AihS9nWh8KqJavgxFagJydInrkSlwCuiz2gAPK5hu+fJqczRkEwXPz9vfGYsGT5mSUR1oWj7ZNhhAvGpmezdCU68jXw=;7:sQ/PqepeNJ0h4lxh1s6iml6DlP4qbEJiPWOr/oomFwTpYGlsEVDc4N4hSN+t8bywRcRv7zIAszFpSvAb/aJ9y7k5Qj9e4N65ACSED8zNBVRJpvzaUviu4n+JtIzs1iWzrAWd8ihGwAiyvIVEE5fQK1XAECO09SEC/8JsTgZJbOzYo9wsCPTM3gBQtAcxtzTwnizGdSVN/gRHPHd5dugvn+jkPDj2NLtGUeLkIcyMeaa/I1ad9fvnLaMUdZT3TKPx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 11:33:25.9754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fab10f3-394d-4554-6a02-08d601d9c27e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checks the pixel blending mode and plane alpha value when
do the plane_check. Mali DP supports blending the current plane
with the background either based on the pixel alpha blending
mode or by using the layer's alpha value, but not both at the
same time. If both case, plane_check will return failed.

Sets the HW when doing plane_update accordingly. If plane alpha
is the 0xffff, set the pixel blending bits accordingly. If not
we'd set ALPHA bit as zero and layer alpha value.

Signed-off-by: Lowry Li <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 74 +++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 49c37f6..17be123 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -36,6 +36,7 @@
 #define   LAYER_COMP_MASK		(0x3 << 12)
 #define   LAYER_COMP_PIXEL		(0x3 << 12)
 #define   LAYER_COMP_PLANE		(0x2 << 12)
+#define   LAYER_PMUL_ENABLE		(0x1 << 14)
 #define   LAYER_ALPHA_OFFSET		(16)
 #define   LAYER_ALPHA_MASK		(0xff)
 #define   LAYER_ALPHA(x)		(((x) & LAYER_ALPHA_MASK) << LAYER_ALPHA_OFFSET)
@@ -180,6 +181,7 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 	struct malidp_plane_state *ms = to_malidp_plane_state(state);
 	bool rotated = state->rotation & MALIDP_ROTATED_MASK;
 	struct drm_framebuffer *fb;
+	u16 pixel_alpha = state->pixel_blend_mode;
 	int i, ret;
 
 	if (!state->crtc || !state->fb)
@@ -242,6 +244,11 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 		ms->rotmem_size = val;
 	}
 
+	/* HW can't support plane + pixel blending */
+	if ((state->alpha != DRM_BLEND_ALPHA_OPAQUE) &&
+	    (pixel_alpha != DRM_MODE_BLEND_PIXEL_NONE))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -323,17 +330,19 @@ static void malidp_de_plane_update(struct drm_plane *plane,
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
 
 	val = malidp_hw_read(mp->hwdev, mp->layer->base);
 	val = (val & ~LAYER_FORMAT_MASK) | ms->format;
@@ -342,14 +351,14 @@ static void malidp_de_plane_update(struct drm_plane *plane,
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
+	val &= ~(LAYER_COMP_MASK | LAYER_PMUL_ENABLE | LAYER_ALPHA(0xff));
 
-		/*
-		 * do not enable pixel alpha blending as the color channel
-		 * does not have any alpha information
-		 */
+	if (state->alpha != DRM_BLEND_ALPHA_OPAQUE) {
 		val |= LAYER_COMP_PLANE;
-
-		/* Set layer alpha coefficient to 0xff ie fully opaque */
-		val |= LAYER_ALPHA(0xff);
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
 	}
+	val |= LAYER_ALPHA(plane_alpha);
 
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

