Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7DBC4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D952208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Fz6I/PyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D952208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756259AbeFONwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:52:36 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:24662
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755645AbeFONvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCQusGnGX1c055jXHkvQTIr57xmWwv1KVOKWzEmxyzI=;
 b=Fz6I/PyXhUUde1TAgsH0ELV2OuxfrNcAr3SldJVaVlvoIRSHUh8gpy9KVv243qIV6iAOn8hB7GeaHkVE+eY1VyK1dGScd5L4mrSBL2rz6hBQwG7+89z+W3QdPxxprwU27lJ0iofrVIxVzl3rxpT0VNz+QbAV9KXrjEsmhUg3dQw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1378.eurprd08.prod.outlook.com (2603:10a6:203:1f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Fri, 15 Jun
 2018 13:51:46 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [RFC PATCH 2/4] drm/arm/malidp: Implemented the size validation for AFBC framebuffers
Date:   Fri, 15 Jun 2018 14:51:32 +0100
Message-Id: <1529070694-21088-3-git-send-email-ayan.halder@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c923a2d-de62-4dc2-3890-08d5d2c722b8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1378;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;3:P1kI6Q3s09W/DQidDXgDA/k0lEAXj0NotS1teE5mnkbUncQBNo9o5XABxpb/gB0G+SHn1qjJ4KUeTWm7BOzXR2bv3u5zEQn3SDryeewbATdegXeTkzcO+FPleHdOS+hjMwOL9d8DyQ36eVdeeEO07DtqfvzXHJEQXT8krpVEdOXk9uMLquVpQ0IMaeX0dWvBvrJmjtl8QBrW+rt/S9TcRFyn+iTAgezXX9p108+ceJ4IAXgYiA0ZRq/XBUUDOOOr;25:ESZ9rAwusIimKKmtQKU7ntfIQEY6N6F5LkwS3/eYZXppVJTjD6mO8jVMz1/6KSobzj/Ju3oSNOO734OKXGKRY48gYv/Mxlf/NtS70NIk6RDaZXyDA78YZhgor52d8voZBb9OFln91bfA3JO/zCYVoL/h7UTrwcwTLitI8IWx6jHpIFBB/cPQt5sbwtEOWKnlmJ4MD/EQ/VVYxREepYckPzssS/EaqAwphf9nIcKm1gHey1Chbc5v5wyL390mBx/l7clRr8e9GVCm+9cWnEv1XDauLKi77HHz+zcMLCwTASwkDvbp1K7TTfH+/VVIXKOBljOUUyqzybJUCWbnTddoSg==;31:octW5fxLTQ26TPURMm194+wFfWTNZXeGiOi8qx0g86vQCxoaKc+wDWQnO7ziveLTkjLj32mhm0qiuUdS8se6PMO4POk+2lhukt3jYfmHq+fS+gmPNiJT4Y0xsCRJht9hFoKY2cR9qXqve/zm/M8h1LxhlcyCXoRleQc4BdVC7tB55Cx1rngXx2pgZg9XStzuN6vvxg4tmTKHOeLPlrD0cC3YAlkdjmQ4eTcaSfc75z0=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1378:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;20:pWnmUQpCA4HB55VaAWtRxzp/sufp8fTkMGtMu+viqN1NiDxNxODxLrgY7BTtMFT2kSRhG1IMMWAFEORvJ1HUXtgV9kt/SVc6/PHowT691jSQDAJUNP8rbrmSqpiJ5TUW2Sjb+AO7LPJOaX5HaJOoYskzE9Md1KffWMBILqkl5GtV5lQqQEC89pHfG/nJRSQ8cTVZ4O2GJkhf0kg9MZmZcMQsjDG1bEj6x16u31eDtEOOt3N6Ro5vBA72Th/p0MLs;4:sb2HDVAkdWa7NfzdnvcS3aSN+dr01Aw9BxEEUlFIf8ocBHC/lAZ4X/dWmuYNJwIfBVXZR+U7Mvc1/0PRKWfRLtSRVIM3FrYwMz7iB/L3Rw9yWF6y80nJ8AIxadmHJbSijNaCOfnMVDyQc8BOwjtbEoOzXHeWg4WoQUBeyVBpBeVpZeUAq+pn4EqcojE9wln9NEuyQ4SY9t5xg45fwtEgTC4/iAEzHlte6QjOG29CgYcfWipxSdlK8SyzcSW03OIedjdmGy570vrXoB8/rjU3ShRAbbNxhaB/28E2yZvr6azHM3Q15sq48cuM+x21tbF4
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13784D6E5AA5211A085291B0E47C0@AM5PR0801MB1378.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1378;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1378;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(2616005)(2906002)(476003)(5660300001)(47776003)(8936002)(76176011)(97736004)(7696005)(52116002)(11346002)(51416003)(7736002)(53936002)(59450400001)(386003)(446003)(486006)(66066001)(956004)(305945005)(26005)(3846002)(6116002)(50466002)(16526019)(6486002)(478600001)(16586007)(68736007)(48376002)(81166006)(81156014)(36756003)(50226002)(4326008)(106356001)(72206003)(8676002)(25786009)(86362001)(105586002)(316002)(6666003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1378;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1378;23:8KtnZfFKxhlMjGh6sfxfivdQIuEvVnzcziF9BcU?=
 =?us-ascii?Q?7IHL834tsW8lDgiFnLPo5GLoLbguKcVdFNV5mDsKosp+Vs6ehj1hIk3KGxcZ?=
 =?us-ascii?Q?/qoWzHNZnMAwF4pgsMI1COChVJflq4cybJZEaedRVqXSBvk+tjReY1J15gJu?=
 =?us-ascii?Q?oiebWT0s0DdYrY7QIyg7FEjj0jVtJi+K+gM1pq945vWQrby0M0VeDl8fjIi7?=
 =?us-ascii?Q?pIgWOWgnEVyvzx3ZB3LLM9facRVfGiuGpujUu6xEP3AcykHsa6DY0rhA4LXW?=
 =?us-ascii?Q?Pr1FlxY+hprK6Ytv63mkELhDzOSmcr+qEBNrlFiQDY7lr7XDHKj6YXI/H6ii?=
 =?us-ascii?Q?LRG9ttcNUIMO4wEUBOcOaHtoSlpCUt3wRdEjzz6AWVobnya4dXMshG8aRxkJ?=
 =?us-ascii?Q?HIW99TvKtvb5A0+15G3y/bk5YZxpw4wlJDcA8qtKJrbPzR/2i1KHuC3KLUwD?=
 =?us-ascii?Q?bIyGRWyFfErMXhQQu4MI3p5I411qfglKKMtKZ2KGyGoL8p98uN01S9CEYUbd?=
 =?us-ascii?Q?/qVJCbhgI3LmDM37qA8QoYvBERukscuTLnvjqevUsnYytpOWVyK7iJRc3n2k?=
 =?us-ascii?Q?n9P5x5xJDobA2xRK/DCcfpieTwN1LRFjWFCAzzwU7cFcJp8pnDcHxdi9teN+?=
 =?us-ascii?Q?IMF2U4iWPOHd9uXS2T5av0GfjJM6q9tyTN186qNKV41lC7MTHOxO7tXx9BHf?=
 =?us-ascii?Q?tdjBF5LfpeP2AWnYqEaw0xvxFMb15I26F6Z92YAb7oRSxlHDv53T7O03RqhT?=
 =?us-ascii?Q?7MNpnxAArTqD7f6Nhc1bpO6YjtZM12V8rf7o5vSdT428JbAzr1+7AUanZdem?=
 =?us-ascii?Q?RZc6XcEc/Z7j+jmC9DLKHGwIe/GJwXN/Hf+oq1hpXNT/DklBsYe75sMce2qQ?=
 =?us-ascii?Q?b4+h2G83a4zKX2JhWtL7LmxPEvKfYXXJXAdD7mmrpF7FxQNqvUixRpY/xUm8?=
 =?us-ascii?Q?4iB8ghr7g6VRgZ7GYVJGqPZud84r7aOmaO7CPQoGIClRlG/DUDHkefEWfhW2?=
 =?us-ascii?Q?sJeZyz/Q2mgEWm2HvK3fqOnzJVVIeH/Yk/ccTuk8BC+Nk6X1cC7NN8D5hQdn?=
 =?us-ascii?Q?1o6e9S++yIlL5A9+oGIcow7Do0c1rmOSYotvErts2Ob8kWCDC2c8PZQ06Xu0?=
 =?us-ascii?Q?yf1tHyVeVZp5hCo1iyghyNGczEKTCBWa0aZ2CQ/bd138muFxQ1pD/F5S2Clh?=
 =?us-ascii?Q?C8WAM6pD1o1mjD0A=3D?=
X-Microsoft-Antispam-Message-Info: uwef1QAXKaDXjg9NyTWG4bY/C4jWnnLx4kIGOCIzhIcvPJt5M9WZpwRzM8c8N8WuAtHDvDROu4yw2qcqJM4ECl12eHQ9/jyzMq7R8Z9Zn9Ly8gED+K7LD2y+RQ/dmgBvUu1ThpYZYbWLzArPHl/MtRW0WtyKzO9Cbe6gFFE1KmKShaqshkVt4yftyDDUm/fh
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;6:RqjhpshFChJnGcdMfNbWmIIpzOAYRWhHc8c6KZSdiIJGtaKXCPdBKqnnKPlVJujPyLtfYwqxSqL805kkat1gvWdlaLiXR/yvUW+dQGSQVQ4sjOpWmRZjq3+e/mBLrPJelSYN1QNDBZpgBRrv/tyX2VAj4WRSrDJAqP/9zKa10EwsmXU4jK2ZCuXsQtjbgt2cWTXjQyJlbhl3fsHbAv5dWjbvN4hWh1UUGqhelGz4uL5PvzNcOJ1+2g7t8W+NUjlCVLqYGOgiA0CC060PXdLk9rqHNcSx87XlYTN4mREqlgmcKYrLJUkr1c9AJNFPPYxKBhvnZftzeKrhDT7X06MwgI/Gyd4JFOOM/WpvNWy5bZD+d7odF+rRq5+lWYXEuKb5xOUQYudQxoAJhyICbwwYlX8LDmeGR37ZIlv8nKO29yUv8OmuR7Q2d+j/O6JK+XAJuCDRiDisrGrSN1kA9d4i/w==;5:fIrOP1E53KhBOCf/W9bj0QUEhnPrK7YpfgNWi1oZ/cpSwVqBXwBLrET/mJi0SpDpVDLP7ERMhK6tG4jXWjkoXRdIoxFbwpqDDN6yjZcVwYH/ZwcLlpGK/KNhuWpx1JAe7LCCuA7Om9r+evScCDuq57bp/zzyqlxhRj1i+igafUk=;24:/MArq5sWARsrav46N8Cb9Pd6F6v+bMEkNQL9W3cADc3Aa2k2z6Ix1mryGuIwFXqFDEQNbG9Mdj+ssd5hRQRK3i3s9dghY8IB54wOyncyKe8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;7:jbxj0zUEif8xeGmUzGq+UVui2JGKU0I8UXrUJi5j+ktZow4ga3cFGCh9iicEszibUi0E003vczM7GHcI+6+nxiTjikRn/sPVNw/+v4yzaVU46ou2l4cOyMwIPbwP7C6CwoRpIGa1XshBrRydn9KPu4KbhDA+b+Yoc/E+ouvjkYJKUuc/QpIGb+JdLNKs4sw2oaFB9XAewaIiJ2JBuejNpS12tZfo0qJPwhYXOJP2/27Fo7TzEpN3rvBU7Bx/sO+f
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 13:51:46.3674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c923a2d-de62-4dc2-3890-08d5d2c722b8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1378
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

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 128 ++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/arm/malidp_hw.h  |   5 ++
 2 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 8d20faa..7b6a848 100644
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
+				       const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	const struct drm_format_info *info;
+
+	if ((mode_cmd->modifier[0] >> 56) != DRM_FORMAT_MOD_VENDOR_ARM) {
+		DRM_ERROR("Unknown modifier (not Arm)\n");
+		return false;
+	}
+
+	if (mode_cmd->modifier[0] &
+	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
+		DRM_ERROR("Unsupported modifiers\n");
+		return false;
+	}
+
+	info = drm_get_format_info(dev, mode_cmd);
+	if (!info) {
+		DRM_ERROR("Unable to get the format information\n");
+		return false;
+	}
+
+	if (info->num_planes != 1) {
+		DRM_ERROR("AFBC buffers expect one plane\n");
+		return false;
+	}
+
+	if (mode_cmd->offsets[0] != 0) {
+		DRM_ERROR("AFBC buffers' plane offset should be 0\n");
+		return false;
+	}
+
+	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
+	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
+		if ((mode_cmd->width % 16) || (mode_cmd->height % 16)) {
+			DRM_ERROR("AFBC buffers must be aligned to 16 pixels\n");
+			return false;
+		}
+		break;
+	default:
+		DRM_ERROR("Unsupported AFBC block size\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool
+malidp_verify_afbc_framebuffer_size(struct drm_device *dev,
+				       struct drm_file *file,
+				       const struct drm_mode_fb_cmd2 *mode_cmd)
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
+		DRM_ERROR("AFBC superblock size is not supported\n");
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
+		DRM_ERROR("Invalid value of pitch (=%u) should be same as width (=%u) * cpp (=%u)\n",
+			  mode_cmd->pitches[0], mode_cmd->width, info->cpp[0]);
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
+		DRM_ERROR("buffer size (%zu) too small for AFBC buffer size = %u\n",
+			  objs->size, afbc_size);
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
+				  const struct drm_mode_fb_cmd2 *mode_cmd)
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

