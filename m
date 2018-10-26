Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFE8C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0722085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bC5sA6qF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0722085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJ0A5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:57:33 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:45093 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeJ0A5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:57:31 -0400
X-IronPort-AV: E=Sophos;i="5.54,428,1534834800"; 
   d="scan'208";a="20187339"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Oct 2018 09:19:52 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 26 Oct 2018 09:19:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvqjjW+uLz5CMP2p/3h+xplp/7O3+Qo56tXuAOxdoCQ=;
 b=bC5sA6qFByNU4jpuRSbDsmT2YOS2IE3AyHdFGjr0+JRGRI0yHmnF/mlRHCa/tensbRTvA5GJPuhSuv3UQxRW4GOc1RiHymCiN1cEiwmRsAGO4edKxo9lk3nR5JRu1/ep7H8J76E0/6pSAXW+BClpqDsVGeOk7W4bDjtR9w0B+/g=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0792.namprd11.prod.outlook.com (10.163.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Fri, 26 Oct 2018 16:19:48 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8%7]) with mapi id 15.20.1273.021; Fri, 26 Oct 2018
 16:19:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <boris.brezillon@bootlin.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/2] regulator: act8945: Implement PM functionalities
Thread-Topic: [PATCH 1/2] regulator: act8945: Implement PM functionalities
Thread-Index: AQHUbUe3aB7PxIHxB0GWg8NpuJvvnA==
Date:   Fri, 26 Oct 2018 16:19:48 +0000
Message-ID: <1540570753-16370-2-git-send-email-claudiu.beznea@microchip.com>
References: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0095.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::48) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0792;6:EUlFOEiDfZzwgg8koXmzBqs7eDJVYTit9zcPCwXHIhbw55WSboyN4+ZnAeCvUevpnjSnoGA9SS05MtSdVdiLoF/N208oJx8LIOSN7fJJSvI5n1pBx6oZvtLTzVYhas/9qcBFBG88Ugt2w7D6vN0cWNSB88auc17+8OFTN5XuEveMLAAovc5hpDXl/qIgBSII+Re/EAxtymswnPzwPy+wljmiHmxyW8l2TdiA+ECPf6Cjt+xnT9kwQGiyYr+mIuNTP4aqxYBsfyQbT1kDoEHNFR7n2LE3VAKkJFP/zB3djAOYSnDIPujs8M285cU6zH9uh8d7SeHcoJZk75MXsWMa+EcWI3Yp/CYaZvSTTfij90ODv/MlTYgLO/LFObnKUy7lo2uH8u3xX8HXtkpHc8ullZjXxaOvk3egn+EeMFAY7MRu3VIPPYNq1vxRZxaJn3Ydqkj6OFs8AjS2ylw237paRg==;5:A4sHFviSxG9AdG0OV2WHFxQgzdQIyguZ3N3vQTho7giYbapa1SEusBugppitY4czqX2c4BddiQ1boC6jDkb7JSOTcIgCsJzt2Xngw3tm9pPs9sr7iaIs87ZPeSRNw3PomvFvKtVo5RHKeX9QAwYnlE1/4QyYkKma5iHwpD6R8xE=;7:K04bBvyW9vCZheGodOxm1mrmSnq7DfeJi5pLZVs8hxHLSuHy8S9jNLbtevLOK9G5xLpzbdq0YtXr2QL/4qZRO4TGMdQxldGSrJtJMLdmF8CF20qSmxqThvJ3h9kdaYcxLLt71UBhnJU6beYG6ro/ag==
x-ms-office365-filtering-correlation-id: 201a4e47-c29a-48a1-5db8-08d63b5ed98a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0792;
x-ms-traffictypediagnostic: BY2PR11MB0792:
x-microsoft-antispam-prvs: <BY2PR11MB0792C46D4BA724D4DFBD063A87F00@BY2PR11MB0792.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0792;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0792;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39840400004)(199004)(189003)(52116002)(256004)(2501003)(11346002)(76176011)(6486002)(99286004)(66066001)(3846002)(105586002)(81156014)(6116002)(71190400001)(25786009)(107886003)(8676002)(39060400002)(7736002)(305945005)(2616005)(476003)(446003)(68736007)(4326008)(5660300001)(36756003)(478600001)(2906002)(5250100002)(110136005)(54906003)(2900100001)(53936002)(14454004)(575784001)(72206003)(316002)(26005)(81166006)(6512007)(386003)(6506007)(86362001)(106356001)(186003)(71200400001)(14444005)(486006)(8936002)(6436002)(102836004)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0792;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sMYxXWTmwhRpHE5G/YwpdopmN1vrYk7pISa/npuN1Awf9MfbAu6JBqeFimw/zWAVB1pPGsEk14mUMcA4Z2QyCOibGohQDvzvKAMTrmcK0LgbXyzJyns0Msh7avyfL5Kg6/Ph8gylVZbwZIYW2BN9U3OpbxTW9YmlwaE5hhGxc3IlISBB/+K6wzx3O0neEzj6lKfC2MkQgAdKRRohutZfWAUzCYuyWQRF+dnTuhlIuXOVycoOqyHaDCHPDtMCRb0XrW5huIKgjjgGrUe/jJAix1P+yPRVg5GQpkYvpinPDb4ziqYrcO4r3RAyqBSwToNonJaQkaU9dkgoW+HiKvdYzp4n12LskADdD5xFiW4qyUQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 201a4e47-c29a-48a1-5db8-08d63b5ed98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 16:19:48.6025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0792
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

