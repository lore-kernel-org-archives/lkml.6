Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E42C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482C6219CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aJmPJkWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482C6219CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbeGEO0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:26:08 -0400
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:10752
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753322AbeGEO0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfwRg587UBurlCZXqmdkVsM8Sa3PRwVLtLEi4iLnanE=;
 b=aJmPJkWzl59SDsmIx7KOimS02OWslW4txP79aBLGT7e4glnbCix/MddtHT/eaSokcqNZ2fNkwn+cjwkwWJ+0Ug6Wyrb45sfCJvkXa0zkxasZwR5onlv5b3bz1Y5VpHgqCQwOq6MTVOpTLvczBS/F1nFTu8+Rh1HCeDGkUkOlSl4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 HE1PR0801MB1385.eurprd08.prod.outlook.com (2603:10a6:3:3a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Thu, 5 Jul 2018 14:26:01 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [RFC PATCH v2] drm/arm/malidp: Added support for AFBC modifiers for all layers except DE_SMART
Date:   Thu,  5 Jul 2018 15:25:43 +0100
Message-Id: <1530800743-2250-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: MR2P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::35)
 To HE1PR0801MB1385.eurprd08.prod.outlook.com (2603:10a6:3:3a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a79b5f2-42fc-430f-71bc-08d5e2833c5b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1385;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1385;3:yoGCVmIoZtsNaTIi6FcnVJXOhJhSrHemm8DvYm5YLIfC6GN3w7QHE5YVt3RMRctJEoNX5easa8//FgcOWHMPST644+lunJ/+14HeMIcp/ArfAajKKIh0p8XPtCjnhS5Jf/XTsnQMf4/vxVPekoff3cr5vfe6JBOK2O3O+gx5+RVusOH0CgjEKLJlxUWN2Jvw381V1yMkrh57PeQ84YvncClq7e2r9mWkKt83tUdzIpbfJ9QQNcSvv2XeELwx4sM7;25:3Pr0Bly8SXJKsJxKvaJXUMeBlbw60E8RgLGXhcO5Ib5YrP/a74/Q7El15ezdgsnSCS1NAO1NHAVnSCJQ03qbkeMioeWVt73Eol+jq9lQMxbBy5lol8RSXwRQ+P4IrsdwusnnTJTmtGU+F/rPHQm4gfWFb5fWGgWYPz+mqEBC9w+7UOizh3pdVrYvRgCLlVYdiBafFMdKFfKgCHQLioEinZ35hVZsrnjqqfM9ip4/Z7eEM6k3CVGNrjXwpYXAg+ktemSQdCrIZlXlG4+hFsj5c7h0ohEL+5EYIwFgGLNEb0w7oqO+dZRyrNIZ69pnN3cG2m/9QLf7gQWiDCThzp7n0Q==;31:nWZIFGLQSyKqa8j0Z8BNRK6iN3U6npxDR5p3n+AJK3ZtkzEIwR52QF+M0bQfFSTB5W0NsijklQRDInKGx+w7lRNo4DJp8C96r0/u7boLjgruKAYV9YgTXPW0qYclKMuopHfaQLeAX6BjB6AbJfWk49PGBaoiHGbzhWkMCk+JN6Sz88jKegj9mK1gDivkYAivFm0LvKJ063QgkuQDi616XSPeeOR+1jHzAWKH1qXiIn0=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1385:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1385;20:hmoEQuo+aGSlGR/Miej6lwUAwEoZ3tm3RZJ0CP/5rOnzQPifrZlbQ9Foc4Zr1rCnzxLlwUuq9ZVEeh0QobRiCbEae3v92ffhebNTuyVtWv5hzS1CyMKOYxHRiMjZNxWOXEMnWIPe/6M5EDYK+tJwtDZPsadm5hwgvhYL+zD1+w8=;4:VLBa7e6jhUpUZzi5Rye7tZXvSfUIsloCHzlHxHd801KwzHJL/etppbvgqI/sZMDnCC8yN9rElfFJ3qGD30T45tf6r/kjLGA0wWfuhKoIzFvFZHG3i+xf/W1ZgSPeCXqczGUlrtRteo2zQQ8HEFa59vGVwrTPsLytgBUKgtsrXDtnrM1u2fcAFt3KnlDuoIBsKQdAffJUDqqIcZIO6pKCt0+/IrIbFshVMhcntFJLTB+Gzxrv6OWKejlfdBqWyQKyrKQs7HLNtPFOvGRLOKPrqM6rEsEm0Fc9CbGzNAHf7WsbzGfjTTThEB0+t6e/UodT
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1385017A6BB1A581EC31671FE4400@HE1PR0801MB1385.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1385;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1385;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39860400002)(346002)(136003)(199004)(189003)(81166006)(6116002)(3846002)(86362001)(68736007)(45080400002)(50466002)(48376002)(81156014)(5660300001)(7736002)(47776003)(478600001)(66066001)(97736004)(72206003)(2906002)(6666003)(305945005)(8936002)(16526019)(51416003)(26005)(316002)(25786009)(52116002)(16586007)(4326008)(956004)(106356001)(486006)(53936002)(476003)(386003)(105586002)(6486002)(2616005)(36756003)(14444005)(50226002)(7696005)(8676002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1385;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1385;23:GdUIaOpdChGNF45GMV/6vBIeS/fsN/qufB7MewF?=
 =?us-ascii?Q?fenSxVnFnjqLdEW+1S3TNAGHGT6NQU+uquUWPiCNEhwpsgrMlDJTYVKnFtC5?=
 =?us-ascii?Q?kTJB5CfGuzIuzXfOJVmuU/UG1QKy8+CdrUwveT9yQI8Uk/UwsOGHiJ/yYsYM?=
 =?us-ascii?Q?cP97I1CzqxBqacS3gp8gR7ymgLLO/LNc0BzTBXj3aWbcilSyj+vED5S/yWJR?=
 =?us-ascii?Q?I3CAz8jcK5FgUTDf26MjBfEuAfSUgUZHYEz9p5BoAk+v0oJDRD+bXYOPfBN4?=
 =?us-ascii?Q?+jlbJA1KuOCIlOO4/qlfg6ZaHR6D/AVeVex+pvVDWE5snAAflcqw7Prbu260?=
 =?us-ascii?Q?J4QQBty7k7cY4+yvVDEIwKU6ww6P9eRizdfeVkhY857UwIuEY32i6Oj8dIA3?=
 =?us-ascii?Q?04XYYgECTXSoZqoyK3IfvBfWqLHoFtPGwxLWQbx2joRNLAxxwu674rH6SzCV?=
 =?us-ascii?Q?sReUjg696i2a38An433bv0joaW0bsGUh/y40WsHerzjHz9Zs/ShsuWxAlRUe?=
 =?us-ascii?Q?lL/HLsjVB5Z68YXC7pNx8gh7Gt3jurnaVWFGi0xQxjp2di30t92yydezIr3G?=
 =?us-ascii?Q?I9I7NMC2EyzdZgGfgHc1k5WFHWRMMo3vboNVIbWLsJ/pxDJxh/6css9aM+km?=
 =?us-ascii?Q?ozZsJkwG6warwdf0qMPfzXbuVLk+JxYIcYEr0RNKmRjnjiEI/04mrF4Tw7bM?=
 =?us-ascii?Q?ejlzWd93PV65Lfvr6JZqTNWtI2j+mF5XkksoqwbhR4gR1Y0EhOiZGy7guURi?=
 =?us-ascii?Q?v1LI2FgvNqyHMHKEiy8C0VSTi3GI0JfkfwJthXFIrzA9MHLkVbuAfQWlg/Ig?=
 =?us-ascii?Q?Mxa+FI8AruNBde7vxANzdRv5ZqVUPYnafOHADInkqjH97PQhGNyHki3cxsVH?=
 =?us-ascii?Q?xr8EYQH58CQU8qBB9MofTadJKosB8KQ/WOFLxSVQFrybQYF6NGDv9g14qov6?=
 =?us-ascii?Q?8gHTPcgwVNOzEezhhAn5XLWgqmGn0eIqFnz563MwVuzQRv+7pbQumwEwrDUF?=
 =?us-ascii?Q?jTtT4fDOzfTugKbh6vMGKJ6DjfIq+BzLGbsneMC0p8RjvVwBpjVInE8C3s0e?=
 =?us-ascii?Q?L+1fVqbenKy0h7wvf4KbrqmZMe8BPBOXi7oUkeffZXyTMt+jWCyeRJYR6XK9?=
 =?us-ascii?Q?3dbIvnNFAyRVjSdmlRw/TEWXgQyXxP45f?=
X-Microsoft-Antispam-Message-Info: HabHcLrfNF/iyMOWIi6LykEyvD80/VZRJs3Avgv5x0UTw7VJ5in/T1TK/3fH8DKj3XYYaOVuDX46Vi+6/qenSc2/zIrhZ3mxfVez+ntf0Ksf6eDQW7qho7I7YwyIdqUQqWZpDXMcqBfDWVgB64VBQakM/fM6/dZ4p7IFkuTswj7/NCW/2tSA8J8yzC6xrhGLG8Yaa95JqoOJCwSSADMXkG1/B10CIJJQEy3WDz8XjlMor+73p+q3Y1EvyKAi8MeDPDv1P8AV2lxcksQDUfg+UDUjDtf8E87i+unlQ/KAMfQ761MMqNFTkjW3g+SspjMgZ9gtCfO2tt47ESWefYiGX3c7MJ3D5UdN+DsL68pYlSE=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1385;6:2PCoZy590yrTeGOOuEBaKBaRDpY3WwafL4UjMefCIOc9CTRgih6KRo6cqdfW19RfPYq5AqgJO43NNizYUDucjN5+cDkTIglioRaP9wwwDp8XqrkS7C8XI218c1691/7mU8pQ3ITzP4Qghvh+c3NULzlsS9T5iJIwA5iuWxVQNtHzUrzr2FMgpeSxyFryH9sst2m1Ua1sr+euxvCHbgLPBKTtacy55I3prIUtUSVI2YJjdBJ77FwfHSJu20371Zs12WgdwXgiKl00L5XVmgfsioxLhTSOL2sSQaw+7StnxjjO1OoiaW7d/ErOOeX6CmOO+3R+gcp3W+dNj8grN2ndpsgT2X9/P2qcu8ItdH0YMZmOxDm63vdvRBTXncrv4SVcwdNvLIsUWw3X/P5/KSucb9/OuIFtwsjCtqxb4EimTaoSbEOgnNoYKt5B47Ok7MUr82ikoNRCM0igXJmqMdU1fA==;5:rQgsDajWAP2tuQYWzb3kqfIdQ5ZDimRXhTjUr9EbFUTeWT63vvI+gZDeJfFfhigy8d9U87LrlTtT5tWF6yXPLNAE/IkPx0HpbCd/kuYEGqsNqu1UAVanKpJrJyoRK8qXkiGuRJ67NIPi/ZMp/xMV+X9IxDmMFrhqyzPonB1VPxA=;24:eeCsDwGQfq1jetFF2pMpDJsaITb9058xYrCxLx51R3Pr+rsjkRrxCuH+O5GlphA19dHdr8fh76N42Pw4N/KP0PnZzhGuS0keErxYS4aw7yQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1385;7:eKf0McyZM9SZlzuK+5e5NMMeGr03UD8nFA+NGy7Hpmnrr9cBo5PhDjBPHiL9Gqz0NsCw3+yF15EuPYlToOzHxsrmVCtVqkSuMd6TwoiUjOZSiIVSI564YUiVn4vJAYGcJykHcOuC8d9VvLIN6bn6yM8pAFEh1X35SBqICx67MaFOOjMyJkHVWqthZ8KPMbdGbZaxJhfBgG2SV0Qvwy4IqvXyYDhvczCxVd7v7Bz9+ZfqdBoHxTWii4Ga0U09IFOw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 14:26:01.6656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a79b5f2-42fc-430f-71bc-08d5e2833c5b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On planes which support AFBC, expose an AFBC modifier for use with BGR888.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Changes from v2:
- Removed the gerrit change-id
- Replaced DRM_ERROR() with DRM_DEBUG_KMS() in malidp_format_mod_supported()
to report unsupported modifiers.
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
index 3950504..914cc58 100644
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
+		DRM_DEBUG_KMS("Unsupported modifiers\n");
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

