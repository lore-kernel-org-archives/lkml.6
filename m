Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29450C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA37C21A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BLgEvvyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA37C21A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbeHFVmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:42:05 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:22570
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731324AbeHFVmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOTvoSNHzmqZfRgdkzeW1Cx/h4acjhDSfvDT0QW2LwI=;
 b=BLgEvvyGojMFF/YyVcOGzXcLVOE5uvSgtkshs17iqzi0XRdY4ovVp6ZDNZRMDYVeVeGpBGWTZK3XoeuoQuw7ch3Grw36VdAcz9u5H29xG8qKCprP2A8vEiEp9iv8k1Q/8W979Joj2SGNvg7/nmKdjkVgHi6viaAUpv68CKiJCjQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 19:31:26 +0000
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
Subject: [PATCH v3 1/4] drm/mxsfb: Fix initial corrupt frame when activating display
Date:   Mon,  6 Aug 2018 22:31:07 +0300
Message-Id: <a1551bbbb018ebe9526f7367aef536ae26bdc256.1533583611.git.leonard.crestez@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51a5a137-ad37-4fed-3dfe-08d5fbd33487
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:BUVuFmnOTc9hh/yn+5K/oIHNBUfPPq8quPDO3NU9LI0fgYKGdvzUouK6+Dj53OqTtPSQoqGTig5yrsY0cCZ09EgVEgkvUzXl63aQ2RV52uiYL5jl4NWCndGW4SuGYZ+fiZSGAKOwbIr1ZsgcIx/8EcclGk8KGG53yGJNiCLyZ+mydFHvqLEHZsgp86XFDXD1yAZiYJy/zYaNzqIZU+o/xrVB2j2nd4EJFWGBxyhYQ+cIqxY2MOoORy5ysYbC5Fky;25:pSmd/MdmBKy8uDDBZlVPgzN7Jd7VVcBPiISYY2O0N4pq/NKBTWTzAybRg1e+o/8uexaZBcpVQnbGuycaWwmM6beENPp3Whc4394BBm8J2WJUEhkKmdFh3+W/1mQtwZzpXSCvcRyFzD/56PTZV8b9Rq+gUKPL3bLJnGfXn7zAkFeCoMlCrZJkkKQ0EGio867wBWAGWgdZlxPxMg68NMqWdbzJ0/B8k7KySSRyaFkdIYseeCH2dfgBBXO3qAVmUdTnuIf6Q15CeHLIGe54Pmiwn7Z87SKSygnAKgOSwxLQNWla2eBgi30xXbVV4LRR1BDpDc0xvPbHsfBYvxKs4vu7pw==;31:P12nfsRHVCEfj/TlIYTvxkChfASDOpviTJQ7ZRCh1UYuSHJp/tkNt3G8D+HF7B0X/2KlyltM6py1ZbJgx7fpmsym8zUeORyNthfmk+Aebx6B0Dtb2kbm2bMm7Qs3VVjBseboaIGC0g6L2PsAz6gKp9dk4a+mbXLmyUlmG9ilxJFbqHZgTR4kuz06g6HWsYU4hIIFd7koEouUYwAKJavYKpomJBAms1Mc9MBOAMqTvTk=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:LN5zuQYTCO1Y+4UrIEVYwhJ/BE2LZEz79ocr/JOm82OFzOWzyfykkTEp5H69tT1W/pOU12ZcfOHadp0N33+fJiHciiMwVEvdXS8xuN4WqjX4ufDtaI6KmUupbP2oGkeECJtX+dsvTz/G+bF9ANU3+wSPZL6gSZ7Ea5nWKNAGNKlnGbJLAX8VCBFFpbHM9pkcwJ11nE5rRFjoaUgxNw2MkBmzqF0Cac8INTTcLZ8KkMP522SaK1HYfSJCCv4KgQ+KxP4IUdYtU3x/RMJZMEvdZcpnQDmTbHZlQZEZK/YuFCnG8JXtwI5TTjguRH4YcjxYxwci98SxOtwBNJqfbxTvYR9s/4tolWc1B89E93pyatorY+4CLnvsNHXQStbRHAptvDMa2lMjrZL4k+z5pZrGnfK9dDgRH+YpCAdW0e4/JSp+9S6n6Ryp2CD0dmCwns29LSMitZJNLY/1yQIwsqkcIA/fabY7QSTetBpCmqOEr0KJIP7HRjaaIPWHOFZx0q9z;4:Y4x1wG7zOklQiUD3hsqaQoWEsFxlaPkmmqxGsEUvGGBAFcyMw24HyzLMrMxQNT+zUcml1nt3lMs7AlziV91w6dZGDKvindUBfDY5iUIRc091CQi2SU9Sqq6i7wxVVds2PWF8IzEnZZVK/AorVTmqBZrYltEjpzfj3szq+bbicKAWjRZ25M2oW0WvlQWm7EZQvAmUBKrszvggY2JxOS3SVHzBGmrOwvcRpN9y5L/NkDRSuuM/3BFm0OcQGu23yb+q8QsMR3wGPcDDxP1JiVLIFRWHC1en+XPsmiCiV9OZJgVBjqACL/w3+pUGUgwL2Sns
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290C14A7A686763BEBA856DEE200@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(486006)(86362001)(50226002)(76176011)(316002)(6486002)(68736007)(14444005)(386003)(6506007)(2906002)(6512007)(50466002)(51416003)(5660300001)(478600001)(6116002)(16526019)(3846002)(66066001)(25786009)(26005)(47776003)(305945005)(44832011)(186003)(8936002)(52116002)(476003)(48376002)(6666003)(2616005)(4326008)(446003)(118296001)(54906003)(8676002)(105586002)(81166006)(53936002)(7736002)(97736004)(110136005)(11346002)(956004)(106356001)(81156014)(16586007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:b9Dc+nLyb9HLyGJ+UkppVMKkFeMt/hBlBnleun+QR?=
 =?us-ascii?Q?SXQ9ke1Pie7MzoJe70/Q6n8j8vxqZ4+8L+oI6J3XCIkf/MPuYH9qn5KKia2O?=
 =?us-ascii?Q?p7+FhoVIzPDCiHeB1fczrCEnCBwyaPPACa8CFTFpxjTk95pzKAxb8pnt1avd?=
 =?us-ascii?Q?YcnpHdb1DmfQa6GXgWFxxXNeHCbLA6GkuNTJ/AfkiQRFwizIDB5ZTA0JU9+u?=
 =?us-ascii?Q?x5tZRxRYwRfe/RbVSvzhtAjrLxoESh8rX5E/vcPID+jBHCb9mdIkdYOyYSHk?=
 =?us-ascii?Q?Fgj0c0cofjoW8SlfR4qQaTe+WZBVp8gdYMEdpPqWbLWKGn0oYDMZ3R3Vu2fd?=
 =?us-ascii?Q?I+CH05n37bhW4yvOkO1yq/mHXKBOkqPaXGu/AAY1S6vFOE5bN33mXLiSLuXz?=
 =?us-ascii?Q?da7/kSuy+f2pUpIrhrTPqkuTQ0EDHMZMhqAv9R2GGzLUOmVDkeD0TgqyseeP?=
 =?us-ascii?Q?NYLQKC+NeGuYZLGpPxJiYxrnqYItJ7hjU8DSVf3QX1IgQd7/kiN8RYgyDQyX?=
 =?us-ascii?Q?VU8QRNStdJr7ruKem2nw18uhe7O2YoYL9tnU1SVdpKFX4ssx3tsFLJ4JAiKq?=
 =?us-ascii?Q?SfB7OQD3hT6T8zDrzvXfHqV2abfGSiwf2ten0CfUyq8qd7UKZ0heIW3/n/Jd?=
 =?us-ascii?Q?s+rtdmF3QWUmJq68W0Biit+a0kYuxlA4mx3TnUHyxJrC+1puwtd0IM4iNOzt?=
 =?us-ascii?Q?qx+HvYajiGWOVe448L2sD5nHoBx1YdilfmqV1wdHvhsaxaWTa+xjmKqyZdf6?=
 =?us-ascii?Q?u1B9zkkD9Ma+jWP7iJzz2PlN9p4weAKVN/1Rs8gniqtKnXNdRG3h1usgsYfU?=
 =?us-ascii?Q?o3otTJ2vR90DQbLKIP6ZH5YtO3PhL1lQ2ALfdknGanYQHq51ODhJy41sd2ir?=
 =?us-ascii?Q?aQnyq1WU0mtt5x07aYpRN1Frq66eqoW8ekd8BdpZNLTGyMFIQoci3y77ytsi?=
 =?us-ascii?Q?dl++VyhPSRCo3emsREVthGXf8OaHyIAFAhKR+yQUWeVEW7OB+pwK552n9Buh?=
 =?us-ascii?Q?ORDSLWcHqwUa7emhi6aOb12lOjrO/J001DSwKye0gRnVT96KhfPlr2OYiLmv?=
 =?us-ascii?Q?9sMOajlS3ryYmXUdNXUVw/q7cQKpOQlYCigeWImY/yhnZY0ohbgmLvWx9spG?=
 =?us-ascii?Q?fMWLE6cL5ZGh3OZDlzrewdHUVlnps3pJZmEa2B4zX+BbbvlXiC/MJpgvC/7m?=
 =?us-ascii?Q?Rk1+TW2o3K12z2rGg+DqRZYxPLQ96rvt570L2FY+Ruy9uRyaXLfskjVliqXi?=
 =?us-ascii?Q?8K8HU9YACTDA8+keIwIh51fQBPJGqe/TztpOr7v?=
X-Microsoft-Antispam-Message-Info: e5KmAXKXGBykVq7n5/29LD5bm3gNMpSWSuvxJmfmqtU19ndgtSKTd0JG+lsWGCYDUXkoLkzQOiqsqzaAIJP11yDsvqGuScuM/TL9umFY9pBvAIj+7/zcWlgtLEEHzKNy032NfxYK7peeDWU/JjT9uP2PfiGPnG66VF771uDqebYkgrCALdCUzgycgCCj3BPWJVpOr9GsgPLd61dO3VyJEvcQo1GI2DceYjoyX3QDq3Hfzx98G6/TbMMRu83UOQntO4FltvujfGGqiduGOtsyrr5dU5kFOUdTHdy/rNovyK5oWfjsAydl2GlfLSj2nDp6WwPHxtLmebilyr9fHM4BShupkwlAhRUEoP2KHdBxjmY=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:Rvu96NWJiFt/G6mXI+NCvP56Fz7okLi8dkgA3qj1Z72NbBJyK1dop7hMxBMYpiWhyLmSHkAd1p5dnjwypAkHex1UXaPZlmy+sKmc9hvJIYGKUWLjLifFeu3H5GRvPM1nXQfKpY2Ph0JgDfIU74p8k3fImW5jJTNia13l/0dCAGdBny2Fq376a+zeuK69sImnn4Qupgcyy+yXOiaQ96JsH6JG3QZuCXAkW4/ObcLOeh39osR5+RJZcOVc5ptSlHlOemyodXm2eZ4tBfdzW4aR1lbZJixxXmQWBugPUo73k3HSD2n5TYnqracEMi83r/AUIVPx2t3dbh8ej2r7MmZSUtsF1la57XDN0dOSsZRLLJFAZEn0hfc93wPNzPfPMv5urOgd6U95q35b8YFbGK7C8B+ZeuKRYqMYbt/nXfUDKjtzkYAWNskYw5QZWeESEXEDJSn9irLahDbgAp95AQzXUg==;5:oywAXlP4blg8RdPEMBJQQp7ZMIeR1X9xiITZNSs9nAKBaNSk5KdWq1/w9RMdmPo9bScD5Vu3TJpuj0Sao81q0Xm0f1oJN5AImaQ1Fvp0jZCE1nPp0zZsJQjwQ1g/skwqQa1QepPkgCgS7Jfq/Z/2/yQZjIpmC4dseCLP5qMob7g=;7:JtRZyjeUcfYU2tEtwnkdBoS8qrmYqSWvBvk5HrscyZWwgLV1FH0WwReSVDFihMZqo3W7LtOTc8330suHqlXHsUeJQts+qO3pj3ty8+Y7d26cH0XO2rheqjK729835WDaaHmL2zssL4ttcmf84P5oTA5rf/Q0q76s/Dli52XDx5kM/jVdj2rQG2W+u6Y3Xo9s7B2mPyhLUqzlRgHhX7oCwg9P4Iij0uoM0Uwx7RtXyPbljTlu6hlNCy8EZXdOwQnv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 19:31:26.9224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a5a137-ad37-4fed-3dfe-08d5fbd33487
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LCDIF will repeatedly display data from CUR_BUF and set CUR_BUF to
NEXT_BUF when done. Since we are only ever writing to NEXT_BUF the
display will show an initial corrupt frame.

Fix by writing the FB paddr to both CUR_BUF and NEXT_BUF when
activating the CRTC.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 42 +++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 0abe77675b76..db3ff5bde122 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -194,15 +194,31 @@ static int mxsfb_reset_block(void __iomem *reset_addr)
 		return ret;
 
 	return clear_poll_bit(reset_addr, MODULE_CLKGATE);
 }
 
