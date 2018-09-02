Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1E8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8904F20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="W/R89q3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8904F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbeIBRer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:34:47 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728973AbeIBRcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDbEI6HBxwPLaXbfAmN+DwhSb5qBq6OZGW9zLrke1kE=;
 b=W/R89q3H5Q9LBiyDv049Md/RTa8tWVWLlGA9GNheDtEJMto3DqizRXX3ZpUVmeMs5FZxMB6n9+ZVc3QEsKcHiTu8i/k8H8NctaJHc7/MVxkPOUv6mNDjTS+Xh3g1JmgldnXT3ED+Tgn5/f7VKRK8WCHIZuWbfFrg7sUgFU0pFw4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 24/47] gpio: ml-ioh: Fix buffer underwrite on
 probe error path
Thread-Topic: [PATCH AUTOSEL 4.4 24/47] gpio: ml-ioh: Fix buffer underwrite on
 probe error path
Thread-Index: AQHUQr8c/HVUrn6IeUSsEBL8a5/UHg==
Date:   Sun, 2 Sep 2018 13:16:08 +0000
Message-ID: <20180902131533.184092-24-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:ZNtxD93St2dKaNvwt93173S3NtQo5MwVKfeEUF6RnIxbkWxEODbY6ewhJCr7ViHPM/li2q+CBKN5FVqVSxlvt1+gNvhgsDQuKo3x0UiJT1ZghhKj46OqYc1GWOIHqHgQ2TaFIMtdW9FJlCX/YOzYYzRfKYGelit6D76dIqGOef7Dl/tC4zVw1Ul5yPTrrNMMd0hvpI2TEzpDGXf2rzcW1cPAdRiC2TQ8PPO1ptQwlDNyPrBphwRCvaJOAxqWPVz0/9mGTTehRBTm9h5Orhr/MZyGGlQWfiFvdESdG/hlIHFaLVMu9Lv9lS3D3z2LvTQ563Mmqt7v9mrtbfUY8WC9eyRZc/K79pKCKZFAVno/G3lF7XKKJgKkohXcVk035vR4T7OYEjb+vlFZnExYbMjVbHoecNNUloVgJWFCc8PW+l66iTZHbLSQPt7Y2oy0/RzeHPvlG0uLcDCHEvsXkDOrSw==;5:Zm5kUA3h03I6Rm2SJ5ZSJ3h1iuITTfkEWXiEYOKmyvGLglhEmzc+WXkYwJR5Hkgwb6dTXe+4IejyGsxLZJUaWx6sz3B51F9xfdcL9mOgy3ltvOzLcsCq58WD5hD9oDUUmiCt8g9WTnU2ZcdXERPUH0aQ27B6TeGuxGJ1Eaf+OOU=;7:D9rsnb1LofZs8jJbEk3lFJIwIHT39P1XdEsVBWv56AUZU/qPviTXi14N5T03djc4nnvzNCH+NeBCkT5MygTV7NRqVkvMevGqV3UVhItNo6xswG6NsW2tyGjh5WA0915/6dtFwKsHEwJefiLA1yS1U4gmTb5EvqeV5XxW6ROMPHbJS88vVmPbSWXPg6Ny8o8I6Bz7789BTCB/Ty61WYYSsRWLHhYVlEu346NBHMGHz1iZ2VivHmr54/Y9Xil7vgVI
x-ms-office365-filtering-correlation-id: 34ce0803-ac70-4e02-33db-08d610d648c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629AA53944887BE885A4F2BFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(4477795004)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: yJHX/fSusNbGZhz1F/N0hSoU0aiKCR5ODGK3Kvo3slUuOaaz4pUsedit8at2XURdot2FVmLuoQ5YEvsTUwOUBfjVsP1wohrYon1VAkLRwOGnEXJSieH2rOwzE9w5+8TkwoZPuc4YtkM4Asi86/uINZFO5L4oOjs1ZI9O4tZJHfjw/Fytj7yo7IM2OapKO5mfB9R3ZwRhIPZPi+3XCHUI/3eVdA0uc1ygMDnAZ42X/7gMEMET4Jxz4bIvqcuY4Oq7PVr3d1EVe3wtpmr8TjOWFK2v3fITFx+J2jAM1/H1osODdXK+FQ3kfa21J/K9VW2mRiWlF2uWV9T/+OqNLlpCLgkeuPI0lbdMLmMLdB4qr4M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ce0803-ac70-4e02-33db-08d610d648c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:09.0108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 5536108aa9db..fe21734bbe5c 100644
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
