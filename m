Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA69BC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DA12147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="A5SqksBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DA12147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbeHWL7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:59:39 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:31903
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731339AbeHWL7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2awzDQYsUvWaoqslURtKKQI9k6v7xuxm8PHm4tu0KjY=;
 b=A5SqksBX/RJsjql7DT88pA7wDky1pekBF/NyUXbU3YzuZ2rAUHU07E7DfF+YcfeKo6zAtfMJfljQluSea/lMjRTq3LG3YgknFGQZI5RZbQKV/zoNGD4+5hNsP1+sIAtqimJfIlWNbLK5xwosbAyMej9Iwyh3ISa8hurpgF7V+v8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 DB7PR08MB3530.eurprd08.prod.outlook.com (2603:10a6:10:49::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 23 Aug 2018 08:30:55 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v5 1/2] drm: Add per-plane pixel blend mode property
Date:   Thu, 23 Aug 2018 16:30:19 +0800
Message-Id: <1535013020-23737-2-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535013020-23737-1-git-send-email-lowry.li@arm.com>
References: <1535013020-23737-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR06CA0129.apcprd06.prod.outlook.com
 (2603:1096:1:1d::31) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8739b130-8255-4b85-0f5e-08d608d2c206
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3530;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3530;3:BeeFYZ5k1Wwz0At1WFNONJ+C23bc7cWXMf8RQGwsTj0fRpp6u2jbb8OPG43f0uyCIxIeRHsNENXKwdrqWC4fzCVaXmC8MIsrJ5zqozKlprEParnkIXmHYb25Yq7BrjI1OXEzZYCdK1QQfSCwkMPf+kk/tdgLfX7zq89HSGs8Cig7RF8beZAif1JfwxuDGd+x40RIRnCj16K/jS/ROnC6JMJOKtsThkdi6d3zBEbmkSsYGt44fnJwHlhi5td3NRVg;25:w50Ha7ITFGr5lqzBOYGZOvduW7WsLrio3Kl1CAIYaz9H5cCE1jeSVrIYVcUAIwtrn/JAe8VUdG3xykmRKtglJF8kZIfzBP/366rUPSImNP1as+Q4e1xAvfaRNDJFYlBfWS4l9FtU0dgdD2ikfemAg+Yj2ZU1e2zeqfjOOtolA3+lw0rKFIK+u5ZUrJJJtR5WI7cxK/y7FkLs5Iilwhrf9aFqGECV55/tsMpyI88b0qVWVitjNCl5FGqhYDk7sPqb1x6yHzSc5ya561aGGwFxTeDUetq3tnLceQ649YTy+h48x4w06tN5nwajFAczKomAgWT+m2nSEKGcMcDyytsPhg==;31:Z519yn8wZaUiiAssnmo1gdaOCCXEaB9iRbc9lqCtnYDNCL3cMMXYydDNcfBkDuJRBSAcnRcz0gIHHqscutYyCVByu2A+e4iiE2aXiGJ/igJdBgSuyqLoXpexGwpYvworsXm1hxQLlf+o2U16gYrGCAZnhyNjDFvQrJ4o/kN/ZUrIhBHyC2WDWWjW7OPnvAybyGKHddrTall+0vJ9dmE49l6Hcm1uVCidzu9Wk0r1u8E=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3530:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3530;20:5AJOA//hfcout3gBzcU0JkUDPU3FFgCioE77HpT2cHqSZd7fjGJYP4WzL89blbZz/Z0FZLre+EBKRPCYaft0sBY9y6cjvPLphQJghHT13aF+eyKS/mrt/wlhNT0lgSg969jZLyyHm+7KlLPh2zkifBCJsElC2X1U/s4XK9HMPGBnakKvKYGuQu5hdvOqzOo0jyteDcx2ez/4zCJVdP3Q5ISPrc7EugDErlB1PH8VyoqBSH9N0pBtbvVazTsPL+5YMzGCODFBlBWTC12Z6APWuDABHZ51y+8OmYlE0ipTcs+kI68PBFYGNW08NF3uEhokKj7gBEXFsPCxHFMkNQRc3g==;4:BOHuWsDRyEvicNmR/Rvk0WXbMU9Fq7zLiRHy4f4EbDngc7iE7h1ll2VAFNhRsTzxHhzMSCzhReexenqd9K1fgV1NC/7rfEE2DFU/4Iv9UOo7SS8xhkvDsM3lvViRI4MkI4G0z+dAPtyxrbU3syQ16zmSLw1Epg71vCK/HGn6+BLzs/MvCFAruxa2cxaETdSOS8WrDMw6tb86L9vZYTh7B/w8CH6SubTY8naXt6boIk8SQfKCsb1Pwtovk5/UPUJJr6qpyXnjqgcylt4Otfon+enZ4y/2eOQtcInXH7+ycx5mXBm1TdNCYsXZ1IcrypdK
X-Microsoft-Antispam-PRVS: <DB7PR08MB3530C1CD34A924874A2BD0F59F370@DB7PR08MB3530.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR08MB3530;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3530;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(305945005)(16586007)(476003)(37006003)(8936002)(106356001)(5024004)(5660300001)(446003)(50226002)(2616005)(25786009)(956004)(72206003)(11346002)(39060400002)(81166006)(36756003)(2351001)(4326008)(8676002)(48376002)(6486002)(34206002)(81156014)(486006)(105586002)(316002)(7736002)(76176011)(51416003)(52116002)(2361001)(7696005)(53936002)(97736004)(16526019)(386003)(26005)(44832011)(68736007)(2906002)(6116002)(6666003)(6636002)(478600001)(86362001)(66066001)(3846002)(47776003)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3530;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3530;23:1mqqAe3sXVlzVqPMgPpOI6bjUYNTyb88tB6bkBtoz?=
 =?us-ascii?Q?E7wcUtKQSndZsc4qf+4Ymg1+z/64AxQUJbVvwfHS4WV8EHWP9SeO/KgZ8NAc?=
 =?us-ascii?Q?DLXzEhGkubO8iBywxErobC7fp/zlUvWgpgt7pwSUVScXVEdLNMeW71UxqME8?=
 =?us-ascii?Q?xgmOdqOd/i7B096c6Qv9o7WeTyYnP/z09NnMRZU+fbceqwFcPLCcWERATFig?=
 =?us-ascii?Q?ogl9H3DccVuWnCih+KGryN7yj6ayz+JJDbE2CH9As8K/CwwuOucD9uBOPRW8?=
 =?us-ascii?Q?6+g427hEPEkHRFNNEY5UtPikR1AOi8pF7b4PVOhQ9G5PtQ0sGbfNIplOkKMr?=
 =?us-ascii?Q?5d82K4JLLynRFitfAjqw7B1/+0onHvVUFFh9U8zhFbIWldAKe1TJydNd7znM?=
 =?us-ascii?Q?u9u9OVvAavOxVZfInexGzJEmO/xjpADx/JCmmTpDCQA2+acqh8bZhZPpNuDQ?=
 =?us-ascii?Q?wxDy/8aNEmj7AMUDr4wdF8p21jqZsOfA5JqQK2fsbfCSaLPimRKBWn5Y1UiK?=
 =?us-ascii?Q?WvzwDc0sO2lbMt2XuQA3hkU22LpEFd2NH/T55oi/svAdZiaNGxfBk8ky3Rc2?=
 =?us-ascii?Q?wf/i144kccnmoQhUNbXlhKdBJjYjSQbvHtGnocmCa17T7k2QwAmap+4vfToK?=
 =?us-ascii?Q?l4wHNpWzJ/eDWBZ5AxKer+Mq7Z3A4GerWYpO9yqtBBrYxTLjxdPX0ErRQ2n6?=
 =?us-ascii?Q?tlI6OcwKFcFMJWkvpWX+YLFwc75JY1KgnJB0uAD9tnwQ8tFyPfIAvsB6/kDZ?=
 =?us-ascii?Q?e7xmhGOneronCEENY9nSpluPMYuLiFZO2JMPHeFoOjR6yHB/f67ML/Jqfkd+?=
 =?us-ascii?Q?2efzsSBkB+U/aYIslBplfBfpMC08If/M5UkinClFZOyylSdpI65c+qanX9My?=
 =?us-ascii?Q?1PqcKCM6gvLRR1mirBlp4L/Z3eWdZynnCAJXADs2j+yjkATtsndUKW0dneRf?=
 =?us-ascii?Q?9SuWVs290cUW1Jcs8fOq0xS57Y74sooLi4qsQNyoSF4aPojSrmIDthr/z8qX?=
 =?us-ascii?Q?ruKnIW6tzHBs+CFfQZBsNo7l40u9LCk4eRD1brpY8XdgUJvc+P42eoRl+ZgU?=
 =?us-ascii?Q?J5AxHxT0pJbwlCYwVAk4jnL6CS0pz6b0RCbxOvaTvNo6y00rgNMvRXvoB2Pf?=
 =?us-ascii?Q?wELGFH0zAW1cahLhkFdLw31n+5AIn32cP1PQHEZ6udBbA8B5wZYy14RRj+Di?=
 =?us-ascii?Q?nN1ja6a52h5pqBycXgZyBBOER+c2xcCiAJ4ChZ2TrHK82/YVUftQIIYRFs6T?=
 =?us-ascii?Q?XPJoT3yqJIzAvIT7W/OEoHkMdwcfA+Yeeyv/qFEC1ZlL867yLFz4neWxM1yM?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: +2DEFSilw+My10+rXpuYG/3pB0F1ygO+PytnOxwHlV0J0zp7+UI/OWA42SlDxYr2UqhTI7Wl1i2gmVm+FkjEYN5YkRGRPXL3kGAkdKJYk4krAxJ6kSV2dRj23tNTj12ayLOVlBvESmV2E2M2GorN6qECrNIuET48DeOEpof7/eodoBe+sNV7B1mX2MhdZPRzv4iXpeoBnU1PTFuVjZTGh+cm+x2QeXyl2KKdlU1u8IIdcBGAwntcHt38nXT2N3nybXH7cpZ2G3DAHk68UEB06KqmnbfvNVk48TRGqS9QoqDKy9BGUACJDRnDHe+7yLyaDghgBVKxLHuxrnYxmGtE5/bVCxcP4O5OnIUS/Vo7DDU=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3530;6:+3K+tsors4CFSoYjdIFULpMg8oKD1W3X8EuFdRNFsGg18Yva1yZUld1oejnJ50hvl63cZy9ehla4nPZgwdHqb2iO5RfVDxC/19LcXwosaof/8n2LxxYdZmzbtKEYxmK/GnZtMB2nEe4KkKgSddEYPJdrBoua3hZEWYmzTyAQxgftWI2aeSeWi7cKvdfx5uDRk787BlDkSS4dNCQTgW5QHsyHFj+QJaW1taP2g7rIWrlcOUXMZTeuF5tWuVHcNHRChyAAFkeD/k3b0D/xsfluGMzv3VLY22NeAUwZWT8N2XilvibwpShB0mmOZ0LZQFOEOIA+T86GXw3OObWRPUt1+bv/YVzLA/TTDPBQZzaFP2mtHvY4OSOB6Fw/nbaP0+JRd4qScbqPYlraxPoJbtKtTmUtl30l6101J6euAxb8kTm+3VEP5NzzqDPTeodOqMDgKkXceelbhR/uNiOl0vY5MA==;5:aEnWYb5RXkIRwjXpeSqRGBP/CEtkriNv/yqUBv1Dea+5v2AWO+RK4sMi/h+2NrCcCz3yEZkX8g4vPktYBXFwo1PLNRFF93N5FgZBX0RlrfIL8+YdbTSQrHQuyxDc41KClnWbW7lCpZsafGh7ghAEiV7/agq7WCR78T7KM8x0Fm4=;7:OqOwYiTy+ZqO2HFdK01q9dtGczSfA8msPyZspGnc6No+TuTq5I/aLX2VYCk+sXyt+++3qATilxatulxvKK3zw3apMetMd/09nndP+HeV3OoC5RKX5rM1rrODOU++SJHRdsKG6qVq8/R0qD1Anw348sYyCekMIQhQyp7CqncT60pq1XyuYhPrdc2JuVD51WiG9baEZhQl965rcdyblP/7qc/3xl483xGLF7HHdWC1BE9rPd4BjvGfTPmS/+pf0n+S
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 08:30:55.9479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8739b130-8255-4b85-0f5e-08d608d2c206
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pixel blend modes represent the alpha blending equation
selection, describing how the pixels from the current
plane are composited with the background.

