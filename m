Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FUZZY_AMBIEN,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD13BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615E7214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Qsdwh1ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615E7214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbeHWL7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:59:32 -0400
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:37705
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729644AbeHWL7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQoFOpoe6wsDq6LDDTXYTywN76O+EY1/s2V+248YIP8=;
 b=Qsdwh1obnV49rqrjMWRdEH+Z7VdGCYvN/MnOHeGVZYEeIGFjLTf+tLZ/H9OLmWJlOPRJkWAbZZ8PTv47V9CTL24quin1ABMk5ZP9bjxsl/jYqi7AOWQhE+mePnX1LeZ9XSaWSIfUlGdu8QsocQdM4CXIHOBle6RfLHWHk85mEXY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 DB7PR08MB3530.eurprd08.prod.outlook.com (2603:10a6:10:49::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 23 Aug 2018 08:30:50 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v5 0/2] drm/blend: Add per-plane pixel blend mode property
Date:   Thu, 23 Aug 2018 16:30:18 +0800
Message-Id: <1535013020-23737-1-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR06CA0129.apcprd06.prod.outlook.com
 (2603:1096:1:1d::31) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0e08896-5bba-4deb-3576-08d608d2be8f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3530;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3530;3:jeWGHpeQ6jWDz2n5kPjSGtWu+Y/7UMb41M2xWZ5TQQGw5aVOR0QilCL9SmdQsiUc4Rgt+3UaRpPtoIk0lflPk5mrPcn8O/CLEv4JMOna5jsB5yqohD8uTjylF7T9PFjzmckQp52SnReLDXOD8GoBmEGWSuO7gKER4IJtktF4goZMzdpJenz9+9nlcq5tWqWAU9p37XH4Ze1Qo3P3flQFlJjVZDIkp1PsBYb8QKZLlXhArn0q6MtInuNu0PzmlIQ+;25:r2+E37pAcijkpY3ZitqScrzgdA8UehrGCtK3+HUyhhZDiK7Tnc49lEBMmmKE12ZnrY6ExJ7sRCYJK/njNrN1mGYbA3cW+Nwp7bDZvqr07HuiyyxsI4K8Rp2dIibBv980BnE5v//+7bb1Pby/nyWaT9zWChJFSeE68HgRGhI0naa/58Z0TJO73wguM2gZBm8CMWKMRSy8O8NzMamk6E8VBcm2OLzg84rZO1TJTiZzRzZdGfsg+zAuzEZkJAJ3YVICQNRsubNPX7543GuroatCfK8tZbIxG8k6D5uI0EdH/D02fE8VL+mwBn0S2AyQ/6Dlv0HKDshBIM+mW5Cx+cjHDQ==;31:0UU8XlZ/AwihllJCSHnNqWK2pd3F0km9MnJovBpdvbaoTvGGTczYpVSpHt0ywtt422ripIuXh4jUhJRrqnwumNeydU6le7YcvMAVlfQybEmd1Nr0yjM/Fi3ss6ORk9C+McjDxiqWvzhru/km8IcyHSXDl98NqKsXKLP67Gotbr8n5ZiLAbv5boPIE+HVGOsFGJSVb+YKr2T6/GpSf+N8OAdHpZKJbgJwvSP3SC2Y7uo=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3530:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3530;20:Y028bGak56Nb1j6nEvdBBzRJQRjykvignU4M803WWTrjnrjxZhuB48WwmdlnjeVWBP25oRp93HaZ1jFhX8AzoVlV+BB5egPmG0aaNLYFZyvTKy9w+d3yjH6du4hvrP/Ms+BL1ym2BP3E0g5slG4w+64xnL4bPkxJvSsxRixkEJegP2SRZvHH1gN6gLHalJ5Kql4G9uCfJL/IYt7WG/KS2mqwJNEChRlr4/fDYIXhyd1FeUk8YfDW0P06brrsBLWd6f8kZ/dgKnuoiUoNIX0dZ8naSPMsKJe9RnRURqfSAZyaS6demMGS8z1/ARuppCvtn/SXm6e26WOWvzvx4io/kw==;4:CR9qtMxbajf0EXqSFNoBo8aM/A93AhpGIVWPaZaptUOnt8A/upcPxfTSpB1QMAIZ06/4FCRlzFu3OGedqZkWvxI66DWROHxEqcNinOLcGUoauarmgsJwoIOCnF4Uex17FKNh93vaajI8nN6yxF0uGX4mHSQN0FnKAg5loiWKIJcGgby0vN/GZ+0RlLKzunsXD+1CDYxpe+BdTqNsKYHbuVIt8ziNzY/sJu6chwnN72d8hwCi2Ta/adeFoxE8KuxAC9S4nJ/xnrMw/YwEy6vijA==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3530B7269ED496385EA21A8C9F370@DB7PR08MB3530.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR08MB3530;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3530;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(305945005)(16586007)(476003)(37006003)(8936002)(106356001)(14444005)(5660300001)(50226002)(2616005)(25786009)(956004)(72206003)(39060400002)(81166006)(36756003)(2351001)(4326008)(8676002)(48376002)(6486002)(34206002)(81156014)(486006)(105586002)(316002)(7736002)(51416003)(52116002)(2361001)(7696005)(53936002)(97736004)(16526019)(386003)(26005)(44832011)(68736007)(2906002)(6116002)(6666003)(6636002)(478600001)(86362001)(66066001)(3846002)(47776003)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3530;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3530;23:t3jC3YJGUcYcav46O0+FeteUf3W6Yd+jzIwWJ9inx?=
 =?us-ascii?Q?PNQSAZMyQ9XvQjFXg8JMZJeZ/V7kvv3WUydPwOY32mlHz7QV3QRtE3X1wVTM?=
 =?us-ascii?Q?kksJKOTAlpHv2bqvK8ZAW88XqKHarDKLgXHXDnEakqjNK/WMlQpJXDu/57Du?=
 =?us-ascii?Q?Z1Rv5PSscWwN6aAgF9gDs76FBHqLWdjrwYG1cQ4/D/K4Vv1asXrRhY/bIKWW?=
 =?us-ascii?Q?anVIoVJjvkd/XQyRzTBRqY2s3Vr8aoITcGQQINrGjMQD7ihmq7ztn1tfGyIG?=
 =?us-ascii?Q?tQHMXWpQ+6v37SuaCHBvE4WjJQXq+t2ras5Y9Z74kllj57kNCRAnOcAGhsdV?=
 =?us-ascii?Q?WOMoZ9pSQwW1s9eNjkozCBCLtdYzNzzVVYtXKANwYq2/4F3dhGIlYndORyFl?=
 =?us-ascii?Q?NC4iUnNVnBAUZumGaKHW7dyYVC67vR+9qGwsNrqR+q8ZMf+Kr/U1wyszN5Am?=
 =?us-ascii?Q?HBwel57VVEP90/hpgCj70Y2LfZ4ygItCbeljNfOEbX+rMhw6wTrm45eVI8qO?=
 =?us-ascii?Q?boNdoMXoQzy62gWKFDi1Nr7CQPcPM/49YRh5zgz4AXc9QRmm1KrMwzKDW4CX?=
 =?us-ascii?Q?eJU4IRoYGrWEDBET8gXUsTu8QMEiILneHWD/qMwnUrvxknZXNRLHSxure07I?=
 =?us-ascii?Q?iVMVV+YCOEBt7cIHXBF+uh39mwwULjwnIsUPcKd5bonLvdz+XeY9WnCpUuM8?=
 =?us-ascii?Q?4vaZc2Vd8wwNmRQQyIrQyPCqk6pwC8FTIlhkRUEEnY+gLX3IcvZX4thxb/Vh?=
 =?us-ascii?Q?VyMwV87wLNm/SRvFahMQpj7HrG5DhnIOZF8FhNtdvYvaEYWmIU68N7lo1WzF?=
 =?us-ascii?Q?0H2q9HitAnwomQXEueDWOtzgWJrVDhEXNm4/Y+SX+UYhec4qPoigZ1Ydu4G8?=
 =?us-ascii?Q?QBd3DC3A5fRizIb28qONfZMYuHcqavUXarkfFuT9j98ghPhztVX8G1aT9jey?=
 =?us-ascii?Q?HB0vP94CIXFw3WWizQSubEAujcX49orHO5iFmaVIcUYfETbiohW4EVwNnSmu?=
 =?us-ascii?Q?axgMYLz+cyN+mN0fQKgpaA1TTYpj6vd7HASNIvMeV/fp+Enwp3Cxt+Pfdj11?=
 =?us-ascii?Q?CI18VBamjqUQBxLp5nt9Uy0NDkYlLDsdhqRaAwvqjFVnJIclyc+LyoHKWYU5?=
 =?us-ascii?Q?wxxBO0Iq/SWUXBzTYYkj2AN+1uXsNWvj2+BYZlpOO6JWmQRpLFD4SvUZ6oI9?=
 =?us-ascii?Q?9PlUem6l7ZuW6Fp+T5J9KU26RKdlMltFWjSYdz38qSJShzkRKzkWtXJ4m52O?=
 =?us-ascii?Q?SD4juaj3ovQhSGc/gs=3D?=
