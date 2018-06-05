Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbeFERL1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:11:27 -0400
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:19319
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753731AbeFERLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:11:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>
Cc: Robert Chiras <robert.chiras@nxp.com>, dri-devel@lists.freedesktop.org,
        Marco Franchi <marco.franchi@nxp.com>, Stefan Agner <stefan@agner.ch>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Date: Tue,  5 Jun 2018 20:11:05 +0300
Message-Id: <cd4ddc544a27915cab58a218223723eb18525c21.1528218001.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR06CA0023.eurprd06.prod.outlook.com
 (2603:10a6:206:2::36) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:O04jNuHummun+RpWmpzzabcgqvf/K6UnUWglkMRz6JTwr2UirvC7SQZgQTU483zIY3eKr+RqcN1HwK/nO8jKNq0q78DleZyVgZ177EU/qZTQfci5WSI1xlW+1Zqk+9tCwL3CCNoGh/AN8EzqWKE3W3L/YVrEKHDGnEhBaGEVEo45mQLkWsTWcLQRrdTQ8LWIzkXVDJ7Uou174Dhu73/ejtI0QOAukT6DIUQK8DkEzh1ODadeQgW6Gn8ByKIeq8jI;25:ivk4sXV2VNPeRIkU1rWJnWDl0s2mVi8CVt9o2HSb49t7rwx6ZVRTcQ4RfKIBmf/p1EA3tDlWL0SlOuFluw7tnPMrcMQWJ7f72aTsVRP3LvADUzBY/wpnguZfF6tGUsmVqwCtqd8/CBDKtTWL0sdBGH2OZlUuMdPD4/XsypFBj/l08wh9ktqN2881/Es60ZiOAnz8d7zbnqVfi6Oq2zWTDQybK/4iSxUBrvdOSDXCov1NfIJtAOKwiHPrRwE2h17sdREcmgnUqqFHeT2wWNt+MsxBuj5Q/zdaJtKay5sYjd0CD0Qw267/b7VOSAyJy4nbyxasjcoNbohxbjR+/i042w==;31:DZWrmGbSYuTqlXnSULefWnMNPOaaDeuMY/mwN/3LWWKwhhR23hbno/HJy1lAjqK4ucT5rSTDmvNhP1JepmhupJ9hnGam9Gg3sgZIYnnKsgWKTTfOs+GSDNwgTzWKmbx2MWu0y7QCSyuBA29QhmP6V+EER4akEd4ryp9VoxmM9SclERghir/V7UiRywsLpFERUIfr5lM2gGIfObxAd4WT8azSfWh48XilIUeZpSrqO58=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:tgV9rli+bvEvby0QQGW5P9VU6UA63tO2FfwPCyPMBJ93v3ACwOh1KEQSCILtxLEUyNgK1GQe6nCF970P+gad+UhzfHq/fte8eDk1bOdFeR+KEphFcOb0CLx2CJkRC9gnC7XACcGr9AW3Ss8CGKi+XQuVTgBS9xzwOlzQPZ3ts/gooWVcsGkUC3IPwM+/raEP9rFN5tp0ZGrCHkTOaVE5jgNU2uGtmJv4YfIHfhn0y3PP+HpDMXjZlVaUuGp+F2gRBx7u1hnbngQQ4rlBKjpPqYPPVb+NqvYr5OIUxF9M4mdt8mealL4Wbr9nSF1WUSCF+weiw0QbyjvpGhWoZJFmUPr2e7vmJr9Okjs/dEwxQ/708rjhymBpph5nwOznAEclK/fhfQjkDdUyI62uwZJk+zgkzgZ4g4FVZfhrXQn3Q7MZctRRZ5wg3E1YzecZDBRm0v6J5CwjZz2sbYoG96GOZdof5ap1ajB7OSEBe0p9P0Cj4PoJuOFU5eBHpVehdOmj;4:iYuYPEMlJEtF7jwbvSKHv7m2BQ031DVxpJ4nYbElz4hDrfMEvlnEMZkmhFxb/Dw/LbESX2cLBM/7d5RYGn4sx3Zp6PA6Aeik0+OGv6gmWTY+1CMoeZhx0Gf4hxqttgp3gjZwyehwnwcQAHDa6UwmilMblj8oWXsqGiW33l4P4XGvTwJlW00a9q5GBXlvr9b9mMDAbdtcENUNIIqK50LiG4LzEuZwsRQB5ChJBZT76PcT65cwBpcErg9lhRkVD6ZdtTfnbiy6QvapVKDsHxrQVwbXWPwiMSpYcjoDrdNMu0J+d50paDc71Gcz2wJqRVNc
