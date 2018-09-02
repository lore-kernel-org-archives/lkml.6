Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE05AC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9073820841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zv7GQRzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9073820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeIBRTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:03 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:46915
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbeIBRTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+KEywYQkB6QXO7q6iKk2p1rXOgMUcoOphVPtf62Qa0=;
 b=Zv7GQRzwHRjCjgbSePNu+Kdujq4q4L+EMfO24OIQVegHK/3sLJi1DNZmXNSBIhn0sd7fNmPkEVjV6Lrwc91Z3xmfIVrYxgLbhgdIapkGxE16gG9jd9oji02bFfsGOUOHDkD7S27779FwX/s0Sx3DuZnXmXN8QvNmnEef/2CzPQs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 014/131] media: dw2102: Fix memleak on sequence
 of probes
Thread-Topic: [PATCH AUTOSEL 4.18 014/131] media: dw2102: Fix memleak on
 sequence of probes
Thread-Index: AQHUQr1Q/TbXQWvQ8UiB5zVvVxKc3g==
Date:   Sun, 2 Sep 2018 13:03:15 +0000
Message-ID: <20180902064601.183036-14-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:29rvGt3PLENTOQHzcthiJcN+bX2oRshtRM0b1inF3wzHiriSD6S32ryGOtZkX92cnRAOPxtf4qsF5e+NhW0IQ63+mDnhxA9GZ4dKb1LOC+KulSa38h+w0gpwm0ymELXKdjmSlGqeoypZ7loA4LN/NN6URTCw67oa6KAXMJhX/gUuy8AOJxANSGrTohgE77fr45FQLMQSi1VfTNERxDAsBw5pLFQRCWXpzprsTEy8HkU8FN7ikMLuFry9gIov34GwVZ8NqFY0YP5Ue2Gr2FOadHhW2Ua5ShXhGytnQ4H6Yp1Xa1hVsRrc/6WL5ILbLbBll9o9JqbPw03g/qbEtqmEIDpar2ocpD16ZdeXponZZ2FW45BgHAZh8P+cVCt5410/3c5e3WkOHWiXBndx1xlWMopcwdacgBsTi++BP+mDDRVGeTnL20s1+fYYW7vDvmJdxMPQFDulprzcQzlJoHarVg==;5:fgmS5IGy/tHoZEH1Dusn/H1lrLm/TeAqr/sBoA6BXHDleNdlfuF4N6Uq98MEmrMLSlJOaphygVS+nCR8Tx1hQ3+7Ta442gIf+6sOedmSdOleArsTPdrYPuTCAx3+KwHrNjyBtoIPSOnxG7mPT0ZASHHVcKh3qjViJAzqTzi6zzI=;7:FHczPjUMuTZUJ50nAqCvJx4p13ty7ZFAwzR2QNJCVrHrVap+FJfPXJpdLOtJ303brxHo2yC0wkHwNC/I8v2WFH2scNGMSnJG22gYH0CbxWnzPRKw2iUEP1KO4bASqqgfWZ5FtyqAEMEGgH/XeNXwnz2RV0PPgPFPgI4IiGTbRbzTHEmGLZZNZyVq3TwqflBPOc8C476Xsb/Xjmb3u3d/vRyMlsUIMKzLPs9cQWefytPb7DCbm83bFgrl2cNofhqG
x-ms-office365-filtering-correlation-id: 787b7083-bbc0-424f-7980-08d610d472b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB01501A73107F6A9CBE229D1EFB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(4477795004)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: VVZ3lzVm7xlpsCIav5GPb8cf5ctAgmoveXNyXQLt7Gqbf9Jo9B4UQzWQmXh2spEDc5+EBTAydJ9wUrV59hrTW7sBAmV0zCLVtSDQE4bc5F/gJMpD2MUUz4r44Qvp58m68HhphC7OwJT0mVE232rlrUXgjmrnUtFjNk6AbF41P/3JPszbzOEVJd6RKepbaniIijd+45OOXQTPurJzywBlgwMI0dijfapqM3W13uPPf3/U1XdvAsOTHvF0Jyn4dxFQodX53bL90PjnjEATfU9i/IKsAVFzMf2mj/qZRFnp1XI7O8M1xcCkJ8xL7Tn8+aZs2QhnwD2jfuCrNrYg+NAcs2SMNMlAHDjmtPF5fd8MqQc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787b7083-bbc0-424f-7980-08d610d472b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:16.0796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
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
index 0d4fdd34a710..9ce8b4d79d1f 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -2101,14 +2101,12 @@ static struct dvb_usb_device_properties s6x0_proper=
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
@@ -2127,14 +2125,12 @@ static const struct dvb_usb_device_description d480=
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
@@ -2334,6 +2330,11 @@ static int dw2102_probe(struct usb_interface *intf,
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
@@ -2402,8 +2403,16 @@ static int dw2102_probe(struct usb_interface *intf,
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
