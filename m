Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D9C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2845120863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qfzswyTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2845120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeK3ScM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:32:12 -0500
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:2784
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeK3ScM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSXDf49YLzeK/sSz8wwIF2c0rbTTjmJdkmLQdcKUdvo=;
 b=qfzswyTfInP4lztCP2IzI8qvTxl+J26sZVqZU2la20QEY1o6lgDN+YPqOb7GXrG2hs1gUBvU4Jp0w2fEgqkNWuj/rcJLX70hXKRPK2h9KeqlHoqn6r+WEnCaHC4kT14eg92oWnKF62IVeff+ofmVNe7LE2sUuW1L9FenFUPirBE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3945.eurprd04.prod.outlook.com (52.134.65.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Fri, 30 Nov 2018 07:23:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 07:23:47 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Thread-Topic: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Thread-Index: AQHUiH2hWlHF6oLZCESale1T/3ahbg==
Date:   Fri, 30 Nov 2018 07:23:47 +0000
Message-ID: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3945;6:cgNr8UY5+sSAmOACdnxN63mB+3px6orWU5n8aedB/z7MwiZS0x5Mo1AtQLmCYz9DuNb3WosyXGGZvbr9gKjj9av5nDciSUwWNsnkft6z9pm1o5B2X2X965oVC5mdsSS/Z9tAlp764UVpB34De/slewYHLciX92VQyYNUwFJFbFsNNPenNzMSUzzDXcblhY3cXEwUadmVUJZFs5dVIbfnWbM9ATpopW26Ij/YoJeRo0kqDQEZedoo8DB66qZS5B/Shss5iyt4fTmaXINew/O/WiyL/rIGUr2HM2tPqV6xkz9KoWAcRUNxZBxjZ9855FqCrc6zMj7DKBKBupNO1sO67dSLsR0mDIvJTdYCBm+dva9zpeVyeKdH2DXIr3s6uJzb3m2AfnHpeKxD/RZ6PlLUGgyxSa8PaqdM3zSHmm/ecv7zAbpmxAnYnXf0PzexwRrH24b0DMJJJj2CCEujTRmTrg==;5:ead+WvbZO0h23amTaPLpAP8967cNL9v5cwHa1pkPSR8s51qDfLB2aJYsuzSd5I4es8dfiXlpim7cbLKv+pu+/Gs8JD0/g6dB5XxcZxgs7kCG0nJalADCBBJfiT5xu2hQaUJeyFbRdeX8Xe8TyOxS7EUQpuIM3bs1LL7iqZexffY=;7:DrG4/hBy/XNSrVBlKk0cO6VpOGQJNw6SNQEm3p8eb15Grg+XTNRKANzMpXt5dwH97/B89rxLJ7wyuFNpHKZ76eQkizTFnTVJ0xM1cz1E/egtEdXPlldSpjYlxONNO3INflW3XoP4ltjtAkcEcfRb7w==
x-ms-office365-filtering-correlation-id: 289746cb-e7fd-41e1-acc8-08d65694c415
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3945;
x-ms-traffictypediagnostic: DB3PR0402MB3945:
x-microsoft-antispam-prvs: <DB3PR0402MB39459DCC0805FD5DFA298072F5D30@DB3PR0402MB3945.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231453)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3945;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3945;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(66066001)(305945005)(7736002)(97736004)(478600001)(99286004)(71200400001)(71190400001)(86362001)(575784001)(52116002)(2201001)(25786009)(2906002)(6436002)(6486002)(6116002)(3846002)(6506007)(386003)(486006)(2616005)(36756003)(476003)(6512007)(106356001)(105586002)(53936002)(186003)(14454004)(4326008)(256004)(26005)(14444005)(81166006)(81156014)(2501003)(316002)(8936002)(102836004)(68736007)(50226002)(8676002)(110136005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3945;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7CUYaiGAYY+/uAqetqUvKplM9Tq+eCvT9+/cpa900R32ErdZlv4t9GaD34LN1pyCcNT5WpF3lTJItkBfyhMPa8/Uu58ASFR5F/58F3gAr/0xaMxs3BFRlylsI2gYiVCqlSzK14pznlVJItS2mNbHfYUMNOvhZSdajjfRHgiKakuv3qgVfZqYG1I/NYj3IQLolYyytoLcUfTIstqChm9Nr9ZrvxiqDpHiF+rzv0Rlh/c4njxpSdEeF9PPuRzocF8CdFvNpkkQtyuXkzIKTRDoMiF9kfK4UU49EQY2su6wznIJKJizPt/0u7vYUP3IIH+iN/gfj/uF5vvANxvLYtLFVNmVl5oaUnDsKd5+SRWuKIE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289746cb-e7fd-41e1-acc8-08d65694c415
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 07:23:47.0501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as other i.MX6 SoCs, ensure unused MMDC channel's
handshake is bypassed, this is to make sure no request
signal will be generated when periphe_clk_sel is changed
or SRC warm reset is triggered.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 6fcfbbd..e13d881 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -17,6 +17,8 @@
=20
 #include "clk.h"
=20
+#define CCDR				0x4
+#define BM_CCM_CCDR_MMDC_CH0_MASK	(1 << 17)
 #define CCSR			0xc
 #define BM_CCSR_PLL1_SW_CLK_SEL	(1 << 2)
 #define CACRR			0x10
@@ -411,6 +413,10 @@ static void __init imx6sl_clocks_init(struct device_no=
de *ccm_node)
 	clks[IMX6SL_CLK_USDHC3]       =3D imx_clk_gate2("usdhc3",       "usdhc3_p=
odf",       base + 0x80, 6);
 	clks[IMX6SL_CLK_USDHC4]       =3D imx_clk_gate2("usdhc4",       "usdhc4_p=
odf",       base + 0x80, 8);
=20
+	/* Ensure the MMDC CH0 handshake is bypassed */
+	writel_relaxed(readl_relaxed(base + CCDR) |
+		BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
+
 	imx_check_clocks(clks, ARRAY_SIZE(clks));
=20
 	clk_data.clks =3D clks;
--=20
2.7.4

