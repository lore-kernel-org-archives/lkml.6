Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5067DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0095B205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kSgQptbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0095B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbeIBRYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:46 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:56192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727733AbeIBRYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcF3Llrsxz5f28HNOdTtNZ/iqUmcoJRHc4OAcn4s418=;
 b=kSgQptbkd2Xh+oGQhM1L2VChchNI/pZvjq5kAkNjyCxyuo/y3naMPfEMdW7L4w3R2tGDc7VogQ44QQWdQPvykcBUYKFatZjdWN5TgKYArgq7gs/RPFGWC5beu6EjXxnFH3zlaYa9Z0ncPVWLWdogXPMKT4cj5Asn47/6qkEF9f4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 04/62] gpio: tegra: Move driver registration to
 subsys_init level
Thread-Topic: [PATCH AUTOSEL 4.9 04/62] gpio: tegra: Move driver registration
 to subsys_init level
Thread-Index: AQHUQr4PYE3TlydWxEW1imTrnPUcAw==
Date:   Sun, 2 Sep 2018 13:08:37 +0000
Message-ID: <20180902065131.183542-4-alexander.levin@microsoft.com>
References: <20180902065131.183542-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902065131.183542-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:umK/lET+kZmAHsjVV+7yofRxKiVLuCPReEleE2k1Zj3H2ihKbby2IzpVGIBY0J1dFkqiI5Usc2ACnaYfqiq2Y2hsz9nrsxhvuJc9VW4p7zOHUNfJ6v+PH6BKzfV7EA3N9UOathJzEf1D46BdO2TmFZjQKJ7wKPAr3QstVY+UZU71bOIMkIM6WL69cGASsvQ7tTV7Jx7cFjJEvf+z1Th6XtVhHgQhQ/Vw/q9UgkSqiycPk8f1Byrp7j76OdUo26fy4dLTp/zLDCzR6PkNywJ128Ka2YkO0Kk37BAZvBbU+jWdbL/lW5OESioNSlAFn9GUUM3igU1C6oRhp5bESXKT7HUpIYaiIIbRmVfP3+o4xt65nCEGGzH89kJGog1r54U0L5QQiYMaI2mvIn+BrhYwpUVN3A9QOaFyi2ADYJdg3F1Hx8w+4Cu+WJMr6l6qkf4OSl/7rOLRaSFIqm2HpbkYzQ==;5:cpgKqkspSN3RzERkI+zVYBu36VlKqer7U5Ddmcc0kwJJgN7C3OFCcqRoAYEYqKx2RL36ZaKoDwQiDZQHi/CCvEaS9A2mMj0lLBb+FvMXLKqntJg7l7SsWlx2KEsChHGGThwFcQTzX6EdxaTv3xc2KX89fkACTsDQZxY/NRx67AA=;7:Kh9Lc2QLwyyZ94+lQYs63ZxTnqTKLMJfzXzIDMxMVRivp3sp1zPSuLRcaQkknJicfbNJPaRMIvM+GnPLEEsDCRlHJdDUkNZWAdFekBfaBrxCsx+nHIls2DIdWn7qZfPc3h6za1wTnA20OdaLOCw+r8Novb7opxtcJB0ZcAV7jYsdk60sPVzlE0CjE3vloYozNpKAsUgyntn3I283QldyA1MjZis1Yc0sVB87hR1s4qio0Vzsn2hHei9O1riEYHPa
x-ms-office365-filtering-correlation-id: 8394d82e-7f3f-4c5e-361d-08d610d53c33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04699C760C84F147E46A63D4FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(39060400002)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(575784001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6mVLy8tjzaujJxyKjG8Qjprr5MlcMD9GnpPYO2+7DNZaCVmIU1L4QhblJWvtc7z767AZOnh7Y190a7w9OuUmAxbw3RduPQVdXgOZHTMwRkiW7+2OxxxbWw525tdhWc8XJuIlb/sr6OfGgesVQLwL2F6vn9YrHPj+mSyiq7gB9dQhVJE+0Ftjaj6F3G2JwfWFHmIvemb7CE8U43b7NQLF3u0I9uDhXt3WucW9iRFDfich+khYqec3+LVflSWIReDlVIXtifN2opLYgffTJ+4wwG9JjKevFcQgNj4V1w0gN8mJleUYIZXhzE526A0QJ3vT+fEwUokppy81Rx2C0R5wIdTYM+txa+YXEOqzwP5lQkA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8394d82e-7f3f-4c5e-361d-08d610d53c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:37.3625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 661b0e34e067..05d3241ad20b 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -723,4 +723,4 @@ static int __init tegra_gpio_init(void)
 {
 	return platform_driver_register(&tegra_gpio_driver);
 }
-postcore_initcall(tegra_gpio_init);
+subsys_initcall(tegra_gpio_init);
--=20
2.17.1
