Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeCZGft (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:35:49 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:48357
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750859AbeCZGfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:35:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 4/4] x86/CPU/AMD: Calculate LLC ID from number of sharing threads
Date: Mon, 26 Mar 2018 01:35:16 -0500
Message-Id: <1522046116-22578-5-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:405:4c::34) To DM2PR12MB0139.namprd12.prod.outlook.com
 (2a01:111:e400:50cf::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9f7e0ec-d228-4049-35a5-08d592e3cb9a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0139;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;3:8BukFJEsVIiR5RzXFL2TZwo+QkwS+Z9i6Fj92bISzlRztrKJXrCKtD5D7HfC1znTiWL4iSNx6wdruA/u6obtjy1iguaXgfn+0YxfzweBUKStl0+q3t8mRnjUlnkfE6lbYqS3QbHRB1Le5cBy75YBNOjsTnsBk0YS6KYeKOzeNncpyr/Gg9qpz6zBL1GMVPQOwqOKo3H0kDya75oxK4ZH0DAsZtXlmSKrIB0Vhc4tqfr36hC9uTmGNczw4gUNEf5y;25:WwnjVctZgaDzeloCj040sa/m3Vj138/0h21cZS/ANUWCZX4P2D3gwc8yJY6Tco0Z3REGwHOSu5MQWIDsuE7Tr4stywiQhW8IoFJByZfNWCjtJdBBQ+XPfccUCjsr06hPaUwW4plMcNKX89rdfd1OjacW6yn34VysPdtO8aN0PRW6h4yV1Y2q2x+jbU7ihax7vsbB6Lx6diNkenvBNUoPy7xRCBIx3CwfDsvaxrNIzdJEnJyKBb/S6GQUumtlDueY2WuV4Z7k1NETNb5YXQjsKgVayaCNjs/V05qbQgK/70RE6EU5N7bwzU32LyJb8Ix05yG3m+MoQSA4NihOMj23fw==;31:RwG83jcHUpklvHLA512ySFWXtpjxR3zUZPOL2FGE05I+FrqQu8QGt2eUfT+rlQVHz/kGmW2QDIuyFgsMjVsMkYPW0rqI5uZiP+XeaZf7ztst8+oZFea8P85uUWYf8CfTSsrqxVVVh5tkE4cnAgT4LLUK8Nc1EgXhSfWzBJ6Xz9yPvXFDGzRGnLGdVcgsy44eNGl0+m1VAbPgyvvVeBxNOAIHlvCu9Bb1ZSYIQGIJHrw=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0139:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:h+YhYxoNbBzPsltxpfVMziMAEHAq65zUlWm3B7MPd9caONt9ZRyKbrJ6/hUlZn67ZDLBleSrdCMHu1iO6nKSEe9cjwSWUq6Xv+DBQ4e77/y55L3DbG1sbSgC5DBo3v0oeEx12ZPnrzunsLc/cfvYxIKa6U0a87hrAs1yCZEcZart5i4c79QzdidHqieD6H7BGKhFKD06IJr6p1Cj1/P5Po07eWRv5aCNlqTYEqR6XRBQ5sFpAJTTCcsp2j1pCkULCELqJq+lrfZLePvucYnA0/OmxtkVLcFy2wadTN0R3zQr8e8ANQu40TebsLl/958+D1rZyFnCzhe55YiVP+32QuTiHdpm+SDyqPvJ9SO4SSKIzTArnrlFtGwHzR5rK4OqWMZIULmaldfImcsfSk9ZK3e4C6EzpAn2zCDIdu3JT5pSYKZLsdvgTJeVWIZZ1Vlw0M2uIL7gUA6nx2nfKb8DJiD/axJTo17b4ctJ6rkrQddcdyf7extYhX32J0I+QFJm;4:Ooszib0RnbCku+W749q8w1KHN8LAXCVP37MVSa6g6LjLQswqhc6xms4Ge4jP0q8AU3mmVecnitGhuCUs2xLofpOwPk4THPkW9FzqUBMo/yFaeLUranUW1WPEmYjMJo+ig/wL4UjRQijyRZSJ0ouTABiocHpNGkRrRRH+vuRuPwf04Z1oA+mCX/9uf4YGGymMZdGoAwwSaHHS6doDbBPQFOFvhkp90lByZ5UEMIAQ6xSg3FziwMNZAmH16BAzwx3x5IWaKu3lWQedopaqGb06nlmTTEcNyIls7OOgbyB3sxebpLIhoVourida7ZObmMXQ
X-Microsoft-Antispam-PRVS: <DM2PR12MB0139183F18D6C03855172B35F3AD0@DM2PR12MB0139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR12MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0139;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(48376002)(76176011)(16526019)(6486002)(52116002)(316002)(186003)(47776003)(575784001)(86362001)(3846002)(6116002)(106356001)(105586002)(53936002)(53416004)(68736007)(81156014)(81166006)(11346002)(478600001)(97736004)(8936002)(446003)(72206003)(8676002)(16586007)(956004)(6666003)(25786009)(7736002)(305945005)(50226002)(50466002)(386003)(4326008)(26005)(7696005)(51416003)(36756003)(59450400001)(66066001)(2906002)(5660300001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0139;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0139;23:3aeUufejzhmLWfVNl/7/ougJbpj7+I67LoDtqT5GS?=
 =?us-ascii?Q?ZDxWv4XX+7mCYqCszl3fr0ntCThMqOCOLbWm21Ipojb5JJTxpb906YUOcTgz?=
 =?us-ascii?Q?ulgrvZrpNcu0ErgNa5MJrtJuBeFU+7siK/8tQetD+egm0eMnznA1F3zEv98V?=
 =?us-ascii?Q?235l+nhxoBYee4/Q5Wp6NVH8SZGsT0PlOfP/qw8z6XO9BsYlwTGIj7n/vJiL?=
 =?us-ascii?Q?KIHXZq9nGHwLrKFtA2vfmI3unui+6fJ8DZZXvsyHHRYZrSyW9QXgOmr28xCi?=
 =?us-ascii?Q?QinsV1SzYxtM2Z/F4KsiNTHZf5VJFHuT6mKuA/5hri7jH4WKvgSA7HOd50hr?=
 =?us-ascii?Q?z4/4cLQGOXJ1iqbo2nbRsfO11czqN1q2T/FExRDEzY/AT+hwt4at0YVBg1qF?=
 =?us-ascii?Q?eyVNwCwY1eC4LBYIRtaOgW71jIs/tM9LBHq3+Tc7V6DDGj7G0ndIXqTfCpzs?=
 =?us-ascii?Q?aSPuHTisVQSBzZ3sAUv6HVfGgjTynGreU10RnUbS2IIe2m5otag2XT2lXP6W?=
 =?us-ascii?Q?qNDt/JcCuL7nasgKdL3roMsnyTV4wEPV5ko0dtusEGCuuHNwMdEbdKDNDcTk?=
 =?us-ascii?Q?vx6pAv/3HWRLhrlgDFem3kCeTb2+guluAsfOZAgZ5B6EqhdNWNMGWPd8QbM1?=
 =?us-ascii?Q?hPjavMxG9KRieN83tcC019E4mdDUjmVNo6za0z3VvoD9ajBS8MNisXI8Mhw0?=
 =?us-ascii?Q?AyccVyk4zc/3AsLxv08KASeFjCUs1hvortSjGVVOFj0GNlPAMZW9Sshibspf?=
 =?us-ascii?Q?7sgezp9q6d1iQFfSzMtmgR9F2IY8LILgfemxH/X0gJzc8jjH2PVVtfME51/a?=
 =?us-ascii?Q?KUKcXeCfgdPGhn7PMooaGi1w9HYXLT1gKIMZ8EdKvRr3YCCAOKzgtucBpMjJ?=
 =?us-ascii?Q?hI2rpxOMnW6+pSN/JMF3P/uhvYEnIU2VRByAwwbrOvbTwNHBi2g7ehgELOoi?=
 =?us-ascii?Q?wHtE4puOxEEb9rTVSaS4NLibBaKMLUz8vIUBVMeW3AEWITV+GxR6Rut3Ae6r?=
 =?us-ascii?Q?0jf1J++dzbN6hZbhBBkAIhj5tzgosoMD9KA6Nf1p+iLUZp0Cv/UG9JuDlfde?=
 =?us-ascii?Q?Kq2P/oUetykxIeADEq/DIvX+5EXOhaew1KHwPMdotHGjSFhAZbP3N1nKfbZa?=
 =?us-ascii?Q?Fa3ubT4g0dFXaN84eYpQKF0SN73cCVq+cdWavoIHbMK1KKvavlMJvVhSKtBr?=
 =?us-ascii?Q?NJw5YzYV1CFlGAOj7TWH0pvG3udLvq3VRx0?=
X-Microsoft-Antispam-Message-Info: tMn7l3KeY8Yg6OE5V6rERau1KtWCErQEcUvhARoj+j85xPqx6YvRQJBGNWCgjq1TqVPcy+94yRpWBOkc7TBSAztcQQPQI7vmJjb6XsszNXCgFMQPE3K+b2s234lqn2MZcoJq5lPsVnssx+03qU0mhOMrtnGQXfw5B2/6vSJnyz1VdN5hpNdYdIqhBdBd7IwV
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;6:bklJAoBpdBfZ7R8LSF0CxBsePA42JSSCd0eOXWvx7BeKfHGaPJX2a9or03cMY+xY7za7ejBcc03ZNkN/8uS9zMj9Q4oDfvWNBHbAgOyDjMIZcq/cq+ZxZnNVcAvOI4WbjDt6x3AnQmfgkvULttGK2+3n/DXszMwBDxfo7cyest/RO8YnVG7cUGkhbBl4Yi1Efx5CoOsVMxvjH6NdT8zC3+qDG58lAnCfNMQ40bUlfgpA5U1oM0l8iG/aKG0LgRYOuCfB2zeLwxukPCPf917g6QuGa/TjiVzupfsKaDaSPYzrEgXuZhXUM1W5VWPfvij48BO2I3/surWz+wZv5UKz0nka1r8Jcbc4RjuonVz1+3w=;5:EM5F4HUtEWVJ/VdAknpsEhxxolQuo03Cy8XG96VlSdbgvr83ojoBlERRKO7tlU/nEMQ+yMFB+G6YXzyXSfTUfKvH+eaAX3kqKUg/6jfKnsaepZMP7mwdvrNkKwed5KVpmpvxojuPxhu941K3ASeqAqKYjR/yDpbXSmwlC6AL71g=;24:2cZOsKPgGO1SzHGRUA6UOcTFW9CP1cJgvsbyqzyv9hr59XZZg33AykGrzDlU2DSrLlEjBWk1E5319C7IHSp/8bYB53/GautoVJ9EBBjMDc4=;7:D4m1JlZgYcm5OBfDXdOGVLQm3svpUloHpvrev64Lh5gTDoGinGOAOvcVfboHO3n1nowUQtxeFUKYd/FP0qOVvEu2t4xKcxZbXKC9MC0SKx+ArWLZneK0vMSouvVldIpacg5zorQrrOVGfutA9xWE+B0Lht4kY3xe9grrDPR8KhtyUjlpzLr0PwVzummVBbvxBySl2qg5luQp37h+wFdMHhwQDc0odHXN54vgBYyYvYdCMyfKSMs47jmUwCKxTXXn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:5mZKr9UszLF5gxOmPSKavTHycvYvqYM5KRsS9PjoH/sR2Rx1PVpsGYt/x3N3U877iuzpC9/OydPgpvoAW24ZuJOZHc71cpLoVz95h/8l6gALMEvQDu8V7qEbMM0wt8AUfkIYQogQWPVl4IzAr1Ap8v522HllrKxLrnqzroEhlc3RwmCWiX0SPckAyBX8l9CbruOpoLibYaJ1RiOQLfNfhhNyQvKQQ6X7sqgj8sBsbkiCOY0ADQs6lVSXkBizBA0p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 06:35:40.5936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f7e0ec-d228-4049-35a5-08d592e3cb9a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last-Level-Cache ID can be calculated from the number of threads sharing
the cache, which is available from CPUID Fn0x8000001D (Cache Properties).
This is used to left-shift the APIC ID to derive LLC ID.

Therefore, default to this method unless the APIC ID enumeration does not
follow the scheme.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/cacheinfo.h |  7 +++++++
 arch/x86/kernel/cpu/amd.c        | 19 +++----------------
 arch/x86/kernel/cpu/cacheinfo.c  | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/include/asm/cacheinfo.h

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
new file mode 100644
index 0000000..e958e28
--- /dev/null
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CACHEINFO_H
+#define _ASM_X86_CACHEINFO_H
+
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
+
+#endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 922f43c..2c1a9f2 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -9,6 +9,7 @@
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/apic.h>
+#include <asm/cacheinfo.h>
 #include <asm/cpu.h>
 #include <asm/smp.h>
 #include <asm/pci-direct.h>
@@ -343,22 +344,8 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 				c->x86_max_cores /= smp_num_siblings;
 		}
 
-		/*
-		 * We may have multiple LLCs if L3 caches exist, so check if we
-		 * have an L3 cache by looking at the L3 cache CPUID leaf.
-		 */
-		if (cpuid_edx(0x80000006)) {
-			if (c->x86 == 0x17) {
-				/*
-				 * LLC is at the core complex level.
-				 * Core complex id is ApicId[3].
-				 */
-				per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
-			} else {
-				/* LLC is at the node level. */
-				per_cpu(cpu_llc_id, cpu) = node_id;
-			}
-		}
+		cacheinfo_amd_init_llc_id(c, cpu, node_id);
+
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 54d04d5..67f4790 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -637,6 +637,43 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
+{
+	/*
+	 * We may have multiple LLCs if L3 caches exist, so check if we
+	 * have an L3 cache by looking at the L3 cache CPUID leaf.
+	 */
+	if (!cpuid_edx(0x80000006))
+		return;
+
+	if (c->x86 < 0x17) {
+		/* LLC is at the node level. */
+		per_cpu(cpu_llc_id, cpu) = node_id;
+	} else if (c->x86 == 0x17 &&
+		   c->x86_model >= 0 && c->x86_model <= 0x1F) {
+		/*
+		 * LLC is at the core complex level.
+		 * Core complex id is ApicId[3] for these processors.
+		 */
+		per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
+	} else {
+		/* LLC ID is calculated from the number of thread sharing. */
+		u32 eax, ebx, ecx, edx, num_sharing_cache = 0;
+		u32 llc_index = find_num_cache_leaves(c) - 1;
+
+		cpuid_count(0x8000001d, llc_index, &eax, &ebx, &ecx, &edx);
+		if (eax)
+			num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
+
+		if (num_sharing_cache) {
+			int bits = get_count_order(num_sharing_cache) - 1;
+
+			per_cpu(cpu_llc_id, cpu) = c->apicid >> bits;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(cacheinfo_amd_init_llc_id);
+
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
 
-- 
2.7.4