The regulator supports a dedicated suspend mode.
Implement the appropriate ->set_suspend_xx() hooks, add support for
->set_mode(), and provide basic PM ops functionalities to setup the
regulator in a suspend state when the system is entering suspend.

We also implement the ->shutdown() method to make sure the PMIC will
not enter the suspend state when the system is shutdown.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[claudiu.beznea@microchip.com: remove dev_pm_ops, fix checkpatch warking, a=
dapt commit message]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/act8945a-regulator.c | 195 +++++++++++++++++++++++++++++=
+++-
 1 file changed, 193 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act=
8945a-regulator.c
index 43fda8b4455a..41bf7d224abb 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
=20
@@ -23,23 +24,36 @@
  */
 #define ACT8945A_SYS_MODE	0x00
 #define ACT8945A_SYS_CTRL	0x01
+#define ACT8945A_SYS_UNLK_REGS	0x0b
 #define ACT8945A_DCDC1_VSET1	0x20
 #define ACT8945A_DCDC1_VSET2	0x21
 #define ACT8945A_DCDC1_CTRL	0x22
+#define ACT8945A_DCDC1_SUS	0x24
 #define ACT8945A_DCDC2_VSET1	0x30
 #define ACT8945A_DCDC2_VSET2	0x31
 #define ACT8945A_DCDC2_CTRL	0x32
+#define ACT8945A_DCDC2_SUS	0x34
 #define ACT8945A_DCDC3_VSET1	0x40
 #define ACT8945A_DCDC3_VSET2	0x41
 #define ACT8945A_DCDC3_CTRL	0x42
+#define ACT8945A_DCDC3_SUS	0x44
+
+#define ACT8945A_DCDC_MODE_MSK		BIT(5)
+#define ACT8945A_DCDC_MODE_FIXED	BIT(5)
+#define ACT8945A_DCDC_MODE_POWER_SAVING	(0)
+
 #define ACT8945A_LDO1_VSET	0x50
 #define ACT8945A_LDO1_CTRL	0x51
+#define ACT8945A_LDO1_SUS	0x52
 #define ACT8945A_LDO2_VSET	0x54
 #define ACT8945A_LDO2_CTRL	0x55
+#define ACT8945A_LDO2_SUS	0x56
 #define ACT8945A_LDO3_VSET	0x60
 #define ACT8945A_LDO3_CTRL	0x61
+#define ACT8945A_LDO3_SUS	0x62
 #define ACT8945A_LDO4_VSET	0x64
 #define ACT8945A_LDO4_CTRL	0x65
