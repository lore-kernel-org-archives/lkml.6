Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0F7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617DA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bos+eiAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617DA20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbeGWJ5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:57:34 -0400
Received: from mail-he1eur01on0070.outbound.protection.outlook.com ([104.47.0.70]:61664
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388021AbeGWJ5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxZ/Tg8HYcq5Qxr9qFQJ0ha/g00R92N1ozh0e2yUX0M=;
 b=bos+eiAUCYef+Gro+SF6zDAW73NhaMzSWksncsKv8cdRWrQimm4dr3lrleUW2YH0xg0UkfJlCl89GpHhDisY875mhMfGjfHjphFaWfPI4JqjxSdFyF+KumIsDqV4VDUCJQCV17BCdIiKqHEtGAxu/hxIklLFIdLBnk5PcZ7b2Pw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 HE1PR0801MB1385.eurprd08.prod.outlook.com (2603:10a6:3:3a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 08:57:17 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        ville.syrjala@linux.intel.com, maxime.ripard@bootlin.com,
        airlied@linux.ie, wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [PATCH] drm/sun4i: Use (struct drm_format_info) fields to determine if a format is yuv and multi planar or not.
Date:   Mon, 23 Jul 2018 09:57:00 +0100
Message-Id: <1532336220-3791-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: DB3PR0202CA0030.eurprd02.prod.outlook.com
 (2603:10a6:8:1::43) To HE1PR0801MB1385.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03993ec7-4db1-4952-5b59-08d5f07a4aff
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1385;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1385;3:EmxURfPox4bTn/Ln3p1u07fb9UlQB9vA+Tc5IwfPDSr80TSXDJYkaqJURFXAsZR5Hkzw6RTuQzm7f1SqW0aY7oDCUqqUkzTtVMlXkB1sUSyTbbsjdxQhS84M/uaoIberfv9s3KoJYhBgQaw2cjcAHJIaUw2jw5Jdi/bR1JTDYq0nuNJu7E2Cv5IuBsMcqLCeAOR7QesNjZKWB+GDSII8LQrfK6q3JF9wRnuLJGZYxwUiEbwvpTKz5My8PCv0s4O3;25:4gPjPXPdD2aiq03hIxrF3x9UblFyELfUNGJhNtwMt5PI5WXXjLRQE/HfUmeQJwhJWjMZ7apH3ORuAJ7K1VL8PCatDMB8p8poQugiqJng9Pm6IobDjQwUs4PVKkjfpajbcXHo7ZtmxhnmYiyRlCD230t/Yk7Oa3I0HiOcbzyZdkF/2+kziQtE1A/G9j17DxB9q890YLEDDWX3ZAZlzHJPLpr+yE4I31043JyPnqeKZq6fyWVk4gxDoNZzULxUkyV3MGI82/gcuXNOlIi0PRA6S3ZoY7agSlZYTXj7djljJPI+D9eD39eHc/vA3B/a65ed12sgsN0ydXLWWwB2vVQtRw==;31:QrOShUgOnyvZbo1saWglvlzBbuhBbkhCXCe1GK24eTpfOqLw1BedPpKXPthsiTyfKFlxKSn6eNgj1gsvgL1DAEdVwiLjbMbJqlEqf5fzR7/AajfTVAqKSIoXNwFLHTkzE75pBIM0aJdKGsT3TN6Onq6sMsHhzwZjV0qHQhfVpm7GYLDx/C3LHgv2NWqH3Mp11aPxV3k/m8hXtFeHzaZHHHCrj0HiDrBtJ+EXaFQpiVM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1385:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1385;20:ILTir6EMjaRjvY52ctoqZnzq4ZXP4mxHA29GPsTcj5XD7q83L13TS5EHpKCp4ZH4FcIHYmPfAS7t1nrtDQdwvtlbzFprK0nfgQqVcbN7e0U5VwaCdHSmbfxH4hP07u4lorrvYH/QXSXkfZ4H3kEnRHXVH9+USAMDeY7kYwD314R17ucHo/ivhUtwgZKxNeonkm7HoRnC8YrcKnSDa91UFE5t27N2Ekx2zVimfDlW0voEFCPp0ggG6AhNpMcad+RPsfYGbxcJ8IcZGu395YWMEiclGV01vPg2k8Ky+OYFfbBoHcBDIAHIvaJ5RqEUiblqv9d+JtTpjwfVIRMEBwI7Qg==;4:bOg6CaCOqc6HEQB1F9ESVGmp7pkWUdNhFNKTLyDHPuBbDqOcghhRzxoioRTX7tX41weE5Yo6lyzvx4I1vh4ovmSUriVmmDG4XhoO8su+Fr9mhVUXu2J0kQyRP5uEqixlgwU4MSXxr6CuO5buYv4wVxyd1EXBYT8bo6DMepJt1r5FK/jea3muuLiRgNI1mLAAaxY9mBbp/520oO9T9Ahe4lh2plyj4t3v9mRLP83nyK9zXuzAh++7Tuk0JwbWcIa0iCmAYP4blmCsTDqtslL8eXcQZVvkhjy54fHm7owkZUnBeH0LeyY/b73knc1hm9RpPjMDI+MKiCl5+iMVjelpCvH/k6uJjPrubEQHUGOuEJQ=
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13854AEEF2799C53D678E369E4560@HE1PR0801MB1385.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1385;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1385;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(189003)(105586002)(305945005)(16526019)(26005)(386003)(7736002)(48376002)(6486002)(50466002)(5660300001)(52116002)(7696005)(51416003)(6666003)(14444005)(6306002)(1857600001)(956004)(2616005)(316002)(68736007)(16586007)(66066001)(476003)(3846002)(486006)(50226002)(6116002)(53936002)(2906002)(97736004)(478600001)(47776003)(106356001)(81156014)(81166006)(966005)(25786009)(86362001)(8676002)(72206003)(8936002)(575784001)(36756003)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1385;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1385;23:9+HgRwvTT+u6RqAYMvAcbs5i71eUtTtYKxJLzIj?=
 =?us-ascii?Q?KUmFGLqUQpwNYO862zNRCGfslvIOcmBnZkCoYTgZjCbsuNKuke0y2II8DeWG?=
 =?us-ascii?Q?QlK7VlGgfnqcaSLetz9pC5H9JOVBYOK6nmhnmeYd/DYZNkvi3Za6qWX3OFqi?=
 =?us-ascii?Q?33KIlG2/yUX+yEdwQc7HfksbFE8LGR+FG4r09n1xoz2QwLX+Aufxd+4eppYb?=
 =?us-ascii?Q?6BaSbRpep56RExNkirbBHeWY/+U4L7vpYFss4adSTLRqpoiaGCkQmlyaATMf?=
 =?us-ascii?Q?CMHx7Kv59l5AzTRw8Z7l2Dq70NfVEojfBm2sB8q4jRL6UwLMXsxRns5SKbUF?=
 =?us-ascii?Q?aRGP3JiP7fTzWtYhJP1clT32hOJx2PfnT7s9StXrXzZXQsVTiPc8pZu2bDtI?=
 =?us-ascii?Q?J0edRE1bKKLAMHa8QGthuoqonTjTK1B8vC/Pwf//Vd9kp1+vVE0fCx0aBlu6?=
 =?us-ascii?Q?3iyTR9dHFgCGPmLCWSyJkFh+d/VPeX8HgsW3i76iw12ovPRV2mzLIhPE/3da?=
 =?us-ascii?Q?bcfS7npLheiLfKwNbgm5wmxXIfqCcI2LitngFu+GhK/ZUdt8KfhelkQObEXq?=
 =?us-ascii?Q?JvZkQtGmfW0839C7J/weRL+GWyHfeFXBKoObax97PAIzD2/se52SgPdQ3KNY?=
 =?us-ascii?Q?+GJ1CPI7DdaUyf3/ZCQj6dMzWzvmyIWrvAdgHs1ygLlCpgoO40z5wR08l/Pj?=
 =?us-ascii?Q?9kyJxDAy2T9/zmfOrp4zAP9dFDHdzwaBUl2YmgGXfuBreDYaFhaAEVouhOFt?=
 =?us-ascii?Q?t977k+n/IVhIX2CeQuYryRYfhK1Kcm3ACJ94sQnYE8daghpWCbpq5bGoNjgF?=
 =?us-ascii?Q?eQ/BRaGDYh0bySATbD600//HtTMdgf0VTwspbASJ1cWMb2jIrbdggpoZVIX8?=
 =?us-ascii?Q?6ATY8saNJO8eu1r4+XiB7TYZAEuqFeiloz58vmf6n3a0G9zvEIdHWcuK7fcb?=
 =?us-ascii?Q?ANZin4cZQalQdWhl1chv7YdxV0RbiLh0a5II/061GxnbAM7veX0OXOY4HST3?=
 =?us-ascii?Q?u9AMzSvNBUJVxIW9e7DouIp3GF7YOoHw78thl/on+ILs6GBHFG+YNDyBY9p2?=
 =?us-ascii?Q?GakQpCIot/h5w8BkmIXZr+JYJ4r5COYn3+ReN3ZrXD5uSf1A7hsMmt67q+KE?=
 =?us-ascii?Q?L8oILp6fgfTsNqbKh9djukJaBxLymuRrRg5Fgzsd8fdDFBXXmnAXzdCFE1Np?=
 =?us-ascii?Q?pZzABGI2Y0M641T/kJ2RPZ0xD+GnGMd+cX7JE?=
X-Microsoft-Antispam-Message-Info: owEIJdZbJg8/JuMDgOxOc2VrJKSs7PRT0IPdLiwC20Z7zQL0SYsDyIms4/vpza1YHGbtN0xHbZU8pVRCm6BnQGKQREfkLJ1+FyNUoNDZ8P0Lh1JHVXVAYDS6wAixvthxKTw4w7ENqFyeUPe0jjSSVWGR1JSHLCQvK4bmY7TwJXx34wpe37/Rfg0Rk6d5VmNffg1h3zSFk8J3FV2aoNkOr2mJy/PFXjs9x2R3ePCLb/WX+MNULhCZuzkkDJKTBF/TiW0i3+dFJMv99L3jVjbmytKih2tB16n1znp9lxaLsrtegqam82dbYmA9g+qQ/+mt0JRhiMVv+0awVQZ+ICi2qRN6nmqKBGdTwY26O6bEbSQ=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1385;6:n3XOS/IAduDYjb9e2+XMpCZMqB7KqJMrWI6YPgB0ry1pVegWepioWJjgTjmFZTmnm/wcUnlLRMqtM9giTAtqLSgrl7BneTNe0fIlZPEqnjQ6mSFiI4t400kUtW7NenWht2MLFtHWaHGLzKjZtRUxTKI6/RJYD6S4kOXRaYVBPbfPEsh3kMclZv73PZmVmE1pzqKspYWfNrLWv1tAR9uajHAUqVGEfmvdC62BIoqx9UunW77xmPSjZmcTQe2nV+e+kzFvFnZwNlkW+goR9lsQKtIZJxL6h/R/VdFUs7hRBL4VEMaNzu/1sDQ3i8TNmBgVY2y6KUDb+Jt92gc9S5KtFEJzFneah23qmGcvymmJtzrcD5KZpY+VB7iBuT/ZZyh8h5t6VakRjYvI+hx7gLVrxWZgbULd5NfsJ/GzWn6mWBuldnedHm92ib9/QttvBjpFs7OeU35v0M66grbLLyGLyQ==;5:Kmw6lMibWaUlEGTX9K6l9i93CuW4ytkAA+ZF79gDH2KU5ZuMVGE+qO5T7jPk0N/iAIT836+NoctmWN3wfdtgJvua6XT9GbXOF7meDW4PyxowGvqVLoWaCbFtCuBvrZnD+1hs1AWwGrKe9JtFvf6Wsoym21+jYAZ0yCwD+VtQDns=;7:JpjFZvbGatRfVN+HPXRgyrDvFw07tGuo4FfX83xqaR8bIdVKhaL6w81FI7idI0dQX1Kxrlabi3wAU2hSbk9tBivw0ykzuBXxf3FhPX6MYeK94umWzbTCKqdMQi8DZZfS1X18BeAX9bEbx8yuowxtMrrTjGJc5imDLFJoLzWfPx+m7zN0UpSRG3GDHr9lEQaRW19Z17foJCuP5d8RrHfRJPicQnC9jc+Ropdn1HkBuSTd5wxb6Bh9+SkAZz7pXvDU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 08:57:17.0112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03993ec7-4db1-4952-5b59-08d5f07a4aff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not need sun4i_backend_format_is_packed_yuv422() /
sun4i_backend_format_is_planar_yuv() to determine if the format is yuv multi planar
or not. (struct drm_format_info *)->is_yuv tells if the format is yuv or not.
And (struct drm_format_info *)->num_planes denotes the number of planes.

This issue was identified during a review on a previous patch:-
https://lists.freedesktop.org/archives/dri-devel/2018-July/183840.html

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 37 ++++++-----------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index f6d8d0d..bf49c55 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -63,32 +63,6 @@ static const u32 sunxi_bt601_yuv2rgb_coef[12] = {
 	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
 };
 
-static inline bool sun4i_backend_format_is_planar_yuv(uint32_t format)
-{
-	switch (format) {
-	case DRM_FORMAT_YUV411:
-	case DRM_FORMAT_YUV422:
-	case DRM_FORMAT_YUV444:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static inline bool sun4i_backend_format_is_packed_yuv422(uint32_t format)
-{
-	switch (format) {
-	case DRM_FORMAT_YUYV:
-	case DRM_FORMAT_YVYU:
-	case DRM_FORMAT_UYVY:
-	case DRM_FORMAT_VYUY:
-		return true;
-
-	default:
-		return false;
-	}
-}
-
 static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
 {
 	int i;
@@ -218,7 +192,8 @@ static int sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	uint32_t format = fb->format->format;
+	const struct drm_format_info *format = fb->format;
+	const uint32_t fmt = format->format;
 	u32 val = SUN4I_BACKEND_IYUVCTL_EN;
 	int i;
 
@@ -236,16 +211,16 @@ static int sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN);
 
 	/* TODO: Add support for the multi-planar YUV formats */
-	if (sun4i_backend_format_is_packed_yuv422(format))
+	if (format->num_planes == 1)
 		val |= SUN4I_BACKEND_IYUVCTL_FBFMT_PACKED_YUV422;
 	else
-		DRM_DEBUG_DRIVER("Unsupported YUV format (0x%x)\n", format);
+		DRM_DEBUG_DRIVER("Unsupported YUV format (0x%x)\n", fmt);
 
 	/*
 	 * Allwinner seems to list the pixel sequence from right to left, while
 	 * DRM lists it from left to right.
 	 */
-	switch (format) {
+	switch (fmt) {
 	case DRM_FORMAT_YUYV:
 		val |= SUN4I_BACKEND_IYUVCTL_FBPS_VYUY;
 		break;
@@ -260,7 +235,7 @@ static int sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
 		break;
 	default:
 		DRM_DEBUG_DRIVER("Unsupported YUV pixel sequence (0x%x)\n",
-				 format);
+				 fmt);
 	}
 
 	regmap_write(backend->engine.regs, SUN4I_BACKEND_IYUVCTL_REG, val);
-- 
2.7.4

