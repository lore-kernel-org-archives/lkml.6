Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCCEC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BDF21A27
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZtDyYoDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BDF21A27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeHHSaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:30:05 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:40736
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbeHHSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGLEKB9UmShLbz/Xsfi9i6LiZaAch4VQ0GYplPRFDrI=;
 b=ZtDyYoDK3361yrJv1g2UHKXr/LwR5Y+X/6f16nfP7+1ms9BZd3VIaUjjK2TmR2gX6inZVMDwawwKdb+5mGhe/VagkQFI9B3PGRx3wPgm+RXbA25tybZcOsilb0YAgEmO7I+o/Kd4o3yXmRQ66V4rcvc2vlYeG+KrgPl3HmqRZIo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (2603:10a6:803:3f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 16:09:35 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm
Date:   Wed,  8 Aug 2018 19:09:02 +0300
Message-Id: <172ea0eeed9f129632cc1e279b922e637dff088b.1533743954.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533743954.git.leonard.crestez@nxp.com>
References: <cover.1533743954.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:6:15::17) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf649cb-ff57-46e8-0e5d-08d5fd495633
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:QIrcTrEVi4Wv3YshR98XWFRbvG0LGpdeBn9LentCBmzaCmIQUeYG4gLicCEVF2W+uazlz1I7LGaIEZNAADg10+pELxT2R/3IDViduOlWeKeEEGoXkbX8OJYYlnsfPwbn7TjHzkO7lwIWXd+1xoadYn85UzSBlojBSO+4XEgyFOn/STcK0beXjKYDG/0yjc5RlDGvR1leTjMJLTXsHdf2+KTQeeklJ38wVx8AHy6N2sH6fxIZRhBl7QqYD0a7u80+;25:1rnwf2PVPGdTH9Kg7+X+ozWdKem3jQYIJCGL20keD9FdfplUjphiWIXmfYo9CcMctAU7UNpCMRm8Jh/awu493Vdu9rPiRMR27DqkO/pxQ9jxn4V3XWuuAcLG1aIgGLEjb1LOyewM4ykSkQVSJL45aW2IIR2KANXObO+hy73Lr/ej4bTCE/N9Ice7nVUwSYAERGc3xt61jfl/0Yvnk0GWiskqh0rxmHS9HRcrbOpaDlEk3ZnitEzRR3LjcoSrlSuz7Le0Wf/0PWQYbcnORT8BMWSMl3la3Gu8qUi7Q3PBDZUOimm/kdl9ULv0yC31z7MoJymfPqKyztHj7++HLTppTA==;31:EHs+sXe/S+VSkaZU8H2E5Jzj8MFGY1lAslP4CMYj9wWsVJf2RqMElfGCvM0cYX17hLnP73OnhTyrwS/R6D0Wr1AKITRTNxK3WixEhHembzr2oWuv+NhNPnI9Ym3W+af1mDY/vqwVhwMjfWSCkaxIsR+iUgwTTEAl7r1KRQQd5SOEMNGK40niHinxonDmCH9F/rWtICiqRk2PpxRjI3ydvm8MgS8ltgN0WacQKtzjPzg=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:c5g9NkrVHAmXUZS/gv2D+Ys7AD63gFp9SfVR7IBPM5tL0GGOpP20PQeIqLmh/F/VU2GHbpqnak0eJyjZLIq5huywbilQufHRp/MBWmzmGkkSbyXcLmyIdCdIOwGll+H8JUQpe2M1sYRtVAw8uwmoJUYgiA9rp5syTjW+auyWP3pkm+OHOtWJjCQ5+vBC68eK6pBzDAK7AjJEFUFZv//mMD4LyxFO1NMvrgGanMbBazT+KeQrkq7c21mv+65uwJ01EYhuqzzynudi7ezPBU8UXj47PZjyMPCJ68gwHxdceyFzFZjXw9uylEtYb8LyZtmfiGiGsm/d86STeeGois7eZZeKfXdbAeygLR2achgfoUFDXO6Ou/MefVo0MszXuF9LnUg/CNLk3QLwx8g2PfBodWPcwl3Ny4KzcBctbG9ilBMVAwgd8cZ+FwnD/d0PHxm5Ti3RnbXgIRj5UYEvVdlAyUqHqgqDlPAnUjikRXRqLNAKyoLhvxhmLfzwd55tnnlR;4:QRpveA8fixJVeLRzYm6PIu+spppSzChWCMWzn9+wjvvRzQ2W1CT4d1mBkDm6nbeD62DXtt9Gvuw8nNqocZoDdxAsDW+oW2ZIGPi2ZHZT58KqKmlPYEyQqfYm+gnN7pK3Wnw7z4WE4sG2GnND/Cfr37woFRPiTcVEVhmdDCHrMMoGty+/xsfx4X910snnLKIQL6hzKfMaGtm+UGg/3QlrExATr37XYo6ZMlwCkiooGchl2BAPkgb+L3m8J1j2r+SdKg9lJix513PX0X64LP95wEpJdPOZscexOc2TeYiIRUtCMqk09cpUK0zLtBGP/1k0+Lw0UQxxqsBINdwwH2LnPzjf7Ro6VdUfAfMXqPgjx+U=
X-Microsoft-Antispam-PRVS: <VI1PR04MB4301C907B6BB787BF294692DEE260@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39850400004)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(66066001)(7736002)(76176011)(47776003)(6512007)(81166006)(68736007)(81156014)(25786009)(8676002)(6666003)(110136005)(54906003)(36756003)(14444005)(305945005)(106356001)(105586002)(53936002)(50466002)(6486002)(97736004)(48376002)(86362001)(4326008)(3846002)(5660300001)(26005)(486006)(16526019)(186003)(316002)(2906002)(16586007)(6116002)(6506007)(44832011)(478600001)(8936002)(956004)(11346002)(2616005)(50226002)(386003)(446003)(476003)(51416003)(52116002)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:KKEEZg0OLqhOYBVO38jYtB4cLLmZfGQFTABQLgpv6?=
 =?us-ascii?Q?RQ1zbfyzEmMIkLN8HuuYZkJczaGDUzQOkeBmSWyb0j9a+nqGkpWmnNUlWCxN?=
 =?us-ascii?Q?QjSch/Llg2SCoEqeB6ddfn5Q0DRvBS2Tofv4uu54B3viHVUadLccvlVgmTgb?=
 =?us-ascii?Q?oJPBR6Qdyc1TjDBVUIdAvbju2kQNhCr2rbJFSaBlsenwIUjrnt7LCrq14WcD?=
 =?us-ascii?Q?GKotBtc4rJ2RF/qvm//NdhGtPAaNqxXIyYHGtO/mJwjgI8j4kLp1BekhWA2w?=
 =?us-ascii?Q?3xryAwcX071TkiKZnJM2I92tIBywDi9B/wAB15Up0f0Zpg/LXeq/uVbj26br?=
 =?us-ascii?Q?vcTo08N56/gAUgfTXEtrH7wDL7uGKoOfFy7SrT3OlulhCoFEsYhLx4ykCZ4T?=
 =?us-ascii?Q?mQPcDXmwffKIagKbUzGvKEyparo7G6No7C7vvqKrTt2BpzYRLJvm/Rysec1j?=
 =?us-ascii?Q?nN+RsNIzPNr01xppoHZsKxF26LYtVHnboNfMd0zk7Y0JjH/fPnc0nppTZB+i?=
 =?us-ascii?Q?cKIv8iIG/JyEcC4BF7Wf9GhlRKvYViuyjtfZeLa3uMyASJiy6g0nE+tuFXw5?=
 =?us-ascii?Q?ZDGgC7PsMPhSkRfcl7xP9pYeW8aMsqPsmOPh6TeHyU7VSyqED40U4iz5TuO1?=
 =?us-ascii?Q?onFavc37uIzoF6p/NQGTbfdZaLrRCj8bJJp9GG8QoUElD66v4b0qdSQ96nJm?=
 =?us-ascii?Q?w9/N8DYTq0iPNdfzAxGA30gg9EjKB+TavrZeJu+wBys+j6iQZCSt2EqW6Nw4?=
 =?us-ascii?Q?i6d88O4WkPkc1TAy63+0DLg3kYwcTKtm4UM53Hur2ZgpBos4EcHtEthLWXX4?=
 =?us-ascii?Q?kfYbRBCPVC17Z8bZpNUYt271zjgNWV12iLXB3tQIxbygH6GNCDcOhTJuI9JW?=
 =?us-ascii?Q?Tt1bq6/JHinpGC0UzOwWi0QUatTjWq8sMePTbpuTJX2Rq5rnHerl5biJzcmO?=
 =?us-ascii?Q?xbqHy9/pFqc8N3mMMuWsDILYtDGcCCBRtx9JtMFtpyRf6icUnm+yBrbe+fJl?=
 =?us-ascii?Q?ehCfE+7FLzkcgQ5shE8Kd6ab0tiF8WhwI+7C8F3jiftRl/GggeHS5LlPmj9I?=
 =?us-ascii?Q?bKNtbEIgnxI7OniEBi/xO3cf2+AupFsxdPyRyD95Mf6OMnluPtxAZVZkznUy?=
 =?us-ascii?Q?OQqmdED3Z5rf/1ZkaTrROFQ1bs91w22JS0z2Y9BQ+Ea+6/lQflyqqz17YL9E?=
 =?us-ascii?Q?PmL7omj8oQ60ddjnLvAo0xpISVCNRh75WmYwSyUlXFpqb6qd7DeF+fsty3ls?=
 =?us-ascii?Q?CLA9dIAhqcuycbcHjIpq3KPbpTErnY0jyw/D57S?=
