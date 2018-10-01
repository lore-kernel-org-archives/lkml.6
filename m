Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F075AC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07182083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R5AxLemV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07182083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeJAHVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:21:01 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:45056
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729769AbeJAHPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejhmgSKYU4c+nadrSw8G9liq75ZynMgfv+61D8k5Css=;
 b=R5AxLemViMv+m2m+PkHaZGzqnlk4zuq8aFB42LQKCVL2qGlNIV7Wfa4Wbdhxj37UFMuEB7IsD2GqKTQGrnETTvmVRqnLbee1kYf6/DH574fvNwpfBJ94EW+yrEtDAL1hVDpBxzd6eZoy0fAgmeptuf5JLFj1rFuLuHbILjdVoDI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 03/26] pinctrl: msm: Really mask level interrupts
 to prevent latching
Thread-Topic: [PATCH AUTOSEL 4.9 03/26] pinctrl: msm: Really mask level
 interrupts to prevent latching
Thread-Index: AQHUWR9bd6qV1CoI2EWJ3WOklnVvpA==
Date:   Mon, 1 Oct 2018 00:40:31 +0000
Message-ID: <20181001004026.147201-3-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:Y+J9OaIHuBiuG5jwsHUzKGz9WkNqkq//2y3/jMiF0Mw4HYK7OvlVOdzPxqa2I0WR5yxqNEnCJUXBK6Kk7mvoy0mtb0my+/aYB46F48hBxXavNS2Y31/AQj/mdcRcmcahShoeVH47wmtF1KgZzcPjc8jyhNqP2CUI5Rt5zsllhwnu1L3yQ1LTpNeS5EGWAhaEetmAWDmdwDgpSg//6KVIZyVFKw2K2eCwJUEiGbx7SLtSF2wQDb/0p5/QVlh0yHleZ62lehEEoTva4fVfiHyNnzL3g6X7tpOX1Vx9RvFqBiD6JKTXyDqG4latcnk5FjIORbuNKJSjcz1xBV7+u/YHjvQP9hi8RXTRmzbqDex080OG4+gP3Y0Vt93Mjp4N+d/w384BR18yAMxBErEuLkEAsCNdKX0aHrXg89XPsGqIQ8wRsawdWDnMM7VuDIwNwv1SGNkdw4OBLHI8Ywv8HvN5RA==;5:r/xApE9zOW12poFRJiOOl4WoLBvhL/4AIvepTbHBirLMZmNmrOsXylZD17FLI8FUHH7GU4EuD1O6SwzmclHZtSJh7tKXpYvcso03A+z10guW2Au+QmtU+tqpmIF/Mj0pl0Vd8LbFIjkM2n4ofYkNXX2EL3OwEHLOXkKzHLWEsNY=;7:GNiGZzS5aV+oIDNqurIoaUvX4V3PFmI1qS425vjVSvAyxrqwrYpwsKyxFi28ellOJELAly3FJQ3cRf1WmatqnutAkBuLTFpy4sGf6OtzE8ncCE/VqTuTb8Ns6GsvvrCVUmgYOCQ9tdXEI2s5iPbeJbJO7l5dl08SbZ2cLrWS+2Q4YFpddwWmzh8+w0XLfU7rLMdE3EUr3VXmOkzBe3NTt10vPlOMVzdqIwhatgMsoYMCWgx1AlKegFmsOUJeDDpf
x-ms-office365-filtering-correlation-id: 3a0cebd6-3a80-497b-369c-08d627367dd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01202F3F98BF117F42218BC2FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 53ZYlAD64OxWnHB1wv9LO65930Dcnm7lnbzavo/tEmm5PDM+jbpVIij040jAQts1ZiaKf4E467uiCyJ/qT7HGx2mX7KsV9eq8AStb3phWHeVxBjEUEXP7Dix00SVTi9XIFdDKzdD/lYxhpO5cFEwjC+HnkJ+lsgEFlb4O9QOg00lVbsnF5qvbuxLUCj2clNpvZ144sjO0TEt3bdNu6EdvE0WhjgcjtmjxOMGo2DOgVp4LF5+0oZ1BvdLpoX5v84NSPQAR6A5tETliCr8uD+ui1wYSh96561qLpwtWyhbeLaoQ6abu0MuJFrwLg/ysObBJugrGmHH/smiBc4adHvcYD1WLHRAJHbfzJ0xrALpu54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0cebd6-3a80-497b-369c-08d627367dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:31.1371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index bedce3453dd3..39d79ce2d4a4 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -574,6 +574,29 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 	spin_lock_irqsave(&pctrl->lock, flags);
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
@@ -595,6 +618,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	spin_lock_irqsave(&pctrl->lock, flags);
=20
 	val =3D readl(pctrl->regs + g->intr_cfg_reg);
+	val |=3D BIT(g->intr_raw_status_bit);
 	val |=3D BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
=20
--=20
2.17.1
