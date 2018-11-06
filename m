Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD27C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907292081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wcOUfKhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907292081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbeKFOjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:39:44 -0500
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:58720
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729016AbeKFOjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRNM/KzO9Xvaa1k5gmG7yi0o+Dqlwd7sj+zbwrlpvYU=;
 b=wcOUfKhTBNal8+XjaF65hTIBfjcc/sLWDC9dgUbP1ch77DLEbkWuNs+TZcVl+Uom38sInKjDkI+E4qeAcobHN2vRHO1GdyR4sfe45s2ogsXREoSuSSxBoc0/sddau9YX4gUxYItOCiZYDuj3p9ZFpjpvBiSf4LWBu6j+zVuNzA4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3866.eurprd04.prod.outlook.com (52.134.71.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.24; Tue, 6 Nov 2018 05:15:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.028; Tue, 6 Nov 2018
 05:15:59 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] clocksource/drivers/timer-imx-tpm: convert the driver to
 timer-of
Thread-Topic: [PATCH] clocksource/drivers/timer-imx-tpm: convert the driver to
 timer-of
Thread-Index: AQHUdY/Naxp4ADV5AUOFRnit+JKa7Q==
Date:   Tue, 6 Nov 2018 05:15:58 +0000
Message-ID: <1541481054-25186-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:36::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3866;6:waxhCaKticqPZu/20+WaFLGhC6DdwV4Jykn328sWEFS58bfvLxTFVxwlAYCGoaHJq6LSpDgAfS9IBBqZtjyaE40zef3a+bbAWsFRAJbLUyk+nSzrE2FdJh8hrSdvIrI2Ata56keLY+y0sorFG0MqUElEtl7gEWAUKcGr9t+94JtlVDNpahW8QrF2bIhpFfpXu6QUUZfYZDksFH2R4+Ucu5wD3GZAQc+MNGOj+BtrP2wBMhVKCpKRUPmCK6sqwqCjMYckQETJCYzUJ8nk81C81QGOnOaC42INOR+XXwaVwYNBjKX2wYBo2KGf4060uZ9F8yXA8kY6354rqDkGhIbNiw7sW6o7L7i23+mC14YI7x3e8wJyEI1LrdWVHRVpZITSGg1CPUG5XmZVricDgDJ5L804G0h7ZK2xD0tTHO7P6vNwszmn1qyEEvZbk149zN36KbDDDz5yo2ynJhhvJnD7hA==;5:11/IExDWuKkS7nLkOk97Yz8blYfcJax4d+XYA2VBzWDtPQLNTeJgyUv5jCg+x5HLSb8Gtyc4x6zMXPkjjkXObQznZi1HdmL8UWzowBQbVaF/XFO2FoHP+XgNAHn8VDFRv+xw9RmXoDrCrOw30w27i7VC354L5suQSMg8n50mr/M=;7:1emP5qo4Pla1nXX71re9sWcYNnAgKmobhugWyU/nguzf3rQU9UlWXoaqQ+In+KCY3ALBun1juq3YaVZJkGXXU/Af+RV5fdp42LmvXiR8avGfkaZleor97vKd3wQY8kmeRDO0vw52maQ0t8O/UUkAUQ==
x-ms-office365-filtering-correlation-id: 97ddce09-ced0-4fc5-9e65-08d643a6efb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3866;
x-ms-traffictypediagnostic: DB3PR0402MB3866:
x-microsoft-antispam-prvs: <DB3PR0402MB3866B4E59269A77B51C03779F5CB0@DB3PR0402MB3866.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3866;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3866;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(376002)(346002)(189003)(199004)(1857600001)(316002)(256004)(14444005)(2501003)(6486002)(6436002)(97736004)(14454004)(2201001)(2900100001)(36756003)(26005)(486006)(3846002)(6512007)(575784001)(476003)(478600001)(2906002)(2616005)(6116002)(50226002)(99286004)(86362001)(106356001)(68736007)(5660300001)(6506007)(386003)(186003)(102836004)(305945005)(8936002)(105586002)(7736002)(81156014)(25786009)(4326008)(8676002)(53936002)(71200400001)(71190400001)(52116002)(81166006)(110136005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3866;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iBpqsZ9E0PwIYmE0HzalW3CkR25DlL8nJLI9Xq6csWVOEAxKqRiZWwpKevKmevMWGxHfGO5b3nb4hH6ZKVZusRyOlPA7pw0yyh2cSPN/lJynrV7G+iCWthlHU4xmergYXpYYQPrKF0yqCTevLJv602umIZiWn2DDptsMM2aTlyUFHA017eDlwlC/+cWANYccFT6+lpf3oiH2Jj8fdA0TlsxYHuJkOYh6EOdFmhACwp3EtFu26JK6KAQRHTGgE8J5KZfNhCwshJ589vecz8HhH3jYogj8LeSMpdQtNHHLbgsYBUfX2flmYJSbwYYBhwcjF2GhdDOyc6E+q0Oz/Ja0E/UP47aehhSadZ/a6oNi4Q4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ddce09-ced0-4fc5-9e65-08d643a6efb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 05:15:58.9702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to use the timer_of helpers.
This allows to handle timer base, clock and irq using
common timer_of driver and it simplifies the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 136 +++++++++++++++-----------------=
----
 1 file changed, 55 insertions(+), 81 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/time=
r-imx-tpm.c
index b7aa2b8..c3dd4d2 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -12,6 +12,8 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
=20
+#include "timer-of.h"
+
 #define TPM_PARAM			0x4
 #define TPM_PARAM_WIDTH_SHIFT		16
 #define TPM_PARAM_WIDTH_MASK		(0xff << 16)
@@ -33,9 +35,7 @@
 #define TPM_C0V				0x24
=20
 static int counter_width;
-static int rating;
 static void __iomem *timer_base;
-static struct clock_event_device clockevent_tpm;
=20
 static inline void tpm_timer_disable(void)
 {
@@ -80,19 +80,6 @@ static u64 notrace tpm_read_sched_clock(void)
 	return tpm_read_counter();
 }
=20
-static int __init tpm_clocksource_init(unsigned long rate)
-{
-	tpm_delay_timer.read_current_timer =3D &tpm_read_current_timer;
-	tpm_delay_timer.freq =3D rate;
-	register_current_timer_delay(&tpm_delay_timer);
-
-	sched_clock_register(tpm_read_sched_clock, counter_width, rate);
-
-	return clocksource_mmio_init(timer_base + TPM_CNT, "imx-tpm",
-				     rate, rating, counter_width,
-				     clocksource_mmio_readl_up);
-}
-
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
@@ -137,74 +124,77 @@ static irqreturn_t tpm_timer_interrupt(int irq, void =
*dev_id)
 	return IRQ_HANDLED;
 }