X-Microsoft-Antispam-Message-Info: gJ9wzkEj9GU9ZzQGWYLSAmt1gldVFHj1w44hs7Yo49q4aAmbkUM/dFj75141NqHkhnTVqI1jxEmDNnhHiionUNamP0D6hBggsHnjtlxwVIDc4sgwicqRiW/rcda5doe2JjAsULt05l7/gxfJap/jydN+Lyjik8sFeczskrtLsAdQsJSAqwCMkUN2x8vxmIJlZhsr2jiYIKeYk8QfRBC8KIh9h1BYBwVGIGYEOT4kbNiAXdAHFeC1HC0oF1estdTouujS6slOxbQPwAJ7/Uz06lEA83w2dQP6Xod5V2/LiPoB+bFdLumHobdSkCGu5qly9Z3k6fhRDGyeN9S1DopiQEGxmILY3W66k6ZskXQxvZI=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3530;6:Kjv58I1E34bJe4OiCT52ILE6XPDL03SrS7J2nDQZdgI3JeQxRgR94mQ2YytgfhHNEmYyRYNWBAwTLp2NBa10KSLceRdejimV0i8WiOp7CfCselUqrcv5m8Uo15hwwRpLhg3LiQGZclkFqY1y1+uB5fmHS4oz/MMhS0fQtLrs0VD/VUwzmB519v3kfD8WOnrRXgNcfRPUspZpFepSoB3bP2/0AA74C+lAXd6jR5Wwy1gVwbLm+vJmy2osItkOWZvPBd3QnI8/TESmZNZuPPwD7b8ebsOEIasxwLgbA0YDc91ymjo0MFSropTU6/Itu0NL9gWVRNbnVptnX8chg91BzHA4Ss5FEK6LthmSieNWBAPxGtNcherjFVVrdAXpUDPktQGBp8oBvnxadKNp+IHTTg7UUeGWplzdQtQHaadwBbrWDsZbKbo9xuaplvt76agOPWiPThNvGnEvE3DK9/w05g==;5:HHqx3UjMhes6k/0WIcMbThQGuZCJzQb5PfAriDnTB4a0bsOFvMaGGcR2fUJRoausCZhxyQ3c3SypNaeiqZoPmf0M+CH2mcw7wdC7PHdXAVpGg4k/dT1OFrn5Nfj9QLLbPCNrlPq5cRVgvxRPmoPY4NCByjLEaM4uQyGVrsyqlGg=;7:q4r57MFsMuVsjy8xiHOZL3/SxD3aXMJEu+WTwk9ybMRyIB9jsL95TOKuNsEtkNsCgTAcd95vPZZ2k+WLXhUynW1k4mmjmmrcqX2SvzLzdIUYUZxHId/jzSfhyr0fcqKctGWqG3ZZwNdV6xB0xB8zjvRkofcW5by7d3dC+iHYLFwgS4XexRBlkS1y9Ln8Hog9PjhWWC9rQW1Da1nqavr+GjixhDzsEWQ9g0owRntP6WPGRE1xsCIaA/BgUZvqTt2I
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 08:30:50.1218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e08896-5bba-4deb-3576-08d608d2be8f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This serie aims at adding the support for pixel blend modes represent the
alpha blending equation selection in the driver. It also introduces to use
it in the malidp driver.

