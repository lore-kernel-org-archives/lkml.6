Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA6DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A9F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uggNfwRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfAKGCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:02:03 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:25838
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727846AbfAKGCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kYSRxsRGK+FO7ypNattloBcDLkGHIr1KmhNKjiMuPA=;
 b=uggNfwReZI6BY9Xmz9FYQOXng6boL/6hnXe1lTb9ictW0XYaalHMIFM8d/6dVoVCXLhP23+F3FdQzcsNGDuxYFJg3LcvMchUgK4lWUknPd3zznbQMfmxuNnm7PVsMG2ia1kBssGMdZNd1y6rhSB06TxE7FKeIPhla4Yq47UrAss=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3852.eurprd04.prod.outlook.com (52.134.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 05:57:30 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 05:57:30 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Thread-Topic: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Thread-Index: AQHUqXKJSi5DEBdu5UKeaKryAiY5Gg==
Date:   Fri, 11 Jan 2019 05:57:30 +0000
Message-ID: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:203:72::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3852;6:8PUSiBC59KePb3JcEOLkLi9Rs6xfCHOzQN0iw56XRgBBFhy9KeyHYpBghMg4LO5uX6eyxWBBDZuLh94ruZKb8VuOCX3wEpMIkO4T9Z2vAiprAuf011qWSBwxT5xOqns3ieMsYtXgj4hAWZq2dp18XCeyalACQadixRQobFb/k7/AiVP4pLNOmzZV7ZADSKSIAFKwUYfTeoNKIuim192/sfyfEdTn1KumNhy8fRNticQzm57Bcoo/zJdggra344lb+i8e1tu/CFQqQohAVoGTcCnRfV5EfzuFZKsyrvFv6+05+shj71NF3cPWsW+SGN5sQ4dUUh1GADQVtbjVP3bHyHIN31TneYvXnmaabhYS+V3Tl14alvqcrkn69nESoHFvbhNT+wedEQnq2aLPjCuQzLeUdx40pXlE152+qUxvp9xV0rnWpEKLE3EnW91xFRQyVCmhfiEFyKQC4t/hNzDT0g==;5:BWtE1DASKlCVSO81c588T+WnRMODdVSqxnxQPlCPd1GbE7toMVZUgxhOVd3c8rfjWkPYsS6DOtxXX5pKfS5onZ18IEeCBw0SDSaQcI0UrgeGOf8ZEQ4tUYfX7esyRHdx1aCRAb7BP9eKW7ETgB3UdGM/+TlzS8OkD1V7T8itILWN3uoIvcj125jCBOMR613QecgPNDeiLvbGNkFtmQHf3g==;7:/4NTILLxO7W5sIJoU3KrWKXfq/LmMHuYaSpK4iP2++NajBca7lllv/8Fjs5+TgS5OnXojet0twJzSlFxeOwwGb+mdu6TOXmQ3lThMM77sUxb+ibf9SsZR6jfYwsMOPWuEP1lFtpYx7VL9m+t/3hSnw==
x-ms-office365-filtering-correlation-id: 8a95582f-ac02-43de-f809-08d67789ac38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3852;
x-ms-traffictypediagnostic: DB3PR0402MB3852:
x-microsoft-antispam-prvs: <DB3PR0402MB3852C3C12F35EB9CD28C19F5F5850@DB3PR0402MB3852.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3852;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3852;
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(54534003)(2501003)(386003)(97736004)(68736007)(5660300001)(36756003)(14444005)(256004)(71190400001)(71200400001)(105586002)(106356001)(486006)(2906002)(66066001)(316002)(2616005)(4326008)(476003)(110136005)(99286004)(25786009)(6436002)(86362001)(575784001)(2201001)(478600001)(6486002)(3846002)(6116002)(14454004)(8676002)(81156014)(8936002)(26005)(6512007)(6506007)(53936002)(81166006)(7736002)(305945005)(50226002)(102836004)(186003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3852;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ay8wOj/Y+9RRxL8c27vEBPUWbPxuQifW3bz1EEqWotvh5V0BwhiKCJ4V1JZxGbo+RdX0Kb6ILTKblNGbYB850pm6seYLCM/GicuV6Gpmr4NE2n9BzZyTWxRsqOtzmQHscMH+EA84IVHOz6mjd8hpSM94VD4WG+WtjWob5Xnks0uHzHZtbIwXZFd/pYeAp3old47hf79QM/nGfvHG9jd057Idq4AygbmWAhfOue+4MGm0YCJ5UKSkVfUjKIRRo9y+YrcH4ncLYmuEaiOnEDQkWcG/MU04YZCl4/XeE9T/zWswR/XMgWvlxhyDnZ76ACjt+iwFvnGPkUsqU/hmFolGEyFVfbbK/9OFWmW/l3XmykFTIx2JINqFvF8ugarkGu8nYe2u/Pev+aGkgp442ZXM7e5yk1Va1FG93ca5sYfSGxA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a95582f-ac02-43de-f809-08d67789ac38
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 05:57:24.5242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3852
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds cpuidle support for i.MX7ULP, 3 cpuidle
states supported as below:

1. WFI, just ARM wfi;
2. WAIT mode, mapped to SoC's partial stop mode #3;
3. STOP mode, mapped to SoC's partial stop mode #1.

In WAIT mode, system clock and bus clock will be enabled;
In STOP mode, system clock and bus clock will be disabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog Since V1:
  - add prefix for power mode name;
  - use tab instead of spaces, sorry for this stupid mistake.
---
 arch/arm/mach-imx/Makefile          |  1 +
 arch/arm/mach-imx/common.h          | 10 +++++++
 arch/arm/mach-imx/cpuidle-imx7ulp.c | 60 +++++++++++++++++++++++++++++++++=
++++
 arch/arm/mach-imx/cpuidle.h         |  5 ++++
 arch/arm/mach-imx/mach-imx7ulp.c    |  7 +++++
 arch/arm/mach-imx/pm-imx7ulp.c      | 49 ++++++++++++++++++++++++++----
 6 files changed, 127 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx7ulp.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8af2f7e..12aa44a 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_SOC_IMX6SL) +=3D cpuidle-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SLL) +=3D cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6SX) +=3D cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) +=3D cpuidle-imx6sx.o
