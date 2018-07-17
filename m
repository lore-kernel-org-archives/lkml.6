Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066B9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6E92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="l3jcmX/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6E92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGQRr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:47:56 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:36100
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730745AbeGQRry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eiR6+gSZvB99/gdaUJMloiw6Ag5tahykAFCQU6EXKA=;
 b=l3jcmX/dYc6+TFnOUHGqKvYqBemQgikDDyJ7qdeVh4SqxwGJpiw7D/NxdH43khDBNDkeAgvyTQI7OHkKncZhWLn/vDsv6oda4JpDl8I0J3rJdxGV/JFtxg5DnVIABM9YGLK/dHOeTHinI9zdhhzclHK2VCW3/DLUNykXgL0SeOw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1377.eurprd08.prod.outlook.com (2603:10a6:203:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 17:14:11 +0000
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
Subject: [PATCH 3/5] drm/rockchip: Substitute is_yuv_support() with format->is_yuv
Date:   Tue, 17 Jul 2018 18:13:44 +0100
Message-Id: <1531847626-22248-3-git-send-email-ayan.halder@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5b8c3aa2-3a56-4865-f7e4-08d5ec08b7cf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1377;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;3:jduvcIniSv8wRhCyFhZrpB2rc1ERZj10pvpcCdsrReyjGt7ifEPYWravKx7NgERUJV8OzpFWTbVl06VKbGmipMTJG/oc21J2MR2PW0hebmpmTftIZ1j46+S+wmH4wL7E0bUutevPVZVI7IMLtjyktOOnfi276J2ySgCFhkA85XWDbOIKtXDidqRaKCRMIRMl2Vv+N7IVYemv63YutvVATvp3z5/fYecyaGDdqDOftrjd/wc3fgkVnS+N5QcE4nOq;25:E8kjsL629XBvyHQCke221ui8jGmla49fSVF/Zz+SKMmARhJJSl3HnyW/BnDCRKN7MrE+k44b5DLe9CqEbnFe2b/1HMkNGjV9cY49xoGL3rvC/fj709jNCEgcHKufXZOvB6tDyBOPEPp6GPnMZqbr3gQiJWz9NozarE/kcFC3mb4IL9NqzuuAtXzUxa2Q3EvSOiizem2Hv8yqHisSOCxM1ftbH949xaQoRzzuXhaFDxI5WWsAakVA/Fs9JjQUmk4sYOmsRHKh3cQV0hkIrTOTQW3kyqbnjPQEh3AhXJbGe4A/WqgcbX2JIzPjbRRFDQs9mb8sBlTmJEohJjJLfpQzUA==;31:Z7qYuJLJ5H+c/3G8HFi8Q4fqjqawqj1r4BNwrvA0AGitKmkutZNwrBvKDK/yblZt9juq+4yGkWH8wy+S/HgUdYgsL/0BOGXZ8dm6M4lNaxpHAJxvGs6fCHfOF1Yhsk/d8il5OZCrUUIJnthY6LobGTPbTguTKv/Neg3/pVj3NIEuTOlgyyTL/Ugf05Q16woIam2KZjT8xS8EmtJCT+MaQXjWEtpy/2vAm7jdPkM2AVU=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1377:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;20:MLkzc6hhY51rgzQstiM47aR9CdaM4dpvPDs5U7mbwndCmqjea1c6l4Rb7IZK13Aj3fSj2GWHcCNa0lnsPd1/2YHw7qjl25ONjxviSOVhkzLuhV2z0NEPN/rfccmvO6FzpwgxCOCVpZTL951B54MNtvjb0HaNvoMtW+vBNzNI/eE=;4:FGXXDlyYL18F676wFw1cvhd3joWVEjDLfHqbM0DN3XiJfxecZTcoZDVV4qfUXdqJ/kxN4DT6JVaPLKUONgUFIj6GLj+fw0Eg6HKkBeTO01EqOJz0S6uxoX9G0z8mfg5mPMNKoOXWjbSEoEcUN97FHfB8vcB4nkn4XhzQ+o/9VKNx9Y7wwxDyXyWP2URWEGcDk1d5XIDDMTnWfjV2JAHUyGQOWb0p4caMMieVMCS+6VU0W10wtcyAieAYLTDSyuigPEcNK/Qsc/9uhOPGTcVLdgGkrK1S0lENFeOP6797ov+MXmbEKMdSi5At4AJX9zgW
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13772EAAA7AF5D2C3E1D25C8E45C0@AM5PR0801MB1377.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1377;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1377;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(199004)(189003)(7416002)(316002)(305945005)(36756003)(5660300001)(76176011)(486006)(4326008)(446003)(50466002)(51416003)(48376002)(386003)(2906002)(52116002)(7696005)(476003)(53936002)(11346002)(2616005)(6486002)(66066001)(3846002)(72206003)(68736007)(16586007)(478600001)(25786009)(956004)(105586002)(81156014)(8936002)(50226002)(26005)(86362001)(6116002)(47776003)(16526019)(8676002)(97736004)(14444005)(81166006)(7736002)(6666003)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1377;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1377;23:04wI+1uVkUm+lNYLvR4dO+yyMC37ipjcpqoW+eb?=
 =?us-ascii?Q?+e8d0TT2NC3xoERguJotZHdm2IY8IQNAoFBnCdYvEPexV9vVUJlMCQSTy7oq?=
 =?us-ascii?Q?nZxAKM5lLdyJTNnXbDT9jnpDVzXafIGVCVzyrtxZncxZDLVWZZJRaN0My6Lq?=
 =?us-ascii?Q?ssO6+zE0MGadIHFoBAuKxln6jwgoYpmrtJiWabZSvhzp2GcDa3uqMFVN/taG?=
 =?us-ascii?Q?JTKEXzcR9KnWjw3QIgRYAqN9bxgwujzvohOrXVf/QBJWoMus1UIxznYfvLi6?=
 =?us-ascii?Q?ZE531Alzio+4s1879EI0NCsnbbgpsF2HNPlT0d67JIwByWyYJCu+iK/UJJ92?=
 =?us-ascii?Q?9k3bp9N7fieO3HR/u4PgFUyz7dz0tLzWoPzA0Z2HzQG5FTgtM9DjzFlYXHYZ?=
 =?us-ascii?Q?I2Jx6W5lrn1+DuW/HC5WI+Lo/AxildbZ2gdPaF4lhPbajAg0eLsdWKEqccxx?=
 =?us-ascii?Q?2A0K7O0oKpHTkSLPWW3w8UH2mctDm9DDHsB00WJLFKavYx0yypDm5d+0UV5O?=
 =?us-ascii?Q?IRCLFo/q8GJV3rAMM/Agc3Svggf4+7IV7CFWS9Pg4yUyyX9GP+PkYtqM17V0?=
 =?us-ascii?Q?R7h1ouSd1NYIdn5mxtn4djjIxqB4VQQBHMg345/ntSWtMLYNVk+2XLYuFoCm?=
 =?us-ascii?Q?TA9jFmNIHxW2yv92BoKTVcY0gF6omTYUAEmMRs/kQvXg9Q2m+nLetC8JF0Pl?=
 =?us-ascii?Q?eRQU6k4lH8gC/2Vpsv1gMl7TZFIsQFn4MW8ysomGgofanzAXT+1GReR10u9A?=
 =?us-ascii?Q?vKFRpe+VDlba8XNt5uoQ7qiACvuCL5wnVPhMdpKIsLU0fLDgTvM7ezOIPMYd?=
 =?us-ascii?Q?xXTQ1PjsPyH+5dQgrVSr3cLrcet6DiVIrgJZYVYw70jF7+Ek1+8SzpdjkuJH?=
 =?us-ascii?Q?+8LDAYbxNWe6DmDX3xztS8sQV+TUQZRNBZQpBEnjT7r/TeNyfog9EmaK8h6j?=
 =?us-ascii?Q?dHa72uzPIP/7Dhz3BMm/r+J2rC3s4W/i1I/stkj/6wrOiO0xY6XDTAcm+X1/?=
 =?us-ascii?Q?yPsORYbJ5aVC4nAsIlFTb00XLiHX6gjmfdNLAILf/hUn0q6Ynpm9OCaLWd82?=
 =?us-ascii?Q?gohDm+Z0KyYkwEiHamEKGabpHo/taRbfWv5KrzaseDpVW1ZNf3lIfwnHs6z5?=
 =?us-ascii?Q?KeDsKie+qH7ghFHUxyjdi5/AnNMocBJMJJFvYsFa5weTvxNKpyEffYn0BCgO?=
 =?us-ascii?Q?TZnV4xpLnoNqX7gzV3Y32Qezgux30IKoebsiK?=
X-Microsoft-Antispam-Message-Info: mfePAV6Zu1aVb1SQwFViXzIk1GPsrmOmG3HCrbtjEYodlMJJW5FJmt3cQxQTVJ6mNB+5uHM/IBj/aYmJRWu8Z+u4hMC/MbkZvA3b+trgAzIqjokpbGt3XKIbHgZWU+KjFrDg8AZEoj6nhmUWkgyAy7snNT5RurYk2jjmOWvjLVHd7MtMbiI3a5BuZ2n8QHlNxLmCM8f7JtBZ4HyYyVQhLj9IIV0otTkqYwticTuCjz9JgXf6+oow+nPCDJCCTWI5Ja0ohFrEIjBhsoFcpJ53l74pwKawh2hKwl8n6ZF0OSKlZONe3oUI5nHWlujq9pRMfW6YqGjaSSA4gF9d9exzV9Uftw9SPy4kgoSJYKR1x7E=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;6:2nSxjbRJwWEMqgD5ajxYwAaBvsqdw7qEdSkJHvVxzprQJhoOdNWKszbvvnQELjcU7CyEJXQGDll3m6t9w4tiSeDrZKzymZCKXfk35KxjOdebXyXthMbRSs2h2BKjRGWSPbFx9pet5Fwh01FEZrRfo45IK8RpHlmwFNErI8rAfFTs9f9n0GJjxIYrXYoazqQk2xL10dYSEJYJ0zCjsSlJUIEiXXILV2Cyzzbl0+hsIFedxbF3Df9v4HRU3iQA6oouksN5bhekDUfIfZ6QK3l9Nf4rZFboTY9G7eXQJRK1YsIfz+ic1i3pDYTUTfuDj5sxnUZ9dcJBq00meIMj+ceZ3+0lfRpCWP7ngRQMocJxBlyOIpruVGniYXU3A1EZp5gOKLk4SLSAm/Xvx5/Mno+/sVZmcV8o8mMrwDDkfFxde+P/8qQj03BFSoHUr+Yc/rdOlGd9pkLucML4uH/7uZVzQg==;5:/532OEKp5g7sfebrtm8TWaqSxNTTNB+wUvNLhb2ftFsw3x+3zil3lTcsYg07dXeRg98/vr9Pzu55fda9qsNKLlWZ9ELZptKPFpcKhYoNC2Vyjk40UoGQ0xdqhvKpoVuLBQKL8oGrt5jpzT+j7lzk/HlELZuy6FxkbzU4XDGeiQk=;24:/cggGIUzraU9L01MIY31HcYLa2nkKZYH1ugBwzBSTp1yRCBGRATFvd4jfwDWNrWD34zVB6t8CEmyn4CQHeY9xUGLOZq60o3F4apVoL4VSoI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;7:lNDNWQqcYNDlfoYDiYGpWYQRFURsCmsXqLSn0i0/FHP4l5r5Ei6etV4ildUDPXaZrajnNFJAL2i/OyWYRK3EyTtAPt/4TDE7V1zEGgbhwyQa4hY0ofjSPllnveKXLBCdNkjVVZVIMaZGDuaojUzuSK+lMiYrXp2bgRsJS6dPyZ5r7j6jXsDDq7nH0AiLwHSGthOwkz9VYdFk8ecFXXgj2ATXBCeG8IlW/L1bjsHHK5deEMY/P3aP5W/TH741Dg3p
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 17:14:11.4293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8c3aa2-3a56-4865-f7e4-08d5ec08b7cf
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
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index effecbe..1359e5c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -243,18 +243,6 @@ static enum vop_data_format vop_convert_format(uint32_t format)
 	}
 }
 
