Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A66C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4142173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GGKqFh5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfAIOOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:14:11 -0500
Received: from mail-eopbgr00047.outbound.protection.outlook.com ([40.107.0.47]:52304
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731437AbfAION7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqOI9wGgRSBx9PN7qT/bKWY4ND6FCh6In/F1uNY97bc=;
 b=GGKqFh5XPH0Pe9t2O7eETUKmmgIw3SWy0t5ZaiJDbJAis6XL/7e5vsJHVc1eBGGWLEHZU9VGoL3EP63rjlJ27JBmeAL5++prXxn7jOWNhgHOWMjFG6kCeDybQIFYdXCZB+qK6nOllUMbJdPAoPLZq/uc3VCjhH0re5TL6VpZSpg=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB5157.eurprd04.prod.outlook.com (20.177.34.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 14:13:50 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:13:50 +0000
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
Subject: [PATCH 10/10] drm/mxsfb: Clear OUTSTANDING_REQS bits
Thread-Topic: [PATCH 10/10] drm/mxsfb: Clear OUTSTANDING_REQS bits
Thread-Index: AQHUqCWLxxNKo7mIzECjUXO83WoaFQ==
Date:   Wed, 9 Jan 2019 14:13:50 +0000
Message-ID: <1547043209-8283-11-git-send-email-robert.chiras@nxp.com>
References: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5157;6:Kr7L2rVSy5fByPH0kfUAJUXyLrSqhUprbgZ5JBc5Y1NStYWNAf+8p3YSuIgv+x8mu1mSHvDnjKAnNfYwQa1GeIu2CzbH1ed1euU+9TZNi/1ERB3iK4k8t5AggHhhYPG5ew3e3bK42XH95EunrRC7ew4p3tvQ9+gS0zxiEL0/CHlOBS/rdO69mjbNyN8wnESI1rA2ETR+msAP9TKZ/+omALrGHQlJF7eYes/47G8ivfVVoDOW+qtQx+sg6l21Ll3oaLX056AdSQDWbPKEtbckMThBH7niEs5cQxNJx+kd+1ygf640HUuazSq0yePA5aGFqiQP1fGqhnXqrqwwmYkPZfLiLYQLLC6l72eu0WP5pWFRRM5uWr4EKb+u4glIpUwnObtQ5Imz/exaIqSp2+4iXuAGnlHJlke937xqClS48Eg0pNjVj6iN+WM0RbM59qgqolA+XAA5yKR02m9OKXwmsA==;5:5Vapa4U6azj8Vp3V7x8pgM7cKtAwuulzJF7AGMIELGdpWiDjSWT3IVnBQ/Td5X9o34OKKm43zegxchWjQ0hdB8WbSZisJlS8Bo1FnlU09jp63b9aDkq+X629eP6spYZvwPy8VGzHwDu+l6QNw2Xpd6RWcHTgPtvqb5CNe3YwVltTrqNz2Xm7KWg3JEnyQ8OGpHw7Djs4r3X7SM7q4wKCvA==;7:C7xO/AgH3RdQaqt+5xuDTsIapT3TVb56oy0B/pXXllJP9N0cK3AoLS+qriEWs4+YHdqd0yaZk5BLLbn+MV8RK0tPGxXVKCXBYf2oFMde4sGe6kZ+qVIkMwpbHmRjf6IrAHOCVW7E80KPap/P2zd1/A==
x-ms-office365-filtering-correlation-id: 60541cf4-5102-4c5e-f733-08d6763cad5f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5157;
x-ms-traffictypediagnostic: AM6PR04MB5157:
x-microsoft-antispam-prvs: <AM6PR04MB5157954E1E9C8B27B6E55CCAE38B0@AM6PR04MB5157.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5157;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5157;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(50226002)(99286004)(11346002)(110136005)(2616005)(256004)(316002)(86362001)(14444005)(54906003)(305945005)(7736002)(8676002)(71190400001)(6486002)(71200400001)(446003)(8936002)(105586002)(97736004)(81166006)(81156014)(36756003)(106356001)(476003)(25786009)(486006)(6436002)(186003)(3846002)(6116002)(478600001)(68736007)(53936002)(102836004)(6512007)(14454004)(5660300001)(44832011)(76176011)(52116002)(386003)(26005)(6506007)(2906002)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5157;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2fkKl+6LRzqpZVnti+xpkUtM/xV1f3E4h19Sy6ZFZyKUxOK8X8p2LWlfN0twDSZ9W5JPIWpn/ja/sKYkTeRML+oHxwwcINnYm+j8AB6ghZ0CO85Biqn1ro2ZTNvoeff3gDNzzmST9Jqy6axD1Qvzk9V4M/t5EG64iwMwEd1OBk4HMFsL3r0jQbn01WPWAJgPM6sSPLExxGUuU24hr+htvOhV30dMCEEA+N4/YmeolZEoia/IwdaUm09QGICvbqwejRanDvdBLy3b0zJ4fhnOTY/JDktIwhds6MRVSM17ys3SrYLVmrM6B1KmleTQwZJM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60541cf4-5102-4c5e-f733-08d6763cad5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:13:49.2322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 21 can alter the CTRL2_OUTSTANDING_REQS value right after the eLCDIF
is enabled, since it comes up with default value of 1 (this behaviour
has been seen on some imx8 platforms).
In order to fix this, clear CTRL2_OUTSTANDING_REQS bits before setting
its value.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxs=
fb_crtc.c
index b9437c7..c5689c2 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -231,6 +231,13 @@ static void mxsfb_enable_controller(struct mxsfb_drm_p=
rivate *mxsfb)
 	clk_prepare_enable(mxsfb->clk);
=20
 	if (mxsfb->devdata->ipversion >=3D 4) {
+		/*
+		 * On some platforms, bit 21 is defaulted to 1, which may alter
+		 * the below setting. So, to make sure we have the right setting
+		 * clear all the bits for CTRL2_OUTSTANDING_REQS.
+		 */
+		writel(CTRL2_OUTSTANDING_REQS(0x7),
+			mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
 		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
 			mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
 		/* Assert LCD Reset bit */
--=20
2.7.4

