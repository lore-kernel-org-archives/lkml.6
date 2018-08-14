Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FUZZY_AMBIEN,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9421AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3630121738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="q0jzkysF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3630121738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbeHNOUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:20:13 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:10365
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731370AbeHNOUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZFsSdY6k24PIhV24ydIBPYCzgvLRDKnsxSjansbzXc=;
 b=q0jzkysFXO/53KNb2kjWNmUS6hRYq+A5uinF2kp06rZ26GlYl1IGU+uK3h98jOFIUIDdAhVmCWjXSnpG+PZvzJ2Y8/k4Vnt//vLGt/Wer3kej4YxZMsrPQVFlrkKRWJFwxmb249EDu5Sv3iJiTKga+1eBW96LTYA8eGPCgVwHuM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 VI1PR08MB3533.eurprd08.prod.outlook.com (2603:10a6:803:84::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.22; Tue, 14 Aug 2018 11:33:16 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v4 0/2] drm/blend: Add per-plane pixel blend mode property
Date:   Tue, 14 Aug 2018 19:32:55 +0800
Message-Id: <1534246377-31346-1-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR0302CA0016.apcprd03.prod.outlook.com
 (2603:1096:3:2::26) To VI1PR08MB3533.eurprd08.prod.outlook.com
 (2603:10a6:803:84::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31ded68a-3109-48e2-6963-08d601d9bcb3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3533;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3533;3:7/7scCY+KdbJv4UMebdljm9eDS7g/p0qlvNaAMzThIaBxe5lb+U3hF/x6DImy5yEEPuVlAiTtaPs6D1vU3NOTYistYIWvycR8qLKSeyKS/JSFQQro+VMRhUXGXPos2Vvt1VCuQNGOuP2lYNEPXswAPQU0olcpyrNBZyYfWhgzEwqcJBTY98wCzeVtHawiboaO1pqz5+3WyJ84psBhetLTjLR7KSfyniwYXOmF+X/cDBjZz9KLQVV/9vjLA5D5k98;25:2UK/3yV2Lc+EP4AaUnK9LPblRPT9FVO2L+xfE2aJD2WFI6S63I/saSyNRkDbS3qEuC8KjWV9FFSXlBK+5P1qdA2YWGX0A46xx+PmcC9c8u5TS/eU7d90zGGEIAWV1tmjA37e35K5zCEyVS06Z0M/MTTROU3kNzCrJFvR5ZtQawQGmeu3tBNe9BfwU8CNp6fnQnjW7cJgDBUVTEDWEhEfTbz07/PzJz7BuOIYeiDWnEvsY++U3+e0jKtC7p/EivV4MQdNng1k4cyR1J/90OphBQ79axBFdJMDbSZ6c0n7JsJXXuT1QyY94H8ccRgeL8e3m8o6EPOU+/bywBeuBrLgfA==;31:Bk/RSd8VFBQGrlMUvxnV2xZl6Aj+MjNGDE9YEyJu3avzrGIsLHBhlba4BbLvH/Zru1LG/7tA7kTsVg3bTHrJ597jELVLepaZQM8BIZKuOCrwVOHxkldDfpeHTrb2DeqhyGutIpDwjO6eAhYGk1+kAeQi3a21HqxlTuANYbDt+OL2Xtv9tcaj6NVH/GCA8rMgLvYiRijRL4ZdM25GSjHTwASZcT0EPEsja7yvZK0j/pQ=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3533:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3533;20:iSXMS7x/IpCjhaHBOU4yx7NF8wC/0Ufxe3mGNV+RC19jQoGexRDc0TdBpAGdqPIAvsx70LO19eYjdVda3jkfaXZKfKTJNPQ7irzSP8jfRPnwD8QaV//MWcM5lu1fIzbFtbjeSo49S06xcgmSEeyk2naiUEfd4qVAKAOAJEqMWW4/seUX4wKhjE3WCF1teDP5sYNLDU2KRxWOgx4ptxt4lBu0vAx2IKCT77OJ4A/rFkB30K66gC7hP/a3b66+0HgmsKZx3inz5yuLlO0tDs21xpL8EObwBxviUizy85IjkDtcBgSaDMLmwuJunD4YaS2SYKxnaVMQ6cFey9KRMo26vQ==;4:MTrr4yKWO4uUmyJqbJIV2SdhnV2tEujR+DLGR3WdzW9XS5PxKv3Gk5ZcqfHLJnC/wGKeN7YZcz+08Le51GJ+iHK76CWomYLPVkj2gvD/pi4Mk6TMua5Um8MUU5VHf3Qm9bq5mw6xFoWoUaW+0bzkSjvVnWim4qO34UIgImTMw/eBN+5cPig1wwj6DYGeahbO9jg9Nb/EndeEDmlmFyzqSLi6U/zL/8DxSJ+/deqGe5m50suQ019Vr42FqwI0UsiQ38yEqSXK9da/WKLGIytXEA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3533D9D04FDE4C4642F94C0D9F380@VI1PR08MB3533.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3533;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3533;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(8676002)(6486002)(25786009)(386003)(68736007)(2351001)(2361001)(2906002)(36756003)(316002)(53936002)(34206002)(39060400002)(50226002)(8936002)(44832011)(16526019)(81156014)(6636002)(81166006)(4326008)(6666003)(105586002)(106356001)(26005)(7696005)(51416003)(5660300001)(52116002)(305945005)(7736002)(476003)(66066001)(3846002)(37006003)(956004)(16586007)(486006)(14444005)(478600001)(72206003)(6116002)(97736004)(50466002)(47776003)(2616005)(86362001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3533;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3533;23:Mfxi+qnqGFIMui+NjNeiAqaK5OmmGUQL9jIyGOt+M?=
 =?us-ascii?Q?8L6UTKaZIw2qv3+zfpRW3QSXuHOW/TUUwQsZunHma1HZCvpy5cr2yRR+hQHi?=
 =?us-ascii?Q?MkTXde7ymbj0gEgIhdvp07YJ5Haxj1XwHFkFXOgQmjVT1YID4QaT+9Anj77q?=
 =?us-ascii?Q?MoDuLauGLMj8CRW7MiH6XEvClpbsyXb7B2r7Nn961DtL/WqA+YXW/Gge2bdL?=
 =?us-ascii?Q?KZPRpQ9cJ3HJxlP08+6gZfuBnRSSG7GMWr0utm9SWnuyeBjYTCBlaUPlQrUo?=
 =?us-ascii?Q?c+N+fi5vmiqFP5nH+c3rJgqivTKvtpaRlKAlkcmOSFwYd0PsmoWvUerx6tYM?=
 =?us-ascii?Q?kBM7XoAdojL3DgzY8rF+0oi713kUBf32MK+DYXu3SFwFJXO0f0jX/vSjflvz?=
 =?us-ascii?Q?/UwL3V8+60u9XAsy1HDNB4BkYwTi52zgK+WDZTyHV8/ZmDqsNkhCXqEu+pWo?=
 =?us-ascii?Q?EzQlZhP5WSisXVDnXAhzhf+5SXRdZBiiSEVGqQVVgQyfa2TVwsDV2LjzSCXa?=
 =?us-ascii?Q?I1m3y+Jgx7StF5n1wddwT5KezkUg0e22P7Cfs1i3V6I42hrRcmKW7hhVl6fr?=
 =?us-ascii?Q?3cSOOvpfqtrEIOsOZBIbFoluBaV3b/3lhR6XLBs0ZdUX2g9KGAf6tM36yldn?=
 =?us-ascii?Q?ig0W9inyNl+uxs1UDPyCyn9mo2YS7u1qgva4NurYCFsoUo9IEbpH451QlWkM?=
 =?us-ascii?Q?qsH3PToqOnUp2xBR7jOxqiP7U3MT3S0H2Jzn19P1+EaQPHH6bLtRehNFzGsF?=
 =?us-ascii?Q?1dZnjatQL12cbP22b5J41WonIrLNcj9fOQKlr9n9xYq//UcBfgxSilO9htkC?=
 =?us-ascii?Q?SXLw2enpDEk7d0o75PU4bwoFswjH6tFbIYDPdr1f/zqaeQHwTm17H2TisQUB?=
 =?us-ascii?Q?USMDwVx6PlonJs3AmXpvy6dg/FX+b67jUMKJmRY1omVjKq6q30MhzBLnbaDn?=
 =?us-ascii?Q?J9K2JQRgWBuuvhmxx2nlx7gB0jQAtADv1oaaN/+7iU5Rd7bSbMexcOanrjUi?=
 =?us-ascii?Q?sctTgmdJBOWt29EFynWCHHUMTLoZ0GZgt2enYpamItLzxYd3nRRxjVZ8y2Wn?=
 =?us-ascii?Q?dB/MesCTUEKIAOCONrb+BSOSAbtozs1lv6Rz1ybMJyBb5PaIAdeRedGE4j5K?=
 =?us-ascii?Q?AuFbd0qocVmrmcrKYIQK16av+auQAMPLASV2eKDMJR5U23/pWxFf3t4X3jTi?=
 =?us-ascii?Q?aUCM8T7Oj2Xp/tAABI709mF9XtkwbCdkx1Ge3/yOsfYCRFdbfG6Hngy35HOo?=
 =?us-ascii?Q?qTxmKM/H+4mN0jspSY=3D?=
X-Microsoft-Antispam-Message-Info: fv6SnKIfhwG59dDvN/kIc2lBKAXxTaZCg/Sro0AUHf573yvHcwu5N8r6Z+iJgRA3/5l6IC8jv1SWLtHEebfOZsExGoOU/vCS1CdJ6VMKQJA427+OSZXQS0GYKT+FLz5K+fL4kWCK+s8ltuX8Cgs3O6Z7QEd+mzcjn+kay331JYvNG45QVXwdj58hSijhoOf1T1KRX6e/QgJIxY+j0TRVzhhpsqOS31mOfCDyk+tTcIfUEZXPhaMNoL59IECQ4OtFSmJvFDZTUqGQEnOe6OdfPQ8fi8jg1EQXJR+0mgST+eBfnNliBrTzNcqGh2NLdoaFqQXstkwSM9cMHPQf1lUyqXpkqdFJ+IdaQNcrodvvQTw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3533;6:MUkCBrqZ+jQMDpfcELhA9/VFMmyajqFRaObk4i7/sby74d5S4QiDUrnmjyfuX6dRmhbchlD/4LrVsMjeHUeiULoBc8k7YFaSGFn7UyAsAPfVmag/027dX33bI9AgNQgmOggWP598o27PRyj3+j6TTpXYCwcgynZoh7Yd+Dr6DRL/O2ijdA+pxpZGSxfDOIfj5B7FOVbwWinltROU9tusUnj/2u6dKTDwHxNaUA9uLgZISYjPm+RVERY1t1aNM9BBjHNU5SnRniZS3MVYfURpGBrQrvIG72v56qt3vag/1kARmH0dRxAm1psoANhceDeDvT9I/VYeOo/8kJp3CKIbvES9kNyC++13ADCmTs9RRW7ei9UR2f78vUEYlePCggA2bXpwFuWSWN/H6N0/R8wYYgUIIwnGVc8NkmdKTVADw7l6zU4FCUcnV2PL0w2+LfQQWnu7leHBsG4cvpP8tVmLww==;5:gaMSkl/GCLY9kb6qooIBh47xbICNu8yev3MMIg73T/EwEtiYAUNq2vLpKUwoC+yYjVJfCa83khC2x/XQPXX7Mr9EmFYeHbCDgkP56aFaEucUqKC4YtaYiVcMIuVyGQbBRMuDzUb3rE6AKAyu7bytQD6Y+SMAh8HV2SNg/KrJlH8=;7:7EzOgCSLIby7xQPPwjI2nmvPOPA0gnBl2DjP2lR+sTAB5nuUomKYlbWwFWf3S/mbzrGe80iLBbEi9d60o5bBqR8lvbAeVc2IrFJtbri6hoU9VT0jLRBwD0Ks42GzoZWcJ1rl4ZbuhhixL2O3L63cCJUbt5P4JFvxz8nLUfOUr9E8Nx/gTAgVUKzF2eWqtvJVawWS477P29sHqCmcSfMDhJ/NoyDAz8jyLmPr9PPoc6pe4NyV9ZABk87S2vdF94lo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 11:33:16.2877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ded68a-3109-48e2-6963-08d601d9bcb3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3533
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
 - Adds a pixel_blend_mode to drm_plane_state and a blend_mode_property to
   drm_plane, and related support functions
 - Defines three blend modes in drm_blend.h
 - Rebased on current drm-next

Lowry Li (2):
  drm: Add per-plane pixel blend mode property
  drm/mali-dp: Implement plane alpha and pixel blend on malidp

 drivers/gpu/drm/arm/malidp_planes.c |  74 ++++++++++++---------
 drivers/gpu/drm/drm_atomic.c        |   4 ++
 drivers/gpu/drm/drm_atomic_helper.c |   1 +
 drivers/gpu/drm/drm_blend.c         | 126 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |   6 ++
 include/drm/drm_plane.h             |   2 +
 6 files changed, 182 insertions(+), 31 deletions(-)

-- 
1.9.1