X-Microsoft-Antispam-PRVS: <VI1PR04MB4301EEB2BECC3D67C4DFAAE5EE660@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(396003)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(6486002)(106356001)(6116002)(5660300001)(26005)(25786009)(4326008)(3846002)(97736004)(7736002)(186003)(6512007)(110136005)(50226002)(54906003)(16586007)(86362001)(16526019)(68736007)(105586002)(956004)(2616005)(36756003)(81166006)(575784001)(59450400001)(386003)(6506007)(486006)(48376002)(118296001)(81156014)(478600001)(305945005)(6666003)(44832011)(52116002)(51416003)(50466002)(47776003)(476003)(8936002)(316002)(66066001)(8676002)(53936002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:9YoL8xDzQtWaEao72WrMPCrjB8dZL4FLkcvmRdmp7?=
 =?us-ascii?Q?dsIH8K2dA64cuNXvl//cYjfqXcRRWP8HXZfs+aHNYr8LEzNA9wxDgtjx+yG8?=
 =?us-ascii?Q?NW2i+ZbqR+YftTUYculctirgfViFvzXpzhA3JMcqucrMMRV62DhYxAP/7pXj?=
 =?us-ascii?Q?pnWSabYkUS978tPxPnX1MpIgpEKLYdQdJzO0lfMksvmvWZQVWSXS6aF8sy9Z?=
 =?us-ascii?Q?hF6xXVk/DulSp70P79a9M9RqZUfkbOSS6XQX0lz1QyZ4TVGsNQ9oJYamTGGI?=
 =?us-ascii?Q?nFsNqKEaW+leGtY/qhBOeykYpJWGeBvu/Jt8B/c1SihUuIGMDtTkfUwCIWs3?=
 =?us-ascii?Q?FpmbSfxERLShBAagHngWl6gN/UV4yyChJNDexIocn4pPR6ByYk1idSh9bjYY?=
 =?us-ascii?Q?pt3ub13j0CzyyRrz4e6JZquIw1+vO4/6H0MQug6gnekcKnV9hCPpJZjca+Uh?=
 =?us-ascii?Q?fuZkfYqw4fdajjCyKwZ25kWJA6ErxXArQBjtLSpMWa1ISU0Tx1zd+Vo8rHvH?=
 =?us-ascii?Q?OH3LMiFl9ZrTnsoNYHSXXYLZ044b+kh5iRKHG4dp/yVDT4GOd5qeCt3NpPWg?=
 =?us-ascii?Q?5KT1HVvKRLC+3htIZFMpa8GL2EMg7hDXid6VI/hdon9xsN4YZDvcyMqZJrTx?=
 =?us-ascii?Q?KWnV/Ftsjb2AxPIhFCGpQLeqclmmJNafkz0pddEuK4X4rZkJDWEl71osjQDU?=
 =?us-ascii?Q?gfGPFoMkV5JQVvXOGiW+TLRCgsKBGpgaXU1PuHMXWK6XIx+sxvpYD8fsqzjE?=
 =?us-ascii?Q?+9SSvAOQ8vMNyFprGbwyCBdvMGjXMUOdOu58wLPQqImjCdGUF6bX4h+Oc2vx?=
 =?us-ascii?Q?p5yqXNcT9d/KHAhXVAR9AvWpSw9VuD7zrAHCeN0qUUoQW7gRL2edj7IoYBd5?=
 =?us-ascii?Q?sMUOXPgYRfvXAHiiFsFl08rLUcRZNyKZAV7fz9wpOCpBlHbFwqLuP3TjjFd1?=
 =?us-ascii?Q?s34YBNSTDzShn8ocvZ28C2oxnOps66UUv/ptyprzIjCKVTEdUnKsAwf3Ih0I?=
 =?us-ascii?Q?Y2LaaVxmGPBUE8IXIN1sf0fVIOIxvqMq7kgeYwY9qZRH5SlYJ3tg+mnkysAV?=
 =?us-ascii?Q?yITaclup2V+9mS2EFSk6fpM91quGT7LIyL+BZMcb6yql8SEv6/5IBBRavA5X?=
 =?us-ascii?Q?1GDpoljgNy5n2mBBvoDyl6LVYXl98AAKpNIclttv1vPviQfJQajDcnLBDKz0?=
 =?us-ascii?Q?Y5MW+teABT6l/hghD78Bb2fFC0Pc8koRDvWFFMuMT20G56t+nCarvCnqku6I?=
 =?us-ascii?Q?8gNLTkD7sOIbrzwZbU=3D?=
X-Microsoft-Antispam-Message-Info: Y8bjmKMpOAimHXMkexIZPspGyMwKi/T0leMOPTL1s8eYudzhp9JDCADfEdJnzuqnTUB810oas4Zyz8inRp/X1+k5Ue5cW8X2cGXj7+YJXRgOXvbTxcVAOr/NH8lvOQkhZ8HoAwe3dzkmGU0Gm1+mJ3UG9im7gpz4aU7+SHM/3YJuB37US1xiAmrWUVPwnW9V
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:x1zUKanGyzVg3oDtH2gM57J/hsjwGDe35A6uVq4AM4FSdRdmI3RGquxpXO5H31k80hIA4hOqqALapJgPTJlnDsgUlmtopv4+x6ymaWHRg+LUUYVWC5TNUFuJ6RMix4If3Scnh8OrF+emniFNA+izkFDUNaQM0zoQOOXdpm+As2CDTHNWMw1Gzv1Lous6/x4imF5rnEj9VRwdzT885626Tp4edEzCfvmqfg538iAXF853IIkzrmp51hGzJ87oBfwVb/H0qzggQUqIYkdg4h1rHK6027FXzmL3sTGiWJ7fw4I7F+JQvv/ZWo1vS4UO2qJzW6chTtFdRMX762whsRqHvp4RVfrRCpTpkhxzl4VBDT6yPylCTP7846EDpn52MMOcHN9Peq21GRgs0/PcLi1XxI0XLaUAJ8V1Iji0TVs6lV5H9yUkJyF+i9DE7pqDVF3kAT+/R+qLX2h5yn7cGHVWMw==;5:cP7RDCtORZLwxlya+i5aqJL8wScdiez5ArLHJDDZHsHDjupdylS/5oLkzxcd12cl5CEylp2XGrFJuXkSAGKBWk5ymMAHVikZ700oLw405KnuA4aUrwwEF6+mYrvLVBhRb31/LGoNizZY95U7RFAykeyPeSC8nVH7b/iUfXZGtpA=;24:KogCFcM3yWlm0XYp0TJEQvg4c8MB3wJVlLjn+LjXtMlTe+CEOfPagSyW3KK46TH5TqXJE4SzLNewfVNvCislWo9woUSp9KgWiVrBJ6Mb7Vk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;7:Afqad3qpBTza2GdbOZ48pJ7uRrPPKqjXR4yL3YJBn8D7gmzfnKBteTAU4d5vuTYgRvsYhKr4OaoOOsA3ewn3IfbZ9KHXRvd2F7dIXoctAlC++/KO8ZIebDjhhf/ZvvctKPGNIwOYZUfF5hmRCVXzlxhvcey6TArfiCvfSd2lcVvDSlVhxyxrIRAeBqS5gNm+YOCGKqhD7HkAZTunvAi6sL7WzFopnBltxIlP7s5h+3X5BiUTPkae5ONk8dRHeUCU
X-MS-Office365-Filtering-Correlation-Id: f2a54eaa-9f12-45e7-bbb7-08d5cb075a6c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 17:11:17.3671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a54eaa-9f12-45e7-bbb7-08d5cb075a6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding imx6sl/sx lcdif nodes in a power domain currently does work, it
results in black/corrupted screens or hangs. While the driver does
enable runtime pm it does not deal correctly with the block being
unpowered.

Fix by adding pm_runtime_get/put_sync to mxsfb_pipe_enable/disable.

The mxsfb_plane_atomic_update function can get called before
mxsfb_pipe_enable while the block is not powered. When this happens the
write to LCDIF_NEXT_BUF is lost causing random corrupted pixels on
unblank.

Fix this by splitting the writing of gem->paddr to nextbuf into a
mxsfb_update_hw_next_buf functiona and also calling it from
mxsfb_crtc_mode_set_nofb.

Also add fields to mxsfb_drv to keep track of enabled/suspended states.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 38 +++++++++++-----
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 72 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  3 ++
 3 files changed, 100 insertions(+), 13 deletions(-)

This was initially written by Robert for imx8m but I tested it also
works on imx6sx/imx6sl to DISPMIX power domain.

Tested on imx6sl-evk and imx6sx-sdb with SEIKO 43WVF1G panel by
blanking and unblanking via sysfs and suspend/resume

Testing requires a modified config (to enable MXFSB_DRM):
CONFIG_DRM_MXSFB=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_FB_MXS=n

It also requires dts changes to enable the DISPMIX power domain.  The
dts changes might break drivers so this patch attempts to fix the lcdif
driver first.

Patch 2 is a RFC of imx6sl changes, imx6sx is a bit more complicated
and it also interacts with PCI.

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 0abe77675b76..cce2ec1c80ae 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -194,10 +194,25 @@ static int mxsfb_reset_block(void __iomem *reset_addr)
 		return ret;
 
 	return clear_poll_bit(reset_addr, MODULE_CLKGATE);
 }
 
