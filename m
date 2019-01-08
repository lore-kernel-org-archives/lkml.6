Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4FBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D608020827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="zTzH9c4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfAHJxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:53:02 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:1503 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfAHJxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:53:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="25223860"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jan 2019 02:52:59 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 8 Jan 2019 02:52:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjbrXEvd0zPH7JipVlT1O9m5uxmU2/hsg98FIsTY8p0=;
 b=zTzH9c4eTDmAfhc5e1HZ5bZjDZNmw63WkzC6LTl4pxUSMzFE4V/oi5cdmIz9IaEJEtUXvDCu08YjVu9RGihVg6mVyqtLt0jS+nDitYoH8DUprxNh+azWW5CEKIDr2ju3E/3hCBSAAx3PVGaxAN62vW6XOKT0tTZlVz/tYcvAsdM=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1838.namprd11.prod.outlook.com (10.175.53.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Tue, 8 Jan 2019 09:52:57 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 09:52:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 2/3] regulator: core: add helper to check if regulator is
 disabled in suspend
Thread-Topic: [PATCH 2/3] regulator: core: add helper to check if regulator is
 disabled in suspend
Thread-Index: AQHUpzfuSbgXOYh/ZUy6GuHn+HLJVg==
Date:   Tue, 8 Jan 2019 09:52:57 +0000
Message-ID: <1546941147-18410-3-git-send-email-claudiu.beznea@microchip.com>
References: <1546941147-18410-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546941147-18410-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0081.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::34) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1838;6:602outgIX2dsnktWSAyHb9hNItLEDmWWwWcFLsYrVorAdSAL0R2mnoFec3Zake0vD/hYycDzzeBJI7N5n+j4VNlBXmz2SdeRWP2MVTQXYWrDjr9LlUTqvgiPvh1v3S+QqV8x1eo7RzNIx99S3FgeKx9KpmqLipcvQ0mtBfFE52WyNfuk2pdso2uPOkNw7AYZvsmE8qrAYNr6PfxlDe0zR2am0fG9pnb8kZGjd0CsU73s7hEjp1ZfO3fjuDHMT0pM2g9kzwG8WcCCzGPnbUvzy2Kx/PxADO9EdJnWHJC7Fg3Ee1NyIvdibld0tdmQLuGCL9Mn0sfdij9D79hbBqPLkWN9jRKrCoTb3Xe+JNkdUUKKRI9qfKUI0Svdsn0dNj9Vo3gVvzH5XxvhU6cughgWgo60fFbRClrq1fdvTVyf1jb229oNJbiFlhi61ft5lUlfdocCONWWqXZv5cqOzAg7MA==;5:oyYk+cZsM+o4/mnCLpE4ovd319EU280s+Xgm0zMbSM/rm/5NDT1hfSO9qaBcdT/KsrMrsqmaq35tYVxI5+XsoyPaTZ3VQq5vfd4RiKDWzD0OR2TvYFXvD41v2D72WRd91u8SXofudb7lEKqAI3W2yF81jh4g1056w73FD3293OG0n3Yew/D0ypJxp5RDoyysolj04434llts6xco/5ScWQ==;7:EQzfr9LW7uOrBsanl7DRWltyXS+IAW9bAwXNysYsRlhKNlhDzmdwQq/NmrCFO/++gdLydIkEl8FXUizM+rArDqb58tMLRS2PuDfgtU1oQnPGhuh2BzCmjMo1O42hSyfCq9SkowIfBmU00lIt/eUUeA==
x-ms-office365-filtering-correlation-id: 55135e29-257b-4285-c84e-08d6754f1105
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1838;
x-ms-traffictypediagnostic: MWHPR11MB1838:
x-microsoft-antispam-prvs: <MWHPR11MB18387B0C9F9D12484070E337878A0@MWHPR11MB1838.namprd11.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(6436002)(110136005)(305945005)(107886003)(54906003)(6512007)(76176011)(52116002)(99286004)(8936002)(105586002)(53936002)(5660300001)(81166006)(7416002)(81156014)(8676002)(4326008)(39060400002)(7736002)(316002)(106356001)(25786009)(97736004)(36756003)(14454004)(72206003)(478600001)(6486002)(66066001)(68736007)(2501003)(15650500001)(486006)(386003)(6506007)(86362001)(476003)(2616005)(2906002)(71190400001)(71200400001)(186003)(14444005)(6116002)(3846002)(2201001)(102836004)(6346003)(11346002)(446003)(256004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1838;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AqFDRG/eXvW6pL3P7KorPGW6hSvfWC9jyz1c8Jee0HCjqz77kX4WKCFUBQChw/VhsOZYIrPu56I/O/kcMs3Ym04rZVcP6LTprZv4nikQ7vr/rW00Ll2SRbEsfaPO3Dkb/a6CiSxDeEkiC53T6WZK0hJAk0N5n1Ztv65HuY/3ErJ1TsPo1h9QNPX9EvuZ/GruJv3/nYzFEBeRwvd3lmvLmR4I2SWBt8ieQt4LhTPdW6zbFuFFOITJkOVT2RIxXhh73Mp8iXEtJBPke+8fb9PF9J1sw8D6qlA6llYLdXmI15mpEFzCj9ZmsFxZSi98UBKD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 55135e29-257b-4285-c84e-08d6754f1105
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:52:57.1674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1838
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add helper to check if regulator will be disabled in suspend.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/core.c           | 17 +++++++++++++++++
 include/linux/regulator/consumer.h |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b9d7b45c7295..a876ec369450 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3786,6 +3786,23 @@ int regulator_suspend_disable(struct regulator_dev *=
rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_suspend_disable);
=20
+bool regulator_is_disabled_in_suspend(struct regulator *regulator,
+				      suspend_state_t state)
+{
+	struct regulator_state *rstate;
+
+	if (!regulator->rdev->constraints)
+		return false;
+
+	rstate =3D regulator_get_suspend_state(regulator->rdev, state);
+	if (!rstate)
+		return false;
+
+	return !!(regulator->rdev->desc->ops->set_suspend_disable &&
+		  rstate->enabled =3D=3D DISABLE_IN_SUSPEND);
+}
+EXPORT_SYMBOL_GPL(regulator_is_disabled_in_suspend);
+
 static int _regulator_set_suspend_voltage(struct regulator *regulator,
 					  int min_uV, int max_uV,
 					  suspend_state_t state)
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/c=
onsumer.h
index f3f76051e8b0..cf5e71dc63ce 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -36,6 +36,7 @@
 #define __LINUX_REGULATOR_CONSUMER_H_
=20
 #include <linux/err.h>
+#include <linux/suspend.h>
=20
 struct device;
 struct notifier_block;
@@ -285,6 +286,9 @@ void devm_regulator_unregister_notifier(struct regulato=
r *regulator,
 void *regulator_get_drvdata(struct regulator *regulator);
 void regulator_set_drvdata(struct regulator *regulator, void *data);
=20
+/* regulator suspend/resume state */
+bool regulator_is_disabled_in_suspend(struct regulator *regulator,
+				      suspend_state_t state);
 #else
=20
 /*
@@ -579,6 +583,9 @@ static inline int regulator_list_voltage(struct regulat=
or *regulator, unsigned s
 	return -EINVAL;
 }
=20
+bool regulator_is_disabled_in_suspend(struct regulator *regulator,
+				      suspend_state_t state);
+
 #endif
=20
 static inline int regulator_set_voltage_triplet(struct regulator *regulato=
r,
--=20
2.7.4

