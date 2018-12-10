Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C90C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E171220855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="kw5l57Br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E171220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbeLJPBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:01:02 -0500
Received: from mail-eopbgr70117.outbound.protection.outlook.com ([40.107.7.117]:51573
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbeLJPBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIZ9UvLOH5jxbvlq0lVZ6pj4uSQXmcxCqU5COVJFm8w=;
 b=kw5l57BrRvcHXjP5k9PMkZHkaAPOqsk0YT63b7LAjO7lvEhcsyJCDLL7/Q17/SSc1vs9ofjSm6SO9ctz9RndgYbASPB0yHpmZuDyXM/2xV+pyPawO+OwJ05Kwuzru/UcA8iYGhqsN02g+32lKGDdzx7/gE3HlZlxHSF3bzJtROQ=
Received: from HE1PR07MB3434.eurprd07.prod.outlook.com (10.170.247.141) by
 HE1PR07MB3225.eurprd07.prod.outlook.com (10.170.246.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.9; Mon, 10 Dec 2018 15:00:52 +0000
Received: from HE1PR07MB3434.eurprd07.prod.outlook.com
 ([fe80::e491:596c:4d4e:ffdb]) by HE1PR07MB3434.eurprd07.prod.outlook.com
 ([fe80::e491:596c:4d4e:ffdb%2]) with mapi id 15.20.1425.016; Mon, 10 Dec 2018
 15:00:52 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/3] i2c-axxia: dedicated function to set client addr
Thread-Topic: [PATCH 1/3] i2c-axxia: dedicated function to set client addr
Thread-Index: AQHUkJkkbqmsp7kY3UehxKpVxU5xqg==
Date:   Mon, 10 Dec 2018 15:00:52 +0000
Message-ID: <120bc3dbc7fad29807ff9f7c74575a66e6da15a6.1544453688.git.krzysztof.adamski@nokia.com>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
In-Reply-To: <cover.1544453688.git.krzysztof.adamski@nokia.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0004.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::17)
 To HE1PR07MB3434.eurprd07.prod.outlook.com (2603:10a6:7:2c::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR07MB3225;6:L3R6/LhovvgKAfGvfjjSIsBXPKck1TJ5+SMRfWZsIX9xypOHmMmB85eyUm62O+r/hQP2T3M4uoSbOolMufLwP/DI/JLRtMpsbcV8m7eqWObZ5gFLX3ZqQ7IJpGBa6pZn5CZJU+3dJPtrEab1UOvSOhl5xETxLhauqxRLkkxjKCo4Lc86tDofndPHg04kXAvjEwQoVuvltMZDHvj+lFCBsGzf+IOCIYUgqroTL2fO3MTf1otKHzN+ak9aHcTmjEb5wSJN+AHE+udkCgE4H9Nlh3VKgiQQ+hof4F4dut35UeNMw0+BtYsnHNbh0DVL724bSDC3PgEGHefTbV0v6AfjcvyYS3myWvFWpp6xr8hTKB73OVK8HTn4zlfFH/v8yi13rxid3wEJz3hYi47o1eYa532jcLUjuoYqPLlXWyJ5gtLmeQqGlK3l5KXAWBz2HDEzBPNhInCK8pPHzPJ+PLONlQ==;5:z8Fo49bXNg7Ld6EYGIzeoRx7eX3wC1HjM9VAaiWDURTEblHw/ydK2WEeIFsaHU18J513cf7WJ5qgHDguzjozsf2IQ3S4PCdjI0UvNkYLZEOLV3NZbDQwPRrErCeKkbPBBcDM/XtCgJzOV2ieH96GjfSAQAmr3/iHo6dpUM5b098=;7:xuLgsuOY1fouBvmeWRJ8azzUfDA6zmLxixfWmlQHbbbiieL2XmrypPzA5LOw25DTvWtkK9DnKpj016DaI6yRS8H2DFRCWM1qJDC/OfdBt3lJxUeKWW2WUqUfZAg1MnNJgpcto8zrYJw/qvtA3iSaSQ==
x-ms-office365-filtering-correlation-id: 957e32f7-4ce6-4dae-dfab-08d65eb04742
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB3225;
x-ms-traffictypediagnostic: HE1PR07MB3225:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-microsoft-antispam-prvs: <HE1PR07MB32253AB277B2CD6950B3D57CEFA50@HE1PR07MB3225.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(806100)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:HE1PR07MB3225;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB3225;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(478600001)(186003)(68736007)(2616005)(102836004)(11346002)(105586002)(6636002)(476003)(446003)(25786009)(26005)(486006)(14454004)(76176011)(54906003)(110136005)(97736004)(52116002)(256004)(386003)(86362001)(6512007)(106356001)(6506007)(316002)(36756003)(8676002)(2906002)(7736002)(6486002)(118296001)(5660300001)(53936002)(4326008)(8936002)(305945005)(81156014)(99286004)(66066001)(71200400001)(3846002)(6436002)(6116002)(81166006)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB3225;H:HE1PR07MB3434.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CVK/hzJmT36l0uGpbT8SYgtat7H8qfav09tBuN8ApbWkhudLOOoI/HXWBvWyU8RXtI6+pK2EMplrhlRemdnUFMYvxbdRk4kYusD/r5o8DcTGLDeCgCzqwltAfv2RMK+tHVVgdEZ3MJAzvr0kr7uirixWxRO4J1DDy1h257DDL2cZu4wN/mlZEVxeERP1dnt/6vC23N04NCBeFoqQ6/h+Xvph3D2Es/v8PJedg6mof2k0kXA+OgQVMZTrOGpWcgVvH52bQ43VIXFFrOcA03GkttF5i+Xo9qnVeflbO4OwRI0tK0AlXkP/AcLfIHZT+OoY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E34369BA36F7E341BB244F349EE2F73E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957e32f7-4ce6-4dae-dfab-08d65eb04742
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 15:00:52.5115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves configuration of hardware registers used for setting
i2c client address to separate function. It is preparatory change for
next commit.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
 drivers/i2c/busses/i2c-axxia.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index 51d34959709b..d37caf694fbf 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -337,17 +337,9 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 	return IRQ_HANDLED;
 }
