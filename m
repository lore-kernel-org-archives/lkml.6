Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01F9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC2F2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gCigcUPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC2F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbeIXUxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:04 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:52378
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388565AbeIXUxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok3msBVh7n2c/6b86qhOG4yRt+Oo+JCVB05x0mxWAho=;
 b=gCigcUPf+apBm2V3JF1/VCrsV/uC83z+oud+X0jPAXVwqtzur7Qh09fbaosp5NPcEC8mwenupFvN76TfOTXama3rXUzH4pdcPdpvJBTBVmwIS0T0Ju3Lt+BBbzq/v0VYaIPqpxqLiTJTXwCnTf7jllo4N8GoLPBCQW0DoRG/Nps=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 05/23] gpio: adp5588: Fix sleep-in-atomic-context
 bug
Thread-Topic: [PATCH AUTOSEL 4.9 05/23] gpio: adp5588: Fix
 sleep-in-atomic-context bug
Thread-Index: AQHUVBXKmuwCBvHLn0uWItovYGeW8g==
Date:   Mon, 24 Sep 2018 14:49:26 +0000
Message-ID: <20180924144919.164617-5-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:x4Cs/vCCt+NVOIzgYcqIlY08MxA/4iNMpuOA9zoVw5k8cADGgqWTwxfs9UpaO9CLKi5A0LNMN0B2Cr1kgvs5HDPRJdKwf5ZWJVu9/ny5jZnMX7eLPtgjBVlNbU3cp9UHsixxIqC2wWjhqsxrYtTGRsts7PcR7Lgo6d3wSdPh6A/2/NLSVZAtHT4kGxFbd3TTpNj8KzkBo74aajTOzqN8ZuZdNvCj7ilEJqI2Tv0aA39jp1HqB2EBMBjPqIqsbWkuYKUEBK/qLo9qNkjnBNJsjo0FLNZV5HdNfystAUq3GdHpCNHlJa5MROsvOJyrGfdo94pngA/5U8qhZA7Pmv0a+fvxxhXnCtC20TKRLG/ktKWeRJTFBcx+8NSzsVFssn6oO5v6zwAEmhel3HazdD77ZjadTtUSbsel+R4OX7lqcMpGw6X+nGpeWdbdpWMwAL46D+WoiwcWAo7SV5CYzwsrMw==;5:n2df3TQZQtxIi3eX6YkjdsWMO2l4CkayLXML7gbO14Th3BjPzdWHMVc3C6iv4QzhbIQg+HD/Gj10iprwIinPPQ8qvrrKAs838K2SsHGAijv1qmLVZozLKoeXtm+/Ksu+GeZsiVPiPu+tga9RUoCzifUMy8IY9EAXwrDehxIjers=;7:dNb+Bhu5Nh38haWz+UvVGqZ24Lsjk7jahoGvatC4f0WkYPN/bUQAsRIKYFVwyYci9imYxcPD8xmTQegFpdwOqPUAhAZ0LF89g8YdQzYEn5xtgn2Jm8AaNy2nZ2K3YpD57TCHGHK92isowN+4w3V1G/SBqzfugw2psv5TtseFGoactsUB4vs+z6TPWmCZCZjETegzSAxhTHSmuwolEUkaEcPRjGVp+Jm3ZnwjAdmNylrnw7rfIGQiSrcrZqtJi+6W
x-ms-office365-filtering-correlation-id: 182531b5-a7a2-4126-4d7a-08d6222d0fb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01811958A36A3572683045ABFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(105169848403564)(232431446821674)(85827821059158)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(2280196)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011)(60540400001)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IUA73Vi2H7thBEV0/5ckB3Oglk5G+/LglJKHnGWzDE1KyBYJE5CSnGODHyeJNzHBaPlZPO4xyseDqtb6ilpjEdV5BE2fff1SGSoUHjFt4COdWY+QhnBd7HnW07a0XNjD4Wa4LwyeNf9WJfDXlHiyxziAnb1BPMk7t1h3t12yV0/xOAqc0NBlmR62FlKeOZczU5IsDvx+zVnzuZQkUbgXULJ1eXHnNodvjTLgE7kVS3lGgU6MK2mu1fQaJs/n+6YkI95XvYlBAGk2FYdUsqRuYCOySHmlvgwuaWXzzIAZgNzE998LGybkyQ2xsr5v7rwJHGJi4hoJsakaDz38N0Mb3MWDTyAPAWsLNEWsMHyC47kpMXXEl/Hx2W/AOD1QSrSPUbS77z4CHAuPTBPRBvJGf746IEjeZQNU1nxroxN/Vj/niqkEGXeQqWSqoPniHHmmHa3OVgkkBTF0KlIHOcuH2JYOyCr4C5Bdzl5OPY4sNW2n6vAASe0kzUKCH2JM8y/HgezivkyYKbTW+nmWjIxZYaqvxmLB9fJb4xy5hpW73FFsG26VOQBbDyaineNS8ATP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182531b5-a7a2-4126-4d7a-08d6222d0fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:26.6836
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
index c0f718b12317..c85407abc201 100644
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
