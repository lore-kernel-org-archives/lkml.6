Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE755C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F5C216E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sQQ1FVDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F5C216E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeHOJ04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:26:56 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:61344
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbeHOJ0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TKuIGzH/aV1OHYs9xsf9kNpVw7n+6gVbCdFL2QRmb4=;
 b=sQQ1FVDVACXkxTpLzeb4fMhsTL+UGeoUMvgcZTV4i5QH2e9xex+7zypnvnTEsNyplJi8TdUCaQPN5pYrH1tNX71KB2X5DqRpA4sRGHbMfR/HUIYUitpD9Dp4EqyEIBpVUN5F0+7MasxbBXSxZ4NKuypjASFRqmmOO5L2xHP52sE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 AM0PR08MB3523.eurprd08.prod.outlook.com (2603:10a6:208:dd::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.19; Wed, 15 Aug 2018 06:35:54 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v4 1/2] drm: Add per-plane pixel blend mode property
Date:   Wed, 15 Aug 2018 14:35:32 +0800
Message-Id: <1534314933-23182-2-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534314933-23182-1-git-send-email-lowry.li@arm.com>
References: <1534314933-23182-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR01CA0129.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::33) To AM0PR08MB3523.eurprd08.prod.outlook.com
 (2603:10a6:208:dd::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b44e3a68-0786-4c53-24f7-08d602795cb5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3523;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3523;3:3rAOsavS7uRA9lhV+4HFQfciefmDS7I5zcOR3Bw3L3GoXGRpxUMZ9pY43i7OKaqZK/akc7ftLxKxNDH2VaetNBp++5xBEnvUEtIihKzZDuo6ulZaswqL4aBjk8lZMySMlg+F8TEEtHRdDC4LJtqA7AuT1zec6o8EWHNGmCdEb5T8rZacNgP4ubck+GKJTgRTlEbYO0bVfqn6D3028RJR2qnXpY4E7kpwzBRE4G8FL5R07z2ZjSMviUpLQxT9k6ja;25:kQxRJFV3JxxKGLWGOS/uEa09stl52gwUIxsMNZutaC3ElWgQNWQe5Ol06t5RuIeuuolrcXe3YQ3KUtRJvnW7tYAXJ34SKlf/lyS6HI5g47yVUHIyo3itXbT55cYLLPC/txJptqk6lj7Vhzupt4kb3aL7MfI6RMdOeyUQ8RYaG49gUbIwNglDvVoQHYToyAKaj0kKZwUpxEstn/1GBu2qo5JY5gnXAhBEnk8Yqb7BA0BmIbwXVmt9wNtdqga8Cu1gR+XDgRGhCMmhqGWvGvZWf55p1BBijM3Gq9Tqvpv5RMy+0KeVjLZ1p/nSJu27ZRz46piinkdG0x7kqaxOSGGLXg==;31:dXbOYmkz+nYo7kwp6PUPI4ZugMLCGWDyxYEddl5YtLHyMhhX/ukRggYKU9pAQeBPi/36aW8350OvQ8Hindqg7cNYl9MSwZVEu8Gs4UFJtouooOz0veOvKmJyCTLrHT+MetYnf93CLM0kVMqfGyj5zbGH/K0Z81zDQRI0iaXM6H7iSGdxQdVQLdM/VfF2JzFa75clZxutvzHm2jKTh3mnQAJEK2fK8yDga0nNn2i98a4=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3523:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3523;20:VG932hY96W9OI8ii2WsjL1jJsooz6e+mS8MTUqHZrd470rIwCSTwgAw0kLPHJXWPyx4mFcl+sl7GpYlS+ttJ0NNgOSdg3cnPr2zMOBpFq//bSlu20xr+lhG8qqiLOdUmn5oYPFTNQcKasFipMCeA8KTSlJ91t7MvgUS2XHytoExEzRvJMiUoX84z2lEQKBg5CdTMbmHwMAUQUqsUzYtXvBsFwcWNX9sk5+TwJKmioeX/8D1C5reJyTSJOET/ViRlBojD4JfnEJw5iU0uvxCK8fOq9aL7ONeH7d1BH8h7BEMKVu6iSh8Kpvx8gjnOOL4aZ4aTCZIpmknek7Vr6D1sDg==;4:9aoQd5QuUFVgQYJBC3y0Ls4qtu7WFbI7YCJpaGYRVY9JplK4iM/PABNZ+FqQ5x2Z/54QNJFBIQ0PsN5FHYdCpdjx5U3GaRb1qmdikezuDH+fEqzKIj449SrSzX7pyUlHoODiwTK4JBrIX5K4qs1WFh8XHvre2MqjCKS0m28+b+OdWus8h43plxSJ/Fvxm6AA8IqRNho7QFk3sMiuBcYv4uSr9zPgW40Hl4iACa/A1nA8D1aq9hEypNhqPihOUSdR82vsUzBDhANiOqH/VHBzJcs1fKGzK6y3C0VP/KpjUbvG71a8CVyMzgWYcWGNeb8y
X-Microsoft-Antispam-PRVS: <AM0PR08MB3523440DAF81027415CD19939F3F0@AM0PR08MB3523.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3523;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3523;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(7736002)(305945005)(16586007)(66066001)(37006003)(3846002)(50466002)(478600001)(72206003)(8936002)(48376002)(68736007)(50226002)(86362001)(39060400002)(316002)(6116002)(5024004)(47776003)(36756003)(97736004)(34206002)(25786009)(2906002)(5660300001)(51416003)(6636002)(2361001)(4326008)(6666003)(44832011)(6486002)(106356001)(81156014)(105586002)(2351001)(11346002)(53936002)(7696005)(956004)(81166006)(386003)(52116002)(446003)(2616005)(486006)(8676002)(26005)(16526019)(476003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3523;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3523;23:PuUTOQ5tRb6BzuDAg7byszQSyJbM6vLxOFyEappuH?=
 =?us-ascii?Q?FXu+6xWaadjxIz6ifDBuudWOg/B3yW2vV/zwKQ4Sf9DYegDKU9zLEKVXTF6K?=
 =?us-ascii?Q?gNDHQCGhbMmxyBjtusHvEvqdF30U6gB2GIG3hQM5N2lPvgpIXVLffWmYZ0TI?=
 =?us-ascii?Q?1fAFkdOB4KpPoyJuKXbZar+smMs+I+Oc13UAH6D2kG7dZkEDUXreZTceKQNR?=
 =?us-ascii?Q?PDBwqqK/7jWhh66k0iThtfjExsyaM+WXavJab7cuia4xPnVfAGFKQKZx7Aie?=
 =?us-ascii?Q?Tt+AQ/XFvozrxE7ddTnR0djOc2XxUU3OI5KiAl1T7Kxmj3SGnZurZ5LATBQN?=
 =?us-ascii?Q?wB1k3zSvNo8sM6LFk55Ic+KIwVlmSZfHr3SEQ04XQ3fXh1bnNp+8IjALbQ2P?=
 =?us-ascii?Q?vEZLkanDSyllvkqmBF2tc7nU2bTV2zcHOrjoNaE2pTshcv372cWdrLq5yXV8?=
 =?us-ascii?Q?Oh9FoFZUz1ravHHRpM1gDgvOjYFaVImKoZtDY0ueNMRjTWjrIlUwxvaK98Me?=
 =?us-ascii?Q?enF6lY0+jPXW3KJ6kgvZuECWQFI8z0NoPrqRUCGBLNpNj1lOR6tGBUB3LsTz?=
 =?us-ascii?Q?j5Q9fw6issFIYB2pDWMXMGpzW17V9VYFJTN1RwwD20BMhN296elA0IAIuMM3?=
 =?us-ascii?Q?D2Ih8Hrv1AdFB4myDNLaIdpwYxT0OOtoL8BQt4E81er74NPPJEtRJS1NGtRi?=
 =?us-ascii?Q?coDWF06oIX8206LlJ0eun792HrhwxumKXYFTEoeX9TL+TzjAwzEFKLxdzSmD?=
 =?us-ascii?Q?t/5hLLZV/0VfbFX0N+s6FM/34yrGTO0obO244dGBUVBSO7H7S6GWyU8ELgWH?=
 =?us-ascii?Q?nxsIoyphobV5OnhGqVLeeaOiBD8WBZOr/lRCRu7eQ6ClFtsEJHAgFY+ctgPC?=
 =?us-ascii?Q?DoEd1nqUppsTHXWQaKqB38pYFznYtqFk1lJ1T6ILoaR58D374uEcE+O7cMaN?=
 =?us-ascii?Q?AZGbGLZB/Gv+BPbr6eoGfp+Z7snJQYV/GRpKbnff0SD9+h3UQ/w37LfqnJkC?=
 =?us-ascii?Q?/LgDE8UgZss2NxWme8MIVe7VlTFik6ukuzqk35w65emX102erWZ5gNnLi73b?=
 =?us-ascii?Q?Rc/8qAxG5Ppu+FHR29dydRdYtyy1sUJ19XG8c7vrYg6AoNyzp16XEfGwCx34?=
 =?us-ascii?Q?nx7egSkwoTNuGPLgX9HmvbRw8yZzxtmb0AcP4+kpSXkynVyIJwFRUTNYvqAN?=
 =?us-ascii?Q?YQXE98qVbgx+uKcAJRQGQuf14FJ7HCGSbpKzBR1oWo6aHZt1QnXncUXFQPyD?=
 =?us-ascii?Q?D2TPIsLSufe9R15mObjFtgBNvOwf33c5WddOeXIURoBsVX6Toy/6aUZqcylD?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 4jPjp7iiol9BPH56DTPS/aG0sNnH2Cg7OTEeFYVO+3rPrm3vtkVeLyzbPTOuWuGTyl4eHe/1zOkgtvxkyiRyXs0mm+hsZ5D965g4rRsE86mAidJwdIYT4nWGT7pjb3rD94GhAcEEP470jnHDJkzfSX2jIFWFR/WmRxdxYEdbBA7lPrlxYxEdSvEiuC61D7TssvRiYhxTUVM8A5JBf1NQqYbuO1/mZq52GGjYQ1hQOGQWCkGdtvzpFD0dKoIKKtNj/o99tEURer9IhmNtpfm7uSDVsCg+ueT59cXI3XdMvrD8P3+CNLAyJu4ciGc02Qwt2iuNq7C7tWxsrZncQAWVAbvc33E3r0haZTD8k0CVGyE=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3523;6:uak3QmWMn8KtqVAbdVY3VUaC0zhiJ28DnNF4TsfmbrckhKvSf4OmP6yIFI87CTXs3Luh0l3fon/AEZT5Ef2ASrOe5f7AIVTnj07AYifHMgTqPV617raaQdqTb+H6SXOGOyMYVNodLRlo5hvU99seQtuF59T0V5b7ZCGo07qUWazoEXebNj9pMAdp9C1YrjGVaDcRms9ymHT5F5n8XpAbnB7S2SkfZXCM+m1KqMY0bdjThrS60dc49p1sv8xNpmSCfitoYccjnjyRdIY8ON8CvDdlnRIf0QO4puP3MdjcX6CKtdZjl3bhDsLFpkzXApA9i25S1RPw47cSxr/9ff872h4KG7esrXebVyxzlLoOMV1J3ocsTS6GDj5vvht7Ze9sgdO8S3a6W8M87oO1LVp8CP202VDp+9u7iCQaFS1/r7q89gQFjCdCDOcs5/qb+1GqcwtS+nb9BwmuPTFQX18Ujg==;5:orCSp4s881nh7FDT6om1wuGaaH+hRUVz/tyslYceE8Ch/ffO5+C88Ly+BztHc9VPKm1O2dqoecUTV5ha4NbINlgCth9ep4mw2cHiFcDvOT0GIdkd1eFVTb1LM5fl13LM4+6uKb5dKknw8o3qmiwvTKiXWH+x9TE2BglWX32I3JI=;7:KbmDBNG7hRqWqC4U306qJ4uspi/9XktVHq93A6mC7Hu2qfxwjkDGiAUM7ODY84Cyies/Dev/TtwVoWDFQSD6nAGZf7o+9nrxUft7/Ob4+SKX9rziE2i2MVzn+xVJXubSWo9HF8UxljbWA+2nr/2KW8PzNTBrI6wz+SDXGUeHqGnxBiaWMGA//Pv+wykRykBk5WewsAcjJClS1g8vSoOX0RlLpXr/ucTKF3ArzvNrK2PMFZsiQKmesNocsudHjgtn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 06:35:54.5739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44e3a68-0786-4c53-24f7-08d602795cb5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pixel blend modes represent the alpha blending equation
selection, describing how the pixels from the current
plane are composited with the background.

Adds a pixel_blend_mode to drm_plane_state and a
blend_mode_property to drm_plane, and related support
functions.

Defines three blend modes in drm_blend.h.

Changes since v1:
 - Moves the blending equation into the DOC comment
 - Refines the comments of drm_plane_create_blend_mode_property to not
   enumerate the #defines, but instead the string values
 - Uses fg.* instead of pixel.* and plane_alpha instead of plane.alpha
Changes since v2:
 - Refines the comments of drm_plane_create_blend_mode_property:
      1) Puts the descriptions (after the ":") on a new line
      2) Adds explaining why @supported_modes need PREMUL as default
