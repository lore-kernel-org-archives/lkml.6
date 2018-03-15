Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeCOASV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:18:21 -0400
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:44887
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750950AbeCOASS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:18:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com;
From: York Sun <york.sun@nxp.com>
To: bp@alien8.de
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        York Sun <york.sun@nxp.com>
Subject: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for A53 and A57
Date: Wed, 14 Mar 2018 17:17:46 -0700
Message-Id: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.92.81.50]
X-ClientProxiedBy: MWHPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:301:3b::18) To HE1PR04MB2073.eurprd04.prod.outlook.com
 (2a01:111:e400:7be9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b43d79c1-b609-4691-466f-08d58a0a3e4d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB2073;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB2073;3:JrFhfEqTHTkQewlzreLLzXlSMNFv/70RHnNN3zQFisysdkbLVau1p6Uwo+4LjmmekdMTvYi4Rod5y/H4w6VT8R7d1b0nbsWx0FYUJMxSB74fyeAMA0jJM4yxns7F+jGp2BxxRH+E8D/Cfm+7ZmecAQg1GEw7F8qc7CtTOjimOKPUGyEIaxHR9zFn7mTee8ld5nYXruUCy/bdJG//wzQzLWJ3zNBXPV0KBddWae+wR1rdeNv0vr30OLA595Lxod+B;25:6/VLBMY6K07WhWwzjCxV9Lkn6HXax5+52Q8SK0QsVr+mHNrhXUAtPKxH1UOKZqoogNjQiwaKCfw7Uij436AnvQ2MPkcidPsKzUu1UA8KXQBo1ZA6DbNgXp3gMRxzs8MDIXRZbg7+RsnJNepxrfkv6YCLK8KHBcZzI40OgZIGoCzNNTaVhoSAKe708sVTXLvRxFejmqL3Rgv6Pfnsi4j+FW/QuNp9lydUc2m7Whp9l9QcqF/uhAqBrws9/Ip/siODYuceZiekitbtlrBZPbFJa4zm7em+PhjgkHo63sw8N1Rj04yEZZ1dInwc9ASfroOqqbwpryLVhGt/TsvO5XRwPg==;31:Y9cj8+s+Xt5MD4gvTAlJ9a0ilWHfRuAnEvyJdbgZMNsSykke3u+/An3FbI+ZWCO0koZY0uMsZyqmYHt5B3SoVvaHbTUU4yRZyKJjRL8/bryOb5km3765OhyxnUbarHs31qLxEf11u1R78x8CXwNTJBRuUfMnay/EGRyiSrXzwB3CXyQ0RTTC5RXtIPCwO20l2tz7WvalOyopvxCNOHtPrenoh8IWSaCnf2pFxaTHTmM=
X-MS-TrafficTypeDiagnostic: HE1PR04MB2073:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB2073;20:ExU7w8a5vnjv0sPBocPfMkEbPouQEko9aM+SNToArcgUWlq/uNVh1Fgob5GP6Y0iL9xP98VNxFYTuKE5nVvazObbnQpWEK4Ifx7T7Vl6cIobVIfmW6yjpxEbW7vbuDCQmvf/GKdMv6GmRajUZs/HV6Z8A64M51ZbAS2flQWX71oK5eoyliFguXi0Y+4Qur8TS9NJaQe2HDeQuOdZ5aAqIyt42W8fM+MHm+df/fP7CZP5PxirM4r7u7v//3PHVKV2aMZEmWqLVfY4prJe/ZNga22nrf41WTk74W6iFXDdij6k+TOIouwnsxZyD0fcwui17zPvaYLCyNGT+hReo5J0pVX8PAd3Z7ryQ9FR0Eslb0jGyqkN2P7rZmjaVYDbVhuCHWUVZVohBdGYunbAJGvvv0F16TjMnObBFzdj+hLrS6aOQGIeNAKhtYoZaECXdoiUa+0/Z0JYHQ95tVia1jJ4G8GL95rZzTKcXML8Cp7rXT+mpY7wg1UXHVZS1ULaVu5e;4:+jU1aUz9JbOcjtiEYI9U+7N9YlCj0TwGGx40NbvXVZdwiYf1u6jlpLFTtyI5qaiJ8COJkP1LcILAaFBx9xqOB7EzgU6L2BsktRFcTbEwtbu1X04tN15fTAEz13AH1gq/eMWr/5tqgl9jR7g7yXTCLsx/OeLEa9oa0rbc8wHemkuVwm77TcU9uFwt7jNyJwg3aU6CwnF2YYBIgS/rrYHFLFR0DQnI82olkO9DiMTXlGbjcJBhsRAmNF1nX2WXQgeu16m6w/y3L/ARgfefCzzQq/Hk6+jPSHLEh3blSWzv+tWEL/DKsHU0I+P8zjgiYAVTA4mB3IVawK035/kg30/nufaybXRgnU9AQ5ycnJIJ3oCcXODYC4eolhVrJlb1UxZY
X-Microsoft-Antispam-PRVS: <HE1PR04MB20731B5CC80CF78A8FCF9AA09AD00@HE1PR04MB2073.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(767451399110)(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB2073;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB2073;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(199004)(189003)(36756003)(6506007)(386003)(53936002)(97736004)(59450400001)(47776003)(2906002)(26005)(16526019)(6116002)(68736007)(52116002)(51416003)(186003)(3846002)(6512007)(478600001)(105586002)(25786009)(316002)(66066001)(6916009)(16586007)(86362001)(4326008)(106356001)(50226002)(5660300001)(2351001)(8676002)(6666003)(81166006)(48376002)(2361001)(81156014)(305945005)(7736002)(50466002)(8936002)(6486002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB2073;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB2073;23:tLr9SaLvGK6lsA2OAmzhFMMdMwwetrOHTkphB44tc?=
 =?us-ascii?Q?fR/44J0YVXvicDsFINAw4UntGSih1r6w9YhKZnBPD8dzYT1STX6iQIWVxk2k?=
 =?us-ascii?Q?bHvev7qZAyS1tlgjNYei4sqBLm5KK6nwoiswzK9+h8JPgc9fAPHq8lPuOh59?=
 =?us-ascii?Q?JrbMLIfYNOdHuWpGLzS0Bgz8czb3T6585Bsxd7YZ9yZb3apZOmIq/P2VOeZg?=
 =?us-ascii?Q?eZuKEfej7mhZyJQCims8zqu4yFbmX86U9cg3qJ98eDuC6UNAVCKSRy2nMEFo?=
 =?us-ascii?Q?NNEBkPoBYobbzbU6jiTzKwhRtL175Yzf0YWGPm4jmBmkzoz9+KEtRSw9R2u0?=
 =?us-ascii?Q?198ZlguRGCs1bNGEv58LCYL/zW1JRJp6HixBu3AF8XtDOovO1LDJaSFdwwKl?=
 =?us-ascii?Q?RzHPPKnFOXYtPEDRbM8I+Z3/8Xpj8OvzTrj+sO0C39drWj0AEZlPYEkOQEfF?=
 =?us-ascii?Q?PNZ6xOUMiWgSvwu1wadr3UY23ydbuhVGMNJUM6diE67Y/5KxazxQM/tZ24rP?=
 =?us-ascii?Q?ZwAbYpYX7fqbywJ49nO0zM9+o4Z+B5XxL1Kjwib8VaIDnT82GWvR7o3pdXO+?=
 =?us-ascii?Q?iM4ZkiDM3SDL2ao4hbsCEB+E+FQZdjmmVEQhb20pJD0ti87jOvZvHddkjJhS?=
 =?us-ascii?Q?E14455sCM8WBzm7iC7zGVV9JTedNTVyT06Lqe9CxDIoSW0qMoHxnrSr601IE?=
 =?us-ascii?Q?TwbrszvCsaClufZWVa5AaQQ97IbivMzhFBExk3EEds/rNN3wvSos2DavG7T+?=
 =?us-ascii?Q?VhN61cg9PFbkEvTrUT3klVE4sKb3He1HyM55rj6DtzMwf57EkJUarIZDvhZL?=
 =?us-ascii?Q?Z2NZcJxgIa7S/svGuaVZ5Tcf6MmxtU4LdSQ0equAJn5LDUelwkIpjozVr9tU?=
 =?us-ascii?Q?qgWBwP1zp4rUiHdgp2RP6pJKMRSnxw5szpHMZU163OqTHmOZ8MbYqWfrlpTV?=
 =?us-ascii?Q?FU4nZTap1UVN7NeBqGo6+cYYgscpugPPeREC+DQZxkAQ64ohRo4aFJIdJn0B?=
 =?us-ascii?Q?jMahnpUjQtEuOf++HYKjGGrUhwEDBu0ZbQX6c6zlxXmgGJ+3CFQf3/WqWHnK?=
 =?us-ascii?Q?NLzuNofd0XQqU2LN9TxAiWXyKmaJQvVxq2BlQGGJ9lxr/k79hVFs2ejwCJWD?=
 =?us-ascii?Q?tuxTwG/e1BLX1CUhf6oTKmq4i/p/YkrhfJ7J3pLuH92qHCUatfcoA=3D=3D?=
X-Microsoft-Antispam-Message-Info: uYFCI+XowTjD82UeqTfQJo4yYhggI8RjOVyMiVoypebMIPtZJXuZBs93yHtvmUt5F9rAb0JmFExIgWEq09qBYX1/VgKXOOmyzzU1yg4oZZb0rDmALNJW/AuTk6TGKT1pctns5CIA3cSvf1gAjHxFWHvXh+nekZ0BWVL5/9fmZ636wn0SVDyj0KkpIWaSVw6r
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB2073;6:HixAnqhrceUmrf+p4B9hmJ7vbrnCY6OWapZkvjKdryJjMUw8gS3NOwuAzVt8X05k1NfnNmHdBcWVhXYBpNmxNlDVeK3pRzKVbqd1sbeHn5J3s6Yof55WyfrswArcnEiDtTDikrZc7mrF99q/pTAlTqRGoCkt6wFBJUJXF+BkpCqHQ476jn94Mfol3WAZTM0orKZA0HEuyf+5i23gu1zILSmnmoU82UXKCrA6EQ9c50AnjVKgMkVXwjrOrpzVZikHM1vIJAZBIJe313TJk3oL9TbOht490yFIVleS0EkJ/FLEfJZJLwbxzE6iyMPCjBpbnZN65PBr14AUelFRpGcrckLX2dchMXG14+XVql3UaXA=;5:gpnHjF1eB1N9dRyaZVWt6OEByiF2TwK3ZQOTrrDqHoHfbZXA3I6By65x/tw7dV7LsCnJlOwBABZVtYKkox4iYvlTnMX6FSLNteoLzX/P8Izdgl2I4ruLkIKOxmj0ISUuz36IR6mfgZlkkKpmHJhm1djPjCbH6F/neuxkb4/9KWM=;24:uiGSUSy1ZJGPpUbGL/xB1rvqVtz0YPkKT/RWT/PfuO4RDaW7WMBN9bxasduikarlCj9+kONy0Gksjjw5esAl1MeFOZDhSddhj+6p7re2dd4=;7:Cflx0LJG9cZu05OcKZwqNIS79EjvqMC3re+Bhy7rROutyyuU26iXOL65hdbvkTvGwUYMXKS8+pwzyrDT6SeC2WWlH+uGM9+hkIiFR/SR+v+JpH5AgeQJbRtBK4u9YWZqlrS3AJA+6kZXL2lTCMP6hYCyVvncCvjokWLRCs4R4hP2G39TnXY07ZPQeAF0Msr6BUlXoFcTIf0yM8K4eFUSMhYbVD8q11VAdvdo51PPf4LLclR6NfAp4hCgos1wHkTx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 00:18:12.8599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43d79c1-b609-4691-466f-08d58a0a3e4d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2073
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error detection for A53 and A57 cores. Hardware error injection
is supported on A53. Software error injection is supported on both.
For hardware error injection on A53 to work, proper access to
L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This
is done by making an SMC call in the driver. Failure to enable access
disables hardware error injection. For error interrupt to work,
another SMC call enables access to L2ECTLR_EL1. Failure to enable
access disables interrupt for error reporting.

Signed-off-by: York Sun <york.sun@nxp.com>
---
 .../devicetree/bindings/edac/cortex-arm64-edac.txt |  37 +
 arch/arm64/include/asm/cacheflush.h                |   1 +
 arch/arm64/mm/cache.S                              |  35 +
 drivers/edac/Kconfig                               |   6 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/cortex_arm64_l1_l2.c                  | 741 +++++++++++++++++++++
 drivers/edac/cortex_arm64_l1_l2.h                  |  55 ++
 7 files changed, 876 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.h

diff --git a/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
new file mode 100644
index 0000000..74a1c2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
@@ -0,0 +1,37 @@
+ARM Cortex A57 and A53 L1/L2 cache error reporting
+
+CPU Memory Error Syndrome and L2 Memory Error Syndrome registers can be used
+for checking L1 and L2 memory errors. However, only A53 supports double-bit
+error injection to L1 and L2 memory. This driver uses the hardware error
+injection when available, but also provides a way to inject errors by
+software. Both A53 and A57 supports interrupt when multi-bit errors happen.
+
+To use hardware error injection and the interrupt, proper access needs to be
+granted in ACTLR_EL3 (and/or ACTLR_EL2) register by EL3 firmware SMC call.
+
+Correctable errors do not trigger such interrupt. This driver uses dynamic
+polling internal to check for errors. The more errors detected, the more
+frequently it polls. Combining with interrupt, this driver can detect
+correctable and uncorrectable errors. However, if the uncorrectable errors
+cause system abort exception, this drivr is not able to report errors in time.
+
+The following section describes the Cortex A57/A53 EDAC DT node binding.
+
+Required properties:
+- compatible: Should be "arm,cortex-a57-edac" or "arm,cortex-a53-edac"
+- cpus: Should be a list of compatible cores
+
+Optional properties:
+- interrupts: Interrupt number if supported
+
+Example:
+	edac {
+		compatible = "arm,cortex-a53-edac";
+		cpus = <&cpu0>,
+		       <&cpu1>,
+		       <&cpu2>,
+		       <&cpu3>;
+		interrupts = <0 108 0x4>;
+
+	};
+
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 76d1cc8..f1cd090 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -73,6 +73,7 @@ extern void __clean_dcache_area_pop(void *addr, size_t len);
 extern void __clean_dcache_area_pou(void *addr, size_t len);
 extern long __flush_cache_user_range(unsigned long start, unsigned long end);
 extern void sync_icache_aliases(void *kaddr, unsigned long len);
+extern void __flush_l1_dcache_way(phys_addr_t ptr);
 
 static inline void flush_cache_mm(struct mm_struct *mm)
 {
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 7f1dbe9..5e65c20 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -221,3 +221,38 @@ ENTRY(__dma_unmap_area)
 	b.ne	__dma_inv_area
 	ret
 ENDPIPROC(__dma_unmap_area)
+
+/*
+ *	Flush L1 dcache by way, using physical address to find sets
+ *
+ *	__flush_l1_dcache_way(ptr)
+ *	- ptr	- physical address to be flushed
+ */
+ENTRY(__flush_l1_dcache_way)
+	msr	csselr_el1, xzr		/* select cache level 1 */
+	isb
+	mrs	x6, ccsidr_el1
+	and	x2, x6, #7
+	add	x2, x2, #4		/* x2 has log2(cache line size) */
+	mov	x3, #0x3ff
+	and	x3, x3, x6, lsr #3	/* x3 has number of ways - 1 */
+	clz	w5, w3			/* bit position of ways */
+	mov	x4, #0x7fff
+	and	x4, x4, x6, lsr #13	/* x4 has number of sets - 1 */
+	clz	x7, x4
+	lsr	x0, x0, x2
+	lsl	x0, x0, x7
+	lsr	x0, x0, x7		/* x0 has the set for ptr */
+
+	mov	x6, x3
+loop_way:
+	lsl	x9, x3, x5
+	lsl	x7, x0, x2
+	orr	x9, x9, x7
+	dc	cisw, x9
+	subs	x6, x6, #1
+	b.ge	loop_way
+	dsb	ish
+	ret
+
+ENDPIPROC(__flush_l1_dcache_way)
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 96afb2a..67cd60c 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -457,4 +457,10 @@ config EDAC_XGENE
 	  Support for error detection and correction on the
 	  APM X-Gene family of SOCs.
 
+config EDAC_CORTEX_ARM64_L1_L2
+	tristate "ARM Cortex A57/A53"
+	depends on ARM64
+	help
+	  Support for error detection on ARM Cortex A57 and A53.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 0fd9ffa..6c21941 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_THUNDERX)		+= thunderx_edac.o
 obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
+obj-$(CONFIG_EDAC_CORTEX_ARM64_L1_L2)	+= cortex_arm64_l1_l2.o
diff --git a/drivers/edac/cortex_arm64_l1_l2.c b/drivers/edac/cortex_arm64_l1_l2.c
new file mode 100644
index 0000000..9bcc8e9
--- /dev/null
+++ b/drivers/edac/cortex_arm64_l1_l2.c
@@ -0,0 +1,741 @@
+/*
+ * Cortex A57 and A53 EDAC L1 and L2 cache error detection
+ *
+ * Copyright (c) 2018, NXP Semiconductor
+ * Author: York Sun <york.sun@nxp.com>
+ *
+ * Partially take from a similar driver by
+ * Brijesh Singh <brijeshkumar.singh@amd.com>
+ * Copyright (c) 2015, Advanced Micro Devices
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/arm-smccc.h>
+#include <asm/barrier.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+
+#include "edac_module.h"
+#include "cortex_arm64_l1_l2.h"
+
+static int poll_msec = 1024;
+static long l1_ce_sw_inject_count, l1_ue_sw_inject_count;
+static long l2_ce_sw_inject_count, l2_ue_sw_inject_count;
+static struct cpumask compat_mask;
+static struct cpumask l1_ce_cpu_mask, l1_ue_cpu_mask;
+static struct cpumask l2_ce_cpu_mask, l2_ue_cpu_mask;
+static DEFINE_PER_CPU(unsigned long, actlr_en);
+static DEFINE_PER_CPU(unsigned long, l2ectlr_en);
+static DEFINE_PER_CPU(u64, cpumerr);
+static DEFINE_PER_CPU(u64, cpuactlr);
+static DEFINE_PER_CPU(u64, l2actlr);
+static DEFINE_PER_CPU(u64, l2merr);
+static DEFINE_PER_CPU(call_single_data_t, csd_check);
+static DEFINE_SPINLOCK(cortex_edac_lock);
+
+static inline void read_cpuactlr(void *info)
+{
+	u64 val;
+	int cpu = smp_processor_id();
+
+	asm volatile("mrs %0, S3_1_C15_C2_0" : "=r" (val));
+	per_cpu(cpuactlr, cpu) = val;
+}
+
+static inline void write_cpuactlr(int *mem)
+{
+	u64 val;
+	int cpu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cortex_edac_lock, flags);
+	cpu = smp_processor_id();
+
+	__flush_dcache_area(mem, 8);
+	asm volatile("mrs %0, S3_1_C15_C2_0" : "=r" (val));
+	val |= L1_ERR_INJ_EN;
+	asm volatile("dsb sy");
+	asm volatile("msr S3_1_C15_C2_0, %0" :: "r" (val));
+	asm volatile("isb sy");
+	/* make cache dirty */
+	*mem = 0xDEADBEEF;	/* write to L1 data causes error right away */
+	__flush_dcache_area(mem, 8);
+	val &= ~L1_ERR_INJ_EN;
+	asm volatile("dsb sy");
+	asm volatile("msr S3_1_C15_C2_0, %0" :: "r" (val));
+	asm volatile("isb sy");
+	spin_unlock_irqrestore(&cortex_edac_lock, flags);
+}
+
+static inline void read_l2actlr(void *info)
+{
+	u64 val;
+	int cpu = smp_processor_id();
+
+	asm volatile("mrs %0, S3_1_C15_C0_0" : "=r" (val));
+	per_cpu(l2actlr, cpu) = val;
+}
+
+static inline void write_l2actlr(int *mem)
+{
+	u64 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cortex_edac_lock, flags);
+	__flush_dcache_area(mem, 8);
+	__flush_l1_dcache_way(virt_to_phys(mem));
+	asm volatile("mrs %0, S3_1_C15_C0_0" : "=r" (val));
+	val |= L2D_ERR_INJ_EN;
+	asm volatile("dsb sy");
+	asm volatile("msr S3_1_C15_C0_0, %0" :: "r" (val));
+	asm volatile("isb sy");
+	/* make cache dirty */
+	*mem = 0xDEADBEEF;	/* Error will be reported when L2 is accessed. */
+	__flush_l1_dcache_way(virt_to_phys(mem));
+	__flush_dcache_area(mem, 8);
+	val &= ~L2D_ERR_INJ_EN;
+	asm volatile("dsb sy");
+	asm volatile("msr S3_1_C15_C0_0, %0" :: "r" (val));
+	asm volatile("isb sy");
+	spin_unlock_irqrestore(&cortex_edac_lock, flags);
+}
+
+static inline void write_l2ectlr_el1(void *info)
+{
+	u64 val;
+	int cpu = smp_processor_id();
+
+	asm volatile("mrs %0, S3_1_C11_C0_3" : "=r" (val));
+	if (val & L2_ERR_INT) {
+		pr_debug("l2ectlr_el1 on cpu %d reads 0x%llx\n", cpu, val);
+		val &= ~L2_ERR_INT;
+		asm volatile("msr S3_1_C11_C0_3, %0" :: "r" (val));
+	}
+}
+
+static inline void write_cpumerrsr_el1(u64 val)
+{
+	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (val));
+}
+
+static void a53_allow_l1l2_err_inj(void *info)
+{
+	int cpu = smp_processor_id();
+	struct arm_smccc_res res;
+	unsigned long flags;
+
+	pr_debug("%s: cpu is %d\n", __func__, cpu);
+	spin_lock_irqsave(&cortex_edac_lock, flags);
+	arm_smccc_smc(SIP_ALLOW_L1L2_ERR_32, 0, 0, 0, 0, 0, 0, 0, &res);
+	per_cpu(actlr_en, cpu) = res.a0;
+	spin_unlock_irqrestore(&cortex_edac_lock, flags);
+	pr_debug("%s: return is %ld\n", __func__, res.a0);
+}
+
+static void a53_allow_l1l2_err_irq_clr(void *info)
+{
+	int cpu = smp_processor_id();
+	struct arm_smccc_res res;
+	unsigned long flags;
+
+	pr_debug("%s: cpu is %d\n", __func__, cpu);
+	spin_lock_irqsave(&cortex_edac_lock, flags);
+	arm_smccc_smc(SIP_ALLOW_L2_CLR_32, 0, 0, 0, 0, 0, 0, 0, &res);
+	per_cpu(l2ectlr_en, cpu) = res.a0;
+	spin_unlock_irqrestore(&cortex_edac_lock, flags);
+	pr_debug("%s: return is %ld\n", __func__, res.a0);
+}
+
+static inline void read_cpumerrsr_el1(void *info)
+{
+	u64 val;
+	int cpu = smp_processor_id();
+
+	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (val));
+	per_cpu(cpumerr, cpu) = val;
+	if (val & ~CPUMERRSR_RAMID_MASK) {	/* Skip RAMID */
+		pr_debug("cpu %d reads cpumerrsr_el1 0x%llx\n", cpu, val);
+		/* clear the register since we already stored it */
+		write_cpumerrsr_el1(0);
+	} else if (l1_ce_sw_inject_count > 0) {
+		l1_ce_sw_inject_count--;
+		pr_debug("inject correctable errors to cpu %d\n", cpu);
+		per_cpu(cpumerr, cpu) = (1UL << 31);	/* valid bit */
+	} else if (l1_ue_sw_inject_count > 0) {
+		l1_ue_sw_inject_count--;
+		pr_debug("inject Uncorrectable errors to cpu %d\n", cpu);
+		per_cpu(cpumerr, cpu) = (1UL << 63) | (1UL << 31);
+	}
+}
+
+static inline void write_l2merrsr_el1(u64 val)
+{
+	asm volatile("msr s3_1_c15_c2_3, %0" :: "r" (val));
+}
+
+static inline void read_l2merrsr_el1(void *info)
+{
+	u64 val;
+	int cpu = smp_processor_id();
+
+	asm volatile("mrs %0, s3_1_c15_c2_3" : "=r" (val));
+	per_cpu(l2merr, cpu) = val;
+	if (val & ~L2MERRSR_RAMID_MASK) {	/* Skip RAMID */
+		pr_debug("cpu %d reads l2merrsr_el1 0x%llx\n", cpu, val);
+		/* clear the register since we already stored it */
+		write_l2merrsr_el1(0);
+	} else if (l2_ce_sw_inject_count > 0) {
+		l2_ce_sw_inject_count--;
+		pr_debug("inject correctable errors to L2 on cpu %d\n", cpu);
+		per_cpu(l2merr, cpu) = (1UL << 31);	/* valid bit */
+	} else if (l2_ue_sw_inject_count > 0) {
+		l2_ue_sw_inject_count--;
+		pr_debug("inject Uncorrectable errors to L2 on cpu %d\n", cpu);
+		per_cpu(l2merr, cpu) = (1UL << 63) | (1UL << 31);
+	}
+}
+static void read_errors(void *info)
+{
+	read_cpumerrsr_el1(info);
+	read_l2merrsr_el1(info);
+	write_l2ectlr_el1(info);
+}
+
+
+/* Returns 0 for no error
+ *	  -1 for uncorrectable error(s)
+ *	   1 for correctable error(s)
+ */
+static int parse_cpumerrsr(unsigned int cpu)
+{
+	u64 val = per_cpu(cpumerr, cpu);
+
+	/* check if we have valid error before continuing */
+	if (!CPUMERRSR_EL1_VALID(val))
+		return 0;
+
+	cortex_printk(KERN_INFO, "CPU %d ", cpu);
+
+	switch (CPUMERRSR_EL1_RAMID(val)) {
+	case L1_I_TAG_RAM:
+		pr_cont("L1-I Tag RAM");
+		break;
+	case L1_I_DATA_RAM:
+		pr_cont("L1-I Data RAM");
+		break;
+	case L1_D_TAG_RAM:
+		pr_cont("L1-D Tag RAM");
+		break;
+	case L1_D_DATA_RAM:
+		pr_cont("L1-D Data RAM");
+		break;
+	case L1_D_DIRTY_RAM:
+		pr_cont("L1 Dirty RAM");
+		break;
+	case TLB_RAM:
+		pr_cont("TLB RAM");
+		break;
+	default:
+		pr_cont("unknown");
+		break;
+	}
+	pr_cont(" error(s) detected\n");
+
+	if (CPUMERRSR_EL1_FATAL(val)) {
+		cortex_printk(KERN_INFO,
+			      "CPU %d L1 fatal error(s) detected (0x%llx)\n",
+			      cpu, val);
+		return -1;
+	}
+
+	return 1;
+}
+
+static int parse_l2merrsr(unsigned int cpu)
+{
+	u64 val = per_cpu(l2merr, cpu);
+
+	/* check if we have valid error before continuing */
+	if (!L2MERRSR_EL1_VALID(val))
+		return 0;
+
+	cortex_printk(KERN_INFO, "CPU %d L2 %s error(s) detected (0x%llx)\n",
+		      cpu, L2MERRSR_EL1_FATAL(val) ? "fatal" : "", val);
+
+	return L2MERRSR_EL1_FATAL(val) ? -1 : 1;
+}
+
+#define MESSAGE_SIZE 40
+static void cortex_arm64_edac_check(struct edac_device_ctl_info *edac_ctl)
+{
+	int cpu;
+	char msg[MESSAGE_SIZE];
+	call_single_data_t *csd;
+
+	get_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		csd = &per_cpu(csd_check, cpu);
+		csd->func = read_errors;
+		csd->info = NULL;
+		csd->flags = 0;
+		/* Read CPU L1 error */
+		smp_call_function_single_async(cpu, csd);
+		/* Wait until flags cleared */
+		smp_cond_load_acquire(&csd->flags, !VAL);
+	}
+	put_online_cpus();
+
+	cpumask_clear(&l1_ce_cpu_mask);
+	cpumask_clear(&l1_ue_cpu_mask);
+	cpumask_clear(&l2_ce_cpu_mask);
+	cpumask_clear(&l2_ue_cpu_mask);
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		switch (parse_cpumerrsr(cpu)) {
+			case -1:
+				/* fatal error */
+				cpumask_set_cpu(cpu, &l1_ue_cpu_mask);
+				break;
+			case 1:
+				/* correctable error(s) */
+				cpumask_set_cpu(cpu, &l1_ce_cpu_mask);
+				break;
+			case 0:
+				/* fall through */
+			default:
+				break;
+		}
+		switch (parse_l2merrsr(cpu)) {
+			case -1:
+				/* fatal error */
+				cpumask_set_cpu(cpu, &l2_ue_cpu_mask);
+				break;
+			case 1:
+				/* correctable error(s) */
+				cpumask_set_cpu(cpu, &l2_ce_cpu_mask);
+				break;
+			case 0:
+				/* fall through */
+			default:
+				break;
+		}
+	}
+
+	for_each_cpu(cpu, &l1_ue_cpu_mask) {
+		snprintf(msg, MESSAGE_SIZE, "Fatal error(s) on CPU %d\n", cpu);
+		edac_device_handle_ue(edac_ctl, 0, 0, msg);
+	}
+
+	for_each_cpu(cpu, &l1_ce_cpu_mask) {
+		snprintf(msg, MESSAGE_SIZE, "Correctable error(s) on CPU %d\n", cpu);
+		edac_device_handle_ce(edac_ctl, 0, 0, msg);
+	}
+
+	for_each_cpu(cpu, &l2_ue_cpu_mask) {
+		snprintf(msg, MESSAGE_SIZE, "Fatal error(s) on CPU %d\n", cpu);
+		edac_device_handle_ue(edac_ctl, 0, 1, msg);
+	}
+
+	for_each_cpu(cpu, &l2_ce_cpu_mask) {
+		snprintf(msg, MESSAGE_SIZE, "Correctable error(s) on CPU %d\n", cpu);
+		edac_device_handle_ce(edac_ctl, 0, 1, msg);
+	}
+
+	if (!cpumask_empty(&l1_ce_cpu_mask) ||
+	    !cpumask_empty(&l2_ce_cpu_mask) ||
+	    !cpumask_empty(&l1_ue_cpu_mask) ||
+	    !cpumask_empty(&l2_ue_cpu_mask)) {
+		if (poll_msec > MIN_POLL_MSEC) {
+			poll_msec >>= 1;
+			edac_device_reset_delay_period(edac_ctl, poll_msec);
+		} else {
+			cortex_printk(KERN_CRIT,
+				      "Excessive correctable errors\n");
+		}
+	} else {
+		if (poll_msec < MAX_POLL_MSEC) {
+			poll_msec <<= 1;
+			edac_device_reset_delay_period(edac_ctl, poll_msec);
+		}
+	}
+}
+
+static ssize_t l1_ce_sw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				 char *data)
+{
+	return sprintf(data, "%ld\t Number of errors to be injected\n", l1_ce_sw_inject_count);
+}
+
+static ssize_t l1_ce_sw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				  const char *data, size_t count)
+{
+	l1_ce_sw_inject_count = simple_strtol(data, NULL, 0);
+
+	return count;
+}
+
+static ssize_t l1_ue_sw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				 char *data)
+{
+	return sprintf(data, "%ld\t Number of errors to be injected\n", l1_ue_sw_inject_count);
+}
+
+static ssize_t l1_ue_sw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				  const char *data, size_t count)
+{
+	l1_ue_sw_inject_count = simple_strtol(data, NULL, 0);
+
+	return count;
+}
+
+static ssize_t l2_ce_sw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				 char *data)
+{
+	return sprintf(data, "%ld\t Number of errors to be injected\n", l2_ce_sw_inject_count);
+}
+
+static ssize_t l2_ce_sw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				  const char *data, size_t count)
+{
+	l2_ce_sw_inject_count = simple_strtol(data, NULL, 0);
+
+	return count;
+}
+
+static ssize_t l2_ue_sw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				 char *data)
+{
+	return sprintf(data, "%ld\t Number of errors to be injected\n", l2_ue_sw_inject_count);
+}
+
+static ssize_t l2_ue_sw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				  const char *data, size_t count)
+{
+	l2_ue_sw_inject_count = simple_strtol(data, NULL, 0);
+
+	return count;
+}
+
+static ssize_t l1_ue_hw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				 char *data)
+{
+	u64 val;
+	int cpu;
+	int len = 0;
+	size_t size = PAGE_SIZE;
+
+	get_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		/* Read CPU actlr */
+		smp_call_function_single(cpu, read_cpuactlr, NULL, 1);
+	}
+	put_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		val = per_cpu(cpuactlr, cpu);
+		len += scnprintf(data + len, size,
+				 "%d\t %s CPU %d (CPUACTLR_EL1 = 0x%llx)\n",
+				 val & L1_ERR_INJ_EN ? 1 : 0,
+				 val & L1_ERR_INJ_EN ? "Enabled" : "Disabled",
+				 cpu, val);
+		size -= len;
+	}
+
+	return len;
+}
+
+/* We don't care which CPU we inject error to. No need to inject to every CPU */
+static ssize_t l1_ue_hw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				  const char *data, size_t count)
+{
+	int ret;
+	long en;
+	struct cortex_pdata *pdata = edac_ctl->pvt_info;
+
+	ret = kstrtol(data, 0, &en);
+	if (ret)
+		return ret;
+
+	if (en)
+		write_cpuactlr(pdata->mem);
+
+	return count;
+}
+
+static ssize_t l2_ue_hw_inject_show(struct edac_device_ctl_info *edac_ctl,
+				 char *data)
+{
+	u64 val;
+	int cpu;
+	int len = 0;
+	size_t size = PAGE_SIZE;
+
+	get_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		/* Read L2 actlr */
+		smp_call_function_single(cpu, read_l2actlr, NULL, 1);
+	}
+	put_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		val = per_cpu(l2actlr, cpu);
+		len += scnprintf(data + len, size,
+				 "%d\t %s CPU %d (L2ACTLR_EL1 = 0x%llx)\n",
+				 val & L1_ERR_INJ_EN ? 1 : 0,
+				 val & L1_ERR_INJ_EN ? "Enabled" : "Disabled",
+				 cpu, val);
+		size -= len;
+	}
+
+	return len;
+}
+
+/* We don't care which CPU we inject error to. No need to inject to every CPU */
+static ssize_t l2_ue_hw_inject_store(struct edac_device_ctl_info *edac_ctl,
+				  const char *data, size_t count)
+{
+	int ret;
+	long en;
+	struct cortex_pdata *pdata = edac_ctl->pvt_info;
+
+	ret = kstrtol(data, 0, &en);
+	if (ret)
+		return ret;
+
+	if (en)
+		write_l2actlr(pdata->mem);
+
+	return count;
+}
+
+static struct edac_dev_sysfs_attribute device_sysfs_attr[] = {
+	{
+		.attr = {
+			.name = "l1_ce_sw_inject",
+			.mode = S_IRUGO | S_IWUSR,
+		},
+		.show = l1_ce_sw_inject_show,
+		.store = l1_ce_sw_inject_store,
+	},
+	{
+		.attr = {
+			.name = "l1_ue_sw_inject",
+			.mode = S_IRUGO | S_IWUSR,
+		},
+		.show = l1_ue_sw_inject_show,
+		.store = l1_ue_sw_inject_store,
+	},
+	{
+		.attr = {
+			.name = "l2_ce_sw_inject",
+			.mode = S_IRUGO | S_IWUSR,
+		},
+		.show = l2_ce_sw_inject_show,
+		.store = l2_ce_sw_inject_store,
+	},
+	{
+		.attr = {
+			.name = "l2_ue_sw_inject",
+			.mode = S_IRUGO | S_IWUSR,
+		},
+		.show = l2_ue_sw_inject_show,
+		.store = l2_ue_sw_inject_store,
+	},
+	{
+		.attr = {
+			.name = "l1_ue_hw_inject",
+			.mode = S_IRUGO | S_IWUSR,
+		},
+		.show = l1_ue_hw_inject_show,
+		.store = l1_ue_hw_inject_store,
+	},
+	{
+		.attr = {
+			.name = "l2_ue_hw_inject",
+			.mode = S_IRUGO | S_IWUSR,
+		},
+		.show = l2_ue_hw_inject_show,
+		.store = l2_ue_hw_inject_store,
+	},
+	{},
+};
+
+static irqreturn_t cortex_edac_isr(int irq, void *dev_id)
+{
+	struct edac_device_ctl_info *edac_ctl = dev_id;
+
+	pr_debug("Got IRQ\n");
+	cortex_arm64_edac_check(edac_ctl);
+
+	return IRQ_HANDLED;
+}
+
+static int cortex_arm64_edac_probe(struct platform_device *pdev)
+{
+	int i, rc, cpu, num_attr;
+	struct edac_device_ctl_info *edac_ctl;
+	struct device *dev = &pdev->dev;
+	struct cortex_pdata *pdata;
+	struct device_node *np, *dn = pdev->dev.of_node;
+	struct of_phandle_iterator it;
+	struct edac_dev_sysfs_attribute *attr;
+	const __be32 *cell;
+	u64 mpidr;
+
+	cpumask_clear(&compat_mask);
+	of_for_each_phandle(&it, rc, dn, "cpus", NULL, 0) {
+		np = it.node;
+		cell = of_get_property(np, "reg", NULL);
+		if (!cell) {
+			pr_err("%pOF: missing reg property\n", np);
+			continue;
+		}
+		mpidr = of_read_number(cell, of_n_addr_cells(np));
+		cpu = get_logical_index(mpidr);
+		if (cpu < 0) {
+			pr_err("Bad CPU number for mpidr 0x%llx", mpidr);
+			continue;
+		}
+		cpumask_set_cpu(cpu, &compat_mask);
+	}
+
+	pr_debug("compat_mask is %*pbl\n", cpumask_pr_args(&compat_mask));
+
+	if (of_device_is_compatible(dn, "arm,cortex-a53-edac")) {
+		num_attr = ARRAY_SIZE(device_sysfs_attr);
+		get_online_cpus();
+		for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+			smp_call_function_single(cpu, a53_allow_l1l2_err_inj, NULL, 1);
+			if (per_cpu(actlr_en, cpu)) {
+				pr_err("Failed to enable hardware error injection (%ld)\n",
+				       per_cpu(actlr_en, cpu));
+				num_attr -= 2;
+				break;
+			}
+		}
+		put_online_cpus();
+	} else {
+		num_attr = ARRAY_SIZE(device_sysfs_attr) - 2;
+	}
+
+	/* POLL mode is used to detect correctable errors */
+	edac_op_state = EDAC_OPSTATE_POLL;
+
+	edac_ctl = edac_device_alloc_ctl_info(sizeof(*pdata), "cpu_cache",
+					      1, "L", 2, 1, NULL, 0,
+					      edac_device_alloc_index());
+	if (IS_ERR(edac_ctl))
+		return -ENOMEM;
+
+	pdata = edac_ctl->pvt_info;
+	attr = devm_kzalloc(dev,
+			    sizeof(struct edac_dev_sysfs_attribute) * num_attr,
+			    GFP_KERNEL);
+	if (!attr) {
+		rc = -ENOMEM;
+		goto out_dev;
+	}
+
+	for (i = 0; i < num_attr - 1; i++) {
+		attr[i].attr.name = device_sysfs_attr[i].attr.name;
+		attr[i].attr.mode = device_sysfs_attr[i].attr.mode;
+		attr[i].show = device_sysfs_attr[i].show;
+		attr[i].store = device_sysfs_attr[i].store;
+	}
+	edac_ctl->sysfs_attributes = attr;
+
+	rc = of_count_phandle_with_args(dn, "cpus", NULL);
+	if (rc <= 0) {
+		pr_err("Invalid number of phandles in 'cpus'\n");
+		rc = -EINVAL;
+		goto out_dev;
+	}
+	pdata->irq = platform_get_irq(pdev, 0);
+	pr_debug("irq is %d\n", pdata->irq);
+
+	edac_ctl->poll_msec = poll_msec;
+	edac_ctl->edac_check = cortex_arm64_edac_check;
+	edac_ctl->dev = dev;
+	edac_ctl->mod_name = dev_name(dev);
+	edac_ctl->dev_name = dev_name(dev);
+	edac_ctl->ctl_name = EDAC_MOD_STR;
+	dev_set_drvdata(dev, edac_ctl);
+
+	rc = edac_device_add_device(edac_ctl);
+	if (rc)
+		goto out_dev;
+
+	pdata->mem = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
+	if (!pdata->mem)
+		goto out_mem;
+
+	if (pdata->irq) {
+		get_online_cpus();
+		for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+			smp_call_function_single(cpu,
+						 a53_allow_l1l2_err_irq_clr,
+						 NULL,
+						 1);
+			if (per_cpu(l2ectlr_en, cpu)) {
+				pr_err("Failed to enable interrupt clearing (%ld)\n",
+				       per_cpu(l2ectlr_en, cpu));
+				rc = -EACCES;
+				break;
+			}
+		}
+		put_online_cpus();
+
+		if (!rc) {
+			rc = devm_request_irq(dev, pdata->irq, cortex_edac_isr,
+				      0, "cortex_edac error", edac_ctl);
+			if (rc < 0) {
+				pr_err("%s: Unable to request irq %d for cortex edac error\n",
+				       __func__, pdata->irq);
+				goto out_irq;
+			}
+		}
+	}
+
+	return 0;
+
+out_mem:
+out_irq:
+	edac_device_del_device(edac_ctl->dev);
+
+out_dev:
+	edac_device_free_ctl_info(edac_ctl);
+
+	return rc;
+}
+
+static int cortex_arm64_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_ctl = dev_get_drvdata(&pdev->dev);
+
+	edac_device_del_device(edac_ctl->dev);
+	edac_device_free_ctl_info(edac_ctl);
+
+	return 0;
+}
+
+static const struct of_device_id cortex_arm64_edac_of_match[] = {
+	{ .compatible = "arm,cortex-a57-edac" },
+	{ .compatible = "arm,cortex-a53-edac" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);
+
+static struct platform_driver cortex_arm64_edac_driver = {
+	.probe = cortex_arm64_edac_probe,
+	.remove = cortex_arm64_edac_remove,
+	.driver = {
+		.name = EDAC_MOD_STR,
+		.of_match_table = cortex_arm64_edac_of_match,
+	},
+};
+module_platform_driver(cortex_arm64_edac_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("York Sun <york.sun@nxp.com>");
+MODULE_DESCRIPTION("Cortex A57 and A53 L1 and L2 cache EDAC driver");
diff --git a/drivers/edac/cortex_arm64_l1_l2.h b/drivers/edac/cortex_arm64_l1_l2.h
new file mode 100644
index 0000000..8f474b2
--- /dev/null
+++ b/drivers/edac/cortex_arm64_l1_l2.h
@@ -0,0 +1,55 @@
+/*
+ * Cortex A57 and A53 EDAC L1 and L2 cache error detection
+ *
+ * Copyright (c) 2018, NXP Semiconductor
+ * Author: York Sun <york.sun@nxp.com>
+ *
+ * Partially take from a similar driver by
+ * Brijesh Singh <brijeshkumar.singh@amd.com>
+ * Copyright (c) 2015, Advanced Micro Devices
+
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef __CORTEX_ARM64_L1_L2_H
+#define __CORTEX_ARM64_L1_L2_H
+
+#define SIP_ALLOW_L1L2_ERR_32		0x8200FF15
+#define SIP_ALLOW_L2_CLR_32		0x8200FF16
+
+#define EDAC_MOD_STR			"cortex_edac_l1_l2"
+
+#define cortex_printk(level, fmt, arg...) \
+	edac_printk(level, EDAC_MOD_STR, fmt, ##arg)
+
+#define CPUMERRSR_EL1_RAMID(x)		(((x) >> 24) & 0x7f)
+#define CPUMERRSR_EL1_VALID(x)		((x) & (1 << 31))
+#define CPUMERRSR_EL1_FATAL(x)		((x) & (1UL << 63))
+#define CPUMERRSR_RAMID_MASK		(0x7f << 24)
+#define L1_I_TAG_RAM			0x00
+#define L1_I_DATA_RAM			0x01
+#define L1_D_TAG_RAM			0x08
+#define L1_D_DATA_RAM			0x09
+#define L1_D_DIRTY_RAM			0x14
+#define TLB_RAM				0x18
+
+#define L2MERRSR_EL1_VALID(x)		((x) & (1 << 31))
+#define L2MERRSR_EL1_FATAL(x)		((x) & (1UL << 63))
+#define L2MERRSR_RAMID_MASK		(0x7f << 24)
+
+#define MAX_POLL_MSEC 16384
+#define MIN_POLL_MSEC 64
+
+/* Error injection bit in CPUACTLR_EL1 */
+#define L1_ERR_INJ_EN			(1 << 6)
+/* Error injection bit in L2ACTLR_EL1 */
+#define L2D_ERR_INJ_EN			(1 << 29)
+/* L2 ERR interrupt */
+#define L2_ERR_INT			(1 << 30)
+
+struct cortex_pdata {
+	int irq;
+	void *mem;
+};
+
+#endif /* __CORTEX_ARM64_L1_L2_H */
-- 
2.7.4