=20
-static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *=
msg)
+static void axxia_i2c_set_addr(struct axxia_i2c_dev *idev, struct i2c_msg =
*msg)
 {
-	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SNS;
-	u32 rx_xfer, tx_xfer;
 	u32 addr_1, addr_2;
-	unsigned long time_left;
-	unsigned int wt_value;
-
-	idev->msg =3D msg;
-	idev->msg_xfrd =3D 0;
-	reinit_completion(&idev->msg_complete);
=20
 	if (i2c_m_ten(msg)) {
 		/* 10-bit address
@@ -367,6 +359,23 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *id=
ev, struct i2c_msg *msg)
 		addr_2 =3D 0;
 	}
=20
+	writel(addr_1, idev->base + MST_ADDR_1);
+	writel(addr_2, idev->base + MST_ADDR_2);
+}
+
+static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *=
msg)
+{
+	u32 int_mask =3D MST_STATUS_ERR | MST_STATUS_SNS;
+	u32 rx_xfer, tx_xfer;
+	unsigned long time_left;
+	unsigned int wt_value;
+
+	idev->msg =3D msg;
+	idev->msg_xfrd =3D 0;
+	reinit_completion(&idev->msg_complete);
+
+	axxia_i2c_set_addr(idev, msg);
+
 	if (i2c_m_rd(msg)) {
 		/* I2C read transfer */
 		rx_xfer =3D i2c_m_recv_len(msg) ? I2C_SMBUS_BLOCK_MAX : msg->len;
@@ -379,8 +388,6 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *ide=
v, struct i2c_msg *msg)
=20
 	writel(rx_xfer, idev->base + MST_RX_XFER);
 	writel(tx_xfer, idev->base + MST_TX_XFER);
-	writel(addr_1, idev->base + MST_ADDR_1);
-	writel(addr_2, idev->base + MST_ADDR_2);
=20
 	if (i2c_m_rd(msg))
 		int_mask |=3D MST_STATUS_RFL;
--=20
2.17.2

