Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C58C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59328208E6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CMihAh+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59328208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933377AbeGJNTd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:19:33 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:35472
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933132AbeGJNT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK1lpmrp4yKkCqYw4d9IGS/He7wYU2QgAJnt9gBcRhw=;
 b=CMihAh+B+7F5c8Xdu8VpUlbYoPjlw34gRAefiZMPYrB/nu/NnOXnl4vjX2lbUeeTx0/XsRNV+WZU3ZMWGbRBdonRmS12qxqtnaIbjv6gX+I2XTGN3T1s109szeKKKmMJw48uVVXkXmSFyts1cl21ADWVU1Rg3ayXCCxcGWpPuCs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 DB6PR0801MB1384.eurprd08.prod.outlook.com (2603:10a6:4:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 10 Jul 2018 13:19:26 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [PATCH v2 2/4] drm/arm/malidp: Implemented the size validation for AFBC framebuffers
Date:   Tue, 10 Jul 2018 14:18:55 +0100
Message-Id: <1531228737-5450-3-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
References: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: DB7PR03CA0037.eurprd03.prod.outlook.com
 (2603:10a6:5:2a::14) To DB6PR0801MB1384.eurprd08.prod.outlook.com
 (2603:10a6:4:b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6752d47a-d5cd-4de9-4ec3-08d5e667c2c9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1384;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;3:3Yu+S4n1/O2848AMbpK+VR4kHI756gmUYBBny5/BIn6r0ND3gODkt569KmxCrtBlVhZ5v99weGyw+YZfk7f2NZK8rDCJigKp7Unx/wp9cYky1XZMEEOgN+OdpvvrQtHNxtjKX3pX8D1Ur6jR2Fd4FNax+RJL97CNqPXZTgAX1H2XoDKGWYmYs49u2G7E1058C/j7J5661f4qUC0XKEoOUPLnUh9Z9MNaNRNXe6d6AtQWB+6ZEgMh6GsYa/f7j/D6;25:7cM1N8XK1JRjWVLIYTGyqo1EHFnB2de1/Flt9BGb4h2eYlbvFFNrqr7SCLA10YsYgP7JRTR8qJwuqRR4ApjHPAlX4etn2yI6Wjj23snz8OPTOxEzc5NGIC1c0ve9VTYvNyGNy8prnAYIeo1UMdziZp38k0XFqWVEb2x9VyKuzFTE0MrJLQJL3xAUCD+KE8Kh0T3q5KIhNEb41jPfz5KrOgd2DS05ZS+JMAVQzKav2SsDIR1iVA1+hPZ7dAV31HGq/bzjC8i0jsYTItEpZYY5mcUzWzBjSzmEePO5goI1kr65dtTD6tEVYKu9PSEC9WfDHVTtBw+k0z2K0CvlQT43xQ==;31:ylrjy0+gzNfT9PXm9KMhMb8s7/Oe/Ds46KlCxy/M9w3aBiYFcGh0vaUhZVutnntG7FzZKIezLugHcCQjTIdZHg5nTG38a1UmxYvGG5UB7olAbBtPwuofedK5AcaSEevYfliNBEyJ9Fj6uUSMTxZ0vQ8yuknwpqnln4RhKucXyOJz4IVOtRzDclakCljPeWgYNZQGboIY0AL0/cQnFNfnumqB9AMJHfK0nRLUGFcanik=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1384:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;20:cZdUWGRqAZ/6n8umHvhhDlnwcHSrs6+5fVZiR5XKcAbJathpHgSbK/g+nk46mdDuFLnO8y86lGyL2RRenMGQWIbnOQSGe0Itm64TBcueHr5TzNYChn9h4SAKoShRXoDzB4N3vH36W4XrhYU0m3DrtlZxq4qx0En1aCKJGtRSHO8=;4:0P5LF1WbCGcSOIklU+/MMbLLJNnf/oLyEdcDzTPrDjsSVUP58I5+zLOzDohaOiTNxxZBoSMRMyBEgh5zaxnbLyRbZbOJ4MlEQ2LrBHbokWTY1rrsIxu9Ka9EsMVa7bMT/b97OP2IY6sA5dHFmxHXexAv2VimvJht3v95OmBLaItZmCHid8Y3Lai3dz3dasmlavmgWMJDBkwgUNUxzWMjLx4+qhBMUooioaNn7elIFtmGv+Xc/2xHi14QmnTQHxj6sgx7q/xyYGEK4PUPRmglkaqSQyxdZlCx6msCj+0L5Av3Xm7rAa7AEtowr2RCFFwA
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13844C0EE7F3B7579704FB38E45B0@DB6PR0801MB1384.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1384;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1384;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(51416003)(7696005)(52116002)(5660300001)(26005)(386003)(36756003)(7736002)(305945005)(6666003)(68736007)(16526019)(76176011)(8676002)(106356001)(446003)(50466002)(97736004)(14444005)(2616005)(486006)(11346002)(956004)(476003)(72206003)(48376002)(3846002)(105586002)(4326008)(25786009)(2906002)(6116002)(53936002)(50226002)(81166006)(81156014)(66066001)(8936002)(47776003)(16586007)(86362001)(478600001)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1384;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1384;23:gEqa97T82yvDSwRjxJuTpXTKDpO8yZG5eB+i3/M?=
 =?us-ascii?Q?jv6kYibS4ftNGRh7TwtcOCljEXR5II2kcfIQHBA1zS8PwryrZLEvBfdIrBrv?=
 =?us-ascii?Q?q1xtxRe14XMajumRT0YiPUyPdFDvGuJxCg+GtVwBsY5NiI4yPTSjVuCjWfYW?=
 =?us-ascii?Q?/Vk0uNNX6lozwjF9D2pPkzZ+gq6CKUcwu0ZN26trChMkaD/5chTK8nqqv2cS?=
 =?us-ascii?Q?diUc9lluWSsY15RgOWq8Eo+t+4iJzSq/L2VBz8eHCyWSn4u+636BMn7ba1mR?=
 =?us-ascii?Q?7uotGYy/HBKVew05p0IJXxHEx9wNnfABK8bSuMFdzBJidRZKMV1uydqbNV8T?=
 =?us-ascii?Q?MbqGb0OczsAJ06V/9Hcwi93iEvVFDWAh9VSPURDr9wLqFCM4+GKx7kFxAiIv?=
 =?us-ascii?Q?bjRTxD7kg+pg3y8QQNITQ004783U4MknOSxuH/w6v0rgMPFLlZ9UlubHCLHF?=
 =?us-ascii?Q?IxHm4LQ9Cja7l1ywb9ox1ktknlj1Qj1mBV4gUFgrUzCEs/L1o+3aD6zk+R03?=
 =?us-ascii?Q?GxlzVVfGTXl6OUeo4hJwHb7RoRfuiIrveU1Dn+TdbToIb1LtefuXQoP75yP1?=
 =?us-ascii?Q?uVrBSSiziUtYWzAefLKKAxr4uXy/1LGn8d/TUqZK9zgm976+xDjUXpAlvExT?=
 =?us-ascii?Q?4JNiPbAZLGU6cJgGZkbGV1poo70yy334bc7I6cRf6kPKQ1B5WhGYjONzkkV8?=
 =?us-ascii?Q?FeYfDFoPJWXHvXcU9oyPgN4FTfwMdd03TgaAZJ6R8OLVyCPJbDIvKS7PvFBg?=
 =?us-ascii?Q?MsERAwuMiVy6Hl8PWUzNLVSWSV/rnf0LurOU9tbBFTG61JPPl9ICgcHD0Y2i?=
 =?us-ascii?Q?TDmVlSknNmLs43uJVE30mAbhK5GD38098Ex7+rnXgjS9oUKUbUgnn7dRtVtL?=
 =?us-ascii?Q?qgv5GR7UDnXkXmtrAZlYuHjEsWzn9ZRh8FKO4d01jB3+c5APudCxu+7bsEt1?=
 =?us-ascii?Q?PQ3N5JWsX+EapvFHzqB/tbareyyrBi/SrjorORcMdG+1mJkM/KalJBFf/TXc?=
 =?us-ascii?Q?a4x25RMHFXU3/kBeK3ic+9lmUjrtavu0gcUtoZoisDZASyL/1396YcQBatOS?=
 =?us-ascii?Q?Xsmxjfm0LNVGy6P3b5JdK1KAt4cs4hAo9pi7DDceAeoS9kmdqRHJVLuD3lWA?=
 =?us-ascii?Q?3ZDgPBakrIf0GiaVIGxQqLyMgeP4jMpNzquswQBBILdsrCVsBFOSxNw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: oT4YC+39vy5U7boiW2fVx7f/DmB67Q0zA2YR7LGnPJ519051lUNy3kVebl0LoSH2WjR6rF+hg9tKcOSPew/ZotLh1u2tdjmvyUekxQ14AezjYJuR5nNsOqjEgJVbscm2fognb88zrITD0lkXZdhb2vh7lkSJqc4JsknomIR+Ry9gRcH2cvJ8uOI2FTk5hYrlSqtM+Ex5OAkD87lU8uLyX2Q1u5dDH3lEr+h7cVnTvjS8FQxh0CaqIBW0/IK/6jbDDHjTqCf4N/0C2+u5+Hi5xDU7MigO81lc3Wn5lTPkozJ5/nYBwToIW1Rdm8yQzWI4/IV1kWGT+IM4CaMnNt4pQKI5R+yLTYSnEIC5te020Jg=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;6:Z704iXmkReH011mLg+R3q9UQKCnFDfNkB7SopCsZSiR8Fu/fAOu38vKnr37HZmT82y/oiwCnjGUMSLug5UgaSRgInwReh95bzaHZvcgmhNu1Yidu7WTWd3XHiRbHDWwSxSNlodVYVoNceNb6cglYuCT5as94u6uJp3Gz6Hbigq80JpzGqAjHFb/fe8bx2xKv+sP0RzKIjqsm1MHvNtZqjEGLsQCFV5D2rrPnGm8+7IsdiOm1x/SpOGugFPYWFngdhBUSrCtuyB5BM56V8LvsBkU/z6x2JOhppfTrRNobb8NEDVyHGyXNpYA8IE7ZqkyUnMKrnnlx93CtnJLzzadKzvEE+2CmX0lsnAfgUaPDrtznP/VUCRDFaGUX/COOzdwllapd5JLPAOupSvSwRzsvDoCqJpX7hGaVJN2u7CANKyYHbAkgtgt8reLuO1HGByasHcsxJqAR3bpoBJoOoD5EnA==;5:pcvwOiRlKF2RxYitB7h6nfAa+BHkKTxZc3UwX/NhkTK/n9LtGPKRRMIryDRYDj2UBFbb5IVmTw/KZjPNc/czcebcvAqa24fMrKNrEUsZB9Ko0vHykmVTPKGFP7zKDXefjVS+dHc32TTJ7PvmhJOqAVug/1CjXF7qCYI3eArlHQc=;24:/q9HgpewPtsJA2Tyfzn9iS5J96hJp8jv1drhfzq2uw+V84m6OFZHJdziauJ1eQT1A6BRrNxuOGLCdfyuzdNeMAM8vLzmxg2F+F904TdG4xc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;7:C9NluA4OnzaF50nYiiSyw5nkeT+44od62Y3Nh0Vexswc7r83Q7VUkVdJ5M8sEUNrh20SdBkexA5mA+CWOYkPXKFT4o+8cpxDa4MDYBdDH5ifm+Jk2W/x7xqJSSP3eU9lcMU+70rV4cDAiFKA1hgvE3Hz3kXSS/fFCBMCW5cjHbhsSboFzJP0zXS72mPX6pCYV5EyrTzhvbu1znVGaFJmRJUbJaF3rIXyza7eUAVm3m1KVgIcmyZGV1AZVJuaF3RL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 13:19:26.5044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6752d47a-d5cd-4de9-4ec3-08d5e667c2c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFBC buffers include additional metadata which increases the required
allocation size. Implement the appropriate size validation and sanity
checking for AFBC buffers.
Added malidp specific function for framebuffer creation. This checks
if the framebuffer has AFBC modifiers and if so, it verifies the
necessary constraints on the size, alignment, offsets and pitch.

Changes from v2:
- Replaced DRM_ERROR() with DRM_DEBUG_KMS() in
malidp_verify_afbc_framebuffer_caps() and malidp_verify_afbc_framebuffer_size()

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 128 ++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/arm/malidp_hw.h  |   5 ++
 2 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 8d20faa..262a830 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -35,6 +35,7 @@
 #include "malidp_hw.h"
 
 #define MALIDP_CONF_VALID_TIMEOUT	250
+#define AFBC_HEADER_SIZE		16
 
 static void malidp_write_gamma_table(struct malidp_hw_device *hwdev,
 				     u32 data[MALIDP_COEFFTAB_NUM_COEFFS])
@@ -245,8 +246,133 @@ static const struct drm_mode_config_helper_funcs malidp_mode_config_helpers = {
 	.atomic_commit_tail = malidp_atomic_commit_tail,
 };
 
+static bool
+malidp_verify_afbc_framebuffer_caps(struct drm_device *dev,
+				    const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	const struct drm_format_info *info;
+
+	if ((mode_cmd->modifier[0] >> 56) != DRM_FORMAT_MOD_VENDOR_ARM) {
+		DRM_DEBUG_KMS("Unknown modifier (not Arm)\n");
+		return false;
+	}
+
+	if (mode_cmd->modifier[0] &
+	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
+		DRM_DEBUG_KMS("Unsupported modifiers\n");
+		return false;
+	}
+
+	info = drm_get_format_info(dev, mode_cmd);
+	if (!info) {
+		DRM_DEBUG_KMS("Unable to get the format information\n");
+		return false;
+	}
+
+	if (info->num_planes != 1) {
+		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
+		return false;
+	}
+
+	if (mode_cmd->offsets[0] != 0) {
+		DRM_DEBUG_KMS("AFBC buffers' plane offset should be 0\n");
+		return false;
+	}
+
+	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
+	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
+		if ((mode_cmd->width % 16) || (mode_cmd->height % 16)) {
+			DRM_DEBUG_KMS("AFBC buffers must be aligned to 16 pixels\n");
+			return false;
+		}
+		break;
+	default:
+		DRM_DEBUG_KMS("Unsupported AFBC block size\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool
+malidp_verify_afbc_framebuffer_size(struct drm_device *dev,
+				    struct drm_file *file,
+				    const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	int n_superblocks = 0;
+	const struct drm_format_info *info;
+	struct drm_gem_object *objs = NULL;
+	u32 afbc_superblock_size = 0, afbc_superblock_height = 0;
+	u32 afbc_superblock_width = 0, afbc_size = 0;
+
+	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
+	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
+		afbc_superblock_height = 16;
+		afbc_superblock_width = 16;
+		break;
+	default:
+		DRM_DEBUG_KMS("AFBC superblock size is not supported\n");
+		return false;
+	}
+
+	info = drm_get_format_info(dev, mode_cmd);
+
+	n_superblocks = (mode_cmd->width / afbc_superblock_width) *
+		(mode_cmd->height / afbc_superblock_height);
+
+	afbc_superblock_size = info->cpp[0] * afbc_superblock_width *
+		afbc_superblock_height;
+
+	afbc_size = ALIGN(n_superblocks * AFBC_HEADER_SIZE, 128);
+
+	if (mode_cmd->width * info->cpp[0] != mode_cmd->pitches[0]) {
+		DRM_DEBUG_KMS("Invalid value of pitch (=%u) should be same as width (=%u) * cpp (=%u)\n",
+			      mode_cmd->pitches[0], mode_cmd->width, info->cpp[0]);
+		return false;
+	}
+
+	objs = drm_gem_object_lookup(file, mode_cmd->handles[0]);
+	if (!objs) {
+		DRM_DEBUG_KMS("Failed to lookup GEM object\n");
+		return false;
+	}
+
+	if (objs->size < afbc_size) {
+		DRM_DEBUG_KMS("buffer size (%zu) too small for AFBC buffer size = %u\n",
+			      objs->size, afbc_size);
+		drm_gem_object_put_unlocked(objs);
+		return false;
+	}
+
+	drm_gem_object_put_unlocked(objs);
+
+	return true;
+}
+
+static bool
+malidp_verify_afbc_framebuffer(struct drm_device *dev, struct drm_file *file,
+			       const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	if (malidp_verify_afbc_framebuffer_caps(dev, mode_cmd))
+		return malidp_verify_afbc_framebuffer_size(dev, file, mode_cmd);
+
+	return false;
+}
+
+struct drm_framebuffer *
+malidp_fb_create(struct drm_device *dev, struct drm_file *file,
+		 const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	if (mode_cmd->modifier[0]) {
+		if (!malidp_verify_afbc_framebuffer(dev, file, mode_cmd))
+			return ERR_PTR(-EINVAL);
+	}
+
+	return drm_gem_fb_create(dev, file, mode_cmd);
+}
+
 static const struct drm_mode_config_funcs malidp_mode_config_funcs = {
-	.fb_create = drm_gem_fb_create,
+	.fb_create = malidp_fb_create,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 41f4521..4390243 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -361,4 +361,9 @@ static inline void malidp_se_set_enh_coeffs(struct malidp_hw_device *hwdev)
 
 #define MALIDP_GAMMA_LUT_SIZE		4096
 
+#define AFBC_MOD_VALID_BITS (AFBC_FORMAT_MOD_BLOCK_SIZE_MASK | \
+			AFBC_FORMAT_MOD_YTR | AFBC_FORMAT_MOD_SPLIT | \
+			AFBC_FORMAT_MOD_SPARSE | AFBC_FORMAT_MOD_CBR | \
+			AFBC_FORMAT_MOD_TILED | AFBC_FORMAT_MOD_SC)
+
 #endif  /* __MALIDP_HW_H__ */
-- 
2.7.4

