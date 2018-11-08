Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0558C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B17D2089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f+BjNCM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B17D2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKHU2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:28:36 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:46152
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726581AbeKHU2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7S+Y5egftBqKsiZLgwF3neSVc4rVsIOULj2oVKSVJw=;
 b=f+BjNCM5Wo+99vWdod4ZanXzyhiJ5hIFzMlrsyVVwtbqh6CQqFQGV87pgLmyf2Q0U+NBb9rR/cdVzFi46idHjqBEFTRU8AEtzWrtBynmUrUeh3AWjqpQg3uI71GpCEs+V+f5gwxCao7t20OmQ1QhxlhgtfIDh6HMEzTr9xbFgkk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Thu, 8 Nov 2018 10:53:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 10:53:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] gpio: mxc: skip GPIO_IMR restore in noirq resume
Thread-Topic: [PATCH] gpio: mxc: skip GPIO_IMR restore in noirq resume
Thread-Index: AQHUd1FN9Aj/AynheEG8YjCH4WLcUw==
Date:   Thu, 8 Nov 2018 10:53:38 +0000
Message-ID: <1541674114-843-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:203:52::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3724;6:H+6QnKUFQRaPODcvW/XLiz/CS2LP9Iq0O9xDwNe/Tz2X/YYBQzgb5uCtlSosnodyGYsXtX5B2lTau/ukrE51wmG3Kk4DpcX+h8fSYZN/SdAOc3ouAihXuOEopmUk9Q75zfnRM+C+WJwK6mfBv/blawKnbAIyyEx9DWB4EZhJS8RbKxuzQ2OhCs9MzOLjD/i0DgzjMZlNebKIrZXlkV2roWHqXS2jSbLrWldfhBykYmYWmeVWNqKn2ePr+HEfvyvUMpANQZDPiWi+AXlMC9nfGzzzS9td+O4oDgTWvUlj4JZCM4u3LBTcmdDaxjPWVPTJKNW9rW/OX4tHitlcvkydK63IZ36iZYyHWJQksIcZ/DJkM0KBhKEWYUmnxZtXt99qp9NsAUS/4Z4+rzKsRmgVo15mlWnljnE/MvHBJZmwmvzjmGNSjDJhdu+CHT7wlJOLxU//IU4bjTYH5trEHe/OaA==;5:L27jA+V3lI7ic6JL8D7nD+fBdQhPkr0COezCdXcA6fU37k7xgOHy74ACJSUjyqLoaK9ekEoQiYbettZaeciXNFbg8qoEWGqG8GPyGYmvfQevJE3kzHmASXNauBfnGjKLuFO+kCaj3Yh2IyBBiqv1+WJhL44qXW2odyB3S9iqSMs=;7:xeQJjeZpdrFS9QqrqwTTiGDtXI00XJBKpAjAHGFDTPXZX5VoRVnZHJ+a02m9IquKC3KlnfvuVShUOk2z0vLRZY9Jpb4vYMkjeLOEZWC3mRVLGDvGTQIP3rqsn9b7yjEcAY4il8qBLwGUhCxqgmcogA==
x-ms-office365-filtering-correlation-id: b4c97bc9-7478-483f-96e5-08d645687039
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-antispam-prvs: <DB3PR0402MB3724D27D4E18B4133F802795F5C50@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(105169848403564)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3724;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3724;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(305945005)(81166006)(1857600001)(7736002)(186003)(8676002)(68736007)(110136005)(476003)(2616005)(8936002)(486006)(50226002)(97736004)(2501003)(52116002)(478600001)(386003)(102836004)(6506007)(81156014)(99286004)(106356001)(105586002)(25786009)(26005)(4326008)(66066001)(6116002)(3846002)(36756003)(2900100001)(14454004)(53936002)(2906002)(6512007)(256004)(14444005)(6486002)(5660300001)(2201001)(6436002)(86362001)(316002)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oaUJh8VedSvxRK44xhLARmPiz6nt7ZV5qtS9YeTyDn+mOpFEfUurRF61Eqwt5KX6ek31b12ipl2IWjd29Qsnz+FcrWer9/ERXUOIDGyQesCIZpGO8F9Sr2jtCxYdmLhX/7Fcf4flJRL9QeGrTCHUXTMNWqQ14/XQ4lrPxFcwUwsvxcIVcWexhSxG7eZmKMAjusFxFZtyq7dp328h7kuocP58MZLx6IrOXs/+kms6rCjc4V+vF0AfWVt8ZQTQw8s5bHUWPwg8LeLCyWyyvD6g94mILCNol+t1eF2Q2cZKcR89wrDhH7L29ms7sm2evvl4+BEB2iAXQnrdtMKXxM67L6oUTNcg36rdGx3JG+4QUIA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c97bc9-7478-483f-96e5-08d645687039
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 10:53:38.4991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the time window of noirq suspend and noirq resume,
if a GPIO pin is enabled as system wakeup source, the
corresponding GPIO line's IRQ will be unmasked, and GPIO bank
will NOT lost power, when GPIO irq arrives, generic irq handler
will mask it until GPIO driver is ready to handle it, but in GPIO
noirq resume callback, current implementation will restore the IMR
register using the value saved in previous noirq suspend callback
which is unmasked, so this GPIO line with IRQ pending will be
unmasked again after GPIO IMR regitster is restored, ARM
will be triggered to handle this IRQ again, because of the
change of commit bf22ff45bed6 ("genirq: Avoid unnecessary low
level irq function calls"), the mask_irq function will check
the status of irq_data to decide whether to mask the irq,
in this scenario, since the GPIO IRQ is being masked before
GPIO noirq resume, IRQD_IRQ_MASKED flag is set, so the second
time GPIO IRQ triggered by restoring GPIO IMR register, the
irq_mask callback will be skipped and cause ARM busy handling
the GPIO IRQ come all the way and no response to user anymore.

To make the scenario easy to understand, I take GPIO1_0 for
example when it is used as wake up source:

1. GPIO1_0 is enabled as wakeup source, it will be unmasked;
2. In noirq suspend, GPIO driver saves GPIO1_0's mask state in
   IMR register as "unmasked";
3. System go into suspend;
4. GPIO1_0 IRQ arrives, system wakes up;
5. Before noirq resume phase, ARM handles the GPIO1_0 IRQ, set
   IRQD_IRQ_MASKED flag and call GPIO irq_mask callback to mask
   it, as GPIO driver is NOT ready to handle it, now GPIO1_0
   IRQ is masked;
6. In GPIO noirq resume, GPIO driver restores GPIO registers,
   GPIO1_0 IRQ will be restored to unmask state again and system
   IRQ triggered;
7. ARM handles GPIO1_0 IRQ again, this time the GPIO1_0 will NOT be
   masked since its irq_data already has IRQD_IRQ_MASKED flag set;
8. GPIO1_0 IRQ keeps coming, ARM will be busy handling it but always
   skip the irq_mask operation, system no response.

Although this issue is exposed by commit bf22ff45bed6 ("genirq: Avoid
unnecessary low level irq function calls"), but actually we should
skip the GPIO IMR register restore, as the IMR register is NOT
atomic during the time window of GPIO noirq suspend and noirq resume,
it could be changed by ARM if there is GPIO IRQ pending at this window.

For the scenario of GPIO bank lost power, that means no GPIO pin is
enabled as wakeup source, all GPIO IRQs will be masked and it is
same as the reset value when GPIO bank power ON, so no issue for
this case.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/gpio/gpio-mxc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 5c69516..3d74ad7 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -531,7 +531,6 @@ static void mxc_gpio_save_regs(struct mxc_gpio_port *po=
rt)
=20
 	port->gpio_saved_reg.icr1 =3D readl(port->base + GPIO_ICR1);
 	port->gpio_saved_reg.icr2 =3D readl(port->base + GPIO_ICR2);
-	port->gpio_saved_reg.imr =3D readl(port->base + GPIO_IMR);
 	port->gpio_saved_reg.gdir =3D readl(port->base + GPIO_GDIR);
 	port->gpio_saved_reg.edge_sel =3D readl(port->base + GPIO_EDGE_SEL);
 	port->gpio_saved_reg.dr =3D readl(port->base + GPIO_DR);
@@ -544,7 +543,6 @@ static void mxc_gpio_restore_regs(struct mxc_gpio_port =
*port)
=20
 	writel(port->gpio_saved_reg.icr1, port->base + GPIO_ICR1);
 	writel(port->gpio_saved_reg.icr2, port->base + GPIO_ICR2);
-	writel(port->gpio_saved_reg.imr, port->base + GPIO_IMR);
 	writel(port->gpio_saved_reg.gdir, port->base + GPIO_GDIR);
 	writel(port->gpio_saved_reg.edge_sel, port->base + GPIO_EDGE_SEL);
 	writel(port->gpio_saved_reg.dr, port->base + GPIO_DR);
--=20
2.7.4

