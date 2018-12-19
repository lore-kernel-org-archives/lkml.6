Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBA221850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hgQoq6st"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeLSFZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:25:05 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:30688
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727321AbeLSFZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Qvi8SidpDlNUuRS/ioA1ZHmBxrHmEsY/nr5UMh/3r4=;
 b=hgQoq6sti/bgw868K9kst1+7xtbfl1SO8C53e10P/KOBsrQID8tC4vlNHhWXhFmcFQeMGeH82alz43sUc1DqFWZITlbTPuzfa4MNf2nT55PIBLfY+YnEh9uezQgDpkdQDcAsmeUDNeeYw9f41kH2LqxoDstcXhe1xxt4hc9M3H8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3SPR01MB014.eurprd04.prod.outlook.com (52.134.70.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 05:24:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 05:24:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] pwm: imx: add ipg clock operation
Thread-Topic: [PATCH] pwm: imx: add ipg clock operation
Thread-Index: AQHUl1suxeUnCR+GgEiqBlmW06QBLg==
Date:   Wed, 19 Dec 2018 05:24:58 +0000
Message-ID: <1545196822-31361-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3SPR01MB014;6:qywFLFgFRZ9UNzpWocId2x1Z2Nm9CcWPlX93I7QtQGKXLHGL5iYXhwEN5iLJ7jVPA0ILecTzXoWNfRO0kVB4ibXDDjYMng6q6I8xy/NXmXBtR0m0OBEEwVEhkTDBQ0jrAhzIrPL1OrqUdrPl0Nm973BIkN3+tywcgLMkvBfhNhHJG2SHpgHnTBBBb6Etpf1mCRfIzReyqOIjCsIT9kIcRYQfuR4IDirT6GfT1IMzvQjadWBX0RdF98s0ByvS1MZd92o3Z7mBI12RGoeZaZDPYms7Ll6Ps+1SwQhJksfmVRFf0IPwhc3DIK9u6tymiTAAnMKVNZYIWe8GXNvsA460dZJ09lLES3/VkVAc1DGConV9R4jOp+mj3ilrx4xVXYFzYyfCJRWrvO+2h1PPIfod3fbfUsAf1Hxl8OAVElfNQL/Qr39ymf096RDbEru58v4OTGh9nmERfF3EbuSQxaBPGQ==;5:1u9CQNEOfODUnNjmuE12gyXQzJLFUtxEUixTN+jWb2UGlHFCxFAMCXNhAKvsV+0SIYppBD4s3mDRqQEFQrR3Wo2heoVGFQ4zXLqDjYOGCC4e22K8nk+Af/qjSiwCL69lTzI1a//3e8dBOcfqJmOkWt/qF50YatQRAccFh14/jmo=;7:SZ1A3HEnTtk/PcGeRRQdCCjezXBWF2dkcxuEZuykZg6KNvYX8Yae3dDazaV7Mu9ymH4t/9viPct2wlbbIK7Vh1oQ3dsa8zR7tcNAjVBxjarVDMunC76kO0vtNLpGlJ90Acwj1l9Rh0n6Bg0hLCpzDg==
x-ms-office365-filtering-correlation-id: fd701f5f-0023-42d7-4862-08d66572511a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3SPR01MB014;
x-ms-traffictypediagnostic: DB3SPR01MB014:
x-microsoft-antispam-prvs: <DB3SPR01MB014B897B06E732F986B8FD6F5BE0@DB3SPR01MB014.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3SPR01MB014;BCL:0;PCL:0;RULEID:;SRVR:DB3SPR01MB014;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(68736007)(110136005)(5660300001)(71200400001)(7736002)(316002)(71190400001)(575784001)(4326008)(2201001)(39060400002)(86362001)(256004)(14444005)(478600001)(25786009)(2616005)(486006)(476003)(14454004)(305945005)(97736004)(53936002)(2501003)(2906002)(36756003)(52116002)(8676002)(26005)(186003)(6436002)(6512007)(81156014)(6116002)(3846002)(81166006)(8936002)(50226002)(6506007)(105586002)(106356001)(386003)(102836004)(6486002)(99286004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3SPR01MB014;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o0M0tx3ib3Pveaf6MJZkLfkxenzcE3ZdURGZfur7hDBQ2VG6t/RRWAd0v1M5iHgY5SjJwVp7ngocXKK8QnzHvQ+mbXovMeVPvV5c9QZG1DMg44x5XUN/G3k4uvLAuDwDWnQC0w1LESG2ad7lgDFc4lUeA+N2hei/sAqKF5fCZBlqpTMJXtkPyordqnnO4Q6hMcZybjd1TlXbLpsBpRr042e5y7pEIpkjZuf/SlYaysvPfJ7khEhfrTG8YLRzsBReo11b2uH+6ymj1bzWMiljn2bNM1fMi08abxOA5szV6XaFnnFax7qktb9G/g16queR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd701f5f-0023-42d7-4862-08d66572511a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 05:24:58.4170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3SPR01MB014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX PWM module's ipg_clk_s is for PWM register access, on
most of i.MX SoCs, this ipg_clk_s is from system ipg clock
or perclk which is always enabled, but on i.MX7D, the ipg_clk_s
is from PWM1_CLK_ROOT which is controlled by CCGR132, that means
the CCGR132 MUST be enabled first before accessing PWM registers
on i.MX7D. This patch adds ipg clock operation to make sure
register access successfully on i.MX7D and it fixes Linux kernel
boot up hang during PWM driver probe.

Fixes: 4a23e6ee9f69 ("ARM: dts: imx7d-sdb: Restore pwm backlight support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 6cd3b72..55a3a36 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -87,6 +87,8 @@
 #define MX3_PWMPR_MAX			0xfffe
=20
 struct imx_chip {
+	struct clk	*clk_ipg;
+
 	struct clk	*clk_per;
=20
 	void __iomem	*mmio_base;
@@ -96,6 +98,32 @@ struct imx_chip {
=20
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
=20
+static int imx_pwm_clk_prepare_enable(struct pwm_chip *chip)
+{
+	struct imx_chip *imx =3D to_imx_chip(chip);
+	int ret;
+
+	ret =3D clk_prepare_enable(imx->clk_ipg);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(imx->clk_per);
+	if (ret) {
+		clk_disable_unprepare(imx->clk_ipg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void imx_pwm_clk_disable_unprepare(struct pwm_chip *chip)
+{
+	struct imx_chip *imx =3D to_imx_chip(chip);
+
+	clk_disable_unprepare(imx->clk_per);
+	clk_disable_unprepare(imx->clk_ipg);
+}
+
 static void imx_pwm_get_state(struct pwm_chip *chip,
 		struct pwm_device *pwm, struct pwm_state *state)
 {
@@ -103,11 +131,15 @@ static void imx_pwm_get_state(struct pwm_chip *chip,
 	u32 period, prescaler, pwm_clk, ret, val;
 	u64 tmp;
=20
+	ret =3D imx_pwm_clk_prepare_enable(chip);
+	if (ret < 0)
+		return;
+
 	val =3D readl(imx->mmio_base + MX3_PWMCR);
=20
 	if (val & MX3_PWMCR_EN) {
 		state->enabled =3D true;
-		ret =3D clk_prepare_enable(imx->clk_per);
+		ret =3D imx_pwm_clk_prepare_enable(chip);
 		if (ret)
 			return;
 	} else {
@@ -143,6 +175,8 @@ static void imx_pwm_get_state(struct pwm_chip *chip,
 	} else {
 		state->duty_cycle =3D 0;
 	}
+
+	imx_pwm_clk_disable_unprepare(chip);
 }
=20
 static int imx_pwm_config_v1(struct pwm_chip *chip,
@@ -180,7 +214,7 @@ static int imx_pwm_enable_v1(struct pwm_chip *chip, str=
uct pwm_device *pwm)
 	u32 val;
 	int ret;
=20
-	ret =3D clk_prepare_enable(imx->clk_per);
+	ret =3D imx_pwm_clk_prepare_enable(chip);
 	if (ret < 0)
 		return ret;
=20
@@ -200,7 +234,7 @@ static void imx_pwm_disable_v1(struct pwm_chip *chip, s=
truct pwm_device *pwm)
 	val &=3D ~MX1_PWMC_EN;
 	writel(val, imx->mmio_base + MX1_PWMC);
=20
-	clk_disable_unprepare(imx->clk_per);
+	imx_pwm_clk_disable_unprepare(chip);
 }
=20
 static void imx_pwm_sw_reset(struct pwm_chip *chip)
@@ -286,7 +320,7 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 		if (cstate.enabled) {
 			imx_pwm_wait_fifo_slot(chip, pwm);
 		} else {
-			ret =3D clk_prepare_enable(imx->clk_per);
+			ret =3D imx_pwm_clk_prepare_enable(chip);
 			if (ret)
 				return ret;
=20
@@ -309,7 +343,7 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 	} else if (cstate.enabled) {
 		writel(0, imx->mmio_base + MX3_PWMCR);
=20
-		clk_disable_unprepare(imx->clk_per);
+		imx_pwm_clk_disable_unprepare(chip);
 	}
=20
 	return 0;
@@ -367,6 +401,13 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (imx =3D=3D NULL)
 		return -ENOMEM;
=20
+	imx->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(imx->clk_ipg)) {
+		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
+				PTR_ERR(imx->clk_ipg));
+		return PTR_ERR(imx->clk_ipg);
+	}
+
 	imx->clk_per =3D devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(imx->clk_per)) {
 		dev_err(&pdev->dev, "getting per clock failed with %ld\n",
@@ -406,6 +447,8 @@ static int imx_pwm_remove(struct platform_device *pdev)
 	if (imx =3D=3D NULL)
 		return -ENODEV;
=20
+	imx_pwm_clk_disable_unprepare(&imx->chip);
+
 	return pwmchip_remove(&imx->chip);
 }
=20
--=20
2.7.4

