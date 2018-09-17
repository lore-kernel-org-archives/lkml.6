Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F90ECE566
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F2B214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HU+5E9nQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F2B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeIQI2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:46 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:50080
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729758AbeIQI2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFukvIaODhFZ1aA8LBcnKkfyX7zxYVJ27pzOWOl0rhI=;
 b=HU+5E9nQ454qDP60uQx/4QjSzsXcYqgQZGiFQwrf1tTNz2OPQpFn2qP392muE5xYStS16TXmuaBhppjI2YLqBi7IjNy1Y77LYDgOC2T0m0JSpsgJT069gMM4E+CZG9g0g4xQ7ODdH4LokTLO7APUcqm6hs/QI0KkBtTT6VO3ct4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 136/136] gpio: tegra: Fix
 tegra_gpio_irq_set_type()
Thread-Topic: [PATCH AUTOSEL 4.18 136/136] gpio: tegra: Fix
 tegra_gpio_irq_set_type()
Thread-Index: AQHUTjK/BwTd8YnjKEWtjQjsfwwiuw==
Date:   Mon, 17 Sep 2018 03:01:37 +0000
Message-ID: <20180917030006.245495-136-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:KH0r4pSddoHeWDUNmBPKzQX+Duq9wLtG84IxfYP77up6Of3tqi7o4OQRAkZsVjDt5Fd+hsBhCfLrHy56tB5kPlY1FWYWcOcAiwl4wN7ZunqxVMic41pst7LnY2NLFPiP95aT/+9L1rsnmbgrCzVf96adFaxxIuDRS5uovw6ShL/ZVu8XRh36JPJJsmbrvcJ8MaZRkFDOvu11OY9Mb4OCWs5nbdQPoIDaN9w2WRQCx8u9Ra5dEBQ5KfDoBMZ2csxaHAVDt2hy2Iv0oiSOAdDnXi2COovQPgrWOYOgjnrPRxIbMTqmjU8rMJqBJeMg25X5xHztqp3RwTzsYFkytt+NBcQ9Y8XghPzVgbYnpz7k0lQYuBWDvZggJXvEWcc0H0pa19XhYSTIXZVcgl8C0spCa6DOh7FfudhylhyeXOCKA4z8k6C5PLSyzssgfPyZXJj0z7Uw3BzxmQ2pc0/qAuNLGA==;5:aQBzqDsnRH9AsmHNXfQzJQWz+yMH2a0D6GTeSnQp8kKSsaUaQkgpt+pHa33sOn7YoebGBg8IR0Pb+7u6H6U9w5BNZi80wv4QxbX0nDTYZXcGYajhdfMdzPbp719x/P1i1lpYv835WHxu9WdyWujsMAFtUGCvUVDZ5lu7I4x+Cqw=;7:HosTqqLcMHjA3VQMMa0HiC9OhiYO4e8veMiOCXAza4qgBD2JAEY3jJm4cn2IoOHNKjOl5Sy4i5iR+VN5bFiJtzNTe/uwqB1SNt2aEdJwYi8nVt8mZJZ1pMjfm6LM3xygGmLHmee7rxfFF+V+kye4xQow88XqJY27AlGowRxbtCWDbDJ3emsKJPKiTb8HB9vKJYr0z8djNlebCqVU88+CTVf7viR+e4CkGHxu58PZuc1t99WDBCXniDWrexERthLT
x-ms-office365-filtering-correlation-id: aab22b18-2191-4247-3e20-08d61c4a23b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855D1A2BCBB045826BED77AFB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(18589796830644)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(6486002)(10090500001)(10290500003)(8676002)(39060400002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6666003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5ywQO7aU70xzqBWqo6bFqYfMrkIFsUE9qTWlAK0uAKIC4nKvdqvojY9JMqbp/MfikGAjvmGfjmD0KRk+qgFAnzG9GwCMTcD7NEKsrDdumch49UJVjg/VokdnJHXxfUz7a7RAIzeoSZQRJxSZNIAlNEaHo8dq1Bey7bjPVEZJtYD5q/XLhcXyvDKwgX3wD1omRnFga5ngUzmh+iO9wOdS1+fWtZ1dkZ7EHRr+Z+j+i7j3w4UuHVxZl/4n+0SOKsk1ENm0pJtdnx0QQ/VPfu0uesU6kC+7ailHcG4A/3z0RMX6eKQhppPXaG/+hLUC2FUaZoMbSV3hdLOURj3giV7jQuLpwt2AzMkkUBbGmbJImEQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab22b18-2191-4247-3e20-08d61c4a23b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:37.4008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit f78709a5d4114edc21a5d86586ed5e56e284f2bd ]

Commit 36b312792b97 ("gpiolib: Respect error code of ->get_direction()")
broke tegra_gpio_irq_set_type() because requesting of GPIO direction must
be done after enabling GPIO function for a pin.

This patch fixes drivers probe failure like this:

 gpio gpiochip0: (tegra-gpio): gpiochip_lock_as_irq: cannot get GPIO direct=
ion
 tegra-gpio 6000d000.gpio: unable to lock Tegra GPIO 144 as IRQ

Fixes: 36b312792b97 ("gpiolib: Respect error code of ->get_direction()")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-tegra.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 94396caaca75..22e7c99ed69e 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -323,13 +323,6 @@ static int tegra_gpio_irq_set_type(struct irq_data *d,=
 unsigned int type)
 		return -EINVAL;
 	}
=20
-	ret =3D gpiochip_lock_as_irq(&tgi->gc, gpio);
-	if (ret) {
-		dev_err(tgi->dev,
-			"unable to lock Tegra GPIO %u as IRQ\n", gpio);
-		return ret;
-	}
-
 	spin_lock_irqsave(&bank->lvl_lock[port], flags);
=20
 	val =3D tegra_gpio_readl(tgi, GPIO_INT_LVL(tgi, gpio));
@@ -342,6 +335,14 @@ static int tegra_gpio_irq_set_type(struct irq_data *d,=
 unsigned int type)
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, gpio), gpio, 0);
 	tegra_gpio_enable(tgi, gpio);
=20
+	ret =3D gpiochip_lock_as_irq(&tgi->gc, gpio);
+	if (ret) {
+		dev_err(tgi->dev,
+			"unable to lock Tegra GPIO %u as IRQ\n", gpio);
+		tegra_gpio_disable(tgi, gpio);
+		return ret;
+	}
+
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		irq_set_handler_locked(d, handle_level_irq);
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
--=20
2.17.1