+static dma_addr_t mxsfb_get_fb_paddr(struct mxsfb_drm_private *mxsfb)
+{
+	struct drm_framebuffer *fb = mxsfb->pipe.plane.state->fb;
+	struct drm_gem_cma_object *gem;
+
+	if (!fb)
+		return 0;
+
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+	if (!gem)
+		return 0;
+
+	return gem->paddr;
+}
+
 static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 {
 	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
 	const u32 bus_flags = mxsfb->connector.display_info.bus_flags;
 	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
+	dma_addr_t paddr;
 	int err;
 
 	/*
 	 * It seems, you can't re-program the controller if it is still
 	 * running. This may lead to shifted pictures (FIFO issue?), so
@@ -268,10 +284,16 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	       mxsfb->base + LCDC_VDCTRL3);
 
 	writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
 	       mxsfb->base + LCDC_VDCTRL4);
 
+	/* Update cur_buf as well to avoid an initial corrupt frame */
+	paddr = mxsfb_get_fb_paddr(mxsfb);
+	if (paddr) {
+		writel(paddr, mxsfb->base + mxsfb->devdata->cur_buf);
+		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
+	}
 	mxsfb_disable_axi_clk(mxsfb);
 }
 
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
@@ -287,16 +309,12 @@ void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
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
+	dma_addr_t paddr;
 
 	spin_lock_irq(&crtc->dev->event_lock);
 	event = crtc->state->event;
 	if (event) {
 		crtc->state->event = NULL;
@@ -307,14 +325,12 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			drm_crtc_send_vblank_event(crtc, event);
 		}
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
-	if (!fb)
-		return;
-
-	gem = drm_fb_cma_get_gem_obj(fb, 0);
-
-	mxsfb_enable_axi_clk(mxsfb);
-	writel(gem->paddr, mxsfb->base + mxsfb->devdata->next_buf);
-	mxsfb_disable_axi_clk(mxsfb);
+	paddr = mxsfb_get_fb_paddr(mxsfb);
+	if (paddr) {
+		mxsfb_enable_axi_clk(mxsfb);
+		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
+		mxsfb_disable_axi_clk(mxsfb);
+	}
 }
-- 
2.17.1

