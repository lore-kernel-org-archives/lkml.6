Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeC2D4A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 23:56:00 -0400
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com ([104.47.37.59]:64288
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751862AbeC2Dzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 23:55:52 -0400
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
Subject: [PATCH 4/5] powerpc/pm: add sleep and deep sleep on QorIQ SoCs
Date: Thu, 29 Mar 2018 09:31:42 +0800
Message-ID: <20180329013143.22527-4-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180329013143.22527-1-ran.wang_1@nxp.com>
References: <20180329013143.22527-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131667693450972066;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6029001)(7966004)(396003)(39380400002)(346002)(39860400002)(376002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(51416003)(105606002)(508600001)(305945005)(26826003)(5660300001)(356003)(106466001)(59450400001)(48376002)(68736007)(50466002)(1076002)(8936002)(110136005)(54906003)(50226002)(76176011)(316002)(97736004)(47776003)(81156014)(81166006)(336012)(16586007)(8676002)(85426001)(575784001)(86362001)(6666003)(486005)(126002)(2616005)(6636002)(450100002)(476003)(36756003)(53936002)(486005)(2906002)(26005)(104016004)(77096007)(16200700003)(53946003)(4326008)(446003)(11346002)(21314002)(2004002)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB387;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC002;1:4rE+4PEXVSrW5+1kYDZLvkobUeavNVdXZs2WFCrVCi27hE9Kb4vjvceyXJMx76FiIDwLJ5miawYQZTAqqq4nfKwWTGKa0GvWli93/oDIenE5zMn6r/fIJcCvBkI07MPd
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d147bd3-c02a-4a9e-df42-08d59528f2eb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BL2PR03MB387;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;3:fARaFMx/7tWNjRMmhVocsekCGJwvz99sY7ZtmmpzgM5/UVHJ3wo8evB0/ebUr217HzRuR9T+F3SMAJ/ikLWJ8p++9bKUFWV1cE2tGyCml9cw0euRsMtDozjiwrofEPh2y2FyXef3OVhD5vqTrwBNreZpecVHacdwXTx+bhNUW1+sTdfMoV0GtDQIqIkbwnUpyh8thdttW03mjnShafAvkATKuo7WKOLqHGQn0Mm8cO4vGa3qnpkSPoSrqdoIHLNrI9RWJv+kd/V9WRoPsvWE2NDsaWpiE9JcwZAiRRkOns5Vgmu95CL3LS1gqlmjgtQhkpN69siihEDdj2TvBs/xRa/JkcWO9sFcWvNL+Dowltg=;25:52HVKH2NqVUO2GHLxzx31k9xjyekmpQt27xECjMPNfKxCUZQZFD2iVsp/c++0YGSa5Tsle8F4Xcen6ancoH3ZatGugasRumaTo4yWH6mORBcINj/oUcH1xYQoKegtyCEBDwow8A2yQ0QxDnw8W1k5Q3p1f9EQgTvSNcEcGfYOl561LA+UpV/7+IFSZzSP4xNjQ27rM27jtkafdtt30ItDj6vUmsv47zP34YkHi3wjkQwujL5rrCAHIq1+YsiCnzPlAK2N/+wYdSHHkyBMb91j1tBaYIyq/BBj2wTIcG0Vdx8BmPexXMkibXOh18O2XCuS8VEGDDix3U+VSenPFQT7g==
X-MS-TrafficTypeDiagnostic: BL2PR03MB387:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;31:IWMx1R6Jjqm955IidTBOuJqDDl/8aBTLPX3F4jAYYwT0rF2tPLNWHBmap8u9HlkN3E0ZYMUZ1VXjinA7TJhDZKDoXnaHNWwSkAh4F/UqoVaBI12dFEYAUjSLHTIOlZOnSZkeENe31BPrqki4EuAF0bT50RE78GPiGQN308Yylsy3mBkvK1s/YVw/4CHcD4cAMFqE/rCxHZgN9T+rNEQj/l2WMYna/UonV/s4KlnxPdI=;4:pYBwAgA3rn/+fIWqvGjiAHV0rgrxKl7T3tA52TaZMDmszwwkIJ/3P6dfiQdr+Xzy4Ohip5cS8P9CxwsO/nDjK8Z6uccIalYTixgllE6kQ67Jf1N04vqWB6AiHOD7PBcvSeKo5zvX2NN8Zi6i8KKfQ/OP3XQ/d9/a1Dfv8MSN9AoKd7ew55QOkP1H5KPwQ+sb9Cwrg/c+WMxqFGSRwyA+WkpkuIaK813btMl8d++tpQ8oDHY82c4Z2AGJ104pOxBD5mo3kbQqcsjPWJarKUrcYA6jcjovaIBotaG8LEDVcY2qFyr7czGQ6R4Th0mI0PzHcuUPdlae5K9V8WtEJTeWqLZ4YopEWkZ3iiMgRUrojMK3e0OQDJhrHeVRy8+5VRSb
X-Microsoft-Antispam-PRVS: <BL2PR03MB3871BFEFCAAAD9B9D1F3C7EF1A20@BL2PR03MB387.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6096035)(20161123563025)(20161123565025)(20161123556025)(20161123559100)(20161123561025)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(201708071742011);SRVR:BL2PR03MB387;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR03MB387;
X-Forefront-PRVS: 0626C21B10
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB387;23:z9BE5uNrp+OfCSimSE4wH70PtN60g39TMr8qOVhvxH?=
 =?us-ascii?Q?miogb3uvWwDglFL8h8dy/WrIOQ1VDHI5jay/9NCCbF35j41MCcywW7GVlfBq?=
 =?us-ascii?Q?+Gd/psihMSkHuorAZ00FowU4BzaxLtqcFFx0sc5sHNJmbgt57fw434rNPxhg?=
 =?us-ascii?Q?ebCrknAxfq843mgNWrcioQnCX7VtVZvEJhE0zctSllLCaZ5n1gA6OwU5PtJL?=
 =?us-ascii?Q?R5zB7URLKPV+Ar+RmMJuV7Ur6/TFgdZ/6gQuP21sDdVPR1JDDa66AvWm4bZN?=
 =?us-ascii?Q?C2pi7RnRTI4xpPJ0JqYL/e/7PhCNrpuNfNUk/xiwIT3zqfTrzym3lUMADXCm?=
 =?us-ascii?Q?3PQC5H7+VS97J1YAe0+0FyT/kUeHjoURRM+eRIBfcZ2vXK8Znqc7l4NATQhO?=
 =?us-ascii?Q?J9HJBYfIQqjFMNxL4DB8nD9+ZDxbvgA21y78V2BUfLh2F14wMrp6ev8/a2K3?=
 =?us-ascii?Q?yWnQrBcHC6mLnmyLCPyZvyugmZohBVIgXLSC7AUZJdTEMoIvSAbXezrVqx1R?=
 =?us-ascii?Q?dmh2zbEMjLJbn290YZCWcVDLqG9iOMijfG2Pt5Xy+n0ZNNdPArROGtHsKESl?=
 =?us-ascii?Q?pbLa143+SUOXr3RGJhlVeGV49BfYBTf0l4iBO7ticQKlSz7kIwG2ySnNv/um?=
 =?us-ascii?Q?uVS0maCRMLXkBg+T1IxXiuFoxaKyL6s1Dxe6jUc0IfFTJ1lsyEPFw1MhLQJK?=
 =?us-ascii?Q?OKSoTPBa53fjVFDJ5z75jEBCiHOAK5SuW6k81oCkmzXZBriuzz7XgQdG4nXu?=
 =?us-ascii?Q?Kn2uTXR7U+LV7q5mli9FRjPlM6ZqefdLIt4W20dHfeMVD2hqW5wgVhX1apu9?=
 =?us-ascii?Q?qif/r3p6sU0KViFKSP3gptbKZ8zt4XYQnYUJrX//Udd11g/n2BG9QhQlrSO+?=
 =?us-ascii?Q?rnI1X9J++GDgNN2RrKaTB0HE1Q0Lh8OnvQchfW88B0fyfzYGcrS7RBzLPlmO?=
 =?us-ascii?Q?ZJM/YwEXiTFlHbciKQkthdAZUiqSLHXOdRX5KjdHwXftA9nBeR5uSfcdLOyx?=
 =?us-ascii?Q?76OfLQEk13OKONfCjS2MskxDhfiQ4N267FrsvrE5QKVhejGST5DeChIcJ1TM?=
 =?us-ascii?Q?DE47MhQ1RpZq6bnlAb02OuKkhXVC22JMpFtAvsMoTn42X3QRPueF/QYeefNq?=
 =?us-ascii?Q?Phc8f6lfQgX2K2zIjkQmBYXbKT+GUDyFzV+OAZ6xK0c1E9u8ratCeU188ddb?=
 =?us-ascii?Q?F8GF1Bv0qt8KtNICyEHM8owF4rVbwVCaYqyInDi5Q+r+eWE3FhhEGZ37e1Jr?=
 =?us-ascii?Q?8VGuF2JB40Uf6WVgO2vkPAkqNfSLPWhu8jSNaAwPWq5OZ9qdwYJqojIRi4Uc?=
 =?us-ascii?Q?WwGmm4BeW4rI9c7RftiF3vjZbIIFTk1/N00wTGrZFRL8ueWLUcqPq4oDuUq1?=
 =?us-ascii?Q?yK0cg8A8DRIbbEnzKCMrpiaBE2L5ZaOCrTzOacSLxy5G2VwFabt+NZAGE6f0?=
 =?us-ascii?Q?EL6TMpDjugIQybzzlt3u0V6yiWI1E=3D?=
X-Microsoft-Antispam-Message-Info: GAzdkWzjiGlSrLmKAqWB2PUIMEXDCqrKyOd6970eqBziWWoCMt3xayOR7Z/kzCiUkwrtRCxifMDi6mRFIqXAJysk+5/HOExs8EkmIurSBgOf2hUPnfqc5+kUinNZwx/tA6wCKGOHzujB+rxScjFOlqFWsf4DIkcF9vR3AG9ExQ1h2LGR9N+7jjnstFH6dG4y
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;6:jQKQQKJ5LT088A2xK+kwPdMRzi1gtr6t7k4x6g+qHnBYR+S0sWsWoH9/5sXK85dbIq1DGfo654ARzUEuxy8f6fN0qUNEB6vuhB9xsARkM//uKXs7HJ/4zKr2r8MsC94UeCVdSWUSe/Xp3aq3eVV7YAvIP40EEwDOqhMIpDRIwaI7uDajjhjmp+tICbcbuQLW9QBIYyI7ZcCFfE+CJEEpLAH1siYp26KY8iEd/QwM3wiHmgb21u1Ig221n5AzgbHqe2MY4Fd6BhcrKbr0Z1NCcLLCIActn8ZVEC3jBU8WBuc4VeLSTwuNKI+FqGdBojPPOa2A0C9jwKchH5lQMrk6phwv0nJNIr0xNZZTeK9ZdJhk5abY9Vo5OtehC+1HTV/oAu9eyglvdzKUGQklr4BQVjRY5lsW3yvT1502xPHlcYstY3tTz9GpIlGr4U5ZPL6H+v//QoTC0IdqpESrAUZgLg==;5:/jGiLUc+BdL/il0Fwmw6fNHheORbW5bibh/iIrAj77tPursc+nzBFDcmoaXiuBtTDs/K92yk1iVxTO+lWIDhzygB4pH+VBKwMNJG3NGSqpf/Frv7FHV5HzcobALtVGbk0Rv3c1TKuifFmnE6i5a42/RQpkoCUdaKuYW9kvBmEDo=;24:0Sdj44ycTtw94AojgTmyaQAukUF/9iJZci1MWPGEM1pGBnwJvGkPXFrriTbnqfYzuEpE0ArJvsWHCRVBZYgGrffb25eGOK6rC9RDUD1o/mE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB387;7:eYZt/uZ1XfW/dgYnl9acKk7yUrLUofo+ZFlBX1JsbFu9KiZoztspjoE+Lm+CjRi/etbZWLy8sHiJ0dtQJDG36fOSrTyKY8NBnWauEOY/6769HfiVs5I9fCga3fEhzZaSixRvrv++OKeNNT6rJbQjwpyzTH0ToXjIIEEnR07xru0Fy/w9CFncNyyWvGizSapm/aOjjgc4KKIe9OVxEm7hX0WoGw6d0YHK4omKI2d/9pTEh+Yr0Nx8BW1JcJlSGu09
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 03:55:43.6776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d147bd3-c02a-4a9e-df42-08d59528f2eb
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB387
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sleep mode, the clocks of CPU core and unused IP blocks are turned
off (IP blocks allowed to wake up system will running).

Some QorIQ SoCs like MPC8536, P1022 and T104x, have deep sleep PM mode
in addtion to the sleep PM mode. While in deep sleep mode,
additionally, the power supply is removed from CPU core and most IP
blocks. Only the blocks needed to wake up the chip out of deep sleep
are ON.

This feature supports 32-bit and 36-bit address space.