+#define ACT8945A_LDO4_SUS	0x66
=20
 /**
  * Field Definitions.
@@ -63,12 +77,154 @@ enum {
 	ACT8945A_REG_NUM,
 };
=20
+struct act8945a_pmic {
+	struct regulator_dev *rdevs[ACT8945A_REG_NUM];
+	struct regmap *regmap;
+};
+
 static const struct regulator_linear_range act8945a_voltage_ranges[] =3D {
 	REGULATOR_LINEAR_RANGE(600000, 0, 23, 25000),
 	REGULATOR_LINEAR_RANGE(1200000, 24, 47, 50000),
 	REGULATOR_LINEAR_RANGE(2400000, 48, 63, 100000),
 };
=20
+static int act8945a_set_suspend_state(struct regulator_dev *rdev, bool ena=
ble)
+{
+	struct regmap *regmap =3D rdev->regmap;
+	int id =3D rdev->desc->id, ret, reg, val;
+
+	switch (id) {
+	case ACT8945A_ID_DCDC1:
+		reg =3D ACT8945A_DCDC1_SUS;
+		val =3D 0xa8;
+		break;
+	case ACT8945A_ID_DCDC2:
+		reg =3D ACT8945A_DCDC2_SUS;
+		val =3D 0xa8;
+		break;
+	case ACT8945A_ID_DCDC3:
+		reg =3D ACT8945A_DCDC3_SUS;
+		val =3D 0xa8;
+		break;
+	case ACT8945A_ID_LDO1:
+		reg =3D ACT8945A_LDO1_SUS;
+		val =3D 0xe8;
+		break;
+	case ACT8945A_ID_LDO2:
+		reg =3D ACT8945A_LDO2_SUS;
+		val =3D 0xe8;
+		break;
+	case ACT8945A_ID_LDO3:
+		reg =3D ACT8945A_LDO3_SUS;
+		val =3D 0xe8;
+		break;
+	case ACT8945A_ID_LDO4:
+		reg =3D ACT8945A_LDO4_SUS;
+		val =3D 0xe8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (enable)
+		val |=3D BIT(4);
+
+	/*
+	 * Ask the PMIC to enable/disable this output when entering hibernate
+	 * mode.
+	 */
+	ret =3D regmap_write(regmap, reg, val);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Ask the PMIC to enter the suspend mode on the next PWRHLD
+	 * transition.
+	 */
+	return regmap_write(regmap, ACT8945A_SYS_CTRL, 0x42);
+}
+
+static int act8945a_set_suspend_enable(struct regulator_dev *rdev)
+{
+	return act8945a_set_suspend_state(rdev, true);
+}
+
+static int act8945a_set_suspend_disable(struct regulator_dev *rdev)
+{
+	return act8945a_set_suspend_state(rdev, false);
+}
+
+static unsigned int act8945a_of_map_mode(unsigned int mode)
+{
+	if (mode =3D=3D ACT8945A_DCDC_MODE_POWER_SAVING)
+		return REGULATOR_MODE_STANDBY;
+
+	return REGULATOR_MODE_NORMAL;
+}
+
+static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode=
)
+{
+	struct regmap *regmap =3D rdev->regmap;
+	int id =3D rdev->desc->id;
+	int reg, val;
+
+	switch (mode) {
+	case REGULATOR_MODE_STANDBY:
+		val =3D ACT8945A_DCDC_MODE_POWER_SAVING;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val =3D ACT8945A_DCDC_MODE_FIXED;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (id) {
+	case ACT8945A_ID_DCDC1:
+		reg =3D ACT8945A_DCDC1_CTRL;
+		break;
+	case ACT8945A_ID_DCDC2:
+		reg =3D ACT8945A_DCDC2_CTRL;
+		break;
+	case ACT8945A_ID_DCDC3:
+		reg =3D ACT8945A_DCDC3_CTRL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(regmap, reg, ACT8945A_DCDC_MODE_MSK, val);
+}
+
+static unsigned int act8945a_get_mode(struct regulator_dev *rdev)
+{
+	struct regmap *regmap =3D rdev->regmap;
+	int id =3D rdev->desc->id;
+	unsigned int val;
+	int reg;
+
+	switch (id) {
+	case ACT8945A_ID_DCDC1:
+		reg =3D ACT8945A_DCDC1_CTRL;
+		break;
+	case ACT8945A_ID_DCDC2:
+		reg =3D ACT8945A_DCDC2_CTRL;
+		break;
+	case ACT8945A_ID_DCDC3:
+		reg =3D ACT8945A_DCDC3_CTRL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_read(regmap, reg, &val);
+
+	if ((val & ACT8945A_DCDC_MODE_MSK) =3D=3D ACT8945A_DCDC_MODE_POWER_SAVING=
)
+		return REGULATOR_MODE_STANDBY;
+
+	return REGULATOR_MODE_NORMAL;
+}
+
 static const struct regulator_ops act8945a_ops =3D {
 	.list_voltage		=3D regulator_list_voltage_linear_range,
 	.map_voltage		=3D regulator_map_voltage_linear_range,
@@ -76,7 +232,11 @@ static const struct regulator_ops act8945a_ops =3D {
 	.set_voltage_sel	=3D regulator_set_voltage_sel_regmap,
 	.enable			=3D regulator_enable_regmap,
 	.disable		=3D regulator_disable_regmap,
+	.set_mode		=3D act8945a_set_mode,
+	.get_mode		=3D act8945a_get_mode,
 	.is_enabled		=3D regulator_is_enabled_regmap,
+	.set_suspend_enable	=3D act8945a_set_suspend_enable,
+	.set_suspend_disable	=3D act8945a_set_suspend_disable,
 };
=20
 #define ACT89xx_REG(_name, _family, _id, _vsel_reg, _supply)		\
@@ -84,6 +244,7 @@ static const struct regulator_ops act8945a_ops =3D {
 		.name			=3D _name,			\
 		.supply_name		=3D _supply,			\
 		.of_match		=3D of_match_ptr("REG_"#_id),	\
+		.of_map_mode		=3D act8945a_of_map_mode,		\
 		.regulators_node	=3D of_match_ptr("regulators"),	\
 		.id			=3D _family##_ID_##_id,		\
 		.type			=3D REGULATOR_VOLTAGE,		\
@@ -122,10 +283,22 @@ static int act8945a_pmic_probe(struct platform_device=
 *pdev)
 {
 	struct regulator_config config =3D { };
 	const struct regulator_desc *regulators;
+	struct act8945a_pmic *act8945a;
 	struct regulator_dev *rdev;
 	int i, num_regulators;
 	bool voltage_select;
=20
+	act8945a =3D devm_kzalloc(&pdev->dev, sizeof(*act8945a), GFP_KERNEL);
+	if (!act8945a)
+		return -ENOMEM;
+
+	act8945a->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
+	if (!act8945a->regmap) {
+		dev_err(&pdev->dev,
+			"could not retrieve regmap from parent device\n");
+		return -EINVAL;
+	}
+
 	voltage_select =3D of_property_read_bool(pdev->dev.parent->of_node,
 					       "active-semi,vsel-high");
=20
@@ -140,16 +313,33 @@ static int act8945a_pmic_probe(struct platform_device=
 *pdev)
 	config.dev =3D &pdev->dev;
 	config.dev->of_node =3D pdev->dev.parent->of_node;
 	for (i =3D 0; i < num_regulators; i++) {
-		rdev =3D devm_regulator_register(&pdev->dev, &regulators[i], &config);
+		rdev =3D devm_regulator_register(&pdev->dev, &regulators[i],
+					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev,
 				"failed to register %s regulator\n",
 				regulators[i].name);
 			return PTR_ERR(rdev);
 		}
+
+		act8945a->rdevs[i] =3D rdev;
 	}
=20
-	return 0;
+	platform_set_drvdata(pdev, act8945a);
+
+	/* Unlock expert registers. */
+	return regmap_write(act8945a->regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
+}
+
+static void act8945a_pmic_shutdown(struct platform_device *pdev)
+{
+	struct act8945a_pmic *act8945a =3D platform_get_drvdata(pdev);
+	struct regmap *regmap =3D act8945a->regmap;
+
+	/*
+	 * Ask the PMIC to shutdown everything on the next PWRHLD transition.
+	 */
+	regmap_write(regmap, ACT8945A_SYS_CTRL, 0x0);
 }
=20
 static struct platform_driver act8945a_pmic_driver =3D {
@@ -157,6 +347,7 @@ static struct platform_driver act8945a_pmic_driver =3D =
{
 		.name =3D "act8945a-regulator",
 	},
 	.probe =3D act8945a_pmic_probe,
+	.shutdown =3D act8945a_pmic_shutdown,
 };
 module_platform_driver(act8945a_pmic_driver);
=20
--=20
2.7.4

