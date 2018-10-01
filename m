Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A46FC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4415020840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lCzTQ4uG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4415020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeJAH3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:29:09 -0400
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:52496
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbeJAHNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1AaiNCqaTb9h0uZQ2lJnFQbQ7SOw4nxP8Nz5iXnGfE=;
 b=lCzTQ4uGM37MJJCi+t3jdeJqV4o5VwqmE4GIVnur4439t4Ss+Pj+J93eid0wKVBJRNcVhXH5sojJTSvtJjLxp9+AKy6JTZzQ8sYV0TUklYmpCsuiN4l1GQZIKzVGfYWzNmPON8NzQo3UJIRbrI67+opoRkasXbyWIipXstETbMs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 06/65] pinctrl: msm: Really mask level interrupts
 to prevent latching
Thread-Topic: [PATCH AUTOSEL 4.18 06/65] pinctrl: msm: Really mask level
 interrupts to prevent latching
Thread-Index: AQHUWR8E0EMaU0vSKEKjeFPan9beWA==
Date:   Mon, 1 Oct 2018 00:38:05 +0000
Message-ID: <20181001003754.146961-6-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:ad9PgP6XFqTpiwjmyYPczCMcEHZizjiS4aRASu7tQup0ZAyl8AJ7z+/iBKhinwOaGboRcUrKQKuqinLdKIXzHAG/+zvL+K7oqkujJWn8RoYTo/w1zaGvgWLh6BeRI6Z4Aca71yuUHCQug7wwBBMkDjz6Ek7ronzyt8CSmCsB9Rz24E1aRmnnAyrqfub2qmZ8K2fRb7p5ZhzctHT/DlGrhUNbAY+/pAAIWoxBNt2rtn4OOsld9V75ZdmPwzsavogjTZhzK08AIzK/hvQkY5MnYOVlao7dlt7K2WdlnNY5uTTFG7u4KQ7xgHVufGLRCgSZrEO8tWiz3EEPtdo3huEOd5Qn01wK6BNqWkW19dAkiMlGZajuFMiUQlrFEAd/hJttJNj5/0s9a4Wox4BwDiiq43rX4fsOW2fQDDn7s8EZ6JyQpax5s1OeL9mI6q9CDvBr3q/Ry/eOyD7TL7xx4BRuLw==;5:mWQu5Kx2cPnAXfUYwN3WL7hsp2/67LvgiagvVAtbvQrHVawdhbVksqYjmVHQkp7M2DbqLbL61T/HEjWmjuqt57IV4YVXsBdiigIqrI+VkK5Q9P3/ZtAAhACww+PV2A5+xcNe/0SZlDlm4QqaBprGA2zn/cLrbgH5Ii+ZoripmoY=;7:Js70gD2CqhAhHNEA8cvb7gZafzUbhteh5zFju+bHnphckYZ28jstysAZRdvKFxo8gymg4YUbmbvDjWzr/w6sfu+mYznFY6uTJ0GvdHFIPuquUAV5arzhuJsQaSSQIhG1oCL1qjKe03YC/DQOMpYlODv7l/hGZPs12OkrJ7tWxKaKKxB7Yaf3dJFdpwaNd7U7if8MZuYgAvry0J86W0Lh+UkHc/LAcnSLH67Qw/AKT4HTnBgEKJUPkrepMqzq9OBt
x-ms-office365-filtering-correlation-id: 5cf45be2-efde-4c2a-3246-08d62736274f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04698168CD2EEEFB73332901FBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5250100002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(14444005)(478600001)(34290500001)(6506007)(2906002)(7736002)(86612001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(76176011)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(107886003)(2900100001)(102836004)(6486002)(6436002)(53936002)(11346002)(446003)(26005)(66066001)(2616005)(476003)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3c6B+UJrmYqSs45oKlb6Y7FpZE03iKMJeqYgAkEI0xe4W4ytOJyYYPlpYsh8BmZ8lM2/5r17agiv4rHTazCCKSSvlnReDeVpvYuafLWaZDxWDmf39ooR+ZJRFS8fZpKn/Hz8DdtytfTKQzIXh/9mazfMRP6BBusbHFcQx/sVaCncPzTc7hsNZUMsXn5oDdc8/AvDqlHB079MpTyluqMkmPdN61fX0MXf2Afdrv/EKNFEItcPbcRr/+5q+jmYnOVSD+myG93gWBKmDE72YAGEjsv2/ssrlwFaGlgPK+WkhcTI5RVFlKciuPD+laZl4Em4wRPQaGOtcEua/K3Qa81ro3jKQDMxjxUM4MpnnUWdFoY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf45be2-efde-4c2a-3246-08d62736274f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:05.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit b55326dc969ea2d704a008d9a97583b128f54f4f ]

