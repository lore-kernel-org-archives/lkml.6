Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A43ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FBC20684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ui+DcP98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FBC20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeGQRrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:47:53 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:36100
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729748AbeGQRru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp2V96KK4tzf3I+EN+skOsOY8Hk1n6s9s9DYuU27Su0=;
 b=Ui+DcP98sBzrfNxnxWbMqgiu/NwcvoJQ3WGPeg9xEhNxwltAoGbL5uxmaUnOB4nzYuStTjaCeIwIpTRrHAO2bsFhpVYyW+I/3xDwmr+wKalrl1oRGCBNvVIneYldd9j/BcUo4qD6PuH/anMSCY0NdwnUBvcsisXEr/PZzna9dgM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1377.eurprd08.prod.outlook.com (2603:10a6:203:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 17:14:08 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        hjc@rock-chips.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com,
        sre@kernel.org, bparrot@ti.com, peter.ujfalusi@ti.com, afd@ti.com,
        dri-devel@lists.freedesktop.org, maxime.ripard@bootlin.com,
        wens@csie.org, malidp@foss.arm.com
Cc:     nd@arm.com
Subject: [PATCH 2/5] drm/i915: Substitute intel_format_is_yuv() with format->is_yuv
Date:   Tue, 17 Jul 2018 18:13:43 +0100
Message-Id: <1531847626-22248-2-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: MRXP264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::24) To AM5PR0801MB1377.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb169a4c-6df5-4b59-3d6e-08d5ec08b636
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1377;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;3:npg3JN2ydkUUylephFOs6jEP5Te9n/rflsWQxcQaNSZjPiQIFZk+ZPv5tnSFIsMnxQj/Ib83x+2M//qBv/2l6n9j5bEy9hOBkLfPpz69DK48WHUeXp2bIeTM2AN8W7U7NQtGrx2c50D4Sjp0s7U1W35o5EJIB4zQzu8ucbqbVF65Lw45qX1Wp5jW39TMRNLMeHF8eJml0E4iCzh1urcA3KQraceKjiHefOvsQIbWfqixqHRqbJOULtKAAj8H0/mA;25:GwKDnidgcRqLCoYXlf7u9dRjKFduQb8jdra0A3tUHyukwgeLFo5IDo1QUZgUj6h70PcfoHJBiVUBjECmNgv9T2UANWWL2PZsFLy3ioAtTpX1Dcdwih6/NtNOCiNHGYGvS9AguVg62K5mJQ9modMUjzfco6QuMeXu0rHmWdPgEkHX7q8bnIoIC64tJFURBaGZ7If1EDc7ZLht8XMaNnmXBb7osVKnBKZef72FcLkl7S+c+4YyHHCm346aVB4SCi9krmLHKYI187wDH0gPQjSeANn2hU9LtkWaKzh7ZAtwaA1lPk22nJCuzPG2Z5XijcxazSEfS2QebWHK27UiySZ3rw==;31:cDjd60OVbZ+BwxjxEFRrTpTrS/cUCYp1PxBnGtteSqfXfdjwpel+0lxMZu+MvSWoOR2QX4bHlMCrOrQwuSM3iQ6kL/jazBjaqU1oYmX56BB6WnPE9q4S0mbwLgLQYIZSNel85LZn6yYZnsi/IOOomNv39oJQ4KYfdDdXrMJBbEEwAWHlbLXHIFMAjR4gV7JPuo08mMpGKmhUpBbu1VXEOBqMyrG5r2UOuk3DxwrpMeg=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1377:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;20:D3CaItF/FVhNYqrwmigklMn8Ylon84C75E2o8jMjFnWWSGklWr/hgo3sn8/6we5qA2TZ1lVdua7I9AoWNR28/VSh82q6GjM1o4QrpTOmep1nUkSkmdII3POVEMM99cRoOA/RbncQlh5XMAYwDoRAjWSeNI/Xc23CRresGMltftA=;4:dAMMPAl3Rz2st0M8rjKS8YL9rBUdSccjTsV4e2MS0yFyKu5HOjZEj9z9syS4KpeSiheuTJMjj0aXzZ9l2bvNucLi/Ra3dA9FpUasvSA3JUBRqf/LjODZ3CJdtBCwerCsz/8aJ49vUC2o+WfuPsMmxrn5OcyOuKqE3NFzgHATw3e8VDXkc2/AGxyxfXyajLId20G01lms5AdXYLhpHjgfhLkqPjoWpk+IhjaM/R2BhjFCn9u+UGPDox7J9E1CDzOXeGQI1mc2rVvS+1YdhPtdcWxMULR7H4RbR1OyAITPGouBl6/qF4PbAM6q9RWHVy77
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1377F316BFC1AE55C5274DFFE45C0@AM5PR0801MB1377.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1377;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1377;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(199004)(189003)(7416002)(316002)(305945005)(36756003)(5660300001)(76176011)(486006)(4326008)(446003)(50466002)(51416003)(48376002)(386003)(2906002)(52116002)(7696005)(476003)(53936002)(11346002)(2616005)(6486002)(66066001)(3846002)(575784001)(72206003)(68736007)(16586007)(478600001)(25786009)(956004)(105586002)(81156014)(8936002)(50226002)(26005)(86362001)(6116002)(47776003)(16526019)(8676002)(97736004)(14444005)(81166006)(7736002)(6666003)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1377;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1377;23:22dMLYxen54lCGhLSlvhvTw655GvU7v5O/FBrf7?=
 =?us-ascii?Q?Skd0EUW8pe2nbxFGQAt98RXJUHagxjpnKDIRkJ/HzFZrcoQspeFfVa2Tizty?=
 =?us-ascii?Q?PyWQjjOqo4fZ1/Rzr8JvTjsrdqLWTXULK12P7ax95Ky3JllqC9/Hd9WF8R/q?=
 =?us-ascii?Q?MWnqzPuj2CCPamnBP8Elaqfi4nkxxSTKlB1fKBPdKMTf5iBzlMlFUmRqWyh5?=
 =?us-ascii?Q?h7oIuqzwasoZuk4A9bLTldtTqMuRH3yUkMd69uv/5i9zHkPkDeSe41zYJAXl?=
 =?us-ascii?Q?QhzvzHWqPAlwpe/SX01CisU1+esbHjNUQGwBirmGYJh7ab09bSsPZcVsvQfM?=
 =?us-ascii?Q?IvsptffNJb0Eaec4A1oOyDkzzxl7vCUEmrkme3rfV1orUsoGiiUxuB/94e9M?=
 =?us-ascii?Q?Yp2jApu+8Uj5orbSnZMqZv8nWa2NqDlHNETIrCaxQ3pF/CIz+v5iM+hJiG68?=
 =?us-ascii?Q?xK0fpB6v1i8llIF/Fx1gQIKuZL/6VviQGMBmb+O6EuG094JcO2Qcb9PzBl97?=
 =?us-ascii?Q?KawfpE24JxhJDS3fM076Xa5q5fk59zKoTMxfPcqwyudocjj+owV895PmHzBL?=
 =?us-ascii?Q?U0/vbjqauwW5R+lGEHyw5de74GenolR2ZRquRqRrOhUcc/JY1NqplV9ode4U?=
 =?us-ascii?Q?WF15OPbLM6Txi7fNDlOmGltR9hUkM5T0/xrKvf08USzt+PomONDnCE3SHcn8?=
 =?us-ascii?Q?R7g+9rzsIKfWBPYI0eTPj0sgO5/5X4D3yR/rLTEJKTxqwx9ptpkwxRuLV1sR?=
 =?us-ascii?Q?v+WRGZ6e0mUKdd2HLsgv4zLh5TOGOXM1cV4Ai9Y3vMLigNl2o15V2BbLDskI?=
 =?us-ascii?Q?uJGJXihgXbI+3U0nQlWwOSBgDrPBJSHQUnhRHJXD3SBndl4QfvJ9VQVzWY8r?=
 =?us-ascii?Q?V+eDarPUohVR4usTn5kfNkB95+yWpF3o/JzND1zbAhEMxhS/pKwCm2b8KUoE?=
 =?us-ascii?Q?sU1u6Zfvgc4rbFaZOg+JQOoUPGc16hI5shJgGpa8i79ODFCjBbzoh3w9eaC8?=
 =?us-ascii?Q?jt0Ps4eX5YyZvHBN/jPNULjVI+VdyiLaIcTQk+tgAQnrjWM6Uiakbumyq2be?=
 =?us-ascii?Q?7np4KUEz6vZ5lQZCAc/g98jIM8LPOpIvt4U/drKFTFb/qYOPMg64Jxwn3jlw?=
 =?us-ascii?Q?qAWyo6EwwS+ICkn50qInpi0AUrfnf8QiZmRAw7LInViPt8u59Dd9PGkzwHx2?=
 =?us-ascii?Q?F8H1T3AWj/0jHP5jj5ZqQIy2Bk87zQ6DdE6P/lW0sDfMgnj6tQ1/o5Ur6pA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: Vp8USI7BGfTRFJGwg17mhAPImHWCKaoh5bD7mteUA6Aec619LoJWC8hdFgwnDN0GdyQfPY5qRE9P0FgBtZ9mKcyB/seDFiRWxf1edhdilQIbGjEX2FZgUfPFZe1ZiYFii6OEHBVanushQPhk+mijTWqBrA/+7qQR0fJ9GaA3wap5u4MA4194vpOrCzzZZAO/60j/5+cYsltpmNRcMe74G9QZAmC4hYb3uXEQXhQbudoxbQXwr4gVxetpvE6rsnaQCAE33J1S2pjovhONtOBEJXad3IFKOxsWFhUaeNabbayvHZltqCCjVejC8kKITJ0YxZtklPHhyufKwY2ti9ELW9Xspqcc+kAJuOmwYHAMrpE=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;6:cCLIVWRHlFvRpvgWks2p6B0aPGt9tJ4zvy4Df1IZfjIupNxlAxT9vmTiBaECA8cjrq//cW0UsKPU/bz65A9+eH5+it6HekJO6VsSKBuIPivjBpXtH0QBthtrV32kBTbRXBuKdW8wFkuABNofiTQA1oloUAH1Keatny60Ij/Mxn9H2L6iN7akAzIZXQRXdeeWh0hJhA2OdJxwZVmc0fpR95W04c57pQw7dop4V0UqHQfDRMbsq7zEmlSZnChJZ9PnMlFTB2HKOElnt39WrNflcJFnHIaJU7vmqKNgZHaaG+afnfGg6q0a3RbChlWMWV8FWKIEH31Vi9+Uoa6ePzSC8eVxfNSUwhJv2E+MkwtqlIqzzFulGiS7c89+xTQ6lsiB6jqxGTf0vlaECZTyFdzOoBpQ0lpsX9vPeeO1adC9Vbs7kmHlDUqYz5hq8AhVazZ+Uv2F3j58miALGzFnkfmR1w==;5:cXCXX3pC1kavkB+9j1Mv8ulTHt5kbEXw7OVQpwRhtxdoUpz2eqMvKIrUU23HR0UDBO4A1/ATShpoXEX3A97AOjygfGDc/nhRSG4AFMe9UR3H+0hc80fKXtkyZ7mu0JJpuwfwtojBHXDKFzBj0BowSP0dNAadeKp82p5E0K+Xbzs=;24:Cp3inLfCfiYlmvCKtFDDufH+i60h/Mbf0lIVq+kmvb6isG/ZQ1m/Qw2m+VrmLA7hwQaZW6SNxKsBF+VyDwEehpG1hs7h0y/n28gsMLUCXGY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;7:2wXzgDNdNmjqhzWa8frupmsaCzYrinYi1hrobBBBUeZj/WE5nQYToDhjIB/cWA4A2BQIgoftiINN/B5bTBdUpyJDUJvZEPaDvtfg84z+wqRO0uZEFhnJGQOMCDUg4acrzcPmjQNpgdXLlzcw8FvGWEI4//S+hlnCiCvQys3M4cAZwVVZanoMtx8nxhppHsCg10Em8uZkzWjam42G4tdEI9X6hSqwdaYKu+PXjhAPd4SvOpbgbCJShc3qQ6s+MmXc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 17:14:08.7581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb169a4c-6df5-4b59-3d6e-08d5ec08b636
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_format_info table has a field 'is_yuv' to denote if the format
is yuv or not. The driver is expected to use this instead of
having a function for the same purpose.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/i915/intel_display.c |  2 +-
 drivers/gpu/drm/i915/intel_drv.h     |  2 --
 drivers/gpu/drm/i915/intel_sprite.c  | 20 +++-----------------
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index fbe5a65..cf09012 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -3657,7 +3657,7 @@ u32 glk_plane_color_ctl(const struct intel_crtc_state *crtc_state,
 	plane_color_ctl |= PLANE_COLOR_PLANE_GAMMA_DISABLE;
 	plane_color_ctl |= glk_plane_color_ctl_alpha(fb->format->format);
 
-	if (intel_format_is_yuv(fb->format->format)) {
+	if (fb->format->is_yuv) {
 		if (plane_state->base.color_encoding == DRM_COLOR_YCBCR_BT709)
 			plane_color_ctl |= PLANE_COLOR_CSC_MODE_YUV709_TO_RGB709;
 		else
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 0c3ac0e..64111ea 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -2069,7 +2069,6 @@ bool intel_sdvo_init(struct drm_i915_private *dev_priv,
 
 
 /* intel_sprite.c */
-bool intel_format_is_yuv(u32 format);
 int intel_usecs_to_scanlines(const struct drm_display_mode *adjusted_mode,
 			     int usecs);
 struct intel_plane *intel_sprite_plane_create(struct drm_i915_private *dev_priv,
@@ -2085,7 +2084,6 @@ void skl_disable_plane(struct intel_plane *plane, struct intel_crtc *crtc);
 bool skl_plane_get_hw_state(struct intel_plane *plane, enum pipe *pipe);
 bool skl_plane_has_ccs(struct drm_i915_private *dev_priv,
 		       enum pipe pipe, enum plane_id plane_id);
-bool intel_format_is_yuv(uint32_t format);
 bool skl_plane_has_planar(struct drm_i915_private *dev_priv,
 			  enum pipe pipe, enum plane_id plane_id);
 
diff --git a/drivers/gpu/drm/i915/intel_sprite.c b/drivers/gpu/drm/i915/intel_sprite.c
index 344c0e7..1bb7bc3 100644
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -41,20 +41,6 @@
 #include <drm/i915_drm.h>
 #include "i915_drv.h"
 
-bool intel_format_is_yuv(u32 format)
-{
-	switch (format) {
-	case DRM_FORMAT_YUYV:
-	case DRM_FORMAT_UYVY:
-	case DRM_FORMAT_VYUY:
-	case DRM_FORMAT_YVYU:
-	case DRM_FORMAT_NV12:
-		return true;
-	default:
-		return false;
-	}
-}
-
 int intel_usecs_to_scanlines(const struct drm_display_mode *adjusted_mode,
 			     int usecs)
 {
@@ -404,7 +390,7 @@ chv_update_csc(const struct intel_plane_state *plane_state)
 	const s16 *csc = csc_matrix[plane_state->base.color_encoding];
 
 	/* Seems RGB data bypasses the CSC always */
-	if (!intel_format_is_yuv(fb->format->format))
+	if (!fb->format->is_yuv)
 		return;
 
 	I915_WRITE_FW(SPCSCYGOFF(plane_id), SPCSC_OOFF(0) | SPCSC_IOFF(0));
@@ -439,7 +425,7 @@ vlv_update_clrc(const struct intel_plane_state *plane_state)
 	enum plane_id plane_id = plane->id;
 	int contrast, brightness, sh_scale, sh_sin, sh_cos;
 
-	if (intel_format_is_yuv(fb->format->format) &&
+	if (fb->format->is_yuv &&
 	    plane_state->base.color_range == DRM_COLOR_YCBCR_LIMITED_RANGE) {
 		/*
 		 * Expand limited range to full range:
@@ -1040,7 +1026,7 @@ intel_check_sprite_plane(struct intel_plane *plane,
 		src->y1 = src_y << 16;
 		src->y2 = (src_y + src_h) << 16;
 
-		if (intel_format_is_yuv(fb->format->format) &&
+		if (fb->format->is_yuv &&
     		    fb->format->format != DRM_FORMAT_NV12 &&
 		    (src_x % 2 || src_w % 2)) {
 			DRM_DEBUG_KMS("src x/w (%u, %u) must be a multiple of 2 for YUV planes\n",
-- 
2.7.4

