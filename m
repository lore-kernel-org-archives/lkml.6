Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9E4ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CE720843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="El60kLzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CE720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeJUVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 17:25:11 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:64912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727688AbeJUVZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 17:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+879SXv+7Y8DzyvSxQeMfFBjX0ZNtbl70uRqcaWiiz8=;
 b=El60kLzkPc+OPaCc8QGQGb8TlAOiJtQ3A4Yh6T6ykuGRK8SQacXL1OlSUQcFXkZkHpo8Z+Hno/qb5OTaTtPdrYhh/eCi+z5UsTGo9mPukaVMvNfBJCERUHRDep9PvpHbvHs0Uw1ObrTmz3lT0yCWDAyW0xRqDfiNndriIY/gw6k=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4580.eurprd04.prod.outlook.com (52.135.149.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Sun, 21 Oct 2018 13:10:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1250.028; Sun, 21 Oct 2018
 13:10:48 +0000
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
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH RESEND V4 1/9] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk
 support
Thread-Topic: [PATCH RESEND V4 1/9] clk: clk-divider: add
 CLK_DIVIDER_ZERO_GATE clk support
Thread-Index: AQHUaT97je2HHpUTbUy+9sDZKHmTVg==
Date:   Sun, 21 Oct 2018 13:10:48 +0000
Message-ID: <1540127173-21346-2-git-send-email-aisheng.dong@nxp.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::22) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4580;6:AChiRNhchQ20bSJf1xUyNzIdX2Ka7p7h3tk7+qp60odvBB5c05gd0k9rAIDRZN5pcenQor2oALqACBqTlDESpvUBtrCQQxNCzMbZXxChRmzv9KrFT6nlweez5+6iBJMsIsoMLuG65UHg9ffF/mBvkUv8WvOPxuumPKdLtnQwFnz5W8jjzmeQQjTFoh9bVFv5eeZ1WQS3Jzp+Uvv2gQZOicYlXxqDYEqyGhtUHq3VqrLrDacqGa4M8RyywYwVevq4SvLTvsaQzYmpdW9T8ykEtGg8NMrKx6/x9JWcnUQuxuxo0IGeLEpIGAw0vGMWSqwNigj7PTuzhpyhaMgqPY5kKLPTr4+5k0fMcFa4K+lPXmYPGW0ncFEMUUDztajU7kfZJP//8lZXJLfCCR8DwCq5WNtL5+w+CkzE1q+mDytpvRqlmagCioEn/2Zy1BUD+Ttiw6FnpqGO6VxJ/ib15+GgJg==;5:P7I6Fhbb0ZK+TuzsVH4T487xt3+FUvha5gnciEd6ogaVxUPEqvDgyXBtxxS7C81HezGeabvqurHUg2eBCsNUcnudrsDzpwDilmVKiSTP70ZjBNSgGUm4+IEkEW4cn+xrwluemNglOy7WOPMf/EtvqZOdayH9ahZqRj4LhKW3FmM=;7:ZLIUJHzqLMyZDVsXbxSNRMdVwjDcb/bFhNaBXsmtlvMQmErWwdWtI6K0B8V7ripSiJsxA+JN2quVrsFlfFfHkBIEACYAXcDnrLvSuC1861ifZpDJ9EYaHBZUbrCDZhXVAKrMFrsmTbu96+37B4RofJoSR+9LCobrW/khVgggOdyStczYI7b+FJ+7chtDly4PGOWqXOn1umC6BFCIeqpnk4zk9TBj3B8leSgAQNckTks7dg628e+YaF0gU7YAWDGG
x-ms-office365-filtering-correlation-id: f4a72d26-18d9-4a04-d7d1-08d637569e4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4580;
x-ms-traffictypediagnostic: AM0PR04MB4580:
x-microsoft-antispam-prvs: <AM0PR04MB45803588632ADF8BEFEDD9DC80FB0@AM0PR04MB4580.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4580;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4580;
x-forefront-prvs: 083289FD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39850400004)(136003)(54534003)(199004)(189003)(476003)(2616005)(11346002)(446003)(66066001)(54906003)(316002)(26005)(52116002)(99286004)(486006)(186003)(7736002)(386003)(6506007)(305945005)(102836004)(105586002)(76176011)(50226002)(86362001)(106356001)(256004)(14444005)(81156014)(81166006)(217873002)(8936002)(8676002)(6916009)(5250100002)(25786009)(2900100001)(2501003)(68736007)(71190400001)(2906002)(5660300001)(14454004)(3846002)(4326008)(6116002)(6512007)(53936002)(2351001)(6486002)(36756003)(71200400001)(478600001)(5640700003)(97736004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4580;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: toUkTE6rSenjdoNBFYnKFzPYio1yLTPwJoPEBtCTWg7ocdO5Ya7tutXv92FgFp90IdVsVYHRQWZfbn7k6vz9DmF2qxCUyvpkoNBGp/vkQsHFv4H+sUQvwU+0Jekv0F78D2irWxqDg759bYSU9g8ebSYm7dwmI4i4Yz0PNhNUFa8k/xL8D0rud/SSVERZJcyLvBkAX954AC24iG0+3eoEDY8H4+TGWIZTX94FN5SlOWpX2Gxn/9AuPmajKcAM5//u7oWxDpOLvUiCTmHxuKI59h15qC8jzSryhqHcS/ia/mcMsHWTZM1ULdaUrtyrndqYjZxCDfILSZSmWORVm0YzP3juLgdgxhYSuuMj9MWXWSc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a72d26-18d9-4a04-d7d1-08d637569e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2018 13:10:48.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For dividers with zero indicating clock is disabled, instead of giving a
warning each time like "clkx: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not
set" in exist code, we'd like to introduce enable/disable function for it.
e.g.
000b - Clock disabled
001b - Divide by 1
010b - Divide by 2
...

Set rate when the clk is disabled will cache the rate request and only
when the clk is enabled will the driver actually program the hardware to
have the requested divider value. Similarly, when the clk is disabled we'll
write a 0 there, but when the clk is enabled we'll restore whatever rate
(divider) was chosen last.

It does mean that recalc rate will be sort of odd, because when the clk is
off it will return 0, and when the clk is on it will return the right rate.
So to make things work, we'll need to return the cached rate in recalc rate
when the clk is off and read the hardware when the clk is on.

NOTE for the default off divider, the recalc rate will still return 0 as
there's still no proper preset rate. Enable such divider will give user
a reminder error message.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * split normal and gate ops
 * fix the possible racy
v1->v2:
 * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
---
 drivers/clk/clk-divider.c    | 152 +++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/clk-provider.h |   9 +++
 2 files changed, 161 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index b6234a5..b3566fd 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -122,6 +122,9 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, un=
signed long parent_rate,
=20
 	div =3D _get_div(table, val, flags, width);
 	if (!div) {
+		if (flags & CLK_DIVIDER_ZERO_GATE)
+			return 0;
+
 		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
 			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
 			clk_hw_get_name(hw));
@@ -145,6 +148,34 @@ static unsigned long clk_divider_recalc_rate(struct cl=
k_hw *hw,
 				   divider->flags, divider->width);
 }
