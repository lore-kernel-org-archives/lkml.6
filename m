Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A85AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B968621778
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cmZMa6/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B968621778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeHNOUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:20:15 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:10365
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730759AbeHNOUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M4blUFqeONqtFi0iN8jj2IxIavQ59fDnQd7XxJe570=;
 b=cmZMa6/0z1cQAi8/n43p3ZL9ceJzKb0tFEI/EDqHZ/xMM5bv3CUTh7OgEO0N+MpJHWcJPjIAgHSpqSnVsr7771OedlntK0bZGhDklHhKwVTDBir3Fgx5nyj1k2U6EdA8zo3oKtUvR8octOMWNkd8HFUxbPA2VdY4YsAOgYbpsPY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 VI1PR08MB3533.eurprd08.prod.outlook.com (2603:10a6:803:84::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.22; Tue, 14 Aug 2018 11:33:21 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v4 1/2] drm: Add per-plane pixel blend mode property
Date:   Tue, 14 Aug 2018 19:32:56 +0800
Message-Id: <1534246377-31346-2-git-send-email-lowry.li@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48e41f7a-dcd0-461a-875b-08d601d9bf96
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3533;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3533;3:iZUvD1X/MUy6Mt1BERv9+WV3qwp0zNH8M/FiWAsNjE+ddJGecdYMhc3DAEb+ONZJSf380jHsYf7/mJyJigwVVcvaSuWjDLSSssEMovNkVWpl1ptQQwEHc4QDhqBEeB11fTpd1JW+vXrAZyqCt9dWxSh0LIGeVzdLXqOVYXWg4LliOj246AxjhtPNSNlWz8Z9etS6g9V7GgObjrWnq6Z2ZYpk5sA8L1TJ1WwGjfHq5l3yo1bNmneEFnR2X4aoRK9l;25:9kaic7lnZmlZ6yKT3Hf96oDxrxrxUOYlHWSpW4xXQCnNijBh3MgGcE1zJ8aovaRcLuQWYBhr03rqUZo8fGoT0rgmgbBAt3LQgNmKVSuOSDV65N097kkfI4Nr/wUw7yUY8B8p+AlNDgTxJ41idFHFo0quNEdp1e/C8g2KKVDOiheRH2pgHqowfwY28e1rXoOQNE82fB/ih9F8NUPe41Tx8BJvdHymqHWAWhgaWjAnluCl58uXghB/FY4PplM9eq7tR42OQrlzstGX2248eZGJM9pUNEMFMdls+7w9HlKuZDnLxQWmum+LG2xubOyOyUq27IwD1xsU9zWq/T+u3zEyDA==;31:jThUgTSojje3qPYann833qH1WWTOM2Lb0XlsVpb2fvMmwa0ifSuLY+7jSgoILzQjUVcDp9yDtt7PDU0rqnGB+WcWTg5C65WOna/2AuKKe2KsjdEUbgnKNmEo8yWbNM2hoJHJpAX/4mfLBwyW63UdFn8A82qTo9K6g17Cce/qQjhd3zFijHn0GGvYi3xb/ne2dkSDYmQePM5ki9ZuHPDwuIXDQoMV99BQZbo+i44V/rk=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3533:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3533;20:gh1UIUMRXAlpXQ/10aVvK21n38xgdy4Q4mWSRmOPeXKan3KXI9ZEop2Nu6oUvsai1iNBLy/WDBXp0shBg0FMv2C75nK/Qg0XoX2/eMPeoQ60w6erwHrncIylAfhNa/Z7D0hZAF+lft0RHQgf8BPldhMf0xCkc/817YFnDNVYnc5cp29tdP9TachHos6ev9aKdUvSIJtCt2/L4Jy92NKqGReI+by5UVawY9A3RhZuFuYjyEWOVXRHoaRhJugnMfaJMfpsxMmHmTOIj1hvH3Hpb9/wI06qMTToQsCylPLa1YB690kx9N1iAlCCI7RnhdRcUq/CUjRTCYXIjZLscDSL1w==;4:tnjNIthPWSOsc8PLfyNvjku3H2s1gDhXKTlT0THN96YhjhJBToWGRwIbFzyQuQEGbvb5x1EqcUdC/0C6v4OSsR0PP3H3oI8w309iawnp8vxJnkAk+S+4QCw9BrCS03onZDAF9Wi3W+BKXHnv4NOEkF7IUwMeFOZ3ZQbUY2Fc3SYxW7C96ZNhkJnzLIDK5hRaZbJm3el+acC2bLgIGs+iEyQUpMXpOmUiUhNAaP/k7k1QeW4vsn/RKmOyuKn5X2y5OuSIHhKuGFV1wfC8oYUzbvuiWa6XVCBNn4ou+UgDoBkmaPCf9M5LqYYJWXRFuDOa
X-Microsoft-Antispam-PRVS: <VI1PR08MB3533FE2420088C3BCA9C18AE9F380@VI1PR08MB3533.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3533;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3533;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(8676002)(6486002)(25786009)(386003)(68736007)(2351001)(2361001)(2906002)(36756003)(316002)(53936002)(34206002)(39060400002)(50226002)(8936002)(44832011)(16526019)(81156014)(6636002)(81166006)(4326008)(6666003)(105586002)(106356001)(26005)(7696005)(51416003)(446003)(5660300001)(76176011)(52116002)(305945005)(7736002)(11346002)(476003)(66066001)(3846002)(37006003)(956004)(16586007)(486006)(5024004)(478600001)(72206003)(6116002)(97736004)(50466002)(47776003)(2616005)(86362001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3533;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3533;23:TcgcAn03vDZWmU2TXPP28EOC+96QnROPyHiyszscQ?=
 =?us-ascii?Q?u0IUM6XjR1iwoiYw8BpvsQkuJHAxgCDQ1ibV+bx4kTQQ+WN82DliVS7zegW7?=
 =?us-ascii?Q?ZacfP4KyTBwY0DfK395jCFU68c2H7OWuwH8fhTKPrSCWYsnKsaXPuiMy2xLy?=
 =?us-ascii?Q?c9PS6emQdvHrGZkFIhQcLWwMyU3dhYtXQIiSUIhX953GIkzJx+js81sFJm4L?=
 =?us-ascii?Q?/2k7HdjdKXTC/bCZKbG0tfID9nEhXjYNkdVu/CJ74cPruoLj048ox7/Ledy7?=
 =?us-ascii?Q?5Bq6DdF/w1A8nT+A26xYqSxeEJ6tmc+1WpyuxP3OiqoPDJDhNZBfeYKW1NeH?=
 =?us-ascii?Q?f7jEvWlb1x+HO9sdCKXs+mvSj0ZltQjbTg7cALk9SRDv2FrU/igf+mrincrR?=
 =?us-ascii?Q?cGt/vtV2ufCPT9WsU/gELTHWQigId1Ci9meiLd6459rng8c2wYjZgQyk6p0o?=
 =?us-ascii?Q?raMUjmkL9avV7pKhdgCRPGnvTO+GUIwHyl+pitqEJ1+We0xe0+OnkcGi9o53?=
 =?us-ascii?Q?vFrhKho/sIDXFGN/SxmFdI4qjrm0tMewHwHaTAg277CaYIln1pJ0PApG3w3c?=
 =?us-ascii?Q?usKjP7c85PPxSP0Yg98L4rdZxLDxOd1tBtrXVTNnfh92G1upXlzXOCgJlafL?=
 =?us-ascii?Q?qTtXoxJYt8ryktP/E8KjdEM5XW2f1dlcDtMbCjhRVZmnzSGeTihk2c5/jGRR?=
 =?us-ascii?Q?u/dtMQGOqfUoRmlKZBX1JXmfKRC/fnvcsFl6oYiIWeVkwqh4BSg3U8OurZ7L?=
 =?us-ascii?Q?/vJzdo0TXbstUxcOf7C4bDjRnbwhR41onDTleyjJlBXKGvW8w8M6NQxnu8KF?=
 =?us-ascii?Q?r1WNfZmgztZb4PPCKXuDugDT6iEoLec7RnZDO0u/dpwy2oYZvKBECcuREYsS?=
 =?us-ascii?Q?lOhFTurPiMqQUY6Wor7BZdS/dnee3B9zC/7qj+h/Q98uhV2fAFt6CuQ9YQNz?=
 =?us-ascii?Q?sPInYEH3uqEVPkMUbMYBddUna4zgQ+OQE8YGx9efyHuDINBMEIqKFFa6EHZJ?=
 =?us-ascii?Q?H9K2woiEtfVPkMq/N/EeG5XWafM92sPpK5HSZlFSMeNeqfQu6PlPU+N3SA6+?=
 =?us-ascii?Q?W6aEy2m9nOTXMum+diofyFsqyV6QZY+PEuy7RKHAzvqlx4kbTiYCG6CJ8UEG?=
 =?us-ascii?Q?PhqZ3lcKwlMGhYRmCBI4NhxNz01FY9APQdR7yCCUjPVOz4LHtGa3Eqd4wJTi?=
 =?us-ascii?Q?slJpcjUTfVdWu/vHuIroG5nGttrELUVOMJqe8G53T49urmypppt9/RANhoIg?=
 =?us-ascii?Q?9bKqUaTLQ+5xeQOjy/atJmsHNkmnhk0EL8imejGhpki9YkrPOxaIM6u5dV7L?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: IrHrAU+NODAUckAm4zaXFIBDir73gCW+Z4uJs4+mWj9eMIPCnZzO5fFnuMUFNHh1B4c1gJfwJ3JASyZMb0yUi8X2jJtdajK1qQaYbzvgYMV8NjjA1YrQuh0X5t/K1Khd/ssLNcnVlF6HnDTGZCfpJpHGGTEe9H5LGYVp85rB8acqj7oRZHtVrTwCdiojTYR19uDJ527giQIMiu4TVd3uj0Yl2qg8ZdCS8KB6lO7WZ31NPmki+ZX7sYmQ66okWXGBKxW3n0bOzOoYAqcUYx5QS82NLfWCRMkBpFr+1kORApqDrjxNe0+aZ5VlmDmL5eahfxUPiZYMuhGpk7NaRRDlXxvmlHwURvlI5r+KqfvLYSg=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3533;6:GeU3cGj6JUTYhw4Sck7peRxNAQnpO0b9bGiyIrUR7pU8OXGOZyVn4gxT9MPVdhL83q+U+zhx67AmxDq0XaEFeADs5L7NGNJ5wSvoHt+ibusp0IBcB4lL+RZTi7GojAJX5c/qSKk2dxmpWbJ6cHbmIKsVwowODPa8K8VFg6fy8Yd76D7OP5K8S86AJk+h5quIPQ0yIuR8QMc8wvcWn44HmdUdUzH6CV/l7x+uwKh4h5XlVy3orJi0itgD02zGu1K4mQNdCHXzuIf6jm0uH3iGT2Y3V3EfYx3VdHLB0s3FrG6VixigHxMYTwldPqlgtoIYnJgP+nLiSUUQBwttTWdMI52Qwc89dic7FOuOWuO3MGUmnHA7O2PaDUEfuCkmyHjckDfm2ip4qElhxywMgL+N1heXyvc0AYg+Kd5axrHykGSiGjpIPkQ9ABMtpkSLBWW1tUYrpJzRUfE7eWwKwHHQiQ==;5:oxYZp4dUUma0TQNiBybVG6/TbVIUU988r7Tnpz4mvTTLViu3C/M5JFFEw+N1g8bdNaz5dqAiZNq1hsGeqkoekEC5wd/tiBYBHMg6VDlHcCZh9S+X7pV+wjFsDgfGFfWRmHk6gDQv33bTYti9ro8q1gc8F3nYFd2+T5G3ge922Tg=;7:kAF8Bsgg+oWI1CeNQrICOpJOHVjFyaohdRFd1KrIL+gQ/A02iU2ZEc1IWNKTeydsIzCC8QiqO+xtyibsAeXNycFRZ5cufVcz+lvfKwmmzLI4Yeg+bElXmxfVZPkdk3fp6FtTHxcYNijsUGwq6tMyugZJtHbtpiO7irjhVgAgadOWKVhbqmnY028nZ+y2KvcDVtxNDnQ7pzejcYuOKpy3cBbvoeGnuQbcQOcqr5OL4Mfp7wnA11CTaQJUYl30P2uD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 11:33:21.1315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e41f7a-dcd0-461a-875b-08d601d9bf96
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3533
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

Signed-off-by: Lowry Li <lowry.li@arm.com>
---
 drivers/gpu/drm/drm_atomic.c        |   4 ++
 drivers/gpu/drm/drm_atomic_helper.c |   1 +
 drivers/gpu/drm/drm_blend.c         | 126 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |   6 ++
 include/drm/drm_plane.h             |   2 +
 5 files changed, 139 insertions(+)

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
index 6dd5036..563af09 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3569,6 +3569,7 @@ void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
 	/* Reset the alpha value to fully opaque if it matters */
 	if (plane->alpha_property)
 		state->alpha = plane->alpha_property->values[1];
+	plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
 
 	plane->state = state;
 }
diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index a16a74d..24016c9 100644
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
@@ -448,3 +494,83 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
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
+	if (plane->state)
+		plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
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
index 8a152dc..c52614a 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -117,6 +117,7 @@ struct drm_plane_state {
 	 * details.
 	 */
 	u16 alpha;
+	uint16_t pixel_blend_mode;
 
 	/**
 	 * @rotation:
@@ -659,6 +660,7 @@ struct drm_plane {
 	 * drm_plane_create_rotation_property().
 	 */
 	struct drm_property *rotation_property;
+	struct drm_property *blend_mode_property;
 
 	/**
 	 * @color_encoding_property:
-- 
1.9.1