Adds a pixel_blend_mode to drm_plane_state and a
blend_mode_property to drm_plane, and related support
functions.

Defines three blend modes in drm_blend.h.

Changes since v1:
 - Moves the blending equation into the DOC comment
 - Refines the comments of drm_plane_create_blend_mode_property to not
   enumerate the #defines, but instead the string values
 - Uses fg.* instead of pixel.* and plane_alpha instead of plane.alpha
Changes since v2:
 - Refines the comments of drm_plane_create_blend_mode_property:
      1) Puts the descriptions (after the ":") on a new line
      2) Adds explaining why @supported_modes need PREMUL as default
Changes since v3:
 - Refines drm_plane_create_blend_mode_property(). drm_property_add_enum()
   can calculate the index itself just fine, so no point in having the
   caller pass it in.
 - Since the current DRM assumption is that alpha is premultiplied
   as default, define DRM_MODE_BLEND_PREMULTI as 0 will be better.
 - Refines some comments.
Changes since v4:
 - Adds comments in drm_blend.h.
 - Removes setting default value in drm_plane_create_blend_mode_property()
   as it is already in __drm_atomic_helper_plane_reset().
 - Fixes to use state->pixel_blend_mode instead of using
   plane->state->pixel_blend_mode in reset function.
 - Rebases on drm-misc-next.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Lowry Li <lowry.li@arm.com>
