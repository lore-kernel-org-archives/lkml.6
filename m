Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4621B214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WeqbaHsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4621B214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbeIXUuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:52 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731022AbeIXUut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPjUAXZrpf8Ez+hZdS7hep+Zw8OjxOE+HHDkbJ1zyT0=;
 b=WeqbaHsnazocpoO3MA0Om1tHsLwhq/LT85+JvsanUXqBx4wmoVApe0yX2b9FLvH96BGXKUylHv/jocFj0KYRZkVvXhuHkrbXKtKfmdFdDP5BqnNgyK5YqGtEZqWOG0kdit4/mkjK2Fl6ifZTIpVp+fcNBtsMyHeYy4jhSmQWosI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 21/76] gpio: adp5588: Fix sleep-in-atomic-context
 bug
Thread-Topic: [PATCH AUTOSEL 4.18 21/76] gpio: adp5588: Fix
 sleep-in-atomic-context bug
Thread-Index: AQHUVBWeRUacpA6SmE+yaKSdEW1t3A==
Date:   Mon, 24 Sep 2018 14:48:13 +0000
Message-ID: <20180924144751.164410-21-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:KMGXx3WLWmR803CfDeoNJFbro4hwCVktFGca0fzFPZWZPsKNg1Lgb8FTICkhEcO+tiHydeAosEfAn2G33J2V8t9WQ/yd34lumkDC4XE/jChsigBGjaWL53myj1Y7WUFRxVeipjk8hmb6rP+tlCEZgZirxRHZOfUn1sWZygchHbk2sWGDOxOgBN90eJ123riMYDCsiV03u+IKjJX6S48vjPJQ5YZw27tgZhzdK5Qii5CfO2+L9dqBwjtZmtBzPdFnz5HxWSrOEdGE2xNCNoKvipJNX4cNmQu6vzQySjuI+C1gFrUDTv2GG40NeM0Gv1BA50e6g/kyY/hpH4t7Z9l5fOi7TSmnsckdZssVHpMK64ttz7RDkfYsHwhwfxFGrT0lLa7lCAGAU67yAHdkf8y17k5nMSlC5Q67r/uhlAHaxwcx1b/Ikmu0OKeVjEp1AUmyqzvgUBZF/SuMxjHIxJKf1g==;5:DcWnIY08B1N3gND9pjgsKRAskmj2i5KQCYrEsr5s5WtkmDtBrv6BPfYnnQRX5Z/88X58AzTdaOPc/5DSoa0AB4rgwnhs9Tg+pWNuxL8rv7wUn66T4YDsmRm56jbaLhv9OV2MAJECLGw0UaKZmrIF/PYAKU36lZzw75649emSa2M=;7:7OCdEIUz6DyDMjzeBJZaH/oPM/pdoHI3JNTGUH6EC/iUfHHZswEyhlGr8sR9W+k/JfvlS8gRZVoAJD4Ho+PCpDezvM5naIEpfjlYPUE5taSr/n0dBZCGJPTAkPtuhtEiSvLwvzpxHLevOaLECHBpW+KcPHizztQRLoZZNgORZVk80+suJeP/0SkUiCk8TIwuG2aTQgCVbgyS4b7UGLjEwEsGWW3unQzRPpaiyeteIuNnyMZX0SRRg3gSKwx+qiWT
x-ms-office365-filtering-correlation-id: 0a517d84-cd90-47a1-1182-08d6222cc17b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB082110741E93C19B24AAB898FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(105169848403564)(232431446821674)(85827821059158)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002)(60540400001)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rndaMLGzrRucWc6sJIQ33sS/jaVroUhL7SkxKy1grf98l0R1gU2T6VpYlb+sAb5UT5fxzSCCCl/WUDVWDVBBdMduTbDSUha+GNCtvS6lBhgtuGlttp3JfhQS/G7REo1pQYq52S/UMGBBQMD89VuUFChU3qoTyJsnG84SwNriBmgjBmjFzfEFKWdW6y7JQ68YchjqOsV8nu9VtxkWymplAPA5Nwm6rxobMS31ISYv19q+UpmopmqaF0bItri6ijzgsL+SBTb3E8KQSYV6fY9I4cZgaByU3u7NNVlYXloZajh3EZEH4gWOfh2M4me2N3AuzIc89YUU9/x+8FWafW9C485iFW0DtvET12AvD1/+MPnQ8dCblzxOfZK7FpUae9s56Dz0aD+wc63+12Nq19TE4dkGh+uNKTMef9ZEEu0kHHuIo2SMjJsFX1bPq8vB1/9Y3WFrf7EVM6ggK/Jzx1tmdEhVtnsVEN25V4T6BaV9bRK65xliJjKzQNNslEnGi3CAJjtcHSSTJsKCLHhzqCix80VgvIwDM1BNdBzQd2cITf5McCNHUcmeJS9IqArlKlu5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a517d84-cd90-47a1-1182-08d6222cc17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:13.7876
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
index 3530ccd17e04..da9781a2ef4a 100644
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
