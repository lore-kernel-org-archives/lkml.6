Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 231A5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F4A208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lLAg6Xxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F4A208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756223AbeFONwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:52:02 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:24662
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756186AbeFONvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGC27K9kmfDInPkYHY+wKgQk8Ri7WCCtB6Btk83m2V4=;
 b=lLAg6Xxnh7eQbdYEeMGd0QjMKDxdMil5CSeDlwczvgXYJiWsNA9/wioyJtquSTpdT9FLN7adUWmbKe3mJKmwHaAG450GQ+Kts4gm+cKnkRTuZZzFPCyKFOaKTw2xJuNBF5XjVIxFsSzzmMIdv0Z1O1JOgdUBdor0gJH5tG6Zg+w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1378.eurprd08.prod.outlook.com (2603:10a6:203:1f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Fri, 15 Jun
 2018 13:51:48 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [RFC PATCH 4/4] drm/arm/malidp: Added support for AFBC modifiers for all layers except DE_SMART
Date:   Fri, 15 Jun 2018 14:51:34 +0100
Message-Id: <1529070694-21088-5-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
References: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: LO2P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::15) To AM5PR0801MB1378.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae5bc29-f834-40d1-f4e8-08d5d2c72408
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1378;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;3:vBr1Ki/o2RbDtL345UcjbPyzT1JFUqsciIMYDvo+8v5/clL2Bj/eMPJYgt24W0KRplYzODl5xGZthFm1nUE4I+55bfnUb0rWzMQmmkDNyCQhKYtciQJ7PEC2TtPCmp2H74cXNLHQlrFv2JG/1AlQOt9zd5xV+exZsUlSfd8yR0zXSTxusBxJahXTo+IckjZoodoZpfVWyyjgJaQ/IRDDOa6HGUl2XIgUUH20Dw3l58XitCQAnbee0q01Gp3DhKNz;25:Ml1emqv3YBFaKCmwLCMEDbhT7p55rk+MH1a/sGreHdYS2GA8BaVqIctjVmL6p+MXqHhHJfotTifCNEMdlxdIHQMbw9zDQSxf7h5czz4i0nPU5gX+wO+rMaYboTMCF4xl9Q7lW5XOpVTOIrxYxhSDg3gyHSkl3+qjy73Su9o3TF4EFMvkarCmiJIwpbadgKeh13/2xe7EHHhKv8ZX6G23oSiMyjxwT1VbAGcPJF4ixNi20UyK5zI6xkqODWVXazEzTO3nQYzxcebgBxpWjgdcwqiJ4ugmrkzfgsscbq8HQC5RUft475sikHfPeCO7AET9v1VXQQtycrNdPjo+VSfmjw==;31:TQMyCkypfDFQ1DeXI2l5e7O2/Cto+ShIfjr/1rufejxnpPdDxGKeZLFQuurajNm1zzuuQu7JZfTEY3cYGuncPv2oD3CPZkU++WkZxVcQvqqKf3hGR4JoWdfvD1qy+ca/hgbholTA4fl40G6W59XHBXp7W0KoaMOjGemOP3MEiz7TFtloR0gRNddhezNfsXzkMX/8xVHglYUQNX9IFw7O1MH1khilNv/l99sTffPKg6k=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1378:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;20:8PiIszJpYHm1Nf+FxiI0WenZcq29Xm30JeEqVUx4qQNydWnBriWIsXVWua8yQTyYbmLvbIN4p74KhI7W7A6wDk/NXgB9LPaJsnjpovUoqc1bWSUiDXKqpgYT6nv7mpSls8UX8Q4VxUV1sQhtoeGg3J3YW/yJLpOcnH3c//jOcW+Ftv1Z4LA8H/cJ7MQhIHroGpCznvKtYUFR07Ow41RUsTO6O2qJxe2Fdd0OlxbZbT6xKskJB1ZndOpmY/Iobf1t;4:X9B0WLtaAI4kQr+3oK3oitTkyO+C7ZpJoeQsusVtpXfqmHvmTW0q6/WBoAKeDjDnARI5KelI6gewhMoyT4H5bvcl9NhHvUCwdHQUXsC8RonxANxohGIoxRUu1lNVrrmF9g0vbjgpZS68BCVaWtmsBs1eucYMw4tD2K45CKQnHSBPLDxxtyZr9lzmtTTI8AVmwihyRU9xIfuuQlYzamqVMHkds6uy2Z6N015y7/vHjvNqW5BOiAt9XsMM2ZJmsAdM7cY5J1nSzpT0pfned1TBZGigpnBwxlk+IrqtlLZYHl7YD5B3R5GKPAp1k2C09TYB
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1378B301F3558050228CA200E47C0@AM5PR0801MB1378.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1378;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1378;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(2616005)(2906002)(476003)(5660300001)(47776003)(8936002)(76176011)(97736004)(7696005)(52116002)(11346002)(51416003)(7736002)(53936002)(59450400001)(386003)(446003)(486006)(66066001)(956004)(305945005)(45080400002)(26005)(3846002)(6116002)(50466002)(16526019)(6486002)(478600001)(16586007)(68736007)(48376002)(81166006)(81156014)(36756003)(50226002)(4326008)(106356001)(575784001)(72206003)(8676002)(25786009)(86362001)(105586002)(316002)(6666003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1378;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1378;23:lYYk4EWUdzrpxoxZuNCeou8grMwcTkGV0rDLloO?=
 =?us-ascii?Q?zFUJrNHs7yUfZTWyLNPt2NNcfkbr5jbI0qFHlfvmaxWX+rRrq/6ajNRQmQyi?=
 =?us-ascii?Q?tYJFQJgmQ8HrPkTJMBB6wB6WYUqJMmp2e6UsXWstXkuZQSLP3lQraxKmLwcC?=
 =?us-ascii?Q?5ZHFQbo934ij7FnM2dhD9RSpsTaHRkxhpv/hPNUb9udl3KYKs0mAP9btm9LU?=
 =?us-ascii?Q?gOrFLSCmoabkApgFBql72BSceKf2bvObyRL71UsG3Ho7mOhOlqssvzZLxf/5?=
 =?us-ascii?Q?9bzrj3zsJQbuMP/5MQG/ZoBVsylVG3trtmfxSz8XeFhX3oT2ukkzQdmeouJ4?=
 =?us-ascii?Q?kgHEY746Kf5olqL1maBkit0u1ZOuMPKTBirnzh2eoSzMo57ILq/RRCd1df2e?=
 =?us-ascii?Q?MjZLrlIEVAfq/hw1QVp6jX36+shWPqUP5fLLQBLqEIWY9jl3MqxaStZZPW1c?=
 =?us-ascii?Q?hz3MM6Pcl6ibxmrkhHs0aFFjGV9tmmuwHE5KEKSscih7MVDqCkFVsyFhxsHk?=
 =?us-ascii?Q?eT7FGD1ZO5CmTys6WRjiJ4+MQwH3HZRWsGneA3W9JBtbAmj9MmnbFz5j/uPr?=
 =?us-ascii?Q?rB/cAdw2lXWMUk1BQyS7rTZCZLd87txo+p1G4jVZwC3qgrxzxVbLLk3xDmzl?=
 =?us-ascii?Q?rZ8eCrkZUzNECZvf1t+cCVipNZOybhpP+2Bp2dbzzYrHzLB5DHhO8hzluDww?=
 =?us-ascii?Q?V+6Mi+AA8czF2ihErjc2X+7k4K7RmHrEtPURtOlt0/gbFEHaMjx8OCMv1IPf?=
 =?us-ascii?Q?MJKIiqDNEo+26eI0OyEZfeyCsem0DMTu8ulbq2cR3lpbRdBvYQt57fb5yotd?=
 =?us-ascii?Q?El1OV4kkPhs60reDmE7uzBHR2eidAsj6bY7spYzFtzQkI1wYdPjU2AeTWy9v?=
 =?us-ascii?Q?ZhiUS9zMJGoIodZ+CZDPJeSucaJXlqwosxSpbOsCGrghYYt7modQNI5Zsb8k?=
 =?us-ascii?Q?UZ+jDqPbfmq9jNg5Dtmt8oXlPch4R6/1+Bq8fuQ85Kaxi7QeDxlR0SaVTo+3?=
 =?us-ascii?Q?KEx8qrF4yxlVaJtsO4PU7dIALh9XAA/+66+SzMJ6ae+tNW9TwUQgHfE2J5LS?=
 =?us-ascii?Q?q1BmYa6qIFvs0jmCMIEjk9Dftu/j6HYxdwAY9ZnIgg96fuZJClCbJszdbStN?=
 =?us-ascii?Q?cEM007zTbB4hI/HtnaWzzIM+ikYPhNtLpeFCNiFLsG3YXRFYX2n3bLhm60xk?=
 =?us-ascii?Q?02x54k+5Z4X1iTsYG7R20PmFE79V92evS+ExJoe68ZloCqJBRPVP6YFgXWil?=
 =?us-ascii?Q?YYgb4CQINL5ld07nQvAM=3D?=
X-Microsoft-Antispam-Message-Info: u47Xm3Wxr3jknFquXMrxDPAkK7oq1wCwpLpuVzNVjysYz1RAmEZV/6nSfegrvsD7yMJN4gn1kswtWsex6vgndjTrXnMtDL1Q6kkB8HpmUtms6DzdCglTgQ3ZS1hkPM2AjOi3VrvUzlsraDoGokW6WAu7UMpZbfsJoNfgqq/b7q3ecKS++iYx+dZbqY5F6YfI
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;6:cFzMqyKpKnicTiEqT3aAIWB2LgUtfUXTFIjh7E3vZfa+xrD8GhdD8IUVhNY89OvpHk+QptNZMag/JMvRaLabAo6Gs/Sbx9WU0+M38Avxc2VbbtGQ/UaIkdwYtlOYW8Lh/rUOnQY6RrhUeF4XamOzfssnqswnRpWNp2HZYHR8LMwzViz6s3Zl3GhtDQOLlt/HbBZlAC26G1etPTv3U9QReGc47sOC3uSLqoL2NqV5s4C4kD2E7ZN5dhBdN0xKzKXoV7ziPZeAU2VNIvGYljaVvLUMepWvePw5YKldssTEFIddNm947QLbgBmgI40Y0AL8xe2GXOBaOmbeHqw1UxqH92iAYauOArE+M4vKBgGlFjsbaXXrIqTaUI2ySRVyABGghqOhH/9c+4hKjCQHmkU4XZD0XT/GzTfDHVpVJ4G/hOB8swrbRdCaeDORUxaqLb6m29VMj3BtUncWmY/lOLyipw==;5:syL1wJqYnr8HTtQXCXqOQMOqXQgT4pANUZBMgO/w3RA5oaBVK+R+7IVPrOJJF6nRfWy+H1E97QV2imBufBQbfjcXwa52yosj69BrXs6W7XGNcaWDrhoU/4q3az3wvHosonocfjH0oSk8Wlq5I6KLTeO20h/MSLLjUyxeuOo1fNU=;24:XNE5+8LvZbuNN8Ioxofs3Ld64keHEadphRcDHXDcXz8Nm/KgwKwDQD6HmBr7S1hh822wr3dA615MlQhdM1q+pNgpGaAHXwXyAa561oJPASM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;7:W0FCuZSGTHe+C7tRF+pSaORkp4IuHpptB3KmsUgDe+1W7w1D7R5L0qu3121UwAPZPYHEYUXlXdFmXPyvEqp7nCsyet1TXRmVpTE7C+ugMU7a+nHHA564qthiI4+cgXHupbLzx/bzdAT29humUhB1hykqw1NpKuBJ2t34lbvkpx4oVjUSkhXqWZNCBaxlfy5EpA7sLmJUhKf2JD4fEKTGoc2FQFWYiHYePrvoHU9WVO3d7YL5E2t/AAAjIJ73aD6e
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 13:51:48.5302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae5bc29-f834-40d1-f4e8-08d5d2c72408
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1378
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On planes which support AFBC, expose an AFBC modifier for use with BGR888.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>

Change-Id: I4739ff55c0f6d5715b268cb3947ed133a9ee7c2e
---
 drivers/gpu/drm/arm/malidp_drv.c    |  1 +
 drivers/gpu/drm/arm/malidp_planes.c | 46 +++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 7b6a848..7bcd679 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -392,6 +392,7 @@ static int malidp_init(struct drm_device *drm)
 	drm->mode_config.max_height = hwdev->max_line_size;
 	drm->mode_config.funcs = &malidp_mode_config_funcs;
 	drm->mode_config.helper_private = &malidp_mode_config_helpers;
+	drm->mode_config.allow_fb_modifiers = true;
 
 	ret = malidp_crtc_init(drm);
 	if (ret) {
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 3950504..55c9a1f6 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -124,6 +124,35 @@ static void malidp_plane_atomic_print_state(struct drm_printer *p,
 	drm_printf(p, "\tn_planes=%u\n", ms->n_planes);
 }
 
+static bool malidp_format_mod_supported(struct drm_plane *plane,
+					u32 format, u64 modifier)
+{
+	if (WARN_ON(modifier == DRM_FORMAT_MOD_INVALID))
+		return false;
+
+	/* All the pixel formats are supported without any modifier */
+	if (modifier == DRM_FORMAT_MOD_LINEAR)
+		return true;
+
+	if ((modifier >> 56) != DRM_FORMAT_MOD_VENDOR_ARM)
+		return false;
+
+	if (modifier &
+	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
+		DRM_ERROR("Unsupported modifiers\n");
+		return false;
+	}
+
+	switch (modifier) {
+	case DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
+				AFBC_FORMAT_MOD_YTR |
+				AFBC_FORMAT_MOD_SPARSE):
+		if (format == DRM_FORMAT_BGR888)
+			return true;
+	}
+	return false;
+}
+
 static const struct drm_plane_funcs malidp_de_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -132,6 +161,7 @@ static const struct drm_plane_funcs malidp_de_plane_funcs = {
 	.atomic_duplicate_state = malidp_duplicate_plane_state,
 	.atomic_destroy_state = malidp_destroy_plane_state,
 	.atomic_print_state = malidp_plane_atomic_print_state,
+	.format_mod_supported = malidp_format_mod_supported,
 };
 
 static int malidp_se_check_scaling(struct malidp_plane *mp,
@@ -524,6 +554,13 @@ int malidp_de_planes_init(struct drm_device *drm)
 	u32 *formats;
 	int ret, i, j, n;
 
+	static const u64 modifiers[] = {
+		DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
+			AFBC_FORMAT_MOD_YTR | AFBC_FORMAT_MOD_SPARSE),
+		DRM_FORMAT_MOD_LINEAR,
+		DRM_FORMAT_MOD_INVALID
+	};
+
 	formats = kcalloc(map->n_pixel_formats, sizeof(*formats), GFP_KERNEL);
 	if (!formats) {
 		ret = -ENOMEM;
@@ -547,9 +584,14 @@ int malidp_de_planes_init(struct drm_device *drm)
 
 		plane_type = (i == 0) ? DRM_PLANE_TYPE_PRIMARY :
 					DRM_PLANE_TYPE_OVERLAY;
+
+		/*
+		 * All the layers except smart layer supports AFBC modifiers.
+		 */
 		ret = drm_universal_plane_init(drm, &plane->base, crtcs,
-					       &malidp_de_plane_funcs, formats,
-					       n, NULL, plane_type, NULL);
+				&malidp_de_plane_funcs, formats, n,
+				(id == DE_SMART) ? NULL : modifiers, plane_type, NULL);
+
 		if (ret < 0)
 			goto cleanup;
 
-- 
2.7.4