+obj-$(CONFIG_SOC_IMX7ULP) +=3D cpuidle-imx7ulp.o
 endif
=20
 ifdef CONFIG_SND_IMX_SOC
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index bc915e5..c51764a 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -72,6 +72,15 @@ enum mxc_cpu_pwr_mode {
 	STOP_POWER_OFF,		/* STOP + SRPG */
 };
=20
+enum ulp_cpu_pwr_mode {
+	ULP_PM_HSRUN,    /* High speed run mode */
+	ULP_PM_RUN,      /* Run mode */
+	ULP_PM_WAIT,     /* Wait mode */
+	ULP_PM_STOP,     /* Stop mode */
+	ULP_PM_VLPS,     /* Very low power stop mode */
+	ULP_PM_VLLS,     /* very low leakage stop mode */
+};
+
 void imx_enable_cpu(int cpu, bool enable);
 void imx_set_cpu_jump(int cpu, void *jump_addr);
 u32 imx_get_cpu_arg(int cpu);
@@ -98,6 +107,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
 void imx6_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
 int imx_mmdc_get_ddr_type(void);
+int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode);
=20
 void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-imx/cpuidle-imx7ulp.c b/arch/arm/mach-imx/cpuidl=
e-imx7ulp.c
new file mode 100644
index 0000000..ca86c96
--- /dev/null
+++ b/arch/arm/mach-imx/cpuidle-imx7ulp.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP
+ *   Anson Huang <Anson.Huang@nxp.com>
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <asm/cpuidle.h>
+
+#include "common.h"
+#include "cpuidle.h"
+
+static int imx7ulp_enter_wait(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv, int index)
+{
+	if (index =3D=3D 1)
+		imx7ulp_set_lpm(ULP_PM_WAIT);
+	else
+		imx7ulp_set_lpm(ULP_PM_STOP);
+
+	cpu_do_idle();
+
+	imx7ulp_set_lpm(ULP_PM_RUN);
+
+	return index;
+}
+
+static struct cpuidle_driver imx7ulp_cpuidle_driver =3D {
+	.name =3D "imx7ulp_cpuidle",
+	.owner =3D THIS_MODULE,
+	.states =3D {
+		/* WFI */
+		ARM_CPUIDLE_WFI_STATE,
+		/* WAIT */
+		{
+			.exit_latency =3D 50,
+			.target_residency =3D 75,
+			.enter =3D imx7ulp_enter_wait,
+			.name =3D "WAIT",
+			.desc =3D "PSTOP2",
+		},
+		/* STOP */
+		{
+			.exit_latency =3D 100,
+			.target_residency =3D 150,
+			.enter =3D imx7ulp_enter_wait,
+			.name =3D "STOP",
+			.desc =3D "PSTOP1",
+		},
+	},
+	.state_count =3D 3,
+	.safe_state_index =3D 0,
+};
+
+int __init imx7ulp_cpuidle_init(void)
+{
+	return cpuidle_register(&imx7ulp_cpuidle_driver, NULL);
+}
diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
index f914012..7694c8f 100644
--- a/arch/arm/mach-imx/cpuidle.h
+++ b/arch/arm/mach-imx/cpuidle.h
@@ -15,6 +15,7 @@ extern int imx5_cpuidle_init(void);
 extern int imx6q_cpuidle_init(void);
 extern int imx6sl_cpuidle_init(void);
 extern int imx6sx_cpuidle_init(void);
