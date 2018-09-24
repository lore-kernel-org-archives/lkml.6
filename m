Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC43ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639E22098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Bv1RtGB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639E22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbeIXUuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:54 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731150AbeIXUux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2QIa89gY7cnJFT0PBnFFpNnSIeQQB63O/4211J9OrE=;
 b=Bv1RtGB5T+UIT8gb8yIjFRFarHyE2L9aBqRC09hRb5f+Wej79N9bLhukSha/ewfPZBWrNcGMLFmzW2fmRFewE1heaCuMWCKbsnjB0UbydLkE/+pjXBcVcyrtrY9LwuZXxkLWZdRHYbbHPQEwhEZ0+mUyrEHNASwz6lISptVt8eE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 26/76] gpio: dwapb: Fix error handling in
 dwapb_gpio_probe()
Thread-Topic: [PATCH AUTOSEL 4.18 26/76] gpio: dwapb: Fix error handling in
 dwapb_gpio_probe()
Thread-Index: AQHUVBWgzvLwg+rSPUOzN+c+QosJfA==
Date:   Mon, 24 Sep 2018 14:48:16 +0000
Message-ID: <20180924144751.164410-26-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:D2/4knLY3pMxnW5KMRIHjd/WSMRaaWv6z1ReLc63giE/96HaPgMntJWpp5cafYrI6ArYuHWzcDecfdE/6WgRepHH9cet3+qJoXTVeizQV6ckqOkBX7D1CrJKnTBKA9D4FjW07q6dyB5DETMt+DO9YMp3LiCBBsrUQR60yyXP8n00T7xCM4DB0XhDszCuNTe9hb2PP5NIMNBSHo6AT3NmjTtCH2MS0ZqjDid8fQT3bjs27BW1Q1NcAuqsqI8NJGhmfx92HACnA4KsjVJ5iTQNAG91VCj55j9+t5hRb7Jechy5+SEcCLHMS3p7Q/rigk7IUQzc095UUpgxSWJ+ig2nbBTHXCmUDsgNo2NS3glWbLlHjoSqyaDi5h62UURyMd8mv1A8uCJblToSDvGLG4iSYleGjEJxSja9r2WJIOKJxaRXCiRHtsPV4MFQW2EIsW4IYLu0LYMBS0AXZ91UfaAlnw==;5:14XQIlTvSrwz3oXDEwIpnLoz5f9XjAGJm/YI8oM9Uy1bZ1GILW980KxfwyhvOqrF5jVKs7ZMUHFBdaHpZeW279fUovsQ+AQnhVhLBurMUGN0VV/xMpVh1bN2dA/lE5KIn9d/+jsga4BUm4UM1noBjGVRQVD/d08S4Xexp+/hraU=;7:hm+FHFei8HI+yVBEnvwKcrJyk1wzXKPswQA8/iltB3LX9ksU3RlqBDo4matSpl4DJFZTIEBIENKOQd/TFvmkafLNtCe7843Xhcr9Iiq+RTpOULT/g27Q+F8yWLVnHrSHiDJCU8bOWQT+tI8wfLViYJZeG7z0sarLty578TcBXs4SZSG+mOzmTGRj0t7+0lvGOIcPzlL1YYx7/lOSL92qo8X6Q2HmB+tIn1R0sAEUiXRWGW4jryis1ICV5dptgvQM
x-ms-office365-filtering-correlation-id: 163d41ef-95c2-4e24-c1ba-08d6222cc358
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821DD04A220408B884ADF3FFB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(4477795004)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: wuW2BJAt3sSHmZN+BLQrYttVKVP5glFC8Vckfb5h2K+EoxLNbg+vNnxRtSS38N9iwsI6aQfqNLMyd2QQYqAO2gX8Za6hq2+UWhHo9IW1YAGo5G+7qMyQkL+F0y5PQkaC8TSDa0TcZfhZLljWfgVsmI30xv2B0t+4xDZS1rkj/ifzPJE/8cTf4Xr4HRz+1II/lejNyTVFouCZOU661lSL3dOJD0YcMtvqeYEruv9sREehCtc+FgaFpAwuAT362VQzlHHOzukwBr4lBtS5LA8LZ1Y0IOEj+paPnNnzZo2RQTVmkk3I7ohgkO0wJ5Igcv3x7GEmRQJo/WBIH9ZtM+sNjenZoC+xL9fOqCbALiN/YSQhfSb5RVuZ3fjoGOI6tyU+LFdK4DeJq41O01M47SyryEy3imXwjj0TBNvNsACTtknyf1HKLmV7mtSzyNGAiOY4+ELUX5i7Fz2kVr+JMuDQDxbh0b5iafIcvrev5b6/SbcOQLTfYtbft3iBHH3mxr6/bDfwSZY4sExpsZpJ+k9nnbvvyWgvPueguE1JCTCh3RgrC5BNQ+syZUut5vGYJPFI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163d41ef-95c2-4e24-c1ba-08d6222cc358
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:16.9992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit a618cf4800970d260871c159b7eec014a1da2e81 ]

If dwapb_gpio_add_port() fails in dwapb_gpio_probe(),
gpio->clk is left undisabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-dwapb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 7a2de3de6571..5b12d6fdd448 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -726,6 +726,7 @@ static int dwapb_gpio_probe(struct platform_device *pde=
v)
 out_unregister:
 	dwapb_gpio_unregister(gpio);
 	dwapb_irq_teardown(gpio);
+	clk_disable_unprepare(gpio->clk);
=20
 	return err;
 }
--=20
2.17.1
