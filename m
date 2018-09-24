Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D728BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C462087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fdbRbBCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C462087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389248AbeIXUy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:27 -0400
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:2178
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731884AbeIXUy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jFESLm8s44PmIk4XK576YhTO/SyAG+o3FWeehb2RRk=;
 b=fdbRbBCeZRXXsOrr4wZ6QdWSaVh0Pfv4/LB54S8Uoc5hcG5lHgVOw1Vp/yhIEgY2A8WxtzjgVuOlO0S3vtioGo760DJLlJpF77JJBBWDP6HKGK8jKw3R0QAlX/l4bON5tE4v1Puwhz5FmZ+LZNM1Dc+pCcQ6GL0acLcXdChmq4g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:51:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 03/13] gpio: adp5588: Fix sleep-in-atomic-context
 bug
Thread-Topic: [PATCH AUTOSEL 3.18 03/13] gpio: adp5588: Fix
 sleep-in-atomic-context bug
Thread-Index: AQHUVBXjaS0DUiC6UEKWSOMQ/f49+g==
Date:   Mon, 24 Sep 2018 14:50:09 +0000
Message-ID: <20180924144959.164754-3-alexander.levin@microsoft.com>
References: <20180924144959.164754-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144959.164754-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:qAKaYEsAPIcMuRaTjsHR0TlY24dMBQsBaxLD09G3B4w/XuzprPxWCrXP3n3ZmUO2J46zRmZLn20PJtx5GmuennHdCIVOUMrWliTPipqU077qsJxLW8+c5DZJe9ftbzkRu5PVnkYAycE1rt+HkZcXuPdCfWV3BoI5gY6aCwars4tves4aVcSxz062sOp6qsHVAKdMdtN2LMHATlGkLe4xGNtmMU1wNtAJyiS/OIbF4bhQ+kOrpbk/EDwfGBqnquUVfhvRla5GpSiTbUdNnFWbW75FbgV5J/xDkaGUt5TU8KJSDN2rghm/O8ynu+BIG+ne1Q9TDNWsaxMEIN8ZILhRYaLzC8c8c2dzjs58r4YKECfCOFhzQPG38G3+pv8UM30mAqaz290DfU1BMERRtZhN4LhNxEcmA90rK7AbkQRlhoIojVKh3UN5uVtZXec7EDCJzbPo4kdKsGBVw5CiPaOuNA==;5:1a6E/9AYfs1JIW+4nFqfnxl7Jm7Pqyw54nq7umFXgVHWZpubpSjI4SJbSEnqHnKZRPMOYr/sQtQTFkTf/Y+ydzZdMtosiJHsncR0ISY8J+P15lX5JwQpohHJ8X97GTL8klIMVte8fCYAfADJuhsGX6RkMf7gx4JcucAqvbEFn5s=;7:P3T0KhuOrVx1kGjw2pTJsY7A5c8MNF0fo/90kUXD+Z/2oM+PwaGtUh/C0IzTkdwzDo8/7Cf+G3G4g6MGM+ZDZNJ1czmLwYkDpS88m9F1d0HE2Q+XdVuh3KtR8bOufhbalbJsaUP0KW7ELsiFFDFDUuO4Cf0+zErv6kkylpmpz87ri8kWmHZiqgzqgOTTJ12l/nf45beXxtTwgAHu67Dn9FiSL21Tpd0fYM1KdKx93vACT99AgBFlvFZr5oQoz+ky
x-ms-office365-filtering-correlation-id: 64cb7475-04bf-4c31-19a0-08d6222d4110
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0631FBDBAD3EC83F2ADC0257FB170@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(105169848403564)(232431446821674)(85827821059158)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(10290500003)(316002)(8936002)(66066001)(4326008)(107886003)(6666003)(22452003)(6512007)(25786009)(110136005)(54906003)(305945005)(68736007)(53936002)(7736002)(99286004)(5660300001)(2900100001)(6486002)(186003)(97736004)(26005)(6436002)(217873002)(71190400001)(10090500001)(1076002)(71200400001)(2616005)(11346002)(446003)(476003)(5250100002)(3846002)(486006)(2501003)(14444005)(256004)(86612001)(105586002)(14454004)(86362001)(81156014)(81166006)(106356001)(76176011)(72206003)(2906002)(478600001)(36756003)(102836004)(8676002)(6506007)(6116002)(60540400001)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FpLkfLKY9lKh79V2dbWTF7ZtXh7fAjtbokYiGxati1VYBbo2R7NMFaOYuQo0Vmj916FaLzxDjRwP1Mo9AELw4GEWI2cfctidlt2IOimLHYPiqmghp2KjjiXmmweQxKTi/CwNmdrURt4nJ590v4/63zB3dAXHMJr589ha0wk10HmpMuTLwycalnGlmO7pp00qRs5ul8JB8RlbRLtAajo5LWuxgpqRt2JNxSkAge6CedmqlcWdGN6pOOAZ6yQ0I7R09cnCYj5d8Pvadg6/0p4cb+OuU2umbKS1wXiLPkFXWQfSZoOBtnuOMu/cHTpIGrR22cyv0xOdpgfFR33ex+wmAS7Rk/tiPwrKy4QjkhBZrdyAh9nwAdDIza5HiB0xbYIpoDS1FtWmXAbIiwzeCPj8LvyD0F7nyC/CNC+WwWAp+dySpGWwLbsEJYhW2akoBBHzbO0rMqDSv31QGlTbkkeOhaJ6iL9M8hS5ui9THpN5jYmaeae5GkA6JgqpqVEkvY5c7PrMmOn73ZtmF4ehcpTX2Ggi9ygk6Sj3xzlvAxMLgDUufVgMTFWixe/HzgQEr0P7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cb7475-04bf-4c31-19a0-08d6222d4110
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:50:09.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
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
index 3beed6ea8c65..348cde425220 100644
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
@@ -177,12 +179,28 @@ static void adp5588_irq_bus_sync_unlock(struct irq_da=
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
@@ -225,9 +243,7 @@ static int adp5588_irq_set_type(struct irq_data *d, uns=
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
