Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeD0VsZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:48:25 -0400
Received: from mail-co1nam03on0049.outbound.protection.outlook.com ([104.47.40.49]:57424
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932851AbeD0VsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:48:19 -0400
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        rientjes@google.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 2/2] x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB when available
Date: Fri, 27 Apr 2018 16:48:01 -0500
Message-Id: <1524865681-112110-3-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524865681-112110-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524865681-112110-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:405:39::46) To BY2PR12MB0132.namprd12.prod.outlook.com
 (2a01:111:e400:585a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0132;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;3:ZuuSPxRX2iCs8wL/kI3iDGTAx0afq+Afe+7g57Cip8m/+9inGUFQ3nHhWyVODPLeW1SiELvRStMdKadWE4VMlEuliKNUPHZyLbRiN26W51B+I7P4j8A+xwibviFNyW7/oZIL5wFYmTQTyYKRE5Z59fp84gnvC2LjYApAgCG++RFLmvLuU5zqU4aNlq1FE/62ANVjKx+MpUtc3XEcK4nvuLVqqbbi2zvH2a9WjaJXXwKry1E6moIfpUYbHws9u8hC;25:RBTwOHCLXqwGLiC7jyvVqnsJctLvKgubXUIrtR/FxXEXrEi3u1V3SJg4dZ5vE8UAgGpehpBGTRbPC4w4zWh4O9oDHcHfdpzvSM5T+cxrNjOxGxcLkeFtPtG6hkRdp9BfcQgwAofFNglaCrbLAxqK0eUhpUqe5gO0t638YhCXEoVH6D6Mvp2Rzp/6bVPemynAFe7dkFhi2O7gF2GVy4cyhuPmdrkPXLzYOQmYubi5v2dlGUhiZvrZ6rLHP/W0L27nxTUUk3L9/Ay6KRDIx3tM81ODlG1j2J8pJj/SNDNskVN1OkeBEyJOcRLgdF1ab46a8KarDSjar8NNxFBtw3JDHw==;31:CeXQ95mmfsFaWVRIwU9P+owHnYy3gCZNuAmR1cq3Y1XVFKQWWepJ0ZUuQisALB7jJwu9hTZSGPFUHfS4IVgvOs/lrtCNVpol3o8oAaQTtsz1xqHfZ+WryI7f/HTO+xxfrHWrlm5ZuxmqNZjtk8NPpTjXnE7Lm/GDKBQdaEl9UTUGPitULrfYiQ7kkt4uWreb90gfoGda1SKgRABsq1ixWjMBiYX4ZagxnUakiL0wZqE=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0132:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;20:I+b5LwdaKHjwO8Kj3CT8Z6RKJr4Evl2kbAdbm7IaAQIbICTr3i7H3GoZVL61dDLFk9GK32zVZENNYHX6VBhLEh89R7RbyRWV1yyuP0y/Dvi2UdjqeRZ3Vs+2pu7TpalxGCqad1TjwadvdNqF6WJnqqODIkztHScFGlCKUp/Lz7/xaIAIxyuSy63ecd3oBkf2iDrBo/g+6huEjVYj5f2O9FUfveTngwP/BHIkXyRahLMMA31ufHfCywR09ECv5Yvih2P+97s0iEWUYa77tzuSTqU5zWaLb8A3GkJmMGFY+WguLrrgbeRf/nPIrZHl+yXoH2fzJDIuhONrfYsZcJFIWBPr3/LYB2HaPwjNnZFVki+5nCJcpWtYkf8M4XU5UanQkZTn2fck+V2WKuPMzKXD7LCrjxgN2tUj6uE2f+LFL0sTV/3QxlNFZ1ovLKX/OGQI8TzbQ9jGG4NBx1FEvDz5HiCNdMknojrRqUPs1LPwZcWlybnoazH1Nv331O6rox8g;4:D7qNgJccrMnKDwy/SejD//REfSQxlUzsyUFD9pD/ik2CI6Dioj71RhE4sFCHoazZ7DRSRaeVsemBfjymaTDrwUomw/7oAUQlFlDIH8Cp7qjUVYZVAtGoQLnps8Fv8S7C7KeyFisrnQA6nfQ/Zvjxlpzh/foqIlJC+Ni1Pd5pfVz1R38c7BhEnGt08WDf7DAi//znjLWHtq0KIFRnd3PxAFcGlOeQRLYMTQWEQUnxANN209y19W1cDE0Q/BxxYi3IPwGDXxF6nDS1tePtlKIDd+BDcCPlT2Utiu0uk6SXtM0yd1Ghy+YMETKr2iZrDSrw
X-Microsoft-Antispam-PRVS: <BY2PR12MB0132221FAEFAB4ABA9FC1487F38D0@BY2PR12MB0132.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231239)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0132;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0132;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(39860400002)(376002)(39380400002)(346002)(199004)(189003)(66066001)(186003)(105586002)(6666003)(16526019)(81166006)(51416003)(81156014)(6486002)(106356001)(48376002)(486006)(476003)(68736007)(53416004)(50466002)(8676002)(11346002)(2616005)(956004)(446003)(7696005)(5660300001)(8936002)(52116002)(2906002)(36756003)(72206003)(386003)(7736002)(59450400001)(76176011)(478600001)(44832011)(305945005)(97736004)(53936002)(26005)(6116002)(575784001)(86362001)(50226002)(4326008)(16586007)(25786009)(3846002)(47776003)(316002)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0132;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0132;23:Qep6pV3bPVeFsFYzp5vTxjsWnP0118F6sabmf90Mr?=
 =?us-ascii?Q?puE9Q6RPi7fpQo9oa1u0n5WP5kBOWRV/jszEp14Pcv2/+EyIslAzPQzdpNqH?=
 =?us-ascii?Q?SAVMjukcW6L5wWBfDooCjTOZdgLcDLOpR3+ThI1TZF4vS7uBJIauYDKog/pB?=
 =?us-ascii?Q?y5g84UoQ/3k3cDDKPxdTqV6qr0RywGNcqXVrAZrnLL21QK81a2bdqtDMWGLd?=
 =?us-ascii?Q?nr2kecT8xfh2RrDYFEdPzKFZbc5VNJfI98DdYXFjiwcsaYEBNSiaDIcLuZi2?=
 =?us-ascii?Q?GPo0zt1lWR+vXiGxTGFaxGN3W5w3Vkr8coHEKOK3ST9kuP3o8ybIBvVVxvQW?=
 =?us-ascii?Q?38ZyQ6QfiBg0cyXzZH93YbiutPjVpcOkvLtZoCCtstkAJ8AxdJv2/B7cOHtZ?=
 =?us-ascii?Q?sWeuonHOoXDhQDFxiQ8/pxozxTqvEyRcU6ULbfdCG27XrvsU0Lm4cSiXdprM?=
 =?us-ascii?Q?X0z5/clS6uBsAmaRoUGKF7a1bC/hjnUqLht8Kcuemy99qp+LhapU1PwlI6Ie?=
 =?us-ascii?Q?klMUyew2yWLGE+qmR7BcG2zKxoj66zGeeqCPZJEX/zAzD5FDrsI8UeUtXO+h?=
 =?us-ascii?Q?Zf5p9s+6ZK53c8qugUnGiekuC0C5oR5MHHFEShCTB946Ggdm6yQggMAn8YYE?=
 =?us-ascii?Q?DIkqbzYNqeHLwBWg1IcdG9AasRXLv7Aa2C/HffSijhYq8P+ISKAIsaZa7Bd+?=
 =?us-ascii?Q?kOz6w6xg+/bRa6aIBI3nyuO26Y51yuhc/BoZLhHr+3sSLestzJZ244buFEJG?=
 =?us-ascii?Q?ClSrTPwnChDJq2NHKTqvECNavTwHjV4+8cmTNa4i+qplFDpMkdp2KfnWd3jX?=
 =?us-ascii?Q?s5QMh91cE2gubNa9liWMovRiYHhFYnqBbYIfE+8CINXgdqQCnW8tOeFP3Akx?=
 =?us-ascii?Q?TRKKe90Wd5H4AJ7Ccm2Yd6us6+tS8SjLHGuHpEXfhE75D/lYB5kVDWz9ci8z?=
 =?us-ascii?Q?ZoZv726y8Tdgwaad0dCJ3QDMj+KDDsU3gIieiCKikhHj8NMDjlq6KL4GpjNB?=
 =?us-ascii?Q?2MDGhG811JTdmMuPMAAZEPji7HJ+hkow9gxpKoLvv7i7IRcGFB01BFdhMeqt?=
 =?us-ascii?Q?mfk1LylEbLAQaGIAy29OpigkIb8YKDwLOYp03p/d45MR/NJGyr4lWSEEDHmv?=
 =?us-ascii?Q?Th6+g/nSxVN94pV986wyE4SKCxrkMHZe/93Xwd58bP0JNCnYaB9ViU7cAwaz?=
 =?us-ascii?Q?rOMIUaPo6jtVeDCAY0gTNK5RsN0s85l2pE5siNgXthzbUSdAMpRIKA4AcUGP?=
 =?us-ascii?Q?PIRds71Em5ZQifQrPzxoniCcrk60HrMcIdpiAHYxhYEMWAWw5Z+6Fuh33+/N?=
 =?us-ascii?Q?t0dRKSTflqPMOgKCr9g/Ix6e1ewMqJE8oNO/O1fWDigH3nBqpfX617PmqU2N?=
 =?us-ascii?Q?mFs4hJY8xjjQ6GfGXe46w001fs=3D?=
