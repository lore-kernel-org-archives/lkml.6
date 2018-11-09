Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4409C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7204020818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eJV+y5rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7204020818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeKIUXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:23:18 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:31424
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728112AbeKIUXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gex05uPOiAHhvMVTFVOftQYW4eLiQvYGwKPXXenI9Rs=;
 b=eJV+y5rbZa/5sIBlXw5vi/p8zEotruDKEtRSc5a4tXupV8cfIuhZoM1/1BzqqTGxwBJudXzzdnzMifQHKu4qgVYtSAuPDoshdvC66FRdNZ2b3QwcaEWRUslX5DyGAWbV1IvszG7kqAtm/5sRz8qjEHXg80ycFfbbGgUfJU1BVvc=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB2702.eurprd04.prod.outlook.com (10.175.22.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 10:43:13 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::d3b:2db7:e2cb:cc45]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::d3b:2db7:e2cb:cc45%2]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 10:43:12 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] driver: clocksource: Add nxp system counter timer driver
 support
Thread-Topic: [PATCH 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Index: AQHUeBkDAucwDPPD20ia0C1fJ7HunA==
Date:   Fri, 9 Nov 2018 10:43:12 +0000
Message-ID: <1541760402-17274-2-git-send-email-ping.bai@nxp.com>
References: <1541760402-17274-1-git-send-email-ping.bai@nxp.com>
In-Reply-To: <1541760402-17274-1-git-send-email-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::25) To VI1PR0402MB3519.eurprd04.prod.outlook.com
 (2603:10a6:803:8::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2702;6:AajHuFup0GLge5A/hEvrvcmu8I06sKMDWUpqp8qmDRMX8MZoz/T6bT3Teub3IJHhkixTsCSxcQWAqHe/oHJfxYvPJJXxY82A65BpeIvB5xoIQSICzpb2ks1/OeyQ8Ta0xNa79lEVA222964L3sc1eZN1qSMzd0Zb58/uf97sw67PPza6Z2UF4vKF4GhIgM04sCuX5RnBfxzNyCwNfMtoGJDj85Hyz6WKcfBVh/84VSRE0t3cDKJW28ZLhMrpDeFM4+VFwKz3Cm3mFAOO5RX2Q1w5Ul426WyUDRP2BrmqrCU8Ti8DipfGmrIqPGhHTFIfeN0vPz0F/p7+vAQJNh9PF1Lk+Mgl2OvhMrF6NizYDxagQnOjpsOlSFniwEn3PFndMRUqDvw+DUhe1mnnjGp59EEzYGJ5T0mNw8nvRUjiTlln17YmFlsi/DWmC8u7kLsE23KkAq6Iyb7VMjX5XT0Pug==;5:eD1SO2kdB8U9bXOqQCYtX2nJXL3EnShEcBncNfgeKaGRTRpNuOFoLjgD7zqF9LJ0rzCQ8vohq3BdIsW7OWVHibkoUI4yUNPTX8GXxie8PJNeMy6506TRroaee7cA/uuQfst2Ahelo5YpTk2T83M3BTXlX5ARdux+tM1TBxLtO/o=;7:A8+qxJzfna7SphDEKCzdDPuY3CldUgbIB7D6m24tWDkaX+FMbOwrkCi44bVLK2r/R5jgzi9jHfceUiqdf5fsh9UNHTUKF3blX5Y5JYRtdJJtU+JqE1Pb6acwUpdtv8EHJuliNK/Vxf7st9zx8uKHKA==
x-ms-office365-filtering-correlation-id: 087a302b-2ea0-4865-0317-08d6463025b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2702;
x-ms-traffictypediagnostic: VI1PR0402MB2702:
x-microsoft-antispam-prvs: <VI1PR0402MB270269CA027F52DDA81B559B87C60@VI1PR0402MB2702.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2702;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2702;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(346002)(39850400004)(189003)(199004)(486006)(14454004)(476003)(11346002)(2616005)(3846002)(6116002)(25786009)(76176011)(14444005)(102836004)(305945005)(99286004)(71190400001)(26005)(2501003)(81166006)(386003)(6506007)(6436002)(7736002)(71200400001)(2900100001)(446003)(52116002)(5660300001)(6636002)(4326008)(81156014)(256004)(36756003)(8676002)(478600001)(54906003)(66066001)(110136005)(2906002)(97736004)(6512007)(53936002)(8936002)(186003)(50226002)(6486002)(575784001)(86362001)(68736007)(106356001)(316002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2702;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UFexO6eKOnyxCF2syaMc+x5i1ijjdR8LPsHYiSiQ8WFCCpOrwQfEmYUYH4CusOFX1+680YKn/vkGGQpQEdxn/mj8DZSkr0ZUZOMWzmYaW/PtUWCIGgW7u7m7Gkd5efvlvaAm48ge0omcFjt9sHe1UpxFLwOlswNBIJamxTYbbQIc6uI68RrGFvt8QK+gB9eYfX5GwGtEy0mJb4McqE0zV0yVlIdE2h1sS6ZpheXPmHrlC6TnhNBDg0IRpOguxHOWd5pw62BzVoaKxLr7gn+QGoRoVxZlYTAElRWlpuay04jQBMEMDOdQNnHTGDf9B+q3F/LAj4BxsVtPVHVWS61XV0dEhrsDWPS2yxsuKuVZKWg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087a302b-2ea0-4865-0317-08d6463025b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 10:43:12.8429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2702
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system counter (sys_ctr) is a programmable system counter
which provides a shared time base to the Cortex A15, A7, A53 etc cores.
It is intended for use in applications where the counter is always
powered on and supports multiple, unrelated clocks. The sys_ctr hardware
supports:
 - 56-bit counter width (roll-over time greater than 40 years)
 - compare frame(64-bit compare value) contains programmable interrupt
   generation

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 drivers/clocksource/Kconfig            |   8 ++
 drivers/clocksource/Makefile           |   1 +
 drivers/clocksource/timer-imx-sysctr.c | 204 +++++++++++++++++++++++++++++=
++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/clocksource/timer-imx-sysctr.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba..cae0145 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -591,6 +591,14 @@ config CLKSRC_IMX_TPM
 	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
 	  clocksource.
=20
+config CLKSRC_IMX_SYS_CTR
+	bool "Clocksource using i.MX system counter" if COMPILE_TEST
+	depends on (ARM || ARM64) && CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	help
+	  Enable this option to use IMX system counter timer as
+	  clocksource.
+
 config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
 	select TIMER_OF if OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index e33b21d..a03b200 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_CLKSRC_MIPS_GIC)		+=3D mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+=3D tango_xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+=3D timer-imx-gpt.o
 obj-$(CONFIG_CLKSRC_IMX_TPM)		+=3D timer-imx-tpm.o
+obj-$(CONFIG_CLKSRC_IMX_SYS_CTR)	+=3D timer-imx-sysctr.o
 obj-$(CONFIG_ASM9260_TIMER)		+=3D asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+=3D h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+=3D h8300_timer16.o
diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/t=
imer-imx-sysctr.c
new file mode 100644
index 0000000..ad3c27f
--- /dev/null
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2017-2018 NXP
+
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/delay.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#define CNTCV_LO	0x8
+#define CNTCV_HI	0xc
+#define CMPCV_LO	0x20
+#define CMPCV_HI	0x24
+#define CMPCR		0x2c
+
+#define SYS_CTR_EN		0x1
+#define SYS_CTR_IRQ_MASK	0x2
+
+static void __iomem *sys_ctr_rd_base;
+static void __iomem *sys_ctr_cmp_base;
+static struct clock_event_device clockevent_sysctr;
+
+static inline void sysctr_timer_enable(bool enable)
+{
+	u32 val;
+
+	val =3D readl(sys_ctr_cmp_base + CMPCR);
+	val &=3D ~SYS_CTR_EN;
+	if (enable)
+		val |=3D SYS_CTR_EN;
+
+	writel(val, sys_ctr_cmp_base + CMPCR);
+}
+
+static void sysctr_irq_acknowledge(void)
+{
+	u32 val;
+
+	/* clear th enable bit(EN=3D0) to clear the ISTAT */
+	val =3D readl(sys_ctr_cmp_base + CMPCR);
+	val &=3D ~SYS_CTR_EN;
+	writel(val, sys_ctr_cmp_base + CMPCR);
+}
+
+static inline u64 sysctr_read_counter(void)
+{
+	u32 cnt_hi, tmp_hi, cnt_lo;
+
+	do {
+		cnt_hi =3D readl_relaxed(sys_ctr_rd_base + CNTCV_HI);
+		cnt_lo =3D readl_relaxed(sys_ctr_rd_base + CNTCV_LO);
+		tmp_hi =3D readl_relaxed(sys_ctr_rd_base + CNTCV_HI);
+	} while (tmp_hi !=3D cnt_hi);
+
+	return  ((u64) cnt_hi << 32) | cnt_lo;
+}
+
+static u64 notrace sysctr_read_sched_clock(void)
+{
+	return sysctr_read_counter();
+}
+
+static u64 sysctr_clocksource_read(struct clocksource *cs)
+{
+	return sysctr_read_counter();
+}
+
+static int __init sysctr_clocksource_init(unsigned int rate)
+{
+	sched_clock_register(sysctr_read_sched_clock, 56, rate);
+	return clocksource_mmio_init(sys_ctr_rd_base, "i.MX sys_ctr",
+				     rate, 200, 56, sysctr_clocksource_read);
+}
+
+static int sysctr_set_next_event(unsigned long delta,
+				 struct clock_event_device *evt)
+{
+	u32 cmp_hi, cmp_lo;
+	u64 next;
+
+	sysctr_timer_enable(false);
+
+	next =3D sysctr_read_counter();
+
+	next +=3D delta;
+
+	cmp_hi =3D (next >> 32) & 0x00fffff;
+	cmp_lo =3D next & 0xffffffff;
+
+	writel_relaxed(cmp_hi, sys_ctr_cmp_base + CMPCV_HI);
+	writel_relaxed(cmp_lo, sys_ctr_cmp_base + CMPCV_LO);
+
+	sysctr_timer_enable(true);
+
+	return 0;
+}
+
+static int sysctr_set_state_oneshot(struct clock_event_device *evt)
+{
+	/* enable timer */
+	sysctr_timer_enable(true);
+
+	return 0;
+}
+
+static int sysctr_set_state_shutdown(struct clock_event_device *evt)
+{
+	/* disable the timer */
+	sysctr_timer_enable(false);
+
+	return 0;
+}
+
+static irqreturn_t sysctr_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt =3D &clockevent_sysctr;
+
+	sysctr_irq_acknowledge();
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct clock_event_device clockevent_sysctr =3D {
+	.name			=3D "i.MX system counter timer",
+	.features		=3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ,
+	.set_state_oneshot	=3D sysctr_set_state_oneshot,
+	.set_next_event		=3D sysctr_set_next_event,
+	.set_state_shutdown	=3D sysctr_set_state_shutdown,
+	.rating			=3D 200,
+};
+
+static int __init sysctr_clockevent_init(unsigned long rate, int irq)
+{
+	int ret;
+
+	ret =3D request_irq(irq, sysctr_timer_interrupt, IRQF_TIMER | IRQF_IRQPOL=
L,
+		    "i.MX system counter timer", &clockevent_sysctr);
+	if (ret) {
+		pr_err("Failed to request i.MX sysctr timer irq\n");
+		return ret;
+	}
+
+	clockevent_sysctr.cpumask =3D cpumask_of(0);
+	clockevent_sysctr.irq =3D irq;
+	clockevents_config_and_register(&clockevent_sysctr,
+			rate, 0xff, 0x7fffffff);
+
+	return 0;
+}
+
+static int __init sysctr_timer_init(struct device_node *np)
+{
+	u32 rate;
+	int irq, ret =3D 0;
+
+	/* map the system counter's CNTreadbase */
+	sys_ctr_rd_base =3D of_iomap(np, 0);
+	if (!sys_ctr_rd_base) {
+		pr_err("Failed to map sys_ctr rd base%pOF\n", np);
+		return -ENXIO;
+	}
+
+	/* map the system counter's CNTcomparebase */
+	sys_ctr_cmp_base =3D of_iomap(np, 1);
+	if (!sys_ctr_cmp_base) {
+		pr_err("Failed to map sys_ctr compare base%pOF\n", np);
+		ret =3D -ENXIO;
+		goto out_free2;
+	}
+
+	/*
+	 * the purpose of this driver is to provide a global timer,
+	 * So only use one compare frame, request frame0's irq only.
+	 */
+	irq =3D irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		pr_err("Failed to map interrupt for %pOF\n", np);
+		ret =3D -EINVAL;
+		goto out_free1;
+	}
+
+	if (of_property_read_u32(np, "clock-frequency", &rate)) {
+		pr_err("Failed to get clock frequency %pOF\n", np);
+		ret =3D -EINVAL;
+		goto out_free1;
+	}
+
+	sysctr_clocksource_init(rate);
+	sysctr_clockevent_init(rate, irq);
+
+	return 0;
+
+out_free1:
+	iounmap(sys_ctr_cmp_base);
+out_free2:
+	iounmap(sys_ctr_rd_base);
+	return ret;
+}
+TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);
--=20
1.9.1

