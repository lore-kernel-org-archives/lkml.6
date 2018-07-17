Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF8FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29A820684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dz+FIPG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29A820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbeGQRrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:47:48 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:36100
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729717AbeGQRrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhhDzE/5b1+y3pegV6/YoPaBMZsKExuyB3nAf+PLdRk=;
 b=dz+FIPG2wawyzb/uC2iw0icFJi3cQsvZvxB4p7Eo8wSMXSazFsbmAk5jsKW2ZiSQ3VYcAFhZZyt7xoj380oYW4eA5D97FWk5j/BotD2QUiJZCl0ubbQ9s3IXsr612Nq6KPheSSXF5PdLOcZUP80VmcPezTB4/k8M3UQtYjtWTWs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1377.eurprd08.prod.outlook.com (2603:10a6:203:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 17:14:04 +0000
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
Subject: [PATCH 1/5] drm/fourcc: Add is_yuv field to drm_format_info to denote if the format is yuv
Date:   Tue, 17 Jul 2018 18:13:42 +0100
Message-Id: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: MRXP264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::24) To AM5PR0801MB1377.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92d03d52-bab2-4b23-7a27-08d5ec08b3c7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1377;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;3:smWZeQAtOFEfa68lgUWgTJCiFdJcVvBnjU7BWAByeVKwVvtvIj9kv4B4T2Ww9Zvzd5qHXS5w0muLpEeIIfdD/aNlnhFh0jF+0/bx0AE7HRyycWer1wXjihczFcBmuGcGzD7aSlb8G3qGebedCouRdcpQefU7Ufh+9M9DYXNSYjRtaYNK4PQxIb5kg3F4CvXgfHucWDhq2ffepaOp5MmyZV4OhO044AU4ZOErJsC3/IPc29qDZxZNnBwKLLM8uXlO;25:FBT1/Ex8PWXVbSZZ51WKAZX/8c2xEyQAsmYuo9lh3HCbLH+2zIyK5X1bsaH97UoePYy2emKEd/IKOmgNksfi0KsXxj6FrRP2DgI4iVDel7N5q0epMYVu8NXoF71GmEDzgqC/skwmFD+9ligYVneFQTbCPSbWpzvv9GH8X+0ydldDlUd+d+Yyvi1RdvR8rxxsXdgDCUyDfe5wQeDSlnVY41uo37WfPE6sDDDz9nMwxJHJYyEAFZ6nQgocgYWLXQkygL6nzhf61M6/g+vyES25BARE2aU+403mLiYKsPM7aH/otcfwGOtnJ8/sNW9kO/3IrGSGxHOj4QY/CfGwMWsbBQ==;31:Ts+ag+oM5MWFzCc2ABVOujwQgvhZiH3MpUVsb+Ra79qH8jA8BYI2BdCPz0i3qTAYrxF/LX85WhI9YEhaKkrJaxpp+3dleivWmsiS2FM7khSLB2jCP2V4tL4i3ndTLJCMGiAS0lqe90/ohh3TFzfS39d9ZQ4H6RHY5mCWXKQIxLePKAcu18u2e9rbyjD3DLamy0kcYTLggsWFgWtuVwUYE8dGfxcnJeX3je7lGUlCiiE=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1377:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;20:OTY9udSqmLyZ5vw1TkqUCB5rLvD8VP/LVXY04S6f4alRSMNdeO2Rhfheo3dLoiJVZmEDHTIxVDuJs9M1Lpe/d0Cc1xikHVbASJesEwR7qhRemH//j60/vNpd3dq0jw282X6Nc1brWFVx1cW2mmbuid2z0RmR2JVJRD7kOg1TMDM=;4:whkZbJzvmHfeQRYrGQDvJnrmq/2SiJKyXLKQV3ZlOMkffTn9p1KDLYGa/TLoeaXaDxoH9QIL7qPd+ARDPWv/IB5tkI70URYloE1psNvgtCGp0Qiol/z1oZPmWKmn84ptUYUcV6ab8nCPf+YgY55+q9mfhOE9Te0f20+uoKc+PztXnjQ4ZHRs0WJEiBowrykX3uetMMDi7b6SJIXXSRuc8qZYXtUR8wRJnNQjKO2NsB5D8ZjyLICaA2szjnh27ikShTAui8oUtoDYN7dxtepUd8lrX6WpG1yet5S2kVUT4DVYdhJAWEQbkO0HdfrjNbJb
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1377A352875EB04C2551B825E45C0@AM5PR0801MB1377.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1377;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1377;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(199004)(189003)(7416002)(316002)(305945005)(36756003)(5660300001)(486006)(4326008)(50466002)(51416003)(48376002)(386003)(2906002)(52116002)(7696005)(476003)(53936002)(2616005)(6486002)(66066001)(3846002)(72206003)(68736007)(16586007)(478600001)(25786009)(956004)(105586002)(81156014)(8936002)(50226002)(26005)(86362001)(6116002)(47776003)(16526019)(8676002)(97736004)(81166006)(7736002)(6666003)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1377;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1377;23:SwS2JNGb2VEBIEj2LlHYzhmmEz8tKDjYYsmoJHq?=
 =?us-ascii?Q?stT/3JfiSjq0EIQRUjj83IhLxktz6gA7JtrQBncLIzddluyQtd9xgGxVn81/?=
 =?us-ascii?Q?7L6UjibzxzGwBjKfEi2JcaMIocn7SjXX+Uhv4/zmB2ADmlo2nY16LV120785?=
 =?us-ascii?Q?mVYPOefNmXJ8260WMLhQLP7WT0GShymeqHAYR+JqBPMbcXsMwPYH/fZY9R6X?=
 =?us-ascii?Q?XRvxXlBqrzymZVdGScvWBiXUkNinPTzpDyCOByuMoEPve0+DRHX48pWF8IGO?=
 =?us-ascii?Q?jNrPoqlsc2SFcNQesiBs9Uqz3pP1cSuWWUJL7bo0uNrhtfjiG4cSfN4qpLvD?=
 =?us-ascii?Q?t/qty9LUzzp3pYIIdoyK0cf4iiNi8GeeS5L/3yCAH3CZ7Rvi6kIwVmtQFdWd?=
 =?us-ascii?Q?MtTOwuAS0N/Zjft8L5hzj9rxywyCOxXHCXzKIjrwE4YWgpYYFI1UqK8klRzP?=
 =?us-ascii?Q?xDfY1C80WICHuu+JyMTnNMSy+t2rG7MzIauk27d4pL4YbjEp43WUjW7ca0s1?=
 =?us-ascii?Q?2gYF2jRTGAOT/J0KsLWtqTzw2aYnbkuiZ+HRSsm/Pi78kPIAqi/KQYBYR73/?=
 =?us-ascii?Q?XnhQH9lYhhnSWrXFSQtp1FKVf9B3odKWkx5gJTAP97QaDC13jc1+nqq7AOos?=
 =?us-ascii?Q?65kE72zxJ2Jfm2Sr6zQPS8MkG5jzGYY/ZBTZI790QXm72aqRdgcW3LJagkGN?=
 =?us-ascii?Q?VkaILr1Y0PcgtKHPX4dbfRnxqKfDJExMl/R7dyFPYv+23NQNFzd+6TgpPjml?=
 =?us-ascii?Q?a9P/xVBLbfi/Fuu261fMzPXFqFNbaah7iZ3YFO/Swe+APjbyad5j1c2LuUxc?=
 =?us-ascii?Q?UZrSB7zMs+VOkdjhL0sFhEO6nZwb5+0CqyOEcR86HUSRFXQ3Z/ZbnnZys4J7?=
 =?us-ascii?Q?XybY3fuyo6ERJrscUUp2NkYbc12cTcWY1iGn3Aa/FRee4Wsp+yqPwRZMxUHF?=
 =?us-ascii?Q?AvQBtdvPNpp7HYFW/WBPNT901bPsIIFsYbhj6g6MOnBPPNVYkIFGcymOMIe2?=
 =?us-ascii?Q?BSH+Fi2dSzCGdXZTB0H2mtBEDZ/D9B5+2Ur308i/f6U5p/zhRVlQmWrigpzy?=
 =?us-ascii?Q?MvpBUHtdxuAclGpxWxanjRPZ7sKpVqA1xDFOq7/SJmJUyrGVm2cOf3xgDY/s?=
 =?us-ascii?Q?03r7t/lIWE1PzBoJCtLIa9MeHTGrtLzaF?=