+extern int imx7ulp_cpuidle_init(void);
 #else
 static inline int imx5_cpuidle_init(void)
 {
@@ -32,4 +33,8 @@ static inline int imx6sx_cpuidle_init(void)
 {
 	return 0;
 }
+static inline int imx7ulp_cpuidle_init(void)
+{
+	return 0;
+}
 #endif
diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7=
ulp.c
index 16b295b..11ac71a 100644
--- a/arch/arm/mach-imx/mach-imx7ulp.c
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -12,6 +12,7 @@
 #include <asm/mach/arch.h>
=20
 #include "common.h"
+#include "cpuidle.h"
 #include "hardware.h"
=20
 #define SIM_JTAG_ID_REG		0x8c
@@ -64,7 +65,13 @@ static const char *const imx7ulp_dt_compat[] __initconst=
 =3D {
 	NULL,
 };
=20
+static void __init imx7ulp_init_late(void)
+{
+	imx7ulp_cpuidle_init();
+}
+
 DT_MACHINE_START(IMX7ulp, "Freescale i.MX7ULP (Device Tree)")
 	.init_machine	=3D imx7ulp_init_machine,
 	.dt_compat	=3D imx7ulp_dt_compat,
+	.init_late	=3D imx7ulp_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.=
c
index cf6a380..7b2f738 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -9,21 +9,60 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
=20
+#include "common.h"
+
 #define SMC_PMCTRL		0x10
 #define BP_PMCTRL_PSTOPO        16
 #define PSTOPO_PSTOP3		0x3
+#define PSTOPO_PSTOP2		0x2
+#define PSTOPO_PSTOP1		0x1
+#define BP_PMCTRL_RUNM		8
+#define RUNM_RUN		0
+#define BP_PMCTRL_STOPM		0
+#define STOPM_STOP		0
+
+#define BM_PMCTRL_PSTOPO	(3 << BP_PMCTRL_PSTOPO)
+#define BM_PMCTRL_RUNM		(3 << BP_PMCTRL_RUNM)
+#define BM_PMCTRL_STOPM		(7 << BP_PMCTRL_STOPM)
+
+static void __iomem *smc1_base;
+
+int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
+{
+	u32 val =3D readl_relaxed(smc1_base + SMC_PMCTRL);
+
+	/* clear all */
+	val &=3D ~(BM_PMCTRL_RUNM | BM_PMCTRL_STOPM | BM_PMCTRL_PSTOPO);
+
+	switch (mode) {
+	case ULP_PM_RUN:
+		/* system/bus clock enabled */
+		val |=3D PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO;
+		break;
+	case ULP_PM_WAIT:
+		/* system clock disabled, bus clock enabled */
+		val |=3D PSTOPO_PSTOP2 << BP_PMCTRL_PSTOPO;
+		break;
+	case ULP_PM_STOP:
+		/* system/bus clock disabled */
+		val |=3D PSTOPO_PSTOP1 << BP_PMCTRL_PSTOPO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(val, smc1_base + SMC_PMCTRL);
+
+	return 0;
+}
=20
 void __init imx7ulp_pm_init(void)
 {
 	struct device_node *np;
-	void __iomem *smc1_base;
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");
 	smc1_base =3D of_iomap(np, 0);
 	WARN_ON(!smc1_base);
=20
-	/* Partial Stop mode 3 with system/bus clock enabled */
-	writel_relaxed(PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO,
-		       smc1_base + SMC_PMCTRL);
-	iounmap(smc1_base);
+	imx7ulp_set_lpm(ULP_PM_RUN);
 }
--=20
2.7.4

