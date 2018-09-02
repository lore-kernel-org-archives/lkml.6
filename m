Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2202EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEC820837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="U2SHGkzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEC820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbeIBRmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:42:04 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:51200
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727463AbeIBRWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGoyUJM1x1pK7s5UaOsJyqazqfUQwMLTKfqGKujqUNU=;
 b=U2SHGkzK0/elssdphjyEFVAhbq/reX9tcmPYCGDfxFcygDksY6tjF1mhnQnOFABM41v9Ct/eBuS5Kq/j0GmXQYpiVYYFMAOMo6Vka1d/UhQZA2UIVFOvvs+kJ0hR/CyYHXX12hujj4vsJwtN1r7ifOHL4c3MNqSyssL0V6n1KmA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 10/89] media: dw2102: Fix memleak on sequence of
 probes
Thread-Topic: [PATCH AUTOSEL 4.14 10/89] media: dw2102: Fix memleak on
 sequence of probes
Thread-Index: AQHUQr2+cPgdSFjCVEuSDmDd8CskyA==
Date:   Sun, 2 Sep 2018 13:06:21 +0000
Message-ID: <20180902064918.183387-10-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:aCOHx/GRW/5JWue/Cu1s1+kVYm6GfBVCoQbVzalyddTCZpI1U4r8reBG8Wt4JqvDfTcQNUan39zMJ+RBo56kfs8cH+1h/+ao494s2HuWgLzjYllgFjYU2ynh0MMoeYAU9XwD8oLaX1e98ycwRW4iZHsgEOIrEibAMLQQEcw/FeeBcjFS6TrZmcr2iw8Ho5hCoxWm0gJkkrSQxU1k/xtrQ8YAPsS3xWPntY8FSxT5j4fFgAOeO7YIYTOrskQ4drJkRXmeX8hAIx7RO7bwleHqu7dU9ODsi9dlfGlwG6vLv/CMvKvtvzPGA9BhcdniIayxhOI5I4b22TqKf9fZY6620zd9jrKZ4qLoMwslZklI2M5mo2ckt5lYe1BKGHRLm8vGgz3aKbcp0WNWqk93fDTtx4jZlTNgkX6DSpLfAkVRd6ppD89HAeRURzXuIowZ/iP6Wi5h9Abb1l+0KAT2mYdTOA==;5:K26OEjb+2HblWvpJRbL6E3EzmwaZwsZ7Rj0cWbz5fmOXQBxKcdeZEUcyMZLsCHGvLq6ssCjO8Tup8VQlgcOh7BRvTAHVhz/T6TNbkRlQivZHtIg+mEb7qoQYZWfdpeE0WJa4OdgDFBk/mfm2CEKIiu/UIsQSeiL5nhKj7jYW5pk=;7:azA0wpOMyo6T1vBs+9MpK+0BRnRvqHoOggdvOfLWO8ya+0Jlftppk3agdGTPyeq9XpmpLxXJSdNqQx7xOliFlm5wzRwYruXd4ql529DQcvzXWtXfWtBVZ9M5HNJWcJ3axX5Hyd80msAF6cEISccr5vu+VvUwszOjDSfgD5X02YSqYBIEgxmOIj745j84Q9Czi67TgMsgXLc4gtrAvrzmiD5yEW5LMDLwxaKhcYN38MmjcSiy+cwmERTzSPICHx7e
x-ms-office365-filtering-correlation-id: a5eb26e8-e240-44c1-d04f-08d610d4e272
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822DEEA7263509006429F05FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(7736002)(4477795004)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: NZ3Dp2V8+1SHu7xElNk7KtUwyJ7btMmdrrJf3LBp7ZI62L3Em44iDdRl6feAoGVVV61C0vFVc9U8sSsnnx7b1dKs3tl6yAuvf3iF5Skq6nzMDnbyDWqvMzPVLya7CfqPqxx2wnk5dY0BdKRVA5zRTG/xc0vXsw8A9MhNGs7tlEZJ0XmNoX7FjyV4Mbm0+eJ56TO1Bfcj525SD7m0ek1onF4mwuSRAWIZS4FD5MMXXPmB6EjZ5Zi9MBjFy8sqnbCBgPgKATYZVrBaQ/FFlzNGPVr3n19q4mSYKPwt661Q8rACaMvJQbdOOLlvpYfLAdpwGl4LzB/4yqFWeF1DS2e3HK/EOTLhwXr2qq2EgpxCvKo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eb26e8-e240-44c1-d04f-08d610d4e272
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:21.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 299c7007e93645067e1d2743f4e50156de78c4ff ]

Each call to dw2102_probe() allocates memory by kmemdup for structures
p1100, s660, p7500 and s421, but there is no their deallocation.
dvb_usb_device_init() copies the corresponding structure into
dvb_usb_device->props, so there is no use of original structure after
dvb_usb_device_init().

The patch moves structures from global scope to local and adds their
deallocation.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/dvb-usb/dw2102.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb=
/dw2102.c
index b421329b21fa..3d09e1c87921 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -2103,14 +2103,12 @@ static struct dvb_usb_device_properties s6x0_proper=
ties =3D {
 	}
 };
=20
-static struct dvb_usb_device_properties *p1100;
 static const struct dvb_usb_device_description d1100 =3D {
 	"Prof 1100 USB ",
 	{&dw2102_table[PROF_1100], NULL},
 	{NULL},
 };
=20
-static struct dvb_usb_device_properties *s660;
 static const struct dvb_usb_device_description d660 =3D {
 	"TeVii S660 USB",
 	{&dw2102_table[TEVII_S660], NULL},
@@ -2129,14 +2127,12 @@ static const struct dvb_usb_device_description d480=
_2 =3D {
 	{NULL},
 };
=20
-static struct dvb_usb_device_properties *p7500;
 static const struct dvb_usb_device_description d7500 =3D {
 	"Prof 7500 USB DVB-S2",
 	{&dw2102_table[PROF_7500], NULL},
 	{NULL},
 };
=20
-static struct dvb_usb_device_properties *s421;
 static const struct dvb_usb_device_description d421 =3D {
 	"TeVii S421 PCI",
 	{&dw2102_table[TEVII_S421], NULL},
@@ -2336,6 +2332,11 @@ static int dw2102_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
 	int retval =3D -ENOMEM;
+	struct dvb_usb_device_properties *p1100;
+	struct dvb_usb_device_properties *s660;
+	struct dvb_usb_device_properties *p7500;
+	struct dvb_usb_device_properties *s421;
+
 	p1100 =3D kmemdup(&s6x0_properties,
 			sizeof(struct dvb_usb_device_properties), GFP_KERNEL);
 	if (!p1100)
@@ -2404,8 +2405,16 @@ static int dw2102_probe(struct usb_interface *intf,
 	    0 =3D=3D dvb_usb_device_init(intf, &t220_properties,
 			 THIS_MODULE, NULL, adapter_nr) ||
 	    0 =3D=3D dvb_usb_device_init(intf, &tt_s2_4600_properties,
-			 THIS_MODULE, NULL, adapter_nr))
+			 THIS_MODULE, NULL, adapter_nr)) {
+
+		/* clean up copied properties */
+		kfree(s421);
+		kfree(p7500);
+		kfree(s660);
+		kfree(p1100);
+
 		return 0;
+	}
=20
 	retval =3D -ENODEV;
 	kfree(s421);
--=20
2.17.1