X-Microsoft-Antispam-Message-Info: db/5MDfWycV/ZbzrHI6Ypew8eVMYLm/9jrLyAXl1SIHZyMaAmPhGkx/jKaByvncphW1xsX7LKkY1S6wQVMSfk6v2Z+nS9O8rvIrlt+wsTiDjLF8S9BerDJI3K/bc3rU0UD6jz2wcRzrbYT9lB8kARYfy7wdkwCOUad7OwCFG9rGUDnZnjE6JZLQw8FBkjcqefxIRWc9Wga32HTUIV5k/6jhgN8TT7SQwBAQxK9WQiW4l2JOzXdjb2ZVqL1CWXLW+XIi4FOlZ0VPXn9ej52RiuRfYSy79YieHC9wjkw1Z1h1mqcCtbb+q3JBqHtoOuQZmGoH5YMQ7J6/wklH3VGmk97VFgTUMlSJlbwVwGhUwdNk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:T76NY9EjdbOZXyZTpogKT3EDmsUbFijV3wRe1keg/Q7MjM+u7twf7Agew+yBY8zxLU4DnDdiobsxTtq5xOSvRh/oNq7+jKZ8vfMomEyuO1wTTKLhyUVyYx3ReqKiEdX/0E7o8QGrErlA5a8p4Yp685zvMo3gwhca8RnC0X4LaZRW528mCgi7vaDDN9nFVq36fM+998reE8A0YtoMJgLoh7EMLO6QpDtXvSd4bipNtcZYDOo7dY1fTE7eFeYMydAaT+VirTlRhHYhsbu3hYQ3lGd52erD+wIrK1ApLjiJiQoYdLK8yJVqUC1rwGVr8iXiCp6ONi+dSp2rnfgb7biZYWjRKjB66lYFORi3kVf4zSyCEVfD3w0sTc96Y79h2kEo9vnH1cYjYkEc3wDNLjB9ghYk7eaFUTYvG4Rt8b32MbS3dattiB24Gcs6dVwMRrVqMTJus+rkZc07fuVhqpBFKA==;5:9epmmeeh0602XlssYix2bbD/yoJ82hk62nbF/cxEmsZcqLhHUV8Eoc5VJQrbpEYz3JI2wYdCF8JCDdVe62vT1Fi2CpD9097EfLjgMkogqJQuVjy8vIf59i/cpzOCS2bAmM0w7+90WiyN1BVZLw5s9c5rxCoqRl9K2iV+K7a7HFI=;7:MAvVU+LYVQU1P9qSGIWQdBzM6FWQOGuJICT8eHCm+y6eruf0R/pSdT6iEDiShb1aEVXNPjeQjWuHW5YP1XxfmNUIE73vnl+77DBNiill8xiKURFVdtQoBwtzWFG51K+4Xw8Mw+b0LwBIJbCObYEFZ4qY/l7y58X7xUm0bADno1NycIluqV4bTtYO8lj6bqLYPeI+4wwR5Eo5G4P1sgvqfz+DeIausdbq2fAljQIbREORxsSJit1I5xGGmohXl89m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 16:09:35.0294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf649cb-ff57-46e8-0e5d-08d5fd495633
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lcdif block is only powered on when display is active so plane
updates when not enabled are not valid. Writing to an unpowered IP block
is mostly ignored but can trigger bus errors on some chips.

