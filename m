Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1F4C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF00621501
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TBO/3M8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF00621501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeHOJ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:26:59 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:52512
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbeHOJ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idy34tnDjnMkRtxW0LZrJIcA5TyhBfUDu1XR9aVh99E=;
 b=TBO/3M8eQ0KyD0H3TqJXlM6i05eFYI/AMQ1Q+AhPNA6jWqfA2zs5DzCgcm/I/fzFXvWsi07nHzSmdmavMADl1L7I6p51sVkrAsXbZQE0ZkLwewVzWpxZlO4soa/W8qFBhp+xNlkxHVxtAyNd7/rBCglGycFQxhXKgJTPNefCnZY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 AM0PR08MB3523.eurprd08.prod.outlook.com (2603:10a6:208:dd::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.19; Wed, 15 Aug 2018 06:35:59 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v4 2/2] drm/mali-dp: Implement plane alpha and pixel blend on malidp
Date:   Wed, 15 Aug 2018 14:35:33 +0800
Message-Id: <1534314933-23182-3-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534314933-23182-1-git-send-email-lowry.li@arm.com>
References: <1534314933-23182-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR01CA0129.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::33) To AM0PR08MB3523.eurprd08.prod.outlook.com
 (2603:10a6:208:dd::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17f4ed8f-6cfc-48a9-a1e7-08d602795f9a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3523;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3523;3:fRcPkxxngEIBVtsWxb2zkAADyMaLjkw35wYhosmgtNm/PjolYus6kMCZZKLTGpAEOpI9meiG22bkE2UemSJMvW7sioj6nyNGd/uDMYBaviM2CvuWM4WFrxsznJ8auMCLpOJf/z8j8BcIP4+wXDguhBAxhcVre3hW0iUJGIoY5HE+9EKiX30BnUoIdFi2sfsFj4/aRkrDFZmsldQ1dKDg5wBWyyVgj7OC00Y6Wq1/zNgQM7CHAdXNNl+B0cFA9cj8;25:fqDZknrfm2iWxs9ZPJyzie0eaCyEyvvx0zWMOtGGY5fQxsiVnsyCvhRLLLdoVaLEA6Xx+M6G3gj1344dGfCz/l1z4hZoUXQaR8OpVmFEHQW4jPbxInvFIp6sLD4P+YIDtaoIvEp2fGi3PxNTLEbjhz0chqTyhMtE25tUVmiHt5C89bzBe2m3N15tGTwPdKWlz1OnOsvYseiuWMSGgpJFPcrBehjftCXeUJvksc8hXotn0ieCVawjekKU9d/7OYLhx6iFbeZeCZq3lFq4lahWiBDQtcf9J4N7g564gpi3seBIWOf224YSDC2kzORdbJD6I3mRCAyxKeW+MjlifGZyPg==;31:+/6czKpyFYCAhqUD3lCJzctAZLyA1z74hcWG4/lIwWw8CbFuAS5HDzbX8iSR028UYx+/cIKx9DzIIC0VshE0FNA/XHfzKxoTMA2mCA51Cb1OHbwW9y7S7JFCLiHmho9vvBA0UYdeGizDRjWgT4DFMnfHBNFmCIESwHz9sOO1q3KbAPvR4QvWjD3tvnnW6rCWOsPDkLYAOKC08vTRFVgNwze4yLZNedaCYVXPpf37r3Q=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3523:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3523;20:Y/xs7k3WFLySXg8rsOEY3pCsXS3jiv30+uIviG1u4LHkXC2pTlOR/8DvcaWCD74QnV1rHk0zXq+NYw1X9Fq5DERTcTzW2kCE95A9kM+m9+jSHfdidwuy+gwjOSrrxqJvgv6x+FZQe0a96ctbbsVBfMuugKzo9RUnfPkOh3FuZcVameWCHEhK0AQoUNlarzWCmzptXMTmIZYJnXVtK7fcqmb9AgwGFinuE8970rjd4N29ebk5HIITSuBxtkynJDFvq1oB2Y/eWk5m8vcFbmX99Wes2gI6C6IVlQYJahiRfdPdB8DkA1eDF6IVvVvvhEBuxew9qFf+gCETHAApeUiLRg==;4:WUF+XPedkvB0+sAAT4uIizzt2hmb1gA1MB6DxDsn8+39Zg+Dzq9fIdWc6VGDdgDWvig/wZ7LQrYyVeRJ7VVb66VjpDsaa8G9LkDGoxmPQgG1Hjx+B+cdnnYT3ktCA6dpHg1snQc7PWe6RewigIjZaYbvrZ4edAfycqrlx2bJGh6p3Tk5ez4ZM0ELU3R7s/hB+MoAolRKyfOi8JRXC6U3tmgTe0kR3HTkn62W/9Mfxgu5NxzbPdnsxwBc05Hd2qGhk4+slFEXYcqkqVJqoSr4n/WrPlBp9hARdKDERppk6xVb0NRPNln7VYMpMvi65kSa
X-Microsoft-Antispam-PRVS: <AM0PR08MB352394662FB17D86EFBE976D9F3F0@AM0PR08MB3523.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3523;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3523;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(7736002)(305945005)(16586007)(66066001)(37006003)(3846002)(50466002)(45080400002)(478600001)(72206003)(8936002)(48376002)(68736007)(50226002)(86362001)(39060400002)(316002)(6116002)(5024004)(14444005)(47776003)(36756003)(97736004)(34206002)(25786009)(2906002)(5660300001)(51416003)(6636002)(2361001)(4326008)(6666003)(44832011)(6486002)(106356001)(81156014)(105586002)(2351001)(11346002)(53936002)(7696005)(956004)(81166006)(386003)(52116002)(446003)(2616005)(486006)(8676002)(26005)(16526019)(476003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3523;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3523;23:KzgH/DmbZN5bxMxWDoCnYzS4FJ/hej0wpIByHxa+Y?=
 =?us-ascii?Q?85tONl/7R1Q210m7akL7ZgIBOlB6f9uYsJ7BqDRAOZGjTk7BVHVI7JQ7rJ8S?=
 =?us-ascii?Q?GSRe6JY190u4JTtHzmdHoE8ESxdzz78rF3QZipUbGQ6JIxNXjmoH/XDsCSzo?=
 =?us-ascii?Q?7M+SCAPo15RZg+4oqf8cSnt8dElfv553hXFBaMIJRAXHw+avBbHRnNTMd+3D?=
 =?us-ascii?Q?iEqXE/4oYdY/0pwb2E6rmMi5q46mv4yvWxEe/dGg5qmYDSBClveD2YuyA6yP?=
 =?us-ascii?Q?BVfLQRmRMpsFlJRPxFeeo55zWLDQQlMFYQzoQfKei2GJpFD2T43LHjMrJGTv?=
 =?us-ascii?Q?fM2zwWsnRIbWVGvy7S9QHyLZCAlVcduOaAF+9zjj56dnddeYSEKjgwixEgOQ?=
 =?us-ascii?Q?I77mz0b6B4bVBmcogvvKY0TfnAvzaXR4jAzHGaY/mA3Ws7+3qyttgWJLEeG4?=
 =?us-ascii?Q?7OGjh/nci/suS72f8cSOXW+n0dCGflfFEtvCNOHbTtiYWMKHaUxUoVp0zeAn?=
 =?us-ascii?Q?mtjCvlCMeVfEiItxDlEEBAsQt6RD7M83WjXsesIHr4SBBzkyygyd+R1xMfoq?=
 =?us-ascii?Q?Uhbso6opxkTkknGbyF8UdF655Kh8eNryjn3lkfQ93scqjmS3XcLenAyKRTgN?=
 =?us-ascii?Q?tJT7gNVx5984r/ni+z/1ML6VeNzFIxaVuzpmzqhf7DwiWo9rkDQHJxUbr8Rw?=
 =?us-ascii?Q?9zcP8iHVMzdwkrWCh2/mHakkKsOSqIYXWvQcv0dwyb+jT9+t/H5XqYx0pl80?=
 =?us-ascii?Q?yR6SgHps0ul14AT5AZt9i3+xSaE09w331x876nCH7rDo5NXGhU1OSFG0Rk7a?=
 =?us-ascii?Q?XA0Jb6IB8NXgzQ9nDpslMNDh4chYtdPC7hiEfZqcaTrjJIhVSP/LXADsKKCe?=
 =?us-ascii?Q?33kn2Ac4LoeXM50ISdb3xNDDGrY5L7sSmKizb6ezYKhjxI66JLa3MufIJw0b?=
 =?us-ascii?Q?z2PC4EydfB00bf3HfVaIfcQV9gUs7l5ld+/0ZyG+bk3uyMdiRTL+mQ5Rzm6o?=
 =?us-ascii?Q?6QfR9Yhvvp/GNPFv4g5hrETVWwbMt7ZS74UpKPshE6JtyhMAqnD+IC7NiHtx?=
 =?us-ascii?Q?ckZ5nB+VWUhP1qIWU2NMMTUReh2mVfYVX5IpZpdF2U9eMzSnOqCc/YGPECtA?=
 =?us-ascii?Q?q0PrRWjsSA6pOplihgVpnG3xnhr1XhI2q9w1KIiyCWXR0A3E5eEfkBpxTcoe?=
 =?us-ascii?Q?ffA1cC0T1Cq2XTsLxqNx4X60BMVLUERyrN83MgxdIXwtEdxHxMqcY8qAIeya?=
 =?us-ascii?Q?NH/FrC24oaez4GAO0pS1xGTUaRctF8M62FXjtifPczSXXDnZbuPTNN8AoE3c?=
 =?us-ascii?Q?S+zp3nINnnbB0bqhjIEVWUc/3R4rvnPsAV/BxOhtnIXnmjHh+fJ4KLkqxKV3?=
 =?us-ascii?Q?EVHVw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 1orlgNoX9VThUGRPmf65vE6mFfZgE0eXeMXWmkjSuCjOv1bufljt8b1GPwyZef/UKU5T7IYB235omno7bnC84M0hGEp0I/gAXgS1jpIGUawr8BL26PKIj1JMJ38Hf48TRtshlqGS12ZMr09a8H+63IwHYKYfua/7KC/TjcU1r0yqoLwCb6CmChkPzeQPR0Col+OPBIeQ+l6nMTx+ITWjdJ+eDRqpLIMDnK0h1d9Bf21DPg4DD/k0khXaSW6kNpghonObY45iA38Y+WT7tWfuZNIXaC71lvsShTqtE4G2G5luUW1AkEmRZuHDRWf1rwXkxPfzczezE5Wb9H0dKm1xg14kEWhoGsuLomfrNBYvNBI=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3523;6:329boDAo/eON4vsk3RBjgGpvDZkq9EtRhbxeprTe478Az9E3gpw5HMVXDmUP52NNAB/jwXZE2RToJ4X0YAH27qLrI9VMFJBC4IW3PVaTnYyuC1CDk4nRcc37ZPs5zEK5y70LQBJpHms5dXdTJ+Sjnpghp+0G+SospRMzo3l/n+WvcnrE2KK21wy1F880yWGU9PNCA+TOEtKVS4TwCrf4/ZHawUPxEkau0B6av5uKuOCFlLaLwKf8menYnIx3xCtNdx+4mn7dG7UC60gSSNQKoix20iqnAnDwsanftL5ZLyhW0VI+TwdouOeqfwRMW9ePLPXCPSpcBnwKtOZhtrBT/mUCcQP86qd8hdF2QwSZt6yKPP9Ay7yyzUqDUUFXxQkgsFR50TTZUtjV0QpJx8vtRzAN7EzfcANdkOsEiSLQyTe5qPflSDO6BawFVmi9AwuggVT9SDLYXhbdLFglLB0F1w==;5:mo/CVpTQo24Z7VfCMDrSl+73oqMcmci0eWqilX4mZYIXpthA9A9ETO22TnY/sfzV3jJuTu+UVXFOScBQYiIvyJANyPj9TtMCWvY0I3qArEJd4Ncj8O9Id2eAlsM2a0H/CYv4k7lGBeqBk/p/xS6GgRi23P0SZy5mvu+UB6ZpOI0=;7:hYLAOaaU94Y8tw6nvGp5Vmp3fXE+lIy3V90jsbp9/C0kuq5lmbn+vICQHUGWr35QO1UdcZ/F7MtVg/yZRePsGow2MiYL24xmYsX/TgeUR9F+1PMgrA++Vd+hU4UVOk4DPdvvLqsS3RPuwGdgprbPUckODWMskKpZU3/+XkPmuNjtF5InY2+KNszvytk1oqIP6fef5IJ5Ki5DOIdpcwxeZVdPi25w134ADEisXi2p2l7LbGK/dHSX2yBcJvlG6iJz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 06:35:59.4333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f4ed8f-6cfc-48a9-a1e7-08d602795f9a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3523
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

Changes since v1:
 - Introduces to use it in the malidp driver, which depends on
   the plane alpha patch
Changes since v2:
 - Refines the comments of drm/mali-dp patchset
Changes since v3:
 - Updates on drm/malidp, hardware limitation check only when
   the format has alpha pixel.

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

