Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D903AC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F0C223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gpUByUNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F0C223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbeKNCSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:18:46 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:37052
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726948AbeKNCSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSpisXqyiqinVUr3sVqs5YJNZGcGCU3SQh+AJsjEt6U=;
 b=gpUByUNqKPpLLaHnemsT/wzz0iblELiK6TinHtQvIOmvLMpRxvW3RkE4CvNbeH7TYn0ac/XC7uUqoAc7CHvLm4bteQLBUjhvi/vRdjo5Jix/vwxPv0FkxorTyUfDVp5okhTEBt/IBMnkqaaqE+fHoR9DX+AD5nFoA9EHoPpAENY=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3750.eurprd04.prod.outlook.com (52.133.29.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 13 Nov 2018 16:19:56 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b%4]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 16:19:56 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>, Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v13 0/5] Add i.MX8MQ clock driver
Thread-Topic: [PATCH v13 0/5] Add i.MX8MQ clock driver
Thread-Index: AQHUe2y3mzPT6ZN6ckOdG5IYTodpUg==
Date:   Tue, 13 Nov 2018 16:19:56 +0000
Message-ID: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0065.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::42) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3750;6:XSYxfyp9zLqxId9sUWCaOtTm9/LcGs6s4yPua8POvNDLXgyllJNI+ArXL/ut2KRRZaxUTdItfAUpZTkA1TH4Cc86k4zBFs9OjER2nZIuIuPlzlxAPL5SDCmfrJ8ZQC7KB33xWIXGbV414JmgZmu/OJpA+H9NuGMm9S1iSl9rUL9i78tlNwUEDq6axWBFdmr+brOyd9F8HdqoZVlJn3G0jsvOu17NoNrNEfAO24l8YKyGh6gD5xXxo0yHUxqmvj30CwAwr9uCEN2ODeho3f3GR//liSy344UHEIoEgl5vSZ0F4i9BGh3Q4EzDFyc4q6wr96E2vT+tnHcFHN44CiFpztbyFBtKcAqlp1uuXu8pA44kLsavVwEsbmANU3AgK/r4oxbOJSxLgZ0LcFJIalwYdV7ABqJ6QKHCJ0C3Rhh9BpSnBWTAnDp1qH4lrbhPoTThxbjEaJQJzUBfe4OKA+epuw==;5:QKNMt7i3Va7ql7EgBEHI+rQidBEahuleYI2/LJ0eJse017mQprj5zjuVDIcvz+mhG0Fby7Awt+GJghMWIwLwWMFPtydSX3bs7g+miXpXipZ6H3HRNElxqrNSwnsxw/+CYNcLStmf6bxpJsXVEjoHiSY4ZOngMh1FnUVNN2DNS3w=;7:sRGmRlzvEaCcF/mzLxlZTKRdWMm/0DEqC+prsAP8HB4gAGqHH+n6Drzb2nUt47eOJ/pkjqC6q+zlUfu/tjJSFC4E0tAKNLJCsgt8h0JzYttijGKnvDKWcnutHXf4NIL314DZc8pEfjE9bU/bEV45Xg==
x-ms-office365-filtering-correlation-id: ead84bbe-c51f-4f84-26cc-08d64983d95a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3750;
x-ms-traffictypediagnostic: AM6PR0402MB3750:
x-microsoft-antispam-prvs: <AM6PR0402MB375037152EC4F0F562444673F6C20@AM6PR0402MB3750.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231406)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3750;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3750;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(966005)(105586002)(2906002)(44832011)(7416002)(386003)(6116002)(106356001)(26005)(3846002)(5660300001)(316002)(4326008)(478600001)(68736007)(14454004)(186003)(7736002)(110136005)(54906003)(305945005)(52116002)(2616005)(476003)(102836004)(6506007)(486006)(14444005)(71190400001)(71200400001)(53936002)(86362001)(2900100001)(6486002)(99286004)(25786009)(6306002)(6436002)(6512007)(8936002)(256004)(97736004)(81166006)(36756003)(66066001)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3750;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UOTEQ8WtNo7xN/ltuZHwVGuf9H8nMedPpxmpuw8eki3UZ6/6RLaWuaIWB03j4qs5AsJnLfUlVFwG+/V2h7SC5lA1xrSzgDmkWkfoYvYF9npYuI5qMDQM3ICmXrsd16XfbS7cIFCsWrSPALb5v/jFhzQdhmQWljK0uxS397zWeplllwSF3K5c4+ZRdY56ivZwj7d8xd8iHut5ZzkYJiMvggjhtbZ8D1NI6mTGFT4gbRMrVBOVa1X3pCTc08cc0pZ9Keb4mflK9UKZqOmFWj2njN/OeVRZtHzaUDqXqI+NVzzhBSHjmYBLp3Sy+OUZADLjtIUA7q+Urus/hSI6t1OMZpHQXGEcp5FadREH03yxpN4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead84bbe-c51f-4f84-26cc-08d64983d95a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 16:19:56.0614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a link to the 12th version:
https://lkml.org/lkml/2018/11/7/642

Changes since v12:
 * replaced the division in clk_pll_recalc_rate in clk-frac
   with do_div as suggested by Stephen

Abel Vesa (2):
  clk: imx: Add imx composite clock
  clk: imx: Add clock driver for i.MX8MQ CCM

Lucas Stach (3):
  dt-bindings: add binding for i.MX8MQ CCM
  clk: imx: add fractional PLL output clock
  clk: imx: Add SCCG PLL type

 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-composite-8m.c                 | 178 +++++++
 drivers/clk/imx/clk-frac-pll.c                     | 221 ++++++++
 drivers/clk/imx/clk-imx8mq.c                       | 589 +++++++++++++++++=
++++
 drivers/clk/imx/clk-sccg-pll.c                     | 256 +++++++++
 drivers/clk/imx/clk.h                              |  64 +++
 include/dt-bindings/clock/imx8mq-clock.h           | 395 ++++++++++++++
 8 files changed, 1728 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.tx=
t
 create mode 100644 drivers/clk/imx/clk-composite-8m.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

--=20
2.7.4