Prevent this situation by switching to drm_atomic_helper_commit_tail_rpm
and having the drm core ensure atomic_plane_update is only called while
the crtc is active. This avoids having to keep track of "enabled" bits
inside the mxsfb driver.

This also requires handling the vblank event for disable from
mxsfb_pipe_update.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Suggested-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index d797dfd40d98..5777e730085b 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -96,10 +96,14 @@ static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
 	.fb_create		= drm_gem_fb_create,
 	.atomic_check		= drm_atomic_helper_check,
 	.atomic_commit		= drm_atomic_helper_commit,
 };
 
+static const struct drm_mode_config_helper_funcs mxsfb_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
 static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 			      struct drm_crtc_state *crtc_state,
 			      struct drm_plane_state *plane_state)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
@@ -113,15 +117,25 @@ static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
 	struct drm_device *drm = pipe->plane.dev;
+	struct drm_crtc *crtc = &pipe->crtc;
+	struct drm_pending_vblank_event *event;
 
 	drm_panel_disable(mxsfb->panel);
 	mxsfb_crtc_disable(mxsfb);
 	drm_panel_unprepare(mxsfb->panel);
 	pm_runtime_put_sync(drm->dev);
+
+	spin_lock_irq(&drm->event_lock);
+	event = crtc->state->event;
+	if (event) {
+		crtc->state->event = NULL;
+		drm_crtc_send_vblank_event(crtc, event);
+	}
+	spin_unlock_irq(&drm->event_lock);
 }
 
 static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *plane_state)
 {
@@ -232,10 +246,11 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 	drm->mode_config.min_width	= MXSFB_MIN_XRES;
 	drm->mode_config.min_height	= MXSFB_MIN_YRES;
 	drm->mode_config.max_width	= MXSFB_MAX_XRES;
 	drm->mode_config.max_height	= MXSFB_MAX_YRES;
 	drm->mode_config.funcs		= &mxsfb_mode_config_funcs;
+	drm->mode_config.helper_private	= &mxsfb_mode_config_helpers;
 
 	drm_mode_config_reset(drm);
 
 	pm_runtime_get_sync(drm->dev);
 	ret = drm_irq_install(drm, platform_get_irq(pdev, 0));
-- 
2.17.1

