Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D58C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22ED620837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kWvLF4R+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22ED620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbeIBRim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:38:42 -0400
Received: from mail-co1nam03on0097.outbound.protection.outlook.com ([104.47.40.97]:50844
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729895AbeIBRan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55tst6ufJRzQcCHbgIxoSHLNlNWkpXyAitrJZXKsSjw=;
 b=kWvLF4R+yaPOa8s+iKIC3fi8Tbtb8pRZe7Zj7Y89IjQS9hpVeMOt7Kmz671mD3aGXN/Jfq80zHBwxWszOH95JtTtUSBt2q8ReL/uUbsxmL5FvwpblOxLp5LQKxLTPVsggECivnunNcU+fgdhkDgoRmdBn8cmf3NiKGdluk+xdw8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 29/62] gpio: ml-ioh: Fix buffer underwrite on
 probe error path
Thread-Topic: [PATCH AUTOSEL 4.9 29/62] gpio: ml-ioh: Fix buffer underwrite on
 probe error path
Thread-Index: AQHUQr7oM/Jf9eOBHk+WSlqwqC42PA==
Date:   Sun, 2 Sep 2018 13:14:40 +0000
Message-ID: <20180902131411.183978-19-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:qSqrnIBpCsODAC2Hpow+qoe2+Bcpf2qFEDboI68uWkWXqUKY5+qtxU5rMljNAJ2MBZHjjJtSFFwrtTdcg898fLNAkNAfjGIGekITUsLEpPYEl1+gqCp8ym+P6yjc9gcrKcBkR6d6/KOC0Hm+25kvA+jL7S8B1ixPAPm1VhaYRtEb+PbZV8RRkQIhuYW7EuDZfOvkOXt/O6oMk/JQoL2TKB6cRpT2EOyY82GrxEqVBoNg2sLopGFwBvUtMZQnPG8STCeNo4MR6JgyKtHYzd+8cRwU7+OO/HtZLgs/d9ke7JHKsd+m46SlznHM+LqDnlUTPPyZkVce5Nb2BZPwWVTiwyzJfWbO0GJKImPxKg9LZnO/i5Wqm+XV7PZbgFX2Y3QCNpo5s7pa5OyRCHLGxfby841qHilOEYGY55Fo8aMO5Xhfp2hYX3HrlD6Fw5YNVeJt6SMY7fB/F3E9x2BenHd9rQ==;5:aPxVSHkuGPbgCgre1g5HmAPxxJOyrhd6c81LfzUJ7bLDvrlks3iWfyuft3Cw6v/q1LAn3ea7fx4kbfJhadwzTy322ICbdYMjXcBWlujvQ+WAH+XgWj49pVLhYF3iAtCnnpCmcpu74cLBSGJ04iEZ9e+YENp3nrJpUdcQxGJnZ/I=;7:2dO4NmBqpuQp6PKUkuRsb7zuZ5U+h15wEq4BQGWRXWbeZ1v9fJXLCC3IqJUkX08VxN7iXJv1ZtB6syA9/zKOHX0psQzhNZ0ZffDfXo+/6N3Ka1RE2XTKBwCUsoMrKzieAB33NeG8BFEGcIpGDjyX6arJ0erH3/InpLpd8hTNGzUR9DY/MmORHM1wQvHhI9eftR2yh5fM44YX7z8xkDTbRitEXpIAAP+71586FWMJKVVM3zy5MPcO9B+yv76AXYHr
x-ms-office365-filtering-correlation-id: 25f91c45-3bd4-4586-a0b7-08d610d60ac3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120AF911EE2A43B63196B65FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(4477795004)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1FN92W+avW+hVqsjgUz7mtQDfq2iml0kjfSg/4gkByYV+989tKmYzs1Az/DmGuvX2VVPGT+J48L44yICv1NzQu2JTw3pMJt0ifyzrvj0JryBl35ow3gsPEbbPDp4o3xZzLDs1lREQ0lrW0HVSW7dqWAXC49wLeIQNPdKDyOkbuEB7xA7m3khtKoyqAW5MenYseePEj8D6biT11Hb/VTq/gViQArsD4oTtfNJFuVYazVH9+x0jLXjmGOhDtDUIgyAkKOiawoAPuSyE1aF0eWkWkh344WuyXXXOvgdgUujPeDPXcHaM3JrMVN/nROn7piB6PH7rr+ye22MIFYH15HWqlfjbo/Suznan58EQAgERII=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f91c45-3bd4-4586-a0b7-08d610d60ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:40.7661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 4bf4eed44bfe288f459496eaf38089502ef91a79 ]

If ioh_gpio_probe() fails on devm_irq_alloc_descs() then chip may point
to any element of chip_save array, so reverse iteration from pointer chip
may become chip_save[-1] and gpiochip_remove() will operate with wrong
memory.

The patch fix the error path of ioh_gpio_probe() to correctly bypass
chip_save array.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-ml-ioh.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index 796a5a4bc4f5..e9b607417df9 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -495,9 +495,10 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
=20
 	chip =3D chip_save;
 err_gpiochip_add:
+	chip =3D chip_save;
 	while (--i >=3D 0) {
-		chip--;
 		gpiochip_remove(&chip->gpio);
+		chip++;
 	}
 	kfree(chip_save);
=20
--=20
2.17.1