X-Microsoft-Antispam-Message-Info: Uv3tX8FaevopaaO5LqPCWU5ySEw3fYVk8wnG/VaBCE9A01XUqfo97AWJPO1yyy2eLbBsgmcKuSUyCv+uLoXKkFoUy9TNH2jllJfCa+9SbKdSJfC+LRU3FAJ1RiFV7FHaB90r7UanM58DJ3qhm7qgGUcBe2yVhBY4HbuQSuTlefS3if3dJ0WJ/ZYcr3mV60eo
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;6:6RD1nvVc6He50e4yskOaEmPJRzJ52h6qKCeWawCrFKpdxG1YcXjXftPpbDvda9Ezwu7llog7CWicl6g886OWYiZPDpWAs6XH5xrYwbJyG4B4b/f7qnlRxHFwI5gzQfBjvzjz7KLZnh3vTgLfKV5XEng1/qJB3grqoCejVf3GO/UFltUJByHaffAckw+j7oEfT9tV0cJT7ECWHJ6qkjztEqDn6n2lREIwsNyBiatXpl9A9XYGDgSyAdpMdqi7m3K1KbprWQGKkLkVo0klXMZvAW0AZwrBZ+VM9IYX68602dyRiXdhLyE3VV2rqGEpjrMtuI9x3sUSqqBCov7dWoBTn3d1gwdbtKrVCkb2bfonmLOTCg8jNQo2ckdQZU/cnkI3zGW4BZ7nAjfns3ygg5QaGGfO3TjhHHZRMUzTdHGDnBDyB+IPPUXWDoNuk0oN60g2EpBMPpVkqwTDd9o5iZOegg==;5:aExWir1gvLPZHfmfeVq4XpBCX9Yb2lN+DDoVx2VNpRn0jDOHX5MytwluGr9yWEbN3IlyzJCCOzwsbZqiW4nx4/rS/okBmU8kBo9WKgwJckRYENe/Xd2A5jPA2G1yhdi1qZ3C53Rp5Kn3eQrKvSswzIQu01p9CNeJO/AF9CBM5w4=;24:RtK1wpq1NSNft06HDhKF+oSQJOMaYL7FxWqr2FcSgSo7OTbbbPKGI+ci1HZThmWwzYwtu963HoGVJevwHVmZqTWE+o1FEZ772j9CPS1TwR4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;7:mVfSrbA5XHvunvM1jgL3XXduxBXq0Hw6PeH+dp5uaBdPV+wvt0/TtoJYFGruDtPAsKEQAz2n0iPqa/Ta1V7mTuGFthgRTRUXlfQqaZ1JS+uTOnEWIfsebXf2+ngM3+dlKgOEXj2OQupwGXpRi5UWuKLmoghHVnqsBrNt6usdxbtiwZ1ewlOzpQw5hL1+7kleW78vT2pMgni1AAowfD6ive5UEvnLLOOBYq21zxrJQlXOXE0jJDzWKSTdAmTORStD;20:PuGXKc/XxC6BiglQ+0JtunJ2qLXVLnCFNnKO0t4f1vIXTLDNwbz9xRkdmMbMIpJin19A/SAa9om6T9AbsOJ9ur5AkEv183n4SfFfGcHlyLhYx9b0bXz6CgyVY2PVSMQZGuaFQPkwc5SXasw7KhFyswdYAA6Rz5uxhY1yy65nuBgdsy/s/NjLkfY+HCK0hKRNQrOCKSkcc2AWXtm7ocpiiRto0Wz9SbbrC638/2SqPtIEppopvHCVnUSoen0Gvaay
X-MS-Office365-Filtering-Correlation-Id: 1bd7819b-d893-498f-8c93-08d5ac8895ff
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 21:48:16.2836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd7819b-d893-498f-8c93-08d5ac8895ff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Derive topology information from Extended Topology Enumeration
(CPUID Fn0x0000000B) when the information is available.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2c1a9f2..a3e099d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -327,6 +327,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 
 	/* get information required for multi-node processors */
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
+		int err;
 		u32 eax, ebx, ecx, edx;
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
@@ -344,6 +345,14 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 				c->x86_max_cores /= smp_num_siblings;
 		}
 
+		/*
+		 * In case leaf B is available, use leaf B to derive
+		 * topology information instead.
+		 */
+		err = detect_extended_topology(c);
+		if (!err)
+			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
+
 		cacheinfo_amd_init_llc_id(c, cpu, node_id);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
@@ -378,7 +387,6 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	c->phys_proc_id = c->initial_apicid >> bits;
 	/* use socket ID also for last level cache */
 	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
-	amd_get_topology(c);
 }
 
 u16 amd_get_nb_id(int cpu)
@@ -823,6 +831,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	/* Multi core CPU? */
 	if (c->extended_cpuid_level >= 0x80000008) {
 		amd_detect_cmp(c);
+		amd_get_topology(c);
 		srat_detect_node(c);
 	}
 
-- 
2.7.4
