Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C434DC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CE720666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CqZAixOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CE720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbeJAHRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:04 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728961AbeJAHRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZNqkzr3vCrWMVfcyLnU9Ppo/Gi0mE1Y7/qcd7Cl2c0=;
 b=CqZAixOFMPC/j08JCnzygTB+nXbpRseGsX1sMfG29GfKKzORb5Qtq5OOoImflwPxRPIzQcfBRmZJBWzpzpl02SBQyy7kBePzn9nTFXiOCCkNBWW0utFi9dhQXAx4M6PoftLg6iYTzHsxEGfvFsbKhkVCmGFtcSFItAJ1Icbnk9c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 02/13] pinctrl: msm: Really mask level interrupts
 to prevent latching
Thread-Topic: [PATCH AUTOSEL 3.18 02/13] pinctrl: msm: Really mask level
 interrupts to prevent latching
Thread-Index: AQHUWR+H3+lbzzkMJ06RamYq4APPiw==
Date:   Mon, 1 Oct 2018 00:41:44 +0000
Message-ID: <20181001004139.147341-2-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:GvNC9mXK7/Yl/dOyLE9pQwbAIEGJIpxwLrrlRXcmEkBAoQlLBNpEj/0Y41vBXZErz6DAZGPHNCq6pySLSDgVr5+X372TeTKjQ1E4uQSe/t1CRnPqftGdqfS0NIbLOpxLf8cdN0NW3oWITZcf5xLiZdBxksMZgVcoZWp+cUBYfygRj6UMWOZtxu4GLQVt0Zj97yP9zDcahngW+E+VZ2lXrPuxNsOLHtsDzqMXUJxC9CrHDXsXlyrN2vEScx6QKGz7mKUfPBMorOIVsCMdaMjlfZISDvOhNxRmaDD64TY2R47ZExBD+kj0jk7fFuIESheRChlu1jGJPJLPrfdZmPphfW4/arDe4jTd5/aRchwI2gCEKBBKJ67mJssFcrwch0oaXcoKgWQTdL67Kw/j7jifK3x6c6/uAW2EH/Z/e6aX3uduMgsnK21Qj3BbXTZyiIo6FrjTDpgEpQGQPlCPJFfcng==;5:Q2wBfVmrF9EeAVOMiYN9qEUt9r457wnquL9FIBFrHPF23rfftUBp3HIpD9XO8Cvb3qrL4aRQ613fl1q9uSkbqitWDXevgJKlQYLnqw5uklBEQQqetukCbxHi4fuzcp38rHaLQet7hLHdsAGv1A24WyNG6t/UcG9KBgUpuuX+U7U=;7:GCpacp+UUaEoUz/nVn8edOgALcb+B0HKKIzZ4kYQMU86/kdmVcj3SqIE+HWJsPdm6f+uo+apEFp/Ygh2JKW4JPJOZ7NA3Q39pK57h9m6gULdhhxOSn/BJjdFUeFfmeSe2uKh2ZP0xnLyo8sc8myFDYSdhf9mmK1Zl1kLH82kdVtaz4yLKn6iwHLukxEP0hDoYdKTn71bndJpWPjVA/jkeHrVrcJ2fD4HZca9y6vk9cxwYlJHjtUXhtQWWQFHQKgZ
x-ms-office365-filtering-correlation-id: 36532e97-8282-4310-62b2-08d62736a9ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0791B8AF8CD3E04E2D48AAAFFBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CMtENJZxOt2DOZrYkKPd1WB+3F5lKlKIVfwfG9Ma8zJPcbvha24apZe+m1MbxOofLIkDtxyZr1lrbz3e/mCOLOOPl0xbH9+Zdwj0JD9f9/UVi56OqbJHqT1f4AUkEl1tu7kSUDNtl/s0B5DsQL4cFbm8Z8M3UVwVHb7EuUbc17oX/bpH/BOZ/PDreXCa+lTiXPtthetCRx7UsuBoljyHKaD1PvZuNgDLPSTP7Zqem4l5YbzHUvhCcq/MMQ211aH+AeUDKG4UsiulwnFjcuQOafgfc0ItEgnNclxMO/AImYDHQiy0JjESztLi0SX+ZhYR1BZ3vgTmRUeZD3pyJ8x2bD9T9x/bNr4Dpfll3Xcm5vs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36532e97-8282-4310-62b2-08d62736a9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:44.9135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
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
index db4c22dd07fa..9824e36ad7b9 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -596,6 +596,29 @@ static void msm_gpio_irq_mask(struct irq_data *d)
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
@@ -617,6 +640,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	spin_lock_irqsave(&pctrl->lock, flags);
=20
 	val =3D readl(pctrl->regs + g->intr_cfg_reg);
+	val |=3D BIT(g->intr_raw_status_bit);
 	val |=3D BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
=20
--=20
2.17.1
