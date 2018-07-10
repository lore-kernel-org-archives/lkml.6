Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A133C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411F2208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="E10axzWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411F2208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933406AbeGJNTk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:19:40 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:35472
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933354AbeGJNTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/Znw4nUEgKRZQ9teXtMu7gUOyfz7Xj3Jk58RhvcYKY=;
 b=E10axzWhGt2Ngl2rDvCOKuDtZwfR/KUSvloyd744ijlGBzAN8xbmd6E8fjWMZPODTeWSkh162Kp7Jo9/WIhdRPW/tm4X8/Sq6boW3wIw6FCEmSIKkehqGTfYxUFaC03U8IEMXbJiUK7aIjuiLhAXlFXQOzDR3Jas3zHHKIhFoUk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 DB6PR0801MB1384.eurprd08.prod.outlook.com (2603:10a6:4:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 10 Jul 2018 13:19:28 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [PATCH v2 4/4] drm/arm/malidp: Added support for AFBC modifiers for all layers except DE_SMART
Date:   Tue, 10 Jul 2018 14:18:57 +0100
Message-Id: <1531228737-5450-5-git-send-email-ayan.halder@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: fce8b00b-5dd4-438a-a906-08d5e667c3d1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1384;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;3:shMgxN6YobBYwTovnj8O1sRis90si9uHgQAG3eTQ/rAOavArEnVQt7JFHJdatmXyLqhK3mN4ysbp23gi4w31iqNhs6BN57rcwzcI7cMSFocnfH/ltGRgR0n/UQj1jIVZu97UKs+7g/aTLyQuikNgUQs7dO5RnpjETazXZVZUdlR5mbDjcsoJ4xxQaFqEtBHrJws1Mgg8FA4cvMB16CEZ0bJDpCgdEMMKX7pCoLqMBVQMc4i1NUzH4PrEGJ8lrGui;25:ewjFckB/+PmoFWA34WSomSIqHai5buoEwOpwVpEOaCc8p8ML5TlTDBZaIQ4T1D9K2elXxB2E8UUlTkbntulKR72gbD50GKbnbVA2J9wrRxFWI0IqY2OsYBoOXWbggxKl6w/wYgNAirsgZrklvprZLJeEzcwfr2F5GDgfr33k4akZLbs5etT4ifeQdLNmb67cGv3drvXDxfsHyfbWnGJ903YCMoR4rYqG3fqOTDdNxL5QiA/s74CZbirmiRRBcPyu6oANWWNsvTqSi/NZwWY0rU9kNTmqUeZl5QmQ45xnNRsMwQ6LNKNhJLXWYu1trB/agpQiBxe+k02gSfE6sJd+xg==;31:wAUa6cXBn1QcnfrPpSdgkVBEWAS+cWTkjDgfYNZU8vHCCtfW4s3S8ZBNPbIzTzxlBvnL+zr5SFYtkbLg8JXQimmwKd31GD3vlEOLtJ9DkQNSuPDhOVaeKnkLL6lFFOeTURBdb8ACo2oIGu/1355l9j4B0ZeRRaXEvVx1gNnPSzaWVlP7MTQUL84zn+9mthJU+n2dteos7IRcn9F72Ccs9W1PSYjfBIUHcDcGy0feh9g=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1384:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;20:2AKwxARGzH/qILbRX59YiNHZyTUam6A/O5Q3z73aVkaQCyvoBR6UsILQ2L0EoJ91IcTXq/Pkq3+Xa4o+Wupk+cPHchAGq/QUGzEMZVDHnGQE03oLUeNpx5/asRySbMpiIMwtbDlcOC5lefhXw0wSjd3LkVXUZYU0GZL12Hk/10s=;4:1JnSCxcFGwoiPmIbTlkPCqioLjWyHepZ0opRyjGeXVhCAYrO/zPnpH3Re3/2E4xcWjb148KGuQdNilSU8vD+Hxmrofsifr4389Ro4YISpQdAJeCbc7R4l/VGZJ4MQ1NJO65p5ZlfN1vaCANoI1s2q7/svEBEMbu3t60LF3YLOvyZLPkea/0gyUwsvwkYzsdmaDoOJOetgsJt4vkHB9ojQIlFPk/Yv3OzB6p6cY0oIealkzngKYNw3/r6snDXjqZEXcCZ1rPTZYULh/kFpnlgO0iHK48qbJC+kAgV5PM/rRfPXusrI+eOz8KdSIMqTXQl
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13844C4EB0A2B724963C7B6CE45B0@DB6PR0801MB1384.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1384;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1384;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(51416003)(7696005)(52116002)(5660300001)(26005)(386003)(36756003)(7736002)(305945005)(6666003)(68736007)(16526019)(76176011)(8676002)(106356001)(446003)(50466002)(97736004)(14444005)(2616005)(486006)(11346002)(956004)(476003)(72206003)(48376002)(3846002)(105586002)(4326008)(25786009)(2906002)(6116002)(53936002)(50226002)(81166006)(81156014)(66066001)(8936002)(47776003)(16586007)(86362001)(45080400002)(478600001)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1384;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1384;23:wl0yGmIIHvhgIIAKaZDz/eG2JTxWl0KjkSNh2oq?=
 =?us-ascii?Q?ecLRjHsl+i5J8XVl/rDByPcN5RD0DNjeQqEzR6ypSq0gBg1cHkH1SKceCD/t?=
 =?us-ascii?Q?zDKWLGb/6Lj/uZdD4Hfq8d93Xz5908MIiT/hBzmCp5lZ/Yuvjgj/XxeE9V1V?=
 =?us-ascii?Q?SBEm0GzLqu+2EAyOmlKE7KhKz9oQ+hoZPSYmXV7Ga5R6Brbl65Kxv77znwHw?=
 =?us-ascii?Q?pWYiqKVKPQ+caM8SGvDESR05VMf7WW0IwuoTI1eRf+fC44JtSCo+76bSJAfN?=
 =?us-ascii?Q?werQ31P/nhhBsU8GnAPz0eepUiVA1FnUIuBKwZWemgGbIGVI+NVw2ouQnHl5?=
 =?us-ascii?Q?D6RJ9FNgZeUE+C6N0/T5YDe1cy+D+lZgJ04fnHS1718FI1pckRjXQUIMkSSe?=
 =?us-ascii?Q?tOHJEvDUrTw4m38RGaUf6aeK8VqPWTKkvGGYLl17zpn2917l3lEGVyOQjdTK?=
 =?us-ascii?Q?HnmbqEdTWchPM6afSPaoVCt5+uBQQn+Vi4rWzt42dX13pLpE5gPmSIlQuwp7?=
 =?us-ascii?Q?zW+/VHyl/aO/7Uqh2MUAWDkItGSdQYjQQ8zZZA7Pd76nGzuviYqv04RPTPs7?=
 =?us-ascii?Q?AZVXu1q3/ul+XdXWOSjvAJgNAHITqaUJnY090hu2CpB/unOJmKN6c7RQa3IM?=
 =?us-ascii?Q?vERhe70gin9QmVy39XaWJBlFilpef9HJ4x6qgbolfD0uoY371zyPaBhBp0hK?=
 =?us-ascii?Q?kVtSr28n8KiCD2mdEQvXFJcTve7zb14mRpPbQwIS2ODR89A6bE4+zlUPX5UY?=
 =?us-ascii?Q?GWiYg27KPKu7noEzAmlh9HALSjV0GP1WUr9pPynvxN+Cm3DNWK+majQ/9zYb?=
 =?us-ascii?Q?+xDHW+1Y3P5Q57DSdVuuKfaI0fq4ODVywtb9ZY8iy58qW2cmXQpHuFCA8CXe?=
 =?us-ascii?Q?J+4mjovaUkGdkP6ytOKhycePXoD1oWwjtOH1toWhkHhoPa4kOwmYgLXGfHu1?=
 =?us-ascii?Q?oKQBNdbbGp1WhN0IoLytt4QrdB3UjqNIE8BV02f+Jcft/7UiOKrxqRtYBgyc?=
 =?us-ascii?Q?4YhTmpSHzN5vZ5o3YxJix+wkXDWJ0ZL/J3nRC+ZLCKN0sccRRJhepRxpKd3m?=
 =?us-ascii?Q?tcpYIv2tNiutkhpl2PZeiyMDJue2wCFBKiv6/VD6TDogAqRUrwS6gTZL43sF?=
 =?us-ascii?Q?6yI9XGQoGlZCDDUX4BGT9ilkB8zrooAj1qX31mV9aYrWZ6wnNuVqa/wIkux3?=
 =?us-ascii?Q?/Oqg4nRgC7DOXgb4=3D?=
X-Microsoft-Antispam-Message-Info: lwvsjAPx54ov5unwXFO7p5ThvmVyJPZNZGc0/UdSHI/jlX9OpJtpEZRAE6rHdTaorejogZbV2nARr5EjAwCeSeivvY5SOA/zkkO4TQSSze4CNGY1989fAKXHaej/cRlZhtffyRn7/Y6G/4tj7Aw2ewBouusLajPGaytDdZI2NG8wqmTdnUTmLJ2E9fmi9pJ/RciixRLRR9VA+7QFgE005vmRA9BJuQcACvqy6KVJ98+gxCZH1ZJYqWxBoZ9YrB/JENKk5K3ld16HCUOCGmBLQRaoHq1OY2wc22AIvaCNUSzJKD3DmMtaPXIuRdZvjoQYRVhwe5idTsKygYZ+T2I9ftXQOyZnu4TXVedJSpRDavA=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;6:0M8MYh5OCtPFVa3Wzji6kuZXGndTJN4ym/oj2nj74+oAY/TW1urB1blJFcBOiOejtr95xUFB2mcnCKRk0SLP5uaiNuA/So/7D0UOafLIEnMl5Ru7VJ78VgZfTi7DOvSK50X3ii82AtYHEduOfAq6cOwcvKr/pmz+gIbY3FbhYnqwZmeAXz8yrSYXYI5pPvKkoOjdx8FQT/ZrdZY3SEJ77ZodkWt0fVKyRll7TWYZ1HZHY0qM/Q2EeH3kTYEv71PUqdMlj/qRAr6uyqglbDr0tPdUlOoTiEXzUBNqmBraiuw+tihqUuOSW6+/qrJUCBuDrObN3FmTAsUD7hO/TPXmUK9BMbSW7qGIDPGn6s3Pb7oli9PObQ4wqBbraPSOD4FjmnbpLDsYsAU0unjv4vcYW5/Q4RuwcUk4U5u45ZzFETxpK0ffX9aEWHHadNQzicItZVqxcAkNxr8BzbJWMbsMlQ==;5:yZnrNK5gnQsOhO+mPQSYDL3+nhJOOQ6uBl/bMGYzbwuu3v3WduWxCR7RxXZQeFkDmOfEc7b5w3z53gRSacMZn18/WjKn/opwI/7OkjdFFZWXimJ/ErXuaCspppnj/XNQ1BU7HftXUQu3bmEhLL0FIIcoUXb3tTeJMpELWjBFq2o=;24:F1Z7PVcJs3sdQnYq0qqQusu8j7nB8azOMFWu6kVfF1C9i0qVH6sEldDQK2gpngPqHFJ0KyjuXDVdd36L3ee21MNYvQ+1oT8QvOjbjhlhUK4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;7:EB54lUoBz/wQn7XmC7gtqe7G3BZ1oxMVxIkcnHtcx8rNLRfeQ9YmzyxEmftmSTakPBbZihVy/bNxHVO1WLbOLl0mwG4LS+Spl/dTIfgeLipNeBN1HfsdzSNPoW+EvmGA4o1eZTsgDHVSPZzfhKyQzp88BFI8QHmevGATwUq097DhkKZ5vJIlsH/SGsnJBITWsasLrFIWZW6htvoYuPbRujxWCGNQmKZHCHOa2WM92/5o7vZQMQFl3fszFD5FU1g3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 13:19:28.2329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce8b00b-5dd4-438a-a906-08d5e667c3d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1384
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
index 262a830..4f6e52e 100644
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
index 0122091..605c5ae 100644
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
@@ -526,6 +556,13 @@ int malidp_de_planes_init(struct drm_device *drm)
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
@@ -549,9 +586,14 @@ int malidp_de_planes_init(struct drm_device *drm)
 
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

