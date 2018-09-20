Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC70ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C49321522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ge5ha6cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C49321522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbeITIaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:30 -0400
Received: from mail-eopbgr710099.outbound.protection.outlook.com ([40.107.71.99]:10496
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388316AbeITIa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfTVsLS23jqnyvsz4IAJ9PgtZMs/nhKECPf1dyR2BRM=;
 b=Ge5ha6cOx/2cnTIcenplqdKVYmz1n3RifIp23ECPZv72ltOE/GgugrPAeN9vtnJkXC6W3txu+CWTf1/fn/KR/pI9vcNTPhmSqkzIfvFgnJWuE3jJFIzOPuElh63inHHmN9P3OxLKYBnZsqDORJeU3sAtG3xtRHIAvc+SclZR8ag=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Thu, 20 Sep 2018 02:49:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lothar Felten <lothar.felten@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 08/14] hwmon: (ina2xx) fix sysfs shunt resistor
 read access
Thread-Topic: [PATCH AUTOSEL 4.9 08/14] hwmon: (ina2xx) fix sysfs shunt
 resistor read access
Thread-Index: AQHUUIx03va+Xt6IvkOf03BH8wg5Qw==
Date:   Thu, 20 Sep 2018 02:48:47 +0000
Message-ID: <20180920024838.58666-8-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:qGhiJZM8+bXvy+90YrEn1D5yQbgbxoCcWCYxm9gfAcq1uoKhlqyEpKLumWuAeBB8RIYgkrxQ3GLlWIwvjoyKLLaJ0UzO88ns7lHklBOTBXjFY6vnCKiZzHEEsr6vtxYI0KZdLS4dMm/1YNvLsuZhcz9/vtCZemwaElWaif/Fs9ce06g1dqtOiHetU/71r4Hysw46dmr9Jf2SZaKsg/usXEl0DCsWdyWhLEPJxcTzbviTd4dmdozM0kqDtFQi0uCIq8u8L+W1mWzv7ZZ+3ZR62QwW8AtbeBaLDlxvH9jDtGdXDdxGo1qlpN356xupXwA3tuhDpj+tkRI4fpLEng/yqX5/XizDJ89WlAtZfrssVRshs+jQIotZ0gKlW263h2boopVw8Cb05SMgyoufarLMmYgB5TnM60EySf/AYUOe0Eziu/2qTGrkdLxxozDnA4jRbG+uGocmaxgQNUDFihpTHQ==;5:1bBQlRjDFotloGlbTa4rW7fqaCSJKK3KkBrBsLdsoaAGg7PAbxwVBMsalXVLP4iXR86UeKt6SpUkvVNP1XeI5Z8rjMNKcaTe9JUo7LgTtVxIvpYgceTTmWoMDigZHPPvAOODwdZqW57u482Sd3P9ePPPM44I0jy8SnBe6/n2LrY=;7:JkZEAx2hVsAQDv35E5u4eIQGrX3p4XzpQmT4fFhAMDXVPU9Vy8Kn2nGfeAXvfiGwOd7O6KZKuPQYdj+ZSyBq7V4r4pJyFGzx4y1CGRitsVAECZhQtmzTOw88oLKzjuEGWI4FmA4EDsj6nFefLatFhFae2DdNNelKFYKp12KIxD7iQ+/uB3JP0pOvZ0BVQWOORwmXY8OuDo283p9gejNsosighfPsCn1k5FNNm/fOBK0dn6oPeq48/pZlIsn7w+7n
x-ms-office365-filtering-correlation-id: 272ecc52-d6b3-45c7-5ec5-08d61ea3ac74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB0469241A2BAE98F587C99351FB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(106291317490208)(31051911155226)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(1720100001)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(6306002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(76176011)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(11346002)(6486002)(6436002)(446003)(6346003)(81156014)(26005)(102836004)(86362001)(966005)(54906003)(575784001)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(39060400002)(316002)(10090500001)(107886003)(14444005)(1076002)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: RGcLQeXoi6zs72bPiDW4gzYM3rpZ6PYvhhgT9rELs/pRdsB1aQSGPBxhdD4jwGpNe1QDtEbw58e0Udujx7YcxqMQ6mdvPkD6Zee8WWP6EK49XBY71uppi68rR4MlIcwIRV+jOw0wgIZJibTHe0o3Ozy6ELF1y4XIXWK2nasu565IR3RcZid3EF7JESfMgZRxtQ+GKo9wg/I96RW7EoDcJXi9WsUnv/sKSCAAy6i3HELhZ72MjLocEgLD2+PkIuaMH0wDJyfbVFP1WcBbM6W6XR3wNv3tEDeNPbK5E50ORrfxtrhvc7vPBXzTOam6tTE3GI56Vb7Y5GmR08K1yRU5hY6825q7ZjY7bUjqU71bKNM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272ecc52-d6b3-45c7-5ec5-08d61ea3ac74
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:47.3974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lothar Felten <lothar.felten@gmail.com>

[ Upstream commit 3ad867001c91657c46dcf6656d52eb6080286fd5 ]

fix the sysfs shunt resistor read access: return the shunt resistor
value, not the calibration register contents.

update email address

Signed-off-by: Lothar Felten <lothar.felten@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Documentation/hwmon/ina2xx           |  2 +-
 drivers/hwmon/ina2xx.c               | 13 +++++++++++--
 include/linux/platform_data/ina2xx.h |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
index cfd31d94c872..f8bf14055c2f 100644
--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -32,7 +32,7 @@ Supported chips:
     Datasheet: Publicly available at the Texas Instruments website
                http://www.ti.com/
=20
-Author: Lothar Felten <l-felten@ti.com>
+Author: Lothar Felten <lothar.felten@gmail.com>
=20
 Description
 -----------
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index ac63e562071f..9ac6e1673375 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -17,7 +17,7 @@
  * Bi-directional Current/Power Monitor with I2C Interface
  * Datasheet: http://www.ti.com/product/ina230
  *
- * Copyright (C) 2012 Lothar Felten <l-felten@ti.com>
+ * Copyright (C) 2012 Lothar Felten <lothar.felten@gmail.com>
  * Thanks to Jan Volkering
  *
  * This program is free software; you can redistribute it and/or modify
@@ -328,6 +328,15 @@ static int ina2xx_set_shunt(struct ina2xx_data *data, =
long val)
 	return 0;
 }
=20
+static ssize_t ina2xx_show_shunt(struct device *dev,
+			      struct device_attribute *da,
+			      char *buf)
+{
+	struct ina2xx_data *data =3D dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%li\n", data->rshunt);
+}
+
 static ssize_t ina2xx_store_shunt(struct device *dev,
 				  struct device_attribute *da,
 				  const char *buf, size_t count)
@@ -402,7 +411,7 @@ static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx=
_show_value, NULL,
=20
 /* shunt resistance */
 static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
-			  ina2xx_show_value, ina2xx_store_shunt,
+			  ina2xx_show_shunt, ina2xx_store_shunt,
 			  INA2XX_CALIBRATION);
=20
 /* update interval (ina226 only) */
diff --git a/include/linux/platform_data/ina2xx.h b/include/linux/platform_=
data/ina2xx.h
index 9abc0ca7259b..9f0aa1b48c78 100644
--- a/include/linux/platform_data/ina2xx.h
+++ b/include/linux/platform_data/ina2xx.h
@@ -1,7 +1,7 @@
 /*
  * Driver for Texas Instruments INA219, INA226 power monitor chips
  *
- * Copyright (C) 2012 Lothar Felten <l-felten@ti.com>
+ * Copyright (C) 2012 Lothar Felten <lothar.felten@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
--=20
2.17.1