Let me know what you think,
Lowry

Changes for v5:
 - Adds comments in drm_blend.h.
 - Removes setting default value in drm_plane_create_blend_mode_property()
   as it is already in __drm_atomic_helper_plane_reset().
 - Fixes to use state->pixel_blend_mode instead of using
   plane->state->pixel_blend_mode in reset function.
 - Rebases on drm-misc-next.

Changes for v4:
 - Refines drm_plane_create_blend_mode_property(). drm_property_add_enum()
   can calculate the index itself just fine, so no point in having the
   caller pass it in.
 - Since the current DRM assumption is that alpha is premultiplied as
   default, define DRM_MODE_BLEND_PREMULTI as 0 will be better.
 - Refines some comments.
 - Updates on drm/malidp, hardware limitation check only when the format
   has alpha pixel.
 - Rebases on drm-misc-next and fixed the confilcts

Changes for v3:
 - Refines the comments of drm_plane_create_blend_mode_property:
      1) Puts the descriptions (after the ":") on a new line
      2) Adds explaining why @supported_modes need PREMUL as default
 - Refines the comments of drm/mali-dp patchset
 - Rebased on drm-misc-next and fixed the confilcts with plane alpha patch

Changes for v2:
 - Moves the blending equation into the DOC comment
 - Refines the comments of drm_plane_create_blend_mode_property to not
   enumerate the #defines, but instead the string values
 - Uses fg.* instead of pixel.* and plane_alpha instead of plane.alpha
 - Introduces to use it in the malidp driver, which depends on the plane
   alpha patch

Changes from v1:
 - v1 is just the core changes to request for commments
 - Adds a pixel_blend_mode to drm_plane_state and a blend_mode_property
   to drm_plane, and related support functions
 - Defines three blend modes in drm_blend.h
 - Rebased on current drm-next

Lowry Li (2):
  drm: Add per-plane pixel blend mode property
  drm/mali-dp: Implement plane alpha and pixel blend on malidp

 drivers/gpu/drm/arm/malidp_planes.c |  74 +++++++++++++---------
 drivers/gpu/drm/drm_atomic.c        |   4 ++
 drivers/gpu/drm/drm_atomic_helper.c |   1 +
 drivers/gpu/drm/drm_blend.c         | 123 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |   6 ++
 include/drm/drm_plane.h             |   9 +++
 6 files changed, 186 insertions(+), 31 deletions(-)

-- 
1.9.1

