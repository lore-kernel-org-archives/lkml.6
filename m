Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843CAC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C9B2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G0aWuLcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C9B2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeJAHY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:24:29 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729438AbeJAHOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vasee1INXB3t362RCRuR87ae+JMUB+pwJWmotb8e/o=;
 b=G0aWuLcdy6TBMNg9dX9tRUdU1VqRaq0dSMWSKMmLIJAOtcrKSjKVg93fDNgiIV41vNPCezUOkCZ1E4oVIOnKsbCyCaIVBQOOH8Yb7j7tR9gmsT918bwAx+B79qGO2+AXPEmkeakEVFg/d5RgYXIBaDY0L5W3wdNDqwtJXaZJjJo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 04/37] pinctrl: msm: Really mask level interrupts
 to prevent latching
Thread-Topic: [PATCH AUTOSEL 4.14 04/37] pinctrl: msm: Really mask level
 interrupts to prevent latching
Thread-Index: AQHUWR8iHbctqYI5cE+vekwlI6q51g==
Date:   Mon, 1 Oct 2018 00:38:55 +0000
Message-ID: <20181001003850.147107-4-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:VT27bKUn7rataMlUIW+6Uf68EdjQl4vlEv3OR6dbqlh+B9tjVXyyQu9d7zLac4TEnubMm7Dbqcd3zSZp5eNk+xpmuKLAXbV5qwWvnm/h9mQCiFqUGVn1kht4NJyJuktFoMHbevUxfzCAfE7AhHJ4gXM7zpGluXaiJaQ8SHVY10zdW9l7WaG/N2XSHJi1IMTjetsnaZAO01lGpqdKqKkLFLnnyUJuQMl6ThiMlV9Jce1DRJ2QH8xCRML9K5ap36Yk0A8n1XnEwcBhPicp6Hc7fNRlglBJXIsRJHOiusmIyccCdcTV/LXnLGcPfN7850UGroyl3N7HikQUcXu/qw9C3JTOVixsJbEZ75Lf3jLat/ddNsfLuedc7b9QppeRXCb6d/oNo0K1y491j9bbmkEX8zLE5qPThc6PcmhP3qIZ4LeTo9yU94/5xZnn4pk/ZrMJjt+4bd90ok96DOo5emEOCg==;5:oiuTz2Qf3OTC896wi8p24L4WmiVNBeW3a2ALKgxNKbROKmNB6kXuZijZUUqxCDNnaWd3zB/RmvMd71dRuFs/+cgau6EzQnR780n7PF4xqA4EblF0ZAb0LyoEFT2+B51WYLpbxAJhEeLjAbitaI3N3l3bpeZ8mmHVMg9INoZqSKw=;7:PxeNWxRLsfy7TuvUTrvnjPoZLgja12M6eAgPoz+uIPX3rPVkE+Jv0mYxGDQ6KBz0FY4ceBP4RgT8LBLHMt02G/qHuUXF+DaFfreix6IPWgWutSQ76oqk37516JSZZqHSWIvdRppApPsw2SUZyNj+aldIyPzkdAyYOK2+DREXJPWLVxSmUUyyU9Q5DWkPv/DH0oQAwRe16f8OENEXIxoZOOe8B04SVfFi5F5HlvRRQ4xfi4mWKRaWaAk9L7O+0GQr
x-ms-office365-filtering-correlation-id: f7fdea9a-ed7c-4318-cd41-08d627365ec7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0696EBDCB2192C17BB52E536FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AGGSdjw+tT9gXGhZF+gV93PLZOW5DlpVmYIsYjqE31ADF/1yBKH2zlNhZczMwDWF9NarRVWSUCRpJ/5cVWJF3YxHdJ2KPCzkflaH6ozzs/rVS/pJdklKtRHjDRuM/ddG/jau6uHiuzD2JdHlx64ynvXAb5ZHuyBGScN57ZDf9eqa0A5rJTjZ4vLmaKWxI4/Qz1+yeXVMltju4417plyFnb13AakP2msj143fiFwBa1kx8/O7WwlScghVdR9O6SDHwalHC4fphvMM84ZHDOrMxrOYf8nCzuc7rLQeBG3+hyMH+6l0dqRIWJBllyXrI11UN45h7ifcbjHPUkQ4iTb2lkIr6/ZCPUtxZtmdNwl4eJE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fdea9a-ed7c-4318-cd41-08d627365ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:55.0988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
index 31632c087504..3effb124bad9 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -610,6 +610,29 @@ static void msm_gpio_irq_mask(struct irq_data *d)
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
@@ -631,6 +654,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
=20
 	val =3D readl(pctrl->regs + g->intr_cfg_reg);
+	val |=3D BIT(g->intr_raw_status_bit);
 	val |=3D BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
=20
--=20
2.17.1
