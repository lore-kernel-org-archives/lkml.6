Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeCZIGX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:06:23 -0400
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:49600
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751677AbeCZIGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:06:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/2] x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB
Date: Mon, 26 Mar 2018 03:05:59 -0500
Message-Id: <1522051559-23415-3-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522051559-23415-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1522051559-23415-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM3PR12CA0080.namprd12.prod.outlook.com (10.161.151.152) To
 BY2PR12MB0130.namprd12.prod.outlook.com (10.162.82.156)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0423840-9d00-40a5-328e-08d592f07116
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0130;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;3:YEAvueMGPM+TrvUIMab38FP/SKJX7G3Kw0SkFFWYj5yp1YRm1Tm332l4fIbuZ6tcL4VvqlaCjx6mNx6PvBuHpId8eY2SGgT6jjKQ4uvcZd9GkTz4sb2Bsm5FqL6ghScIeEeg2ki9u2k5cgkZR53zvCwk+zlGZu2V5NXrQDU7uevE7wYDYaSiS5m1eiukR7slmR40uEvxOz02rW7HFpyQm3W/iTuuTKgmNC5qjlH6dWE+pIFRj/uAoCCjCiKyJizE;25:tpf3E2Lqd9YF1R5mtwUPqOIxFD7kHHKZ1rane80DZHFsocBTxpH3ChFa5TBKarJzlFyuRSgSQZohoVMyZuAgjjJRdDG5CN8pPUw4mKQzbYcOyWQ/kDcM9oT2Sdb0wqa8FUHiSuE/HiP/+RgJ16yn+cs8Ieo6CYDmEXl5uTsb2GwvLVugJ6p8z5uQjBZfN8gVFCGM3FwXNAeD9rBcOBpfP+yeIhdPLskm4kLiKH1e4jmhpt1xXh5TVFeXT8le3dIFHXnP/MRaGWS45K/70ZgDAVEE+B+cybWy5c3DTihIQhK+MNeonZEgzsff6a3wJfgVIZYvEMIC//+b2sPFtCgRjA==;31:at0pBJybydpzLLwa2MfEfrGsbjYgnmuaYJScPqpQ2ihiuoKTrvubT0axMFvcnv8Y4jHqENEM8P+CCTILrRv4TXN3OAlvLLM5Zq6qUXGgUaCCjPeoV+jZTtaPkwXchRBmZXFcM7AWHy9lFkumOZfLDUwCEYR3QANBDbigU7Logni2DPbxGOQE4Ot+Ca61Vy6+I6LZ08lkj+XVbNtdbFo+8T/72+ZVR0YVm+2DMYyZMY4=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0130:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;20:GLWzMiu0tVm0g59Uc1QO7EIqUD+g9zI0QB9T2NEfogz45JXm87s5kjh6KSBQhDHDWPVprqFo4Gfyfe6GbfKyEqzFEfdcNJ6Y2RikQED8SfijIvm8KLK7T1m6Cx3CqJuPue084ZD8D5MBQmOtqZrMt+IxNPoq7l+WRR0rGmQAjzPTsuS5uCFacQ/kCblGu8Bk7mnZIB0h65g1SZxiynSyHC0AVu7IX7h52j4eeFx0tSn2o4NdJyaT8imNH0AhJVtH3YMUaXBshL6hs7jgmhOIMpV0whEvN93/X2DnSs6UM7Jdyoo8EqDKHItMnT0qOzwy1Q4Mnh3mnWt5xvYeZqF62DJtgSQ/ef5hrR3SpaFIRNPhFxQgGVq0qlATGKNPPUjM9OsCjwDTdNBVlwlCvycOyGyJf/895N+JGLun2Ct9Fw8iA126FmD3NWypnZgrAfyQRMkPvXlybxzDgKff8+IDN6nVeK05jJGYENNe4Z9C1Bggoil2iNvT3ugywz6eNGkx;4:HeLuerVqqH4m5ipB1jb9w5ZM5IaSh9JuPOv9pVCbocsKwsEO0ZhKnOJuF7wXYEkj1T9jeIEmDUn1xA711l+mQoybPf4iP1vXYRT75Yyn8zzODnnB7XaX4aWXODpxige8z0FxXjNH1EuZDgUmqRqNHaK9/Uv9lg8rjWgxBef045dA5vFsgIqdzaQpHKzamGLWv1CWMB33zbGOBt2vsp6OS5Us21xiJF/YqqYCehpOMCzbUcnzYgsWyxC1jVx1W5QSECzxM2AKPH4AjiQS6N61yKTPefa1EcaPDyfyh3EpxxpbKvMyPr0nS+Ke918B/s6/
X-Microsoft-Antispam-PRVS: <BY2PR12MB0130C81EAB08A2A4B059850CF3AD0@BY2PR12MB0130.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0130;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0130;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(39860400002)(396003)(366004)(189003)(199004)(16526019)(26005)(105586002)(53936002)(97736004)(86362001)(575784001)(7736002)(305945005)(3846002)(16586007)(8676002)(478600001)(6116002)(316002)(81166006)(956004)(2616005)(186003)(53416004)(50226002)(106356001)(8936002)(81156014)(36756003)(2906002)(5660300001)(50466002)(6666003)(52116002)(51416003)(76176011)(72206003)(7696005)(6486002)(48376002)(446003)(4326008)(386003)(25786009)(47776003)(11346002)(59450400001)(68736007)(66066001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0130;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0130;23:BQPyUARjFGorVZCQATNDOwO8DymYdlgyFfhTzsG9F?=
 =?us-ascii?Q?IrsX9AnWf6CTEJ/KreG+IYgwaMtIlijeDgbxeg2ULJ1mcI4pqpt5v7f99HK6?=
 =?us-ascii?Q?gxPA/ZeViesPwFPgdl3e4MJV+afj98kEh5ZL+V09EXdGlg+w5I/T788ISLvl?=
 =?us-ascii?Q?uCgQ7snvVGCW6LQOTWRbjwzD5/X0g7JOlZDAO96aOdL67jWSeXWcHMonPu10?=
 =?us-ascii?Q?YoXgCBfPCC4AZh7KL4CdgP0zHrTWqDwM85gblH6yd3VTIi3s9vapJ1b311nP?=
 =?us-ascii?Q?/K41dII6+dvaV2tP6THtOTfutA9ZpDxPGhHbzl+aurDp9r43jeOYDAEwxWbe?=
 =?us-ascii?Q?3QDmsKrO143r3mv2BSBQPKl8lF31mx9WdrT2lzPPL7+08/tDVX+6y1cCTDA6?=
 =?us-ascii?Q?4/MWaT8BJFJWUgUVXzlZhLg60US6ggTaWqMaxIUxX9HO7/ORmWUC4BJBWx34?=
 =?us-ascii?Q?Yuuv4ndTh3YlM26BFobjlks42hUdlUZmXw1s1xGmH6idtfdCohjLOfDtZNJQ?=
 =?us-ascii?Q?cFAOyzRng1efJv/AGU1OXgeysneWlrlXK37nV8EXihgiTNh3BVkywXTmAbkT?=
 =?us-ascii?Q?NCrbKKvaNIfZtbc+pj2URyabo7KT1/mg7RolSERV1oy8wLcwtFI/Ysq1kqph?=
 =?us-ascii?Q?4s1iDC6JICGGhmhaIUsIqCZCSFgly7GOHhC8Sl6Enkox+ARvGNpN8rfpaSvJ?=
 =?us-ascii?Q?tBtOnW4jRajk7Nt/p5e834+qeVvsfLPb/QOKcABgVYB37UEzXnlxi+B9AOJn?=
 =?us-ascii?Q?IgFlusth+IiUFdj3YwCxQF06MC5JTnJ/xmeLxbAzLxhgjEhnrwnc8K0bsewT?=
 =?us-ascii?Q?SoTSw+S85loDytwtwa4Tt7xcpdUbJHXSTcF9lEBE8HrFHSY/GCn1oaF9I3mr?=
 =?us-ascii?Q?242XcYTJ5GpTkIY5HmD+sQj8N4e0oi9bMJgZ2ngq+gj8+FWK3EKqCFu/wRuI?=
 =?us-ascii?Q?yQbYHiJOEu7IfCxgYMbPuq9WYKD0jfUIc3l4tKM1giKAtIyZjj3lmnNWB+ZL?=
 =?us-ascii?Q?xY5y2l5WIi+N3D8wTaYWcTLrA/FL4bfpEDkTq8SAvZgRGXJnT3V1eY6qMReG?=
 =?us-ascii?Q?duNwW04FVCi4jDMnIenYBppJBVjL7uGu+Ivafst088dw+LEbEL/fjjblZM3b?=
 =?us-ascii?Q?Nsfkf43FMUbKxXltVdre77yimkHzP0BhZYzMYZvcWqDVsBjZFJ/zIjAOE3mc?=
 =?us-ascii?Q?TiGjihMhaZuofQ1+1tyRxUwS/ahLdHTGgWjgcsBAuLrQGuKFxJ3aC9U0w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: cWnwlfTilvGP+AIxy8WD0SVM3pr/855X9EhbqX5aaK3gkRMwJbpVxYXMSk+Izpc/WAGJOU8YuP2U5aeZj4NQbZdxXhS7zHh5VInE4vnRk2lAJXOLY4VyjfQ+EQ62eSNSZlJiI8uUW5+AYF0huQk/vgVrm3dUCFK2gTcvRvZdxPP7+EzanKzOQTX5gDzu+AmF
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;6:701wOCkkjOtlq2PXRqkpixTPlGjcCP0kkM+h/Kt5SppayVUCuzR3ZjQ07gMpEkyXWCaMqU3PjCbVnc/kASJNGsvBze5ZAY3GNy+BtNFsu3rq8I0MXIRVjjLg3/WfrFs9ikwZiTSr2vloUy6uEZHWkpH5QpnrO66GCGaZpQGIMrZbXuowO2bBGdEZgPYe6by07u7rojwgywiVZlTHITnlmn8ONshqF3j3PvK7TzWLQNW2493p2bzyHAddvrd2kX9joPZ1cAh1l3tcsIIyRjzoJCsNcGzumkTJnRU20B5UG8W3kc0IwPOCZ6MNiWcFxPPjwjYLcLP9gGqWlmrDVuiKjYW6xvakh1VcmSY/Cb3d9ceZXZfs7tDGCkyZXm+BXzEQkaLohRQLFtZyDhAsiDaGoXz/7W2ECcOg4wWTxyWIJgd5CucEyzsYmT17rm/TWunh9yLDggJ0/5qpVYTtoUU98w==;5:gqeu0aIdkRfIY2fRBD7dzZRsEd8aAG0UAyOOTJU7S7F/9VtKptYhl++CBigIPO0RTHDyBTA+S9T/vKsKWXLjFUUa1vUHD1QlPRmo89ogRMK5kcLUhgqcGClksSeA+pIodeTQFDJf0izRoUZyxUL7AIv5n79RcEwpPU8tXYTECrU=;24:26DfurbtNnZCrq3uY9A+zg2yQLnqpYUHDAR+L920b+y0iHc75OpFOwJzlxmnjH1Tnp635JA8XcEBr9oGCQQeyIKcUs4YaJr4vkgTxzS4JbQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;7:dgHzRdIX9qPBzuJC9221bBDuzgo9DWUpJxolwFmnA3gg26P0FWDWdztA+rt7R32MDKv5rJ9JsB0ag0cxPqMzmHGStDjabSTRuy7xPvoe83rAyDr/noNFYy3/AKshCP9IzT+FWXoytX2B25zpUznQpUBF7M+0sJUJZs1ScgRy6KDd8cIs+9wNFd4qWQCy5SrYP29D0GRFMoB0tOFc9vaXT/3Ac+06Ijr8chWpPeDWrLYldvdO1Qu7zZF6Q1VP+Dg4;20:LAJah1wE72v+SWXFOseHMleeqZMevD61GLE+TGhNF1adRSvHEIqB8KVbKnNwzQqQYXisUZzfbS27mTLwK6LOwnP6lQRFVI4XnjvFbrDmPxb/1nh+WDMidVWnTI3Q3CUOAlXxw+dQY0hwOwzyNzBnbFKoETUxG5Ffp7EcCCpqlEWM4trHeWU097GQJ/G3DEyDlJxOnK2gC/KxDgjeR4ekngTB2VsO0D7poCjoxLuFuK1GiZ+/lDO31p4Lzsupsw/s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 08:06:12.3064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0423840-9d00-40a5-328e-08d592f07116
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Derive topology information from Extended Topology Enumeration
(CPUID Fn0x0000000B) when the information is available.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2c1a9f2..2b40144 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -338,10 +338,18 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 			c->cu_id = ebx & 0xff;
 
 		if (c->x86 >= 0x17) {
-			c->cpu_core_id = ebx & 0xff;
+			int err = detect_extended_topology(c);
 
-			if (smp_num_siblings > 1)
-				c->x86_max_cores /= smp_num_siblings;
+			if (err) {
+				c->cpu_core_id = ebx & 0xff;
+
+				if (smp_num_siblings > 1)
+					c->x86_max_cores /= smp_num_siblings;
+			} else {
+				int bits = get_count_order(c->x86_max_cores);
+
+				c->x86_coreid_bits = get_count_order(bits);
+			}
 		}
 
 		cacheinfo_amd_init_llc_id(c, cpu, node_id);
@@ -378,7 +386,6 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	c->phys_proc_id = c->initial_apicid >> bits;
 	/* use socket ID also for last level cache */
 	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
-	amd_get_topology(c);
 }
 
 u16 amd_get_nb_id(int cpu)
@@ -823,6 +830,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	/* Multi core CPU? */
 	if (c->extended_cpuid_level >= 0x80000008) {
 		amd_detect_cmp(c);
+		amd_get_topology(c);
 		srat_detect_node(c);
 	}
 
-- 
2.7.4
