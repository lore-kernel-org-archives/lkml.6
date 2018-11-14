Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D9C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD3622419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UK4kTt8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD3622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbeKNXIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:08:17 -0500
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:34080
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733010AbeKNXIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6DOobYklP+BYXYLfJ2zwSqtoWLVDTq1nfFK7PPMcVE=;
 b=UK4kTt8fE96DMpSjsYF5tCIpfXn+Y0QctX5Nr34nCoRoml5sbl6p83UORxD38+keP5yiFw7E5se9PvJb7s44qVKm4gtLwEEeAnhNmbvSyakEKuyBsiC5PAn1b83fRdzGmB+vdh0doTmXiEeXUDjIyl4X8oo2hDYcJrRMuAziicU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5985.eurprd04.prod.outlook.com (20.178.114.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 14 Nov 2018 13:02:04 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 13:02:04 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: [PATCH V6 8/9] clk: imx: implement new clk_hw based APIs
Thread-Topic: [PATCH V6 8/9] clk: imx: implement new clk_hw based APIs
Thread-Index: AQHUfBo9jbT+xNSQsUSnAwc8nkoIQg==
Date:   Wed, 14 Nov 2018 13:02:04 +0000
Message-ID: <1542200198-3017-9-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5985;6:+XtNbRyrOJDDUnbnl8n8ystBGjjMxnL07JO6bauiGCBgbNqr6s8FAVJgsBGhjV6aUqq3i/XeJLO/aGz/FTXUVOAsV1VDweCJpPZjPA49iRZouPN9m+AB4BYE1pqpfoXfWBYvRL5njt9EEcKG7KL/2v7hQFaQ9ctAxATO4Y6gYlD3lzxbRH3ibdKyStaWuejnX/vIJ8kIrw7AjcuHHi7+OAU0DyaLNLIgr+O6kI2YGcGr+if9TuL0pjsILyr+GNEsE6asHDy+pU4BxkZk8Avefbj+AhrdPmpKFboEJiwLHoR39uhxSL4c/rbOFxqvS+dpsyjItwPvFAT3dJnoFuG3Ck5U5reM35GtCsa/lx6gZIXIr+UuKmND8xGCk9AR6eGtvJWO32Qo8Wlrp4+kfZeLEgBFC3ALtNd4D4pIj2WatV5vBGJlPDvmaQinFKOVrr+PtRXYXbtTwnB816EzUNeIqg==;5:XNhK8RJILWWfdM9E2lNM7FOxwEqWHvpx9phTMFrlHuyjaXA5GRY/u8xnGokZ5AdhfuaEjvzXrI9qSKJ45dQR2G/tcjumpT73x4dIVaolvaZkr/XMYFHAi4plyYrkXoy9LRU0fMw/bP0gRsByFJrC2zQ5HT0nNvTEkK26EClimkA=;7:ETMpkgLJbyshKGSKtpzPeXzDSev5kK5cbIQihE0uZvxQPRYQoSoyoonlA7xO5QLtTLheOfL2JJXapJNm8mXZ+IlSz3lQg4UczxnrqKFIdEaHZbKzlumgCWu0uppTneXf9yxZIB2iD8rBiiHJevkOKg==
x-ms-office365-filtering-correlation-id: 7ed9a4f8-f527-44a7-ce35-08d64a315f9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5985;
x-ms-traffictypediagnostic: AM0PR04MB5985:
x-microsoft-antispam-prvs: <AM0PR04MB59859927258AB1813A51141C80C30@AM0PR04MB5985.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5985;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5985;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(54534003)(189003)(199004)(6916009)(305945005)(316002)(446003)(54906003)(476003)(14454004)(2616005)(68736007)(5660300001)(11346002)(53936002)(14444005)(8676002)(486006)(105586002)(7736002)(256004)(186003)(25786009)(4326008)(2906002)(99286004)(6512007)(6116002)(52116002)(81156014)(66066001)(81166006)(3846002)(76176011)(5640700003)(50226002)(386003)(6506007)(102836004)(71200400001)(71190400001)(26005)(86362001)(106356001)(2351001)(2900100001)(2501003)(6436002)(6486002)(97736004)(8936002)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5985;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y6Hz6jclZKCOJIeGinbI20ezF9DACdURvGOcCM1Iqop3KSJ2jPFLIsZ0+3kCy7v30UDBu5yrJcna7mNqQlNEpiap63N++N0wFUCrWvJNaw/5G36Z97coEXCTTWck6xbSO+lWUeL5s5TiMYBcENPGBYsUAgeBJvDTbhGmo5CJQkZvANFDzzVfadZ4IcoS3EaMo7uhYdVjuRsSnEkX63oKY55hEGEp8FblLDqHfuWxPOwxKGx6qE3PY+cqYfhmz93zDBXo8XrsfRj92raHvG53f1ZohmxVlTfTbO0uBd4IeHHS7iA0Y9yfPntSXJXvrxSkVXsSkhqwqKxVaPAjUEf+yOJTe4xlZeTJj4HMRcJiF/w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed9a4f8-f527-44a7-ce35-08d64a315f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 13:02:04.0605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock providers are recommended to use the new struct clk_hw based API,
so implement IMX clk_hw based provider helpers functions to the new
approach.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v4:
 * no changes
v1->v2:  new patches
---
 drivers/clk/imx/clk.c | 22 ++++++++++++++++++
 drivers/clk/imx/clk.h | 62 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 9074e69..1efed86 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -18,6 +18,16 @@ void __init imx_check_clocks(struct clk *clks[], unsigne=
d int count)
 			       i, PTR_ERR(clks[i]));
 }