---
 drivers/gpu/drm/drm_atomic.c        |   4 ++
 drivers/gpu/drm/drm_atomic_helper.c |   1 +
 drivers/gpu/drm/drm_blend.c         | 123 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |   6 ++
 include/drm/drm_plane.h             |   9 +++
 5 files changed, 143 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 3eb061e..d0478ab 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -895,6 +895,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		state->src_h = val;
 	} else if (property == plane->alpha_property) {
 		state->alpha = val;
+	} else if (property == plane->blend_mode_property) {
+		state->pixel_blend_mode = val;
 	} else if (property == plane->rotation_property) {
 		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK)) {
 			DRM_DEBUG_ATOMIC("[PLANE:%d:%s] bad rotation bitmask: 0x%llx\n",
@@ -968,6 +970,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		*val = state->src_h;
 	} else if (property == plane->alpha_property) {
 		*val = state->alpha;
+	} else if (property == plane->blend_mode_property) {
+		*val = state->pixel_blend_mode;
 	} else if (property == plane->rotation_property) {
 		*val = state->rotation;
 	} else if (property == plane->zpos_property) {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 6dd5036..284a5d2 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3569,6 +3569,7 @@ void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
 	/* Reset the alpha value to fully opaque if it matters */
 	if (plane->alpha_property)
 		state->alpha = plane->alpha_property->values[1];
+	state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
 
 	plane->state = state;
 }
diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index a16a74d..402b62d 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -107,6 +107,52 @@
  *	planes. Without this property the primary plane is always below the cursor
  *	plane, and ordering between all other planes is undefined.
  *
+ * pixel blend mode:
+ *	Pixel blend mode is set up with drm_plane_create_blend_mode_property().
+ *	It adds a blend mode for alpha blending equation selection, describing
+ *	how the pixels from the current plane are composited with the
+ *	background.
+ *
+ *	 Three alpha blending equations are defined:
+ *
+ *	 "None":
+ *		 Blend formula that ignores the pixel alpha::
+ *
+ *			 out.rgb = plane_alpha * fg.rgb +
+ *				 (1 - plane_alpha) * bg.rgb
+ *
+ *	 "Pre-multiplied":
+ *		 Blend formula that assumes the pixel color values
+ *		 have been already pre-multiplied with the alpha
+ *		 channel values::
+ *
+ *			 out.rgb = plane_alpha * fg.rgb +
+ *				 (1 - (plane_alpha * fg.alpha)) * bg.rgb
+ *
+ *	 "Coverage":
+ *		 Blend formula that assumes the pixel color values have not
+ *		 been pre-multiplied and will do so when blending them to the
+ *		 background color values::
+ *
+ *			 out.rgb = plane_alpha * fg.alpha * fg.rgb +
+ *				 (1 - (plane_alpha * fg.alpha)) * bg.rgb
+ *
+ *	 Using the following symbols:
+ *
+ *	 "fg.rgb":
+ *		 Each of the RGB component values from the plane's pixel
+ *	 "fg.alpha":
+ *		 Alpha component value from the plane's pixel. If the plane's
+ *		 pixel format has no alpha component, then this is assumed to be
+ *		 1.0. In these cases, this property has no effect, as all three
+ *		 equations become equivalent.
+ *	 "bg.rgb":
+ *		 Each of the RGB component values from the background
+ *	 "plane_alpha":
+ *		 Plane alpha value set by the plane "alpha" property. If the
+ *		 plane does not expose the "alpha" property, then this is
+ *		 assumed to be 1.0
+ *
  * Note that all the property extensions described here apply either to the
  * plane or the CRTC (e.g. for the background color, which currently is not
  * exposed and assumed to be black).
@@ -448,3 +494,80 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
 	return 0;
 }
 EXPORT_SYMBOL(drm_atomic_normalize_zpos);
