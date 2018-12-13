Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5580CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053CB20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TxDnKOGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053CB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbeLMMuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:50:01 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:36710 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbeLMMt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:49:59 -0500
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="21458533"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Dec 2018 05:49:58 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 13 Dec 2018 05:49:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/64nsyluGvElwmByazX56Qn5dAUA5zlsQ0zdQprWoVo=;
 b=TxDnKOGsDdmDIR7N3TKMRemQDN9W9ehcsEDro+hk3KQ8pvFx2qRrhK6FZutGfBDDUhOBc8/Hz5Wx/Uxl5DLYVxEWeMVcetLvSoJCjbLPrspeC22qWFr2BpNLKdOO+RFjG8F8/nqEd+GCfn90jHe6niMbdgeXmid7quDxL7LF3HE=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0519.namprd11.prod.outlook.com (10.163.158.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 12:49:55 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:49:55 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <boris.brezillon@bootlin.com>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v4 3/6] regulator: act8945a-regulator: Implement PM
 functionalities
Thread-Topic: [PATCH v4 3/6] regulator: act8945a-regulator: Implement PM
 functionalities
Thread-Index: AQHUkuJYOggHUxUFvkGpKYNfCqpWDA==
Date:   Thu, 13 Dec 2018 12:49:55 +0000
Message-ID: <1544703110-27161-4-git-send-email-claudiu.beznea@microchip.com>
References: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0519;6:HjpRThytv4Fad836xEgf8DTKpXEJRKEj9iPGYdc/Gfx4asPdp+EIkpBOgVvnPWbPixKgjUA44vcDvOV8RswvGFGmOjgpe7vn723wpou5l77eNP4x6ciOSId+S9Tmc5gOcqB0Zb6OQhgo0B40yOCrRc+I2dtQO/9lgsWuCaL3tX0Gm7FkCD064TJVrFwvQxtTJlL+BQtU0ttvHqD3c/necBhlwi9bvFIn47Lf7B7jVe+YNGmm3exxqA1FFq/+eIRcYnyYDCTyd5XumNE6DGvpbgRTH2UgoqFfe5uGYLc1IIvY7wO/yWy9PjXap3diyN/mjey3wRKi0EILVE2lcJZrVkMBgbMOp5KnGUfYsgRU2d2NNT31PSXVTiIM0++aojfZmNaNnbedc8cDGB5vDkmsFQDH9muwwkqAe2Vp/MPxi5yUVzee6vm0+svjezuT0RvwqLFSD1q1UfVkgwieaelx0Q==;5:lfKk1u8AulpGR1GNQThaKSQfLe6ujztjwc5GNBdNlLkK+++6XMbGYkaKehfnCIGY9SFlcMyZFZSJQeyG7/zkfkJ0yciIdMj8HAyqxpudFtJHtazQSl0eLwFIbDvLNI7L/dvPNA7R48DDFv9fYgnJatec/VtXVmxXgqyhwDdA72Y=;7:1shCnBSUl2kJQ0vP/ps9ik8JprwmtjiiTcWDJKwa4cxBNIgoUaI6rsYTYs4uHVyPHEBRE0mbXJIB+8OOBdG1U6K6hyIEZ3ftOMunGGjmGjKFNgzoh+V+QmlvU2jwbWWVFBQHPl4DCvzFjAHqOWsxdw==
x-ms-office365-filtering-correlation-id: 6529e970-06dc-45c5-f49e-08d660f97b30
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0519;
x-ms-traffictypediagnostic: BY2PR11MB0519:
x-microsoft-antispam-prvs: <BY2PR11MB0519B02FA9891577FB8EE23A87A00@BY2PR11MB0519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0519;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0519;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(316002)(5660300001)(305945005)(8936002)(97736004)(2501003)(102836004)(26005)(6436002)(36756003)(99286004)(476003)(68736007)(3846002)(386003)(6506007)(7736002)(14444005)(76176011)(52116002)(6486002)(106356001)(6116002)(186003)(4326008)(105586002)(6512007)(256004)(53936002)(81166006)(81156014)(8676002)(2906002)(66066001)(39060400002)(25786009)(575784001)(2616005)(86362001)(486006)(446003)(6636002)(478600001)(54906003)(107886003)(110136005)(71200400001)(71190400001)(72206003)(11346002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0519;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8mvUwHRp2pOxv8lkSgjPvnNxon9KXTHevmOs1uDK9keymqSHSb72JEmZx2ox0/zTiy5ayWcphtjaLgdK7i7borZVs4m+0adl+q752O1eqeJAMVylVpzka77XRz0+1Ocu38rKk8/w8kDYTjUbxHoqM08S51RJZJUJIBIYLPhRqYT1ieIUK325w4bJLkpQwuxMDus+x8Ou8POar7B3Yo7fd8+D3sajEUEZfewdvl1ZRSRdYPmad5g5UHJuRq/9BYC2aenImoIauV+y4rB98mF2vYlBcN7BZnnKtp1QDa/5d+fx3b+0GxC95RUhkZ3PIng2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6529e970-06dc-45c5-f49e-08d660f97b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:49:55.3186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0519
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

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[claudiu.beznea@microchip.com: remove shutdown function, use dev_pm_ops,
 fix checkpatch warning, adapt commit message, add LDO modes support,
 move modes constants to active-semi,8945a-regulator.h, remove rdevs from
 struct act8945a_pmic, add op_mode to act8945a_pmic]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/act8945a-regulator.c | 186 +++++++++++++++++++++++++++++=
+++-
 1 file changed, 181 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act=
8945a-regulator.c
index 8d71d9893d0d..f37d1a860407 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
=20
 /**
  * ACT8945A Global Register Map.
@@ -28,20 +29,27 @@
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
@@ -62,7 +70,12 @@ enum {
 	ACT8945A_ID_LDO2,
 	ACT8945A_ID_LDO3,
 	ACT8945A_ID_LDO4,
-	ACT8945A_REG_NUM,
+	ACT8945A_ID_MAX,
+};
+
+struct act8945a_pmic {
+	struct regmap *regmap;
+	u32 op_mode[ACT8945A_ID_MAX];
 };
=20
 static const struct regulator_linear_range act8945a_voltage_ranges[] =3D {
@@ -71,6 +84,143 @@ static const struct regulator_linear_range act8945a_vol=
tage_ranges[] =3D {
 	REGULATOR_LINEAR_RANGE(2400000, 48, 63, 100000),
 };
=20
+static int act8945a_set_suspend_state(struct regulator_dev *rdev, bool ena=
ble)
+{
+	struct regmap *regmap =3D rdev->regmap;
+	int id =3D rdev->desc->id, reg, val;
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
+	return regmap_write(regmap, reg, val);
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
+	switch (mode) {
+	case ACT8945A_REGULATOR_MODE_FIXED:
+	case ACT8945A_REGULATOR_MODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case ACT8945A_REGULATOR_MODE_LOWPOWER:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode=
)
+{
+	struct act8945a_pmic *act8945a =3D rdev_get_drvdata(rdev);
+	struct regmap *regmap =3D rdev->regmap;
+	int id =3D rdev->desc->id;
+	int reg, ret, val =3D 0;
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
+	case ACT8945A_ID_LDO1:
+		reg =3D ACT8945A_LDO1_SUS;
+		break;
+	case ACT8945A_ID_LDO2:
+		reg =3D ACT8945A_LDO2_SUS;
+		break;
+	case ACT8945A_ID_LDO3:
+		reg =3D ACT8945A_LDO3_SUS;
+		break;
+	case ACT8945A_ID_LDO4:
+		reg =3D ACT8945A_LDO4_SUS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (mode) {
+	case REGULATOR_MODE_STANDBY:
+		if (rdev->desc->id > ACT8945A_ID_DCDC3)
+			val =3D BIT(5);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		if (rdev->desc->id <=3D ACT8945A_ID_DCDC3)
+			val =3D BIT(5);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret =3D regmap_update_bits(regmap, reg, BIT(5), val);
+	if (ret)
+		return ret;
+
+	act8945a->op_mode[id] =3D mode;
+
+	return 0;
+}
+
+static unsigned int act8945a_get_mode(struct regulator_dev *rdev)
+{
+	struct act8945a_pmic *act8945a =3D rdev_get_drvdata(rdev);
+	int id =3D rdev->desc->id;
+
+	if (id < ACT8945A_ID_DCDC1 || id >=3D ACT8945A_ID_MAX)
+		return -EINVAL;
+
+	return act8945a->op_mode[id];
+}
+
 static const struct regulator_ops act8945a_ops =3D {
 	.list_voltage		=3D regulator_list_voltage_linear_range,
 	.map_voltage		=3D regulator_map_voltage_linear_range,
@@ -78,7 +228,11 @@ static const struct regulator_ops act8945a_ops =3D {
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
@@ -86,6 +240,7 @@ static const struct regulator_ops act8945a_ops =3D {
 		.name			=3D _name,			\
 		.supply_name		=3D _supply,			\
 		.of_match		=3D of_match_ptr("REG_"#_id),	\
+		.of_map_mode		=3D act8945a_of_map_mode,		\
 		.regulators_node	=3D of_match_ptr("regulators"),	\
 		.id			=3D _family##_ID_##_id,		\
 		.type			=3D REGULATOR_VOLTAGE,		\
@@ -124,13 +279,17 @@ static int act8945a_pmic_probe(struct platform_device=
 *pdev)
 {
 	struct regulator_config config =3D { };
 	const struct regulator_desc *regulators;
+	struct act8945a_pmic *act8945a;
 	struct regulator_dev *rdev;
-	struct regmap *regmap;
 	int i, num_regulators;
 	bool voltage_select;
=20
-	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
-	if (!regmap) {
+	act8945a =3D devm_kzalloc(&pdev->dev, sizeof(*act8945a), GFP_KERNEL);
+	if (!act8945a)
+		return -ENOMEM;
+
+	act8945a->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
+	if (!act8945a->regmap) {
 		dev_err(&pdev->dev,
 			"could not retrieve regmap from parent device\n");
 		return -EINVAL;
@@ -149,6 +308,7 @@ static int act8945a_pmic_probe(struct platform_device *=
pdev)
=20
 	config.dev =3D &pdev->dev;
 	config.dev->of_node =3D pdev->dev.parent->of_node;
+	config.driver_data =3D act8945a;
 	for (i =3D 0; i < num_regulators; i++) {
 		rdev =3D devm_regulator_register(&pdev->dev, &regulators[i], &config);
 		if (IS_ERR(rdev)) {
@@ -159,13 +319,29 @@ static int act8945a_pmic_probe(struct platform_device=
 *pdev)
 		}
 	}
=20
+	platform_set_drvdata(pdev, act8945a);
+
 	/* Unlock expert registers. */
-	return regmap_write(regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
+	return regmap_write(act8945a->regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
 }
=20
+static int act8945a_suspend(struct device *pdev)
+{
+	struct act8945a_pmic *act8945a =3D dev_get_drvdata(pdev);
+
+	/*
+	 * Ask the PMIC to enter the suspend mode on the next PWRHLD
+	 * transition.
+	 */
+	return regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x42);
+}
+
+SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
+
 static struct platform_driver act8945a_pmic_driver =3D {
 	.driver =3D {
 		.name =3D "act8945a-regulator",
+		.pm =3D &act8945a_pm,
 	},
 	.probe =3D act8945a_pmic_probe,
 };
--=20
2.7.4

