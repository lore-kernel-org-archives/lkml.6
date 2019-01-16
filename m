Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C66FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9E220657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D2HngC2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392604AbfAPLtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:49:02 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:57311
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392576AbfAPLs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7WyWumENxP9DXD8D4lRu3D43zctHGm88Lpz1BgD+ec=;
 b=D2HngC2QOh+JOtyMvDTaBH7qOp0HQf0LHlS4tUgRqHRlpXDWu0uZMKcJ+iZYZQBg1bOHdRMn1J749vUuzxtEizlpFZA6bU9D8bxCnnEi5wXqvcEqawZhpauP4HdkGUOqE9Mx46qylHGtO0zQ/84ugwDGhFEqNiuwZkxdcD2M7ws=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6101.eurprd04.prod.outlook.com (20.179.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:46 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:46 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
CC:     Robert Chiras <robert.chiras@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Anson Huang <anson.huang@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] drm/mxsfb: Update mxsfb to support LCD reset
Thread-Topic: [PATCH 08/11] drm/mxsfb: Update mxsfb to support LCD reset
Thread-Index: AQHUrZFv48Auw077sk6vzcIatxbIbw==
Date:   Wed, 16 Jan 2019 11:48:46 +0000
Message-ID: <1547639306-19151-9-git-send-email-robert.chiras@nxp.com>
References: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:203:91::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6101;6:35X29FfwIJogQtHYnG5MSHfGAGRVq2wgpT5WIdt/YxzMNF2r6iTMo7YdLN9xXHwUA08VC4N9UOPC1BmWtX2LWRP65k11VN7+x6RQfc+Y5iGcr9pCrbj9iQReQedsi21FN7Lj9m4xQdg2AkLjmGYNev6v9oLrFT+7w95evnz0YUUIh2S9J3P+tCkTzN8JMHxzO9YneoGISltLAzLCoMksUZzV5ZEqCZt7AMUc99MWeGk/2KDqEe6/b1AdbCmp2ykLGTymC3ANLbBa3z4djegS3RtbhY5O29Zo1YT+IIg6wAN9sfFvFVJ2HRtXYhdgJoaHLOEYMf1G+qJts7pr3yPDwhcXtiz23G4GFf96XFBKzgS5wcwn/sx1xvsfs5FurbMxIuGTkefyHEe+H0wsFz/KgEB5mbV/Ro89O4lC/ulhVmQnfIGd942fBLyp8DL7I1yzbk0+6B/z7clzpo/O51VgNQ==;5:qiCfKu3Z0i6Z/2CsXfXP/5F2UqWfdJXagMB1TSi2LEUE3mbeX5hpbU/UpZJDDLV29iEVFEma5zh2YDdR+OX+y17TK9U7YaC5vGjcNnX/LCVonJHzRdQm0kYsIJkV6FqJ6w36jCx8kUWMbqehqeLDhXta9OKkLFW7faCKZBNs5YP6ZMxrK9P//OCDZGsIpWrxYiszLlfbYB8RW4+oC1zsqg==;7:7NeDf0Ph2AjtnlYzFJ6ZLb2vkcnBfNvYvcxd3aecaQW71SL3SCfbd3qJGpeVbVKME0vgBPBC0YwFPLw/0E/N1R0CDOWJeB1Dj31NtxOs3YhfYcsVXyPdJZVuapiL7NdpFWrSggfZUkQU60Oh4W/ccw==
x-ms-office365-filtering-correlation-id: 3fe4455e-9285-4b3b-962e-08d67ba8923b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6101;
x-ms-traffictypediagnostic: AM6PR04MB6101:
x-microsoft-antispam-prvs: <AM6PR04MB61017B1480AB2C1C5BAE57A0E3820@AM6PR04MB6101.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(316002)(81156014)(110136005)(102836004)(81166006)(476003)(26005)(2616005)(186003)(8676002)(7736002)(66066001)(3846002)(50226002)(105586002)(305945005)(6486002)(8936002)(99286004)(54906003)(6436002)(106356001)(6116002)(86362001)(2906002)(44832011)(14454004)(478600001)(486006)(71200400001)(68736007)(97736004)(5660300001)(53936002)(76176011)(36756003)(256004)(446003)(14444005)(11346002)(25786009)(386003)(6506007)(6512007)(52116002)(4326008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6101;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DkjRm5I6hUrnIqkNJMpAp860sPqfISCEmngJ0amKA9ZdD6xexGTAewJnPXx3j1FB8u3uut5ne55OSFrjJR56Pr0XhhDIbyY8SKmETMS+O33FQeXcRDJXiecJBqWQh9RvGcFuruO0N3lW5KfLzA6/beGJFq/Mc70sBmqjPIBNOLItjLanFJLOZfQ7wrlirWqfvXQfnwVAddNokGC2BTQW7G6i5CsR++Lo9f3FpJQv8DzWFp4zUig8gJ+bRM0rqqfoBzfBA2qaFF/w1fqcGZUj6jRr0oygO3nUlUOL+SShUCH9fl88ZPO6olAuYf24JOlG06h6YaSW1wz6zMPsbew0TFSBtTzCIoZZOIsYXbepKH+0ojD9C79OhoKaP4QtBB+0KJkAwvbGx1subjzej9E1SQNPiXk4e4npFHeEhajEQog=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe4455e-9285-4b3b-962e-08d67ba8923b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:45.1590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eLCDIF controller has control pin for the external LCD reset pin.
Add support for it and assert this pin in enable and de-assert it in
disable.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 10 ++++++++--
 drivers/gpu/drm/mxsfb/mxsfb_regs.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxs=
fb_crtc.c
index b1d0267..35d6f10 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -230,9 +230,12 @@ static void mxsfb_enable_controller(struct mxsfb_drm_p=
rivate *mxsfb)
 		clk_prepare_enable(mxsfb->clk_disp_axi);
 	clk_prepare_enable(mxsfb->clk);
=20
-	if (mxsfb->devdata->ipversion >=3D 4)
+	if (mxsfb->devdata->ipversion >=3D 4) {
 		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
 			mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+		/* Assert LCD Reset bit */
+		writel(CTRL2_LCD_RESET, mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+	}
=20
 	/* If it was disabled, re-enable the mode again */
 	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
@@ -250,9 +253,12 @@ static void mxsfb_disable_controller(struct mxsfb_drm_=
private *mxsfb)
 {
 	u32 reg;
=20
-	if (mxsfb->devdata->ipversion >=3D 4)
+	if (mxsfb->devdata->ipversion >=3D 4) {
 		writel(CTRL2_OUTSTANDING_REQS(0x7),
 			mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
+		/* De-assert LCD Reset bit */
+		writel(CTRL2_LCD_RESET, mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
+	}
=20
 	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
=20
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_regs.h b/drivers/gpu/drm/mxsfb/mxs=
fb_regs.h
index 4904fdd..1d85750 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_regs.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
@@ -95,6 +95,7 @@
 #define CTRL2_OUTSTANDING_REQS(x)	REG_PUT((x), 23, 21)
 #define CTRL2_ODD_LINE_PATTERN(x)	REG_PUT((x), 18, 16)
 #define CTRL2_EVEN_LINE_PATTERN(x)	REG_PUT((x), 14, 12)
+#define CTRL2_LCD_RESET			BIT(0)
=20
 #define TRANSFER_COUNT_SET_VCOUNT(x)	(((x) & 0xffff) << 16)
 #define TRANSFER_COUNT_GET_VCOUNT(x)	(((x) >> 16) & 0xffff)
--=20
2.7.4

