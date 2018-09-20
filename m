Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECDFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D1F21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M6kl0t86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D1F21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbeITI3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:41 -0400
Received: from mail-dm3nam03on0091.outbound.protection.outlook.com ([104.47.41.91]:20832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388098AbeITI3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4VYDs9ZiWIATMJIFZnTR9gsBbBwRoZyWiDfMf/L+7I=;
 b=M6kl0t86ma/RDOgd6g82UCG527U/ZU21NyGo4xc/125X+/28MmyHB3ngPndn59+ZVEe9NLG+kc2Vs5lh7NOjb4496FtZoTmejxcVBvtYFAGQPgCTvDBJPlQrkPokI00XAeY68eHohydnX/xOUuBzRmzqHovcUIDgM1crMbFcly0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lothar Felten <lothar.felten@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 43/56] hwmon: (ina2xx) fix sysfs shunt resistor
 read access
Thread-Topic: [PATCH AUTOSEL 4.18 43/56] hwmon: (ina2xx) fix sysfs shunt
 resistor read access
Thread-Index: AQHUUIxW+NbnNu21PkWe37qfM2cmDA==
Date:   Thu, 20 Sep 2018 02:47:57 +0000
Message-ID: <20180920024716.58490-43-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:oiNSbjfVELaycoS2fGr80g2m7vbnGopXf8jqfWfg68mjzBGFRCM5eYyjt6O9qVw6fmI9X0N4QhOYsGs1nh6+Y5PsqpVhCpte3Adaau+pSiPXuwaKEIj7G24QDFxvRr5XD1gmXgbidxScsyMv9+9qL+Xd92E9Ka4PVVBKS6ZFSkkpDrSSssd985PVM4cvCZyTuT+CEP1iYYhxuX427owzknoSKIkIg9Ch+uJeek0ZrUVfr4AaHhqnL2V59p3QMekG0BkrTrOzrU5oo70sYfzvdRCkN/YQ2d9/W72OuRSdkJXMMO3wOamDCj437Qi6SUVgEXKdmVkPCy1x5YIo7AvMtO8Od0i0VeRu/cwOtVAUkeZvZSguruCrwy8XOBGzQbwym2XvRctNf0C78IJEvSaOV2PjwoThg0JEmiThNahXTpdvMwFKg6O59qL/sfOrp9dHmTgkonnObL5VlLSeGMNh3w==;5:2Ifb5Ux2+oAzpcVCisJW/qcXy+mjiU5ABn4L6Yi+QMzjr2dETX5P1U1IX3VtxTdiUw8DhcJHeU0213tnhfhzzgG8B1Y/lNFu4DwhyEDAEkXhwpLahkwhLiDuqDM/dyCTeGmXA8NlXeQrJqSEIy4nDSI++GW0P3i3Gc9vh5EeDX8=;7:C1ZBus2ntjGY8/HGRbMhB/+3E51jCjjHK3mvZ/UcQsvvvG7xne24c6fc1gRWF+NeI9rmEL/7tRj4bjAmo5RYUN0aIMb0jJi/IYty1q+BSlE0S2/5hlsHFK5laZmnd65ol7ZJdU7P9+D2St3rBAOLOEi6a4kWL6XGO40o73MxAA+Lv/FQkkQu38dqy2XhioEB6U4hVpSmEkD2l4SD7/YBGf58DBuO6tMVyqyhbIXmRElWw1dfkbCc8vwMuDVoAAZ5
x-ms-office365-filtering-correlation-id: cc36c0e2-9041-4781-8971-08d61ea389ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB01654B9C1E7EACB627C9A152FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(106291317490208)(31051911155226)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(966005)(72206003)(97736004)(6306002)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(575784001)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(39060400002)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(1720100001)(6346003)(25786009)(4326008)(26005)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 26mdwhJEsAPJAwdmBVsU6dU5gEM9QC3KNUIIH8mzVZ2QECGoycbByE6az2YhXIFBrDoCyt+2RWPScBvhZPlzy9QfyLF1reeYAYj2+mNYeSeo1afMW5K+8GG5EfmrQ7b38eY52JoPiieNC6taPBadFD74peAz+PoccMZJ0o3KuwTU9Y2zVCiTiyqcDXguvlN3dckrGnpYiPyvoJOYo6wIu2mWoOxAFxvVKoR+flA6A9dIEp2sa+OAbvNmSuGAExO9lL+D4kcLS/0eUHButAMCduCiRbvtTPZRk4lakO56TXcIXX4uk27O/V8M7zTfAkRMge42fxWSripNMn4dPlMSsN88LH92hQo5HfUc634UMzk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc36c0e2-9041-4781-8971-08d61ea389ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:57.1636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index 72d16f08e431..b8df81f6d6bc 100644
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
index e9e6aeabbf84..71d3445ba869 100644
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
@@ -329,6 +329,15 @@ static int ina2xx_set_shunt(struct ina2xx_data *data, =
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
@@ -403,7 +412,7 @@ static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx=
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
