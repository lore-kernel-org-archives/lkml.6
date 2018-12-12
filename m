Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64522C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8B62086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BGWU8eRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8B62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeLLF2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:28:36 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:2912
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbeLLF2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+kGvRwxD0VJDmV8mGtNA54ssmuCfplpC61ufc9buwk=;
 b=BGWU8eRkZsBEyjJ/nCye8DpKqIuZYtLkWJ3HJBuJwdZr8kSYLzgUOfB5ImmuYT8qME1sN/2Fj6jD2UBz5K8PxvnWunENkwb5slxRGx3DFosqVDP+3Djimz98WTKC06xtoy9bPkhDoXqn0P5R1jHXcl1ws11z+A8A2nBLIeOdC38=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB2942.eurprd04.prod.outlook.com (10.175.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 05:28:30 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::15e0:9552:81b4:33b]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::15e0:9552:81b4:33b%4]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 05:28:29 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Topic: [PATCH v2 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Index: AQHUkduDSPUR4D8ONkaAhIX2AZ1ftw==
Date:   Wed, 12 Dec 2018 05:28:29 +0000
Message-ID: <1544592770-19996-2-git-send-email-ping.bai@nxp.com>
References: <1544592770-19996-1-git-send-email-ping.bai@nxp.com>
In-Reply-To: <1544592770-19996-1-git-send-email-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::13) To VI1PR0402MB3519.eurprd04.prod.outlook.com
 (2603:10a6:803:8::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2942;6:ZZGXETA4f/1J2yWSkkrdMDWpaX7BPCcFWjz8I7avY8X6nJ/CX2A1P5yx0zg3+f1pmLGDSMyDku0soZPAE0RMnjxCR82pLRU0y35x9Bgnz9w4k6zJb72q7CKy0eEAVBYI931sL7RLz4EHQP4vXHsBcCUL3XFOSFA4DvWgF30eSzScbH66kTmUfJ3bZnRzeu3Foj1d5KlS+Nuho0BLXTz1pqBQZxueE4Wk+FgjDIl+Mc5oos9DVXFS80/qk8KwACDJLanVvVGGsg3FPYJv6EDoEgHUMHqktx+yA3iP3YBxmtArg2bMNC4wWHp1eOVjcPavx7ZNXkm1+d1QG+N/5fzsucn33GZ2LK/x8DNhWD57sP3llzHQP87wEff6LxwUoVmj1b+RYVLVaI7Wal5YMhGwyq/mQ+B5AneDe+uAgr+MWmowHNN+dVS0Z9O0sl3QPg4fVixHBBGpOEqBUxGWqFBzVA==;5:rwrzMUswbJe1VhcfWj2vB69DyaocXBSQKf8/5BIR/DFlspLrDQ7XYDm2VEhHkGFj43DKsQ9YOh+3mLudHPzyaSDC8jVFhP9Cp9uFvObvtTGXcJKspv3VXHq0YIp2IXlTqp7k1UW43SNZJZRj+Kmc187+UPIuN3+liuD1TZhm55E=;7:/fFoLKvEZOU8TMfAsqdd5Ep6Ws/G2tMuFCvjplLEQIR0rQxuk9GJNaJVG3OthHYCoPwHdwbK2WbPw+pw+hA3naQFJzLU0dQ2OijWk+66zYU5QiIOJQ+jkqz/B4Wv2QBkH1/ay7Vw6Csblab9Rff4XA==
x-ms-office365-filtering-correlation-id: 2996fb8e-c89f-4576-4e19-08d65ff2a62c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2942;
x-ms-traffictypediagnostic: VI1PR0402MB2942:
x-microsoft-antispam-prvs: <VI1PR0402MB29425B4E7CEBE0392CEEF0E187A70@VI1PR0402MB2942.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2942;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2942;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(110136005)(102836004)(105586002)(6506007)(386003)(575784001)(86362001)(2616005)(11346002)(446003)(99286004)(53936002)(316002)(14444005)(54906003)(25786009)(2906002)(26005)(6116002)(76176011)(3846002)(106356001)(66066001)(52116002)(256004)(6512007)(186003)(5660300001)(81156014)(4326008)(68736007)(81166006)(8676002)(8936002)(6636002)(50226002)(97736004)(305945005)(14454004)(71190400001)(478600001)(36756003)(71200400001)(6436002)(6486002)(2501003)(476003)(486006)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2942;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cRDIvgJyFSDwAFopk0FUHVYq9vrj6zk9Oj2vTv9LXMSK+h/tRDPBwMg0tFqvs9tn1Ti+5IiX208+wRMZwHa4luH/GsxkdO6bYKscL4qhfwAEezqKJ8S86QLiTgQZ3BtBb9HO6ayK/s7QmkXdaF5E54u9SfwdAa8dhMVJZ52rf6IRehHFw/N+RV2eAuptWJCVtcYyVRW7bn/XhYR4r6nuj4zjzn17lvk2fWfvFaHYzA5Mv7Eh4N4EjKyHFgNYJzx0zV6Op4qGQP52PSBwYt/7lO8RuVz4qpC3GHAKJl5Q0jvTlq47LeN8/Q34PaLGj+Rb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2996fb8e-c89f-4576-4e19-08d65ff2a62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 05:28:29.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2942
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
change v1->v2:
 - no change=20
---
 drivers/clocksource/Kconfig            |   8 ++
 drivers/clocksource/Makefile           |   1 +
 drivers/clocksource/timer-imx-sysctr.c | 204 +++++++++++++++++++++++++++++=
++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/clocksource/timer-imx-sysctr.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c57b156..7e5f2de 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -579,6 +579,14 @@ config CLKSRC_IMX_TPM
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
index dd91381..372bf4e 100644
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

