Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F8FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908D62080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aGWtcngM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908D62080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeLNIJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:09:35 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:23934 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNIJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:09:34 -0500
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
   d="scan'208";a="24357411"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Dec 2018 01:09:34 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 14 Dec 2018 01:09:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vB4P2Yn0FtcDcsCE9J90vgcEMLM/4zwQQu3LM7UsWs=;
 b=aGWtcngMAFYmjyaWZpgHX45g2b8EGuecOHlfmDQ4Oq0ppi8amMtzQzZjwmOc5Yi08ph0m8Kd2un872tfC4CL8T+uMPevv5SSdWrw3r9Nv8prMjSP0N6LiSaGdDEK+7xoJafqruHx22GBU/i92c0S0noa/qbNNkXlUDaDKVt/QB8=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2244.namprd11.prod.outlook.com (10.174.113.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 14 Dec 2018 08:09:31 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:09:31 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v2] regulator: mcp16502: add support for suspend
Thread-Topic: [PATCH v2] regulator: mcp16502: add support for suspend
Thread-Index: AQHUk4RXn4oajSHRJEWrNiEHEZjYSQ==
Date:   Fri, 14 Dec 2018 08:09:31 +0000
Message-ID: <1544774961-6951-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0106.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::32) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2244;6:Wjzyuba6nyw1GxCCnpIEwbSA+VzDZ+YKqvv3kfjJazrMGqF2R4lO+8DOMSrYv5e8wU6p7P39Y1oRlZs2dGr6PzGNHpNmUS2yXRwbm5ElEtsUheC0Q0MiB9OoN7e0BWpln8EuJUYzJ4tK+55E6i67o7Do+Mo4eXSCb2k2R+b90wxH6QfiFi4HSWPDkpwSYoMkXTkq36kXO7b33sJqViejeAF+N5PsIeRkmPEWN1i6e6LRMwhlRqiHICfD8dCRTU4l9SWP0W6q87h6h6ME6U4Ge0ylVjXCywORGd82WCG7pIuc8VHkBwze0rmPNhBfIC7dcXWqXlh3pY158QcDZIU7W2ln+Otlz0mKKxNZQG4yTVbg9/kdfBV5QZPTvo8GznOhB+37PwryC7MElVEJZo43Wjg2Y0ARUlDCtSrLqUFba/o3hN1QlUKHV4BcBwRN66mKx5AcmYQR0A08N0CjO2rQeg==;5:eRnzcC4d6vIanuqyF0vf+gMMnK+0UDVoFvWFl1SqpN/DkUMG9FB59DsZavGehA3jPOGsMu+sM/8Tx9c7IA+0rVBWUARs6v091Ok7Sgn1g5jW7N6V5Y/ZX2ixqhGAws5Kbgoz+1ghzzlWWABrFa91WCt++fdk4AkjtSm+e6l1s+I=;7:NEO48ietlI41sIOp0dwbCW7+0qPXW+IzxKhUA5ZF9iO+Ag+Cw4thiehziC2MLwagBGoJ/Xtx0Or1r4xkyF0bZGQzCDrBDMHd1b7zKxWHQdm3OjT97gJWY6LvWeOXKPIYl/EVLF/eWui5xS0PNrc2BQ==
x-ms-office365-filtering-correlation-id: e84ed2c8-b4da-4467-38a9-08d6619b79b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2244;
x-ms-traffictypediagnostic: BN6PR1101MB2244:
x-microsoft-antispam-prvs: <BN6PR1101MB22444DABB5270378C1A599D5EDA10@BN6PR1101MB2244.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2244;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2244;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(72206003)(86362001)(107886003)(39060400002)(6116002)(52116002)(6436002)(3846002)(14444005)(256004)(478600001)(305945005)(81156014)(7736002)(71190400001)(6506007)(102836004)(386003)(6512007)(6486002)(71200400001)(186003)(66066001)(8676002)(2616005)(476003)(25786009)(26005)(81166006)(105586002)(14454004)(68736007)(54906003)(2906002)(15650500001)(110136005)(99286004)(5660300001)(106356001)(4326008)(53936002)(8936002)(316002)(2501003)(97736004)(486006)(36756003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2244;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i9a6HlaSPIlb//sD68Lfu5Cer4hbz3RtPnsKtiNKdBaWYnoPoYGbUi9qIPXcUGnlRGRQW5u495fEoqmtGemIXU/q/nhk4FiCQ1iOY6A29wOPRBVD5grESe2VuPhhWhaIFImpzcqxSkarUEOeIzNaBSqyAuOaox7EhlZYaQr/IxabZDQ0TxacylCAa8cOxr87W7gOYu03kZ1C20F7pT5rVCFNFhrO9EkhPHL2JAQyQtUK4n0/HGBe7zFYdr4DwJqQhdImQYLa/uJtSJ0mrsgsElRc598tSygPlJDk/iF96cAOuMck0cs1Vp/UWSMUBXvh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e84ed2c8-b4da-4467-38a9-08d6619b79b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:09:31.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2244
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for entering/resuming suspend states.
It does this by setting the LPM pin of the PMIC.

When suspending the PMIC will enter the Low-power mode
when the LPM pin will be set to high. If the suspend target state
is suspend-to-mem, the PMIC will transition to Hibernate mode,
otherwise, if it is standby, it will remain in Low-power mode.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/regulator/mcp16502.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 7cbc96f..25d7b43 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -497,6 +497,37 @@ static int mcp16502_probe(struct i2c_client *client,
 	return 0;
 }
=20
+#ifdef CONFIG_SUSPEND
+static int mcp16502_suspend_noirq(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct mcp16502 *mcp =3D i2c_get_clientdata(client);
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_LPM);
+
+	return 0;
+}
+
+static int mcp16502_resume_noirq(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct mcp16502 *mcp =3D i2c_get_clientdata(client);
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_ACTIVE);
+
+	return 0;
+}
+#else /* !CONFIG_SUSPEND */
+#define mcp16502_suspend NULL
+#define mcp16502_resume NULL
+#endif /* !CONFIG_SUSPEND */
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops mcp16502_pm_ops =3D {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend_noirq,
+				     mcp16502_resume_noirq)
+};
+#endif
 static const struct i2c_device_id mcp16502_i2c_id[] =3D {
 	{ "mcp16502", 0 },
 	{ }
@@ -508,6 +539,9 @@ static struct i2c_driver mcp16502_drv =3D {
 	.driver		=3D {
 		.name	=3D "mcp16502-regulator",
 		.of_match_table	=3D of_match_ptr(mcp16502_ids),
+#ifdef CONFIG_PM
+		.pm =3D &mcp16502_pm_ops,
+#endif
 	},
 	.id_table	=3D mcp16502_i2c_id,
 };
--=20
2.7.4

