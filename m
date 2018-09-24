Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F4ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDB22087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JlyLzvkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDB22087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeIXVCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:02:45 -0400
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:17577
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730756AbeIXUwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1JkgadDgWYJRdYTjD6ODUVV8j4J/gKVARJpQnxqow4=;
 b=JlyLzvkKINHhlDx9yPm724Ksh9JX2he58TNW+jBBnheKRBU9YtqB9X6hVQjhq1miGs37HCP1xhS2VsVGJ4W8QBsBMjRrSP0crst2r0DDM5+ZJdWzmmiizTPy2Rki1mNFc4FSlKTaocfxXMs4EmF3fEwxZGQIqqADn2VCcibvizE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 08/36] gpio: adp5588: Fix sleep-in-atomic-context
 bug
Thread-Topic: [PATCH AUTOSEL 4.14 08/36] gpio: adp5588: Fix
 sleep-in-atomic-context bug
Thread-Index: AQHUVBW5Um/yafjMMEuWe/f1faZIHg==
Date:   Mon, 24 Sep 2018 14:48:58 +0000
Message-ID: <20180924144851.164533-8-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:QEojRJUGi7W4UgY+AEufVfj88rLGKNqmsJyK4fuNjhlafuaNjRjTAKgphW2EqlEiFiVg4YAmneKYwbRd+J7KVmm0C0UEk0Nv3QeFR4ygOvWHWHtql2C5ktQWlhOB6l9LiQUDAivQFEX1xjyilgExha5G3Tv5apqntxSg2xHYLyIoAoMWHlZLwtm1zHrTa/bfeumUP0DjNB2SzFCw9aFg2g/4QnT9v7kyvSy2zGIy+v8NxG3JZhgQJYAgGWbattmABlL5on6XF7r1LQOP4GBksgEh92yGUF/2eV4hgU7YlCnf1Lc1cyxJf6WGVVupepXrfiSsU3/p6pCvEK9GbmM0NYBreRUYvmFhbetfdpZXrPdtgojqzksX2EqOcx5GNUifdArgz+d44H1wzzWVbFRXrZUqhOayXX4lGqYD4dkbaQ0kJ/3zZ3HNM8jJoy4nWZ0mruTK414XNgwnfwmGWzoY6Q==;5:gk1MJA61EMjqXyoessZSDfbERhS0qaxYGSYC9hW53GQDMWh4jhtH3JP205XjJBMGslo0O9jTDFx3L/EiEqFreyJH4mgK8XAWkXC8IahZJCJX27kcMGhKvAdCGUirgGo3CBmGnHyQZ8Er83vCc9voXaWP8vo2mv8gnhYQMOCQMhY=;7:WyIXQOIqV5DnU2b5aa/YNGO6zNNgMsEzos2t2vnV9gIxOSKqeoQvXTWlrmMOfj4Zssu1PZ0drDpXTdh4susHJfiPGS5L/nNUbVoz7NXl6DHRoAT5q9urvGCFRSeu9rMm+eefx3sh3PUaaYqMBBygrfhlulSYDvJvuL+CcuJYne3IWe3a5O7PqLT6qOHNB6YLjAQvNeCQLUSUxCpSmniq2ocLqqD539OOLKfzQ2ggZG74KRYZB2frdswQVqQMxNON
x-ms-office365-filtering-correlation-id: 09e33776-9b49-4bf4-68f6-08d6222cf5e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181950C308AAE3F3B079600FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(105169848403564)(232431446821674)(85827821059158)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(2280196)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011)(60540400001)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u2jUekTy82TAvjXXO0WaCDP+v/Qe7QhZhviI/tVHjJb4BbQU+eC+Q9WpWTU9krjAaP6+gK6QqkN7jxTuC+2Ti/SfRY1s642VJoKY7m+qY3o9/aPNC5BzSGo7MwL1gf6dt0ojcd59NR7/+Xbt1yq9yW9b20BJn4qO1c914pfpU89/oMMrfAKAGwhh5hxGQUCtOxiSvWrAt5NfeNGiUwVELbYRFyIKvSt68mcx3+AGv+hNv/Iar6t2/WyvDegChOOc08l7I1kQtHxufCy5tRmPP8Z71gv06b3oblQIBu2ezvHJVeuTlDZeK/xFea81zi/VyrDSeDgnVYdEW+HR0/XDaS7KRCfGo5qcwiYyAUfUFEnJWVdP2UJ2ruF0GjNspvuu0RWH8wSFjERgYCRyowcb/4iCM8dwCqzx67qBY6g/h03pomt5GoVZ8Lyf7s4r6rMDQ8Z9OdbjImj4j4d89oRNbAJmVIrR91fkVAhzSijbsnzbc3zQheh+0uIfM/mGXQ+uF/phe1WzqSmPYA4tik4crNtcpWYEkQi/qz4+f3OrkGHi59jz+le+TWCUHXZJJ7yK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e33776-9b49-4bf4-68f6-08d6222cf5e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:58.0991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

[ Upstream commit 6537886cdc9a637711fd6da980dbb87c2c87c9aa ]

This fixes:
[BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
                          in adp5588_gpio_write()
[BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
                          in adp5588_gpio_direction_input()

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-adp5588.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index e717f8dc3966..202d367a21e4 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -41,6 +41,8 @@ struct adp5588_gpio {
 	uint8_t int_en[3];
 	uint8_t irq_mask[3];
 	uint8_t irq_stat[3];
+	uint8_t int_input_en[3];
+	uint8_t int_lvl_cached[3];
 };
=20
 static int adp5588_gpio_read(struct i2c_client *client, u8 reg)
@@ -173,12 +175,28 @@ static void adp5588_irq_bus_sync_unlock(struct irq_da=
ta *d)
 	struct adp5588_gpio *dev =3D irq_data_get_irq_chip_data(d);
 	int i;
=20
-	for (i =3D 0; i <=3D ADP5588_BANK(ADP5588_MAXGPIO); i++)
+	for (i =3D 0; i <=3D ADP5588_BANK(ADP5588_MAXGPIO); i++) {
+		if (dev->int_input_en[i]) {
+			mutex_lock(&dev->lock);
+			dev->dir[i] &=3D ~dev->int_input_en[i];
+			dev->int_input_en[i] =3D 0;
+			adp5588_gpio_write(dev->client, GPIO_DIR1 + i,
+					   dev->dir[i]);
+			mutex_unlock(&dev->lock);
+		}
+
+		if (dev->int_lvl_cached[i] !=3D dev->int_lvl[i]) {
+			dev->int_lvl_cached[i] =3D dev->int_lvl[i];
+			adp5588_gpio_write(dev->client, GPIO_INT_LVL1 + i,
+					   dev->int_lvl[i]);
+		}
+
 		if (dev->int_en[i] ^ dev->irq_mask[i]) {
 			dev->int_en[i] =3D dev->irq_mask[i];
 			adp5588_gpio_write(dev->client, GPIO_INT_EN1 + i,
 					   dev->int_en[i]);
 		}
+	}
=20
 	mutex_unlock(&dev->irq_lock);
 }
@@ -221,9 +239,7 @@ static int adp5588_irq_set_type(struct irq_data *d, uns=
igned int type)
 	else
 		return -EINVAL;
=20
-	adp5588_gpio_direction_input(&dev->gpio_chip, gpio);
-	adp5588_gpio_write(dev->client, GPIO_INT_LVL1 + bank,
-			   dev->int_lvl[bank]);
+	dev->int_input_en[bank] |=3D bit;
=20
 	return 0;
 }
--=20
2.17.1