+static void mxsfb_update_hw_next_buf(struct mxsfb_drm_private *mxsfb)
+{
+	struct drm_framebuffer *fb = mxsfb->pipe.plane.state->fb;
+	struct drm_gem_cma_object *gem;
+
+	if (!fb)
+		return;
+
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+	if (!gem)
+		return;
+
+	writel(gem->paddr, mxsfb->base + mxsfb->devdata->next_buf);
+}
+
 static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 {
 	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
 	const u32 bus_flags = mxsfb->connector.display_info.bus_flags;
 	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
@@ -268,35 +283,41 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	       mxsfb->base + LCDC_VDCTRL3);
 
 	writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
 	       mxsfb->base + LCDC_VDCTRL4);
 
+	mxsfb_update_hw_next_buf(mxsfb);
 	mxsfb_disable_axi_clk(mxsfb);
 }
 
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
+	if (mxsfb->enabled)
+		return;
+
 	mxsfb_crtc_mode_set_nofb(mxsfb);
 	mxsfb_enable_controller(mxsfb);
+
+	mxsfb->enabled = true;
 }
 
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 {
+	if (!mxsfb->enabled)
+		return;
+
 	mxsfb_disable_controller(mxsfb);
+
+	mxsfb->enabled = false;
 }
 
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			       struct drm_plane_state *state)
 {
 	struct drm_simple_display_pipe *pipe = &mxsfb->pipe;
 	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_framebuffer *fb = pipe->plane.state->fb;
 	struct drm_pending_vblank_event *event;
-	struct drm_gem_cma_object *gem;
-
-	if (!crtc)
-		return;
 
 	spin_lock_irq(&crtc->dev->event_lock);
 	event = crtc->state->event;
 	if (event) {
 		crtc->state->event = NULL;
@@ -307,14 +328,9 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			drm_crtc_send_vblank_event(crtc, event);
 		}
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
-	if (!fb)
-		return;
-
-	gem = drm_fb_cma_get_gem_obj(fb, 0);
-
 	mxsfb_enable_axi_clk(mxsfb);
-	writel(gem->paddr, mxsfb->base + mxsfb->devdata->next_buf);
+	mxsfb_update_hw_next_buf(mxsfb);
 	mxsfb_disable_axi_clk(mxsfb);
 }
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 5cae8db9dcd4..c889cac2e275 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -100,23 +100,27 @@ static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
 
 static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 			      struct drm_crtc_state *crtc_state)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	struct drm_device *drm = pipe->plane.dev;
 
