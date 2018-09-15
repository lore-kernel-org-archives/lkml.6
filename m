Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2978AECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B8221479
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DAiHC/1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B8221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeIOGvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:43 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729689AbeIOGvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrEM1ybXmzzbbu210qoFCeP/k4NUKPOT+oBtXMDClvM=;
 b=DAiHC/1h0sTFElufRcxs6AnOB+sugUnVXrBkTgyYmYedd5pj+LzwoXR3UZCO8HIHLX+lwuvNN9cNvmaSZnRkBwcQRS11dWExCyydV1BNuZjQj5pNBHmYU3Ao534x5sT+I3yuR6nBb65GYYfCYFmBy0A9xKl2D0yq/Hwp0vpGopM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 20/34] gpio: pxa: Fix potential NULL dereference
Thread-Topic: [PATCH AUTOSEL 4.9 20/34] gpio: pxa: Fix potential NULL
 dereference
Thread-Index: AQHUTJRE21TQoCWGqkeYnjXEhv8xwQ==
Date:   Sat, 15 Sep 2018 01:34:38 +0000
Message-ID: <20180915013422.180023-20-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:vzvDw7tOCezmC2WGKLs09OnK1b2GpEwkTBYFM5XJ0RTsboOuq9IGf6lI4bWyFyWNlkqHxj+lQetO1prM0cV3uQiBA7Qcg8e0upU36zsRqUkQtH5nkMBwQFA8MvwrOiCfxjMzQtQv1hsHLmpsYkUctQoLXPGRzT5G1vvf4+0xrofGjpGtwd/Z5n0BFVzgTCRvbOSOALXAEkNi5mTofssBRPKYeixU6YfwJ+EUEyWjg/+xTvvNt7xbSUukeI33ZD/Qb1d/nRYFzOzxpLxrgXXoINExsgOpqobmWyOnW7PAT1RnK1w57Kkb3H0YWpDlT/O9IKrOZOwuuexTUaGgbequzvMmqnxlIJ/0QKHLjOp7+Itr5xBZRkKSSVbz1GKCyMTlnJ5Vb9oPkdlAgotXuFSNIHfDcroLYaQGp3zHZCBL0V6jaGBtkwv+jaQyr+6boaBsdH2r8ddDEFcQVkLISoKfPw==;5:kIDb7YtDnK2qeLE+RBl16EFofMeaItH5nB1UAg9Xwx9DrpwbjfNaSrIwpCXu96GpOvmZM9Mcgc7/CDECBJvWZGiLrNijGDAUgmo8pwEnjbdKlvVreqLiyHgugort6/I3bHurVh46ZKyryNUHkN2+tdtFH+qqkcHePYiaSN0H7qE=;7:RtTCbdqzNMToYHbLsp5nWQ0BME1Nl1A6VRmJ+ZCRG7vE9tDW4oP6SOZY0OXNEYiydUvr3IJQ215VXX++J7k4OkQuxKEmqXVwOAuFAdKcRxzODQqbxBmrFviWu14EVODty0JSzGtcXO9/+yfegJoUle7+VrJEV3/iroWsjNBWHabeCBfSXCXLnPJ/Ey+RSMdO0KXJDxoz8Bb7XW91kSSJNvwjyh/pOV8DoBjcV0+iYmFI2b7UExXoBrPUbIKnocJw
x-ms-office365-filtering-correlation-id: 0f4be337-5643-4ff0-a742-08d61aab66ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08230DDF64181190D1258073FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(50582790962513)(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(575784001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 70JZWLwTz914LaDDgYWga9B6oSYnDVyJpvlRCpdwCsAPee/FiwlzO83vcCHjiGNVHp33jrmri1/pFTB+nSrV00GStfm9I6EahjgWetVPjRWtGnrT8dnxbUANbb17swouSQGPXk7zjY3bCRMErvaGgDWtVHCNgbr1yxe2/6SjNEDlbThivuufwYwFLUazdSnprz84gU3NHCZ8TKuHJQfX/+N4hnmDOX223MsfPLAbPHaSgWPOM1wLus1Oz9ofCiB24XB+DL4zJ1rI+hj0veJxAntipRoEHkQDRqU+qXjYnKEjSk0WhJQBZPsuJB5A1pxpJ7EccyazZbAvVnocMGC/N0CsvEf1/iHpSi8gYzZu2Fw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4be337-5643-4ff0-a742-08d61aab66ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:38.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 9506755633d0b32ef76f67c345000178e9b0dfc4 ]

platform_get_resource() may fail and return NULL, so we should
better check it's return value to avoid a NULL pointer dereference
a bit later in the code.

This is detected by Coccinelle semantic patch.

@@
expression pdev, res, n, t, e, e1, e2;
@@

res =3D platform_get_resource(pdev, t, n);
+ if (!res)
+   return -EINVAL;
... when !=3D res =3D=3D NULL
e =3D devm_ioremap(e1, res->start, e2);

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-pxa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 76ac906b4d78..7a6305884f97 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -660,6 +660,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	pchip->irq0 =3D irq0;
 	pchip->irq1 =3D irq1;
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 	gpio_reg_base =3D devm_ioremap(&pdev->dev, res->start,
 				     resource_size(res));
 	if (!gpio_reg_base)
--=20
2.17.1
