Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeC2Dzw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 23:55:52 -0400
Received: from mail-bn3nam01on0072.outbound.protection.outlook.com ([104.47.33.72]:32704
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751099AbeC2Dzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 23:55:47 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>
CC: Zhao Chenhui <chenhui.zhao@freescale.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 2/5] drivers/soc/fsl: add EPU FSM configuration for deep sleep
Date: Thu, 29 Mar 2018 09:31:40 +0800
Message-ID: <20180329013143.22527-2-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180329013143.22527-1-ran.wang_1@nxp.com>
References: <20180329013143.22527-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131667693450937488;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(39860400002)(346002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(316002)(2906002)(81166006)(11346002)(81156014)(77096007)(8676002)(446003)(26005)(50226002)(51416003)(575784001)(86362001)(5660300001)(105606002)(76176011)(8936002)(47776003)(59450400001)(110136005)(336012)(16586007)(68736007)(54906003)(85426001)(26826003)(106466001)(6636002)(50466002)(48376002)(6666003)(450100002)(97736004)(476003)(53936002)(4326008)(305945005)(36756003)(356003)(1076002)(486005)(498600001)(126002)(104016004)(2616005)(486005)(2004002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3107;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD003;1:RhPiA6I7O586bDgie58PDx3q01B94iLWPpow+CB+PiZRKXyG71qFioZ4wg9/odqi962dV3Vvf+ChD8ZX/qpAtedavtYzCM2cgvoGHY0dtt7CEw3WFp69TWSIp6nkUhyr
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f77ef699-f5e8-44fa-c490-08d59528f300
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR03MB3107;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3107;3:XFM3uB4fYOkmnJRet5iM6F9q7/yvknE0ZfKXgZBmKp1rlTjZbbrMnw3NVB9Cw0ztbPgv5ORdrtZbhsOj6NZ7gU+g+356G1iZbuvUXbaz/VALwppnLGV7JyeOxbFW7TMmcpy62pwH/3/Y6+uT56cbEZlQUMwDjzQEscRFnS83jWm2ghCbqST7asS1UzOKOJdVLJRD4qASMs6Wy7Z/6PQ3Zyen2ku3trVlnYRnBxHUrgXTye77p46Kz7ruWy3qiOqcFkJu2+UiDNFUbtOOuCh9Qe2raGfaevJMU/1ldySbU0nos3UZFdj365UMAzJxfhgMJTwDp3b1irkJYFOJJnv7AES0o3zELPfbYdv9wEp1Vso=;25:EcM0zuNPgAn1Spmgk3SVQ/W8sUMC0kMyE9FKua0P6SskTzmsloD2iKjZdpTSCFO1+y/8dnXNKfLa2hJafyvATgInm2czB471I+1ij4To5L6v4/Usz3M7ot+/2/FQztsRRW46OIpmAUOqY81cbb8aAz2V447dPw74IUytsDD0CGqdvK7S1nwEGYaeYSW5mnUpaEWx6WMuilQsWAZof+eH2SmGz4O01iwdmPl/plsc9+h3H+sTrwril5ToGggm4nMk5cmj+XWY+6691q9uPAfhanm+EP3ZwP7y+jZitL+KF/gbHwLs24QFyapXmtpN7QeEp+nx3M69fjBsAzdG3wBBBw==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3107:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3107;31:1CkM3kQQ1gSCWKFLu6db3xlEvnfAL3i/0rL8agiyMzQJF7cUGVde045gwUzLsj4FdzFmXWrct6va0NsQjQxIpyAvcGtRpUqRWwXwS90fPqD2aFY4TbtL7+M0NYd2Vbe0LewI0mq/nOxqaExa/IZ0LWjDyBXLrY7x+nQN4Wx6VJfgx4Z4dY4NAOaowOpdVJ1nk4Cq7bVwKEX5Rn1b21CmrncooKu4huIX/htmZdPzbKQ=;4:91R67mXK4vukf60dtmVcedC+dWfh8HZbYo37CtfI/4c5PKEMxRkqXVtNY2bqsUWU8uIA4oJ/lrlxxHmrOYM0VPhW8PBkCZIhpHgZcVMq6Lu2GDSA6dJ86vIiEg7DwinyjH5P7KpY84rgB0OqI8YFPEwApiguE+J/1fmP5a23jDF+aqEQ1V7UwfeHz9iVS2nC3mK8COQ/L0Bo9XDF1LTMOqQxT1xCKA5SuRJJQ/C+uov7A4EcBcNhliGbWEbGnHbAEbNrIfI2qzkATyT8d7EgO1e1ZCm1je6+1gXlO3n/O5mlrKBncUvLQ24GvsQZpxcMAZEXSgwPDTb6V7CneAeoH87GSa9bpk4MQ4UDadOunp4=
X-Microsoft-Antispam-PRVS: <BN6PR03MB3107F2A04FFE579FA5D9173BF1A20@BN6PR03MB3107.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(6096035)(20161123561025)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(20161123565025)(20161123559100)(201708071742011);SRVR:BN6PR03MB3107;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR03MB3107;
X-Forefront-PRVS: 0626C21B10
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3107;23:YCEtCX0kydQqVSljN+T3CZOOsgLBJYPvozjCyx0z/?=
 =?us-ascii?Q?w9epBlgEHFGnP1+kNeOK6ObHqI2AFHAK0Y42RHU31cbJJ2vgtLMAALBI4wPa?=
 =?us-ascii?Q?Zv3tEgGxajdiMb3SrToRZ1R/aTXXDVhzeMDD2gN/oJDZViri4wnhC+6Kj6gv?=
 =?us-ascii?Q?2ohU6eH/Swz2CsfGEKALgpRFNIQdMjZAnnVZLp/uH6HTbL7h+RrxOLQdk1UC?=
 =?us-ascii?Q?YrAfZt2Cd/3PfVC0ksWS5vkN0DPsPRWGBqJyxCR/I2PW0L9SAPp6az1u/Mwm?=
 =?us-ascii?Q?ibgh6Q3hcEcXBjpRPxard6Ytfd0DMA7hXbL6XGAG+a32DMFKI7Ii+lvFKwIH?=
 =?us-ascii?Q?bdqiTYg2eHIjPrX5yJkETFBC79SRseGtsnVhG1VcqX3TUVQ7O89tbc5auG3t?=
 =?us-ascii?Q?KQuvVjXF56TgH7iAlUlgpNjfQVs6BZSCMRr0ikeWnoBlr1MibATpj4PE40Sn?=
 =?us-ascii?Q?9t4Y9hvR5tFSUTuNEPk+9WtqSS6eEwfZoLPSFbLdd5OWH92GVIbcSpOvmN+h?=
 =?us-ascii?Q?D/uLujvP/DLc7KnoDLjjo1SWcPHrXkO1pqDO+nLaSs3ZZG/Nu045gVNYrJIY?=
 =?us-ascii?Q?1rnyyr4A25412l+6kzkQomCA8fnM0NKrEZ68gnq81CUWMXF+gnG91e/ES5pr?=
 =?us-ascii?Q?WyM1lTekXhGCnaaZb6tLdl1ApZ8pDty0yY8c3ly8XxFGuhjswc/T+2zNySAi?=
 =?us-ascii?Q?AWef5kqAJoAprbidp7v2r9K0tzVXfmOS0/HJdzDgKfILnk3gujk1Ey95yZgQ?=
 =?us-ascii?Q?p7soDGZENu4Dcxhd0M71MZlSx0SdpX9O7vz5Rn0v2MusTkwSD4K6Mb6+AShQ?=
 =?us-ascii?Q?RW7PMIX2fH7cqRSiRQcIVgIiYORVD3YVbXaLoqQzHifZE0nWVDAH2JY3LEG+?=
 =?us-ascii?Q?xotp2L9tdtM8fTgQWjJ5Kh76Jndg8cbGNR4vXA+Zhk8I9Vf882vnR1P7/LKA?=
 =?us-ascii?Q?02Q/2EABluY/W/N51LzU/XvLCSod+NwWJFVEZxVNmbGXBMxNfXyrDFZXLVjF?=
 =?us-ascii?Q?KgwlUu8EWe67+mL4x49zlIAy86t4psvHh/kaqr8/YHD9l1YH2QCkuuiu6O4Q?=
 =?us-ascii?Q?eyyM0YmI7098kE7Jx2caEoN77e70R7w3LHcWohWseCEOX3QCcJ8+pIDmAXXR?=
 =?us-ascii?Q?7i/odZQcUeplJGYtuLqXmZ35ppeF372NmzC/ohGMYzqGOloeoBZWy8PKEcqL?=
 =?us-ascii?Q?ZP5j2Gd4ckX7K3qcMLcSG+XakprVc5HN9qfkQNW2slxZYfoeaknrGvMlXKjH?=
 =?us-ascii?Q?SplfV7DjhFXn4W2WRb09aEndKA2PKRdlf+5pKPv5SFlOZ8nSw9trl9UKfg3b?=
 =?us-ascii?Q?/A47W3HvTrD/KLOqNRMumVaaaWh6QfI6jRAIak/0UCz?=
X-Microsoft-Antispam-Message-Info: mjkSR9VLn9gBKDbWZ28I2UQiIgxW8xkBCdRvg0clooESbOa7gNCtYk1Os5yQhw8pjbbAerOswjZljR0GGmM+TfKAMR0CCVW+wFALeQxP/pGGgR/x2fF5C3JA2O8wimRJ7JKDU6GWXGdiB8hVthyZWBgenxYui7edpe+rQ1y8euqpjKRkBASp5LpJoT9Ov9zA
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3107;6:jF93kKucDH8LrgAJHCSKj4RP+/as1NfFeJkdtFWF1aOf7UmRA/6SRtNCPgNP6/S/iaLmOUX+FXL+P6hI//d88jln4YFV0GWhpYpbyxjiAntgSJfE7LmNr7q3h0ut87i2gRG4WFPKT/Ftsl26slL+JWwnl0C8qz1xDM+4DOt5r/Ltlp9DhjsrIeSfna4dt8ifhx9fcg/GFpANLogm3YzVprS5AxFy96Pph7vGnxyvRQNeOClg/9I4Qb3Ex0pPz01zxJ+37yLw1rhIPMHvZnXeqBmeI0r9GiIibbr5+eXVlert7Q8RDsOFeXWHxOlO4GaMIcc8LZuDNPWGyUkAbvmI5Vy998WteGwZcv1wmuBDH9dnFGH04bSAJgcFRBcEjSfhb27z6bFbOrfISwTKfx0PQ6yTfhRGj7V5JR6aXxLcYiZAxf9+OC3vFMPySoUzpMqAQIhPsK2ym0b8nnvFQm4tJQ==;5:WkLZl6h31e8tmsduzrZGhBsrTC9zQKh8h/bu9dbcJ5i2nt27nnOp+/GHQZgqcd3ATckmRil/7CldaEqE66k1dDVZZLMrEijxnRlbcGBxgTSdRZBF/RhYKqMYQtwhyqjAUm5HlWDxkxoG3XCqcRPrkuexWDlOXOVwBuPXy4T/kwM=;24:ncnDRkIqL1vhSJbpu1/1g2PKAbRA2WW2rytA7ygfqBSeC3bH7pfB3bwz+VHzPDWHJ9NmWdcGnW36YWnfPnwdXrPripVXfsAIFUB+X3iSAFo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3107;7:XcE+Keb1m8P1Sps5+/6y2pXqdSnwNLnLTEpkdbzYJXgOFhFBO56C+HveQy++xoziX56MF9gbF1hvvPr+YaoL7KnlH88d+8sSpQxRUl1p0fQtqftdqZNCJI1XymY64JGZzVzcJw9l9U5+u/qI+58UHgz0W+DsM8JB3a+O2zF0mSy+FlOQKF27Iw5DI2Nh9IENlDlbCO6SIG/hBwB8oXkvSEgfxIYDCWFUXCJVihC35tvfPwt4aZAJRP3Y5I0r56FV
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 03:55:43.8145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77ef699-f5e8-44fa-c490-08d59528f300
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the last stage of deep sleep, software will trigger a Finite
State Machine (FSM) to control the hardware procedure, such a
board isolation, killing PLLs, removing power, and so on.

When the system is waked up by an interrupt, the FSM controls
the hardware to complete the early resume procedure.

This patch configure the EPU FSM preparing for deep sleep.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/soc/fsl/Kconfig     |    7 +
 drivers/soc/fsl/Makefile    |    1 +
 drivers/soc/fsl/sleep_fsm.c |  279 +++++++++++++++++++++++++++++++++++++++++++
 drivers/soc/fsl/sleep_fsm.h |  130 ++++++++++++++++++++
 4 files changed, 417 insertions(+), 0 deletions(-)
 create mode 100644 drivers/soc/fsl/sleep_fsm.c
 create mode 100644 drivers/soc/fsl/sleep_fsm.h

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 7a9fb9b..4222bd5 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -16,3 +16,10 @@ config FSL_GUTS
 	  Initially only reading SVR and registering soc device are supported.
 	  Other guts accesses, such as reading RCW, should eventually be moved
 	  into this driver as well.
+
+config FSL_SLEEP_FSM
+	bool
+	help
+	  This driver configures a hardware FSM (Finite State Machine) for deep sleep.
+	  The FSM is used to finish clean-ups at the last stage of system entering deep
+	  sleep, and also wakes up system when a wake up event happens.
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 44b3beb..28c38c3 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
+obj-$(CONFIG_FSL_SLEEP_FSM)	+= sleep_fsm.o
diff --git a/drivers/soc/fsl/sleep_fsm.c b/drivers/soc/fsl/sleep_fsm.c
new file mode 100644
index 0000000..378857f
--- /dev/null
+++ b/drivers/soc/fsl/sleep_fsm.c
@@ -0,0 +1,279 @@
+/*
+ * deep sleep FSM (finite-state machine) configuration
+ *
+ * Copyright 2018 NXP
+ *
+ * Author: Hongbo Zhang <hongbo.zhang@freescale.com>
+ *         Chenhui Zhao <chenhui.zhao@freescale.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the above-listed copyright holders nor the
+ *	 names of any contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/types.h>
+
+#include "sleep_fsm.h"
+/*
+ * These values are from chip's reference manual. For example,
+ * the values for T1040 can be found in "8.4.3.8 Programming
+ * supporting deep sleep mode" of Chapter 8 "Run Control and
+ * Power Management (RCPM)".
+ * The default value can be applied to T104x, LS1021.
+ */
+struct fsm_reg_vals epu_default_val[] = {
+	/* EPGCR (Event Processor Global Control Register) */
+	{EPGCR, 0},
+	/* EPECR (Event Processor Event Control Registers) */
+	{EPECR0 + EPECR_STRIDE * 0, 0},
+	{EPECR0 + EPECR_STRIDE * 1, 0},
+	{EPECR0 + EPECR_STRIDE * 2, 0xF0004004},
+	{EPECR0 + EPECR_STRIDE * 3, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 4, 0x20000084},
+	{EPECR0 + EPECR_STRIDE * 5, 0x08000004},
+	{EPECR0 + EPECR_STRIDE * 6, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 7, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 8, 0x60000084},
+	{EPECR0 + EPECR_STRIDE * 9, 0x08000084},
+	{EPECR0 + EPECR_STRIDE * 10, 0x42000084},
+	{EPECR0 + EPECR_STRIDE * 11, 0x90000084},
+	{EPECR0 + EPECR_STRIDE * 12, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 13, 0x08000084},
+	{EPECR0 + EPECR_STRIDE * 14, 0x02000084},
+	{EPECR0 + EPECR_STRIDE * 15, 0x00000004},
+	/*
+	 * EPEVTCR (Event Processor EVT Pin Control Registers)
+	 * SCU8 triger EVT2, and SCU11 triger EVT9
+	 */
+	{EPEVTCR0 + EPEVTCR_STRIDE * 0, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 1, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 2, 0x80000001},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 3, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 4, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 5, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 6, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 7, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 8, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 9, 0xB0000001},
+	/* EPCMPR (Event Processor Counter Compare Registers) */
+	{EPCMPR0 + EPCMPR_STRIDE * 0, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 1, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 2, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 3, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 4, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 5, 0x00000020},
+	{EPCMPR0 + EPCMPR_STRIDE * 6, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 7, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 8, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 9, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 10, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 11, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 12, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 13, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 14, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 15, 0x000000FF},
+	/* EPCCR (Event Processor Counter Control Registers) */
+	{EPCCR0 + EPCCR_STRIDE * 0, 0},
+	{EPCCR0 + EPCCR_STRIDE * 1, 0},
+	{EPCCR0 + EPCCR_STRIDE * 2, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 3, 0},
+	{EPCCR0 + EPCCR_STRIDE * 4, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 5, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 6, 0},
+	{EPCCR0 + EPCCR_STRIDE * 7, 0},
+	{EPCCR0 + EPCCR_STRIDE * 8, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 9, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 10, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 11, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 12, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 13, 0},
+	{EPCCR0 + EPCCR_STRIDE * 14, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 15, 0x92840000},
+	/* EPSMCR (Event Processor SCU Mux Control Registers) */
+	{EPSMCR0 + EPSMCR_STRIDE * 0, 0},
+	{EPSMCR0 + EPSMCR_STRIDE * 1, 0},
+	{EPSMCR0 + EPSMCR_STRIDE * 2, 0x6C700000},
+	{EPSMCR0 + EPSMCR_STRIDE * 3, 0x2F000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 4, 0x002F0000},
+	{EPSMCR0 + EPSMCR_STRIDE * 5, 0x00002E00},
+	{EPSMCR0 + EPSMCR_STRIDE * 6, 0x7C000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 7, 0x30000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 8, 0x64300000},
+	{EPSMCR0 + EPSMCR_STRIDE * 9, 0x00003000},
+	{EPSMCR0 + EPSMCR_STRIDE * 10, 0x65000030},
+	{EPSMCR0 + EPSMCR_STRIDE * 11, 0x31740000},
+	{EPSMCR0 + EPSMCR_STRIDE * 12, 0x7F000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 13, 0x00003100},
+	{EPSMCR0 + EPSMCR_STRIDE * 14, 0x00000031},
+	{EPSMCR0 + EPSMCR_STRIDE * 15, 0x76000000},
+	/* EPACR (Event Processor Action Control Registers) */
+	{EPACR0 + EPACR_STRIDE * 0, 0},
+	{EPACR0 + EPACR_STRIDE * 1, 0},
+	{EPACR0 + EPACR_STRIDE * 2, 0},
+	{EPACR0 + EPACR_STRIDE * 3, 0x00000080},
+	{EPACR0 + EPACR_STRIDE * 4, 0},
+	{EPACR0 + EPACR_STRIDE * 5, 0x00000040},
+	{EPACR0 + EPACR_STRIDE * 6, 0},
+	{EPACR0 + EPACR_STRIDE * 7, 0},
+	{EPACR0 + EPACR_STRIDE * 8, 0},
+	{EPACR0 + EPACR_STRIDE * 9, 0x0000001C},
+	{EPACR0 + EPACR_STRIDE * 10, 0x00000020},
+	{EPACR0 + EPACR_STRIDE * 11, 0},
+	{EPACR0 + EPACR_STRIDE * 12, 0x00000003},
+	{EPACR0 + EPACR_STRIDE * 13, 0x06000000},
+	{EPACR0 + EPACR_STRIDE * 14, 0x04000000},
+	{EPACR0 + EPACR_STRIDE * 15, 0x02000000},
+	/* EPIMCR (Event Processor Input Mux Control Registers) */
+	{EPIMCR0 + EPIMCR_STRIDE * 0, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 1, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 2, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 3, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 4, 0x44000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 5, 0x40000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 6, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 7, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 8, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 9, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 10, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 11, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 12, 0x44000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 13, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 14, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 15, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 16, 0x6A000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 17, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 18, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 19, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 20, 0x48000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 21, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 22, 0x6C000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 23, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 24, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 25, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 26, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 27, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 28, 0x76000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 29, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 30, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 31, 0x76000000},
+	/* EPXTRIGCR (Event Processor Crosstrigger Control Register) */
+	{EPXTRIGCR, 0x0000FFDF},
+	/* end */
+	{FSM_END_FLAG, 0},
+};
+
+struct fsm_reg_vals npc_default_val[] = {
+	/* NPC triggered Memory-Mapped Access Registers */
+	{NCR, 0x80000000},
+	{MCCR1, 0},
+	{MCSR1, 0},
+	{MMAR1LO, 0},
+	{MMAR1HI, 0},
+	{MMDR1, 0},
+	{MCSR2, 0},
+	{MMAR2LO, 0},
+	{MMAR2HI, 0},
+	{MMDR2, 0},
+	{MCSR3, 0x80000000},
+	{MMAR3LO, 0x000E2130},
+	{MMAR3HI, 0x00030000},
+	{MMDR3, 0x00020000},
+	/* end */
+	{FSM_END_FLAG, 0},
+};
+
+/**
+ * fsl_fsm_setup - Configure EPU's FSM registers
+ * @base: the base address of registers
+ * @val: Pointer to address-value pairs for FSM registers
+ */
+void fsl_fsm_setup(void __iomem *base, struct fsm_reg_vals *val)
+{
+	struct fsm_reg_vals *data = val;
+
+	BUG_ON(!base || !data);
+	while (data->offset != FSM_END_FLAG) {
+		iowrite32be(data->value, base + data->offset);
+		data++;
+	}
+}
+
+void fsl_epu_setup_default(void __iomem *epu_base)
+{
+	fsl_fsm_setup(epu_base, epu_default_val);
+}
+
+void fsl_npc_setup_default(void __iomem *npc_base)
+{
+	fsl_fsm_setup(npc_base, npc_default_val);
+}
+
+void fsl_epu_clean_default(void __iomem *epu_base)
+{
+	u32 offset;
+
+	/* follow the exact sequence to clear the registers */
+	/* Clear EPACRn */
+	for (offset = EPACR0; offset <= EPACR15; offset += EPACR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPEVTCRn */
+	for (offset = EPEVTCR0; offset <= EPEVTCR9; offset += EPEVTCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPGCR */
+	iowrite32be(0, epu_base + EPGCR);
+
+	/* Clear EPSMCRn */
+	for (offset = EPSMCR0; offset <= EPSMCR15; offset += EPSMCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPCCRn */
+	for (offset = EPCCR0; offset <= EPCCR31; offset += EPCCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPCMPRn */
+	for (offset = EPCMPR0; offset <= EPCMPR31; offset += EPCMPR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPCTRn */
+	for (offset = EPCTR0; offset <= EPCTR31; offset += EPCTR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPIMCRn */
+	for (offset = EPIMCR0; offset <= EPIMCR31; offset += EPIMCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPXTRIGCRn */
+	iowrite32be(0, epu_base + EPXTRIGCR);
+
+	/* Clear EPECRn */
+	for (offset = EPECR0; offset <= EPECR15; offset += EPECR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+}
diff --git a/drivers/soc/fsl/sleep_fsm.h b/drivers/soc/fsl/sleep_fsm.h
new file mode 100644
index 0000000..e0013c0
--- /dev/null
+++ b/drivers/soc/fsl/sleep_fsm.h
@@ -0,0 +1,130 @@
+/*
+ * deep sleep FSM (finite-state machine) configuration
+ *
+ * Copyright 2018 NXP
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the above-listed copyright holders nor the
+ *	 names of any contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _FSL_SLEEP_FSM_H
+#define _FSL_SLEEP_FSM_H
+
+#define FSL_STRIDE_4B	4
+#define FSL_STRIDE_8B	8
+
+/* End flag */
+#define FSM_END_FLAG		0xFFFFFFFFUL
+
+/* Block offsets */
+#define RCPM_BLOCK_OFFSET	0x00022000
+#define EPU_BLOCK_OFFSET	0x00000000
+#define NPC_BLOCK_OFFSET	0x00001000
+
+/* EPGCR (Event Processor Global Control Register) */
+#define EPGCR		0x000
+
+/* EPEVTCR0-9 (Event Processor EVT Pin Control Registers) */
+#define EPEVTCR0	0x050
+#define EPEVTCR9	0x074
+#define EPEVTCR_STRIDE	FSL_STRIDE_4B
+
+/* EPXTRIGCR (Event Processor Crosstrigger Control Register) */
+#define EPXTRIGCR	0x090
+
+/* EPIMCR0-31 (Event Processor Input Mux Control Registers) */
+#define EPIMCR0		0x100
+#define EPIMCR31	0x17C
+#define EPIMCR_STRIDE	FSL_STRIDE_4B
+
+/* EPSMCR0-15 (Event Processor SCU Mux Control Registers) */
+#define EPSMCR0		0x200
+#define EPSMCR15	0x278
+#define EPSMCR_STRIDE	FSL_STRIDE_8B
+
+/* EPECR0-15 (Event Processor Event Control Registers) */
+#define EPECR0		0x300
+#define EPECR15		0x33C
+#define EPECR_STRIDE	FSL_STRIDE_4B
+
+/* EPACR0-15 (Event Processor Action Control Registers) */
+#define EPACR0		0x400
+#define EPACR15		0x43C
+#define EPACR_STRIDE	FSL_STRIDE_4B
+
+/* EPCCRi0-15 (Event Processor Counter Control Registers) */
+#define EPCCR0		0x800
+#define EPCCR15		0x83C
+#define EPCCR31		0x87C
+#define EPCCR_STRIDE	FSL_STRIDE_4B
+
+/* EPCMPR0-15 (Event Processor Counter Compare Registers) */
+#define EPCMPR0		0x900
+#define EPCMPR15	0x93C
+#define EPCMPR31	0x97C
+#define EPCMPR_STRIDE	FSL_STRIDE_4B
+
+/* EPCTR0-31 (Event Processor Counter Register) */
+#define EPCTR0		0xA00
+#define EPCTR31		0xA7C
+#define EPCTR_STRIDE	FSL_STRIDE_4B
+
+/* NPC triggered Memory-Mapped Access Registers */
+#define NCR		0x000
+#define MCCR1		0x0CC
+#define MCSR1		0x0D0
+#define MMAR1LO		0x0D4
+#define MMAR1HI		0x0D8
+#define MMDR1		0x0DC
+#define MCSR2		0x0E0
+#define MMAR2LO		0x0E4
+#define MMAR2HI		0x0E8
+#define MMDR2		0x0EC
+#define MCSR3		0x0F0
+#define MMAR3LO		0x0F4
+#define MMAR3HI		0x0F8
+#define MMDR3		0x0FC
+
+/* RCPM Core State Action Control Register 0 */
+#define CSTTACR0	0xB00
+
+/* RCPM Core Group 1 Configuration Register 0 */
+#define CG1CR0		0x31C
+
+struct fsm_reg_vals {
+	u32 offset;
+	u32 value;
+};
+
+void fsl_fsm_setup(void __iomem *base, struct fsm_reg_vals *val);
+void fsl_epu_setup_default(void __iomem *epu_base);
+void fsl_npc_setup_default(void __iomem *npc_base);
+void fsl_epu_clean_default(void __iomem *epu_base);
+
+#endif /* _FSL_SLEEP_FSM_H */
-- 
1.7.1
