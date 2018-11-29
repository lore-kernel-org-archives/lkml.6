Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD122C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A0621019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XHbqSxMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A0621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeK3K6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:58:02 -0500
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:14161
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbeK3K6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCsbsgQmcddqWFPKZGRjaCO9Mw8rCcfefcHcNvIk39g=;
 b=XHbqSxMlT5CIp2n35PxWUZVzuV8z/eKY43u4g1b5SPIcXvLhXWyJNJBRDypFfhB4LsIRM7+IvryNZ06OnQ9whnWGG7Y8xMYK8O5VKPwM96EIwBByThYbBKnZVXR0BBgxG9odXSl/AlYzc1c5gqk4sFWpvljsBPmH9TZIHhMaAyM=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3429.eurprd04.prod.outlook.com (52.133.19.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 29 Nov 2018 23:50:22 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%3]) with mapi id 15.20.1339.032; Thu, 29 Nov 2018
 23:50:22 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx: Use do_div in SCCG due to 64-bit divisor
Thread-Topic: [PATCH] clk: imx: Use do_div in SCCG due to 64-bit divisor
Thread-Index: AQHUiD5KFK4Z0p3iBkSuKiBJAh5VpQ==
Date:   Thu, 29 Nov 2018 23:50:22 +0000
Message-ID: <1543535413-1256-1-git-send-email-abel.vesa@nxp.com>
References: <20181130090325.7526140e@canb.auug.org.au>
In-Reply-To: <20181130090325.7526140e@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0064.eurprd07.prod.outlook.com
 (2603:10a6:203:2::26) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3429;6:nsVaD2qw3MhCvqmmYWgcGx5rm3HogZS+pb6GXIXZY5jyi/WWX3pCoE1Gb1LwW3+BtL7AJrwH8pqWk2zWK6Allh06x3Tu3MIR5CfRgwNhsj2oPGxF4zZwjn4j2BFMKXusx95hDouYGrtGc9xL4pejZ3lFlxLimSLyUgXI4ylgiCaRrGxPlWS/78kF5Ys63khfOZCHtsDcYObfYjWvFqAGpTQuyjPLpO3nt9RYl2DzSOxXmBhep4zMYVpzL2B3iFd8bMiEr43SZVlLIFUix/76tlmwpVXv+AJq6u1HeKD8aBLrl4ZLE8s/UB8Bfl2iAygEkwmUiCPlek8DIWuh3EWxqORMeBGW/oDLX717iqRdd3NzbBCGeEi7zukwJ/Q+dfd4ZEsgPLJe/dxoVfYwu9B4euR+mmykaCf8oC6fB0LJVqEvTh8PC6fmVHQoX8vMd1H7aXcxTU60vXr6ss9HBkZLQA==;5:u/srRmAKi1wKEWiwrYtYb3Z66GrnhM+0fP0hzG6twsyzXo+wl6DCCChiY8tWMS7eVYpa18dkvBa7/GwAeDpzaifLy2gDGPulT/1BpMZZMlDVrheqQudBsjGHhentaxSYzLWbJ/RNq1G3N2yL6XfE49QzY9ukuOtZSvbTqh4yJ3M=;7:pWfgshN69kfZbZWfuA/bgVBBkMBVI5fFGyt0EDzEgrEhImGKKNRuwSG0BqU107MQwjbr91G3VTWEIYBrkW9zr+1LoHRaZkUg7uy11anVly+bpe6oBd367x3a40KQcMtzlcFZDD6tZixAw5B//8juBA==
x-ms-office365-filtering-correlation-id: e783df38-05ab-496e-42a8-08d656556cf1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3429;
x-ms-traffictypediagnostic: AM6PR0402MB3429:
x-microsoft-antispam-prvs: <AM6PR0402MB3429D1386687E483F80532FBF6D20@AM6PR0402MB3429.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3429;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3429;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(189003)(52116002)(102836004)(446003)(476003)(6116002)(2616005)(6436002)(99286004)(478600001)(6486002)(486006)(86362001)(575784001)(71190400001)(71200400001)(3846002)(386003)(6506007)(76176011)(2906002)(14454004)(186003)(44832011)(11346002)(53936002)(25786009)(106356001)(66066001)(4326008)(26005)(97736004)(105586002)(316002)(36756003)(110136005)(54906003)(81156014)(305945005)(7736002)(8936002)(81166006)(8676002)(6512007)(256004)(68736007)(14444005)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3429;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6+1xccLGuCCSZKuOJFJG9rQFf1eGmMPr004k3Eh6Pwuq0/aomqMzSvztzRL5BjnsfcHQPYEpsxfvAnXWHJy3+g97w5+AajapnFyoF+4k+Wtm6zEM8KU5AacoNY2Q7lWvX+dXxaJHA4prVVezO7L8g5ySaNCj1RAQ39ZNDZeNOXwB1FVlS4ugyMbutSiX6AfzsTw0wha1w/IZ6lDi5hTysoiiWLqSJExV1CMqBdbYEOyqspTPf+RirB00VnK3XPL08WDDbqFGGm6vfww8GsUJV8ZubYfiNaY+erC9m4w9+NYhEHEiTsOzaRHAQeAHMHiAl1NaE4XOtHUtGoHd2KfrKx3kgnobo0DRD6RUOIZYoT4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e783df38-05ab-496e-42a8-08d656556cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 23:50:22.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3429
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm32, a division with a 64-bit divisor has to be done through
do_div() function otherwise there is a link failure like:

drivers/clk/imx/clk-frac-pll.o: In function `clk_pll_round_rate':
clk-frac-pll.c:(.text+0x54): undefined reference to `__aeabi_uldivmod'
make: *** [Makefile:1040: vmlinux] Error 1

Fixes: 9fd680d0fafd ("clk: imx: add fractional PLL output clock")
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/clk/imx/clk-frac-pll.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.=
c
index 9872620..8b13df9 100644
--- a/drivers/clk/imx/clk-frac-pll.c
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -116,12 +116,13 @@ static long clk_pll_round_rate(struct clk_hw *hw, uns=
igned long rate,
 			       unsigned long *prate)
 {
 	u64 parent_rate =3D *prate;
-	u32 divff, divfi;
-	u64 temp64;
+	u64 divff, divfi;
+	u64 temp64 =3D rate;
=20
 	parent_rate *=3D 8;
 	rate *=3D 2;
-	divfi =3D rate / parent_rate;
+	do_div(temp64, parent_rate);
+	divfi =3D temp64;
 	temp64 =3D rate - divfi * parent_rate;
 	temp64 *=3D PLL_FRAC_DENOM;
 	do_div(temp64, parent_rate);
--=20
2.7.4

