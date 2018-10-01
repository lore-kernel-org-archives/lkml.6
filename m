Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC6C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB47720666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PByLUR7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB47720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeJAHTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:19:43 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:55885
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728769AbeJAHQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y66TjuLCWCdsXMU1m6+mfSs+dY7G1C7+TeC8oKgIEfA=;
 b=PByLUR7WFrMe4QVr0fjZLQ7BFdEN+LfhMrUoIzSDOxJIwwU4z2xCZv7ZkBj/62BT/iQX8UgAKPCtcRqblgTv+H51ZLGwF4MSxr0Vzw6OpjavkoFOMSYjQf/b59WdpqeHqvxyqoDX4ZeYl32grCxU5SIxEts8GQO7mr/BkhPr/Zc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:41:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 02/17] pinctrl: msm: Really mask level interrupts
 to prevent latching
Thread-Topic: [PATCH AUTOSEL 4.4 02/17] pinctrl: msm: Really mask level
 interrupts to prevent latching
Thread-Index: AQHUWR98YQNPgHj1LEyBnwWRPlOTEA==
Date:   Mon, 1 Oct 2018 00:41:26 +0000
Message-ID: <20181001004122.147276-2-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:jwKDnr/WMDNZKl+KAx7lA+y+RDdTrPVQw8oa9NlPZh7gK1hcKWC6VljopBCy7t6ser4iNVOKuYD3v7YYFThTdTeGcFQZsmckKdJALhcgTHddi/Zp1nw0VZ2w3uI10EovcXSc9hB2YnE0ytqArl0WXA1ejSLIW5WN61OnTDVwiXdMRuKwGfqrFibq3yZNWKLVa2M2ikT1+FY7iBy1XhyfUZT9LMGtgI+9LGgQldRf8hFUuOoQXvBELMrQx2wOr3j4J+Ir3rK3uu0RSc4/2yKtM/HC0coGHkBpEjBj+XGrtaF93PkvtfXfB22h+69O7KR9N7p6djZv9aqXjBeN/gBeVusdAnZU+DM9lww68yEEmNHTyLmXgvwd0j3fOVw0EeND5EuBZAg4LtQNDzyf7Y1LBHTM38JH4uA11P3zrGBruapTPBIzAhwruXuxX2Zh20PKia7bGpu8z6KU8RoblJfjGQ==;5:MU1azoUFXWWVIqw19asW2XyXuxSZZ+8ag5oGKJmfDE/7PmiHpr244RDfoAk3SPJgbO4l8+frGGMXlPQ008FmFTQ0FHDMBf2Fy++n8y3Gc57NQs+Nlc/iLJtY1pNAIGUbHLDAt4PQBDGNzp4yLxEUqSKbxiUB/J7n0THQntHqHWQ=;7:iV9S2IQLPvc9hbP9G3DzhYmMm32UqCikPT3FyqmJGlCPRlqbOb9DxxHCbOTOOVvoOMrm72qB5z2m/ZZrbINChgUtSbWo0UICypceJN3/mHSeO0mZloJ7BPuRRGIgJ7q8pY7cxGp5sJis8/5C+lwqtEqbMlGHiQiUbSsN9NZdA02s2zV9ulenFgbp5XZDH2X7H6xkimyEyAQIFUmMS3fM+rhyfkCWhvFhw0XEsu3a5E1k6IBhYCOGKokBsxkbl4qN
x-ms-office365-filtering-correlation-id: dd2d39c1-eb84-4f20-a31c-08d627369eb4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165ADE8395C08553B8A7508FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rJUdXo+856eqhonz+2mPcpGonPN6hkB9bBT3voOWgKw960/8TRVnCvOSQ13ZA7TJzq9Y0nHYRttbrYgtTMFtMhRAIwFmaX3IXwTyKRMetK1iONJQLFes2Zm80ZFv8r58p/9/uoUOoPR0LVX18h4KaddnSea5ngBKYUTz/DqbFp/don9ZygqNPTlE7HkJ8+2fHo1HNe+DlWltkDcXAQCEur8Nz/0nnmHqXmYqS7wl9fFPDvqgHmbWI8yyrVeVtqqkRlFVzATeEsIdtxAv7DPR+haw7lFECItBvtutBu7qZDEzwO8/rHrQAqsIA5w6Hm9kWIv6hRu3rykcuCtefTmPB/FjGek5IqMFd0ZpzEJrkJ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2d39c1-eb84-4f20-a31c-08d627369eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:26.2428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index 9736f9be5447..425dae395953 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -577,6 +577,29 @@ static void msm_gpio_irq_mask(struct irq_data *d)
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
@@ -598,6 +621,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	spin_lock_irqsave(&pctrl->lock, flags);
=20
 	val =3D readl(pctrl->regs + g->intr_cfg_reg);
+	val |=3D BIT(g->intr_raw_status_bit);
 	val |=3D BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
=20
--=20
2.17.1
