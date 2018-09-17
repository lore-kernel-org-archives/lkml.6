Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E859FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB802147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z2+zOiU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB802147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbeIQI3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:49 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:11424
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729399AbeIQI3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=679naag+126c7z/dQRLj/6mxgJkdF4yriw4iP5AS7Ok=;
 b=Z2+zOiU5T/G2eA2xkLmKsabieZ9jf9bEDYbxoX8Bm9M67BEKA0LnRQ49md/r153MGS8H9NnoOArh4+kRxmLsTPxM2BoY2vZnbHFnS7GSMKkQTpSHb6y6ZDjTTtVifejNSkTrMOkauF/9d/l/dFBVSVeiIfgiYJiZnfBjd01QDXw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 58/87] media: tm6000: add error handling for
 dvb_register_adapter
Thread-Topic: [PATCH AUTOSEL 4.14 58/87] media: tm6000: add error handling for
 dvb_register_adapter
Thread-Index: AQHUTjLxg1LBuNjEb0ypBzVbYjHpiQ==
Date:   Mon, 17 Sep 2018 03:03:01 +0000
Message-ID: <20180917030220.245686-58-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:gmEqCWGpjAQXgAnD9to8luDpTxkcJVCocqIhK9QOArTKyk0YdNI6Lav18UhcJ8hcslO8s4+dvN0zYW/yWuG96Yl6ly0kYDREuaAaD/kqkvMweCeXgm6Bn9uwWil2QlAW1KTUGYpld6v3+n4S6BuFKjhSGY08vHvzKaG7IaHpW3PC8YeHjXtlMEO2TOVRdTE2qLH5U5/mtOwzn/bdadX3WZttBKlpBwFi95KCrGFEku4bKNkZSoPYy2OO2mfA/bLueB+5So+VlEx5ZbHvjlpmBsHylClPbriEyfUrZrRrHT1gzO26wa8rWG99fjUoo+ggxX2EbicyM6XzI++ebOtsD408+OHj6l9OwzRCqVAtNw8kUdAPZiYH+cRRp1MGRzlT9ySO+ADtXORZVbAs4LtpY4lqwVw3Nt79iDJkonrZvAS6tbO2r8MjkSvdsG/eS1iVp+GVBphN8QB4xJZKT+IMuw==;5:iWAIDNSPWbeq61W5SY7TigXcyPEgJ16+SucKLsRiyfxRndrp5VsvkNQ6mRAI1fnVB3+obRxS2ryX6qLRxRbZNpWexrg/9irJPWi3FJvoRZtUgc/x0YmgrB3gn/jLV7kUFLZVrWjgVbJ4PjtjPc/jeXqr6VQ9MGW6PJC7bAubW0Q=;7:hzU3ESwRxcn6fpCTqceat4R10nuFTlwWthIkaKeDVrXWyHiW017meMvKkSBmQLh0uoCcYe4naaIfN9IlukFQuaemEqfQXabsJqUmR+c4RBksxy0b/zc7Vd7GmVC76LMX1tv3pXLbudWPSZvsA3CcpaK2jHU+znMhZUxAU83RcrRDDzfJi86IitfcZfLVG0tcKvKfTY9I0UyNbhpLgT25OmrzR0kbUWxSE2J8KeZV9HnuxvbCBtDFe5L6XUZOJHmC
x-ms-office365-filtering-correlation-id: bbf2e643-362b-49b3-dd8f-08d61c4a451b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774264FC63F4EC41DE2D733FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(39060400002)(6506007)(86612001)(10090500001)(102836004)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ujU4uyKj89h0TI6azg7hxntK4UXfIa3Iy2RPWVSGcu516oXyRPb5i8d8fYMEvNrRG+QXy6NJeETzpQhsvMaYlCEbyx8G+5MWNdYsHf7diCLi2dH2c6BaA0wDYlZLJ58p0FtmItpM09dhw4GnsTcHoReOoJNzPncuFoGyoiGP84OoswJelDFlzYM3Ui0jQ/20w6FUkkWGDM3/coGH7DH3DDkrgYvq+kaLe9tUtfja/Nfuhw1tSBhgCGwBQmoIfoGfQIIUbZ4dOqqkHYwFrmrctgHieWOyRwTBhpXpE27iqOm2S4F6+7BUY/IkcF1VK02m2/3bULn5y65apGoDDSi0OV2GEJeOw4d9yo4M6Aumt/0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf2e643-362b-49b3-dd8f-08d61c4a451b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:01.1966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit e95d7c6eb94c634852eaa5ff4caf3db05b5d2e86 ]

When dvb_register_adapter fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling dvb_register_adapter.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
[hans.verkuil@cisco.com: use pr_err and fix typo: adater -> adapter]
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/tm6000/tm6000-dvb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/tm6000/tm6000-dvb.c b/drivers/media/usb/tm60=
00/tm6000-dvb.c
index 097ac321b7e1..349f578273b6 100644
--- a/drivers/media/usb/tm6000/tm6000-dvb.c
+++ b/drivers/media/usb/tm6000/tm6000-dvb.c
@@ -267,6 +267,11 @@ static int register_dvb(struct tm6000_core *dev)
=20
 	ret =3D dvb_register_adapter(&dvb->adapter, "Trident TVMaster 6000 DVB-T"=
,
 					THIS_MODULE, &dev->udev->dev, adapter_nr);
+	if (ret < 0) {
+		pr_err("tm6000: couldn't register the adapter!\n");
+		goto err;
+	}
+
 	dvb->adapter.priv =3D dev;
=20
 	if (dvb->frontend) {
--=20
2.17.1
