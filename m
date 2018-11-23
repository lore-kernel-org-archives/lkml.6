Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC17C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4042520831
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lw7TtjeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4042520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439500AbeKWNk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:40:27 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:64336
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbeKWNk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSglcRE1/ZPpnNWYnaHqFIpjAf0Db3kd0btnw6XRqVk=;
 b=Lw7TtjeZbt080y/oU0k9wpxBbyxbrUHXRsFyrJ+PWyTd8zD+us2xppUUJ5yhCcOS7aJ8+nv7r3JzrqcQy+y/aedE8AnNRETiTaUwF4SAQKVREENUdHA8/ssdh8YcUZzEymqplomjXXUVoNRD8oKPGnRfv0ABKIgSKTJntQpcP0s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3849.eurprd04.prod.outlook.com (52.134.71.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Fri, 23 Nov 2018 02:57:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Fri, 23 Nov 2018
 02:57:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] clocksource/drivers/timer-imx-tpm: convert the driver to
 timer-of
Thread-Topic: [PATCH V2] clocksource/drivers/timer-imx-tpm: convert the driver
 to timer-of
Thread-Index: AQHUgthWbCEbbCF6ZkaYLdSuVCyQqw==
Date:   Fri, 23 Nov 2018 02:57:57 +0000
Message-ID: <1542941550-17949-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3849;6:CbpTGFpVMXpYPLuvftY6hpruunh3YBnHXgxejWSRpSMTTgOB0Z6XDCnT8Ywek4ISywojSZtKgNO7esQ/8BP6WbaVkgEWnjpV7zcMPCtcrRCrNw024YHeINFoMl7Qkv9392qiklzbgqg2bAa31gdsSB8oBRnh7IzZ9K8vMsoD6pPTC20Z+6zWqwnqzYHH2qkvsoFeqejh0OKUc9p+HC65y6FMi+/biyp+5oiRkgqQuaOWJzCUBcuuu3ENr+PNpJNh/ZX/l71UIihYmCWX3oQYn12AJ8ubNM68Wr70P4r7mZZPZx+EB94dNNMJSQDYY8+YvONnUyg6RTxUM8MkZIWd/De5ADd8E6XZVNcNPYTx824DKaTtmb5Pikm7uO/+V8v5OMwy+eGcJ4t40RTObpClm4HGfm1aX9/gZgzL9IDydkfqbuF8Hd2QL6LsHwymQXTgvRXyy7gU+EnuoYv/wk9Q8A==;5:OHVeqe6plOHvKzj/UOumk8Knm/hSARYCd6fZgfU/VeI+WMjrp4K5hGO8TgU/0ac0p+0INyCfUAG6hUAQQAiTjaXkSKRCfZAQBSZnkzALxbl+Y7JNFSy1UCpDBD4PkM89CHUgG1YXZVV7a+oORCmaRe+ZLQrAmyToM7B+xy+HSGc=;7:Qq+l8WiyZkMnuzo2bTdRzkvXXkMtsYnsEQ18bhlwhHcpYyI0OLEYWNGglhGSXNHS+GsXeOwQtIaguLZK8Jl/Hu5czeuSgVDFtGXKSGQhr0G80RBLUxkMSXnr5M2XDejfKbFmgk/6NXUAJiXSE8uq1w==
x-ms-office365-filtering-correlation-id: eca6e5bb-5bd8-4b19-eee3-08d650ef7848
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3849;
x-ms-traffictypediagnostic: DB3PR0402MB3849:
x-microsoft-antispam-prvs: <DB3PR0402MB384989FF8046D4FDD91AE97DF5D40@DB3PR0402MB3849.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3849;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3849;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(199004)(189003)(7736002)(81166006)(575784001)(386003)(86362001)(6506007)(486006)(2201001)(305945005)(476003)(2616005)(478600001)(99286004)(52116002)(316002)(2906002)(66066001)(71190400001)(26005)(6116002)(5660300001)(71200400001)(3846002)(36756003)(8936002)(6512007)(2900100001)(68736007)(97736004)(25786009)(53936002)(106356001)(14444005)(256004)(105586002)(186003)(8676002)(6436002)(2501003)(110136005)(102836004)(81156014)(6486002)(14454004)(50226002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3849;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 22MT4LDwXwncEmSFE3pce3Mdp4DUJP6Xy4yYkvXfpo8iQF37xVwdl1vfhhR1ImedeaguBZVHSTJgb8Dk+RR2TPm9NOQrDlmbKhLJ0AjWMM0nuJHRQAsg+EpF0Bd6zSajgP4bf4cb2+NQFkGoq71rKMwVeZUw/xEJ+CQd+a6uQwsqMjMNdAs2xWZMfHunn0YxqIgrfhbmoAj/SRxEASiauSnLWGGQSgizfVmq+S4o0AbbNKvqAehsPqutvETx7mYRc0MnoCJ913u9j43oPPeo0DF632KVCYUZdpGmXQEqphsqVXsJfmett1ydNBXCmOkezNsYBcpCqrsSzJV2L2yfcQQ6ylhDnFWrMBAnfMEI8Qs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca6e5bb-5bd8-4b19-eee3-08d650ef7848
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 02:57:57.4802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to use the timer_of helpers.
This allows to handle timer base, clock and irq using
common timer_of driver and it simplifies the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 183 ++++++++++++++------------------=
----
 1 file changed, 73 insertions(+), 110 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/time=
r-imx-tpm.c
index b7aa2b8..b9df46c 100644
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
@@ -33,35 +35,7 @@
 #define TPM_C0V				0x24
=20
 static int counter_width;
-static int rating;
 static void __iomem *timer_base;
-static struct clock_event_device clockevent_tpm;
-
-static inline void tpm_timer_disable(void)
-{
-	unsigned int val;
-
-	/* channel disable */
-	val =3D readl(timer_base + TPM_C0SC);
-	val &=3D ~(TPM_C0SC_MODE_MASK | TPM_C0SC_CHIE);
-	writel(val, timer_base + TPM_C0SC);
-}
-
-static inline void tpm_timer_enable(void)
-{
-	unsigned int val;
-
-	/* channel enabled in sw compare mode */
-	val =3D readl(timer_base + TPM_C0SC);
-	val |=3D (TPM_C0SC_MODE_SW_COMPARE << TPM_C0SC_MODE_SHIFT) |
-	       TPM_C0SC_CHIE;
-	writel(val, timer_base + TPM_C0SC);
-}
-
-static inline void tpm_irq_acknowledge(void)
-{
-	writel(TPM_STATUS_CH0F, timer_base + TPM_STATUS);
-}
=20
 static struct delay_timer tpm_delay_timer;
=20
@@ -80,19 +54,6 @@ static u64 notrace tpm_read_sched_clock(void)
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
@@ -114,14 +75,27 @@ static int tpm_set_next_event(unsigned long delta,
=20
 static int tpm_set_state_oneshot(struct clock_event_device *evt)
 {
-	tpm_timer_enable();
+	struct timer_of *to_tpm =3D to_timer_of(evt);
+	unsigned int val;
+
+	/* channel enabled in sw compare mode */
+	val =3D readl(timer_of_base(to_tpm) + TPM_C0SC);
+	val |=3D (TPM_C0SC_MODE_SW_COMPARE << TPM_C0SC_MODE_SHIFT) |
+	       TPM_C0SC_CHIE;
+	writel(val, timer_of_base(to_tpm) + TPM_C0SC);
=20
 	return 0;
 }
=20
 static int tpm_set_state_shutdown(struct clock_event_device *evt)
 {
-	tpm_timer_disable();
+	struct timer_of *to_tpm =3D to_timer_of(evt);
+	unsigned int val;
+
+	/* channel disable */
+	val =3D readl(timer_of_base(to_tpm) + TPM_C0SC);
+	val &=3D ~(TPM_C0SC_MODE_MASK | TPM_C0SC_CHIE);
+	writel(val, timer_of_base(to_tpm) + TPM_C0SC);
=20
 	return 0;
 }
@@ -129,82 +103,87 @@ static int tpm_set_state_shutdown(struct clock_event_=
device *evt)
 static irqreturn_t tpm_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt =3D dev_id;
+	struct timer_of *to_tpm =3D to_timer_of(evt);
=20
-	tpm_irq_acknowledge();
+	/* irq acknowledge */
+	writel(TPM_STATUS_CH0F, timer_of_base(to_tpm) + TPM_STATUS);
=20
 	evt->event_handler(evt);
=20
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
@@ -229,29 +208,13 @@ static int __init tpm_timer_init(struct device_node *=
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

