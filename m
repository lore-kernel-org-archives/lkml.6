Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463E5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65692087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fmhqzznP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65692087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389025AbeIXUxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:53 -0400
Received: from mail-eopbgr720109.outbound.protection.outlook.com ([40.107.72.109]:44208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388821AbeIXUxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFP00kBoonBMfXgGmIWDHNQqIweOv7ML3mZgCq2wY88=;
 b=fmhqzznP4Fm0tSNLHSa6xaMK5OvSuV9F7jCdaNpxm2rLvrabxzS9qPiKwytCoOiNlW4A447FMjP2Qf9yx6o6Hu6wsMAt6cUkyOrba3Ftqww9RfNyqigKTdVB9lHovsqtbtLrSM7SAfSmKcBFVLeTnMcDmtFCt2Xufl9+DFu2/AQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 04/18] gpio: adp5588: Fix sleep-in-atomic-context
 bug
Thread-Topic: [PATCH AUTOSEL 4.4 04/18] gpio: adp5588: Fix
 sleep-in-atomic-context bug
Thread-Index: AQHUVBXWyStixNcIjUeq1bvAl2m5Vw==
Date:   Mon, 24 Sep 2018 14:49:47 +0000
Message-ID: <20180924144942.164688-4-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:tvT5qzecZV0YzdOQ+8EobxVMMnQgseXSgNptnnv0c3QMyWKdIgpSr6V1IwQK6e2CUmT9MIun4vz6g5WCp/GIUHNao/VGHDgp+JlT6stou0Chl5WSjthpNQ/WY6GYkZI1pLiYStrI3H3s+03Akbaack0YPQ3EV4EEr4dV7ylnWAhMp3LTXK/qKKgdCIKHkebDYYmbyAOtjwP2Ee2VGIhFvxDJWSRahasfNl8Ra/xpkU6pXKAJYS1ko8P1z81Riwe/ARtc95GThfkhycaDr81ngeryqMStq88hkuGuEpdgPHrw2HLj0nNIJPjhfq49yiS9UDWyULdh7+6uIOO7gUAXfVKoLO7B7h5AfIzObL30avmsH3vUuufjslW6lXkcP5j95mpPN2CRo0O4f+cGmF1NZYw2wdEwqacv3z6s7TmO7SYaA+PQLQDvjrubaNfI4Z3k2+CYnLCBNYlYbJne5SNeOw==;5:1VR0ok9YQP7xG0PhKqYMxp1ZIsfdy+k91Ph14MxG2YzYBvJjbwDKgMqAAAUGKeSu+T6rANACo9JgEV55ovIFrq0CoQyMiix4eLe5Z2L8Ty7oh9QRhKsedhzFwF6PtManB1qz9o5m4AXQdzoYSF3kn57oRFu9PAcU5GXkFud9s+4=;7:xt1Ut6oBvCbaBfn7+YkZrWRr7KyijFgLygAdc51QrV3UKsOD1wsJ9LhUrCC3LKTzcwc2hPeJr8NOOiW6Heww/lRoef/x13omkk+W6PXmQoD3vp/GgZORr2lbUkQVBM+iJVZ7gLf5G+A51RG5q0hIafzikncf4mr358vf/dChlv1XDVSrsXnfewEptEoArVdwUd6eDGuABM/AvJLo1VegUWrRNxjFGT4LGaP2r7+dVUHAeHx5/l93kxngZo2kAklW
x-ms-office365-filtering-correlation-id: 55f34e19-6c6b-4c36-a2ac-08d6222d288c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB082107C767181E7B2F329DD4FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(105169848403564)(232431446821674)(85827821059158)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002)(60540400001)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +3NXUE+DzwSEpfdic4Ai4r7AwwR1/PQbc4p6Dmz2dsY5g/By6slHVGbjhOcD701BEFmcDJ/w40rHw1BxtSlR+GeY1VPJT/bJW054/xe4xzyQmU4S+qknR+a2dgRUwkrOC7yHbQMgpjymDjJ9hADKUQZ5OvxSDVINWzv8AXFYt+ArJ4vpNdXkmBbpBsdpfvEHmIuHuSH7pJfSio/losToHirdQxSZeuRPZiG8SIM8hYt9fnuJ1wAyHqmV+FLryz+EThZyk/xxrdOZ5NgkpZgvPeVfkBsm6UenX0U+UR+KbzTZg7OL7wHfU47eUnSbRP6Ceq0hTYXkmbPGLE+32kq6Vo8KygZZ3JnT5uxYjizp/rItoaKvvCXrZhRpjFFMxuDqVYqpFPV/r49qy2bhWD+hsxrRJrSWBJqqcr3GThVOTCAkRZOAWgi4PNF10Livrh2Oro14Ybl6CGlyj403fggqPTjvlCZDzujEMI4mqddqowYdeKirDRVI0sLcnkbKtjxqRCg03w6/I8VpkoIVkDN1zg12TkDn6TNLP0s83hcHjijhscbx9/BB5sCTJjQxrGaF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f34e19-6c6b-4c36-a2ac-08d6222d288c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:47.4067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index 984186ee58a0..f5f7b5368da6 100644
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
