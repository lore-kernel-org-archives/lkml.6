Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746BAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CD120C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c+07oUQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CD120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbeIXVCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:02:02 -0400
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:17577
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387805AbeIXUwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T28En4+8RHjuq0L6T5+1TezGNbEU2Kc13mEaLG1mzM=;
 b=c+07oUQgPzw13Lv3VR1PTB3jaUdXJejxt2DpnyXFj4lnLfYtoU0WrRHyhWe/nlbHY4r/lgAZ9f1PEnWgORkp1vqeB9PN9bJAs7dAys5eHvKC3rKIr/lai7l4ks5RN3LAg38H7GYY6L5Qmy00GDC1UZUHEBOsCyO8Hs5xr3JR7uk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 11/36] gpiolib: acpi: Switch to cansleep version
 of GPIO library call
Thread-Topic: [PATCH AUTOSEL 4.14 11/36] gpiolib: acpi: Switch to cansleep
 version of GPIO library call
Thread-Index: AQHUVBW6gB0lhUNkfE6zkfnMB8gC9g==
Date:   Mon, 24 Sep 2018 14:49:00 +0000
Message-ID: <20180924144851.164533-11-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:ExBttPeORADp/77HPZV0ClWCGcB9BV69aBNfE07ZdZF2fYwvBnvXMWzt/VCEo28sW2+kWqVoNESFfEk+EYfJcwtSjKxfeHn0DhcEFR6MV54JKJcy+eJQWMvoEeJf/2mwenUvNN4lnX0G1OF0m1HCVfYhjQ/3A+8eVT5qAOXYumx5wpK0QitWqiPxkn1pyqyZiKJWkx+KAxvDfT6Z2fk65TVj80SrgJD16wsdtjNawIhVm5WCL/bG+NigRTYnJ6VAYJW3zB6UzKJ489OxOq4ho1pu39I7512xbcUpkGBB6BWngMqHegNmU2dXYLtPtvnc82ZH/x0Vcnkuq3g8hWFCQg0dq6PEctO78G007kaZFmDGjkjzFpMEnyoUDaerVTekfgDDnZ1it0zYHqRyElGuPgx/grTn6Dkzsv0uXXTJkQOlfUxn/xcAsxnJgVvkpD2zbeOF2CfOuJSXBuT7QFvtaQ==;5:ilEZw4OOfQr6ZSDm2ZpOgJZpKbXfvNsTMcdw5+Gr4jWY/6q78VMvrnKdVL+0IYd6hDeI3AIzc1KNbMoouYbjCDTZkyrZMWAcEEq1FuumlwYAE3nTy6+chq2RqWFbH5ddPPdGk1d6nph6NDQqxJeszqyENqvW9XOBHWFXPms1SE0=;7:thWidEsN6tfYx4AsQOxDwNCqEJ7GyYNgDIk7qUBS4SaUl3Dk9O6izPV7sV6ZBWjTER3aE4eBkUWr4JCpBwb8C0EfK0IFJac+Uaj7ycUPpj+7EWCNrLjIrxcL63kNl26FVsN9k7984R4VOahyyw2Tgoxa9nnmqjUow6DAuIWxqQ0hIXPVggPbCp8jIWucdTGs1MFeru3wgjMZXZJMJE0UXO91aCIDOoA+pFARhPJXx6oTZgA7jSvwHJyibu5ePY/Q
x-ms-office365-filtering-correlation-id: e5a3a6da-7639-4696-1fdf-08d6222cf69d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018143E610DAEB02BB9C7B10FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(2280196)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZJm1KYsAmqIRILLT3mql190XLYXZW4Uu1lrCP/99Hybd1zB2ZqalBykL23zO0wqbya7FmImUPWINOhDFnEpjVdeT5gzimXldN68W7qWy2J35vNO9NZeZ8jsR5gACP1xWffMjToWqgxTzzMUU8glqlT+b+fAYLvpgpwsy3QpzqdyEVjFBeQ+XhyDCP9xeB9yVudO7nKzHngR03ogMsqh+rsEYd4N3Bn4ZlMNhdjuDThwBMkXW1eUc2N25LVwcUs96cJMwzhM7RHEucgBes0cOHXa1g9OQne2l5QXP4WS8zf0vsxIM6z3e0Ikmtcklc4Lia0u5OdFcTfYrsaHq9+oCUBImiU5HThYkCfmloQAksWOERrcHGVEfY5hBqdjw9fZg5EWibdphBk5fTzXTGOkheus1zSg3KXwrwWjbzc/7uNamaH78XpDwJqkt6Gcdlu3ENZ2V4h7L9tHi9qJkLLcV6sN++yr41J2GntZoNG0W0YPKI33IoToh2oMjExBQSD5s5tRlo8xTn5j1QGBOaqgxXR5cX+MQbYdD46G+oIW0Xn7kpRhrmK6xZxwizA2j7nNE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a3a6da-7639-4696-1fdf-08d6222cf69d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:00.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 993b9bc5c47fda86f8ab4e53d68c6fea5ff2764a ]

The commit ca876c7483b6

  ("gpiolib-acpi: make sure we trigger edge events at least once on boot")

added a initial value check for pin which is about to be locked as IRQ.
Unfortunately, not all GPIO drivers can do that atomically. Thus,
switch to cansleep version of the call. Otherwise we have a warning:

...
  WARNING: CPU: 2 PID: 1408 at drivers/gpio/gpiolib.c:2883 gpiod_get_value+=
0x46/0x50
...
  RIP: 0010:gpiod_get_value+0x46/0x50
...

The change tested on Intel Broxton with Whiskey Cove PMIC GPIO controller.

Fixes: ca876c7483b6 ("gpiolib-acpi: make sure we trigger edge events at lea=
st once on boot")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 70b3c556f6cf..582dde355bde 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -247,7 +247,7 @@ static acpi_status acpi_gpiochip_request_interrupt(stru=
ct acpi_resource *ares,
=20
 	gpiod_direction_input(desc);
=20
-	value =3D gpiod_get_value(desc);
+	value =3D gpiod_get_value_cansleep(desc);
=20
 	ret =3D gpiochip_lock_as_irq(chip, pin);
 	if (ret) {
--=20
2.17.1
