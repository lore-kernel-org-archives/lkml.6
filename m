Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F159EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF37204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ihIM+65R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF37204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeIBRXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:34 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeIBRXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4hGtOgAvvRJ3VcNGnk8zMauL17VTf9wpCwVPQSalNM=;
 b=ihIM+65RDX+HP5F8QIcVHwOdSYcZBjWUlxspQbB7B4w4H7471LCPAYBbpznZO/8a04UudLkCftFSlbKXdgBxRdvuwxoxMvTXcbJJclCDtHaDhxiDtdIkpMlQ0UUko/eJIR4pFTnqPZ+eEBa6VfM6UiwcuoWeVV5zLrJvUsxt1gE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 51/89] gpio: ml-ioh: Fix buffer underwrite on
 probe error path
Thread-Topic: [PATCH AUTOSEL 4.14 51/89] gpio: ml-ioh: Fix buffer underwrite
 on probe error path
Thread-Index: AQHUQr3dQ3MApJnmQkuxF2uSKO1jCg==
Date:   Sun, 2 Sep 2018 13:07:13 +0000
Message-ID: <20180902064918.183387-51-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:KsUfivkK7L4vKGgG1950lnYd3h6H5hdW4leBl1KqgvRDXTkUUX0klJaPeabLycYk9AE9vpR6e2UNAPyFfdu3ZgXZl+mOmkFjsxr3gUyGXTSpjyR8IqU+TiqKN2umsyfSlgBOsemVmRZ84lQrvn947p1HLs9OiMTNL37VRsms/h/cImf+JzYrKFLvRkZDstMSDXJYxRux1EA5lbru3Bw5EvlGUHfOj1Hhrdz7ahByURAFsd9XOS8AX903V/KeL+MeuoZygywhaX/vTUjLgzNPniyPtS10x7bTc997JdUasqq22Kn+RzQYPE4WgXxcmx+8Pl2oQNFx90lEv6Rri2iXHZDiwasPk2cL1GSEL1EUhJ35wvNpcyxBwxJlRR6wJRzZZ38gMmFzt0KOHRtyBN7EGdcego3vIQ5DOZxGjHMPLQguFn7VRBCH6TKR0xI3InhwN6KgxEHpQa/ZKLwBk1zg/Q==;5:z6AmmYJb6y0MBeWHMrElIbONEv8GYYGJ+2fc2Xqd6exEFWGxFyHrzDp64k3p3Tx7ER2Xg23CqSDA0lCS2vRhIVM6jYPqBsdm7PD7BoCsR8FeHEtuTY5NjcoxQS7cFCaaTwRIYdQ98N6eGrwzw4Dmo7wg4JyxEIyhEoxrqmLfFE0=;7:B/bAkOb3qJKzh8gKSP/WbmINOSV74UcPk3HNr8YU/UsZJBRXFFuO5flM9aKMcS83myqVL8g55ONRUiP4iTOSdugnKOPZsfUbi342BCd8xFsxRPjHoFnCv5eqQhCMe4yUPU/5lAAXNs/sXMO86L7dmZbmui+TsAiLl9r32o/4oyuyVeFFRjOrGcX3AnbKDpfwOgKK6PWTIT5E+Uv9USocXk0X92t8JxIB32s4LW5gNGv6tmHC3+Z1qhuwDZ7ILT8L
x-ms-office365-filtering-correlation-id: f791c73e-e5ad-4194-d1bc-08d610d512f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB050352794FAE0B5D8DB015F5FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(4477795004)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: X1mxJlxudkK9jOUZd5BGmcjYb7YsSZRwF/ttM/XoiFI3Peet+34sl3dVq90ab9YVAuwwvjy19ymeYVvoYpOgt4dduYRfMENqGebmU6yacRn010C6YyDnZ62xQmUAUCeTbasnYZqDDYNWtN//IkevC06osxuL3zqnzqCD1Ac5JB9I3ne45hzEj1xWtMJv9x7QPROcFgDVgoUJ519OCMprnVfK+9MFuA3ZP+ZJ1gx2OOgsMX3EuDeU9wWL0gN08YsX+khydduV+HGFTzeIz4nA1KGfLnL94sUBAcresfwbDQ92dpCQzaYzGmVLsvUjutYMAdDFcGqSS7GbzhnJiHGOZxTuUI9Wpb4w/Z7lLnrpLJ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f791c73e-e5ad-4194-d1bc-08d610d512f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:13.2961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
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
index 4b80e996d976..1022fe8d09c7 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -497,9 +497,10 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 	return 0;
=20
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
