Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0122AC04E83
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5DB20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zahhsa5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5DB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeIBRTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:07 -0400
Received: from mail-eopbgr720097.outbound.protection.outlook.com ([40.107.72.97]:28208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727280AbeIBRTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG4Tbt4d8hjbl3tsiYHYXrF0qxylBSebPvGhph+awds=;
 b=Zahhsa5cDg2whGqYGN70Dm8rr+JnsRHjvleifT1JersktN8V7/ddtK4yZV1vktIDjGwh6DA+YLhUbySKlkQxjk74P94NLNXe0vP8TrwrZEHd7ogqA4LoW4hm6A+gkOkpoktkfP0s6Cs2wz/hDIvyf/zinN9ZAlLGAsT5YKQgouE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 009/131] gpio: tegra: Move driver registration to
 subsys_init level
Thread-Topic: [PATCH AUTOSEL 4.18 009/131] gpio: tegra: Move driver
 registration to subsys_init level
Thread-Index: AQHUQr1LQMjHA0IMkUSYXawyouCvYw==
Date:   Sun, 2 Sep 2018 13:03:08 +0000
Message-ID: <20180902064601.183036-9-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:Uz6Ke7IEMXBJ3cMnb5uwVkA56dHNQtZxbBxFJHeivl1O0WUMBFTgdyQj+WlOOydQcAzBYlX/imvf6GhDTU+11UInAoK75OZMjQAmCVZeqMZ9h0xjJmMw2npimOlaQYOGMOxZ0XeoUllHU9/1Qr8Z6n+eif59gRBsUwR6EBv6uoYMI2ebjiM5qqCQGrQT/yVw13Bur518fOWRl+h+gonZ0R3J1OLoWMi4n4RSxItDqpYJumiTlY08eRc+VGL03YQVmTsKHao8W8xC9SuGKqHasE+ZhwnMFU8tSgtwWGRVLlg9My9OYa+csKLBQ2v55qrqPk5i8scU/OTqs+lIgk2vC3BH1NV1MLgSRik8qEXudaq2W7cRSbrjtcF258ZGgxGHlHzPVkZlSK3EvJAz1FzDQwFIF+G2XZ6pR++AbIR/EM1fp7gahE0mziuVV2M89c0v/uSDgCXPaeZL4xuFK9rvPQ==;5:Lae+Plj04dFsbCOf0CsSlpiS0isuSp0owbO0H6Jkw36kbWJ7Ep2QzrQKmAicekCy1/ELfuCucbj66TrSP6Glhzo16GHSVFYF/iLutrLP1/ByZEACIP+07Xwex/oMn7xB7IWXHdmnk2uj3OFCESB4Tzh4v/dH2hR6v2KdmPQeBFc=;7:/QsIKY7c0r03Vj0VZVfXnaVxIaMVWxuplbjYkXQFxCfnQX7Ndj0vmu/8rEpeATTu+4e69UPaUe2wTwL3FW7BjU34d72N1WOLHPYYIlSHQlVrid+ou9JM6c2qD/4XQbxcD+KzlO1v+ETaVCcTiFnTW2ip6OdFtQxteMrVjiN7UogvNvwcPmCsPPMgZOkOoHagu1NC8u6x3Hvxd7MZU0AgBJCGGWyVN2odS+bDLIzR9MZIHZB0J+X+G8IoqKDcYxLL
x-ms-office365-filtering-correlation-id: 38a71060-463c-4bfc-0113-08d610d46e48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08374A5D086B24796FD9BAC7FB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(14444005)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(39060400002)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(575784001)(36756003)(86362001)(97736004)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RxX5eNBu9TUF3eDD6rL/AskKmNTSwexyu3M6ypYiUrGtOcGVAq6CSppgx4+r5Kh3CaRXALMI00HLjRDcTy0VHPrLVdW8MjK9V+HIWePFP1x4ShyLNTqWvxDNa4XiSFYbEHM7swhrC3SHvG3iG/+e8KoIrnmSN8LVlUSthYNLamtZGOwuZN2JZmFLBDmHD1MhAhf8uyhw2qIOoLTf7m44+IS4Bv0ZoXpI29QZb+4UjuovgvMAvePl3BIYUMkcNSBf+cfNdJOXZIAUvgFMPSo0sENcu4sd9u1ILQzmnGOm9XMLlOztoMWPzCM6W1aN+QqW4oPyz3fqgQPGI+6n9t/jqxQPEquzodfhJBA/DWwo+NA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a71060-463c-4bfc-0113-08d610d46e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:08.6695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
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
index 94396caaca75..d5d79727c55d 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -720,4 +720,4 @@ static int __init tegra_gpio_init(void)
 {
 	return platform_driver_register(&tegra_gpio_driver);
 }
-postcore_initcall(tegra_gpio_init);
+subsys_initcall(tegra_gpio_init);
--=20
2.17.1
