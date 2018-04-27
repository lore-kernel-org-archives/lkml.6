Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759410AbeD0VfT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:35:19 -0400
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:62624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759379AbeD0VfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:35:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 4/4] x86/CPU/AMD: Calculate LLC ID from number of sharing threads
Date: Fri, 27 Apr 2018 16:34:37 -0500
Message-Id: <1524864877-111962-5-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524864877-111962-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524864877-111962-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:300:ad::16) To SN1PR12MB0141.namprd12.prod.outlook.com
 (2a01:111:e400:5144::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0141;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;3:5iUthrQP0fppIDZuEIHwxrHqeaX/oSErLPrvdnzecimirUc8AbBz/ta3MjtaXyQBPBFPoqLtfk1RAzH8muLuxZ9wvtJ+owCiILEOlRK4jydhQtOE8AkyVzZtreg8s4wSiV+L+RYAVAa1lGTV3BYwxs7oddGFILWwyp21Ul0jNN20ge+B4afdB5iu2uK9GALL5pbnQcZLOxPbasUSBpiU1ZVY+AUk9DOEzoqQyptDqBwtltpS70z3DVV+xoqIM7mv;25:8kVrkhRRhUY0FJJrzoVKD8Z7GmZMyzfIwVIQFTSOipohbhcKTxwy8vzRyfC4dQkUrJ0dQtQd3ExYpZ7CnkIXp+44+su9/G7t1QJnobCDFGmEAE0krIaeZME8TQ5FuZGB9JFLbuc8p2sy1y/3mDgs6ii7VQwYqjttvQ6gjct5pTEcO3AhfyIB2MkVTZJRS5n+pb7Zko+M+OGXZ3vufDizRBtcw3M2Y46gVh/sE64mq/l01Cj+ul+pk0NrmZbZVY2y8Xrqc0jP4c+fQHmExOEz+tn1c04y4Fka2XkzD+e4HULreDriEUfXMtwMbCUckpw/VGJwYQSUJHuUnwP+dSBFqQ==;31:WIFKcEzUSLYoSzN+b2MhFrH+2uF6NxOIzfs8sJPv9ggTHkn31oTgOMbNDg+UzjVaX59eEkur5JA6c9+qMmlBRfjE/wTNIPK7VUUcX544apZCkYBVlfUdpXr3+IQnOvmGVxynD9F/ZjB3ZYSinhwoRHnKM4I7ZcWQyzNB7NtJW+Z0hCce+ZF4YrT6lo2MxG8ObgGr6sY4/ddQjORwLyP0rFKqBrU/mW5xMQbA+syE2Ms=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0141:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;20:vq0NmJ1jRwSlCAT+oflRJgMIUI1b2qvStQ7g1XPbXFAqsGcZ/PtxJf+Da0Li7Y5jFnZXTAEESyABdQ0sNfqysGwJBHcSsFypnLqpgLx4hqxV1qdWQZd9s5eIywerMyvhytCh3eCPBkdONWlMMwt3F/YXXwJS2CNUPv7gOylUw0nHiYsqw2mCOzYuOko7GGqAPK4zwmXhpnEdUj5wSovemglfDM59wUNo647szPvlKOwC8iTcEtEegbrZACGTHIUa2u/lNNv06Lj9/7VwyRVlttfKYmOSFEq9gV4gYZhxxa0RHFTERxqQnYY3eZSc25yp2F1kcXc1/mYuljKHciojtHsmaayIRhX6BzZONmN1FN7/lIsr5WJCwVwkoS4JhHTYUJzXpHe4cmCLUAgLUDhAlmpYtWa/mUA49+vYYbCMKwU8wJ+GHB/q2eWx8dJXzbxeUDbdz8fGdWzJQh78NOFrK7tayWn79YAF7U3iIw7iKAjFZaog04CaU7gjbaVGx/7V;4:1zlajoB3IR7lB5+/drT8yJQa51EG9yO10fhPKSJQAM/Yb+gT/od5yP0vNteqQTK3Pw7x7o/H0Z75RbPiQWZc5tT1SipM8SHIYR/Mhsb+BmUui5MijpX4WOiaowGswUh4F+PbyJImYuNujom0a64VM5ZNcFcoITZCVQ/rFrSePUZ9I8N+Ll7IXMCrGDSuSh7vuBsBmncj0O6ccn8xm8X6QYVkIMturEoDV7i0JThK+mMhhSvbxTVK9peqkx+Pc7IhnoExIQibmZjFfbLlAYD0ZM0fzjFganUw8jZVs6dVqtcwLwlys5nzg/0Ch1lIcvwu
X-Microsoft-Antispam-PRVS: <SN1PR12MB0141B96740152F9CBC47A984F38D0@SN1PR12MB0141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0141;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0141;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(478600001)(956004)(72206003)(446003)(44832011)(2616005)(486006)(11346002)(59450400001)(6666003)(76176011)(97736004)(2906002)(52116002)(50466002)(26005)(3846002)(6116002)(51416003)(7696005)(53936002)(476003)(48376002)(6486002)(186003)(50226002)(68736007)(81156014)(105586002)(86362001)(66066001)(305945005)(16526019)(316002)(81166006)(7736002)(53416004)(386003)(5660300001)(575784001)(8676002)(16586007)(4326008)(25786009)(106356001)(8936002)(36756003)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0141;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0141;23:rUh5/4T3epleIP05e1OAqKkvTcZ6VNkl1e0rbVD7R?=
 =?us-ascii?Q?KvsG6FK+P8jH9urC3hFlLuBIsgaF6oQMolwNDx0ulT2XMgFHaNkD8qSr95Qt?=
 =?us-ascii?Q?j1GIkTqypRa2vhbwF3Uz3uClgnEArshO3kVVHL6+T0zg7ByE1GnggK5Ripkj?=
 =?us-ascii?Q?Fl76nSkdKIHbihDnR2R/ymQdf2AuV9lnwBKs6EkHapRjg+hiQ6CVNS3ZNR9r?=
 =?us-ascii?Q?Fw7GZWxOg8AX12KaTD+rox5arR+hD0LX2yeDHKSN2t0faTinuozGZ/gM0xE0?=
 =?us-ascii?Q?HBO0oYDZYKwSmTv9XqVFea8S5fDeCUJ73GyaFBXXvHNzdWGZbViEFhPQLC2Z?=
 =?us-ascii?Q?stomDfxsukfieUkIeZ1leLznZQLBfVkOPsM08IY4s0p8qA380fgZb0DAxBKk?=
 =?us-ascii?Q?yStUPak3meM0f5+slOWSMyLNzjw/GOKbHx4GNd+njgOWWmwvKPFo3x92RGMx?=
 =?us-ascii?Q?oTG+ctLNC7wnU4HCvtGNybdigungmGJQmhckaXrb4NdyRCMoCql6lOk4vdDm?=
 =?us-ascii?Q?KT67GFWuK+VLyKeUocM7mlNPIlbsjZZK3+uZAMAKhJDdoMm0JCNBLDjU/iVM?=
 =?us-ascii?Q?ZoDv1IDyW+5oNxVgK7e2nv6BEzxmmYZSby7pZo7U4Ires+aYqtNSR8EmP5Fz?=
 =?us-ascii?Q?0lJ+ZXACqRCWxjkvauWwkx78h9MdYBglzECpamsJ8/de6aA2OOKlY4RPG/vE?=
 =?us-ascii?Q?CHHZv+VzcVnkdiuZLz6jhF0tK1WUrybA6hC9YPdz5xCfS8hlr3yhwR/YbdHU?=
 =?us-ascii?Q?hPJ/Rxa5eRLJrIvwlerT94ihpZqJr0F0VOa1qFp1Va0/7zkdug78z0VN0veS?=
 =?us-ascii?Q?J3j5QdpxTjGKaUV9ULRMAew5hjV6noHKxgUFHEhT3LVHj8c5xjE8cQYEv5JV?=
 =?us-ascii?Q?xvOQwi6fjIhRCUNa84fvLaVXQYwsmmnzNFKYPJzuG/nM0mwHIt9BXT06Eaje?=
 =?us-ascii?Q?nkdnSZAklu95Ng0AeFDHwImw52bb7kFVEEz3hcbOADCt0sV7ugR+tRyILI5n?=
 =?us-ascii?Q?AZ2etlPg0rjPnWrHsBEV6kuvsp8M8R9aAnIZxxEtVGbL1WSRpsQdus3vBAd5?=
 =?us-ascii?Q?R7HdfGcHTI/P3hAULVz18jhRBOJuTszv3GBO1VPp3VJhWq7xHRjdV75gl3cN?=
 =?us-ascii?Q?xqF4sBfxof9RtDyiNUEfSB9gUCcOemqhVctB2qDjAgvDt39e7QMQlo6eQo0N?=
 =?us-ascii?Q?LZShPMrNqtRWueO3lJIoe0mswED89WWGovoPi9oErjwkvIK9Syg6f9MXsafH?=
 =?us-ascii?Q?dUnG327oMn4awSWwSo=3D?=
X-Microsoft-Antispam-Message-Info: RUwd3Sks8WMInDA9uN63Fo40vdvIRePJKVbqDOSS6VKaWbPaPEd/Glf4MuJGzlW/yXtrONc4B2E7OYSh2cKc7vlNI9tvTOufoziKauHGqaPi9ZywtweRHvKACZ/pqADmy/vJqF7FI9jOrM5Rl5nQLsQ32BklythKC+pOxpHU+bbTL/TfZtbyDdHMmzNmISWc
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;6:qz5EXcUl88VIdB2/t+qYW05bVM5B4rsy8lTgU2E71CAYLCMpWn5RRl7AB6YTuae8bLm/OxUEdmadGj5VNruHB78wmKAZ1n+OIZVV9PRVSRxs/kyW322OZLFGv+ARbtZtgPBQYu+WsC8/ITm9ghszoxdN7AYeJ/LvUuB7Drgmk+szxVu3LqI721iyLVrIflgrMmsts6fK2TTufzZllKB8F+RzMLj5QDTcFX5xCz4irHRTT3l0/UhPgUs00iLEGZh9xLU2JOO6dphQ5PIE0hFPVqsI2u7kk9CTQuvCA34r+DY5DfhC0nxSJ0im8vq9/cwjhnbqaCDC/NGNyb9Ifq+CcbZm5tOQgqvIFTdrMVw7e684+o+pRk9fCUfytcBGagcVi9jXkJd6cavMCg+EnPruIxCoxYq4rek39bfYttaEQOwmm3BQtmhyCmqJAShjKI+UEVpaUWhrDlVw0TvZuzs6xg==;5:kGXWMFUqgcsnjq/NFnZEioaM41CVZQJsKXBAg7RyBM9Y/2K6fjhcQOsVDxdlOKiyV8PaEVWVoOCSXiicSX4w6M07XDS5UqXE0Fkokq6p4rMb8B4u1Il+SPRWG/DlXWF3ythGOMeXOfZFSMo/5Wbqkkj+MYvvfktTc+K+jQTijlQ=;24:L/tsxKp7f2m6GB7SUxTk3C30ZlGWsE4xSEzmsc+Jr7CdgH2KjL5XoKezj/hOEdxu9kvfW9QJsLdHE+gnGbjUXXgdAsTR5Gqairf7UH8RqGI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;7:T/klXaPJKToK2SW6SkQmTAXFul7dhKvqwiiShgxikKAl1+bbiRixO01fQ+NM9e3makIWgXF0XNqbrKromx2C2NMynw4JtGcLD4RFZuBRYCrsze687gWouCKpSZRpOPT9PlkDjTGE5qacieXKPWJN/VIxh+cwV2XrRSaSycKa3xyYOM+Z3aaTB8l8Lsdke0rqIS46oS41hH5e0tLaXozD7UZN1h/BCvNSvHPkAuM4DunbYmB+Ga/uP7NrVyqjbCMp;20:bQQoczUEPLk6/1xWL685RB2uqYZCl8HjDIEkkCuaqIc9Lnqw8WlM7+r3d4VOwqf3afg4S2pXS/kT3fTnQOU+QpqaJEi4xRWfskwRzG73ZQqGqfS361D6h3M0zg8olOrr393uJYIyCFwLJ/tO8fgJWjAH8sMBjwCiOXUlZBjL7R5BxoYhd/W/6eWkah2Ijbcz7hHQCPl9W1u1rSm6xt7eoZOUSgept/6DtVpGl09KGVcX/gHSC+jWLoLiCAEV/5wj
X-MS-Office365-Filtering-Correlation-Id: 5c103f8b-6b82-4bbc-ac81-08d5ac86be0f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 21:35:04.5836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c103f8b-6b82-4bbc-ac81-08d5ac86be0f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0141
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
 arch/x86/kernel/cpu/cacheinfo.c  | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 16 deletions(-)
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
index 54d04d5..17f232a 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -637,6 +637,42 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
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
+
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
 
-- 
2.7.4