-static bool is_yuv_support(uint32_t format)
-{
-	switch (format) {
-	case DRM_FORMAT_NV12:
-	case DRM_FORMAT_NV16:
-	case DRM_FORMAT_NV24:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static uint16_t scl_vop_cal_scale(enum scale_mode mode, uint32_t src,
 				  uint32_t dst, bool is_horizontal,
 				  int vsu_mode, int *vskiplines)
@@ -298,7 +286,8 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	uint16_t cbcr_ver_scl_mode = SCALE_NONE;
 	int hsub = drm_format_horz_chroma_subsampling(pixel_format);
 	int vsub = drm_format_vert_chroma_subsampling(pixel_format);
-	bool is_yuv = is_yuv_support(pixel_format);
+	const struct drm_format_info *info;
+	bool is_yuv = false;
 	uint16_t cbcr_src_w = src_w / hsub;
 	uint16_t cbcr_src_h = src_h / vsub;
 	uint16_t vsu_mode;
@@ -306,6 +295,11 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	uint32_t val;
 	int vskiplines;
 
+	info = drm_format_info(pixel_format);
+
+	if (info->is_yuv)
+		is_yuv = true;
+
 	if (dst_w > 3840) {
 		DRM_DEV_ERROR(vop->dev, "Maximum dst width (3840) exceeded\n");
 		return;
@@ -680,7 +674,7 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	 * Src.x1 can be odd when do clip, but yuv plane start point
 	 * need align with 2 pixel.
 	 */
-	if (is_yuv_support(fb->format->format) && ((state->src.x1 >> 16) % 2)) {
+	if (fb->format->is_yuv && ((state->src.x1 >> 16) % 2)) {
 		DRM_ERROR("Invalid Source: Yuv format not support odd xpos\n");
 		return -EINVAL;
 	}
@@ -767,7 +761,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, format, format);
 	VOP_WIN_SET(vop, win, yrgb_vir, DIV_ROUND_UP(fb->pitches[0], 4));
 	VOP_WIN_SET(vop, win, yrgb_mst, dma_addr);
-	if (is_yuv_support(fb->format->format)) {
+	if (fb->format->is_yuv) {
 		int hsub = drm_format_horz_chroma_subsampling(fb->format->format);
 		int vsub = drm_format_vert_chroma_subsampling(fb->format->format);
 		int bpp = fb->format->cpp[1];
-- 
2.7.4