The sleep mode is equal to the Standby state in Linux. The deep sleep
mode is equal to the Suspend-to-RAM state of Linux Power Management.
    Command to enter sleep mode.
        echo standby > /sys/power/state
    Command to enter deep sleep mode.
        echo mem > /sys/power/state

Signed-off-by: Dave Liu <daveliu@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
Signed-off-by: Zhao Qiang <B45475@freescale.com>
Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/powerpc/include/asm/cacheflush.h         |    7 +
 arch/powerpc/include/asm/fsl_pm.h             |   31 +
 arch/powerpc/kernel/Makefile                  |    1 +
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |   10 +
 arch/powerpc/kernel/fsl_pm.c                  |   49 +
 arch/powerpc/kernel/head_64.S                 |    2 +-
 arch/powerpc/platforms/85xx/Kconfig           |    6 +
 arch/powerpc/platforms/85xx/Makefile          |    2 +
 arch/powerpc/platforms/85xx/deepsleep.c       |  349 ++++++++
 arch/powerpc/platforms/85xx/qoriq_pm.c        |  223 +++++
 arch/powerpc/platforms/85xx/sleep.S           | 1192 +++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig           |    1 +
 arch/powerpc/sysdev/fsl_pmc.c                 |  176 ++++-
 arch/powerpc/sysdev/fsl_soc.c                 |   31 +
 arch/powerpc/sysdev/fsl_soc.h                 |   18 +
 15 files changed, 2078 insertions(+), 20 deletions(-)
 create mode 100644 arch/powerpc/kernel/fsl_pm.c
 create mode 100644 arch/powerpc/platforms/85xx/deepsleep.c
 create mode 100644 arch/powerpc/platforms/85xx/qoriq_pm.c
 create mode 100644 arch/powerpc/platforms/85xx/sleep.S

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index b77f036..a5411af 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -31,6 +31,13 @@
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
+extern void __flush_disable_L1(void);
+#ifdef CONFIG_FSL_SOC_BOOKE
+extern void flush_dcache_L1(void);
+#else
+#define flush_dcache_L1()			do { } while (0)
+#endif
+
 extern void flush_icache_range(unsigned long, unsigned long);
 extern void flush_icache_user_range(struct vm_area_struct *vma,
 				    struct page *page, unsigned long addr,
diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm/fsl_pm.h
index 47df55e..510e5d2 100644
--- a/arch/powerpc/include/asm/fsl_pm.h
+++ b/arch/powerpc/include/asm/fsl_pm.h
@@ -11,6 +11,9 @@
 #ifndef __PPC_FSL_PM_H
 #define __PPC_FSL_PM_H
 
+#ifndef __ASSEMBLY__
+#include <linux/suspend.h>
+
 #define E500_PM_PH10	1
 #define E500_PM_PH15	2
 #define E500_PM_PH20	3
@@ -46,6 +49,34 @@ struct fsl_pm_ops {
 
 extern const struct fsl_pm_ops *qoriq_pm_ops;
 
+struct fsm_reg_vals {
+	u32 offset;
+	u32 value;
+};
+
+void fsl_fsm_setup(void __iomem *base, struct fsm_reg_vals *val);
+void fsl_epu_setup_default(void __iomem *epu_base);
+void fsl_npc_setup_default(void __iomem *npc_base);
+void fsl_fsm_clean(void __iomem *base, struct fsm_reg_vals *val);
+void fsl_epu_clean_default(void __iomem *epu_base);
+
+extern int fsl_dp_iomap(void);
+extern void fsl_dp_iounmap(void);
+
+extern int fsl_enter_epu_deepsleep(void);
+extern void fsl_dp_enter_low(void __iomem *ccsr_base, void __iomem *dcsr_base,
+			     void __iomem *pld_base, int pld_flag);
+extern void fsl_booke_deep_sleep_resume(void);
+
 int __init fsl_rcpm_init(void);
 
+void set_pm_suspend_state(suspend_state_t state);
+suspend_state_t pm_suspend_state(void);
+
+void fsl_set_power_except(struct device *dev, int on);
+#endif	/* __ASSEMBLY__ */
+
+#define T1040QDS_TETRA_FLAG	1
+#define T104xRDB_CPLD_FLAG	2
+
 #endif /* __PPC_FSL_PM_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1b6bc7f..f191269 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_FA_DUMP)		+= fadump.o
+obj-$(CONFIG_FSL_SOC)		+= fsl_pm.o
 ifeq ($(CONFIG_PPC32),y)
 obj-$(CONFIG_E500)		+= idle_e500.o
 endif
diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index ea06528..0e3484d 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -174,6 +174,10 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@h
 	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@l
 	mtspr	SPRN_MAS2,r6
+#ifdef ENTRY_DEEPSLEEP_SETUP
+	LOAD_REG_IMMEDIATE(r8, MEMORY_START)
+	ori	r8,r8,(MAS3_SX|MAS3_SW|MAS3_SR)
+#endif
 	mtspr	SPRN_MAS3,r8
 	tlbwe
 
@@ -216,12 +220,18 @@ next_tlb_setup:
 	#error You need to specify the mapping or not use this at all.
 #endif
 
+#ifdef ENTRY_DEEPSLEEP_SETUP
+	LOAD_REG_ADDR(r6, 2f)
+	mfmsr	r7
+	rlwinm	r7,r7,0,~(MSR_IS|MSR_DS)
+#else
 	lis	r7,MSR_KERNEL@h
 	ori	r7,r7,MSR_KERNEL@l
 	bl	1f			/* Find our address */
 1:	mflr	r9
 	rlwimi	r6,r9,0,20,31
 	addi	r6,r6,(2f - 1b)
+#endif
 	mtspr	SPRN_SRR0,r6
 	mtspr	SPRN_SRR1,r7
 	rfi				/* start execution out of TLB1[0] entry */
diff --git a/arch/powerpc/kernel/fsl_pm.c b/arch/powerpc/kernel/fsl_pm.c
new file mode 100644
index 0000000..f328c4e
--- /dev/null
+++ b/arch/powerpc/kernel/fsl_pm.c
@@ -0,0 +1,49 @@
+/*
+ * Freescale General Power Management Implementation
+ *
+ * Copyright 2018 NXP
+ * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
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
+*/
+
+#include <linux/suspend.h>
+#include <asm/fsl_pm.h>
+
+static suspend_state_t pm_state;
+
+void set_pm_suspend_state(suspend_state_t state)
+{
+	pm_state = state;
+}
+
+suspend_state_t pm_suspend_state(void)
+{
+	return pm_state;
+}
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index a61151a..3f0b397 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -863,7 +863,7 @@ _GLOBAL(start_secondary_resume)
 /*
  * This subroutine clobbers r11 and r12
  */
-enable_64b_mode:
+_GLOBAL(enable_64b_mode)
 	mfmsr	r11			/* grab the current MSR */
 #ifdef CONFIG_PPC_BOOK3E
 	oris	r11,r11,0x8000		/* CM bit set, we'll set ICM later */
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 68920d4..b2fbefe 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -10,6 +10,8 @@ menuconfig FSL_SOC_BOOKE
 	select SERIAL_8250_EXTENDED if SERIAL_8250
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	select FSL_CORENET_RCPM if PPC_E500MC
+	select FSL_QORIQ_PM if SUSPEND && PPC_E500MC
+	select FSL_PMC if SUSPEND && !PPC_E500MC
 	default y
 
 if FSL_SOC_BOOKE
@@ -292,3 +294,7 @@ endif # FSL_SOC_BOOKE
 
 config TQM85xx
 	bool
+
+config FSL_QORIQ_PM
+	bool
+	select FSL_SLEEP_FSM
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index d1dd0dc..8e9f369 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -3,7 +3,9 @@
 # Makefile for the PowerPC 85xx linux kernel.
 #
 obj-$(CONFIG_SMP) += smp.o
+obj-$(CONFIG_SUSPEND)		  += sleep.o
 obj-$(CONFIG_FSL_PMC)		  += mpc85xx_pm_ops.o
+obj-$(CONFIG_FSL_QORIQ_PM)	  += qoriq_pm.o deepsleep.o
 
 obj-y += common.o
 
diff --git a/arch/powerpc/platforms/85xx/deepsleep.c b/arch/powerpc/platforms/85xx/deepsleep.c
new file mode 100644
index 0000000..183d55c
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/deepsleep.c
@@ -0,0 +1,349 @@
+/*
+ * Support deep sleep feature for T104x
+ *
+ * Copyright 2018 NXP
+ * Author: Chenhui Zhao <chenhui.zhao@freescale.com>
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
+*/
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <sysdev/fsl_soc.h>
+#include <asm/machdep.h>
+#include <asm/fsl_pm.h>
+
+#define SIZE_1MB	0x100000
+#define SIZE_2MB	0x200000
+
+#define CPC_CPCHDBCR0		0x10f00
+#define CPC_CPCHDBCR0_SPEC_DIS	0x08000000
+
+#define CCSR_SCFG_DPSLPCR	0xfc000
+#define CCSR_SCFG_DPSLPCR_WDRR_EN	0x1
+#define CCSR_SCFG_SPARECR2	0xfc504
+#define CCSR_SCFG_SPARECR3	0xfc508
+
+#define CCSR_GPIO1_GPDIR	0x130000
+#define CCSR_GPIO1_GPODR	0x130004
+#define CCSR_GPIO1_GPDAT	0x130008
+#define CCSR_GPIO1_GPDIR_29	0x4
+
+#define RCPM_BLOCK_OFFSET	0x00022000
+#define EPU_BLOCK_OFFSET	0x00000000
+#define NPC_BLOCK_OFFSET	0x00001000
+
+#define CSTTACR0		0xb00
+#define CG1CR0			0x31c
+
+#define CCSR_LAW_BASE		0xC00
+#define DCFG_BRR	0xE4	/* boot release register */
+#define LCC_BSTRH	0x20	/* Boot space translation register high */
+#define LCC_BSTRL	0x24	/* Boot space translation register low */
+#define LCC_BSTAR	0x28	/* Boot space translation attribute register */
+#define RCPM_PCTBENR	0x1A0	/* Physical Core Timebase Enable Register */
+#define RCPM_BASE	0xE2000
+#define DCFG_BASE	0xE0000
+
+/* 128 bytes buffer for restoring data broke by DDR training initialization */
+#define DDR_BUF_SIZE	128
+static u8 ddr_buff[DDR_BUF_SIZE] __aligned(64);
+
+static void *dcsr_base, *ccsr_base, *pld_base;
+static int pld_flag;
+
+/* for law */
+struct fsl_law {
+	u32	lawbarh;	/* LAWn base address high */
+	u32	lawbarl;	/* LAWn base address low */
+	u32	lawar;		/* LAWn attributes */
+	u32	reserved;
+};
+
+struct fsl_law *saved_law;
+static u32 num_laws;
+
+/* for nonboot cpu */
+struct fsl_bstr {
+	u32	bstrh;
+	u32	bstrl;
+	u32	bstar;
+	u32 cpu_mask;
+};
+static struct fsl_bstr saved_bstr;
+
+int fsl_dp_iomap(void)
+{
+	struct device_node *np;
+	int ret = 0;
+	phys_addr_t ccsr_phy_addr, dcsr_phy_addr;
+
+	saved_law = NULL;
+	ccsr_base = NULL;
+	dcsr_base = NULL;
+	pld_base = NULL;
+
+	ccsr_phy_addr = get_immrbase();
+	if (ccsr_phy_addr == -1) {
+		pr_err("%s: Can't get the address of CCSR\n", __func__);
+		ret = -EINVAL;
+		goto ccsr_err;
+	}
+	ccsr_base = ioremap(ccsr_phy_addr, SIZE_2MB);
+	if (!ccsr_base) {
+		ret = -ENOMEM;
+		goto ccsr_err;
+	}
+
+	dcsr_phy_addr = get_dcsrbase();
+	if (dcsr_phy_addr == -1) {
+		pr_err("%s: Can't get the address of DCSR\n", __func__);
+		ret = -EINVAL;
+		goto dcsr_err;
+	}
+	dcsr_base = ioremap(dcsr_phy_addr, SIZE_1MB);
+	if (!dcsr_base) {
+		ret = -ENOMEM;
+		goto dcsr_err;
+	}
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,tetra-fpga");
+	if (np) {
+		pld_flag = T1040QDS_TETRA_FLAG;
+	} else {
+		np = of_find_compatible_node(NULL, NULL, "fsl,deepsleep-cpld");
+		if (np) {
+			pld_flag = T104xRDB_CPLD_FLAG;
+		} else {
+			pr_err("%s: Can't find the FPGA/CPLD node\n",
+					__func__);
+			ret = -EINVAL;
+			goto pld_err;
+		}
+	}
+	pld_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,corenet-law");
+	if (!np) {
+		pr_err("%s: Can't find the node of \"law\"\n", __func__);
+		ret = -EINVAL;
+		goto alloc_err;
+	}
+	ret = of_property_read_u32(np, "fsl,num-laws", &num_laws);
+	if (ret) {
+		ret = -EINVAL;
+		goto alloc_err;
+	}
+
+	saved_law = kzalloc(sizeof(*saved_law) * num_laws, GFP_KERNEL);
+	if (!saved_law) {
+		ret = -ENOMEM;
+		goto alloc_err;
+	}
+	of_node_put(np);
+
+	return 0;
+
+alloc_err:
+	iounmap(pld_base);
+	pld_base = NULL;
+pld_err:
+	iounmap(dcsr_base);
+	dcsr_base = NULL;
+dcsr_err:
+	iounmap(ccsr_base);
+	ccsr_base = NULL;
+ccsr_err:
+	return ret;
+}
+
+void fsl_dp_iounmap(void)
+{
+	if (dcsr_base) {
+		iounmap(dcsr_base);
+		dcsr_base = NULL;
+	}
+
+	if (ccsr_base) {
+		iounmap(ccsr_base);
+		ccsr_base = NULL;
+	}
+
+	if (pld_base) {
+		iounmap(pld_base);
+		pld_base = NULL;
+	}
+
+	kfree(saved_law);
+	saved_law = NULL;
+}
+
+static void fsl_dp_ddr_save(void *ccsr_base)
+{
+	u32 ddr_buff_addr;
+
+	/*
+	 * DDR training initialization will break 128 bytes at the beginning
+	 * of DDR, therefore, save them so that the bootloader will restore
+	 * them. Assume that DDR is mapped to the address space started with
+	 * CONFIG_PAGE_OFFSET.
+	 */
+	memcpy(ddr_buff, (void *)CONFIG_PAGE_OFFSET, DDR_BUF_SIZE);
+
+	/* assume ddr_buff is in the physical address space of 4GB */
+	ddr_buff_addr = (u32)(__pa(ddr_buff) & 0xffffffff);
+
+	/*
+	 * the bootloader will restore the first 128 bytes of DDR from
+	 * the location indicated by the register SPARECR3
+	 */
+	out_be32(ccsr_base + CCSR_SCFG_SPARECR3, ddr_buff_addr);
+}
+
+static void fsl_dp_mp_save(void *ccsr)
+{
+	 struct fsl_bstr *dst = &saved_bstr;
+
+	 dst->bstrh = in_be32(ccsr + LCC_BSTRH);
+	 dst->bstrl = in_be32(ccsr + LCC_BSTRL);
+	 dst->bstar = in_be32(ccsr + LCC_BSTAR);
+	 dst->cpu_mask = in_be32(ccsr + DCFG_BASE + DCFG_BRR);
+}
+
+static void fsl_dp_mp_restore(void *ccsr)
+{
+	 struct fsl_bstr *src = &saved_bstr;
+
+	 out_be32(ccsr + LCC_BSTRH, src->bstrh);
+	 out_be32(ccsr + LCC_BSTRL, src->bstrl);
+	 out_be32(ccsr + LCC_BSTAR, src->bstar);
+
+	 /* release the nonboot cpus */
+	 out_be32(ccsr + DCFG_BASE + DCFG_BRR, src->cpu_mask);
+
+	 /* enable the time base */
+	 out_be32(ccsr + RCPM_BASE + RCPM_PCTBENR, src->cpu_mask);
+	 /* read back to sync write */
+	 in_be32(ccsr + RCPM_BASE + RCPM_PCTBENR);
+}
+
+static void fsl_dp_law_save(void *ccsr)
+{
+	int i;
+	struct fsl_law *dst = saved_law;
+	struct fsl_law *src = (void *)(ccsr + CCSR_LAW_BASE);
+
+	for (i = 0; i < num_laws; i++) {
+		dst->lawbarh = in_be32(&src->lawbarh);
+		dst->lawbarl = in_be32(&src->lawbarl);
+		dst->lawar = in_be32(&src->lawar);
+		dst++;
+		src++;
+	}
+}
+
+static void fsl_dp_law_restore(void *ccsr)
+{
+	int i;
+	struct fsl_law *src = saved_law;
+	struct fsl_law *dst = (void *)(ccsr + CCSR_LAW_BASE);
+
+	for (i = 0; i < num_laws - 1; i++) {
+		out_be32(&dst->lawar, 0);
+		out_be32(&dst->lawbarl, src->lawbarl);
+		out_be32(&dst->lawbarh, src->lawbarh);
+		out_be32(&dst->lawar, src->lawar);
+
+		 /* Read back so that we sync the writes */
+		in_be32(&dst->lawar);
+		src++;
+		dst++;
+	}
+}
+
+static void fsl_dp_set_resume_pointer(void *ccsr_base)
+{
+	u32 resume_addr;
+
+	/* the bootloader will finally jump to this address to return kernel */
+#ifdef CONFIG_PPC32
+	resume_addr = (u32)(__pa(fsl_booke_deep_sleep_resume));
+#else
+	resume_addr = (u32)(__pa(*(u64 *)fsl_booke_deep_sleep_resume)
+			    & 0xffffffff);
+#endif
+
+	/* use the register SPARECR2 to save the resume address */
+	out_be32(ccsr_base + CCSR_SCFG_SPARECR2, resume_addr);
+
+}
+
+int fsl_enter_epu_deepsleep(void)
+{
+	fsl_dp_ddr_save(ccsr_base);
+
+	fsl_dp_set_resume_pointer(ccsr_base);
+
+	fsl_dp_mp_save(ccsr_base);
+	fsl_dp_law_save(ccsr_base);
+	/*  enable Warm Device Reset request. */
+	setbits32(ccsr_base + CCSR_SCFG_DPSLPCR, CCSR_SCFG_DPSLPCR_WDRR_EN);
+
+	/* set GPIO1_29 as an output pin (not open-drain), and output 0 */
+	clrbits32(ccsr_base + CCSR_GPIO1_GPDAT, CCSR_GPIO1_GPDIR_29);
+	clrbits32(ccsr_base + CCSR_GPIO1_GPODR, CCSR_GPIO1_GPDIR_29);
+	setbits32(ccsr_base + CCSR_GPIO1_GPDIR, CCSR_GPIO1_GPDIR_29);
+
+	/*
+	 * Disable CPC speculation to avoid deep sleep hang, especially
+	 * in secure boot mode. This bit will be cleared automatically
+	 * when resuming from deep sleep.
+	 */
+	setbits32(ccsr_base + CPC_CPCHDBCR0, CPC_CPCHDBCR0_SPEC_DIS);
+
+	fsl_epu_setup_default(dcsr_base + EPU_BLOCK_OFFSET);
+	fsl_npc_setup_default(dcsr_base + NPC_BLOCK_OFFSET);
+	out_be32(dcsr_base + RCPM_BLOCK_OFFSET + CSTTACR0, 0x00001001);
+	out_be32(dcsr_base + RCPM_BLOCK_OFFSET + CG1CR0, 0x00000001);
+
+	fsl_dp_enter_low(ccsr_base, dcsr_base, pld_base, pld_flag);
+
+	fsl_dp_law_restore(ccsr_base);
+	fsl_dp_mp_restore(ccsr_base);
+
+	/* disable Warm Device Reset request */
+	clrbits32(ccsr_base + CCSR_SCFG_DPSLPCR, CCSR_SCFG_DPSLPCR_WDRR_EN);
+
+	fsl_epu_clean_default(dcsr_base + EPU_BLOCK_OFFSET);
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/85xx/qoriq_pm.c b/arch/powerpc/platforms/85xx/qoriq_pm.c
new file mode 100644
index 0000000..0705f05
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/qoriq_pm.c
@@ -0,0 +1,223 @@
+/*
+ * Support Power Management feature
+ *
+ * Copyright 2018 NXP
+ * Author: Chenhui Zhao <chenhui.zhao@freescale.com>
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
+*/
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+#include <linux/of_platform.h>
+#include <linux/usb.h>
+
+#include <asm/fsl_pm.h>
+
+#define FSL_SLEEP		0x1
+#define FSL_DEEP_SLEEP		0x2
+
+int (*fsl_enter_deepsleep)(void);
+
+/* specify the sleep state of the present platform */
+unsigned int sleep_pm_state;
+/* supported sleep modes by the present platform */
+static unsigned int sleep_modes;
+
+/**
+ * fsl_set_power_except - set which IP block is not powerdown when sleep,
+ * such as MAC, USB, etc.
+ *
+ * @dev: a pointer to the struct device
+ * @on: if 1, do not power down; if 0, power down.
+ */
+void fsl_set_power_except(struct device *dev, int on)
+ {
+	u32 value[2];
+	u32 pw_mask;
+	const phandle *phandle_prop;
+	struct device_node *mac_node;
+	int ret;
+
+	if (dev && !strncmp(dev->bus->name, "usb", 3)) {
+		struct usb_device *udev = container_of(dev,
+						struct usb_device, dev);
+		struct device *controller = udev->bus->controller;
+
+		ret = of_property_read_u32_array(controller->parent->of_node,
+				"sleep", value, 2);
+	} else
+		ret = of_property_read_u32_array(dev->of_node, "sleep",
+				value, 2);
+
+	if (ret) {
+		/* search fman mac node */
+		phandle_prop = of_get_property(dev->of_node, "fsl,fman-mac",
+					       NULL);
+		if (phandle_prop == NULL)
+			goto err;
+
+		mac_node = of_find_node_by_phandle(*phandle_prop);
+		ret = of_property_read_u32_array(mac_node, "sleep", value, 2);
+		of_node_put(mac_node);
+		if (ret)
+			goto err;
+	}
+	/* get the second value, it is a mask */
+	pw_mask = value[1];
+	qoriq_pm_ops->set_ip_power(on, pw_mask);
+	return;
+
+err:
+	dev_err(dev, "Can not set wakeup sources\n");
+	return;
+}
+EXPORT_SYMBOL_GPL(fsl_set_power_except);
+
+void qoriq_set_wakeup_source(struct device *dev, void *enable)
+{
+	if (!device_may_wakeup(dev))
+		return;
+
+	fsl_set_power_except(dev, *((int *)enable));
+}
+
+static int qoriq_suspend_enter(suspend_state_t state)
+{
+	int ret = 0;
+	int cpu;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+
+		if (cur_cpu_spec->cpu_flush_caches)
+			cur_cpu_spec->cpu_flush_caches();
+
+		ret = qoriq_pm_ops->plat_enter_sleep();
+
+		break;
+
+	case PM_SUSPEND_MEM:
+
+		cpu = smp_processor_id();
+		qoriq_pm_ops->irq_mask(cpu);
+
+		ret = fsl_enter_deepsleep();
+
+		qoriq_pm_ops->irq_unmask(cpu);
+
+		break;
+
+	default:
+		ret = -EINVAL;
+
+	}
+
+	return ret;
+}
+
+static int qoriq_suspend_valid(suspend_state_t state)
+{
+	set_pm_suspend_state(state);
+
+	if (state == PM_SUSPEND_STANDBY && (sleep_modes & FSL_SLEEP))
+		return 1;
+
+	if (state == PM_SUSPEND_MEM && (sleep_modes & FSL_DEEP_SLEEP))
+		return 1;
+
+	set_pm_suspend_state(PM_SUSPEND_ON);
+	return 0;
+}
+
+static int qoriq_suspend_begin(suspend_state_t state)
+{
+	const int enable = 1;
+
+	dpm_for_each_dev((void *)&enable, qoriq_set_wakeup_source);
+
+	if (state == PM_SUSPEND_MEM)
+		return fsl_dp_iomap();
+
+	return 0;
+}
+
+static void qoriq_suspend_end(void)
+{
+	const int enable = 0;
+
+	dpm_for_each_dev((void *)&enable, qoriq_set_wakeup_source);
+
+	set_pm_suspend_state(PM_SUSPEND_ON);
+	fsl_dp_iounmap();
+}
+
+static const struct platform_suspend_ops qoriq_suspend_ops = {
+	.valid = qoriq_suspend_valid,
+	.enter = qoriq_suspend_enter,
+	.begin = qoriq_suspend_begin,
+	.end = qoriq_suspend_end,
+};
+
+static const struct of_device_id deepsleep_matches[] = {
+	{
+		.compatible = "fsl,t1040-rcpm",
+	},
+	{
+		.compatible = "fsl,t1024-rcpm",
+	},
+	{
+		.compatible = "fsl,t1023-rcpm",
+	},
+	{},
+};
+
+static int __init qoriq_suspend_init(void)
+{
+	struct device_node *np;
+
+	sleep_modes = FSL_SLEEP;
+	sleep_pm_state = PLAT_PM_SLEEP;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-rcpm-2.0");
+	if (np)
+		sleep_pm_state = PLAT_PM_LPM20;
+
+	np = of_find_matching_node_and_match(NULL, deepsleep_matches, NULL);
+	if (np) {
+		fsl_enter_deepsleep = fsl_enter_epu_deepsleep;
+		sleep_modes |= FSL_DEEP_SLEEP;
+	}
+
+	suspend_set_ops(&qoriq_suspend_ops);
+	set_pm_suspend_state(PM_SUSPEND_ON);
+
+	return 0;
+}
+arch_initcall(qoriq_suspend_init);
diff --git a/arch/powerpc/platforms/85xx/sleep.S b/arch/powerpc/platforms/85xx/sleep.S
new file mode 100644
index 0000000..b7942ed
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/sleep.S
@@ -0,0 +1,1192 @@
+/*
+ * Enter and leave deep sleep/sleep state
+ *
+ * Copyright 2018 NXP
+ * Author: Scott Wood <scottwood@freescale.com>
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
+*/
+
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+#include <asm/reg.h>
+#include <asm/asm-offsets.h>
+#include <asm/fsl_pm.h>
+#include <asm/mmu.h>
+
+/*
+ * the number of bytes occupied by one register
+ * the value of 8 is compatible with both 32-bit and 64-bit registers
+ */
+#define STRIDE_SIZE		8
+
+/* GPR0 - GPR31 */
+#define BOOKE_GPR0_OFF		0x0000
+#define BOOKE_GPR_COUNT		32
+/* IVOR0 - IVOR42 */
+#define BOOKE_IVOR0_OFF	   (BOOKE_GPR0_OFF + BOOKE_GPR_COUNT * STRIDE_SIZE)
+#define BOOKE_IVOR_COUNT	43
+/* SPRG0 - SPRG9 */
+#define BOOKE_SPRG0_OFF	   (BOOKE_IVOR0_OFF + BOOKE_IVOR_COUNT * STRIDE_SIZE)
+#define BOOKE_SPRG_COUNT	10
+/* IVPR */
+#define BOOKE_IVPR_OFF	   (BOOKE_SPRG0_OFF + BOOKE_SPRG_COUNT * STRIDE_SIZE)
+
+#define BOOKE_LR_OFF		(BOOKE_IVPR_OFF + STRIDE_SIZE)
+#define BOOKE_MSR_OFF		(BOOKE_LR_OFF + STRIDE_SIZE)
+#define BOOKE_TBU_OFF		(BOOKE_MSR_OFF + STRIDE_SIZE)
+#define BOOKE_TBL_OFF		(BOOKE_TBU_OFF + STRIDE_SIZE)
+#define BOOKE_EPCR_OFF		(BOOKE_TBL_OFF + STRIDE_SIZE)
+#define BOOKE_HID0_OFF		(BOOKE_EPCR_OFF + STRIDE_SIZE)
+#define BOOKE_PIR_OFF		(BOOKE_HID0_OFF + STRIDE_SIZE)
+#define BOOKE_PID0_OFF		(BOOKE_PIR_OFF + STRIDE_SIZE)
+#define BOOKE_BUCSR_OFF		(BOOKE_PID0_OFF + STRIDE_SIZE)
+
+#define BUFFER_SIZE		(BOOKE_BUCSR_OFF + STRIDE_SIZE)
+
+#undef SAVE_GPR
+#define SAVE_GPR(gpr, offset) \
+	PPC_STL gpr, offset(r10)
+
+#define RESTORE_GPR(gpr, offset) \
+	PPC_LL gpr, offset(r10)
+
+#define SAVE_SPR(spr, offset) \
+	mfspr	r0, spr ;\
+	PPC_STL	r0, offset(r10)
+
+#define RESTORE_SPR(spr, offset) \
+	PPC_LL	r0, offset(r10) ;\
+	mtspr	spr, r0
+
+#define SAVE_ALL_GPR \
+	SAVE_GPR(r1, BOOKE_GPR0_OFF + STRIDE_SIZE * 1) ;\
+	SAVE_GPR(r2, BOOKE_GPR0_OFF + STRIDE_SIZE * 2) ;\
+	SAVE_GPR(r13, BOOKE_GPR0_OFF + STRIDE_SIZE * 13) ;\
+	SAVE_GPR(r14, BOOKE_GPR0_OFF + STRIDE_SIZE * 14) ;\
+	SAVE_GPR(r15, BOOKE_GPR0_OFF + STRIDE_SIZE * 15) ;\
+	SAVE_GPR(r16, BOOKE_GPR0_OFF + STRIDE_SIZE * 16) ;\
+	SAVE_GPR(r17, BOOKE_GPR0_OFF + STRIDE_SIZE * 17) ;\
+	SAVE_GPR(r18, BOOKE_GPR0_OFF + STRIDE_SIZE * 18) ;\
+	SAVE_GPR(r19, BOOKE_GPR0_OFF + STRIDE_SIZE * 19) ;\
+	SAVE_GPR(r20, BOOKE_GPR0_OFF + STRIDE_SIZE * 20) ;\
+	SAVE_GPR(r21, BOOKE_GPR0_OFF + STRIDE_SIZE * 21) ;\
+	SAVE_GPR(r22, BOOKE_GPR0_OFF + STRIDE_SIZE * 22) ;\
+	SAVE_GPR(r23, BOOKE_GPR0_OFF + STRIDE_SIZE * 23) ;\
+	SAVE_GPR(r24, BOOKE_GPR0_OFF + STRIDE_SIZE * 24) ;\
+	SAVE_GPR(r25, BOOKE_GPR0_OFF + STRIDE_SIZE * 25) ;\
+	SAVE_GPR(r26, BOOKE_GPR0_OFF + STRIDE_SIZE * 26) ;\
+	SAVE_GPR(r27, BOOKE_GPR0_OFF + STRIDE_SIZE * 27) ;\
+	SAVE_GPR(r28, BOOKE_GPR0_OFF + STRIDE_SIZE * 28) ;\
+	SAVE_GPR(r29, BOOKE_GPR0_OFF + STRIDE_SIZE * 29) ;\
+	SAVE_GPR(r30, BOOKE_GPR0_OFF + STRIDE_SIZE * 30) ;\
+	SAVE_GPR(r31, BOOKE_GPR0_OFF + STRIDE_SIZE * 31)
+
+#define RESTORE_ALL_GPR \
+	RESTORE_GPR(r1, BOOKE_GPR0_OFF + STRIDE_SIZE * 1) ;\
+	RESTORE_GPR(r2, BOOKE_GPR0_OFF + STRIDE_SIZE * 2) ;\
+	RESTORE_GPR(r13, BOOKE_GPR0_OFF + STRIDE_SIZE * 13) ;\
+	RESTORE_GPR(r14, BOOKE_GPR0_OFF + STRIDE_SIZE * 14) ;\
+	RESTORE_GPR(r15, BOOKE_GPR0_OFF + STRIDE_SIZE * 15) ;\
+	RESTORE_GPR(r16, BOOKE_GPR0_OFF + STRIDE_SIZE * 16) ;\
+	RESTORE_GPR(r17, BOOKE_GPR0_OFF + STRIDE_SIZE * 17) ;\
+	RESTORE_GPR(r18, BOOKE_GPR0_OFF + STRIDE_SIZE * 18) ;\
+	RESTORE_GPR(r19, BOOKE_GPR0_OFF + STRIDE_SIZE * 19) ;\
+	RESTORE_GPR(r20, BOOKE_GPR0_OFF + STRIDE_SIZE * 20) ;\
+	RESTORE_GPR(r21, BOOKE_GPR0_OFF + STRIDE_SIZE * 21) ;\
+	RESTORE_GPR(r22, BOOKE_GPR0_OFF + STRIDE_SIZE * 22) ;\
+	RESTORE_GPR(r23, BOOKE_GPR0_OFF + STRIDE_SIZE * 23) ;\
+	RESTORE_GPR(r24, BOOKE_GPR0_OFF + STRIDE_SIZE * 24) ;\
+	RESTORE_GPR(r25, BOOKE_GPR0_OFF + STRIDE_SIZE * 25) ;\
+	RESTORE_GPR(r26, BOOKE_GPR0_OFF + STRIDE_SIZE * 26) ;\
+	RESTORE_GPR(r27, BOOKE_GPR0_OFF + STRIDE_SIZE * 27) ;\
+	RESTORE_GPR(r28, BOOKE_GPR0_OFF + STRIDE_SIZE * 28) ;\
+	RESTORE_GPR(r29, BOOKE_GPR0_OFF + STRIDE_SIZE * 29) ;\
+	RESTORE_GPR(r30, BOOKE_GPR0_OFF + STRIDE_SIZE * 30) ;\
+	RESTORE_GPR(r31, BOOKE_GPR0_OFF + STRIDE_SIZE * 31)
+
+#define SAVE_ALL_SPRG \
+	SAVE_SPR(SPRN_SPRG0, BOOKE_SPRG0_OFF + STRIDE_SIZE * 0) ;\
+	SAVE_SPR(SPRN_SPRG1, BOOKE_SPRG0_OFF + STRIDE_SIZE * 1) ;\
+	SAVE_SPR(SPRN_SPRG2, BOOKE_SPRG0_OFF + STRIDE_SIZE * 2) ;\
+	SAVE_SPR(SPRN_SPRG3, BOOKE_SPRG0_OFF + STRIDE_SIZE * 3) ;\
+	SAVE_SPR(SPRN_SPRG4, BOOKE_SPRG0_OFF + STRIDE_SIZE * 4) ;\
+	SAVE_SPR(SPRN_SPRG5, BOOKE_SPRG0_OFF + STRIDE_SIZE * 5) ;\
+	SAVE_SPR(SPRN_SPRG6, BOOKE_SPRG0_OFF + STRIDE_SIZE * 6) ;\
+	SAVE_SPR(SPRN_SPRG7, BOOKE_SPRG0_OFF + STRIDE_SIZE * 7) ;\
+	SAVE_SPR(SPRN_SPRG8, BOOKE_SPRG0_OFF + STRIDE_SIZE * 8) ;\
+	SAVE_SPR(SPRN_SPRG9, BOOKE_SPRG0_OFF + STRIDE_SIZE * 9)
+
+#define RESTORE_ALL_SPRG \
+	RESTORE_SPR(SPRN_SPRG0, BOOKE_SPRG0_OFF + STRIDE_SIZE * 0) ;\
+	RESTORE_SPR(SPRN_SPRG1, BOOKE_SPRG0_OFF + STRIDE_SIZE * 1) ;\
+	RESTORE_SPR(SPRN_SPRG2, BOOKE_SPRG0_OFF + STRIDE_SIZE * 2) ;\
+	RESTORE_SPR(SPRN_SPRG3, BOOKE_SPRG0_OFF + STRIDE_SIZE * 3) ;\
+	RESTORE_SPR(SPRN_SPRG4, BOOKE_SPRG0_OFF + STRIDE_SIZE * 4) ;\
+	RESTORE_SPR(SPRN_SPRG5, BOOKE_SPRG0_OFF + STRIDE_SIZE * 5) ;\
+	RESTORE_SPR(SPRN_SPRG6, BOOKE_SPRG0_OFF + STRIDE_SIZE * 6) ;\
+	RESTORE_SPR(SPRN_SPRG7, BOOKE_SPRG0_OFF + STRIDE_SIZE * 7) ;\
+	RESTORE_SPR(SPRN_SPRG8, BOOKE_SPRG0_OFF + STRIDE_SIZE * 8) ;\
+	RESTORE_SPR(SPRN_SPRG9, BOOKE_SPRG0_OFF + STRIDE_SIZE * 9)
+
+#define SAVE_ALL_IVOR \
+	SAVE_SPR(SPRN_IVOR0, BOOKE_IVOR0_OFF + STRIDE_SIZE * 0) ;\
+	SAVE_SPR(SPRN_IVOR1, BOOKE_IVOR0_OFF + STRIDE_SIZE * 1) ;\
+	SAVE_SPR(SPRN_IVOR2, BOOKE_IVOR0_OFF + STRIDE_SIZE * 2) ;\
+	SAVE_SPR(SPRN_IVOR3, BOOKE_IVOR0_OFF + STRIDE_SIZE * 3) ;\
+	SAVE_SPR(SPRN_IVOR4, BOOKE_IVOR0_OFF + STRIDE_SIZE * 4) ;\
+	SAVE_SPR(SPRN_IVOR5, BOOKE_IVOR0_OFF + STRIDE_SIZE * 5) ;\
+	SAVE_SPR(SPRN_IVOR6, BOOKE_IVOR0_OFF + STRIDE_SIZE * 6) ;\
+	SAVE_SPR(SPRN_IVOR7, BOOKE_IVOR0_OFF + STRIDE_SIZE * 7) ;\
+	SAVE_SPR(SPRN_IVOR8, BOOKE_IVOR0_OFF + STRIDE_SIZE * 8) ;\
+	SAVE_SPR(SPRN_IVOR9, BOOKE_IVOR0_OFF + STRIDE_SIZE * 9) ;\
+	SAVE_SPR(SPRN_IVOR10, BOOKE_IVOR0_OFF + STRIDE_SIZE * 10) ;\
+	SAVE_SPR(SPRN_IVOR11, BOOKE_IVOR0_OFF + STRIDE_SIZE * 11) ;\
+	SAVE_SPR(SPRN_IVOR12, BOOKE_IVOR0_OFF + STRIDE_SIZE * 12) ;\
+	SAVE_SPR(SPRN_IVOR13, BOOKE_IVOR0_OFF + STRIDE_SIZE * 13) ;\
+	SAVE_SPR(SPRN_IVOR14, BOOKE_IVOR0_OFF + STRIDE_SIZE * 14) ;\
+	SAVE_SPR(SPRN_IVOR15, BOOKE_IVOR0_OFF + STRIDE_SIZE * 15) ;\
+	SAVE_SPR(SPRN_IVOR35, BOOKE_IVOR0_OFF + STRIDE_SIZE * 35) ;\
+	SAVE_SPR(SPRN_IVOR36, BOOKE_IVOR0_OFF + STRIDE_SIZE * 36) ;\
+	SAVE_SPR(SPRN_IVOR37, BOOKE_IVOR0_OFF + STRIDE_SIZE * 37) ;\
+	SAVE_SPR(SPRN_IVOR38, BOOKE_IVOR0_OFF + STRIDE_SIZE * 38) ;\
+	SAVE_SPR(SPRN_IVOR39, BOOKE_IVOR0_OFF + STRIDE_SIZE * 39) ;\
+	SAVE_SPR(SPRN_IVOR40, BOOKE_IVOR0_OFF + STRIDE_SIZE * 40) ;\
+	SAVE_SPR(SPRN_IVOR41, BOOKE_IVOR0_OFF + STRIDE_SIZE * 41)
+
+#define RESTORE_ALL_IVOR \
+	RESTORE_SPR(SPRN_IVOR0, BOOKE_IVOR0_OFF + STRIDE_SIZE * 0) ;\
+	RESTORE_SPR(SPRN_IVOR1, BOOKE_IVOR0_OFF + STRIDE_SIZE * 1) ;\
+	RESTORE_SPR(SPRN_IVOR2, BOOKE_IVOR0_OFF + STRIDE_SIZE * 2) ;\
+	RESTORE_SPR(SPRN_IVOR3, BOOKE_IVOR0_OFF + STRIDE_SIZE * 3) ;\
+	RESTORE_SPR(SPRN_IVOR4, BOOKE_IVOR0_OFF + STRIDE_SIZE * 4) ;\
+	RESTORE_SPR(SPRN_IVOR5, BOOKE_IVOR0_OFF + STRIDE_SIZE * 5) ;\
+	RESTORE_SPR(SPRN_IVOR6, BOOKE_IVOR0_OFF + STRIDE_SIZE * 6) ;\
+	RESTORE_SPR(SPRN_IVOR7, BOOKE_IVOR0_OFF + STRIDE_SIZE * 7) ;\
+	RESTORE_SPR(SPRN_IVOR8, BOOKE_IVOR0_OFF + STRIDE_SIZE * 8) ;\
+	RESTORE_SPR(SPRN_IVOR9, BOOKE_IVOR0_OFF + STRIDE_SIZE * 9) ;\
+	RESTORE_SPR(SPRN_IVOR10, BOOKE_IVOR0_OFF + STRIDE_SIZE * 10) ;\
+	RESTORE_SPR(SPRN_IVOR11, BOOKE_IVOR0_OFF + STRIDE_SIZE * 11) ;\
+	RESTORE_SPR(SPRN_IVOR12, BOOKE_IVOR0_OFF + STRIDE_SIZE * 12) ;\
+	RESTORE_SPR(SPRN_IVOR13, BOOKE_IVOR0_OFF + STRIDE_SIZE * 13) ;\
+	RESTORE_SPR(SPRN_IVOR14, BOOKE_IVOR0_OFF + STRIDE_SIZE * 14) ;\
+	RESTORE_SPR(SPRN_IVOR15, BOOKE_IVOR0_OFF + STRIDE_SIZE * 15) ;\
+	RESTORE_SPR(SPRN_IVOR35, BOOKE_IVOR0_OFF + STRIDE_SIZE * 35) ;\
+	RESTORE_SPR(SPRN_IVOR36, BOOKE_IVOR0_OFF + STRIDE_SIZE * 36) ;\
+	RESTORE_SPR(SPRN_IVOR37, BOOKE_IVOR0_OFF + STRIDE_SIZE * 37) ;\
+	RESTORE_SPR(SPRN_IVOR38, BOOKE_IVOR0_OFF + STRIDE_SIZE * 38) ;\
+	RESTORE_SPR(SPRN_IVOR39, BOOKE_IVOR0_OFF + STRIDE_SIZE * 39) ;\
+	RESTORE_SPR(SPRN_IVOR40, BOOKE_IVOR0_OFF + STRIDE_SIZE * 40) ;\
+	RESTORE_SPR(SPRN_IVOR41, BOOKE_IVOR0_OFF + STRIDE_SIZE * 41)
+
+/* reset time base to prevent from overflow */
+#define DELAY(count)		\
+	li	r3, count;	\
+	li	r4, 0;		\
+	mtspr	SPRN_TBWL, r4;	\
+101:	mfspr	r4, SPRN_TBRL;	\
+	cmpw	r4, r3;		\
+	blt	101b
+
+#define FSL_DIS_ALL_IRQ		\
+	mfmsr	r8;			\
+	rlwinm	r8, r8, 0, ~MSR_CE;	\
+	rlwinm	r8, r8, 0, ~MSR_ME;	\
+	rlwinm	r8, r8, 0, ~MSR_EE;	\
+	rlwinm	r8, r8, 0, ~MSR_DE;	\
+	mtmsr	r8;			\
+	isync
+
+#ifndef CONFIG_PPC_E500MC
+#define SS_TB		0x00
+#define SS_HID		0x08 /* 2 HIDs */
+#define SS_IAC		0x10 /* 2 IACs */
+#define SS_DAC		0x18 /* 2 DACs */
+#define SS_DBCR		0x20 /* 3 DBCRs */
+#define SS_PID		0x2c /* 3 PIDs */
+#define SS_SPRG		0x38 /* 8 SPRGs */
+#define SS_IVOR		0x58 /* 20 interrupt vectors */
+#define SS_TCR		0xa8
+#define SS_BUCSR	0xac
+#define SS_L1CSR	0xb0 /* 2 L1CSRs */
+#define SS_MSR		0xb8
+#define SS_USPRG	0xbc
+#define SS_GPREG	0xc0 /* r12-r31 */
+#define SS_LR		0x110
+#define SS_CR		0x114
+#define SS_SP		0x118
+#define SS_CURRENT	0x11c
+#define SS_IVPR		0x120
+#define SS_BPTR		0x124
+
+
+#define STATE_SAVE_SIZE 0x128
+
+	.section .data
+	.align	5
+mpc85xx_sleep_save_area:
+	.space	STATE_SAVE_SIZE
+ccsrbase_low:
+	.long	0
+ccsrbase_high:
+	.long	0
+powmgtreq:
+	.long	0
+
+	.section .text
+	.align	12
+
+	/*
+	 * r3 = high word of physical address of CCSR
+	 * r4 = low word of physical address of CCSR
+	 * r5 = JOG or deep sleep request
+	 *      JOG-0x00200000, deep sleep-0x00100000
+	 */
+_GLOBAL(mpc85xx_enter_deep_sleep)
+	lis	r6, ccsrbase_low@ha
+	stw	r4, ccsrbase_low@l(r6)
+	lis	r6, ccsrbase_high@ha
+	stw	r3, ccsrbase_high@l(r6)
+
+	lis	r6, powmgtreq@ha
+	stw	r5, powmgtreq@l(r6)
+
+	lis	r10, mpc85xx_sleep_save_area@h
+	ori	r10, r10, mpc85xx_sleep_save_area@l
+
+	mfspr	r5, SPRN_HID0
+	mfspr	r6, SPRN_HID1
+
+	stw	r5, SS_HID+0(r10)
+	stw	r6, SS_HID+4(r10)
+
+	mfspr	r4, SPRN_IAC1
+	mfspr	r5, SPRN_IAC2
+	mfspr	r6, SPRN_DAC1
+	mfspr	r7, SPRN_DAC2
+
+	stw	r4, SS_IAC+0(r10)
+	stw	r5, SS_IAC+4(r10)
+	stw	r6, SS_DAC+0(r10)
+	stw	r7, SS_DAC+4(r10)
+
+	mfspr	r4, SPRN_DBCR0
+	mfspr	r5, SPRN_DBCR1
+	mfspr	r6, SPRN_DBCR2
+
+	stw	r4, SS_DBCR+0(r10)
+	stw	r5, SS_DBCR+4(r10)
+	stw	r6, SS_DBCR+8(r10)
+
+	mfspr	r4, SPRN_PID0
+	mfspr	r5, SPRN_PID1
+	mfspr	r6, SPRN_PID2
+
+	stw	r4, SS_PID+0(r10)
+	stw	r5, SS_PID+4(r10)
+	stw	r6, SS_PID+8(r10)
+
+	mfspr	r4, SPRN_SPRG0
+	mfspr	r5, SPRN_SPRG1
+	mfspr	r6, SPRN_SPRG2
+	mfspr	r7, SPRN_SPRG3
+
+	stw	r4, SS_SPRG+0x00(r10)
+	stw	r5, SS_SPRG+0x04(r10)
+	stw	r6, SS_SPRG+0x08(r10)
+	stw	r7, SS_SPRG+0x0c(r10)
+
+	mfspr	r4, SPRN_SPRG4
+	mfspr	r5, SPRN_SPRG5
+	mfspr	r6, SPRN_SPRG6
+	mfspr	r7, SPRN_SPRG7
+
+	stw	r4, SS_SPRG+0x10(r10)
+	stw	r5, SS_SPRG+0x14(r10)
+	stw	r6, SS_SPRG+0x18(r10)
+	stw	r7, SS_SPRG+0x1c(r10)
+
+	mfspr	r4, SPRN_IVPR
+	stw	r4, SS_IVPR(r10)
+
+	mfspr	r4, SPRN_IVOR0
+	mfspr	r5, SPRN_IVOR1
+	mfspr	r6, SPRN_IVOR2
+	mfspr	r7, SPRN_IVOR3
+
+	stw	r4, SS_IVOR+0x00(r10)
+	stw	r5, SS_IVOR+0x04(r10)
+	stw	r6, SS_IVOR+0x08(r10)
+	stw	r7, SS_IVOR+0x0c(r10)
+
+	mfspr	r4, SPRN_IVOR4
+	mfspr	r5, SPRN_IVOR5
+	mfspr	r6, SPRN_IVOR6
+	mfspr	r7, SPRN_IVOR7
+
+	stw	r4, SS_IVOR+0x10(r10)
+	stw	r5, SS_IVOR+0x14(r10)
+	stw	r6, SS_IVOR+0x18(r10)
+	stw	r7, SS_IVOR+0x1c(r10)
+
+	mfspr	r4, SPRN_IVOR8
+	mfspr	r5, SPRN_IVOR9
+	mfspr	r6, SPRN_IVOR10
+	mfspr	r7, SPRN_IVOR11
+
+	stw	r4, SS_IVOR+0x20(r10)
+	stw	r5, SS_IVOR+0x24(r10)
+	stw	r6, SS_IVOR+0x28(r10)
+	stw	r7, SS_IVOR+0x2c(r10)
+
+	mfspr	r4, SPRN_IVOR12
+	mfspr	r5, SPRN_IVOR13
+	mfspr	r6, SPRN_IVOR14
+	mfspr	r7, SPRN_IVOR15
+
+	stw	r4, SS_IVOR+0x30(r10)
+	stw	r5, SS_IVOR+0x34(r10)
+	stw	r6, SS_IVOR+0x38(r10)
+	stw	r7, SS_IVOR+0x3c(r10)
+
+	mfspr	r4, SPRN_IVOR32
+	mfspr	r5, SPRN_IVOR33
+	mfspr	r6, SPRN_IVOR34
+	mfspr	r7, SPRN_IVOR35
+
+	stw	r4, SS_IVOR+0x40(r10)
+	stw	r5, SS_IVOR+0x44(r10)
+	stw	r6, SS_IVOR+0x48(r10)
+	stw	r7, SS_IVOR+0x4c(r10)
+
+	mfspr	r4, SPRN_TCR
+	mfspr	r5, SPRN_BUCSR
+	mfspr	r6, SPRN_L1CSR0
+	mfspr	r7, SPRN_L1CSR1
+	mfspr	r8, SPRN_USPRG0
+
+	stw	r4, SS_TCR(r10)
+	stw	r5, SS_BUCSR(r10)
+	stw	r6, SS_L1CSR+0(r10)
+	stw	r7, SS_L1CSR+4(r10)
+	stw	r8, SS_USPRG+0(r10)
+
+	stmw	r12, SS_GPREG(r10)
+
+	mfmsr	r4
+	mflr	r5
+	mfcr	r6
+
+	stw	r4, SS_MSR(r10)
+	stw	r5, SS_LR(r10)
+	stw	r6, SS_CR(r10)
+	stw	r1, SS_SP(r10)
+	stw	r2, SS_CURRENT(r10)
+
+1:	mftbu	r4
+	mftb	r5
+	mftbu	r6
+	cmpw	r4, r6
+	bne	1b
+
+	stw	r4, SS_TB+0(r10)
+	stw	r5, SS_TB+4(r10)
+
+	lis	r5, ccsrbase_low@ha
+	lwz	r4, ccsrbase_low@l(r5)
+	lis	r5, ccsrbase_high@ha
+	lwz	r3, ccsrbase_high@l(r5)
+
+	/* Disable machine checks and critical exceptions */
+	mfmsr	r5
+	rlwinm	r5, r5, 0, ~MSR_CE
+	rlwinm	r5, r5, 0, ~MSR_ME
+	mtmsr	r5
+	isync
+
+	/* Use TLB1[15] to map the CCSR at 0xf0000000 */
+	lis	r5, 0x100f
+	mtspr	SPRN_MAS0, r5
+	lis	r5, 0xc000
+	ori	r5, r5, 0x0500
+	mtspr	SPRN_MAS1, r5
+	lis	r5, 0xf000
+	ori	r5, r5, 0x000a
+	mtspr	SPRN_MAS2, r5
+	rlwinm	r5, r4, 0, 0xfffff000
+	ori	r5, r5, 0x0005
+	mtspr	SPRN_MAS3, r5
+	mtspr	SPRN_MAS7, r3
+	isync
+	tlbwe
+	isync
+
+	lis	r3, 0xf000
+	lwz	r4, 0x20(r3)
+	stw	r4, SS_BPTR(r10)
+
+	lis	r3, 0xf002	/* L2 cache controller at CCSR+0x20000 */
+	bl	flush_disable_L2
+	bl	__flush_disable_L1
+
+	/* Enable I-cache, so as not to upset the bus
+	 * with our loop.
+	 */
+
+	mfspr	r4, SPRN_L1CSR1
+	ori	r4, r4, 1
+	mtspr	SPRN_L1CSR1, r4
+	isync
+
+	/* Set boot page translation */
+	lis	r3, 0xf000
+	lis	r4, (mpc85xx_deep_resume - PAGE_OFFSET)@h
+	ori	r4, r4, (mpc85xx_deep_resume - PAGE_OFFSET)@l
+	rlwinm	r4, r4, 20, 0x000fffff
+	oris	r4, r4, 0x8000
+	stw	r4, 0x20(r3)
+	lwz	r4, 0x20(r3)		/* read-back to flush write */
+	twi	0, r4, 0
+	isync
+
+	/* Disable the decrementer */
+	mfspr	r4, SPRN_TCR
+	rlwinm	r4, r4, 0, ~TCR_DIE
+	mtspr	SPRN_TCR, r4
+
+	mfspr	r4, SPRN_TSR
+	oris	r4, r4, TSR_DIS@h
+	mtspr	SPRN_TSR, r4
+
+	/* set PMRCCR[VRCNT] to wait power stable for 40ms */
+	lis	r3, 0xf00e
+	lwz	r4, 0x84(r3)
+	clrlwi	r4, r4, 16
+	oris	r4, r4, 0x12a3
+	stw	r4, 0x84(r3)
+	lwz	r4, 0x84(r3)
+
+	/* set deep sleep bit in POWMGTSCR */
+	lis	r3, powmgtreq@ha
+	lwz	r8, powmgtreq@l(r3)
+
+	lis	r3, 0xf00e
+	lwz	r4, 0x80(r3)
+	or	r4, r4, r8
+	stw	r4, 0x80(r3)
+	lwz	r4, 0x80(r3)		/* read-back to flush write */
+	twi	0, r4, 0
+	isync
+
+	mftb	r5
+1:	/* spin until either we enter deep sleep, or the sleep process is
+	 * aborted due to a pending wakeup event.  Wait some time between
+	 * accesses, so we don't flood the bus and prevent the pmc from
+	 * detecting an idle system.
+	 */
+
+	mftb	r4
+	subf	r7, r5, r4
+	cmpwi	r7, 1000
+	blt	1b
+	mr	r5, r4
+
+	lwz	r6, 0x80(r3)
+	andis.	r6, r6, 0x0010
+	bne	1b
+	b	2f
+
+2:	mfspr	r4, SPRN_PIR
+	andi.	r4, r4, 1
+99:	bne	99b
+
+	/* Establish a temporary 64MB 0->0 mapping in TLB1[1]. */
+	lis	r4, 0x1001
+	mtspr	SPRN_MAS0, r4
+	lis	r4, 0xc000
+	ori	r4, r4, 0x0800
+	mtspr	SPRN_MAS1, r4
+	li	r4, 0
+	mtspr	SPRN_MAS2, r4
+	li	r4, 0x0015
+	mtspr	SPRN_MAS3, r4
+	li	r4, 0
+	mtspr	SPRN_MAS7, r4
+	isync
+	tlbwe
+	isync
+
+	lis	r3, (3f - PAGE_OFFSET)@h
+	ori	r3, r3, (3f - PAGE_OFFSET)@l
+	mtctr	r3
+	bctr
+
+	/* Locate the resume vector in the last word of the current page. */
+	. = mpc85xx_enter_deep_sleep + 0xffc
+mpc85xx_deep_resume:
+	b	2b
+
+3:
+	/* Restore the contents of TLB1[0].  It is assumed that it covers
+	 * the currently executing code and the sleep save area, and that
+	 * it does not alias our temporary mapping (which is at virtual zero).
+	 */
+	lis	r3, (TLBCAM - PAGE_OFFSET)@h
+	ori	r3, r3, (TLBCAM - PAGE_OFFSET)@l
+
+	lwz	r4, 0(r3)
+	lwz	r5, 4(r3)
+	lwz	r6, 8(r3)
+	lwz	r7, 12(r3)
+	lwz	r8, 16(r3)
+
+	mtspr	SPRN_MAS0, r4
+	mtspr	SPRN_MAS1, r5
+	mtspr	SPRN_MAS2, r6
+	mtspr	SPRN_MAS3, r7
+	mtspr	SPRN_MAS7, r8
+
+	isync
+	tlbwe
+	isync
+
+	/* Access the ccsrbase address with TLB1[0] */
+	lis	r5, ccsrbase_low@ha
+	lwz	r4, ccsrbase_low@l(r5)
+	lis	r5, ccsrbase_high@ha
+	lwz	r3, ccsrbase_high@l(r5)
+
+	/* Use TLB1[15] to map the CCSR at 0xf0000000 */
+	lis	r5, 0x100f
+	mtspr	SPRN_MAS0, r5
+	lis	r5, 0xc000
+	ori	r5, r5, 0x0500
+	mtspr	SPRN_MAS1, r5
+	lis	r5, 0xf000
+	ori	r5, r5, 0x000a
+	mtspr	SPRN_MAS2, r5
+	rlwinm	r5, r4, 0, 0xfffff000
+	ori	r5, r5, 0x0005
+	mtspr	SPRN_MAS3, r5
+	mtspr	SPRN_MAS7, r3
+	isync
+	tlbwe
+	isync
+
+	lis	r3, 0xf002	/* L2 cache controller at CCSR+0x20000 */
+	bl	invalidate_enable_L2
+
+	/* Access the MEM(r10) with TLB1[0] */
+	lis	r10, mpc85xx_sleep_save_area@h
+	ori	r10, r10, mpc85xx_sleep_save_area@l
+
+	lis	r3, 0xf000
+	lwz	r4, SS_BPTR(r10)
+	stw	r4, 0x20(r3)		/* restore BPTR */
+
+	/* Program shift running space to PAGE_OFFSET */
+	mfmsr	r3
+	lis	r4, 1f@h
+	ori	r4, r4, 1f@l
+
+	mtsrr1	r3
+	mtsrr0	r4
+	rfi
+
+1:	/* Restore the rest of TLB1, in ascending order so that
+	 * the TLB1[1] gets invalidated first.
+	 *
+	 * XXX: It's better to invalidate the temporary mapping
+	 * TLB1[15] for CCSR before restore any TLB1 entry include 0.
+	 */
+	lis	r4, 0x100f
+	mtspr	SPRN_MAS0, r4
+	lis	r4, 0
+	mtspr	SPRN_MAS1, r4
+	isync
+	tlbwe
+	isync
+
+	lis	r3, (TLBCAM + 5*4 - 4)@h
+	ori	r3, r3, (TLBCAM + 5*4 - 4)@l
+	li	r4, 15
+	mtctr	r4
+
+2:
+	lwz	r5, 4(r3)
+	lwz	r6, 8(r3)
+	lwz	r7, 12(r3)
+	lwz	r8, 16(r3)
+	lwzu	r9, 20(r3)
+
+	mtspr	SPRN_MAS0, r5
+	mtspr	SPRN_MAS1, r6
+	mtspr	SPRN_MAS2, r7
+	mtspr	SPRN_MAS3, r8
+	mtspr	SPRN_MAS7, r9
+
+	isync
+	tlbwe
+	isync
+	bdnz	2b
+
+	lis	r10, mpc85xx_sleep_save_area@h
+	ori	r10, r10, mpc85xx_sleep_save_area@l
+
+	lwz	r5, SS_HID+0(r10)
+	lwz	r6, SS_HID+4(r10)
+
+	isync
+	mtspr	SPRN_HID0, r5
+	isync
+
+	msync
+	mtspr	SPRN_HID1, r6
+	isync
+
+	lwz	r4, SS_IAC+0(r10)
+	lwz	r5, SS_IAC+4(r10)
+	lwz	r6, SS_DAC+0(r10)
+	lwz	r7, SS_DAC+4(r10)
+
+	mtspr	SPRN_IAC1, r4
+	mtspr	SPRN_IAC2, r5
+	mtspr	SPRN_DAC1, r6
+	mtspr	SPRN_DAC2, r7
+
+	lwz	r4, SS_DBCR+0(r10)
+	lwz	r5, SS_DBCR+4(r10)
+	lwz	r6, SS_DBCR+8(r10)
+
+	mtspr	SPRN_DBCR0, r4
+	mtspr	SPRN_DBCR1, r5
+	mtspr	SPRN_DBCR2, r6
+
+	lwz	r4, SS_PID+0(r10)
+	lwz	r5, SS_PID+4(r10)
+	lwz	r6, SS_PID+8(r10)
+
+	mtspr	SPRN_PID0, r4
+	mtspr	SPRN_PID1, r5
+	mtspr	SPRN_PID2, r6
+
+	lwz	r4, SS_SPRG+0x00(r10)
+	lwz	r5, SS_SPRG+0x04(r10)
+	lwz	r6, SS_SPRG+0x08(r10)
+	lwz	r7, SS_SPRG+0x0c(r10)
+
+	mtspr	SPRN_SPRG0, r4
+	mtspr	SPRN_SPRG1, r5
+	mtspr	SPRN_SPRG2, r6
+	mtspr	SPRN_SPRG3, r7
+
+	lwz	r4, SS_SPRG+0x10(r10)
+	lwz	r5, SS_SPRG+0x14(r10)
+	lwz	r6, SS_SPRG+0x18(r10)
+	lwz	r7, SS_SPRG+0x1c(r10)
+
+	mtspr	SPRN_SPRG4, r4
+	mtspr	SPRN_SPRG5, r5
+	mtspr	SPRN_SPRG6, r6
+	mtspr	SPRN_SPRG7, r7
+
+	lwz	r4, SS_IVPR(r10)
+	mtspr	SPRN_IVPR, r4
+
+	lwz	r4, SS_IVOR+0x00(r10)
+	lwz	r5, SS_IVOR+0x04(r10)
+	lwz	r6, SS_IVOR+0x08(r10)
+	lwz	r7, SS_IVOR+0x0c(r10)
+
+	mtspr	SPRN_IVOR0, r4
+	mtspr	SPRN_IVOR1, r5
+	mtspr	SPRN_IVOR2, r6
+	mtspr	SPRN_IVOR3, r7
+
+	lwz	r4, SS_IVOR+0x10(r10)
+	lwz	r5, SS_IVOR+0x14(r10)
+	lwz	r6, SS_IVOR+0x18(r10)
+	lwz	r7, SS_IVOR+0x1c(r10)
+
+	mtspr	SPRN_IVOR4, r4
+	mtspr	SPRN_IVOR5, r5
+	mtspr	SPRN_IVOR6, r6
+	mtspr	SPRN_IVOR7, r7
+
+	lwz	r4, SS_IVOR+0x20(r10)
+	lwz	r5, SS_IVOR+0x24(r10)
+	lwz	r6, SS_IVOR+0x28(r10)
+	lwz	r7, SS_IVOR+0x2c(r10)
+
+	mtspr	SPRN_IVOR8, r4
+	mtspr	SPRN_IVOR9, r5
+	mtspr	SPRN_IVOR10, r6
+	mtspr	SPRN_IVOR11, r7
+
+	lwz	r4, SS_IVOR+0x30(r10)
+	lwz	r5, SS_IVOR+0x34(r10)
+	lwz	r6, SS_IVOR+0x38(r10)
+	lwz	r7, SS_IVOR+0x3c(r10)
+
+	mtspr	SPRN_IVOR12, r4
+	mtspr	SPRN_IVOR13, r5
+	mtspr	SPRN_IVOR14, r6
+	mtspr	SPRN_IVOR15, r7
+
+	lwz	r4, SS_IVOR+0x40(r10)
+	lwz	r5, SS_IVOR+0x44(r10)
+	lwz	r6, SS_IVOR+0x48(r10)
+	lwz	r7, SS_IVOR+0x4c(r10)
+
+	mtspr	SPRN_IVOR32, r4
+	mtspr	SPRN_IVOR33, r5
+	mtspr	SPRN_IVOR34, r6
+	mtspr	SPRN_IVOR35, r7
+
+	lwz	r4, SS_TCR(r10)
+	lwz	r5, SS_BUCSR(r10)
+	lwz	r6, SS_L1CSR+0(r10)
+	lwz	r7, SS_L1CSR+4(r10)
+	lwz	r8, SS_USPRG+0(r10)
+
+	mtspr	SPRN_TCR, r4
+	mtspr	SPRN_BUCSR, r5
+
+	msync
+	isync
+	mtspr	SPRN_L1CSR0, r6
+	isync
+
+	mtspr	SPRN_L1CSR1, r7
+	isync
+
+	mtspr	SPRN_USPRG0, r8
+
+	lmw	r12, SS_GPREG(r10)
+
+	lwz	r1, SS_SP(r10)
+	lwz	r2, SS_CURRENT(r10)
+	lwz	r4, SS_MSR(r10)
+	lwz	r5, SS_LR(r10)
+	lwz	r6, SS_CR(r10)
+
+	msync
+	mtmsr	r4
+	isync
+
+	mtlr	r5
+	mtcr	r6
+
+	li	r4, 0
+	mtspr	SPRN_TBWL, r4
+
+	lwz	r4, SS_TB+0(r10)
+	lwz	r5, SS_TB+4(r10)
+
+	mtspr	SPRN_TBWU, r4
+	mtspr	SPRN_TBWL, r5
+
+	lis	r3, 1
+	mtdec	r3
+
+	blr
+
+#else /* CONFIG_PPC_E500MC */
+
+	.section .data
+	.align	6
+regs_buffer:
+	.space BUFFER_SIZE
+
+	.section .text
+/*
+ * Save CPU registers
+ * r3 : the base address of the buffer which stores the values of registers
+ */
+e5500_cpu_state_save:
+	/* store the base address to r10 */
+	mr	r10, r3
+
+	SAVE_ALL_GPR
+	SAVE_ALL_SPRG
+	SAVE_ALL_IVOR
+
+	SAVE_SPR(SPRN_IVPR, BOOKE_IVPR_OFF)
+	SAVE_SPR(SPRN_PID0, BOOKE_PID0_OFF)
+	SAVE_SPR(SPRN_EPCR, BOOKE_EPCR_OFF)
+	SAVE_SPR(SPRN_HID0, BOOKE_HID0_OFF)
+	SAVE_SPR(SPRN_PIR, BOOKE_PIR_OFF)
+	SAVE_SPR(SPRN_BUCSR, BOOKE_BUCSR_OFF)
+1:
+	mfspr	r5, SPRN_TBRU
+	mfspr	r4, SPRN_TBRL
+	SAVE_GPR(r5, BOOKE_TBU_OFF)
+	SAVE_GPR(r4, BOOKE_TBL_OFF)
+	mfspr	r3, SPRN_TBRU
+	cmpw	r3, r5
+	bne	1b
+
+	blr
+
+/*
+ * Restore CPU registers
+ * r3 : the base address of the buffer which stores the values of registers
+ */
+e5500_cpu_state_restore:
+	/* store the base address to r10 */
+	mr	r10, r3
+
+	RESTORE_ALL_GPR
+	RESTORE_ALL_SPRG
+	RESTORE_ALL_IVOR
+
+	RESTORE_SPR(SPRN_IVPR, BOOKE_IVPR_OFF)
+	RESTORE_SPR(SPRN_PID0, BOOKE_PID0_OFF)
+	RESTORE_SPR(SPRN_EPCR, BOOKE_EPCR_OFF)
+	RESTORE_SPR(SPRN_HID0, BOOKE_HID0_OFF)
+	RESTORE_SPR(SPRN_PIR, BOOKE_PIR_OFF)
+	RESTORE_SPR(SPRN_BUCSR, BOOKE_BUCSR_OFF)
+
+	li	r0, 0
+	mtspr	SPRN_TBWL, r0
+	RESTORE_SPR(SPRN_TBWU, BOOKE_TBU_OFF)
+	RESTORE_SPR(SPRN_TBWL, BOOKE_TBL_OFF)
+
+	blr
+
+#define CPC_CPCCSR0		0x0
+#define CPC_CPCCSR0_CPCFL	0x800
+
+/*
+ * Flush the CPC cache.
+ * r3 : the base address of CPC
+ */
+flush_cpc_cache:
+	lwz	r6, CPC_CPCCSR0(r3)
+	ori	r6, r6, CPC_CPCCSR0_CPCFL
+	stw	r6, CPC_CPCCSR0(r3)
+	sync
+
+	/* Wait until completing the flush */
+1:	lwz	r6, CPC_CPCCSR0(r3)
+	andi.	r6, r6, CPC_CPCCSR0_CPCFL
+	bne	1b
+
+	blr
+
+/*
+ * the last stage to enter deep sleep
+ *
+ */
+	.align 6
+_GLOBAL(fsl_dp_enter_low)
+deepsleep_start:
+	LOAD_REG_ADDR(r9, buf_tmp)
+	/* save the return address and MSR */
+	mflr	r8
+	PPC_STL r8, 0(r9)
+	mfmsr	r8
+	PPC_STL r8, 8(r9)
+	mfspr	r8, SPRN_TCR
+	PPC_STL r8, 16(r9)
+	mfcr	r8
+	PPC_STL	r8, 24(r9)
+	li	r8, 0
+	mtspr	SPRN_TCR, r8
+
+	/* save the parameters */
+	PPC_STL	r3, 32(r9)
+	PPC_STL	r4, 40(r9)
+	PPC_STL	r5, 48(r9)
+	PPC_STL	r6, 56(r9)
+
+	LOAD_REG_ADDR(r3, regs_buffer)
+	bl	e5500_cpu_state_save
+
+	/* restore the parameters */
+	LOAD_REG_ADDR(r9, buf_tmp)
+	PPC_LL	r31, 32(r9)
+	PPC_LL	r30, 40(r9)
+	PPC_LL	r29, 48(r9)
+	PPC_LL	r28, 56(r9)
+
+	/* flush caches inside CPU */
+	LOAD_REG_ADDR(r3, cur_cpu_spec)
+	PPC_LL	r3, 0(r3)
+	PPC_LL	r3, CPU_FLUSH_CACHES(r3)
+	PPC_LCMPI  0, r3, 0
+	beq	6f
+#ifdef CONFIG_PPC64
+	PPC_LL	r3, 0(r3)
+#endif
+	mtctr	r3
+	bctrl
+6:
+	/* Flush the CPC cache */
+#define CPC_OFFSET	0x10000
+	mr	r3, r31
+	addis	r3, r3, CPC_OFFSET@h
+	bl	flush_cpc_cache
+
+	/* prefecth TLB */
+#define CCSR_GPIO1_GPDAT	0x130008
+#define CCSR_GPIO1_GPDAT_29	0x4
+	LOAD_REG_IMMEDIATE(r11, CCSR_GPIO1_GPDAT)
+	add	r11, r31, r11
+	lwz	r10, 0(r11)
+
+#define CCSR_RCPM_PCPH15SETR	0xe20b4
+#define CCSR_RCPM_PCPH15SETR_CORE0	0x1
+	LOAD_REG_IMMEDIATE(r12, CCSR_RCPM_PCPH15SETR)
+	add	r12, r31, r12
+	lwz	r10, 0(r12)
+
+#define CCSR_DDR_SDRAM_CFG_2	0x8114
+#define CCSR_DDR_SDRAM_CFG_2_FRC_SR	0x80000000
+	LOAD_REG_IMMEDIATE(r13, CCSR_DDR_SDRAM_CFG_2)
+	add	r13, r31, r13
+	lwz	r10, 0(r13)
+
+#define	DCSR_EPU_EPGCR		0x000
+#define DCSR_EPU_EPGCR_GCE	0x80000000
+	li	r14, DCSR_EPU_EPGCR
+	add	r14, r30, r14
+	lwz	r10, 0(r14)
+
+#define	DCSR_EPU_EPECR15	0x33C
+#define DCSR_EPU_EPECR15_IC0	0x80000000
+	li	r15, DCSR_EPU_EPECR15
+	add	r15, r30, r15
+	lwz	r10, 0(r15)
+
+#define CCSR_SCFG_QMIFRSTCR		0xfc40c
+#define CCSR_SCFG_QMIFRSTCR_QMIFRST	0x80000000
+	LOAD_REG_IMMEDIATE(r16, CCSR_SCFG_QMIFRSTCR)
+	add	r16, r31, r16
+	lwz	r10, 0(r16)
+
+/*
+ * There are two kind of register maps, one for T1040QDS and
+ * the other for T104xRDB.
+ */
+#define T104XRDB_CPLD_MISCCSR		0x17
+#define T104XRDB_CPLD_MISCCSR_SLEEPEN	0x40
+#define T1040QDS_QIXIS_PWR_CTL2		0x21
+#define T1040QDS_QIXIS_PWR_CTL2_PCTL	0x2
+	li	r3, T1040QDS_QIXIS_PWR_CTL2
+	PPC_LCMPI  0, r28, T1040QDS_TETRA_FLAG
+	beq	20f
+	li	r3, T104XRDB_CPLD_MISCCSR
+20:	add	r29, r29, r3
+	lbz	r10, 0(r29)
+	sync
+
+	LOAD_REG_ADDR(r8, deepsleep_start)
+	LOAD_REG_ADDR(r9, deepsleep_end)
+
+	/* prefecth code to cache so that executing code after disable DDR */
+1:	icbtls	2, 0, r8
+	addi	r8, r8, 64
+	cmpw	r8, r9
+	blt	1b
+	sync
+
+	FSL_DIS_ALL_IRQ
+
+	/*
+	 * Place DDR controller in self refresh mode.
+	 * From here on, can't access DDR any more.
+	 */
+	lwz	r10, 0(r13)
+	oris	r10, r10, CCSR_DDR_SDRAM_CFG_2_FRC_SR@h
+	stw	r10, 0(r13)
+	lwz	r10, 0(r13)
+	sync
+
+	DELAY(500)
+
+	/*
+	 * Enable deep sleep signals by write external CPLD/FPGA register.
+	 * The bootloader will disable them when wakeup from deep sleep.
+	 */
+	lbz	r10, 0(r29)
+	li	r3, T1040QDS_QIXIS_PWR_CTL2_PCTL
+	PPC_LCMPI  0, r28, T1040QDS_TETRA_FLAG
+	beq	22f
+	li	r3, T104XRDB_CPLD_MISCCSR_SLEEPEN
+22:	or	r10, r10, r3
+	stb	r10, 0(r29)
+	lbz	r10, 0(r29)
+	sync
+
+	/*
+	 * Set GPIO1_29 to lock the signal MCKE down during deep sleep.
+	 * The bootloader will clear it when wakeup.
+	 */
+	lwz	r10, 0(r11)
+	ori	r10, r10, CCSR_GPIO1_GPDAT_29
+	stw	r10, 0(r11)
+	lwz	r10, 0(r11)
+
+	DELAY(100)
+
+	/* Reset QMan system bus interface */
+	lwz	r10, 0(r16)
+	oris	r10, r10, CCSR_SCFG_QMIFRSTCR_QMIFRST@h
+	stw	r10, 0(r16)
+	lwz	r10, 0(r16)
+
+	/* Enable all EPU Counters */
+	li	r10, 0
+	oris	r10, r10, DCSR_EPU_EPGCR_GCE@h
+	stw	r10, 0(r14)
+	lwz	r10, 0(r14)
+
+	/* Enable SCU15 to trigger on RCPM Concentrator 0 */
+	lwz	r10, 0(r15)
+	oris	r10, r10, DCSR_EPU_EPECR15_IC0@h
+	stw	r10, 0(r15)
+	lwz	r10, 0(r15)
+
+	/* put Core0 in PH15 mode, trigger EPU FSM */
+	lwz	r10, 0(r12)
+	ori	r10, r10, CCSR_RCPM_PCPH15SETR_CORE0
+	stw	r10, 0(r12)
+2:
+	b 2b
+
+	/*
+	 * Leave some space to prevent prefeching instruction
+	 * beyond deepsleep_end. The space also can be used as heap.
+	 */
+buf_tmp:
+	.space 128
+	.align 6
+deepsleep_end:
+
+	.align 12
+#ifdef CONFIG_PPC32
+_GLOBAL(fsl_booke_deep_sleep_resume)
+	/* disable interrupts */
+	FSL_DIS_ALL_IRQ
+
+#define ENTRY_DEEPSLEEP_SETUP
+#define ENTRY_MAPPING_BOOT_SETUP
+#include <../../kernel/fsl_booke_entry_mapping.S>
+#undef ENTRY_DEEPSLEEP_SETUP
+#undef ENTRY_MAPPING_BOOT_SETUP
+
+	li	r3, 0
+	mfspr   r4, SPRN_PIR
+	bl	call_setup_cpu
+
+	/* Load each CAM entry */
+	LOAD_REG_ADDR(r3, tlbcam_index)
+	lwz	r3, 0(r3)
+	mtctr	r3
+	li	r9, 0
+3:	mr	r3, r9
+	bl	loadcam_entry
+	addi	r9, r9, 1
+	bdnz	3b
+
+	/* restore cpu registers */
+	LOAD_REG_ADDR(r3, regs_buffer)
+	bl	e5500_cpu_state_restore
+
+	/* restore return address */
+	LOAD_REG_ADDR(r3, buf_tmp)
+	lwz	r4, 16(r3)
+	mtspr	SPRN_TCR, r4
+	lwz	r4, 0(r3)
+	mtlr	r4
+	lwz	r4, 8(r3)
+	mtmsr	r4
+	lwz	r4, 24(r3)
+	mtcr	r4
+
+	blr
+
+#else /* CONFIG_PPC32 */
+
+_GLOBAL(fsl_booke_deep_sleep_resume)
+	/* disable interrupts */
+	FSL_DIS_ALL_IRQ
+
+	/* switch to 64-bit mode */
+	bl	.enable_64b_mode
+
+	/* set TOC pointer */
+	bl	.relative_toc
+
+	/* setup initial TLBs, switch to kernel space ... */
+	bl	.start_initialization_book3e
+
+	/* address space changed, set TOC pointer again */
+	bl	.relative_toc
+
+	/* call a cpu state restore handler */
+	LOAD_REG_ADDR(r23, cur_cpu_spec)
+	ld	r23,0(r23)
+	ld	r23,CPU_SPEC_RESTORE(r23)
+	cmpdi	0,r23,0
+	beq	1f
+	ld	r23,0(r23)
+	mtctr	r23
+	bctrl
+1:
+	LOAD_REG_ADDR(r3, regs_buffer)
+	bl	e5500_cpu_state_restore
+
+	/* Load each CAM entry */
+	LOAD_REG_ADDR(r3, tlbcam_index)
+	lwz	r3, 0(r3)
+	mtctr	r3
+	li	r0, 0
+3:	mr	r3, r0
+	bl	loadcam_entry
+	addi	r0, r0, 1
+	bdnz	3b
+
+	/* restore return address */
+	LOAD_REG_ADDR(r3, buf_tmp)
+	ld	r4, 16(r3)
+	mtspr	SPRN_TCR, r4
+	ld	r4, 0(r3)
+	mtlr	r4
+	ld	r4, 8(r3)
+	mtmsr	r4
+	ld	r4, 24(r3)
+	mtcr	r4
+
+	blr
+
+#endif /* CONFIG_PPC32 */
+
+#endif
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index bcd179d..0ce5370 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -5,6 +5,7 @@ menuconfig PPC_86xx
 	depends on 6xx
 	select FSL_SOC
 	select ALTIVEC
+	select FSL_PMC if SUSPEND
 	help
 	  The Freescale E600 SoCs have 74xx cores.
 
diff --git a/arch/powerpc/sysdev/fsl_pmc.c b/arch/powerpc/sysdev/fsl_pmc.c
index 232225e..4549462 100644
--- a/arch/powerpc/sysdev/fsl_pmc.c
+++ b/arch/powerpc/sysdev/fsl_pmc.c
@@ -20,54 +20,192 @@
 #include <linux/device.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/pm.h>
+#include <asm/cacheflush.h>
+
+#include <sysdev/fsl_soc.h>
+#include <asm/switch_to.h>
+#include <asm/fsl_pm.h>
 
 struct pmc_regs {
 	__be32 devdisr;
 	__be32 devdisr2;
-	__be32 :32;
-	__be32 :32;
-	__be32 pmcsr;
-#define PMCSR_SLP	(1 << 17)
+	__be32 res1;
+	__be32 res2;
+	__be32 powmgtcsr;
+#define POWMGTCSR_SLP		0x00020000
+#define POWMGTCSR_DPSLP		0x00100000
+#define POWMGTCSR_LOSSLESS	0x00400000
+	__be32 res3[2];
+	__be32 pmcdr;
 };
 
-static struct device *pmc_dev;
 static struct pmc_regs __iomem *pmc_regs;
+static unsigned int pmc_flag;
+
+#define PMC_SLEEP	0x1
+#define PMC_DEEP_SLEEP	0x2
+#define PMC_LOSSLESS	0x4
+
+/**
+ * mpc85xx_pmc_set_wake - enable devices as wakeup event source
+ * @dev: a device affected
+ * @enable: True to enable event generation; false to disable
+ *
+ * This enables the device as a wakeup event source, or disables it.
+ *
+ * RETURN VALUE:
+ * 0 is returned on success.
+ * -EINVAL is returned if device is not supposed to wake up the system.
+ * -ENODEV is returned if PMC is unavailable.
+ * Error code depending on the platform is returned if both the platform and
+ * the native mechanism fail to enable the generation of wake-up events
+ */
+int mpc85xx_pmc_set_wake(struct device *dev, bool enable)
+{
+	int ret = 0;
+	struct device_node *clk_np;
+	const u32 *prop;
+	u32 pmcdr_mask;
+
+	if (!pmc_regs) {
+		dev_err(dev, "%s: PMC is unavailable\n", __func__);
+		return -ENODEV;
+	}
+
+	if (enable && !device_may_wakeup(dev))
+		return -EINVAL;
+
+	clk_np = of_parse_phandle(dev->of_node, "fsl,pmc-handle", 0);
+	if (!clk_np)
+		return -EINVAL;
+
+	prop = of_get_property(clk_np, "fsl,pmcdr-mask", NULL);
+	if (!prop) {
+		ret = -EINVAL;
+		goto out;
+	}
+	pmcdr_mask = be32_to_cpup(prop);
+
+	if (enable)
+		/* clear to enable clock in low power mode */
+		clrbits32(&pmc_regs->pmcdr, pmcdr_mask);
+	else
+		setbits32(&pmc_regs->pmcdr, pmcdr_mask);
+
+out:
+	of_node_put(clk_np);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mpc85xx_pmc_set_wake);
+
+/**
+ * mpc85xx_pmc_set_lossless_ethernet - enable lossless ethernet
+ * in (deep) sleep mode
+ * @enable: True to enable event generation; false to disable
+ */
+void mpc85xx_pmc_set_lossless_ethernet(int enable)
+{
+	if (pmc_flag & PMC_LOSSLESS) {
+	if (enable)
+		setbits32(&pmc_regs->powmgtcsr,	POWMGTCSR_LOSSLESS);
+	else
+		clrbits32(&pmc_regs->powmgtcsr, POWMGTCSR_LOSSLESS);
+	}
+}
+EXPORT_SYMBOL_GPL(mpc85xx_pmc_set_lossless_ethernet);
 
 static int pmc_suspend_enter(suspend_state_t state)
 {
-	int ret;
+	int ret = 0;
+	int result;
+
+	switch (state) {
+#ifdef CONFIG_PPC_85xx
+	case PM_SUSPEND_MEM:
+#ifdef CONFIG_SPE
+		enable_kernel_spe();
+#endif
+#ifdef CONFIG_PPC_FPU
+		enable_kernel_fp();
+#endif
+
+		pr_debug("%s: Entering deep sleep\n", __func__);
+
+		local_irq_disable();
+		mpc85xx_enter_deep_sleep(get_immrbase(), POWMGTCSR_DPSLP);
+
+		pr_debug("%s: Resumed from deep sleep\n", __func__);
+		break;
+#endif
 
-	setbits32(&pmc_regs->pmcsr, PMCSR_SLP);
-	/* At this point, the CPU is asleep. */
+	case PM_SUSPEND_STANDBY:
+		local_irq_disable();
+		flush_dcache_L1();
 
-	/* Upon resume, wait for SLP bit to be clear. */
-	ret = spin_event_timeout((in_be32(&pmc_regs->pmcsr) & PMCSR_SLP) == 0,
-				 10000, 10) ? 0 : -ETIMEDOUT;
-	if (ret)
-		dev_err(pmc_dev, "tired waiting for SLP bit to clear\n");
+		setbits32(&pmc_regs->powmgtcsr, POWMGTCSR_SLP);
+		/* At this point, the CPU is asleep. */
+
+		/* Upon resume, wait for SLP bit to be clear. */
+		result = spin_event_timeout(
+			(in_be32(&pmc_regs->powmgtcsr) & POWMGTCSR_SLP) == 0,
+			10000, 10);
+		if (!result) {
+			pr_err("%s: timeout waiting for SLP bit "
+				"to be cleared\n", __func__);
+			ret = -ETIMEDOUT;
+		}
+		break;
+
+	default:
+		ret = -EINVAL;
+
+	}
 	return ret;
 }
 
 static int pmc_suspend_valid(suspend_state_t state)
 {
-	if (state != PM_SUSPEND_STANDBY)
-		return 0;
-	return 1;
+	set_pm_suspend_state(state);
+
+	if (((pmc_flag & PMC_SLEEP) && (state == PM_SUSPEND_STANDBY)) ||
+	    ((pmc_flag & PMC_DEEP_SLEEP) && (state == PM_SUSPEND_MEM)))
+		return 1;
+
+	set_pm_suspend_state(PM_SUSPEND_ON);
+	return 0;
+}
+
+static void pmc_suspend_end(void)
+{
+	set_pm_suspend_state(PM_SUSPEND_ON);
 }
 
 static const struct platform_suspend_ops pmc_suspend_ops = {
 	.valid = pmc_suspend_valid,
 	.enter = pmc_suspend_enter,
+	.end = pmc_suspend_end,
 };
 
-static int pmc_probe(struct platform_device *ofdev)
+static int pmc_probe(struct platform_device *pdev)
 {
-	pmc_regs = of_iomap(ofdev->dev.of_node, 0);
+	struct device_node *np = pdev->dev.of_node;
+
+	pmc_regs = of_iomap(np, 0);
 	if (!pmc_regs)
 		return -ENOMEM;
 
-	pmc_dev = &ofdev->dev;
+	pmc_flag = PMC_SLEEP;
+	if (of_device_is_compatible(np, "fsl,mpc8536-pmc"))
+		pmc_flag |= PMC_DEEP_SLEEP;
+
+	if (of_device_is_compatible(np, "fsl,p1022-pmc"))
+		pmc_flag |= PMC_DEEP_SLEEP | PMC_LOSSLESS;
+
 	suspend_set_ops(&pmc_suspend_ops);
+	set_pm_suspend_state(PM_SUSPEND_ON);
+
+	pr_info("Freescale PMC driver\n");
 	return 0;
 }
 
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 1f614fb..b082584 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -46,6 +46,37 @@
 extern void init_fec_ioports(struct fs_platform_info*);
 extern void init_smc_ioports(struct fs_uart_platform_info*);
 static phys_addr_t immrbase = -1;
+static phys_addr_t dcsrbase = -1;
+
+phys_addr_t get_dcsrbase(void)
+{
+	struct device_node *np;
+	const __be32 *prop;
+	int size;
+	u32 naddr;
+
+	if (dcsrbase != -1)
+		return dcsrbase;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,dcsr");
+	if (!np)
+		return -1;
+
+	prop = of_get_property(np, "#address-cells", &size);
+	if (prop && size == 4)
+		naddr = be32_to_cpup(prop);
+	else
+		naddr = 2;
+
+	prop = of_get_property(np, "ranges", NULL);
+	if (prop)
+		dcsrbase = of_translate_address(np, prop + naddr);
+
+	of_node_put(np);
+
+	return dcsrbase;
+}
+EXPORT_SYMBOL(get_dcsrbase);
 
 phys_addr_t get_immrbase(void)
 {
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index db11b06..674ed67 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -7,6 +7,7 @@
 
 struct spi_device;
 
+extern phys_addr_t get_dcsrbase(void);
 extern phys_addr_t get_immrbase(void);
 #if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
 extern u32 get_brgfreq(void);
@@ -44,5 +45,22 @@ struct platform_diu_data_ops {
 void __noreturn fsl_hv_restart(char *cmd);
 void __noreturn fsl_hv_halt(void);
 
+/*
+ * Cast the ccsrbar to 64-bit parameter so that the assembly
+ * code can be compatible with both 32-bit & 36-bit.
+ */
+extern void mpc85xx_enter_deep_sleep(u64 ccsrbar, u32 powmgtreq);
+
+#ifdef CONFIG_FSL_PMC
+int mpc85xx_pmc_set_wake(struct device *dev, bool enable);
+void mpc85xx_pmc_set_lossless_ethernet(int enable);
+#else
+static inline int mpc85xx_pmc_set_wake(struct device *dev, bool enable)
+{
+	return -ENODEV;
+}
+#define mpc85xx_pmc_set_lossless_ethernet(enable)	do { } while (0)
+#endif
+
 #endif
 #endif
-- 
1.7.1
