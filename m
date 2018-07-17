Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637BAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ACF20779
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aU5hOLTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01ACF20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeGQRr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:47:57 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:36100
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729748AbeGQRr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aChXxglBUcRzuUfLqODuUSl8S772bEovI2rxFYS2/U0=;
 b=aU5hOLTdsaGUljlBg5V+2XYXDKuy24uRBrTYKi3SzGdcu7eep44gxXwDdOzP0hCKViWYOmIeJrQePvoC62dUmu4YVNyupFupwPU6Z23b3ThnmX/yVGsvPh3UOO06qlzzSjUO8fE1Git2jARAVzqD4sOtSKrYVXKfonNhcewbbkI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1377.eurprd08.prod.outlook.com (2603:10a6:203:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 17:14:13 +0000
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
Subject: [PATCH 4/5] drm/omapdrm: Substitute format_is_yuv() with format->is_yuv
Date:   Tue, 17 Jul 2018 18:13:45 +0100
Message-Id: <1531847626-22248-4-git-send-email-ayan.halder@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1c569b20-5089-433c-1c25-08d5ec08b951
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1377;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;3:Af8aZEVvbWyjlbWDrJEwH1YETrSbH5yCE+RshrSqQufC9j/cyd6OJyNF/f1VjI+Z3OL6ZK2hOe+jXk5Z7TRAkL+uGa0mE39jG5LakAYbuExWHwbK0gdOSXyLjIQGm9bj0MbnCKaqeH9Bo/gH/mRNJ9yyZZRiOEQSBTBfaaQFd5t3QktaToeHNbcTDPJftVRVZKL9Is53ko0QX6PqRFXdufDhaVWoEu1gfeFKIzByxCp/goBWswBD0vUBSRee+b0v;25:PQL9ChJjbXRJdbh7H2Oqs01gwXaEofB7NvIUmQ3z14JDm7ru/GvOGKfizurpG2ptpPW+M/blC+3Aci2EshyMY3CZgbF8R52bV80WjR7eUVHC1PQru2HC7pSZORT7HLK93yXZ7B2a9epjyjbFLZKOZ3eo2fkmWzo4goSs20O6MHgUoGxUbDTSDArPMzbEHkyggohhVAxWyjNEZzHjep0UM8QfBIWJ2fUqvppGwTC2IXqP+RPuHnJsqkfbm4CttlITf8HDd2SJIDDllvKXpG222QZr5wJFV0R6yym6/IRet0uKoBnZirqwZWTwIYVHR3fpKIinlnaC765WIsPw1d0wFg==;31:3e3V9sowz/hRK8WIcItuTSz1igLPmo3xA8X/rl1gnoPa9Lu5hByp4aAsXHFIQNjQWjQB7t/nSY/AIMy9UlqYyHGdQnRPrCtLzwiXJx3cMz01AOpEvdu0GoyOyZPJA1d9axY+dAxTCTr9vnvG3bJsHC5BGd7gRojrFP3ng/qOZhLeILYU+1vvaqZpRKnTopfs4NGuUsfgg/fHyuDctnjlY+Khnkrv8uDDqNXn1q1M1ts=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1377:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;20:cFeH5T9LNsQuwgcZ0xf6hutPB4TDRISsuwl20F2R8uxcyw89+fxwWhaVpkljUfKPP+hzmKH74s2oKCGAQ8lDQ1ZXb5FeaGPf/GglVwtSg+Zxa93VFJ9r+C+Vi2Nj1C3ZYuQM9KqqYoDfOzZARsQ9xg1JkaRlByvZ2pDpqGOlB4o=;4:pjOXJSUriOYJCD5ncHc1XAfKcrjjCA3pWX/EnHXUdB7UHfzNHIlW6Qs8OYqI3vvQ0xCvCW+nl/rvUY1ePipALf8D+oVafO0ZdiHb5ZuQn6m4Adh6uPYKGxtVOSPGnSohtgpjpfoIGHXTv2DSmWSEiAOGlZP2Ft9fuIxC17VMUBBSMoRDkfVzrBjEly8At884MueSX+xl2MEyeBrV45vQ40cmdzeSqmkGMzheybk2dn3RnW7FwLoup/1WmD/edDqi0MVImY/7fHTrSxAgBENNB4zLfflI26xDEzFdnQrQpiZU0F2gldquAGq+gzsPZ72l
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1377B5F9368471020716B14EE45C0@AM5PR0801MB1377.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1377;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1377;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(199004)(189003)(7416002)(316002)(305945005)(36756003)(5660300001)(76176011)(486006)(4326008)(446003)(50466002)(51416003)(48376002)(386003)(2906002)(52116002)(7696005)(476003)(53936002)(11346002)(2616005)(6486002)(66066001)(3846002)(72206003)(68736007)(16586007)(478600001)(25786009)(956004)(105586002)(81156014)(8936002)(50226002)(26005)(86362001)(6116002)(47776003)(16526019)(8676002)(97736004)(81166006)(7736002)(6666003)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1377;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1377;23:/dPrSl/81m369+eXKQNzKc352K6YW1sF3z+6FzD?=
 =?us-ascii?Q?huRfCaAdco2SJ6Fdua7IRDTfkreGAr/5Sx9p35OY2bLfVtC4vmhbeZgNeo+W?=
 =?us-ascii?Q?/nZHFwE1XoHYT3m31JSTUKagEAWLj6CQD0evWxNTexCxOfSosEg0ka3RAbsI?=
 =?us-ascii?Q?oLQ2vX4bO2QfnvA1vLqawt1RO4VAnmSomHIxeZ9GBJv2gvJIcxmpkIXFZqfA?=
 =?us-ascii?Q?QP20vAVTkNl0sSwhyL5O+7gWEIZiZUy99wL4yCgxwG1kc3NDTYHBLUtXdbuO?=
 =?us-ascii?Q?6ZjS+maIeoNNMGXjPo/F7NocafiyX4hrUMJfERNaZ5L5hWpYdz9SashBd2M9?=
 =?us-ascii?Q?5xE5cTdTn6Dbpu8yPuxPLgHauqgoF8CS7y4WnG7LLyDrtlCaWk1d7xgB9egC?=
 =?us-ascii?Q?6fIbNCZhzhk/gMrPmsT7Fv6stCgjGNtuJ2LFKJ7soiDAW5lGgxTyqMBjo05t?=
 =?us-ascii?Q?9rHkJomTKEsRpF0taoc6PlqygI0fAZolCKI83KKwzWehGlR+NPxKRq+j1Hbu?=
 =?us-ascii?Q?lT5wnnHBDmAnQAnkD27CNqW3ndyCOCVQjJqtvRJfa2u6RIvWbc/lvXmpe9JK?=
 =?us-ascii?Q?Eoe6LwQIkb05DdgHYPh5te60M6NBhUo/FNo/Ge9LikJQ1J7UKJ8iG3636I2K?=
 =?us-ascii?Q?wbScqvYqHBshnRt2sybGyVpMVxrXmV/5M1SwenxIvm9/tpjBn3zeSxIsWEde?=
 =?us-ascii?Q?fnF2v3f3t4FmpGvOpsVNl4y3CmUyS/EJw+Oxeo2hcEeYIPdZmVLUDoSsS9bH?=
 =?us-ascii?Q?L5A8y9HYou6VXwSjoviEWLdLe3mf15fuLXFxvTtTonCToX6ozbceEKa6Oh+h?=
 =?us-ascii?Q?rvxudbZ7xUiXVlh34Aj3g0+8zxw7Kb/gZhPjU+3vDWbxtDHt0t0MPnDJ1GNG?=
 =?us-ascii?Q?mVLVCqgDTzeJwv7jFhYlN3me1Xt/YqKf1RPxMt4bM6Av5lL2ABWovF2fA96E?=
 =?us-ascii?Q?XidqE8KncaRdU4cEIsSRGEO9XrXSAgT4s7+oG3FS+8qzrNTzkrPOmQ9+Q10r?=
 =?us-ascii?Q?5Iwne2b0CcTvwjo+iKAV9Wb9hjBWkDfGIEtDbCK4aOd2Yyp2scAghoZFB4Kf?=
 =?us-ascii?Q?3n2C0llE4K66/jqBgFenn0mr0N76bq4j7WvLS1Us5JTkmQ/zaZyEsqXbWV3k?=
 =?us-ascii?Q?b8KZR46E/TA93QnMNjY6Wki0nyIj2jU4uwQ8ww62nXGWuLFatrL247j5Bjw0?=
 =?us-ascii?Q?rBQ4lXFusYC5Df84=3D?=
X-Microsoft-Antispam-Message-Info: 5mafjIU4q8fcdIADDJphpFE3iHorVzkfJMDgy2mKEX6hCVLO0QJkQBVJevKnJQYfiDkWkHmlRtkXgQsmvWky02/q9n0UOJxgM1gNOtmUfm9H9uYGyDXaEr2LldTCB7HgnEHtB0vAGmDrtQegpLpJB45sBKhlX36dOlRCdIFEMTpt2Tr/hX39a66cB8soSN1m9G+nSSZF8uZ8bCpijjAqVGUg9nd9QolA1jPgIGFCDda7PWNIlewdpI2HsQXy2moRZGRUL7qU/UzvM5IDRoNfaNJwlG7akFBScDo1ua1zfy3OHCSRX71y7jx9EhJvGc7H3BHyXCtLYwQICl1f21ftwyFtSceoAKW9MUvKJrxZ1as=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;6:+Y3kYbAm3CXOYzlMk5rzxV66qho8ereG3A5X9fVoa5i83IaOR7+PuC6wgs+duTZLcVdbXygycNPAvwQMrPWkvX1Dk+EtjAhNrH6n7KSFMxN1gvsYwYTYqCexlcmuLFI+PcB2f8YeWRqbD3rfiICJFSHzNA8uT46o6nOZD2U9QDsAWV+8m39hYkUfmzvL57u8dBirzy1B59GGNffGZ2oWughJAfN/QG/D9o/GUdUmAEx4Kwhlm4wKRmXOV6NSegoaOPQXBNtBRmNNcWJJ2/dvbnLLj/o+1HxCuraF5Yft2Iiwyf3V9pwU/foDUzFhH3C7EsBZJxatNaMS9/L+HjIWU+3JiH6m10oxrvuWxj1XG1oPIQNSJrdyqyPfWs1yACi284gAUQtj00grgisC46SNN1fe1d3AH7pnhUBdDu29gARjLQt8LD5v+Qf5duiHFUgD0VXEVZC9JsZ6KkUzbWlVqw==;5:+lquM5qCPbRajb4UkY92CzpnRcW7GZfk+Sp4V/stAxwkFNvty/cgj2Y6s4zHr5Lk792LLUo7cMFTj1SrMC6xyXzqJW6XR518G4LC8EYB1o1yWfBnqR7/IFQkWFnVwjKTeBqxUTf7m7LAibgWYW/2QrJub28gGsOCmO5f5P5hQnI=;24:fyaTcELFzRuNCL2pty9RuHPj1Krm1v0IcGrFYYVt1vDEroN+YOSmvMNKcnYpmha74Zov1QVrC+gSpbQNx0w9+p5prvzA0FR+oD1E7ELxoLg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;7:01bbxP2EEaxtbfxOcVHaHXLyEqH5n037xqWdnUTYYEr7Lx/snjH5LEMqMQwbdvP4edX/NTKVeffXB3gEsvp7HG9QFo2F9k/2HMZiT7n3/6qz16qEKZYA0VDkvdtnsYEanJQMU91zbGJ8QHU3YIuM9NdSnasXwrjTF1o2GsHKtdfMeMvPDVlGlv4KEVpixEBIirBirVksI/euHmNJyJWVsb+MrifBBWLOIat4aCqQEyLBESM92qWP6w07XNgKhIdd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 17:14:13.9614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c569b20-5089-433c-1c25-08d5ec08b951
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
 drivers/gpu/drm/omapdrm/dss/dispc.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index 84f274c..8d2d7a4 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -1140,18 +1140,6 @@ static void dispc_ovl_set_color_mode(struct dispc_device *dispc,
 	REG_FLD_MOD(dispc, DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
 }
 
-static bool format_is_yuv(u32 fourcc)
-{
-	switch (fourcc) {
-	case DRM_FORMAT_YUYV:
-	case DRM_FORMAT_UYVY:
-	case DRM_FORMAT_NV12:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static void dispc_ovl_configure_burst_type(struct dispc_device *dispc,
 					   enum omap_plane_id plane,
 					   enum omap_dss_rotation_type rotation)
@@ -1910,11 +1898,14 @@ static void dispc_ovl_set_scaling_uv(struct dispc_device *dispc,
 	int scale_x = out_width != orig_width;
 	int scale_y = out_height != orig_height;
 	bool chroma_upscale = plane != OMAP_DSS_WB;
+	const struct drm_format_info *info;
+
+	info = drm_format_info(fourcc);
 
 	if (!dispc_has_feature(dispc, FEAT_HANDLE_UV_SEPARATE))
 		return;
 
-	if (!format_is_yuv(fourcc)) {
+	if (!info->is_yuv) {
 		/* reset chroma resampling for RGB formats  */
 		if (plane != OMAP_DSS_WB)
 			REG_FLD_MOD(dispc, DISPC_OVL_ATTRIBUTES2(plane),
@@ -2632,6 +2623,9 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
 	bool ilace = !!(vm->flags & DISPLAY_FLAGS_INTERLACED);
 	unsigned long pclk = dispc_plane_pclk_rate(dispc, plane);
 	unsigned long lclk = dispc_plane_lclk_rate(dispc, plane);
+	const struct drm_format_info *info;
+
+	info = drm_format_info(fourcc);
 
 	/* when setting up WB, dispc_plane_pclk_rate() returns 0 */
 	if (plane == OMAP_DSS_WB)
@@ -2640,7 +2634,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
 	if (paddr == 0 && rotation_type != OMAP_DSS_ROT_TILER)
 		return -EINVAL;
 
-	if (format_is_yuv(fourcc) && (in_width & 1)) {
+	if (info->is_yuv && (in_width & 1)) {
 		DSSERR("input width %d is not even for YUV format\n", in_width);
 		return -EINVAL;
 	}
@@ -2680,7 +2674,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
 		DSSDBG("predecimation %d x %x, new input size %d x %d\n",
 			x_predecim, y_predecim, in_width, in_height);
 
-	if (format_is_yuv(fourcc) && (in_width & 1)) {
+	if (info->is_yuv && (in_width & 1)) {
 		DSSDBG("predecimated input width is not even for YUV format\n");
 		DSSDBG("adjusting input width %d -> %d\n",
 			in_width, in_width & ~1);
@@ -2688,7 +2682,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
 		in_width &= ~1;
 	}
 
-	if (format_is_yuv(fourcc))
+	if (info->is_yuv)
 		cconv = 1;
 
 	if (ilace && !fieldmode) {
-- 
2.7.4