+	pm_runtime_get_sync(drm->dev);
 	drm_panel_prepare(mxsfb->panel);
 	mxsfb_crtc_enable(mxsfb);
 	drm_panel_enable(mxsfb->panel);
 }
 
 static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	struct drm_device *drm = pipe->plane.dev;
 
 	drm_panel_disable(mxsfb->panel);
 	mxsfb_crtc_disable(mxsfb);
 	drm_panel_unprepare(mxsfb->panel);
+	pm_runtime_put_sync(drm->dev);
 }
 
 static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *plane_state)
 {
@@ -175,10 +179,11 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 	if (!mxsfb)
 		return -ENOMEM;
 
 	drm->dev_private = mxsfb;
 	mxsfb->devdata = &mxsfb_devdata[pdev->id_entry->driver_data];
+	platform_set_drvdata(pdev, drm);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mxsfb->base = devm_ioremap_resource(drm->dev, res);
 	if (IS_ERR(mxsfb->base))
 		return PTR_ERR(mxsfb->base);
@@ -256,12 +261,10 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 		mxsfb->fbdev = NULL;
 		dev_err(drm->dev, "Failed to init FB CMA area\n");
 		goto err_cma;
 	}
 
-	platform_set_drvdata(pdev, drm);
-
 	drm_helper_hpd_irq_event(drm);
 
 	return 0;
 
 err_cma:
