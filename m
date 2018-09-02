Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86101C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3243E20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mrmyIrfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3243E20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeIBRUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:49 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:62112
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728280AbeIBRUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4O9arCSq9096vMgeeAyReu8fDXZyalPoZIf+EQe7M4=;
 b=mrmyIrfToEYjL+L2pTt7H4f0mGbeX7gwsirGAcHHtVpR3CrW0vMUGHeNMPVzFDe0Wudvf9PXdQvPAomjCDn/X/fZMvT5mrorxsdmeciPHwvNmjqs+pDUrI8vPD9bTjnk8NtfJkQ6PhDEqTHHeW4qGemwuCdtbf/YGMgqnCY4CCA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 079/131] pinctrl/amd: only handle irq if it is
 pending and unmasked
Thread-Topic: [PATCH AUTOSEL 4.18 079/131] pinctrl/amd: only handle irq if it
 is pending and unmasked
Thread-Index: AQHUQr2EMjzyzwa+N0GCfDpFCZ4BtA==
Date:   Sun, 2 Sep 2018 13:04:44 +0000
Message-ID: <20180902064601.183036-79-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:/q+uYsY1NSAozUs4/DmKslUDyRJr4I5gPy1l+R/YdwbTc3EuEAx4saNsAnqSD99KC+G3IUWfhTduO8QW3OM8SuyVNyDHhlQXH/Uyn+I2tcKkKw1RMtLe+ch/cplqg1tPR8fIg0wN8HjcVt8mucgWnhK85Sl3QFWmlj6Bwu+yTmgmbuXjwG3FJaIHfJHhM9WFWQTqTCll2hu2+rYHUYUpDcw/GD/PagcHj4j1lJhwx9x/B4078GpBrcHP6zB/wnXeQ10Ggrwb95jh47b2FKXUkFLw6dPP/0R1DwCOurOkMxwPNiYKKXI12BBtg12OrK+aUH1Txezfp/O+qbN4Y1b3aIUG8WuTSFYA/5nxJAfwtwTHlhoC+A9pz9KV/6DRE4V0lorTyaurM9L0V8Yx89Uh5ciWclPCys7raiVQYP4ee4jRMzW80hWp4LivIi4vwUcKRa1w8NXwaowXncXA8zfidw==;5:oIYz4fsnVdFwj/xRpGRb1BMA0sY/3CyCNeuNkwaomhyD0krv9UE1QUp7E688kdYHccFTj8lKEoS5Z/gUM2yJQeGjKtiGmSJEU/7l5Y1waV4n2Ha2oUyvcaA+oHAFE9BpgroP5CaLOa2J1u7ULYo/YRbYhsghp4FT5d+YdxT6gU0=;7:sP23oBK3yK8Rd4ouav5cbXPoucPDp/6bOWjPiLcIFTVXWXObgwIuCsBO3n498MYoNciGU3o+RAr6jY+BFUuqEgB68tc0vzL08mv298RydIe4Gc/mMmHT8V+xlQ+aqn0f5B1AXRdZaYy2zVqYfVW9GkqHSE7pLAqiJ1+P+vzodu2RKhnyjG93lkLHflt0CFDzfT4MJJiGSO47zbMPhK5KGYjZYPQBqz8lS0z4NrNl0P+zc+EPUQW4ueVcNc/qP2mX
x-ms-office365-filtering-correlation-id: a85f000a-aeaa-4315-a595-08d610d4ae36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741F547FFF7D26E26AEC292FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9FiMhlTOcBT1kGPTPOrUu04VZLTmzUEs6y3KTgz+hPS0fa0R9UlF0L7Kc5U8Wmn1xwhLTObDm02GATUw81pUIhCpCve1j62JbQnpGsP3jX8tchVH6acNFGoD50I2xRdo5+sHZHBSB8UKQP0QNNTXLOopPC81tHPkeZU4DMWdFoUG2pg8tYD2xvv24MVUCmoGM1c1IK1ebGVOgo0eAYgspUBTkJe4/bzHn9mt9/eUpk+6R0yC0hhXjfItQVG3AQFEUS8H6cg4sFvWEFbr8n7SLNqOZXWN6eT9GIWzD5voYIFOx/hMlrhLO+vQJTL/nvYY3LdNcsCrPrIcr10WmbD3vP6GpQh4cbr9dZbV0SGcbIQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85f000a-aeaa-4315-a595-08d610d4ae36
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:44.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
index 04ae139671c8..b91db89eb924 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -552,7 +552,8 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *=
dev_id)
 		/* Each status bit covers four pins */
 		for (i =3D 0; i < 4; i++) {
 			regval =3D readl(regs + i);
-			if (!(regval & PIN_IRQ_PENDING))
+			if (!(regval & PIN_IRQ_PENDING) ||
+			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
 			irq =3D irq_find_mapping(gc->irq.domain, irqnr + i);
 			generic_handle_irq(irq);
--=20
2.17.1
