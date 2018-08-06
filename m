Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE15C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300C421A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N3z+wPGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300C421A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbeHFVmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:42:10 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:22570
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733255AbeHFVmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwzkDf7lTlX7MXvHUIqBTaLBXIuBRix1LnKGvzw41cM=;
 b=N3z+wPGz5p20PKDLEpZThTr1xqmV45T8xtgc9AtOSGK9q8Wt39U2ge58+G/EYdrAz4lETHDjpTsC2iTj+ToHHJFoPMlE2j4jncId2LgyOAXot8rUMbcerOj3RDcYmUYxWzDYNAZiPgGYD9c4sZkF0Nn2n9Zq31/tqGZY+cRz3DA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 19:31:31 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm
Date:   Mon,  6 Aug 2018 22:31:10 +0300
Message-Id: <cd938df7516aee05289dc2d7dc17bc85b219be53.1533583611.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533583611.git.leonard.crestez@nxp.com>
References: <cover.1533583611.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR07CA0162.eurprd07.prod.outlook.com
 (2603:10a6:6:43::16) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bf80693-ea4d-4066-c165-08d5fbd33749
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:fjQtGd05W67GvM2azPpqspb2tFkhH1tV/WdtTj2QnyoFEdAMLUXYRBmNg79sy034+rPKYuxOs9KTfpnERSa3IcugW0xj0mWCv5BQ4RZdMpxp/8/dzfKVmv+yZTO6pCqkd8kEdEAfsXXi0fwCJMvu+PXC9Vk6rmnaPNTb8atHUFdBkPO+z/bUWIBAZM3dk9dewjeb9/oHvfjHRIurCtZnPmisv90v8lvopiNVco/fkLE2qV8iTib1+CWyHu7hsPZz;25:qJ18XsUAhJNsFd+i/qK160nDMTV0ai0gpkEq0YWrRAmOvRjltpg8Em+nl1xHvfZDoO4YyEYuLm2A5LXGZHmTzjQYOKaUwFQhiFaParCMwQ9gyG7R+1WjiIZgHCPQKim7g4I3Mygy4IUUzgtOFunyfgmz7X6qOPUxWNjl/PLHWI/NOmFOmKP8U9APInrW8OGVeFlNTvTkmxS2T5/HYwxsP1Sl4DGskTB5zPTVYonOjryYKmOAL1Q0I6xJ81H+DKZP+Mlf5Xk2NHyUhKqk+of/RTIVY6iKWihqAN4JO5ZO1wompmhTW2ybMFJaVfi8uOfIx5Wb6rpxAV3VUtb3nduRZg==;31:uOlGPSp+fcWewytUtU8q1HPRdow1rtsX0A9yTBBsjBX3PWVAjS/MUGj8lNrsFqtdKwK+44fKvnLtxm+O4UKGYCcamIiIgK40OeerKx9PjsQC58Ar0yKePSDdufQYWsU8bshIkJQ/0kWcOOWBPUOVFwF6MxVxZoKoAPUpJk2lRcFxsnYwrPeOd/yZgqYj71EhY0usfhYxp74CyLu7JWPM5RH54onqOuPohUq5xFKRtso=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:HXvsNs5k6O1ULKghI8YRoYYInbTNVRL+gsvQ4YgCo8a+n+Sf8Jip7Ii+IFRPPINtx05xoMsUsPiLzX9sNhxIf6r62vzcXhna7x68SLqy/jDtRomXQ7sJS0OUbwknBd63BHr8WLep3a1xpKnlhKc92U0USA08WKr+tiYdilWTgWPfvwzyLkNBi8ztaLHAI1akfgpF+7AOTgByC7sNYIAcqBw5Bar15500Tq6x3bQcwemdxfAUKYxuFMQ3LufRDfSml3BAQaw1tYJqdHSRr4jNqMvyIz1IGNROnEOKaEVKa/IPQOxJh/lULwQeVkqyRhqF+OWgBYVeQrmMyJ4w3wPGuEZ9jgGcuDt+uRDPUS5TTXneEj4sNfzLdm5jBVvjsLwUgL01U6/3J3FbS3LhykyqVWGMcyEdZzUpbNDkEXe9FJG4DDXER7T/usbsQERFBwDer72wYsQrN9Zz/EvrwL3ffZiX9eIVbRA6UNqfZQsBTPuu8HyjaGiSl8/yYA8bquk9;4:/Q6tDXvfMASEM7qniqw38SDuIIrJ8NqQIXXqCrYibBTh3hQw2c5OrUTvvUlDfDo59yNQNg3hc2+x6Qhjlx0J6ugJE5IbbR4VZNdMiPLnBfXkNXAYKJ1QmDzCYh05mtg6ClGU7PBGaGU04/VYMpjinBayljDM6TGKNPqdkeSop57jKX7xL+r2PIeqxyyMXQk7sJMKzCIhjXyzZpaDUuibQOY8VVhIikFiJflPl0p1V+PanSu9HRoEo96i6grzBHQAN2uiI9nrpMtEoXx2JnRo1OCsR5P1gPa8YM1Lq76R3NzGKx1PTj2iWVz8PdplxBF/dbydt0RKcsEC1Amz8yUSZSucYL0skejnwK8siM2IFFc=
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290A4BF6FA0FA6151949126EE200@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(486006)(86362001)(50226002)(76176011)(316002)(6486002)(68736007)(14444005)(386003)(6506007)(2906002)(6512007)(50466002)(51416003)(5660300001)(478600001)(6116002)(16526019)(3846002)(66066001)(25786009)(26005)(47776003)(305945005)(44832011)(186003)(8936002)(52116002)(476003)(48376002)(6666003)(2616005)(4326008)(446003)(118296001)(54906003)(8676002)(105586002)(81166006)(53936002)(7736002)(97736004)(110136005)(11346002)(956004)(106356001)(81156014)(16586007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:DnMhJmodgl/u3qLu5Ns5RjaAhdNFXBTnN+niG92sy?=
 =?us-ascii?Q?PS9ra5A+UN0VvCMlr1iNnKTkaupcRRwy+yWzPkzikDAjHBCRmQsJ/252s2U+?=
 =?us-ascii?Q?ntFBfeZlAIWa1u1pC4LMhHnPmaScIGVf8zLXrXDVrZFBd2mb17hPBSGe6KvK?=
 =?us-ascii?Q?ToWYGishkOQdP22fIjSpLJIcqHA1W1TvOY1ockEOW6MuCXmsyDU2zR9/sNEi?=
 =?us-ascii?Q?KdD76RVbHwYBv+edDY3j7fdKDE0Si4wY+LznzhHbqDoZfU+LLQum6AoRnrZr?=
 =?us-ascii?Q?tWEBJGjVnOMl1mrChkVGFiZbvhf/DUM1sZ9d86Y0buP5Bkoze1GAXSEBCDkb?=
 =?us-ascii?Q?avdQhCfo5RO5AKWEmpXCR6GpNzeRLBz3E3pbsaCHMF5cXhPhyK5IO3Yc5t5X?=
 =?us-ascii?Q?f1bAj+uFEereTJuArN7KW8F9rCS3FlgV5zNtIow889XPSTfnzhguL+DsiWZg?=
 =?us-ascii?Q?qCIC0WGBWFrd5D8ScvqL1PnoZMkyGoZbetjanev+kZ0IKHBMq7PBhCfGq12i?=
 =?us-ascii?Q?Jh9Es5naKf8Ewi851wsyXJbhEhrY8qPuphIR9EF5cg3NXdwY/GCWFCAuQWMU?=
 =?us-ascii?Q?PjXBn/67cALJTqkNqCuIyss9+9b2TRV9z7ItQqKAEdH5w9+GtqClLHBAKiMB?=
 =?us-ascii?Q?lNXvRrYPorNGjUv+IDkBSGacFKQoJr3UXPSBgCX2jADDBly+WM/9HmmdDWo+?=
 =?us-ascii?Q?I2BZ/ziKx5rpexqGClnk/qujgE7udV4yVolc0sUcq0boUUj/lxK2vlT56huB?=
 =?us-ascii?Q?ZJHKdKCrsaegg52U0xGMQ7s35YayKQr1oBvFxgGwAXtMm/QfdusZb144A00p?=
 =?us-ascii?Q?6V5yzcWs/s8DQl0IfQmF5hNOndBkubXt/h0u7zSnPSN5nvgmIMSkZwn2JRgI?=
 =?us-ascii?Q?VY00+u3sJ2hfggdGuSHaKz6duMoL3r5PyX+SKUjTkxsf3xjBOQ9XMCmlLqKZ?=
 =?us-ascii?Q?D1jp5VScTeuSswEZQJYH7g2fsYQN8wLYB2vEBmlF2W7xNJYET5/6hSRqfooh?=
 =?us-ascii?Q?4zHTCVbJrhB16lISkvSS0VC21fyW3ptZET7WrqOjTOLhBSPGDrUrZzFgkU9E?=
 =?us-ascii?Q?+3khCdA6hDSJ+hKpLeeZYwOhV1yWA5Fh0gGnpN1lwPhod1LAtlZjkvHjRsyh?=
 =?us-ascii?Q?xb22Z0RcrvnEd654o9my41kxiZSoKagxJ3Ah0flv3MBTaHTsz+9LkwSc0Le4?=
 =?us-ascii?Q?4QgSpq0jNmYG3TpSr6sp41ZYkX7NRtsZ2rqDSlEGt7+zpRVo47ckYLonp90v?=
 =?us-ascii?Q?lr5IhITRyvWy26ZPu4U1gsMuhiRs8pRmyABOOwA?=
X-Microsoft-Antispam-Message-Info: AIAwzzI9crnYaWrh+wYkrbH/sqfFwpi2FLwvdzgAuYDry/whtVaZ4yjngJDQ56ai6RcrBNZjosR6FrFr3viZmmpG3fxyb4kzQkOIQKf/lSYoxE+CtvdfxgT6SStGo4EPTwlLfUonQYtSbEIXCkL45Lpjpa561Nkq+WEhL6VBD4zYPXuhJxbzUcpOw/O8JXy0X/SQWcby5XhWInEnKbB4mX19hqjMnlZCsSw94q2RxVq/VDaxCjzKpwjM9hMbfw6/UI5kWxPVMfXU2s1alIGBAYKGcuJK9CiagsGSh8WPKXBZbb/tb/Nb66/sG1zf5aej8kYIZHxzyrfmFJwc+ikl9BrLXGFfvHAzCAov9qLigVk=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:T+we3n3TE0IKXBaziwsjvmWVt2s/BJd6SjYyUe/OR7/8HCodhI1z61xrgoNHnlKNdP40eaS5f0PkKYTQRpijRX8wdDD+gi7yLrZ9gQUEcqnmpFmWZStTnQrvvKy/FFZI6vAA+RHXH9pfqVWoX5WMhZV+3kK6wbYVfPAzUcxiCIh4zjLqTnqB9b7zbMz13cxQSbd9ahTmC1SYoxySG5ZloRlk8j9fmcfhcPlau3Ry9AnJVFxSZ+RRWjFHSzn9b84BnSLOV7lRO2MJ51BuKjWBa9cb2Fs0IUwat6QxAqDcIKJElqp/GKcCtmnDRXXm39sSAjmpdG2q+wggA5fhw4Eu9KjXyYAkbrA1kb3d/5thiaqtMa0+QIPDYkuWj6JZlexz8CPVL2rZfefBfVF5obEL4ARP0aLx/DyEkblcuE40adHQaCUCApAhH5BGY0k1mkZKnaY9sPDhN0L7SE4S/yEpBw==;5:abuWltkhld0MpDYRbhQwAx/aYGYOY4zv0LPajT1TUF4hlUm4TZZTsOFpK0d00Z5PDqb0Cvow8MJaJiXhunydAbR8Ah96y3vl1G6/w8ryowv2HwL4OWXDvNkK6E2/LomrP/WTAlRrGPz8z9tZh04viyy1hD/yKha0/fd74D8Eo5c=;7:u8CF/RZOl/v5TestEHd/5IXXd2/M8kT7q40sEfPFCsBEfFQNLLPaB4/huptoJ7lH0hjUgmQM5zi96MJX2kNLeoeiKuvfvKUk3X/Oqw/MTA7vG0BTH7mAoPCb27hWC19dljLEYNtXEQF3jfQf6sfOvkjOQ2CNDbEj2nCpU2OO55XhZkxn1qRrIxvD5f99fHp+gWHt0qfqSfbLAVull6PbeTKzVWbQWzUJFM8BU5qanQ02Oa3fhZGR/CAVeDNM1DP/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 19:31:31.5476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf80693-ea4d-4066-c165-08d5fbd33749
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
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

