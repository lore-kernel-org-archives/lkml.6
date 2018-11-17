Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5962AC04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2089A2082A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Ul4zFqvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2089A2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeKQW3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 17:29:35 -0500
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:30640
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbeKQW3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 17:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIZW3NZeg7Jg7n2w5PFd1g7Bhoq/EgQWMT7zJnKH7ls=;
 b=Ul4zFqvv7amLjddJlIvmwwv0xlBY4VAeVS6vcLUv/THx6c/e29tpScJG60I1lLQ8epI4/TrOA7zilcePrqkYaM3q+ZTJfSAjUtp11LJ4MSytgb1DVhJ28kUhLaL8TjQWYB2NkDkOE6yXbCRM0uz/jDZO7RyC4fNoN4G+8yexwUQ=
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com (10.169.244.8) by
 AM5PR0201MB2355.eurprd02.prod.outlook.com (10.169.243.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Sat, 17 Nov 2018 12:13:00 +0000
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::7d9b:e9c1:14e6:b72a]) by AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::7d9b:e9c1:14e6:b72a%3]) with mapi id 15.20.1294.045; Sat, 17 Nov 2018
 12:13:00 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: (ntc_thermistor): add support for B57891S0103 from
 Epcos
Thread-Topic: [PATCH 2/2] hwmon: (ntc_thermistor): add support for B57891S0103
 from Epcos
Thread-Index: AQHUfm7h4Hg8oMasp0Wh5BsbVRWt0w==
Date:   Sat, 17 Nov 2018 12:13:00 +0000
Message-ID: <20181117121248.32143-2-peda@axentia.se>
References: <20181117121248.32143-1-peda@axentia.se>
In-Reply-To: <20181117121248.32143-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0211.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::11) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0201MB2355;6:Jh/05xpY7tprEUg5essWMYktOlHNYKcei3fN4vzgn+gzyuiFOkCwQ1jbdKhG+akWutz5GJafkeW6SieJ0NLtEy9D01vE2+gunN2ZtY3CLSKIHtF7jP0w2X7UdOVX4r79ElP2Zce+nLlxJzqKL920UgR8qDq98CT6Az8cMtnz+WmeyHELzyQjqFAu9Z4Vuw/jymy8tdMRE2E9svcsLErXBfK5rrhE4lQ5lEe/Wr+A0U+yUg2hYr16vuOmupoYQBze21w9bYnZVLyFcVk1+k3PgAdCk+dqFe94mWoDWISQxVTkICnD8Agr9MyEda0/XF+RieJeNtTGWJQU7EWgvpE58kfp3tFD70Baz5T/GcWtHZIDehJ3eMpmwW2ad9zwN/z9j4HcOzsc/RVsxIf59r/Kpp+o+gDDQO8GKxZvWkX6bbUmH4DzWSdrUGHjcbiJ+f2bQwu35+71V5MwNC3dKk/2BQ==;5:OM/TdNQUQdYVXGTe1omGemhbQZbB67auD9ukG1nwNJ+1kqoO3vqrTdxqjQJBSu6i9pO6AAPkRNQYhvo8Uk/ihWx/4pG6WEIqu0q4hlgsBOqkYbqC/fLul2emt0O5ji2us9oHpF9x7u9BBP3ogCp5+ONa3kB35649cS6d+f0hOpQ=;7:kw3RwL4WGa2Q6L7+ag4OvgzfCmPKDzSzzz7If00I+qKVcKS+JmiUflEL/gCNUNK8X9CRWRhzpJk1QXFo1QVp4Wp63QUBUEtvB/PsIXO8e1enFLDfcPcJ4t8/RUdTAHBeKfm4FSeNx6B9KBvDhBlqYw==
x-ms-office365-filtering-correlation-id: 7703dcb0-4bec-4d29-e70e-08d64c860440
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2355;
x-ms-traffictypediagnostic: AM5PR0201MB2355:
x-microsoft-antispam-prvs: <AM5PR0201MB2355002D102F17B106FE01F4BCDE0@AM5PR0201MB2355.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM5PR0201MB2355;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2355;
x-forefront-prvs: 085956473E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(39830400003)(346002)(199004)(189003)(97736004)(8936002)(508600001)(99286004)(76176011)(52116002)(81156014)(81166006)(256004)(105586002)(8676002)(7736002)(476003)(106356001)(86362001)(575784001)(102836004)(486006)(2616005)(6116002)(14454004)(446003)(11346002)(305945005)(50226002)(6506007)(3846002)(386003)(36756003)(2351001)(2900100001)(1076002)(6916009)(74482002)(5640700003)(2501003)(54906003)(25786009)(26005)(316002)(6512007)(66066001)(186003)(6436002)(68736007)(5660300001)(4326008)(2906002)(6486002)(71190400001)(71200400001)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2355;H:AM5PR0201MB2451.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aGVRhgz54KZY63wTMGESMdjDLtpluIOzwXm7QWO84ip6aSAKhKukPnxHSVzNrZougX6O6TN6oXuuFgrViz9VaBps/IPxePMqqkFIISFJe++oVsykGEOjqXc4TAkzvPeiR0mc2r9vmIwF7KnMHTcU3Kwxh7tFfkzocZKak+tJNiG1vdmGWlnzVx9lVagnaRnuWCOIoXC2m+K+nHFrLu8BETSeUSG3vFwvodXLxrxzslq/jUGgfHqKooPB6sxo/hpfw4c7eXk+zIElZK6+R4bvWy4Ekt1WAikADy5pTwmncxYyoJ+qFZCKeHaNV4t33I8c56/asesEpz3mhKtNAfiCsb2byriq4Wz93/34Cteq1bE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7703dcb0-4bec-4d29-e70e-08d64c860440
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2018 12:13:00.3877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2355
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More of the same...

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/hwmon/Kconfig                        |  3 +-
 drivers/hwmon/ntc_thermistor.c               | 57 ++++++++++++++++++++++++=
