Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D854C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02F22077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ya/Rs+SW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02F22077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeIBRtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:49:00 -0400
Received: from mail-eopbgr680117.outbound.protection.outlook.com ([40.107.68.117]:50363
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbeIBRUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/t6VhKVEmzSppjw0t7zh+wWmMxTb4pGmNuGf1Cj1fo=;
 b=Ya/Rs+SWtbUtQCNeW08U43bVrspcYmvo63MY7Kp8K9R2CQbRIB7tS7RoQNzgMhqFdfCuGKzAmw8WGk6CuXHAqe7X3C5qgc4FU89E66mGHqjBNplHersFeygWxJlja4ANUsWN8jfErHkywnCJQCCyfff+f771VOizwa6SRFt4m8Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 078/131] gpio: ml-ioh: Fix buffer underwrite on
 probe error path
Thread-Topic: [PATCH AUTOSEL 4.18 078/131] gpio: ml-ioh: Fix buffer underwrite
 on probe error path
Thread-Index: AQHUQr2DAv029JZaQkeAMaZRLECz9A==
Date:   Sun, 2 Sep 2018 13:04:43 +0000
Message-ID: <20180902064601.183036-78-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:l89w53PwIjHmZzJLWXFW3L4Q2H8NU29o4kPYc1N4uvdC+TbSZK5yi3mu/PGRTx3xLEa3TcgF4kau2EUk5DCeXE0mrwgsKPe4XWoQf7cWi8j13iTiYi1M7xhmFpCdOFbdFc585WkptqSLDRChZV04DiHsmbd2AJ7mARwT4SgR7G1JRASVANW+cqs4jtpwGU7eW2yyAtJyhlO394kJqXZ/Aie0gFY9YS06C86UAyhgy6ctZTCqf86kzj1xRGUI3YfAyZTUR5Br6hY/qT+1VSzkxpWsY3txpm4s3suDRHqa/lwChf9nkaEKpR5hXOVaYmldNDZZ9Y37Jm17BR6tLmy0t8qa4VdcglSTmKjZi5lAtv3zLiSZbETZdzqasYt0ou9PTh8/6jxs2OZaQjRgprQvcWXgGPNjSa1MwSxMFa27R+k3RHUx9nmKrcwFmTSF6flkSqVbZNXo8M+fVb0/rVMSXQ==;5:0cDr1E0yH80kthbBSimu6dSUVwIT0tHrl3lYWxgCxeRuNQVLZy5wG7NTyDKbBVPwp2wwl6g/5ot2W1hBmzQK+DVj4/oyUlIRr5n59K6r+onlYVn/OM91tHKm0YcLEkiJYpo7wa6ZHR+Y+vpC5qVTk8WBUHp5A8ubBMQcvNK7cP4=;7:DMZ7EHHWc+oCWzwZpkXX2GthYHuzMglHr4qyAnLN7+t2g8gnFBA44ngxDeQp4ajSH66VogjhcyPKjaxZJRThfm+5oEss7XviI0oMGqjT/w8+5IkU5giyEXVFV+HXOGO6M8Ced150URfMEG4MfXGt8BYe2XRXvf1NvO033H7eSmwsQ/bg8m236VGFkEcCHgJ+8Vbrw5ZZnxnOuAvNOJ6XPlPbwizi2zgV63bRbn7RESGz5bPbp893i98OMC6hnE0f
x-ms-office365-filtering-correlation-id: d4ec94ef-1d79-4e34-2e91-08d610d4ae03
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741171F87840FD09ACCF634FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(4477795004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c9aQ70grrQWiih+w6DQ0r3/4apD71vHofMHA2uGdHGKPmBAWUr26IBdaB6l3VFu14tWoqo3ACsAAiMqSIgrC3AKc8RJjqYWZTrwfzRy2BuJfRhvSiXzWzjGVgMy4fGiGJ3UX0nc5BPWbnQXbOwsGsEv/kCvfDmDcsTw5h0YhR7eEbv9dCBwoCNm4x4YLhGwrXCrqOYuDdujn3v/M7EFC+rB0BdYhYckKJT6l30HrGTdTE3jYa1DSarfLCLx4VcTkuhhxXZUYSwsCQPpUbIXLd/9d13jvcb+nWd87YvK0QXXsd2VH9+QNqKymYcE/RU0bK+2YB4IYgAcmr+Gdq2AaPhep5B4DsXTuuJRh0injl/I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ec94ef-1d79-4e34-2e91-08d610d4ae03
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:43.0953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
index b23d9a36be1f..51c7d1b84c2e 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -496,9 +496,10 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
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
