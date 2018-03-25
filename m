Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbeCYRwS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 13:52:18 -0400
Received: from mail-co1nam03on0053.outbound.protection.outlook.com ([104.47.40.53]:44540
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753482AbeCYRwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 13:52:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] smp: introduce kick_active_cpus_sync()
Date: Sun, 25 Mar 2018 20:50:04 +0300
Message-Id: <20180325175004.28162-3-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180325175004.28162-1-ynorov@caviumnetworks.com>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [36.84.65.149]
X-ClientProxiedBy: HE1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::38) To CY4PR07MB2904.namprd07.prod.outlook.com
 (2603:10b6:903:26::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 917ad9ed-263b-45e5-c070-08d592791ce0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2904;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;3:U+PtQPiVEUElMH39g+Hsps1MVnlJip3c7AHOJgbeOc5J6YSPR3hcpdvfyh/B1++ptANaBJWWe4gaZ7eTuiMr/OPSDxaaw8xwkIZjPDW+2tgVMK8kHn8KGSHyEaAOVb2LY6NiFPpXeCrr5yVZtUghIfYf8LaHF+QF74U5kCZC2mDk8tQqstOiKStzBb413igFDuptVR3SEWA5Nagyf4gBRlV3i1m4VRH5RvzfjTbTFn9T/H53IZt0vuDc6MSSskdD;25:D6meFnrOdIjPimN842nrk+xKrjcMWsHhDpKGlYMEgc8KHtOr3t8wS2xHHeTlnw57hZ2jnNujGQoNfiQouENnqWvsOvsq6PgEzlrwxCsuN4ShNl5mO3r/p47WY5vYGUI0wYYnuAYObRP3C1BW3ZnHVmyC1pGSaMhsPEJuL2i9yLDxn/KGy5VcFLd+Hri/lAtUtusDeZmB/78fcECLBcN6USMaV+6vMzeEut0n9v8wMtW2fP4FJGfbi5Z09LU0YCDAf3CFYlVdKLjD9qHnTMEt4nWgxR3K6A+qV/gVkQ/laPw6Q9Kh4VVSdVPsKpYVDwc2cF7bvFvcZ+q+AEXxDxHeZA==;31:ulWELznhW9xGa8iV4lDlfP2FzO/GTvWy86f28wvV52wpVUBHcvzIkbmQk/eLVGEanOJofZvRWwQ/g1TYR0MqoFE/pvHnawF+NVsSnYJDOLDF65wtltuPxX2bT1djF2B0D0RTbPlyJI+YGITJjtYHeX+cu8P85jF7Gw8Af3cIHhOCIxQ1+a0mDoVI7XI/ioxjlAv0+dTdoON/a2RQbsox4d2iyXwjdHiO/OsfM5wzHwg=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2904:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;20:xaaUM4A0/NMLmCisuqEiXg0vaFHHkH2oUEwPZDuGDptIkBO16BDCpADR6nmM00axdfkrXvvwbn8Mcjen0FEuCE00cstQ0Qh0x/j6sCMUZ0VzB8augjBOKP5/inCLGqfnNoxzg+zdPASRft0iFcwtT7tc3WMfdxJpqiG47Q2ODG0HlHKrX3nMYItu7Y4sfVQeYR25ORea1TJbjmPjHuFET5eJvPPGNyKx6ePrmp/5p6xEOmE9wSNuV0T+M8iF5WCyfy5ssSfAscy2Db5eO6qOV5NnXrkpLLINS4JfUEQ6jhfgIzEnAFIbsQE1GKPoGBKC2wap228h9eAO2YertSrp8r5xXsqM9/AfOEBHGM+FVSH8ybPGyx9x49uATWMR4r8bfWm3XXQv+u1mvF8Gvg5Z+vP0JsAaJi0qvbliw0Bz8RGaSImEzM9JrQEXwO8DDn1VJyJB2mrqqC4PGTcnVXA/u5z1rpmMVG8/xR2j5ojYCaxkmeoGKPzSSXipGecTPMX103CN3rgE53EJb8It6jZzhFSHjCuFQwesHjRymp8N51ZDXrlmbGUYhAnmVVxAtujDFGb3rW4ZiqV6nz5/n8B40KnWHZI2R3sbYlKCyJMDW5M=;4:OKZe+EHHnnRQt5uvKX4qgM+6IlrY08UTK6Caz0EOArq75N6BLmyMPtDfpqjvARen6iCpHLUpTpbkJmMqSJ37wB87ox+1qB0Yx65k/suKYF6RDLRAxYBH0IKulxahcACePprVA8VZCrG0W6mCjdomkBpDV3IKEAnU7dADTP3pBhbwB+6LcmwxeGFUzTK1xiTh2dUOQqktVxBZesUE1DVBh84vs69mZKhcqFChv+4MUjgfhpP4djgp9STUdhT8mREEx8Wmm9SRLP20TDHKQNwGhQ==
X-Microsoft-Antispam-PRVS: <CY4PR07MB29047A93C3026805C38E02F3E3AE0@CY4PR07MB2904.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(3002001)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB2904;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2904;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(376002)(346002)(396003)(39850400004)(366004)(189003)(199004)(97736004)(305945005)(7736002)(8676002)(105586002)(316002)(36756003)(6306002)(6486002)(68736007)(8936002)(5660300001)(110136005)(16586007)(50226002)(72206003)(2906002)(25786009)(4326008)(47776003)(66066001)(446003)(956004)(3846002)(6666003)(11346002)(7416002)(53936002)(2616005)(6116002)(106356001)(81166006)(26005)(186003)(6496006)(51416003)(16526019)(52116002)(76506005)(1076002)(76176011)(59450400001)(48376002)(81156014)(386003)(50466002)(42882007)(55236004)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2904;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2904;23:48DEwgyurYND7l0oS+cOigIwi3DD8l1gDhlIn+jmX?=
 =?us-ascii?Q?7818555G532PQA2KLffAVXh/nIUj6H7ANYGk6R5DE91a4uaIBs4noDmuAKei?=
 =?us-ascii?Q?QbLs6/CjfdDnfVSfYHK95DfiD5U2DdwqxtDYAl3mbqzhTKWZ1kA0ZtTpcBJT?=
 =?us-ascii?Q?pSUBn9xsRFmumprO1j+C5TcRiBUEhVrTkXDyRgszV5S7v0bncY4pL2F1JLoJ?=
 =?us-ascii?Q?gZtQoP3shKh7cBt7rQfxojMFjETUJ1XQyhBM0Nbe5ItWsvspayT3q+ssbuMX?=
 =?us-ascii?Q?EabhuWafgGE3upxP+R0l9zDwoMIGnXryYnF8K1GfFHlEnXcSXTTHsAWlSxHC?=
 =?us-ascii?Q?L96f9fugTjHSIq73zYDy+xDkh2rWzy7Fq4NoGgHVkMbTgr5cCR4JrcltPl1F?=
 =?us-ascii?Q?SfVMcNMKZBQfRU4R7KCqR+f+rYCunMKtcLDtXsrukNXOki1OqC83aR8Rctu/?=
 =?us-ascii?Q?nJ0Auxv8KkRzM2cs7Jm7GG1pLqfUlmHqc5w/IuElWj+92Qa91VaejMLX7pZX?=
 =?us-ascii?Q?f/bJ//O0XS8mFGUXihiYV6r6tGsiBRGVEinq8j91ByFowbamH7rYhFP+GI84?=
 =?us-ascii?Q?DHghl4oFg9KOE6tefXsAPw9boIbF26J2L3rcleHKMRgo/Gh7hRYRbArRzDBd?=
 =?us-ascii?Q?+fDCvxib821ehHzaSKBlAlnPYzFV1SiiOsj4RFLk2kc73dtTZ4/Jjx5Iguo2?=
 =?us-ascii?Q?psZk2cPC2l8dG391+voLFm7oz9ndfcQm5KDk2DaigHzbPlG+A6BvOGegqu2y?=
 =?us-ascii?Q?W9Rn3rNSik0OBhwhdRevdrO90OWMnWPNSp6wjanDX+lBERBCkGDor0aCMYYB?=
 =?us-ascii?Q?XHARgzlIde5obh38MuEFw48dqTuAzWzpVlPvMD6y+cguKcTISF5lLFBD5WWL?=
 =?us-ascii?Q?QrixmZHVIB0ZkxuUdgGxwWjcLuqWRWYUS6YspYEeWDt/sRvSQ4IPnAfB/5LJ?=
 =?us-ascii?Q?DzKQCePG5hrvNugV0E2UbeVDfohRoWmKCdVSQze2xMIs5MQDZKHJNz7Vp7My?=
 =?us-ascii?Q?kYdhRgGF5boQlTEMzCVbS4uVkoxDLRJuFWUE+n64Tbx8xo1+VBYIVOhvS02g?=
 =?us-ascii?Q?hAROgqOabK+pIOtYDzNC5OZr6Warg5dPG1PxGeQwFemSny9S8KtF6ue+1dp+?=
 =?us-ascii?Q?RdOACigTz5qmOnHQ8L7nex3o1hi+ogiqMe0NdY3KiHwC8TPDgQhrt6M9ZOQU?=
 =?us-ascii?Q?PhypnbjqH5mzbXk/mAvSq7JH8bU/3M2u9XUViPp5+ytwHnNk7BtGv8XiPqkG?=
 =?us-ascii?Q?Aw4Q/QyiSWqRxTh8zKxgFgdokHsgw2Ik+h9FzwrH8aF+hD3MdGxwMbLs2CdS?=
 =?us-ascii?Q?q0NcUTIp1TpPb+zQ+zTrTrTD5NwpRRfqp7bocnkDepU?=
X-Microsoft-Antispam-Message-Info: abiFw+vyHstjYDd8PD1/Ec7c4u+Ou1DoCTmPor2zKlLH+6YK/LToS4oAQOiICPlX9b/S6BJznMCon4nxeEk9WUAqZQGDCwteA/A05WRKBZZfwkKTDJ6ydd6CY2ZEk8U2YvtwgC+KIPnU8VoT/bdJxqp5KH8NtcO6LFZA+3k8Mg4Ns+Z4saS2ZXjkTF0ZBiyy
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;6:v2+OSZjcxr68pIIdRkz/B79PLy8wpSX8P1eEb7Mj2OdAXDN3o/bxuIJMygYPv94fR7XfUjlxcG/DzjhpTis0XLDCVXu8Ww9Sat2e0ajpsii7NoTJcbDdES9KmoT/YkVrroO55ef0+gxffD2MrpTSwqTcOku2JxIXYaQUa1JAVhRz+jf0suLFYZP1kuoVnjyk3Jhd7f8bRKjzwwV5Fo1oO0b5DQAj4ce0JbEi0ViU5xD0rhAlNil/QEZDeAjbRpZsOPBnLQ0XcSRFMnOFsAFqJxixFKS3wPaZveEnuMqfm3KBmU73iOyhE4Zh1i35BwYag3iVwb+HwR9gGi8/3sKFyuh8nEdqddv0MwEWcSVWjxdQYBl7UQCPHTABnhqZa7w4CImAMvxdZWYv+Ncw68BR5gt6QCUmO1dTUHxYQH9/Etfu2YPYE2BOEzJ3qUVinz2Q3Buag67xNe1UvNX8rOdpUA==;5:KJ/6DjvpKKr3VjLfbR0lpXKkZtqM9ZG/MecPGf/g+kCCi+j3DrMymixQKuuqlFXj5AYzcAqdIKQVt9vXdpAXjSqStvaigdLKuaJnpR7BnkI/vwjwVV2928GIBRvKfxF1gXbwjvhWI83eZUYlrVUeliiKn1fO8N7ZzNaHiJK2iOw=;24:jGcc27sZHLkVFEtGII8FVzDO+Zd7RkfhtjK/7d81jLTctp1BqQpNQ1zHd0030GCBxkvEgkkM7EK4l0jBi+BcTKzudsp87KuuffkXKjbnKlk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;7:ScOSw5UuG8EEKVBFQWuIOWYLwzaogfcyN3EzDXRqM547OZNOLMVeevwk0FUxCy9vsQV5F+xqO3JtUowtC6wxFCLquptadgXK4eEu1dt341+LKA06nwdpUQRP2jaz/QzXKnKrId/xi16CmdfU7pxhq+KEyPIPEgvrcY8kirj8TiO3K1zg+WIoGg08khQw3DpXMew0btY5bYIMYLJPrbxPQZVXuI0CgENufanttxv616u0t0flYwXbPQ+r4/m19b7J
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 17:51:58.6607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 917ad9ed-263b-45e5-c070-08d592791ce0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2904
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kick_all_cpus_sync() forces all CPUs to sync caches by sending broadcast IPI.
If CPU is in extended quiescent state (idle task or nohz_full userspace), this
work may be done at the exit of this state. Delaying synchronization helps to
save power if CPU is in idle state and decrease latency for real-time tasks.

This patch introduces kick_active_cpus_sync() and uses it in mm/slab and arm64
code to delay syncronization.

For task isolation (https://lkml.org/lkml/2017/11/3/589), IPI to the CPU running
isolated task would be fatal, as it breaks isolation. The approach with delaying
of synchronization work helps to maintain isolated state.

I've tested it with test from task isolation series on ThunderX2 for more than
10 hours (10k giga-ticks) without breaking isolation.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/insn.c |  2 +-
 include/linux/smp.h      |  2 ++
 kernel/smp.c             | 24 ++++++++++++++++++++++++
 mm/slab.c                |  2 +-
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 2718a77da165..9d7c492e920e 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -291,7 +291,7 @@ int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
 			 * synchronization.
 			 */
 			ret = aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
-			kick_all_cpus_sync();
+			kick_active_cpus_sync();
 			return ret;
 		}
 	}
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9fb239e12b82..27215e22240d 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -105,6 +105,7 @@ int smp_call_function_any(const struct cpumask *mask,
 			  smp_call_func_t func, void *info, int wait);
 
 void kick_all_cpus_sync(void);
