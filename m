Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A0C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4353F20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XAySwedu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4353F20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeKKATj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:19:39 -0500
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:62880
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbeKKATi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIf2COuK0zLkMJh3lpZjsWmlj8zfmdBSe3G9aAkENZE=;
 b=XAySwedufJsBxCGeL1Q7Hj3knCinPVdPELPeR0PNk4Wx4WV9R/Ijk+ozxsZ2KXQZ32ij9t/TE1tE/CL635xKkcxWqRI5bJ3ahRL1d3cb8F0ziOALQu6zWyVivRtq/rt4SlHcUo/52mxJW9x6CP5671vMbnEkloRDjeQ+lk8c7RE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Sat, 10 Nov 2018 14:34:21 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 14:34:21 +0000
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
Subject: [PATCH V5 2/9] clk: fractional-divider: add
 CLK_FRAC_DIVIDER_ZERO_BASED flag support
Thread-Topic: [PATCH V5 2/9] clk: fractional-divider: add
 CLK_FRAC_DIVIDER_ZERO_BASED flag support
Thread-Index: AQHUeQJ4H7M6grlas06Jaqx6sohrOA==
Date:   Sat, 10 Nov 2018 14:34:21 +0000
Message-ID: <1541860165-401-3-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4402;6:+ozK55O+3VqilAlUZVHLeZrOAuz6ArWE8M2vM7oZPH/7r+CeW2auNR/bo/Y2mUUzA1ayQHKwXCsdcIo21BnoGnbI08lKzkDor6lDP4RiuioJR4JpFCzhd5dgOibeVDVlgsNZ1ni4gDL1Zv2aRFMwNwuSe2MaW2TczkWZa0rfCHyIqXQ4j3rAwuEq8LF4MtDwRldp+ML9/8xN27ydwBvc1y+nEFGrGXxpfDgaNqEE5lLpRRjR+eitZpsT1XCFxQLrnjEb2HTrfBJqmwMQNJtG2gaoHSxdnqAr8bVphtoqsoUHYt6laI7MoFriepCKP34l9IpDWDZWYQXE684P8utaxUugQnK6hYmGsADg3DDLd/tdY/9HgDFRjDUEpP+wnZHAl3WVOL2pJFcZIUma2Umb7pB/q5ubGDLFpF3CzDI9EMZ1ZAyEZn1zuRnZQ15gtowotn08yPgH6pwZ37+0wFulkA==;5:aRIcqoW0/en8DLyHnzBpES8n3z8xeJBUYuGmtqzlN90DqfuHal4FWYjmcQ1nymB651DXej9AWnUTdutZAXF4Tvt7IVfHlLqgqV9au+ovg7saO4pBzyC0V/WaS1CSgz+zXFDUJG5wJlfEx+ZN1mwFu38IgEQpplm+Mg0bKNYita0=;7:9IZV4xQMesGwY8GaZMRsXrIUY2cZjzyXUQpLt1Ih9r/7K8XJxIrtlpR9lWvPYt4IGuI27WwU6RHDL5WM22lb6xW8haGJBiE64zTqVsCXO+KQ63BmggRJ0ayJDQ+ooCPYvx1xu/YYaQeJKeQPq6Ww9A==
x-ms-office365-filtering-correlation-id: df712d3a-fcd4-4854-bec4-08d647199a90
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4402;
x-ms-traffictypediagnostic: AM0PR04MB4402:
x-microsoft-antispam-prvs: <AM0PR04MB44027B24EA38B23C4B9E915580C70@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4402;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4402;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(54534003)(6512007)(478600001)(102836004)(36756003)(14444005)(4326008)(105586002)(256004)(76176011)(97736004)(71200400001)(71190400001)(106356001)(14454004)(386003)(6506007)(52116002)(2351001)(5660300001)(25786009)(5640700003)(2906002)(81166006)(81156014)(66066001)(6436002)(26005)(186003)(6916009)(8676002)(54906003)(8936002)(3846002)(305945005)(486006)(7736002)(6116002)(2900100001)(446003)(11346002)(68736007)(53936002)(476003)(2501003)(99286004)(6486002)(50226002)(2616005)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YOobZqJtXG7ujdE4OqBC5/kNBOaKdIJuu+SfAgoRkw6lryki+eYvcxiGGVVwQvyNtexffm8Ed4pY/ABCjW6Y/lvf8WmvDrpXOvuxr+jXSMLA2bI3Xh6jmPUfVMPNUbLkFdpk+T+vdWI3FATHYt2Jt19065ky+xs2KaCXuQSSQu4UaOmGYHyOfEamzL+cwZysV6Vnjaq1ZoEAayMoiqA+Mz9N5EsY9cTRPWEICcpiWKf6q73BijHoGq1BvJlLMLRrE1t/QLqa9K6xD2UuEXXY/1SFrMgJi1l/Wq5g3MoOYk2beONgYVcW+nM/yjQyicCIMOPaqbAvfo7f/ZQuxKuz/lAj6bDezV6lX9NQ7gzaaAM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df712d3a-fcd4-4854-bec4-08d647199a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 14:34:21.5027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CLK_FRAC_DIVIDER_ZERO_BASED flag to indicate the numerator and
denominator value in register are start from 0.

This can be used to support frac dividers like below:
Divider output clock =3D Divider input clock x [(frac +1) / (div +1)]
where frac/div in register is:
000b - Divide by 1.
001b - Divide by 2.
010b - Divide by 3.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * no changes
v1->v2:
 * improve comments suggested by Stephen
---
 drivers/clk/clk-fractional-divider.c | 10 ++++++++++
 include/linux/clk-provider.h         |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractio=
nal-divider.c
index fdf625f..7ccde6b 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -40,6 +40,11 @@ static unsigned long clk_fd_recalc_rate(struct clk_hw *h=
w,
 	m =3D (val & fd->mmask) >> fd->mshift;
 	n =3D (val & fd->nmask) >> fd->nshift;
=20
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m++;
+		n++;
+	}
+
 	if (!n || !m)
 		return parent_rate;
=20
@@ -103,6 +108,11 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned=
 long rate,
 			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
 			&m, &n);
=20
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m--;
+		n--;
+	}
+
 	if (fd->lock)
 		spin_lock_irqsave(fd->lock, flags);
 	else
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08f135a..90d7c26 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -603,6 +603,12 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw)=
;
  * @lock:	register lock
  *
  * Clock with adjustable fractional divider affecting its output frequency=
.
+ *
+ * Flags:
+ * CLK_FRAC_DIVIDER_ZERO_BASED - by default the numerator and denominator
+ *	is the value read from the register. If CLK_FRAC_DIVIDER_ZERO_BASED
+ *	is set then the numerator and denominator are both the value read
+ *	plus one.
  */
 struct clk_fractional_divider {
 	struct clk_hw	hw;
@@ -622,6 +628,8 @@ struct clk_fractional_divider {
=20
 #define to_clk_fd(_hw) container_of(_hw, struct clk_fractional_divider, hw=
)
=20
+#define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
+
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
--=20
2.7.4

