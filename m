Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70A8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2A8206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gnx+ivWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfBWDSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:18:30 -0500
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:40514
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbfBWDSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XaQW/HEkseVmU3CXtl+MXB3SIsDHuqJZGgMs1B450U=;
 b=Gnx+ivWC/FTKoqvvHv6h/Y9Mjsl+/S9mRAOD2hCE5QnhAr769brPplWrwIsp8jAC7zfJgxyjipX6/4BOhFUdlSNSBuTTf3wxCYzy/ayocnLpJcU/a9yx7Zwn3AkFhyc0ZUQ/9VRHwgCg+YlSSwR+ohDE4RkI+076lNMMysW8Y6c=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Sat, 23 Feb 2019 03:18:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Sat, 23 Feb 2019
 03:18:25 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] gpio: mxc: add check to return defer probe if clock tree NOT
 ready
Thread-Topic: [PATCH] gpio: mxc: add check to return defer probe if clock tree
 NOT ready
Thread-Index: AQHUyyZwJdNGpsao40SLPie+4E+0rA==
Date:   Sat, 23 Feb 2019 03:18:25 +0000
Message-ID: <1550891629-29004-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80ad5d71-9300-4e4e-39e1-08d6993d924a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3659;23:ciSgMRsDpDoebrAnRiTbsLOHSKzKBgQ24sK0l?=
 =?iso-8859-1?Q?4z2W8sqSSzvdet+xOF8AzuDJUJNp9psOv2T+/brYAGPUEqQepFQJclO7vm?=
 =?iso-8859-1?Q?+VAgRyXy0Ls1Lzj1gR31JgLauvlbxH6Dlu98GQyGP5PfKfXBagVh7++lDd?=
 =?iso-8859-1?Q?MvH5ZQTkvbjpA6vA53NE3mzzFRr1NRu9KxXsjLg6tzuvyEvqd5ISkllgHt?=
 =?iso-8859-1?Q?gmhSKEU7IPSbO++7fIBytYH3SzH9v279xIbXoc8LGVOY4InvByyrM1vYAt?=
 =?iso-8859-1?Q?E84jm6Rm6o3WdHXgst8+jqe8ecqdwrXJ9jphWlw1P+1aJKtI4QmKMXEVf/?=
 =?iso-8859-1?Q?GNq3ucYw9D8wcu85/s4e7aHfVNkerzEMEI11OMtTO2qm9xAeNKfVA2GzO2?=
 =?iso-8859-1?Q?S32RxReQldfhoA4x4Ju7nrQWnYYpIqDwur2c7PO5MuqkqJUQPraoRKhBLS?=
 =?iso-8859-1?Q?7ETQ1jOa67yvqlSjo8JZVlqsJtmmnjTINSIcrHm7CC4bJTyM2EvN9R+XHZ?=
 =?iso-8859-1?Q?1DuR/NMy4guECDpfTS7nyyjgVxjxZAHvNh21+kYIb+ZMFxnO7n+Kh/lTMy?=
 =?iso-8859-1?Q?oOgKsoQ2KR5LRykzZwsQZv+QOCURuN2SVTgF5fg5665Qgs70PFdObPNeuJ?=
 =?iso-8859-1?Q?bZm3iImb32shTNDFPTq2XmvbRl8zbnvkOYUGr2RV6LMDBJbbhm6JKBuFn9?=
 =?iso-8859-1?Q?TZ5M3MA/5QxpprsoYiT52dmHZDH6awyFpgsYdBzDg+ORXa0/yNzdK3jIf3?=
 =?iso-8859-1?Q?DkMfyz2EZMnb7GqsOEjzy3R5uCU/WpnInYMa07Hl0MAbFGGDmpD6831Xn4?=
 =?iso-8859-1?Q?fetPtKNCTTviBljgSomARgHbwuNY4iiMWXIr9pPmpZD51G5dH+nWHL0SkE?=
 =?iso-8859-1?Q?KTOd3Tv9D1QCPE+VROMP1h3lDsuTBVU4fZc3IJ3Hu26W4o2GyAA4ZcVWcE?=
 =?iso-8859-1?Q?Q9cc1Ba+AvgznJ2wvjGGlYurcKkQvsuj+wYEJU1Plig1C3K4AHoHV9pKrk?=
 =?iso-8859-1?Q?HrMhvr+SywCn1lg+mfxDZEkg6xb5j66KnIchUho+2m5AussVZD/ODZP71K?=
 =?iso-8859-1?Q?JDbWncwsBjrZAluYGhu+LtoRQSCnN3rtO6kA1jEVbhdd1dq/M/7h2k/0zK?=
 =?iso-8859-1?Q?yLDwDGDBFg9L0ODZduxI41htB40FZ9RjsX4eOv1fP5QPsY0nM9oF6shw48?=
 =?iso-8859-1?Q?KRJCyVARoCb+l6tIaR5uISR8itkuIDma4eobqWo8HJJUrJelar5cRVJw?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB36592A924CAF5B35D233B102F5780@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(199004)(8676002)(102836004)(8936002)(81166006)(106356001)(476003)(5660300002)(6436002)(2616005)(2501003)(52116002)(316002)(71190400001)(105586002)(6486002)(305945005)(81156014)(256004)(97736004)(6116002)(486006)(3846002)(14444005)(110136005)(71200400001)(99286004)(26005)(186003)(50226002)(25786009)(53936002)(7736002)(478600001)(4744005)(36756003)(14454004)(6512007)(6506007)(2201001)(2906002)(66066001)(4326008)(68736007)(86362001)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hM0T+MV9nRwattefI5SP3SZoplrqpz1e+3N0Dga3vL4omMrFd+LZznrtLLwPI3nsPHclX+ryi/KKCkZPUkZuMYd8KQXrvToodyI0kib3pGcNtjoFfP5kmZ5ZMjApaSb+d43a8cHQUFC83s6fNCikPme5pVOfhLfpoMMCt02sfMzaA5ZBy4A8q1vhTxkux/qMSCwL2X9tRkA7DoG0T8Jcj0Wzo8lgnGP4ndrEeZr7DU+9PPfaeF8eMSVOHsAZb/YPTTW7Yg8i0DpfzznSFN8LWxP1CthBDBXOc5nV82W7ZaZGajGU5OnQZA6uf4zAdQT4xYJbDddPsPJu5DI1+rGmaYVK4YnOTv3xb3InSvJoYuLxTUgKuRwzzS0zENQmeNBRy7kszMEqWwSLzMGUKoQ5K4wc9J3CyM4043UXcnPNKeQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ad5d71-9300-4e4e-39e1-08d6993d924a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 03:18:22.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8MQ platform, clock driver uses platform driver
model and it is probed after GPIO driver, so when GPIO
driver fails to get clock, it should check the error type
to decide whether to return defer probe or just ignore
the clock operation.

Fixes: 2808801aab8a ("gpio: mxc: add clock operation")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/gpio/gpio-mxc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 2d1dfa1..e86e61d 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -438,8 +438,11 @@ static int mxc_gpio_probe(struct platform_device *pdev=
)
=20
 	/* the controller clock is optional */
 	port->clk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(port->clk))
+	if (IS_ERR(port->clk)) {
+		if (PTR_ERR(port->clk) =3D=3D -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		port->clk =3D NULL;
+	}
=20
 	err =3D clk_prepare_enable(port->clk);
 	if (err) {
--=20
2.7.4

