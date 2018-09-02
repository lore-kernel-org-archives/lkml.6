Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAD1C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2A820855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MFuB9Oyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2A820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeIBRXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:36 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728127AbeIBRXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSJsSAcLwGaSuoveq0Zax2UwUC8YJ5v3ru2B13bvbxg=;
 b=MFuB9OykIUS4gOyPoyJuwYi/e+dxcAZCMtEbDmlqZ3VdClWALFLgK2nCgCLs0GgrljJDi1n1Nz92lHGTazSCK64PpudwAQsnDyvZxnXNV/C2oNDA+4e42bLQKTaen7G562OeOLhBE7/VUfFRP8JQZBgDX4xD+P6cJMtFp3LxTR8=
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
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 52/89] pinctrl/amd: only handle irq if it is
 pending and unmasked
Thread-Topic: [PATCH AUTOSEL 4.14 52/89] pinctrl/amd: only handle irq if it is
 pending and unmasked
Thread-Index: AQHUQr3e58e+S8/x+USBo4PFJ3+sdg==
Date:   Sun, 2 Sep 2018 13:07:14 +0000
Message-ID: <20180902064918.183387-52-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:pgcXCaJj00hjdYzZ2INPLWqfwPqcTK8DGYgTXWzrNjQh9fvDXGIaY7THLpSEDMtqyaz7O5A1MDovrN8eJoQQFeJuWkRqlj2jDnF6Z1gEELOs3k2r9QZTOjWyIT6FW/CbJ835hJWEyecMQd50TV1HqyecXpomEAgLi7mH1qDbroRUMtOeCe6aFXTfLL0IYflyxHzE27K9N97O4hI7uAsdPAT78hLfBb3RUt4QLbfaULLnsnUU2oAd8PYIEmrPaKzck6KsscoVwpri26UeWkPDBaytJF1dSsHVD9WrT5uqYgCws0PBHePBzEuykw+7P7L5z+rAMnkrxLZ3P6zaJf+1DxPMjja170U/NPS94WQT133nBf4JXjjzn+ALtYKCNxbJqOWPAFZVvFV/N8m2ucbgX0ZiVW2oMlLOTNOso7g43GUk3CH+WBUyl3XWjSNuxUjdzaE815GaT4dlYPm+BiBrnA==;5:dZx/ZW5stQ+yu+Dqx7bC/NIOPn+1mTSemSMN2tO4OuXTKbAZA3fYqOGR1ReVKF9gsOTsoXcRXY/8hULPwcEAHRdeqyIgpSd6IjdwLWYhOwYaUoIVf3hm/ay8NVTzeI9b+6xEzLFfDg8G6qlkeGWd0IspIzvAptn5xJiEKlBhavo=;7:wP5G+OI8Gyk4qwCl2e+VGG8H09n9tYUQY1uvn2wzF09XCDeKwjKlaDMY5RBsQw9LEdxUaya098HKuE516LUodPSxmlqo6WzXjUaT4nClFQZqkgvmCqNrxsbHizkxcVnZNZwo6uTf6PkAPwAXBEWXE7dXgxGvOiPugnvubi6v3b6T54vleG3HXrnSaMD9TX0UxADnjLSUEKfMh7W5k9pKl6xc3wOg8p4JJFq66KPzAhURhjq9ecl3kfD3M/ZUF5x3
x-ms-office365-filtering-correlation-id: f4b3ee5f-20c4-4548-aefd-08d610d51330
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB050341BB228340FC0C99A114FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9MsM6U77FhmzrMR01K2i4IL9cvkyNiJcwZRLJwzcd+T0POtSa8CRbwXVZiTeaWn384DKqVMGhjKHbRCvX7lGoGdsclJp+sZbQ8UsYMCT8M2UhmpA+R4uYKmoIeFZLg538TeyTecUaLEvn56MQyWQaLw/Pl/YDcYQEMNWZMSFBI0dt2XQlM8PFazDoLxJo5vVz38BAmmdXpb19rPwlVUzfAw3grA/3fNvw+1BCp464B1iihqISOC1PqO0j77q9eaChBEfIk1avNpTn0FVSzjBxWF7edSlNsKli6dISuNnEKFIz7nTTrnlJvUs+9hjXzyd+CF8K4EYMI49rNwAstZGz5e0j1JLM3KQI1oYeNAMbXs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b3ee5f-20c4-4548-aefd-08d610d51330
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:14.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Kurtz <djkurtz@chromium.org>

[ Upstream commit 8bbed1eef001fdfc0ee9595f64cc4f769d265af4 ]

The AMD pinctrl driver demultiplexes GPIO interrupts and fires off their
individual handlers.

If one of these GPIO irqs is configured as a level interrupt, and its
downstream handler is a threaded ONESHOT interrupt, the GPIO interrupt
source is masked by handle_level_irq() until the eventual return of the
threaded irq handler.  During this time the level GPIO interrupt status
will still report as high until the actual gpio source is cleared - both
in the individual GPIO interrupt status bit (INTERRUPT_STS_OFF) and in
its corresponding "WAKE_INT_STATUS_REG" bit.

Thus, if another GPIO interrupt occurs during this time,
amd_gpio_irq_handler() will see that the (masked-and-not-yet-cleared)
level irq is still pending and incorrectly call its handler again.

To fix this, have amd_gpio_irq_handler() check for both interrupts status
and mask before calling generic_handle_irq().

Note: Is it possible that this bug was the source of the interrupt storm
on Ryzen when using chained interrupts before commit ba714a9c1dea85
("pinctrl/amd: Use regular interrupt instead of chained")?

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/pinctrl-amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 433af328d981..b78f42abff2f 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -530,7 +530,8 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *=
dev_id)
 		/* Each status bit covers four pins */
 		for (i =3D 0; i < 4; i++) {
 			regval =3D readl(regs + i);
-			if (!(regval & PIN_IRQ_PENDING))
+			if (!(regval & PIN_IRQ_PENDING) ||
+			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
 			irq =3D irq_find_mapping(gc->irqdomain, irqnr + i);
 			generic_handle_irq(irq);
--=20
2.17.1
