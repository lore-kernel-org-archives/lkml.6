Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4BDC4161C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22492148E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IXSC0pH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22492148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeIOGu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:29 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:38374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729383AbeIOGu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK9husspHRHWgBQKlBHXfalEIrCeO0RUDGfT0k1j1X0=;
 b=IXSC0pH8esBKlHwprhCzjvWoKXuk3New3tlAokmdKi1KPNc7bntd5eMZLmCyrugwwZ8Hyyb+aroSbji7Wo1AzIGrdkDJk+GTHX8hSvl9z8l45t0b0pYrAYrOmNQ8emW2ibI8yzr0Tg4YFJlKDY3zoLUKpFrKmWaaFbHT6WGv05c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 38/57] gpio: pxa: Fix potential NULL dereference
Thread-Topic: [PATCH AUTOSEL 4.14 38/57] gpio: pxa: Fix potential NULL
 dereference
Thread-Index: AQHUTJQFeKS/fNCxVkuLBPqHzO7GUA==
Date:   Sat, 15 Sep 2018 01:32:53 +0000
Message-ID: <20180915013223.179909-38-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:vHNpUjo4N4ThNsgXGUc383oDyxH1xyLYODgCnt1v1b+6NXbGMcG269DDQlNzsDmZVdsiarmQut8TGRW08UgCBmSHNleRdBm3cRLQR8cunw2Y83WaGk4U/5VhbTChHHysP+U+kKPxTaRhkL5+Y2xnUxrpS6ksVqBanVqsgA0MiC/9hGF5vD9dAmDVaKkl9PlEtt62MzNeW90AtGN9ZFkOHly3X/1mWOrzoxcCb32p2yl3s6CKgeMrkPP8+K4MEkoDYE9eDzftVM0veZC7fc0dAFid5JclTqWHHOEW4iQhOHBfyXOLGgDriPjpKWnF5KhOfsu43+fKwGW/pJFg12JHhBgd5pLOXbCo7q/4CC1ACAxMSOwIqo3EfrwEqM31TS7jISuYUcv6T1utj7ZDW1173+j651o2LZMHxM3K4UBFnU3wTztIBD8Hoogj866Z/kuYhj8NxwD6KJ1+RWcJAwf3VQ==;5:PgGEv00oEhzArWUSEv1JSgck5R7U6HdSBwk6rF4p+Zw+Vdn5lm9MXyWolWITcueGqvtYpQHB4wtMW9C32YET6KussxQWSc+D6z/gBNIboe+kqjf1yUO1KzsXGWX38Spt8uEAiFIrmCgvhYCGCjDN8JP3yOfvV0hme2+FRbJ6xOc=;7:IU0vn0f2QT/gpkeno+L/0/mkuSqBkMiuT2/jUP8qYkaiPFxukDONnIEga8c43iwIGSc1btWI6cajdgKcDQ1Yzh25z3TH583xYRcMYz79pi8QHpkiRAJ/eN5o9dPGXwP4Mkzbf0br2g+ceMDQ7L9wo58ESbqdVXjcPGxQrtXXg7h+1Opw4NMSpK3N0Tknvo/p5ww4kp4Kq+hvLcpdhgAxdVXyOpNsyx3/+6pWf5DOBIcYWc1066HH+bi++6Dr95Vi
x-ms-office365-filtering-correlation-id: 67834cf2-8472-42f0-00ab-08d61aab38e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB04719EA032D6879F8F150FDDFB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(50582790962513)(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(575784001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(2616005)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8qlkM0Go5DVqPE+u7sektrobt/MFyOOaMSxrVhhI765oGZbVfpmdCsk+HRG05q1YjMlrl6tmO/q+7pVqoJL0Cmk11Vb0e4GLxnqLq1yi7cd9xo1gXeNI7qKAjaueqQP6T4diO+h5WfhEypCYEXPWd/iB2Erk0p093DhoTIvqSQndC53Q6z8mR9LQY51YP7LVrpv/MC1Lxxj7448D1B/3ks5jKntG7QkC6AlfoOvyZiseKKl8AOBCeAFg+MKqPRIl7uPrUXoxxYmRT0RgEuFMyDRjmofIuXqvarKrn61e8cXArH+VAwnEBjqSuSXyldZMnJ8hsBea/AECrYHOGx6914Ing8/zbL4wYjrk38ZHibI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67834cf2-8472-42f0-00ab-08d61aab38e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:53.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index 6029899789f3..2943dfc4c470 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -662,6 +662,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
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