=20
+static unsigned long clk_divider_gate_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned long flags =3D 0;
+	unsigned int val;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	if (!clk_hw_is_enabled(hw)) {
+		val =3D divider->cached_val;
+	} else {
+		val =3D clk_readl(divider->reg) >> divider->shift;
+		val &=3D clk_div_mask(divider->width);
+	}
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->flags, divider->width);
+}
+
 static bool _is_valid_table_div(const struct clk_div_table *table,
 							 unsigned int div)
 {
@@ -437,6 +468,108 @@ static int clk_divider_set_rate(struct clk_hw *hw, un=
signed long rate,
 	return 0;
 }
=20
+static int clk_divider_gate_set_rate(struct clk_hw *hw, unsigned long rate=
,
+				unsigned long parent_rate)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned long flags =3D 0;
+	int value;
+	u32 val;
+
+	value =3D divider_get_val(rate, parent_rate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	if (clk_hw_is_enabled(hw)) {
+		if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
+			val =3D clk_div_mask(divider->width) << (divider->shift + 16);
+		} else {
+			val =3D clk_readl(divider->reg);
+			val &=3D ~(clk_div_mask(divider->width) << divider->shift);
+		}
+		val |=3D (u32)value << divider->shift;
+		clk_writel(val, divider->reg);
+	} else {
+		divider->cached_val =3D value;
+	}
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+static int clk_divider_enable(struct clk_hw *hw)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned long flags =3D 0;
+	u32 val;
+
+	if (!divider->cached_val) {
+		pr_err("%s: no valid preset rate\n", clk_hw_get_name(hw));
+		return -EINVAL;
+	}
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	/* restore div val */
+	val =3D clk_readl(divider->reg);
+	val |=3D divider->cached_val << divider->shift;
+	clk_writel(val, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+static void clk_divider_disable(struct clk_hw *hw)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned long flags =3D 0;
+	u32 val;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	/* store the current div val */
+	val =3D clk_readl(divider->reg) >> divider->shift;
+	val &=3D clk_div_mask(divider->width);
+	divider->cached_val =3D val;
+	clk_writel(0, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+}
+
+static int clk_divider_is_enabled(struct clk_hw *hw)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	u32 val;
+
+	val =3D clk_readl(divider->reg) >> divider->shift;
+	val &=3D clk_div_mask(divider->width);
+
+	return val ? 1 : 0;
+}
+
 const struct clk_ops clk_divider_ops =3D {
 	.recalc_rate =3D clk_divider_recalc_rate,
 	.round_rate =3D clk_divider_round_rate,
@@ -444,6 +577,16 @@ const struct clk_ops clk_divider_ops =3D {
 };
 EXPORT_SYMBOL_GPL(clk_divider_ops);
=20
+const struct clk_ops clk_divider_gate_ops =3D {
+	.recalc_rate =3D clk_divider_gate_recalc_rate,
+	.round_rate =3D clk_divider_round_rate,
+	.set_rate =3D clk_divider_gate_set_rate,
+	.enable =3D clk_divider_enable,
+	.disable =3D clk_divider_disable,
+	.is_enabled =3D clk_divider_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_divider_gate_ops);
+
 const struct clk_ops clk_divider_ro_ops =3D {
 	.recalc_rate =3D clk_divider_recalc_rate,
 	.round_rate =3D clk_divider_round_rate,
@@ -459,6 +602,7 @@ static struct clk_hw *_register_divider(struct device *=
dev, const char *name,
 	struct clk_divider *div;
 	struct clk_hw *hw;
 	struct clk_init_data init;
+	u32 val;
 	int ret;
=20
 	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
@@ -476,6 +620,8 @@ static struct clk_hw *_register_divider(struct device *=
dev, const char *name,
 	init.name =3D name;
 	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
 		init.ops =3D &clk_divider_ro_ops;
+	else if (clk_divider_flags & CLK_DIVIDER_ZERO_GATE)
+		init.ops =3D &clk_divider_gate_ops;
 	else
 		init.ops =3D &clk_divider_ops;
 	init.flags =3D flags | CLK_IS_BASIC;
@@ -491,6 +637,12 @@ static struct clk_hw *_register_divider(struct device =
*dev, const char *name,
 	div->hw.init =3D &init;
 	div->table =3D table;
=20
+	if (div->flags & CLK_DIVIDER_ZERO_GATE) {
+		val =3D clk_readl(reg) >> shift;
+		val &=3D clk_div_mask(width);
+		div->cached_val =3D val;
+	}
+
 	/* register the clock */
 	hw =3D &div->hw;
 	ret =3D clk_hw_register(dev, hw);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08b1aa7..08f135a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -387,6 +387,7 @@ struct clk_div_table {
  * @shift:	shift to the divider bit field
  * @width:	width of the divider bit field
  * @table:	array of value/divider pairs, last entry should have div =3D 0
+ * @cached_val: cached div hw value used for CLK_DIVIDER_ZERO_GATE
  * @lock:	register lock
  *
  * Clock with an adjustable divider affecting its output frequency.  Imple=
ments
@@ -415,6 +416,12 @@ struct clk_div_table {
  * CLK_DIVIDER_MAX_AT_ZERO - For dividers which are like CLK_DIVIDER_ONE_B=
ASED
  *	except when the value read from the register is zero, the divisor is
  *	2^width of the field.
+ * CLK_DIVIDER_ZERO_GATE - For dividers which are like CLK_DIVIDER_ONE_BAS=
ED
+ *	when the value read from the register is zero, it means the divisor
+ *	is gated. For this case, the cached_val will be used to store the
+ *	intermediate div for the normal rate operation, like set_rate/get_rate/
+ *	recalc_rate. When the divider is ungated, the driver will actually
+ *	program the hardware to have the requested divider value.
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -423,6 +430,7 @@ struct clk_divider {
 	u8		width;
 	u8		flags;
 	const struct clk_div_table	*table;
+	u32		cached_val;
 	spinlock_t	*lock;
 };
=20
@@ -436,6 +444,7 @@ struct clk_divider {
 #define CLK_DIVIDER_ROUND_CLOSEST	BIT(4)
 #define CLK_DIVIDER_READ_ONLY		BIT(5)
 #define CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
+#define CLK_DIVIDER_ZERO_GATE		BIT(7)
=20
 extern const struct clk_ops clk_divider_ops;
 extern const struct clk_ops clk_divider_ro_ops;
--=20
2.7.4

