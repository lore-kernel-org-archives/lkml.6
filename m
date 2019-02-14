Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB5F20835
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WI9Y79CD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393318AbfBNJ4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:56:05 -0500
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:39853
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392838AbfBNJ4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir8c7bEmvNOEkAxrBjP91mWewB0ga0geIwcT1dvGfUQ=;
 b=WI9Y79CDUwcGNiNwUeknb/7Gr3koKEDuUysebsQkF8gr6zBHQ1HpQPAsUg5eLBtDZuiEb9rep4cg2UV9DCX5N8YTiowBD6pNAuhqkiId3JYBp3n4uJGKa7EngmR4NCUEAQFpSH42bBc+X3gyJ5EtbzH2MvdUYEtgwIzrwkf00a8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 09:55:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 09:55:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V6 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUxEt78gy90OZt+UeqROcOSrZGKg==
Date:   Thu, 14 Feb 2019 09:55:57 +0000
Message-ID: <1550137826-18531-2-git-send-email-Anson.Huang@nxp.com>
References: <1550137826-18531-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550137826-18531-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cefc315c-15e2-4ac6-4aea-08d692629dbb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3818;
x-ms-traffictypediagnostic: DB3PR0402MB3818:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3818;23:jBJsX+WXu0fMTBUrwlHU6N74UqJ+1AMR6CWhp?=
 =?iso-8859-1?Q?m+JaqDDiwgNcYlgNxCmx22PmKV0vlbbBq7uk0cFvwg7Ym5cZCgRDTe3WSe?=
 =?iso-8859-1?Q?vjIZlsklH8OfbaPr/R995XpgNBAxuC3TNOSh3MzFXcUG8wf6OLNoEsATrd?=
 =?iso-8859-1?Q?r/KXuwyBf8rx1h7SSCnhhjJruVKgp8mwEBeMSoioEAXdU/XLJja1IQ49iS?=
 =?iso-8859-1?Q?EsxS51kfjGJd/6gtYE7CQo5ib1i01Zm+Z/S4YRPhEADun3Rxc+WUzILxN/?=
 =?iso-8859-1?Q?18miOFzuOoksfEcfeJEMV9n6koJhRgfud02adFkxm/OXDUcgveHhe4xFVt?=
 =?iso-8859-1?Q?PtK7qE1DVuuasZ8XJsOdf2xaMcnNLbdNmSFC/MVrE135v7eVDEml9zmLeS?=
 =?iso-8859-1?Q?68EFzlqb5hDTTAh62fdCzPGQHirGjOqv0zuI99lloWnwtgVrPokPZH8QsR?=
 =?iso-8859-1?Q?Hh4orqBAqwx3x9hDLiJz4gcQu4Vee7quAmDjcKOsi51MSSO/Tz4ukcbvsQ?=
 =?iso-8859-1?Q?m8YLfi/DEbotAxpO3pU9TdctzqNfvmSvlVEyA5v2eUDCgs5cmX/4QNCrA5?=
 =?iso-8859-1?Q?WklEehLTds/4NbLOcWGYWVsYiTEg8sKhpLsbMr4bJ/NNRaumh62MPb/cyK?=
 =?iso-8859-1?Q?oxzOV7qveC4YUNgLUGsenq600cqH5RxZuCEkpXoDncqAvhfAEaJkv0Y1/p?=
 =?iso-8859-1?Q?B3gvociIgGS6fQwJruuSblDDOE2nzh8ytk3HtdNm+72MlnAwcoPJW4OpCj?=
 =?iso-8859-1?Q?r5/tOwTPjWbpQCGrLjyIYbv6rcWcRn8vROeVytJV5xIEoLswSR+1mvJEXS?=
 =?iso-8859-1?Q?l6Zt2GVZqytk8gWTVFYqTesDHen+ZOw4/OPXMZPEOqhocj6zMCz0+iBEME?=
 =?iso-8859-1?Q?QmGnQG/CHzZ3P8mDDKpffR3QyvrnR0qHV8kF37xj/cZIsc2WH6i4qek2pR?=
 =?iso-8859-1?Q?bdLmdqnpODPgz/mPIZpz1x3xNxfRN8gGQTK/lost3fUDtvytKaLbOp8GFk?=
 =?iso-8859-1?Q?qdsLJnXkb1W1PcDmzda7CS+D8DBNEI/hQ6EbcRcrJ5zRIe95FHmcOu7Rz9?=
 =?iso-8859-1?Q?4A93ooEzF0Trg6MtY6xU9Y3FBX+hWb4vrlIc6ZC46wrwRoTI5Xa6X68TOA?=
 =?iso-8859-1?Q?S7xyZQFA1GQuwwXv40gzhRkpqa/lhRzw0k6iTaQDSbojp0mSJQpLcscI87?=
 =?iso-8859-1?Q?pq85H/y3j8T0oXH6BlSya7Y5tOUUhi5aoPdVaKzNZdymWaZwoDLkLAr933?=
 =?iso-8859-1?Q?U5TVx1ESn6P78E2YfqdsFGlpYn5IvaS+Bv+rpL7YudbiOYTAGNhtSwRCJp?=
 =?iso-8859-1?Q?w908=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB38186F1BACD07783895A2ECFF5670@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(97736004)(71200400001)(8676002)(71190400001)(256004)(8936002)(7736002)(2501003)(81166006)(2906002)(81156014)(14454004)(52116002)(110136005)(305945005)(14444005)(53936002)(76176011)(50226002)(6486002)(316002)(6512007)(68736007)(478600001)(2201001)(6436002)(486006)(476003)(186003)(2616005)(36756003)(6506007)(86362001)(386003)(26005)(106356001)(3846002)(4326008)(102836004)(6116002)(99286004)(7416002)(105586002)(25786009)(446003)(11346002)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3818;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /4xjAN95aOsJFIV8mX1Bop+ydkLeGx5QcaJDb22cLAzsh/R1pIr3WHJW/eFjdvuyzmwbBenAH/TEfpyb7+anaCf/FL/1DoHDu02HUIy/BvptIzXpIEqyv/UmMDmrbisjU7Pd+D2v8mcbZY48wkd4+uxwQnK7nqWJVg6wHYle7dHje46hvxTVNivGBBCXLh5oX7k4mQE9LJi3WBqu7mN5VWiOUuo9qfp5wwQp/GfQOUZ3V+TE0hAVAy+T2SbLnXKZYhXGVd4U/ohAxvQ4Dkc9nfYfHPUHzGrJCuk0MignKKuYrSqDT1bfNT3v0EdONp8TMrHjmwisvgZ7xLYs27R4MixipufZpPrbGV+CQ76pGBw80qhJbuVXvazF8NsM92iCCRGGr6WPnKcS4tF/r8sSH1ngKpK9wr+3q9DZawXKPtg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefc315c-15e2-4ac6-4aea-08d692629dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:55:51.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On NXP's i.MX SoCs with system controller inside, CPU frequency