=20
+void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < count; i++)
+		if (IS_ERR(clks[i]))
+			pr_err("i.MX clk %u: register failed with %ld\n",
+			       i, PTR_ERR(clks[i]));
+}
+
 static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name=
)
 {
 	struct of_phandle_args phandle;
@@ -49,6 +59,18 @@ struct clk * __init imx_obtain_fixed_clock(
 	return clk;
 }
=20
+struct clk_hw * __init imx_obtain_fixed_clk_hw(struct device_node *np,
+					       const char *name)
+{
+	struct clk *clk;
+
+	clk =3D of_clk_get_by_name(np, name);
+	if (IS_ERR(clk))
+		return ERR_PTR(-ENOENT);
+
+	return __clk_get_hw(clk);
+}
+
 /*
  * This fixups the register CCM_CSCMR1 write value.
  * The write/read/divider values of the aclk_podf field
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3886979..cf0596d 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -8,6 +8,7 @@
 extern spinlock_t imx_ccm_lock;
=20
 void imx_check_clocks(struct clk *clks[], unsigned int count);
+void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
 void imx_register_uart_clocks(struct clk ** const clks[]);
=20
 extern void imx_cscmr1_fixup(u32 *val);
@@ -54,6 +55,9 @@ struct clk *clk_register_gate2(struct device *dev, const =
char *name,
 struct clk * imx_obtain_fixed_clock(
 			const char *name, unsigned long rate);
=20
+struct clk_hw *imx_obtain_fixed_clk_hw(struct device_node *np,
+				       const char *name);
+
 struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
=20
@@ -90,6 +94,16 @@ static inline struct clk *imx_clk_fixed(const char *name=
, int rate)
 	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
=20
+static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
+{
+	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
+}
+
+static inline struct clk_hw *imx_get_clk_hw_fixed(const char *name, int ra=
te)
+{
+	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
+}
+
 static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *=
reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
@@ -113,6 +127,15 @@ static inline struct clk *imx_clk_divider(const char *=
name, const char *parent,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
=20
+static inline struct clk_hw *imx_clk_hw_divider(const char *name,
+						const char *parent,
+						void __iomem *reg, u8 shift,
+						u8 width)
+{
+	return clk_hw_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+				       reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_divider_flags(const char *name,
 		const char *parent, void __iomem *reg, u8 shift, u8 width,
 		unsigned long flags)
@@ -121,6 +144,15 @@ static inline struct clk *imx_clk_divider_flags(const =
char *name,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
=20
+static inline struct clk_hw *imx_clk_hw_divider_flags(const char *name,
+						   const char *parent,
+						   void __iomem *reg, u8 shift,
+						   u8 width, unsigned long flags)
+{
+	return clk_hw_register_divider(NULL, name, parent, flags,
+				       reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_divider2(const char *name, const char *p=
arent,
 		void __iomem *reg, u8 shift, u8 width)
 {
@@ -143,6 +175,13 @@ static inline struct clk *imx_clk_gate_flags(const cha=
r *name, const char *paren
 			shift, 0, &imx_ccm_lock);
 }
=20
+static inline struct clk_hw *imx_clk_hw_gate(const char *name, const char =
*parent,
+					     void __iomem *reg, u8 shift)
+{
+	return clk_hw_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+				    shift, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate_dis(const char *name, const char *p=
arent,
 		void __iomem *reg, u8 shift)
 {
@@ -222,6 +261,17 @@ static inline struct clk *imx_clk_mux2(const char *nam=
e, void __iomem *reg,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
=20
+static inline struct clk_hw *imx_clk_hw_mux2(const char *name, void __iome=
m *reg,
+					     u8 shift, u8 width,
+					     const char * const *parents,
+					     int num_parents)
+{
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
+				   CLK_SET_RATE_NO_REPARENT |
+				   CLK_OPS_PARENT_ENABLE,
+				   reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_mux_flags(const char *name,
 			void __iomem *reg, u8 shift, u8 width,
 			const char * const *parents, int num_parents,
@@ -232,6 +282,18 @@ static inline struct clk *imx_clk_mux_flags(const char=
 *name,
 			&imx_ccm_lock);
 }
=20
+static inline struct clk_hw *imx_clk_hw_mux_flags(const char *name,
+						  void __iomem *reg, u8 shift,
+						  u8 width,
+						  const char * const *parents,
+						  int num_parents,
+						  unsigned long flags)
+{
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
+				   flags | CLK_SET_RATE_NO_REPARENT,
+				   reg, shift, width, 0, &imx_ccm_lock);
+}
+
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
--=20
2.7.4