=20
-static struct clock_event_device clockevent_tpm =3D {
-	.name			=3D "i.MX7ULP TPM Timer",
-	.features		=3D CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_oneshot	=3D tpm_set_state_oneshot,
-	.set_next_event		=3D tpm_set_next_event,
-	.set_state_shutdown	=3D tpm_set_state_shutdown,
+static struct timer_of to_tpm =3D {
+	.flags =3D TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.clkevt =3D {
+		.name			=3D "i.MX7ULP TPM Timer",
+		.rating			=3D 200,
+		.features		=3D CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown	=3D tpm_set_state_shutdown,
+		.set_state_oneshot	=3D tpm_set_state_oneshot,
+		.set_next_event		=3D tpm_set_next_event,
+		.cpumask		=3D cpu_possible_mask,
+	},
+	.of_irq =3D {
+		.handler		=3D tpm_timer_interrupt,
+		.flags			=3D IRQF_TIMER | IRQF_IRQPOLL,
+	},
 };
=20
-static int __init tpm_clockevent_init(unsigned long rate, int irq)
+static int __init tpm_clocksource_init(void)
 {
-	int ret;
+	tpm_delay_timer.read_current_timer =3D &tpm_read_current_timer;
+	tpm_delay_timer.freq =3D timer_of_rate(&to_tpm) >> 3;
+	register_current_timer_delay(&tpm_delay_timer);
=20
-	ret =3D request_irq(irq, tpm_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			  "i.MX7ULP TPM Timer", &clockevent_tpm);
+	sched_clock_register(tpm_read_sched_clock, counter_width,
+			     timer_of_rate(&to_tpm) >> 3);
=20
-	clockevent_tpm.rating =3D rating;
-	clockevent_tpm.cpumask =3D cpumask_of(0);
-	clockevent_tpm.irq =3D irq;
-	clockevents_config_and_register(&clockevent_tpm, rate, 300,
-					GENMASK(counter_width - 1, 1));
+	return clocksource_mmio_init(timer_base + TPM_CNT,
+				     "imx-tpm",
+				     timer_of_rate(&to_tpm) >> 3,
+				     to_tpm.clkevt.rating,
+				     counter_width,
+				     clocksource_mmio_readl_up);
+}
=20
-	return ret;
+static void __init tpm_clockevent_init(void)
+{
+	clockevents_config_and_register(&to_tpm.clkevt,
+					timer_of_rate(&to_tpm) >> 3,
+					300,
+					GENMASK(counter_width - 1,
+					1));
 }
=20
 static int __init tpm_timer_init(struct device_node *np)
 {
-	struct clk *ipg, *per;
-	int irq, ret;
-	u32 rate;
-
-	timer_base =3D of_iomap(np, 0);
-	if (!timer_base) {
-		pr_err("tpm: failed to get base address\n");
-		return -ENXIO;
-	}
-
-	irq =3D irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		pr_err("tpm: failed to get irq\n");
-		ret =3D -ENOENT;
-		goto err_iomap;
-	}
+	struct clk *ipg;
+	int ret;
=20
 	ipg =3D of_clk_get_by_name(np, "ipg");
-	per =3D of_clk_get_by_name(np, "per");
-	if (IS_ERR(ipg) || IS_ERR(per)) {
-		pr_err("tpm: failed to get ipg or per clk\n");
-		ret =3D -ENODEV;
-		goto err_clk_get;
+	if (IS_ERR(ipg)) {
+		pr_err("tpm: failed to get ipg clk\n");
+		return -ENODEV;
 	}
-
 	/* enable clk before accessing registers */
 	ret =3D clk_prepare_enable(ipg);
 	if (ret) {
 		pr_err("tpm: ipg clock enable failed (%d)\n", ret);
-		goto err_clk_get;
+		clk_put(ipg);
+		return ret;
 	}
=20
-	ret =3D clk_prepare_enable(per);
-	if (ret) {
-		pr_err("tpm: per clock enable failed (%d)\n", ret);
-		goto err_per_clk_enable;
-	}
+	ret =3D timer_of_init(np, &to_tpm);
+	if (ret)
+		return ret;
+
+	timer_base =3D timer_of_base(&to_tpm);
=20
-	counter_width =3D (readl(timer_base + TPM_PARAM) & TPM_PARAM_WIDTH_MASK)
-		>> TPM_PARAM_WIDTH_SHIFT;
+	counter_width =3D (readl(timer_base + TPM_PARAM)
+		& TPM_PARAM_WIDTH_MASK) >> TPM_PARAM_WIDTH_SHIFT;
 	/* use rating 200 for 32-bit counter and 150 for 16-bit counter */
-	rating =3D counter_width =3D=3D 0x20 ? 200 : 150;
+	to_tpm.clkevt.rating =3D counter_width =3D=3D 0x20 ? 200 : 150;
=20
 	/*
 	 * Initialize tpm module to a known state
@@ -229,29 +219,13 @@ static int __init tpm_timer_init(struct device_node *=
np)
 	writel(TPM_SC_CMOD_INC_PER_CNT |
 		(counter_width =3D=3D 0x20 ?
 		TPM_SC_CMOD_DIV_DEFAULT : TPM_SC_CMOD_DIV_MAX),
-		     timer_base + TPM_SC);
+		timer_base + TPM_SC);
=20
 	/* set MOD register to maximum for free running mode */
 	writel(GENMASK(counter_width - 1, 0), timer_base + TPM_MOD);
=20
-	rate =3D clk_get_rate(per) >> 3;
-	ret =3D tpm_clocksource_init(rate);
-	if (ret)
-		goto err_per_clk_enable;
-
-	ret =3D tpm_clockevent_init(rate, irq);
-	if (ret)
-		goto err_per_clk_enable;
-
-	return 0;
+	tpm_clockevent_init();
=20
-err_per_clk_enable:
-	clk_disable_unprepare(ipg);
-err_clk_get:
-	clk_put(per);
-	clk_put(ipg);
-err_iomap:
-	iounmap(timer_base);
-	return ret;
+	return tpm_clocksource_init();
 }
 TIMER_OF_DECLARE(imx7ulp, "fsl,imx7ulp-tpm", tpm_timer_init);
--=20
2.7.4