X-Microsoft-Antispam-Message-Info: tgaObaapaM/wDsMjH1hQuhlc4iW8TmOXdnkTHm39kufzA+SnYVvYc9Gx16GlcTbrey82oP/ZAVyB5rIFn2cUHz9y8jA90g3WT8Bwy87s1MqBkUTqY+GpVWNyp+SHgNCW8iVN0z6vhzd/ohY1oXqbTlqWf/2yAChIQH2y4xYXBV8lCOLpMduJHVmLTKX+F8OygvFAd125Vu4gGXnmNRK7MBgA++nOsyWogaKab3ZIqXkM+/ZGafkVVajAw+xfOcVqxjFBvFr2944EZcIeKhRzVziDrNPmDH0Va1Xhtdn+984vpbrp2O/KNdCA57GsxCQ309NnfurPWZDlyH0Oa6WtxUVUDunk+8wb9BGJ7wixOnM=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;6:1lcoUnqCmtUwMsDTev1dp15Wv26Oq0U6BevvIDt5OO1xOXED/X/D9GRDLh84MX1VpDn54lu92kIS14g3P5YoIFa9qV+1kBnvinZr5Fzbhf+VvV4kRs8rOfG5iWitCQJSu/yO/3muIDVTAVA6R0e5+ayRyWjvB0oq5LpQr0OpqpCcCZZhYNR/24M6JNp54CNeSXVDnv1MssLqm55HUwxYGOWiR2XSLp1VoEZcYtJ4VSpaXu5uyA56gFARYp7jnPRHKSQayM7pnwtTMGijupUqGbYzVRu8OrRUT6C6VHBoprZ3Z5crlu2lbXElHib7Phc5i0ldTBxR3S6PaNBZKPOwiUZNBG5JBrkLTFcqYS6Vo5zZ4LFzQn/+uZH5ckXE0BW+hpHdJs9tivopVH8EFS9qxaJd+NHNixwWcweEs+mw5TnXRgXRWirihcfKMKu8k4OTO0O/aUBRhSixHxyEwUzEMw==;5:IDJ9ekw9mcTga+Pf2XfVfhkCWd9/f+T89Jzbduz3cZx70OiB6wE+ck5A7+b/fqltQD92nSXZ+9h2BkPyR6OgeKhzAK1BaHjsL1M7qxOYMFsHyTM7vpf7YILoX6nnHKhlNvFnGy3VteeQ8ApWqtPLjQd56PCu+y2ZeBS3ClF64Yk=;24:WrtvqqHiV/9Aiw8o8a0um1viUeWHbGcvBTuskc0vT3bLlH5ar1EIBg1Rz74LDqA3rXvyMzEY/X/k/4gjr9dYsOU7V4bWnkhx0K8rHvSDcuE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;7:3T3xJ0IKl9/+9DJkGN1iX76W1ft1cn1ncBoS7TwrKduqrvaKHa583xWxgLJpZIuipen9ndi8cYMjQvAxHodvKivRLRhFAqaL61w/9mxF3ICOKHxJLyj29fExYbSjSyMSYaQpXT9e0YIyfnJGO1AiyGVzcwaXwiQ6aKNOnZ3p4qdAAwyJ1RhyX/feKj70e2spgDS0Ao28Wx4yLBIBPM5sl+ZkbWZhCedPi6Ztxk6KcF5tvAiEIXHOvVIMwAAysgkh
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 17:14:04.6818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d03d52-bab2-4b23-7a27-08d5ec08b3c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of drivers duplicate the function to check if a format is yuv or not.
If we add a field (to denote whether the format is yuv or not) in the
drm_format_info table, all the drivers can use this field and it will
prevent duplication of similar logic.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c | 42 +++++++++++++++++++++---------------------
 include/drm/drm_fourcc.h     |  2 ++
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 5ca6395..35c1e27 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -152,27 +152,27 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_XBGR8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_RGBX8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_BGRX8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
-		{ .format = DRM_FORMAT_YUV410,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 4 },
-		{ .format = DRM_FORMAT_YVU410,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 4 },
-		{ .format = DRM_FORMAT_YUV411,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 1 },
-		{ .format = DRM_FORMAT_YVU411,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 1 },
-		{ .format = DRM_FORMAT_YUV420,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 2 },
-		{ .format = DRM_FORMAT_YVU420,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 2 },
-		{ .format = DRM_FORMAT_YUV422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1 },
-		{ .format = DRM_FORMAT_YVU422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1 },
-		{ .format = DRM_FORMAT_YUV444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1 },
-		{ .format = DRM_FORMAT_YVU444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1 },
-		{ .format = DRM_FORMAT_NV12,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2 },
-		{ .format = DRM_FORMAT_NV21,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2 },
-		{ .format = DRM_FORMAT_NV16,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1 },
-		{ .format = DRM_FORMAT_NV61,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1 },
-		{ .format = DRM_FORMAT_NV24,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 1, .vsub = 1 },
-		{ .format = DRM_FORMAT_NV42,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 1, .vsub = 1 },
-		{ .format = DRM_FORMAT_YUYV,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
-		{ .format = DRM_FORMAT_YVYU,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
-		{ .format = DRM_FORMAT_UYVY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
-		{ .format = DRM_FORMAT_VYUY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1 },
-		{ .format = DRM_FORMAT_AYUV,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
+		{ .format = DRM_FORMAT_YUV410,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 4, .is_yuv = true },
+		{ .format = DRM_FORMAT_YVU410,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 4, .is_yuv = true },
+		{ .format = DRM_FORMAT_YUV411,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_YVU411,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 4, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_YUV420,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 2, .is_yuv = true },
+		{ .format = DRM_FORMAT_YVU420,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 2, .is_yuv = true },
+		{ .format = DRM_FORMAT_YUV422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_YVU422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_YUV444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_YVU444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_NV12,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
+		{ .format = DRM_FORMAT_NV21,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
+		{ .format = DRM_FORMAT_NV16,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_NV61,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_NV24,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_NV42,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_YUYV,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_YVYU,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_UYVY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_VYUY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_AYUV,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 3e86408..f9c1584 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -39,6 +39,7 @@ struct drm_mode_fb_cmd2;
  * @hsub: Horizontal chroma subsampling factor
  * @vsub: Vertical chroma subsampling factor
  * @has_alpha: Does the format embeds an alpha component?
+ * @is_yuv: Is it a YUV format?
  */
 struct drm_format_info {
 	u32 format;
@@ -48,6 +49,7 @@ struct drm_format_info {
 	u8 hsub;
 	u8 vsub;
 	bool has_alpha;
+	bool is_yuv;
 };
 
 /**
-- 
2.7.4