The interrupt controller hardware in this pin controller has two status
enable bits. The first "normal" status enable bit enables or disables
the summary interrupt line being raised when a gpio interrupt triggers
and the "raw" status enable bit allows or prevents the hardware from
latching an interrupt into the status register for a gpio interrupt.
Currently we just toggle the "normal" status enable bit in the mask and
unmask ops so that the summary irq interrupt going to the CPU's
interrupt controller doesn't trigger for the masked gpio interrupt.

For a level triggered interrupt, the flow would be as follows: the pin
controller sees the interrupt, latches the status into the status
register, raises the summary irq to the CPU, summary irq handler runs
and calls handle_level_irq(), handle_level_irq() masks and acks the gpio
interrupt, the interrupt handler runs, and finally unmask the interrupt.
When the interrupt handler completes, we expect that the interrupt line
level will go back to the deasserted state so the genirq code can unmask
the interrupt without it triggering again.

If we only mask the interrupt by clearing the "normal" status enable bit
then we'll ack the interrupt but it will continue to show up as pending
in the status register because the raw status bit is enabled, the
hardware hasn't deasserted the line, and thus the asserted state latches
into the status register again. When the hardware deasserts the
interrupt the pin controller still thinks there is a pending unserviced
level interrupt because it latched it earlier. This behavior causes
software to see an extra interrupt for level type interrupts each time
the interrupt is handled.

Let's fix this by clearing the raw status enable bit for level type
interrupts so that the hardware stops latching the status of the
interrupt after we ack it. We don't do this for edge type interrupts
because it seems that toggling the raw status enable bit for edge type
interrupts causes spurious edge interrupts.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinc=
trl-msm.c
index 2155a30c282b..5d72ffad32c2 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -634,6 +634,29 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
=20
 	val =3D readl(pctrl->regs + g->intr_cfg_reg);
+	/*
+	 * There are two bits that control interrupt forwarding to the CPU. The
+	 * RAW_STATUS_EN bit causes the level or edge sensed on the line to be
+	 * latched into the interrupt status register when the hardware detects
+	 * an irq that it's configured for (either edge for edge type or level
+	 * for level type irq). The 'non-raw' status enable bit causes the
+	 * hardware to assert the summary interrupt to the CPU if the latched
+	 * status bit is set. There's a bug though, the edge detection logic
+	 * seems to have a problem where toggling the RAW_STATUS_EN bit may
+	 * cause the status bit to latch spuriously when there isn't any edge
+	 * so we can't touch that bit for edge type irqs and we have to keep
+	 * the bit set anyway so that edges are latched while the line is masked.
+	 *
+	 * To make matters more complicated, leaving the RAW_STATUS_EN bit
+	 * enabled all the time causes level interrupts to re-latch into the
+	 * status register because the level is still present on the line after
+	 * we ack it. We clear the raw status enable bit during mask here and
+	 * set the bit on unmask so the interrupt can't latch into the hardware
+	 * while it's masked.
+	 */
+	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK)
+		val &=3D ~BIT(g->intr_raw_status_bit);
+
 	val &=3D ~BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
=20
@@ -655,6 +678,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
=20
 	val =3D readl(pctrl->regs + g->intr_cfg_reg);
+	val |=3D BIT(g->intr_raw_status_bit);
 	val |=3D BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
=20
--=20
2.17.1
