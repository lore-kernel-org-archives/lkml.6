Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B955C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275D02086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kiZbH61G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275D02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJOQSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:18:23 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:24045 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeJOQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:18:23 -0400
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="21244466"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Oct 2018 01:34:07 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 15 Oct 2018 01:34:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfAvf4G31pbiphghC1QwLrzHiXgGtGRd8gQ0jljldi4=;
 b=kiZbH61GTJZCLeHSkJBmhkZJpIFiY6066tXIhYtBwyj+dq7NB1cKcdm+qJTyMmanidN2sxF2SSjPIBgFzWCa7tjz8DhxmCdDE8898y8BMSOVjIOzE+iE7Z0ATgslJEHeH1qXzePVp3cS2mujoZxGiWtjdaRd3Ht8KYhyaC/DNao=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1538.namprd11.prod.outlook.com (10.172.22.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 08:34:05 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::c157:ea7:fc3d:f9a4]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::c157:ea7:fc3d:f9a4%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 08:34:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Cristian.Birsan@microchip.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH] usb: host: ohci-at91: fix request of irq for optional gpio
Thread-Topic: [PATCH] usb: host: ohci-at91: fix request of irq for optional
 gpio
Thread-Index: AQHUZGHU492iK0z130O7y5BmMTMr0g==
Date:   Mon, 15 Oct 2018 08:34:04 +0000
Message-ID: <20181015083344.4157-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::15) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1538;6:WYPzMbTLe6jj0sMFLavwaaakm5oetZykrRT83tHLf/IK8+TeeuxL4kCqMfHUhsI8o+Nk0+vEmQH5f8bmJ1IepKbc3igXMG1sZKNs02RzKIHT+LqfkN1IvF8XA6kxTukSs1rrxHa3cA8JUgzVdmrs17itituHRBj3XGZwG4NC7J6D9BxkA47SB0J4sfJQtWEeEzNounantwvI14qWbj22xa6+5BaM6PUTwUMivViiNuBqYCJfyYRyovS8hD4RruLZSQLkTq49RnvrAuboDl9horUERken6WG5cLborz4aU1mIxRb+P+1u3/qEmKCYx+nBtkuvvsdoIZvcw4HIu1MdcxT+q+AaCd33Z9ihaiOY+exd4s1g9YTqD6Wz1geFGe93emRWpRXYNNM5B1/aLSUJtTScE8R914ZD4oNSjP6YCPONWe5sCmlLU0Y0zUNNssHtnWRYB3E19hzNDq2831cgZg==;5:rQer1DBKLkXzFKL2cJOLfOJWkTLG02koVk7sAG0+ERlW3HvrgO3L7KVN/6dRkmx3zZ221Fikv12rMLYdPEjm0jMM4SBGG9XXYGUTQA6eTIXiGaYRQvreMqjjwwQ+O8DjAubuoKrY9MOseqAnNOlPKCWiv+NkSoL86r0LAkfzDqc=;7:OqVd1fPRRtlltanLta6Uoh2LHjGD5V2iDYTFhax9cTnF5DF7dFYbFeiOqupM8zem9m3h08b44JFaU3r3qqCVTRS6oVGdqp/SFuaEPQn+JuGqXT9zuDdznaPULYl8paiBVgaH788XhRxKRFPUw1QuJVb0B68Mkvx6YwzsAWYWJKL6HDtc5mMfuNAnnaMq1UsQW3Ti/9YZ2+6yQt4jeUPbzpQzXViPrtKjV1cVhxLZPdP4UC17eU3mYRQhVaJCHqbX
x-ms-office365-filtering-correlation-id: 8621d44b-3085-4dd6-dfbd-08d63278f717
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1538;
x-ms-traffictypediagnostic: BN6PR11MB1538:
x-microsoft-antispam-prvs: <BN6PR11MB1538BBBA05C6F9C62FA1D564F0FD0@BN6PR11MB1538.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN6PR11MB1538;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1538;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(107886003)(36756003)(97736004)(1857600001)(53936002)(14454004)(966005)(6512007)(102836004)(6306002)(81156014)(6486002)(8676002)(478600001)(106356001)(2616005)(486006)(2171002)(186003)(26005)(81166006)(476003)(105586002)(7736002)(316002)(305945005)(2906002)(72206003)(8936002)(6436002)(68736007)(71190400001)(71200400001)(25786009)(5250100002)(2501003)(2201001)(6116002)(110136005)(2900100001)(66066001)(14444005)(5660300001)(3846002)(4326008)(1076002)(99286004)(52116002)(256004)(86362001)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1538;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pwpbqqM0xNKiV4LkIquKdqaTwTIE1bwC7GmFHS5yjwUmSVUQCd5xAwpzfhL76QKaMH5rnQXvq1+hu5x5wXdsbEBeM3lv/4mBZql73l3nTTEf30X0eTnzI8wFckn+qt3fqLGw5mgKF4giWA2tI29MJ9Qr0cOj3BfefX3Bv7xHD9Ypun4WTPoozHXVcjnHJIXoMQayGSHhrKAxa3fvfk+GnRIaqBL1Lwk7gcbplHU7S/w73speR6TVyH7MI35Jz1Aw2IZaDqgrQlM7+HGme1qTxUl2EDuybJNxQHhbc3fS7fvY+8iBNPQWqUih7qEF8yxdKwG34nr+NdZjg36Zq8noXXQCwYn8z7eIYqhiH+45yx4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8621d44b-3085-4dd6-dfbd-08d63278f717
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 08:34:05.0031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1538
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atmel,oc-gpio is optional. Request it's irq only when atmel,oc is set
in device tree.

devm_gpiod_get_index_optional returns NULL if -ENOENT. Check its
return value for NULL before error, because it is more probably that
atmel,oc is not set.

This fixes the following errors on boards where atmel,oc is not set in
device tree:
[    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" =
IRQ
[    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" =
IRQ
[    0.970000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" =
IRQ

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
Based on https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git,
usb-next branch.

 drivers/usb/host/ohci-at91.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index e98673954020..ec6739ef3129 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -551,6 +551,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_devi=
ce *pdev)
 		pdata->overcurrent_pin[i] =3D
 			devm_gpiod_get_index_optional(&pdev->dev, "atmel,oc",
 						      i, GPIOD_IN);
+		if (!pdata->overcurrent_pin[i])
+			continue;
 		if (IS_ERR(pdata->overcurrent_pin[i])) {
 			err =3D PTR_ERR(pdata->overcurrent_pin[i]);
 			dev_err(&pdev->dev, "unable to claim gpio \"overcurrent\": %d\n", err);
--=20
2.9.4