Changes since v3:
 - Refines drm_plane_create_blend_mode_property(). drm_property_add_enum()
   can calculate the index itself just fine, so no point in having the
   caller pass it in.
 - Since the current DRM assumption is that alpha is premultiplied
   as default, define DRM_MODE_BLEND_PREMULTI as 0 will be better.
 - Refines some comments.

Signed-off-by: Lowry Li <lowry.li@arm.com>
---
 drivers/gpu/drm/drm_atomic.c        |   4 ++
 drivers/gpu/drm/drm_atomic_helper.c |   1 +
 drivers/gpu/drm/drm_blend.c         | 126 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |   6 ++
 include/drm/drm_plane.h             |   2 +
 5 files changed, 139 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 3eb061e..d0478ab 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -895,6 +895,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		state->src_h = val;
 	} else if (property == plane->alpha_property) {
 		state->alpha = val;
+	} else if (property == plane->blend_mode_property) {
+		state->pixel_blend_mode = val;
 	} else if (property == plane->rotation_property) {
 		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK)) {
 			DRM_DEBUG_ATOMIC("[PLANE:%d:%s] bad rotation bitmask: 0x%llx\n",
@@ -968,6 +970,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		*val = state->src_h;
 	} else if (property == plane->alpha_property) {
 		*val = state->alpha;
+	} else if (property == plane->blend_mode_property) {
+		*val = state->pixel_blend_mode;
 	} else if (property == plane->rotation_property) {
 		*val = state->rotation;
 	} else if (property == plane->zpos_property) {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 6dd5036..563af09 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3569,6 +3569,7 @@ void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
 	/* Reset the alpha value to fully opaque if it matters */
 	if (plane->alpha_property)
 		state->alpha = plane->alpha_property->values[1];
+	plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
 
 	plane->state = state;
 }
diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index a16a74d..24016c9 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -107,6 +107,52 @@
  *	planes. Without this property the primary plane is always below the cursor
  *	plane, and ordering between all other planes is undefined.
  *
+ * pixel blend mode:
+ *	Pixel blend mode is set up with drm_plane_create_blend_mode_property().
+ *	It adds a blend mode for alpha blending equation selection, describing
+ *	how the pixels from the current plane are composited with the
+ *	background.
+ *
+ *	 Three alpha blending equations are defined:
+ *
+ *	 "None":
+ *		 Blend formula that ignores the pixel alpha::
+ *
+ *			 out.rgb = plane_alpha * fg.rgb +
+ *				 (1 - plane_alpha) * bg.rgb
+ *
+ *	 "Pre-multiplied":
+ *		 Blend formula that assumes the pixel color values
+ *		 have been already pre-multiplied with the alpha
+ *		 channel values::
+ *
+ *			 out.rgb = plane_alpha * fg.rgb +
+ *				 (1 - (plane_alpha * fg.alpha)) * bg.rgb
+ *
+ *	 "Coverage":
+ *		 Blend formula that assumes the pixel color values have not
+ *		 been pre-multiplied and will do so when blending them to the
+ *		 background color values::
+ *
+ *			 out.rgb = plane_alpha * fg.alpha * fg.rgb +
+ *				 (1 - (plane_alpha * fg.alpha)) * bg.rgb
+ *
+ *	 Using the following symbols:
+ *
+ *	 "fg.rgb":
+ *		 Each of the RGB component values from the plane's pixel
+ *	 "fg.alpha":
+ *		 Alpha component value from the plane's pixel. If the plane's
+ *		 pixel format has no alpha component, then this is assumed to be
+ *		 1.0. In these cases, this property has no effect, as all three
+ *		 equations become equivalent.
+ *	 "bg.rgb":
+ *		 Each of the RGB component values from the background
+ *	 "plane_alpha":
+ *		 Plane alpha value set by the plane "alpha" property. If the
+ *		 plane does not expose the "alpha" property, then this is
+ *		 assumed to be 1.0
+ *
  * Note that all the property extensions described here apply either to the
  * plane or the CRTC (e.g. for the background color, which currently is not
  * exposed and assumed to be black).
@@ -448,3 +494,83 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
 	return 0;
 }
 EXPORT_SYMBOL(drm_atomic_normalize_zpos);
