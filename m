Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B11CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D5C214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="pyMz+JIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D5C214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbeKVCja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:39:30 -0500
Received: from mail-eopbgr60116.outbound.protection.outlook.com ([40.107.6.116]:6167
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730072AbeKVCja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mx65iwArHjHF4esXtppNzt4GYWb/7x4VD0ES3d2PrA=;
 b=pyMz+JIjI/P70elfgcdPmWuc1jCARhPQbcid+nuKiz3ra9Xcbs5piGUeoRUABWL4sjCyova2ViNsAd4UNI8u53HeWHR/WPiqUUbz+1xPJt5afp0lxO0+n/426G9lLA+V/+wd5r3xKJzoyEp6HNK8lhJkJBXKM9Dx3vHBGdQU05E=
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com (10.169.244.8) by
 AM5PR0201MB2275.eurprd02.prod.outlook.com (10.169.242.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 16:03:46 +0000
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::7d9b:e9c1:14e6:b72a]) by AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::7d9b:e9c1:14e6:b72a%3]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 16:03:46 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: (ntc_thermistor) use a table to lookup the
 thermistor type
Thread-Topic: [PATCH 2/2] hwmon: (ntc_thermistor) use a table to lookup the
 thermistor type
Thread-Index: AQHUgbPImXAkheNCakiay8+1i/ECrg==
Date:   Wed, 21 Nov 2018 16:03:46 +0000
Message-ID: <20181121160327.16772-3-peda@axentia.se>
References: <b732b7e0-0076-9cb3-a146-4d0cd80d2658@roeck-us.net>
 <20181121160327.16772-1-peda@axentia.se>
In-Reply-To: <20181121160327.16772-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0402CA0042.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::31) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0201MB2275;6:FzDazX3YdXXw2tvScyf+pUG3dIDM6Ldxz9Te0OCvxsa+qVEdfI8FVeI4qXBC3oaMb0QscDoKaOD9Lr7v4rUmS3ZI4cwVPWBxQXeFyMVirbvz17QgRMRn1Teea6El8ViOmzK620cNFH8TgBqy/Me4FftKs0JBdpG1P6654gg1eytCoxKXRDXcfxphZNPmRfxingj4YD9fJsFLquA1a4GRQ8pVJ4OOIe8nbnvR0a/Knyj982sLy3HtMydgNR1AKKNJKkNHbgykHW4SC/aiOJS9UtH/DL5WjycUhG3gwxKV2vOvT4qWzwNSrZJiq6OgX1Sgd2QN6M3jKP2ttBu4IgXZFEOjB3PfP50Kv51PfNve1JSxCBzSvq/JoZOKYWF0LQLqkM6jZEsopKB1iTW7RgiSN5SfwBILtKzH6l7t0rD++n8VeVG/6VX5DcwF01yanoX58rcX0He/qCn/5ggVXFzXZQ==;5:8uO8ZcZj4HBv8KfkKvAOGDcm1CGVQfNjdhq9PO4Jv/rOqnrUQbQM6dCBTz5PEGGJAlkaEEqUT7iCFKgZL7rROzl5zFhZhyZhfzx7vW4xJ56zfb6IQVeoqnmsc45AfHGmQ7GaH2VswsFG9iMKud8OJ/biUwi/6eJJD8R+5yXGJhA=;7:eJAyi3apbfa6flhTs2OwbfFKZE86XQKrIdy1B9nltFEJ/prfj549NKnKBmeHpLMJnlmZ7WoIoz0qLi4lGXGSA6dXIhZrfzdMy/OViNudiYLeS2zb9N3AxQQpgVIdMf9C6cyl2B8W+ASpSrxX6k9lhw==
x-ms-office365-filtering-correlation-id: 832967cd-ff34-4227-0451-08d64fcaeab3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2275;
x-ms-traffictypediagnostic: AM5PR0201MB2275:
x-microsoft-antispam-prvs: <AM5PR0201MB227535DB4D0AD07F06EBC0CBBCDA0@AM5PR0201MB2275.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM5PR0201MB2275;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2275;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(396003)(366004)(376002)(136003)(189003)(199004)(99286004)(14454004)(52116002)(76176011)(8676002)(81156014)(2900100001)(5640700003)(2501003)(81166006)(68736007)(53936002)(2351001)(106356001)(86362001)(11346002)(2616005)(476003)(256004)(6512007)(4326008)(316002)(6916009)(6486002)(1076002)(508600001)(3846002)(6116002)(74482002)(71200400001)(54906003)(50226002)(66066001)(71190400001)(2906002)(305945005)(36756003)(102836004)(6506007)(7736002)(97736004)(446003)(486006)(8936002)(6436002)(105586002)(25786009)(386003)(26005)(186003)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2275;H:AM5PR0201MB2451.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EePWVtvrEmaw9KD0rRIZxLotK6RsRPSFHmcAqRB8Q6/hQSHQRKOVyBXW7h8Wfr89PKfIadlA/tQuGFubkcEcYhqAPGGhKsiRsqVCSpBcl4OvCSTTFPVxS5w1PrPYnu92sRAEIRacS6J6BxQH1ZX2oc0F4hm2Tqz4dBvdQpGM0fb3SsCsJxHpi2sS1L0tOhqk+92SZVoe8I23McJOTvIAqPgUpzd+umzAcXwyNTu4WOej2A4s+aHo/d+cV2venAUAWg6QjcrgWbWtL6R7vIi2qqfa9S/oqrzgzF44QTzNsxBI5tTx4c3zqaq+PVK84F1zvdS8q6/AEa/cqUasEkamJZr2iTradxi37IIdJoKN9YY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 832967cd-ff34-4227-0451-08d64fcaeab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 16:03:46.2675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the entries while at it.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/hwmon/ntc_thermistor.c               | 47 +++++++++++++-----------=
----
 include/linux/platform_data/ntc_thermistor.h |  6 ++--
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.=
c
index 7747c1ed1f02..56d83b2472c8 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -315,6 +315,23 @@ static const struct ntc_compensation b57891s0103[] =3D=
 {
 	{ .temp_c	=3D 155.0, .ohm	=3D 168 },
 };
