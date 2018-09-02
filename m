Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1477A2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hiqu7mPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1477A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbeIBRmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:42:31 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728907AbeIBRWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7EUMhhGVi+1ITQtYNpWqnsDUIYj9ROrIevuFroxCMs=;
 b=hiqu7mPzrdyFuqUe0+5j+F96yfQED8GmaOAQebUceBCPUEgAcrQjKzMcCfSoDUq2R6iFJvvqDpNhhZOwCRt+ohvWhKdqcSJ4aT7zc3XQ3idi0BRUOBi7jSzxMw0QqcvcD+D2lzfeWkG4RaUE3F1IKIbvFBnvRJhhP+JMuRkbNBk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 06/89] gpio: tegra: Move driver registration to
 subsys_init level
Thread-Topic: [PATCH AUTOSEL 4.14 06/89] gpio: tegra: Move driver registration
 to subsys_init level
Thread-Index: AQHUQr27Hx6moEr25Uywg1zJluwWoQ==
Date:   Sun, 2 Sep 2018 13:06:16 +0000
Message-ID: <20180902064918.183387-6-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:qVV4Tp4EP7o+8fE2ldPvPgmjMMmW18vAx7fn8d06FG2mOnOIjc6R9+znZTo6l4Fu39R8rR2ivnwo/yViZSZXbSzKhexTUGmvNySWhRw3PO3bSVfSfIv3nLCFyIXpaOdz0YT6Sxa/FGNBPOWhlhSWT7MYu+W42FQTXztt843Dx9YdCAj3a5MqBPnNTHuT6aw7Lk7enS3H4xBPGUCEjpemXrButsnGJDfSeXLLXNCpoTYXdqGaCdNm8ELxeX06SQH1H/8B7wYCxBtYoxOLEnGAhZ2prlIF6mTxW4OTNaYCZvVju42c8nrmloHNqhBzjLP9B5zvxfdCWXQOiYyhsOhKDphSfsKhhmsaue2S5WYcwhB3YWub/LRto+H2ZOvhD2HakO/HZ0/Edm2sSiqQjN5ePq60ScUEIjHQaTi6EkZKoGtr98T+KmELk9eIsPleNWR81boRylAKgtNhouSDoFy1Zw==;5:IOQjett0Qam/CjP4CBTOmwKJFKEpB9yaYfDZR4vVCPkOm2mckIdlPrmp9+Fy/kz0bA9K5WuROrM7w/COCjo89/iZtmAEOryElH5UFSEOq5BJZ27dJPtyH6N0st3YWO0/jLJHYF2gTt9sXh1BCDcQcUL92Fe/VJr6TDYy3iE2oy0=;7:cnXRzCMAc0AIiTZueGDqhtmxyg6J9Dzm0vIbfVwzd/XEpe+HV8a/zNCsbOES7I6hO2gCjaYaR/loNlfnWEfMVKzVQOU2Q9SD+0PA4GKfUWgEW9ZhF+ZqoGV9KnuTqn0Y4RbjrWZMwrLbWN2622EzVRoeO8ux+1fBsS1pGY2/5NWhMvFwIoMzW9Kdh9by/Jo7/uyvDSJq3ijc21z9coljQ4C8UrAxplxYoSPlwXGtjzmdmr0P4Qrmm5odXAgXEhif
x-ms-office365-filtering-correlation-id: 341e297d-f353-4595-f7cd-08d610d4e183
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822B14F1E931456BC3E920AFB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(575784001)(110136005)(86362001)(39060400002)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: tRYZtG9SM3wws6TPeJqEea3xgLEypwHeohFwSQ4hN6W2ktyZu6euHiZ0MlesAtXQtrU7r+dscl/eZcBKdghBzMMHBAQUyJOmHzhKNqKaCI6cdXe+ML9ojn7dxWpmwGGaoE8EZXQOZ/u9UZ16Ttm33kAMTyw69yFCRYYhYRYpSMbUB6d7J2oDXL+GxoXeXzmxcMaPzX4ewIb3IKHxJsYQSmJfeZJVWhgI5YDFuyRJpg+kg13iLiG6GvzC+ghWS1ld+xpJ17Fe+md8q4oTG/kENSVriXx1u6jgTk54cUXuJhuCPBRKQ+B77k5iqnqLuyMyhb9v4cewhVnHQoHMEJrWGs8FcG4LWT06RC9SgThC6cs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341e297d-f353-4595-f7cd-08d610d4e183
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:16.2777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 40b25bce0adbe641a744d1291bc0e51fb7f3c3d8 ]

There is a bug in regards to deferred probing within the drivers core
that causes GPIO-driver to suspend after its users. The bug appears if
GPIO-driver probe is getting deferred, which happens after introducing
dependency on PINCTRL-driver for the GPIO-driver by defining "gpio-ranges"
property in device-tree. The bug in the drivers core is old (more than 4
years now) and is well known, unfortunately there is no easy fix for it.
The good news is that we can workaround the deferred probe issue by
changing GPIO / PINCTRL drivers registration order and hence by moving
PINCTRL driver registration to the arch_init level and GPIO to the
subsys_init.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index fbaf974277df..1eb857e2f62f 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -728,4 +728,4 @@ static int __init tegra_gpio_init(void)
 {
 	return platform_driver_register(&tegra_gpio_driver);
 }
-postcore_initcall(tegra_gpio_init);
+subsys_initcall(tegra_gpio_init);
--=20
2.17.1