+
+/**
+ * drm_plane_create_blend_mode_property - create a new blend mode property
+ * @plane: drm plane
+ * @supported_modes: bitmask of supported modes, must include
+ *		     BIT(DRM_MODE_BLEND_PREMULTI). Current DRM assumption is
+ *		     that alpha is premultiplied, and old userspace can break if
+ *		     the property defaults to anything else.
+ *
+ * This creates a new property describing the blend mode.
+ *
+ * The property exposed to userspace is an enumeration property (see
+ * drm_property_create_enum()) called "pixel blend mode" and has the
+ * following enumeration values:
+ *
+ * "None":
+ *	Blend formula that ignores the pixel alpha.
+ *
+ * "Pre-multiplied":
+ *	Blend formula that assumes the pixel color values have been already
+ *	pre-multiplied with the alpha channel values.
+ *
+ * "Coverage":
+ *	Blend formula that assumes the pixel color values have not been
+ *	pre-multiplied and will do so when blending them to the background color
+ *	values.
+ *
+ * RETURNS:
+ * Zero for success or -errno
+ */
+int drm_plane_create_blend_mode_property(struct drm_plane *plane,
+					 unsigned int supported_modes)
+{
+	struct drm_device *dev = plane->dev;
+	struct drm_property *prop;
+	static const struct drm_prop_enum_list props[] = {
+		{ DRM_MODE_BLEND_PIXEL_NONE, "None" },
+		{ DRM_MODE_BLEND_PREMULTI, "Pre-multiplied" },
+		{ DRM_MODE_BLEND_COVERAGE, "Coverage" },
+	};
+	unsigned int valid_mode_mask = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+				       BIT(DRM_MODE_BLEND_PREMULTI)   |
+				       BIT(DRM_MODE_BLEND_COVERAGE);
+	int i;
+
+	if (WARN_ON((supported_modes & ~valid_mode_mask) ||
+		    ((supported_modes & BIT(DRM_MODE_BLEND_PREMULTI)) == 0)))
+		return -EINVAL;
+
+	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM,
+				   "pixel blend mode",
+				   hweight32(supported_modes));
+	if (!prop)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(props); i++) {
+		int ret;
+
+		if (!(BIT(props[i].type) & supported_modes))
+			continue;
+
+		ret = drm_property_add_enum(prop, props[i].type,
+					    props[i].name);
+
+		if (ret) {
+			drm_property_destroy(dev, prop);
+
+			return ret;
+		}
+	}
+
+	drm_object_attach_property(&plane->base, prop, DRM_MODE_BLEND_PREMULTI);
+	plane->blend_mode_property = prop;
+
+	if (plane->state)
+		plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_create_blend_mode_property);
diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
index 330c561..88bdfec 100644
--- a/include/drm/drm_blend.h
+++ b/include/drm/drm_blend.h
@@ -27,6 +27,10 @@
 #include <linux/ctype.h>
 #include <drm/drm_mode.h>
 
+#define DRM_MODE_BLEND_PREMULTI		0
+#define DRM_MODE_BLEND_COVERAGE		1
+#define DRM_MODE_BLEND_PIXEL_NONE	2
+
 struct drm_device;
 struct drm_atomic_state;
 struct drm_plane;
@@ -52,4 +56,6 @@ int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
 					     unsigned int zpos);
 int drm_atomic_normalize_zpos(struct drm_device *dev,
 			      struct drm_atomic_state *state);
+int drm_plane_create_blend_mode_property(struct drm_plane *plane,
+					 unsigned int supported_modes);
 #endif
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 8a152dc..c52614a 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -117,6 +117,7 @@ struct drm_plane_state {
 	 * details.
 	 */
 	u16 alpha;
+	uint16_t pixel_blend_mode;
 
 	/**
 	 * @rotation:
@@ -659,6 +660,7 @@ struct drm_plane {
 	 * drm_plane_create_rotation_property().
 	 */
 	struct drm_property *rotation_property;
+	struct drm_property *blend_mode_property;
 
 	/**
 	 * @color_encoding_property:
-- 
1.9.1