+++-
 include/linux/platform_data/ntc_thermistor.h |  1 +
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index f10840ad465c..5438cecace22 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1206,7 +1206,8 @@ config SENSORS_NTC_THERMISTOR
=20
 	  Currently, this driver supports
 	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, NCP15WL333,
-	  NCP03WF104 and NCP15XH103 from Murata and B57330V2103 from EPCOS.
+	  NCP03WF104 and NCP15XH103 from Murata and B57330V2103 and
+	  B57891S0103 from EPCOS.
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called ntc-thermistor.
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.=
c
index c52d07c6b49f..e0c6b2f244a6 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -55,6 +55,7 @@ static const struct platform_device_id ntc_thermistor_id[=
] =3D {
 	{ "b57330v2103", TYPE_B57330V2103},
 	{ "ncp03wf104", TYPE_NCPXXWF104 },
 	{ "ncp15xh103", TYPE_NCPXXXH103 },
+	{ "b57891s0103", TYPE_B57891S0103 },
 	{ },
 };
=20
@@ -212,8 +213,8 @@ static const struct ntc_compensation ncpXXxh103[] =3D {
 };
=20
 /*
- * The following compensation table is from the specification of EPCOS NTC
- * Thermistors Datasheet
+ * The following compensation tables are from the specifications in EPCOS =
NTC
+ * Thermistors Datasheets
  */
 static const struct ntc_compensation b57330v2103[] =3D {
 	{ .temp_c	=3D -40, .ohm	=3D 190030 },
@@ -252,6 +253,52 @@ static const struct ntc_compensation b57330v2103[] =3D=
 {
 	{ .temp_c	=3D 125, .ohm	=3D 531 },
 };
=20
+static const struct ntc_compensation b57891s0103[] =3D {
+	{ .temp_c	=3D -55.0, .ohm	=3D 878900 },
+	{ .temp_c	=3D -50.0, .ohm	=3D 617590 },
+	{ .temp_c	=3D -45.0, .ohm	=3D 439340 },
+	{ .temp_c	=3D -40.0, .ohm	=3D 316180 },
+	{ .temp_c	=3D -35.0, .ohm	=3D 230060 },
+	{ .temp_c	=3D -30.0, .ohm	=3D 169150 },
+	{ .temp_c	=3D -25.0, .ohm	=3D 125550 },
+	{ .temp_c	=3D -20.0, .ohm	=3D 94143 },
+	{ .temp_c	=3D -15.0, .ohm	=3D 71172 },
+	{ .temp_c	=3D -10.0, .ohm	=3D 54308 },
+	{ .temp_c	=3D -5.0, .ohm	=3D 41505 },
+	{ .temp_c	=3D 0.0, .ohm	=3D 32014 },
+	{ .temp_c	=3D 5.0, .ohm	=3D 25011 },
+	{ .temp_c	=3D 10.0, .ohm	=3D 19691 },
+	{ .temp_c	=3D 15.0, .ohm	=3D 15618 },
+	{ .temp_c	=3D 20.0, .ohm	=3D 12474 },
+	{ .temp_c	=3D 25.0, .ohm	=3D 10000 },
+	{ .temp_c	=3D 30.0, .ohm	=3D 8080 },
+	{ .temp_c	=3D 35.0, .ohm	=3D 6569 },
+	{ .temp_c	=3D 40.0, .ohm	=3D 5372 },
+	{ .temp_c	=3D 45.0, .ohm	=3D 4424 },
+	{ .temp_c	=3D 50.0, .ohm	=3D 3661 },
+	{ .temp_c	=3D 55.0, .ohm	=3D 3039 },
+	{ .temp_c	=3D 60.0, .ohm	=3D 2536 },
+	{ .temp_c	=3D 65.0, .ohm	=3D 2128 },
+	{ .temp_c	=3D 70.0, .ohm	=3D 1794 },
+	{ .temp_c	=3D 75.0, .ohm	=3D 1518 },
+	{ .temp_c	=3D 80.0, .ohm	=3D 1290 },
+	{ .temp_c	=3D 85.0, .ohm	=3D 1100 },
+	{ .temp_c	=3D 90.0, .ohm	=3D 942 },
+	{ .temp_c	=3D 95.0, .ohm	=3D 809 },
+	{ .temp_c	=3D 100.0, .ohm	=3D 697 },
+	{ .temp_c	=3D 105.0, .ohm	=3D 604 },
+	{ .temp_c	=3D 110.0, .ohm	=3D 525 },
+	{ .temp_c	=3D 115.0, .ohm	=3D 457 },
+	{ .temp_c	=3D 120.0, .ohm	=3D 400 },
+	{ .temp_c	=3D 125.0, .ohm	=3D 351 },
+	{ .temp_c	=3D 130.0, .ohm	=3D 308 },
+	{ .temp_c	=3D 135.0, .ohm	=3D 272 },
+	{ .temp_c	=3D 140.0, .ohm	=3D 240 },
+	{ .temp_c	=3D 145.0, .ohm	=3D 213 },
+	{ .temp_c	=3D 150.0, .ohm	=3D 189 },
+	{ .temp_c	=3D 155.0, .ohm	=3D 168 },
+};
+
 struct ntc_data {
 	struct ntc_thermistor_platform_data *pdata;
 	const struct ntc_compensation *comp;
@@ -296,6 +343,8 @@ static const struct of_device_id ntc_match[] =3D {
 		.data =3D &ntc_thermistor_id[6] },
 	{ .compatible =3D "murata,ncp15xh103",
 		.data =3D &ntc_thermistor_id[7] },
+	{ .compatible =3D "epcos,b57891s0103",
+		.data =3D &ntc_thermistor_id[8] },
=20
 	/* Usage of vendor name "ntc" is deprecated */
 	{ .compatible =3D "ntc,ncp15wb473",
@@ -627,6 +676,10 @@ static int ntc_thermistor_probe(struct platform_device=
 *pdev)
 		data->comp =3D ncpXXxh103;
 		data->n_comp =3D ARRAY_SIZE(ncpXXxh103);
 		break;
+	case TYPE_B57891S0103:
+		data->comp =3D b57891s0103;
+		data->n_comp =3D ARRAY_SIZE(b57891s0103);
+		break;
 	default:
 		dev_err(dev, "Unknown device type: %lu(%s)\n",
 				pdev_id->driver_data, pdev_id->name);
diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/linux/p=
latform_data/ntc_thermistor.h
index 698d0d59db76..231a27c302ec 100644
--- a/include/linux/platform_data/ntc_thermistor.h
+++ b/include/linux/platform_data/ntc_thermistor.h
@@ -29,6 +29,7 @@ enum ntc_thermistor_type {
 	TYPE_B57330V2103,
 	TYPE_NCPXXWF104,
 	TYPE_NCPXXXH103,
+	TYPE_B57891S0103,
 };
=20
 struct ntc_thermistor_platform_data {
--=20
2.11.0