+
+/**
+ * drm_plane_create_blend_mode_property - create a new blend mode property
+ * @plane: drm plane
+ * @supported_modes: bitmask of supported modes, must include
+ *		     BIT(DRM_MODE_BLEND_PREMULTI). Current DRM assumption is
+ *		     that alpha is premultiplied, and old userspace can break if
+ *		     the property defaults to anything else.
+ *
+ * This creates a new property describing the blend mode.
+ *
+ * The property exposed to userspace is an enumeration property (see
+ * drm_property_create_enum()) called "pixel blend mode" and has the
+ * following enumeration values:
+ *
+ * "None":
+ *	Blend formula that ignores the pixel alpha.
+ *
+ * "Pre-multiplied":
+ *	Blend formula that assumes the pixel color values have been already
+ *	pre-multiplied with the alpha channel values.
+ *
+ * "Coverage":
+ *	Blend formula that assumes the pixel color values have not been
+ *	pre-multiplied and will do so when blending them to the background color
+ *	values.
+ *
+ * RETURNS:
+ * Zero for success or -errno
+ */
+int drm_plane_create_blend_mode_property(struct drm_plane *plane,
+					 unsigned int supported_modes)
+{
+	struct drm_device *dev = plane->dev;
+	struct drm_property *prop;
+	static const struct drm_prop_enum_list props[] = {
+		{ DRM_MODE_BLEND_PIXEL_NONE, "None" },
+		{ DRM_MODE_BLEND_PREMULTI, "Pre-multiplied" },
+		{ DRM_MODE_BLEND_COVERAGE, "Coverage" },
+	};
+	unsigned int valid_mode_mask = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+				       BIT(DRM_MODE_BLEND_PREMULTI)   |
+				       BIT(DRM_MODE_BLEND_COVERAGE);
+	int i;
+
+	if (WARN_ON((supported_modes & ~valid_mode_mask) ||
+		    ((supported_modes & BIT(DRM_MODE_BLEND_PREMULTI)) == 0)))
+		return -EINVAL;
+
+	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM,
+				   "pixel blend mode",
+				   hweight32(supported_modes));
+	if (!prop)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(props); i++) {
+		int ret;
+
+		if (!(BIT(props[i].type) & supported_modes))
+			continue;
+
+		ret = drm_property_add_enum(prop, props[i].type,
+					    props[i].name);
+
+		if (ret) {
+			drm_property_destroy(dev, prop);
+
+			return ret;
+		}
+	}
+
+	drm_object_attach_property(&plane->base, prop, DRM_MODE_BLEND_PREMULTI);
+	plane->blend_mode_property = prop;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_create_blend_mode_property);
diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
index 330c561..88bdfec 100644
--- a/include/drm/drm_blend.h
+++ b/include/drm/drm_blend.h
@@ -27,6 +27,10 @@
 #include <linux/ctype.h>
 #include <drm/drm_mode.h>
 