+void kick_active_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
 
 /*
@@ -161,6 +162,7 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 }
 
 static inline void kick_all_cpus_sync(void) {  }
+static inline void kick_active_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
 
 #ifdef CONFIG_UP_LATE_INIT
diff --git a/kernel/smp.c b/kernel/smp.c
index 084c8b3a2681..0358d6673850 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -724,6 +724,30 @@ void kick_all_cpus_sync(void)
 }
 EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
 
+/**
+ * kick_active_cpus_sync - Force CPUs that are not in extended
+ * quiescent state (idle or nohz_full userspace) sync by sending
+ * IPI. Extended quiescent state CPUs will sync at the exit of
+ * that state.
+ */
+void kick_active_cpus_sync(void)
+{
+	int cpu;
+	struct cpumask kernel_cpus;
+
+	smp_mb();
+
+	cpumask_clear(&kernel_cpus);
+	preempt_disable();
+	for_each_online_cpu(cpu) {
+		if (!rcu_eqs_special_set(cpu))
+			cpumask_set_cpu(cpu, &kernel_cpus);
+	}
+	smp_call_function_many(&kernel_cpus, do_nothing, NULL, 1);
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(kick_active_cpus_sync);
+
 /**
  * wake_up_all_idle_cpus - break all cpus out of idle
  * wake_up_all_idle_cpus try to break all cpus which is in idle state even
diff --git a/mm/slab.c b/mm/slab.c
index 324446621b3e..678d5dbd6f46 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3856,7 +3856,7 @@ static int __do_tune_cpucache(struct kmem_cache *cachep, int limit,
 	 * cpus, so skip the IPIs.
 	 */
 	if (prev)
-		kick_all_cpus_sync();
+		kick_active_cpus_sync();
 
 	check_irq_on();
 	cachep->batchcount = batchcount;
-- 
2.14.1
