Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186CEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCE6208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TB2+AJMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCE6208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeH0O5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:57:44 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:51613
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbeH0O5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OuoQ6ME5x9zl8DUCFOnuDh9S4MBGNhyUDs21Ggg0Og=;
 b=TB2+AJMAxN9/8MQ8PYLTIBkBCCtXz3nK0+W9U6C3C5Npq7Kz2MMtIjro+7qNHXpvAqrYYWGtKq6fBQmTTUX4TeAI+FIlL86gSa+hcE+uzj0rssUOxgmpiNJZ0rW4y45dFiivHS2GIm0QbyqJ0xQ7Xq1XiyNZgCxhxHvCRXQAqDY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 DB7PR04MB4297.eurprd04.prod.outlook.com (2603:10a6:5:28::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 11:11:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marek Vasut <marex@denx.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND 5/5] drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm
Date:   Mon, 27 Aug 2018 14:10:41 +0300
Message-Id: <1dcf9e3b25ddff3906491a2ce43ac5c1a3f2167a.1535367027.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535367027.git.leonard.crestez@nxp.com>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::22) To DB7PR04MB4297.eurprd04.prod.outlook.com
 (2603:10a6:5:28::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a6baa19-2c1c-43f5-be9f-08d60c0dce90
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4297;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;3:ot013vanC5Jj+5//rSBJcK1HJPZF92NeiL5viWN0KXmMgn7aErblao+tE/IDydzI0iZqoIKaMI8jMwkxIhjEWgljkePCYhocE/9+7lEeyInRnb1X7axExNC5jDJGnpIZMHEEsqxW2DmUzxRv4Lgi91ocChXLeHgNThTbjKz9gL0YAbZ8j1QrWSLv46sHDIF5IT+aHQe0mlz7rFSmy9BgNJflOPr6gRR+9QCLyOxzjOmP4PUVuBBbQivIihfFh1OT;25:NBurl/sDJOHS+VlUzMWLwteVLASp14ldHbflwLE7pJQUXTdc0IgVF4znpVFvTVS5OunmmzdWo+xtBDatX2Nb4+zonn52nkmqtWSvlmp/c2DCbml+Rx3dODAaNmzeqhZznO+nJZdmmtPL8z9sYzSIBl1tG/0Zq/cyqSjHP0ar3IoYxSPk3mMm8RHWQM9OyJAKADYmLTykctxhK398VHgRP4q7KM90rG34sV9n4VAxCpMYdpK0KKYGCDfmNAD79BnbffUNbCL1xbYCDlju0B7RDMcAmgP5rnpPqhr5fzy3DbpXkEqAh+uVaC55mK6oykQ4BDM2leerUc0+APmdJs0J7A==;31:F5AfNW0j5LE4LC9wztaOfvnHMZ7EjGDa3BfcrUNl1+Ciry90H32Dzd/MKjxfUQxzATBDlgY1yt/wxi0bOSU1t/hS/bdrt9uDZaLbGGKdti/au28svllE1agD18IkKgAYR9HBygkuMCiKN3tzcxccNQRubTHuYm8m3DiAm0+ylvp3auFpiaplare7V486ZjfHXvh+tu4I2b5r3Ptt/tzHS0ID3S/TLinWK4ZwI0HpMq0=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4297:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;20:Uw7cIEoYS5anspA5zJhRxd8zunMw3HAfMteUUkPZySnKGluBp4IXJM/BoiexQdsR8R/8k3juYUjmydTEv5g/Iu0RNOiUm9k1FZP/pEvSuUVj0PmtE2JeIAI8sQdRnCSQKsGzNy4XHNIm/w/Onmd1RisCrQKwApcb3+M9pR6Jchmdi7E/Y8KW4Cxu+Sxq0JS8RJ2vMJ8lnmq4KK6P37ehUw3eC288yDy1RCGp+GQ38z+mjzQB2BEei/QdIoUlkgMEr5FQFKsBTSWXWGOu64B6Mco+21RUeLnfenhVzFFdM2URBt6Ygs/XAVhzKmEiJA6OBwh1QmC+IrDHCK6zrT8qQeTR3HYX0fOMvPN9p4StyJIBY45ftagidyMWmLlL0CcmQyn/gQa3c3Z5PeBAVXzGItcdCEjtbvkyWyNzqjt4zS7uYemqtSafKaatPBHkTFKO+ns1R42+PLwpil1Vb6ZPzbjGOyW8ISOBvUZXwRUcAUjr3rlNS7R+uFzKrBDaJrm7;4:dNlvUITbSXr6y5Z804REN4YtaPe8axayaqQeU76TpPAyUlmtWdoZWrLFoNoIul2i90U+h+sMo4cJoE9+r9up6k1M/iA4CNLGRHM+6a0tDYuUzosAB2tt/VgLgulpkXKufba1xn97/GftaIVLZQxICE6F03ptjF/REvFg4F+6vc8GQpDxCPeoyi/fhZYRBbkR+YJFW68S2VU1iLK8b836thkzSEwDR1NxwnCudKB8TFUkZ3/gJBzU3/xbYJjGRc3ti8tmrV92ZSHAzFbTqtVMO1866NYc6pSJ+pqYjXcn39WRBWWIXBtvxlkILFD5Ke8MwT5kUwz2jblDu2BO0vRXurKe/7dR8aA1NS0+ui57fC4=
X-Microsoft-Antispam-PRVS: <DB7PR04MB42977CB9BDC140E7027DCFE2EE0B0@DB7PR04MB4297.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR04MB4297;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4297;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(4326008)(305945005)(478600001)(6666003)(2906002)(36756003)(446003)(476003)(2616005)(956004)(81166006)(8676002)(81156014)(14444005)(44832011)(7736002)(486006)(11346002)(3846002)(6116002)(47776003)(6486002)(66066001)(97736004)(86362001)(54906003)(5660300001)(53936002)(6512007)(16586007)(110136005)(316002)(50466002)(48376002)(50226002)(118296001)(105586002)(8936002)(106356001)(51416003)(186003)(26005)(52116002)(16526019)(6506007)(386003)(68736007)(25786009)(76176011)(69590400005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4297;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4297;23:9lIlWoL8LLQibNHBvSGMwegJ2a23ddL1tlgyaOVeE?=
 =?us-ascii?Q?+V1GxR6cRkLZ3nkVW7dxgcnyMbomwuxp9r9bggsMirEyEi20jeC0GmBXe37t?=
 =?us-ascii?Q?y0Eg8l6FDVkfdHW+Rt8kpXWPzQQ5HS++/z01cppgM9dEQu1HtyVgqOshFCI1?=
 =?us-ascii?Q?8xlUcaWzrt3nsL9yiBuMhNW46k4es1hyT1nvNi1MXq8Ues3OV+iRLKZpKNnG?=
 =?us-ascii?Q?759a0FrLQE/RSLWpRTrMs+eyVq7SFot/xwPa2eDUeNDardoAiwE3Xg7INWcy?=
 =?us-ascii?Q?zVxmzU5ZuRZfQgk2s3D+M8mf1yz/+lSoJTo9JLq3RVpQ0VnQJto9CGhP7CYD?=
 =?us-ascii?Q?ixBs7DDtHU9Zh9A6mCLmPVGFZ2lsYhkwQxWozfazsnD0YGyMUJVy3C86b52P?=
 =?us-ascii?Q?MuXG7CZUkQe91/81gqRsWHuCNrmckZi7yRMVJX0v3CN5ix8DyvJn910mB55Q?=
 =?us-ascii?Q?89tGvda4OC3o78QpdferhOBL6tREmsKY3MjCgJSFiL213x/q3yJi9YIq1Nky?=
 =?us-ascii?Q?/XIv0nZZDCfC2clhhkKK2ijZ6Lg4q4uB9r+stvhSeZgjCHivFaQmb9k4GKA3?=
 =?us-ascii?Q?e2mIWjQp60B7mkg3YdN6EphP7rv53lWcnJoHdBK9DkEX2mlX+/XXuiJ9kmTI?=
 =?us-ascii?Q?zeLPExl8jZRAT8aBl7bNCeGMPoCST2a7B2VQ7OnOagmsuLww4ft55nqToMjy?=
 =?us-ascii?Q?z8EK2LfDamfziDO+QUBqaZvxQSos9IQUBdY9y6tDpbeWelulEqgPDbEibMoL?=
 =?us-ascii?Q?eZ2DA9occL4zCaKfXSueFGvjFYvO3KG/O24Y4MEvdUuUs5me6clFI1wQN9ck?=
 =?us-ascii?Q?woFsunfHPgJOiZxErwMvR6EJBWIinwIhDgkVaPXEvaAWcLqo955d+NNZH0iI?=
 =?us-ascii?Q?YZrWCt5Z46FQbVTPXM5oQEMtItGSfTNhDmFymti8CE3+kQyiacQFsziUY/Bp?=
 =?us-ascii?Q?fsuXCSV0DYpLFNUFuH4LlMgb9DMSfedlUbO5R9L7rsSTBcYiKNLVh9VCpjXu?=
 =?us-ascii?Q?QjJRpp9GajprSSO9ihX2Jik1qX0dQj8qaJ/SYMcbEmhntb6nnZoBHtoDZaBv?=
 =?us-ascii?Q?MnPGh1Z8mgDPQkIssl3IOQrI2XF1CRrRCa39Qly5bRhda288RPg+xpwHSKfO?=
 =?us-ascii?Q?CBZooi3A33I2rtwGQnmI/mNdBIv2YQ2Sid6HhNshwgp0N2StitePcHuVK+q1?=
 =?us-ascii?Q?UsdpYQwxWJXes+5GKAu8RBxukIjHJZXzq6RU6RuydElR4HZQArBA2d5E1qKx?=
 =?us-ascii?Q?nDGhJbaXsDWq/P05KTPf787rLXjI+Zgv4Q3xH6PBcPcGmZDvT+8mnh/qe8+a?=
 =?us-ascii?Q?/TXRTm3DCP+nmC6AA3bpgg=3D?=
X-Microsoft-Antispam-Message-Info: Nz3NAXtUu3uNF8ieziwJ7clWlix1u+4NFbj9digibdXu+4VB6w1TQmlSdTMsolWSAyJwiak2Y2ks/UVXorYzUBsw3MT2HZMzo11jG/aomUfef1ZAFpOhKJqeF4eJqqcEwGyJ11fUkDTBCZDncNENivdWFi+EKJZh3j3iYMMdx1HeToAxl/SAbYtr4fnGeLPlJnsk7EhvqtZUrIiYV+8RAAP4aYEXY6IY72Dnl4lnqQe/S/iCls4vvdXDHmyMwQmdgbfSvSZFsspnOs3FUdrSs8vAJGt0gRpzw9OaxJ71MprpGGrO0Prj7vL8BERfktSIbuzFo0BV6FSgS7lnTAwnYC3dCij9je2u8eb8KxF2r38=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;6:VoTTYnbBfmZRSw1QN5309zs5qa7vJDnf2XrLvAQhKKjSh6Xo9iJ8kZ85YOi4ADUIQjMz5N0KujOPnC67/gf/CsVAkHRSNCJ2npy0N0LFmiGfeSUq/E2xU+QTy8bY8YvYnWs6yz9Uopo7uU0T8oiHu2XwrZxQEOEgX7Qz+OLVn4bghaistrjDzvXRa5kJd2iA73fTFyAgg1e2Z5EFvnyDhat1oVu2x+2VSMvkq/R8h4biJU9N/p1T+y1j6gb2yZnx/6Cz5GtBUp92p8wxgSVIkXE0PSekIjCKEOCqltdExF4fykNbvNrexuqxpc6W7T9aoHlBcWu3q8m7TWgErofqBdI0raieikEAmNjyzLoNi9Rw0Ae33nogRFM1oF8uTVtAATQxEjn9Jio/brKB9L8vif9+LJLnM3Jdq9g9Lc8CmJpdJ8Ntj0VD3bdo579JrTfzLH/zicu1Fm+SRpKVR7XBPQ==;5:pPFHGJy5qMqX/egf1yoVGsQRSt6L8BaxPFM8IGE/JpgToTkWBvxnteNEjpv7kAgIsDMbaRC89+9CS/lxizT/Z0maqE+0nQ8IByqJV0/3QQn07YoU3mszX75VZKNBXEKDCBvxtdpfufxyifJTGusmEpDRZYX4QZPcw4ys2vGO1Qs=;7:WCG6Lq5VfxgXhTYIuWf2V1sSDZzOMcBDOh5kGUCtlHjjwhico1Yy1/VtXdeHqrnw2F1r1G+KBjE3wEKCHAPMnqrvlniTmhh0RfLbXNy/avvMlZgKW8ICrJkb6MGR130f5FiUMqTn/Yil54EW0CbeErZObJPy8mL35+cn/JtF6ojOOAY4y3cj8XhtXNOypuCBKpPitGgZob6BzfL581OpAywizD1yY9wh5fue5s5K76RE/k1E8L1NBvrt42P2I7uK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 11:11:14.1241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6baa19-2c1c-43f5-be9f-08d60c0dce90
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4297
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
mxsfb_pipe_disable.

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