=20
+struct ntc_type {
+	const struct ntc_compensation *comp;
+	int n_comp;
+};
+
+#define NTC_TYPE(ntc, compensation) \
+[(ntc)] =3D { .comp =3D (compensation), .n_comp =3D ARRAY_SIZE(compensatio=
n) }
+
+static const struct ntc_type ntc_type[] =3D {
+	NTC_TYPE(TYPE_B57330V2103, b57330v2103),
+	NTC_TYPE(TYPE_B57891S0103, b57891s0103),
+	NTC_TYPE(TYPE_NCPXXWB473,  ncpXXwb473),
+	NTC_TYPE(TYPE_NCPXXWF104,  ncpXXwf104),
+	NTC_TYPE(TYPE_NCPXXWL333,  ncpXXwl333),
+	NTC_TYPE(TYPE_NCPXXXH103,  ncpXXxh103),
+};
+
 struct ntc_data {
 	struct ntc_thermistor_platform_data *pdata;
 	const struct ntc_compensation *comp;
@@ -671,37 +688,15 @@ static int ntc_thermistor_probe(struct platform_devic=
e *pdev)
=20
 	data->pdata =3D pdata;
=20
-	switch (pdev_id->driver_data) {
-	case TYPE_NCPXXWB473:
-		data->comp =3D ncpXXwb473;
-		data->n_comp =3D ARRAY_SIZE(ncpXXwb473);
-		break;
-	case TYPE_NCPXXWL333:
-		data->comp =3D ncpXXwl333;
-		data->n_comp =3D ARRAY_SIZE(ncpXXwl333);
-		break;
-	case TYPE_B57330V2103:
-		data->comp =3D b57330v2103;
-		data->n_comp =3D ARRAY_SIZE(b57330v2103);
-		break;
-	case TYPE_NCPXXWF104:
-		data->comp =3D ncpXXwf104;
-		data->n_comp =3D ARRAY_SIZE(ncpXXwf104);
-		break;
-	case TYPE_NCPXXXH103:
-		data->comp =3D ncpXXxh103;
-		data->n_comp =3D ARRAY_SIZE(ncpXXxh103);
-		break;
-	case TYPE_B57891S0103:
-		data->comp =3D b57891s0103;
-		data->n_comp =3D ARRAY_SIZE(b57891s0103);
-		break;
-	default:
+	if (pdev_id->driver_data >=3D ARRAY_SIZE(ntc_type)) {
 		dev_err(dev, "Unknown device type: %lu(%s)\n",
 				pdev_id->driver_data, pdev_id->name);
 		return -EINVAL;
 	}
=20
+	data->comp   =3D ntc_type[pdev_id->driver_data].comp;
+	data->n_comp =3D ntc_type[pdev_id->driver_data].n_comp;
+
 	hwmon_dev =3D devm_hwmon_device_register_with_groups(dev, pdev_id->name,
 							   data, ntc_groups);
 	if (IS_ERR(hwmon_dev)) {
diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/linux/p=
latform_data/ntc_thermistor.h
index 231a27c302ec..ee03d429742b 100644
--- a/include/linux/platform_data/ntc_thermistor.h
+++ b/include/linux/platform_data/ntc_thermistor.h
@@ -24,12 +24,12 @@
 struct iio_channel;
=20
 enum ntc_thermistor_type {
-	TYPE_NCPXXWB473,
-	TYPE_NCPXXWL333,
 	TYPE_B57330V2103,
+	TYPE_B57891S0103,
+	TYPE_NCPXXWB473,
 	TYPE_NCPXXWF104,
+	TYPE_NCPXXWL333,
 	TYPE_NCPXXXH103,
-	TYPE_B57891S0103,
 };
=20
 struct ntc_thermistor_platform_data {
--=20
2.11.0