+#define DRM_MODE_BLEND_PREMULTI		0
+#define DRM_MODE_BLEND_COVERAGE		1
+#define DRM_MODE_BLEND_PIXEL_NONE	2
+
 struct drm_device;
 struct drm_atomic_state;
 struct drm_plane;
@@ -52,4 +56,6 @@ int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
 					     unsigned int zpos);
 int drm_atomic_normalize_zpos(struct drm_device *dev,
 			      struct drm_atomic_state *state);
+int drm_plane_create_blend_mode_property(struct drm_plane *plane,
+					 unsigned int supported_modes);
 #endif
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 8a152dc..35ef64a 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -117,6 +117,7 @@ struct drm_plane_state {
 	 * details.
 	 */
 	u16 alpha;
+	uint16_t pixel_blend_mode;
 
 	/**
 	 * @rotation:
@@ -659,6 +660,14 @@ struct drm_plane {
 	 * drm_plane_create_rotation_property().
 	 */
 	struct drm_property *rotation_property;
+	/**
+	 * @blend_mode_property:
+	 * Optional "pixel blend mode" enum property for this plane.
+	 * Blend mode property represents the alpha blending equation selection,
+	 * describing how the pixels from the current plane are composited with
+	 * the background.
+	 */
+	struct drm_property *blend_mode_property;
 
 	/**
 	 * @color_encoding_property:
-- 
1.9.1

