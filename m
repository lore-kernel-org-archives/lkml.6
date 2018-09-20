Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61831ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED2B21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="U6lfOvoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED2B21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbeITIgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:36:08 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388199AbeITIaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdgW8mPcWYzvHn8je3SOEv+EW6y+BBfyWMRscM5yubs=;
 b=U6lfOvoUlZjLXMvC5Dhyc0cEjJaywN1C3DCFe8efHlF7+Y6HtcGKRUkNAyeyCtWlf3g34XX7EphFBDF7PC6ZITIyW4jXBIDrKsXNf+6qHy/cge1RhG1OJdzr5subpi5mi4fvOFRyPNULMm5CligKrJpH35i1SyQubf5nFtVSMsg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lothar Felten <lothar.felten@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 14/25] hwmon: (ina2xx) fix sysfs shunt resistor
 read access
Thread-Topic: [PATCH AUTOSEL 4.14 14/25] hwmon: (ina2xx) fix sysfs shunt
 resistor read access
Thread-Index: AQHUUIxmwWpIo6M3ckKrHZQDC6Ks8A==
Date:   Thu, 20 Sep 2018 02:48:25 +0000
Message-ID: <20180920024810.58594-14-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:B7YefI1Q3idqLLKfYohugZg4PT2UqA4u7+a8SgvBGBQaQpNbRIQ3QhyQAHgVYmEcNDtbplKyuWpz9I+gKBEnmvO3RmvwxtY0xOPHC6kL+qwA5NMJrxLEjxdGMWgx1+lyXwVqoUExcypW2ORX769cZuOXzrHoExKnQ4dETZnzhJMR6unxGiwT9MrlyHTqDA46K4pmyaeEegBJenFsUuLGp0otUijc1tOm5L5JQfHtWdANpajOf/hqfuwoyNKsJpixtCmmIKOq3RfL2YTLhcLK+Bz++YWAO0KFVPz8bgMyYwLA3rRNJngNJ0fNtuWRsRoy50DebpnHwfkBpwvA5ZFAw/VFBZ6L6j+qTWVK6+BcGDRcR85S5C2EfCWqrkVzm/1+1xB+p3888t3RldezrabKTEQHbMyH/QWTXtAFTnSlHFkm0WfsS8+0ZqjnkJuVL/H8sof1K8S0BtS+T/qPbESMBw==;5:+W+m3M4PJNXyTZNpUw5Y3AI3F0URS2sZwiffB4FZdNo2nnbwgESd+zhuUNPhHI0SDxOEdYKvueWb6uLjoxVby4pnRbscqO58wswqmMEiUD9DC4vwEr2y/irMWTAs2QNrxPY/7iRjOfpjnbxJIrV9e8PodhSqj5YEE0HU99MvQcM=;7:c3IQi0dd3i6EfghISmCAytaFxC37nAqerlSHvWG+Irj6Frhx052y/aTUnp/Shh8xYopSfQYn9ps+DWmM471k9qUCJxTHt6nUnwq/Le1HAKkc32iFWTDPWQdZkPiD23RbCLoMh+Yzb1QKG04u5nC6kJ4G49y07dtFf8hijsdb3HLR222y9XfBhSbFrRPhaJ8VXmVN8pXyuyaZXI46wTKuEQuEGwzdn4yHjLSkIvA64D+1vWG7dD4q5OQMdyhnCMiH
x-ms-office365-filtering-correlation-id: f8105d77-afd7-4df6-2e3e-08d61ea3a6ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07441D0B1B6BC29756C693FDFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(106291317490208)(31051911155226)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(6306002)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(39060400002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(966005)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(575784001)(81156014)(26005)(76176011)(6506007)(5250100002)(1720100001)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RAwkgylXdza3OYF7sp/Zx5eh3hJuUzN1Yj/EfXBxZcGgvyKrjjwmBVhGy6r4Vxo12/+Mb1K0rmq1yzXHrnVzbFPkSokM1ah7nEaJYWsAVurq02o2RVZwnVrUadh3z2KgZnzOyqby9zdm+NF5Dbk5ReokjLL9mgSwgo1RDEhBn/O6yW1/q6+zKfvGrR6lGzeCku5IL5Bt8I4xdnVX3m7D1l9peoDeGm/+OTnHqbs9NcP37sAL86Mq7G/t8nqpFOd/N8NmOWKmP5woXgT9Q2nCWBxdOQTGouDAA/EQ1rvJE1Nr7Vq25Wot1OIugQm6ksjMpSF8Q8h/2zEGVQXy++9skC5g22Vx/BMNBbnYul9B4vg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8105d77-afd7-4df6-2e3e-08d61ea3a6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:25.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
