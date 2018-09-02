Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0203EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E3E20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aKl0qiqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E3E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbeIBRbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:43 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbeIBRbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpbtsQzVLGlEM3WSr8zAVKUvb7TEWwmw0Q3oQzqTsMk=;
 b=aKl0qiqoBeAnJ9u21jP09r7s5cqiZjvdKLAsWUH9KyP+5T+lI8gu9jpfHl+LbWJKjn6wq/pVHArwZEuExf8kLvqgHIaFP7etTGOfr86awS13f86bG9mHhgqIrkV+7DtGXlAAI3NAIH1ileMYJVJy+ID7482p2IVtq40SHG3R2mQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 04/47] gpio: tegra: Move driver registration to
 subsys_init level
Thread-Topic: [PATCH AUTOSEL 4.4 04/47] gpio: tegra: Move driver registration
 to subsys_init level
Thread-Index: AQHUQr8M0Masre2l3k6QjPlUC3lXfQ==
Date:   Sun, 2 Sep 2018 13:15:42 +0000
Message-ID: <20180902131533.184092-4-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:oJv5PMj3kqmokd4aBJAZDjlZQ9tsGb9SNfX68Gp4+w5NNfHgYH552f6c9MJehxxcpbYABv6T7vtGNq7G+u4efZuIZlY38eBanEDwZ/HwCXl3fJVI9ebp/dMXZJS7+XDZD6qxQxivr8QYUl9NFNb+myxH6lsWefYLShLoWDJUyCqcpZEJkLvr9JrVJHdz0RmcMkH7zRqPliyvAX0SHCOewq9aYnEyWV5ldfFt4jonJHxGb9ZBs4FTpgkQKbwQ8yE9VGdDnZMd14OyyRJWmq5avJh5Bi1DwO3yGGOe5WiCQnw+c/dG5dwwZlBZyQemlldxTtogADTcXvei+R7DWpGM5orDiCwTg6FWC4CLe1rsU89P2S4MSsJJYhf222bzndQT4Br7sDd2dS4Bh/EG7zPk1YU0ljsB8ecjUqdTO2j3MffuwNdnl/u9M4/01l20i5/hph+t/FNpSz5j1fL8+rueYQ==;5:agdIj5MRVOjcpKGKajO06n+oywK7Ze4UamoYkQXf/FdQxS6vuE9sRMOZ/HduGh9itv+Pig+Wh8ubzV3OOb6tohe1IVHWPQfvQPqBV8H/Y+fZO5l6OLc+Qlz7uRkvnhGOp+sSzkCYYx5oAxJhx2f6YH3Tsy859HClOoxlOGsfjpo=;7:6hUN58n6Rc0CRjnGX8+B0tiN10JOL7bTxxMvrzxIuAuqZBhppMi4oPW77H6OaMy0TJdWqP0Ii0hdLlZR2DIfQGfoSpkwyk4nEFeI4M15JFq8+2UjytOVsJGmx5ixDNLQNXYnAyBQIdkEjh2llIHyQuvMe58WVvWYw8HI64kbqfx2s3gks8v07+tiUbp56pGsMGS+J+WUzd3WHnhDds783eVG2L6J7S5AV0nVRhANoDW/ppavYyEwt+8p4ZXeLv/1
x-ms-office365-filtering-correlation-id: 60ad5222-2b37-4d3f-59dc-08d610d62f56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184287BDB12692E4D0F5C6CFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(575784001)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(39060400002)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b1IBaekjFNQwV/NXczsyI2fvZiGwxhp/5R+jpdj0pj22RTRG3xjj7uobLjMWYEHM2URdfw2shjA2H0QhbVTebYdH3KlCCdFzehNODi3+lhqksb9NBD8aIRSOEAyKwN3lxHPOIIu7gtR+b9LQXiKp12OG7a1Yulm/imJR/G7TgBpCmdsuYCgPD87c7LhJE7+olZuaGd73W+Grvqo7fP0fIc/ShV6mEEdt7PMYvp81nhJJ+d5yOlOoYim92hbmF4JT+Ki2LyDL7dYQFGvAeDdKhVTNLM0mYU034VX9zr+zdva3kSpyochvaGiFUQqUziCgMbN0cTFItA1nJiSPmkR0TjY8JvRkUZcnvvKr1blH+NM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ad5222-2b37-4d3f-59dc-08d610d62f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:42.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 896bf29776b0..fb2c1df4f588 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -591,4 +591,4 @@ static int __init tegra_gpio_init(void)
 {
 	return platform_driver_register(&tegra_gpio_driver);
 }
-postcore_initcall(tegra_gpio_init);
+subsys_initcall(tegra_gpio_init);
--=20
2.17.1
