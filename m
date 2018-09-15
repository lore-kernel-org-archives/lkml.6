Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDC7ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C59221477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j+dVoY4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C59221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeIOHFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:05:10 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:63424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728554AbeIOGr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXoDVBrBL9GIadjEItkgp42QBP7VmO3wd3Y7MD7T6Tc=;
 b=j+dVoY4LiXkZxOaL0IYwjgTtTdZU7tF5rKKlnrnZvTOG+qSxj+7vOIq1lPqwmAzQZWhxgEx6pGg85AsuUONyDVaOZEiP1BK7ULeIf9hSyOte1w5S2glN7/eUP4+Sx3psaB8+xH3MbOrmPrZWrG2xMKwPB70cTeAftO2EH7ySwA4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 57/92] gpio: pxa: Fix potential NULL dereference
Thread-Topic: [PATCH AUTOSEL 4.18 57/92] gpio: pxa: Fix potential NULL
 dereference
Thread-Index: AQHUTJOv9UFVKBHDf0etQ6jVOWDrrw==
Date:   Sat, 15 Sep 2018 01:30:29 +0000
Message-ID: <20180915012944.179481-56-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:ugm4icRO9nvGoVYrFwrG8/woa6hogYj5T8+uD8lkAtP3BWpa+cftCY5CrZxM0K/nJmLSMTO+AUzqg24CA94o+zRiRUoQBXeYUeO5M+ecy92XndumCRw1tLbGEHr9JnDvMbywj06UdBgaOnX4R6NGQGHAT9ZdZeWlyIPAtHdgGlvyj/vlmp3GgJ0pME5jUOfVxgoPccpoBsDOgcbV6zGGgfOrUNbJiLTiaMGLXYM3nuszuuHYhs2J9uKcPnvLe9+K5AWap61J+/YLIc1MMJ9DL1vy+pVePk3eIExAGAUzi0Xq/6wxyykQWv7KIjwwSVU7D/U/XCU9eJMmnDIuc4dfrPhqPUKtSv+OQ2+8eINssQlUtRs4rI6PvXcXEoNaIVW2xFPdRz8ZRycRmCed0ORDUtsink1xirShwIPcZP0ZobjdHMA6mGwvDvz73adaqBkoJ6oBhmd9mQNVM/AyQ0CeYA==;5:F65RFzB9ny26VKB28XWF+rTw7ZGS2JBVYLRbnf0n4/Wlc/l8+xykOKp6xr9OQK2phhjPy+N+7S7yp6ZhVFL4IqbT1ft1+y2WbSxowaVUX4921sxITEODRZOzvrU5wCliVZyS1p8zTH4cmzlLlR7KDXOKQ/Ak0pp/3m++sAMKLMg=;7:tty4uOfWs5WEZ4Pj1WOKXuVlBmpkZg8hKIXMFVb1svmzIrXA6GzxvxJncKQ7uIMEuayZOUp25VKwESKMLfvfu/mE/kBXFCmHzT2QFSKY40w9759h/BI7XgGOCDdTlMMRvcZWqvuG4yszenkNjtFKh3zFOSezLgtFcpWvsCqz75fOJ3YEVTxdy2Kit/A+fStM2iW5UgOF/Q1KEvDiXd7U1KCWZMsw4ZyPtUMfLAUwgwgIeNx0ggXyglqL0q5Ci85w
x-ms-office365-filtering-correlation-id: 20927ec8-fb24-4790-43c4-08d61aaae2c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB08569ACA1F64527EB6BBEE20FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(50582790962513)(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(76176011)(68736007)(575784001)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: XDfhEY+W98pZcgrvvICpNRip+xf7dTqS9VRUal6CdlIddmbEArZcB90PFctOwrP25uyRHdKm0LXAikpXMYLYxC+EwZ/PD/R3thTGISFfXPKvZOldc9IN5fQmJCJh2QJvcdZbddh/IrkPwJF5DNsCRr8rUqg0tcBAhqWket1ShS4kOp15EE0VRRwCzvIuD3XjC7xQX14oNpt9+89cgLYJvEZp+4egX3XsVmFLeKZedYJIzLfxlBWlFuYjh01iwcaGpT+vUWkFuyfijK7BVvQg4xVXWLO2xoz9z+/fd66sT/xJ/PGcTD+8HwxFhl120O6EAqth2BoCVugzSZ2IHA5fP5n068QprvqysHMcahbtAH4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20927ec8-fb24-4790-43c4-08d61aaae2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:29.6668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index 1e66f808051c..0d09a4fcef49 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -646,6 +646,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
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
