Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A424FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5539620817
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XYY+SyYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5539620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeKKAUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:20:06 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:35840
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbeKKAUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CVdAob5+VycCwLiquD9emZ01zBDuv+4RJ9HmVpRIMY=;
 b=XYY+SyYu/+M2QMAfRAKO5RwPopCc7tHkGJTq7W90XjHI2DIrvO/UwS81hyTxhZFskv1XYERiaoTbivdc4E98z95EtePS+QD3jlnmw2JqqX6ecRrnXGMBJBbw0NbpVeDhdB5HaLD8SpXVOivR6zxPND1hg48bI9uaX5FMqtkdPJA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Sat, 10 Nov 2018 14:34:47 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 14:34:47 +0000
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
Subject: [PATCH V5 8/9] clk: imx: implement new clk_hw based APIs
Thread-Topic: [PATCH V5 8/9] clk: imx: implement new clk_hw based APIs
Thread-Index: AQHUeQKHqXu6RNxV2EGuJGWWi6g0mQ==
Date:   Sat, 10 Nov 2018 14:34:46 +0000
Message-ID: <1541860165-401-9-git-send-email-aisheng.dong@nxp.com>
References: <1541860165-401-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1541860165-401-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::20) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4402;6:DpJnME1hr3clUGhpww66dq44b0CkwMc+9vWNgHKcqLfCCM4fmvoI6jhF7o+56huIGzFItah8w279r/gXEIoK9xJtDRSer+9MqhLTxxgIgZ9Th6soty/PIc6KnJW4HUDRHtgqK/FDrR6rgIADL2+eSydlAMAiYBvycSFlJZJKYr6xXbdLVmHXTsF2SZJBaWlcKYxgbhp0AHVvOSUlWSb1rNizvRAxiNhrbEFDtBqbkE2NcK5MZLaA+BjgUlItVotLDwse1hh8M8d1UXOibtc24lcioJkcL9DaZEVfwutA8iE8pHZmLrEmx6Pyc/9ffo2w/tGcxh/6nnAQgAJl4FJSdhYVhuThmQKSAwDdY2ibtX+ifVf+emgwmart50wGH0B+9E4KSv5LSqqi1aYD+4mTTB/W2XNMf+vWoUKBZiM7Ugb6ORt0uuknmwlSAQeOcEqbmQ/KuUoYqvaKEccfmHKOVQ==;5:izFYzbd8hPMW4dk+ikZH1ds6WECKj4+KaMY/Y6VwWcy3hE4tb+2yJ9kpmEM16ejsZTFdnq2y37SVSEJ7RnCqjhzEEyCQAlUFKHyQm/nhy0lx/IaPILbtVwADP2OTiCl/sb3asgAhnOZgcGWUQJp6D3bFNvyuTf89wqc1Rt7LlFY=;7:eH7wP+G7sOpDzIn/sKEHVOx723epo88Risj/Haf3ww3own22p8bNL+tAlcePxeKsT7NeXcVCNqcd7/Mr3xZqIYsLryxlpPiKHl2Qbk4MLyQoidx19UehDdn6/bDc6QeLkHpcxZcLSrUStznOnXf5rA==
x-ms-office365-filtering-correlation-id: ad0e47ea-1b1c-4202-1015-08d64719a9c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4402;
x-ms-traffictypediagnostic: AM0PR04MB4402:
x-microsoft-antispam-prvs: <AM0PR04MB4402354A8B7D79F0AA4873C780C70@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4402;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4402;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(54534003)(6512007)(478600001)(102836004)(36756003)(14444005)(4326008)(105586002)(256004)(76176011)(97736004)(71200400001)(71190400001)(106356001)(14454004)(386003)(6506007)(52116002)(2351001)(5660300001)(25786009)(5640700003)(2906002)(81166006)(81156014)(66066001)(6436002)(26005)(186003)(6916009)(8676002)(54906003)(8936002)(3846002)(305945005)(486006)(7736002)(6116002)(2900100001)(446003)(11346002)(68736007)(53936002)(476003)(2501003)(99286004)(6486002)(50226002)(2616005)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b9KuPjyXZvdQScyrhMvrnc5do6mAw/1wLftyHeETSWKpcFs3PaQ5wd5BYSE8acQ2apKfyD0GmLhYjaZ/cAdI6uBqZ4CgL9iC3Ux4NpOZe20Or6ndb3/HqIEPnG5yKLLVl+DOgEVUwkvFTnyxZp1JR401MwpLhUvKj59W+CU86hzMCQIP+fQXQiFcgMmOFd47yLraHwzoNT1/a8ga2DJER22iXu6eNkrCV4QlHtU3yItFmSbXKE6VdWn02ZKzUwXAmddLAbWmMeyzIykY9xdScVOrGm/OIUIocF6pl0c7BLNP1EiPhu3t7T5zKUiLacyPoL5eEE0Wd9ACUIhBAK4V1dl+yEaAbH+lLdRJVlVpjZc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0e47ea-1b1c-4202-1015-08d64719a9c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 14:34:47.0448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
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
index 290d4b2..75ad05b 100644
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