@@ -417,17 +420,82 @@ static int mxsfb_remove(struct platform_device *pdev)
 	drm_dev_unref(drm);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int mxsfb_runtime_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct mxsfb_drm_private *mxsfb = drm->dev_private;
+
+	if (!drm->registered)
+		return 0;
+
+	if (mxsfb->enabled) {
+		mxsfb_crtc_disable(mxsfb);
+		mxsfb->suspended = true;
+	}
+
+	return 0;
+}
+
+static int mxsfb_runtime_resume(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct mxsfb_drm_private *mxsfb = drm->dev_private;
+
+	if (!drm->registered || !mxsfb->suspended)
+		return 0;
+
+	mxsfb_crtc_enable(mxsfb);
+	mxsfb->suspended = false;
+
+	return 0;
+}
+
+static int mxsfb_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct mxsfb_drm_private *mxsfb = drm->dev_private;
+
+	if (mxsfb->enabled) {
+		mxsfb_crtc_disable(mxsfb);
+		mxsfb->suspended = true;
+	}
+
+	return 0;
+}
+
+static int mxsfb_resume(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct mxsfb_drm_private *mxsfb = drm->dev_private;
+
+	if (!mxsfb->suspended)
+		return 0;
+
+	mxsfb_crtc_enable(mxsfb);
+	mxsfb->suspended = false;
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops mxsfb_pm_ops = {
+	SET_RUNTIME_PM_OPS(mxsfb_runtime_suspend, mxsfb_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(mxsfb_suspend, mxsfb_resume)
+};
+
 static struct platform_driver mxsfb_platform_driver = {
 	.probe		= mxsfb_probe,
 	.remove		= mxsfb_remove,
 	.id_table	= mxsfb_devtype,
 	.driver	= {
 		.name		= "mxsfb",
 		.of_match_table	= mxsfb_dt_ids,
+		.pm = &mxsfb_pm_ops,
 	},
 };
 
 module_platform_driver(mxsfb_platform_driver);
 
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index 5d0883fc805b..d8ef4a053f0e 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -36,10 +36,13 @@ struct mxsfb_drm_private {
 
 	struct drm_simple_display_pipe	pipe;
 	struct drm_connector		connector;
 	struct drm_panel		*panel;
 	struct drm_fbdev_cma		*fbdev;
+
+	bool                            enabled;
+	bool                            suspended;
 };
 
 int mxsfb_setup_crtc(struct drm_device *dev);
 int mxsfb_create_output(struct drm_device *dev);
 
-- 
2.17.0