scaling can ONLY be done by system controller firmware, and it
can ONLY be requested from secure mode, so Linux kernel has to
call ARM SMC to trap to ARM-Trusted-Firmware to request system
controller firmware to do CPU frequency scaling.

This patch adds i.MX system controller CPU frequency scaling support,
it reuses cpufreq-dt driver and implement the CPU frequency scaling
inside SCU clock driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V5.
---
 drivers/clk/imx/clk-scu.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 7ccf7ed..c234a6e 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -4,12 +4,17 @@
  *   Dong Aisheng <aisheng.dong@nxp.com>
  */
=20
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/arm-smccc.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/slab.h>
=20
 #include "clk-scu.h"
=20
+#define IMX_SIP_CPUFREQ			0xC2000001
+#define IMX_SIP_SET_CPUFREQ		0x00
+
 static struct imx_sc_ipc *ccm_ipc_handle;
=20
 /*
@@ -145,6 +150,23 @@ static long clk_scu_round_rate(struct clk_hw *hw, unsi=
gned long rate,
 	return rate;
 }
=20
+static int clk_scu_atf_set_cpu_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct clk_scu *clk =3D to_clk_scu(hw);
+	struct arm_smccc_res res;
+	unsigned long cluster_id;
+
+	if (clk->rsrc_id =3D=3D IMX_SC_R_A35)
+		cluster_id =3D 0;
+
+	/* CPU frequency scaling can ONLY be done by ARM-Trusted-Firmware */
+	arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
+		      cluster_id, rate, 0, 0, 0, 0, &res);
+
+	return 0;
+}
+
 /*
  * clk_scu_set_rate - Set rate for a SCU clock
  * @hw: clock to change rate for
@@ -232,6 +254,14 @@ static const struct clk_ops clk_scu_ops =3D {
 	.unprepare =3D clk_scu_unprepare,
 };
=20
+static const struct clk_ops clk_scu_cpu_ops =3D {
+	.recalc_rate =3D clk_scu_recalc_rate,
+	.round_rate =3D clk_scu_round_rate,
+	.set_rate =3D clk_scu_atf_set_cpu_rate,
+	.prepare =3D clk_scu_prepare,
+	.unprepare =3D clk_scu_unprepare,
+};
+
 struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type)
 {
 	struct clk_init_data init;
@@ -247,7 +277,10 @@ struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_=
id, u8 clk_type)
 	clk->clk_type =3D clk_type;
=20
 	init.name =3D name;
-	init.ops =3D &clk_scu_ops;
+	if (rsrc_id =3D=3D IMX_SC_R_A35)
+		init.ops =3D &clk_scu_cpu_ops;
+	else
+		init.ops =3D &clk_scu_ops;
 	init.num_parents =3D 0;
 	/*
 	 * Note on MX8, the clocks are tightly coupled with power domain
--=20
2.7.4

