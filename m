Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D086ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5B3208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QLgIfLIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5B3208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeIOGsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:47 -0400
Received: from mail-dm3nam03on0137.outbound.protection.outlook.com ([104.47.41.137]:63496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727866AbeIOGsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omP78XmogYx+jUik7AlqLd4jzXr8TOdLO6jRHBeEV7Q=;
 b=QLgIfLIf//TtJ+EfSAXxwVK5hncSqV0pgsoJgCrPmoSFfEEjosD2eHSGcbghCaiwKo+9SLCfzwQxKYA/ALmU4Z1EumsD/pidDw2eD4iD3PI4+3jXwp/ZeC/WqSshcC+kghzZPxeuNx2zXGs7jCR0HDAkhLGKNBdoI3WaOIeGXu4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:31:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 89/92] gpiolib: Respect error code of
 ->get_direction()
Thread-Topic: [PATCH AUTOSEL 4.18 89/92] gpiolib: Respect error code of
 ->get_direction()
Thread-Index: AQHUTJPAHI6YaVvUyEeXGCS0mATfVA==
Date:   Sat, 15 Sep 2018 01:30:56 +0000
Message-ID: <20180915012944.179481-88-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:HRwocJLigu7DqrZaLV0BRrgXooHI9Z/uWIdEGsl7Apw+2EEyVTfts+0Yw8mtJK0ePeBUxpWBnYv//kMHxmoS/kSGIXq0LiPKYW6CD+VX/SkHQfp72ndu0S1kZv1DIi2TIAcbhZjozqH4+c8491jGvJmLK5A7n30xwhlfa7uC6UCpJ+pt0eHPlLw7Pd3/g6PejkAkw2et0a/QVEjPtGxupsV0cdiApw/7QtoMFZ0P+4jQQ8vnXcrEFloDVqvO+Q37LIOPHNfXbAlks9R4MFBYjnCa+qigN0D3o05ombvuOGYNsasimgzDkrW3+SYQgi5VYezcM3bEa3S4JAD0wYCLRbL6F6SBZeI9cDPaevMb5lmXxUZzVZfSQYzHlwd1umIrAhrQN8RvFuvojK5DRf7f2OQhxPazPdHAiBy66xRUE8REm2FLl1EfeORPTGBxsYbZVsuVTrI71YaGpknoqoZF9Q==;5:dHQzatS2Y+K131RnIPn3j79ulmAM1vFiAjm4Bs9tJatNgE3n4F7ExD/8E4zAJAUv7X7ZkDn8RaZJuQHFyZNgMVhACV6ZaG7CsNAd97V9MKcE6sdbRe1CcX+1KjcLN5ke4IOloPVbN+mKevCpnk5PN0EX73DFVAWyX+iV9P/Ap7Q=;7:P7p1/OkKM1BnbQX+Tqww4coINl5rlinsjgk50fy4ml3nWdT3guhLeBQEzaCvmICCH9MeerY6AqNyIftSKcRk0RW29IrG0z+ohfLL+hJwIq5vWyU+in2m0mHSAScvAd8a++tqdKXGtYGAN6rB0QguN/Y36TOBOfSoLnRjtaP89TvD1HLbL02d0vvYqAp7+M/u6WWYh0GAvhkDSF7NRvtHkLM7dJDOnV04SDc8z+d5CS2+fiLGGGWcVGaYdu8/kDuF
x-ms-office365-filtering-correlation-id: b205106f-21c3-4c46-9fb0-08d61aaafdbe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0117858ADE99C0F6BBC6EDA0FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(6666003)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xDiUG5ghO8J9TdOuj8qmlt2mUmk50X11Gnd03gs1zRMxMkvX/34a8R2bjAjvT1jvr7C3VI9az/cq9JSnXPfvrJBFrH4ZoQsiqEnaeroAtTVpDRqzapUbxGk82GRHJ3YllgqssKuQ6xYb7ZJRo3oHygmLmcemID8nn3rT1k3kPdgmi6pi5T8U7JZnHj0vaLrNBt9dWPkpuCr4/Iy24PvY6qARWL9tUCmNseTnxm3X6fKAC929puzLSMYBPTN4g6zDMjas7mQrpdy0wXVkFS1hzTyPr0z4c0/lnAxI/dUByV30Utrtuy2Y2CDGoTri85m0kAQEYGRprtGKI5aaaJ8TbafVhorHDh7L1unSREqzclo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b205106f-21c3-4c46-9fb0-08d61aaafdbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:56.9322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 36b312792b97933dc07abe074f50941199bd357c ]

In case we try to lock GPIO pin as IRQ when something going wrong
we print a misleading message.

Correct this by checking an error code from ->get_direction() in
gpiochip_lock_as_irq() and printing a corresponding message.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 57973524360d..cdc6e2a8f063 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3257,6 +3257,12 @@ int gpiochip_lock_as_irq(struct gpio_chip *chip, uns=
igned int offset)
 	if (!chip->can_sleep && chip->get_direction) {
 		int dir =3D chip->get_direction(chip, offset);
=20
+		if (dir < 0) {
+			chip_err(chip, "%s: cannot get GPIO direction\n",
+				 __func__);
+			return dir;
+		}
+
 		if (dir)
 			clear_bit(FLAG_IS_OUT, &desc->flags);
 		else
--=20
2.17.1
