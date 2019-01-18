Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF59C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713D620896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UbpBz5hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfARMyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:54:18 -0500
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:61540
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfARMyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZEKMpb3b6oxMLMqXfWCt8vclPOdYkwzijJJ24A0jHo=;
 b=UbpBz5hRGdQPRP8PfN3yKT9sKc/oAfgpcOXZkyb6WWDR24XYpVEmKJnT+MlfGVMLSHKIYg4OctX7SnQthrF2J+8/6U95P4uhXLKK5tva2ZH2pKSRXMqhOuzOjpAvIPyU2leThkX9fKgYKjJYo0WLpszuJq38KxlzlD3Zvl0BFPM=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3798.eurprd04.prod.outlook.com (52.133.29.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Fri, 18 Jan 2019 12:54:13 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::24fe:718b:a240:1aee]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::24fe:718b:a240:1aee%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 12:54:13 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: imx: Fix fractional clock set rate computation
Thread-Topic: [PATCH] clk: imx: Fix fractional clock set rate computation
Thread-Index: AQHUryzpS+yM6G7wUUO4UN+Tlge3ww==
Date:   Fri, 18 Jan 2019 12:54:13 +0000
Message-ID: <1547816041-14200-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::18) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3798;6:+YssTJFv0g34CndJMpcWyDEmaLxYYDwHx7kDQsXZQvTSA9BPNtvKE+iHMOmE5nabCjAMOFvPWprpgDoSWtpbeG/O0sUBvs6QbgXdUuRlAkIFIhnRfIJ2sy8j/5kDJKCZRJD4Vm6Y3cvnkH1eu8yKbgkdNxQjczYuOzYx9Uo1m1UjGfYO8/KtP3yVjJ2llTYDK1cCfEOTrgDQAqGzgevLKu9yzi/XZKjgeWWFaLpDG/iBhyh5dvkjNV4pd08hAE6RKgRGAO4tFJzSkxVe6fNYGCRurbZX6NuyUJGxrd+mOPFjUbbrLK/Ay6V+MtkFjmnjI5LaTvI71NxOI+iqpm2kH1petvffBPSPKH7y3xFbFQbzTCq9LjTK2RRVmnQTAXXo/jmQj9n/nv1xFpPuj6UpqWxonv6QAj80it+Lv3FMAKXGgGM+hbhHunBu/TKSxK/L2H0elU5SC5McQZl4vOG53w==;5:wezKCsaEtBHZAUC2swLqOpinaM4QOkKEHIMuGBHHLr5ofQqGHnaill0iDHHp3Lbf7N35U7cRa18rCzP2UvEh9sufK3s+eO3O5PZojKdGIR/s4M299CYEAnzrq/FSkdZPl5+FpSAQt8WMcdcl34hGxr/B+unpAx7CWn5KW3b9SPNHW83LvVGOu8UZFYpPRqi2Fx4kJGUMnMjnXP1OokBU+g==;7:vsxlmXIoDNwD726HqXzKfMuUBIYVFyok6O144bJ5TXP6j7dDsFrmXDxFAMcYMncT5U6SxNjqJAJ5hc0SpqUCo9ajwl04Zm7ajK8vNTvF9pRYYR9b4gVAAlYrZheTqyjVz8sVSw2XQ+tnXuvbCgTDhw==
x-ms-office365-filtering-correlation-id: ab47fab3-08db-44ae-70d1-08d67d440c02
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3798;
x-ms-traffictypediagnostic: AM6PR0402MB3798:
x-microsoft-antispam-prvs: <AM6PR0402MB37987D9D510E2DD9785588B1F69C0@AM6PR0402MB3798.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(366004)(376002)(189003)(199004)(6512007)(53936002)(68736007)(4326008)(256004)(71190400001)(105586002)(71200400001)(99286004)(4744005)(106356001)(25786009)(2906002)(478600001)(36756003)(52116002)(186003)(8676002)(14454004)(66066001)(6486002)(81156014)(81166006)(102836004)(6436002)(54906003)(8936002)(26005)(50226002)(386003)(5660300001)(6506007)(97736004)(44832011)(110136005)(6116002)(3846002)(86362001)(305945005)(316002)(476003)(7736002)(2616005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3798;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CAXBLrl78RBFW+2fkVoWQ3IcJ96+sYRRdy+ofaBdPBLtrj+zQfHA2gvUt26Aq735KsYnTamwtiD73u1okISVTWUD+B/Dmt3K/B5OHSIlSkFfUBfgC0ZAaxmBxCwtHaXf71QmBXoF5vf2BdUuevdw26ZwUT5SUVs8rdkZ+8V+vglL+WEUbuqOngCdL8wmEsiriR7sS4ApD6JZlLksRGR+46w4KQXKwTYdrgxENUDkluw0/JTuTUk3/QF9igioMUfvzpAqOEljjOpdBjOjLMWmvAOGKHQLlc/2q49CPz4/CJQk56TNlZs1lB7DuzCUtwfhNU8aSRfXnPx0IVg3ryeGKZBdUn1GaurNDm1gnIRcqAV/BKk1nhFHy4e8Dtec4RPccuOIFQ8XKqzdCOkSCHaG9Zosvacl9xarAx+NThOKelQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab47fab3-08db-44ae-70d1-08d67d440c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 12:54:12.5676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before multiplying by PLL_FRAC_DENOM, the temp64 needs to be
 temp64 =3D rate * 2 - divfi * parent_rate * 8, instead of:
 temp64 =3D (rate * 2 - divfi) * parent_rate

Fixes: 6209624b9a5c1e ("clk: imx: Add fractional PLL output clock")
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-frac-pll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.=
c
index 0026c39..76b9eb1 100644
--- a/drivers/clk/imx/clk-frac-pll.c
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -155,13 +155,14 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsign=
ed long rate,
 {
 	struct clk_frac_pll *pll =3D to_clk_frac_pll(hw);
 	u32 val, divfi, divff;
-	u64 temp64 =3D parent_rate;
+	u64 temp64;
 	int ret;
=20
 	parent_rate *=3D 8;
 	rate *=3D 2;
 	divfi =3D rate / parent_rate;
-	temp64 *=3D rate - divfi;
+	temp64 =3D parent_rate * divfi;
+	temp64 =3D rate - temp64;
 	temp64 *=3D PLL_FRAC_DENOM;
 	do_div(temp64, parent_rate);
 	divff =3D temp64;
--=20
2.7.4

