Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeDDGpc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:45:32 -0400
Received: from mail-sn1nam01on0077.outbound.protection.outlook.com ([104.47.32.77]:10368
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751264AbeDDGpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:45:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        rientjes@google.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 2/2] x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB when available
Date: Wed,  4 Apr 2018 01:45:14 -0500
Message-Id: <1522824314-25345-3-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522824314-25345-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1522824314-25345-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:404:4b::15) To CY1PR12MB0134.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc7d0ab8-3171-4508-93cc-08d599f7a6e6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0134;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;3:kp67xVtmQ7xViPkvHRJi4tPwdwQ1BNg1Abe5mIqy4biR5aMXnrACc9WYg0YTeTFYoS58ghzj9FlcBX6LPnhrjXGvMk4M6qxhg/yze9AOgEC7wrLcId4HydeWgvYZFW4gZGR4GjI9soVMx9rYI8cWAillgJB89gQ//L2vflYnjXwt3rNH7f8kUiCfD3coWfZ9aL/mpQpNyFPIKjhzpb+513yyjnsg3eLk9v+Dx8vzhRyoW9vOrZ9MYl9ZBm9T9pLf;25:fTAjIeq3Q+KmK77ZMUqkg5RKnY0piAmL7Cd7XP6M3GOm8DyJ+5Z45uajOzy/pIcRI3U+YAm3HdHg3kCtinqL5OeGndcmShE0nvLLEueanYGfSR/n2C+ft+ju6cQUWf3yUBWeyTs+TjkwL3C/XhNPs4Qvl4V1qNzL6EKdPZzFoH/nHHDxnD+4JRU1iEwU4p1fo2FHuCXjAKdabNUHrBnc22BQgpkgncjfPOXhESJOfCl8mS/T3+mlFYZbbS4sEHR3cpKiAYgr48JjB1mS53QQkZhtB8StIWw3diPNABughomzUZUtvwa1bKhKXRbTlF8E11YpVtqZbOi2tDCALV4hGA==;31:k8eTB3VnvVFZFvlPTVbhH0yIhgxQMW3EZ9WhS7JZAXwsIObRIcXgXyALhRNURHR1mhauDW37qWq8xBJKMvMQ83J3QX/XtLftIIgInEtV6vAMEJZxouo00rxgdJBzi4OGKa6GZPDsk7HncSu0JuLqSYVA2cNmPTHV6MP+FtBWcnOC/E94OcFLV3Sk2YOaq6X8wpKl4q4o1ph2qnDEbqv/AhARKMEprRY1A5gmEaPPhsE=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0134:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;20:FGyiEq13u5F7xjJMPIE+hoWmRyUKMiP1wviwl87NL+pcc6YZzoZ615F7e2KO+WhmRzcSRESPxKzI7tnTUSwFm+xTG/rLqBEC1fzzxtH/ytDgXY4QcySa6/mhbBhHN6u1Ijbmz0md/e6Dp59Z6IUYW4o+2RddZoaitjAb9jU58VJ97X9ltylfT9GBZ13DL4pXnWcRvoCZoiCVeLIjwWcuV16lIUwgZhgU1ScTwHI52BHiop9AEVoRSrsephDmNRmg+DGaPx68j7bqX+KQbz7m+WHc0fdTH1Tfq7NWW43uq+V4p84Kbrwe1Q+Obwn1yLGPAF2U+b726gkUKwSqEzMjTTG9rId4xU105nmKWI+0+1/LD1CEoxfuv5x7u7Ng5YQq5CG4ryFnHDtlHR/4mtLI32hPY1Q7SsasIRLfjWnt1k3pCJxveI7zYe+5HZ68YuLxaUzf+3nZu+iKZ1YT+3ECXOlS79/W0eXlE60X0XbroQ54I5uruET+nqEmv0bS1JIB;4:pmAEzDtkolzGjZ/1jEipTNelYWC2lqhbO1DVmby/TVqEz190T/T0GBFQxqPcE6Nx9j5vhpGL9ASWrZX+mCIyF58lP1To/j4TPi4qqXV7YkTfhYwtWjzCazEW6dPZtex9yGqMlSKHgxxK3he3P1KK9BInweuqcxzQEmNM/MWrCajF8zpWpTqwxyj15Bnj0Fx5kcgQK7SNNt8PbnIKsYQ9SaVXWhGvgrvtYH0DgkKO6wWQwDqaWHz7DAJc3Z7f4aLZg2M4FYzg7uiLYNUR2vOGST0kFA65QV1S4hDlgiSRSwpXEtYsywwqjvekCoBL5Q1c
X-Microsoft-Antispam-PRVS: <CY1PR12MB0134235677DDEC15BDCAEACFF3A40@CY1PR12MB0134.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR12MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0134;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(47776003)(16526019)(66066001)(52116002)(386003)(59450400001)(186003)(316002)(16586007)(6666003)(7736002)(68736007)(486006)(51416003)(76176011)(2906002)(7696005)(305945005)(4326008)(25786009)(476003)(3846002)(53936002)(36756003)(81156014)(8676002)(6116002)(106356001)(575784001)(8936002)(26005)(86362001)(446003)(81166006)(5660300001)(478600001)(105586002)(97736004)(50466002)(50226002)(72206003)(53416004)(11346002)(2616005)(6486002)(48376002)(956004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0134;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0134;23:SpXya/k7/6/K0j6WAXfTTfQduP+jde+LlHarM7JUZ?=
 =?us-ascii?Q?7MqDy7eKIzE5pibEb1U9a90ljfXhwwEMQB1dVo3o33zfrA8rSMYdgJvf86io?=
 =?us-ascii?Q?21/i2q5hyq3OJ/BzGjfl+edb63knRZHvRD/gT41zCGuYtKaiba502rJ1SDJV?=
 =?us-ascii?Q?SM9s8HqfyEkrAUJ5E3pxIEzgPMm/6ODQe08AkZ/x6bs+iQcH4ggw9p+MxZIf?=
 =?us-ascii?Q?FWZEQ7VHKnNw38W1fQVZOdbwgoGqAetJMLJ04+S7yXzzoX3u78rqYqPPc5Yb?=
 =?us-ascii?Q?iFh5ARPAx5ef5WhQhBE8vhBTqBHzgI3OFA2C2F/b2UT3s5BnlA/qV9mt26yF?=
 =?us-ascii?Q?VEs6vV8lsEMf6uFsBUGSo9SoU2LAZwV59jnZKJvU/AxPTH6fu3ng3e1jcDJd?=
 =?us-ascii?Q?Pm/DgTl7HKGX1C7xKLWqqF9Mvztr+aPmt9dlriMxWYTHaLIWJ3fPY5tPhIxX?=
 =?us-ascii?Q?efgMHzRg5iCMy+ouuxeAt0t93h1SxjHmScimhQGDnOicJ23C+WC5BQsi4KGc?=
 =?us-ascii?Q?lTrphvTyjeWWDoaI0roOrmoOoX4Qi7MiQaxNx7Z01K8hk+q70GA4zIpqdX5c?=
 =?us-ascii?Q?/YFobnYAX1Z4Lh1Q4JHJuC28103/Kqubj5TJf8EAW0/g4lui03/7Yi5gAKan?=
 =?us-ascii?Q?tDAveoOsUVMr7dYESysvNhZeg+saKGCFC3GnShQM6KNmFXyd8xPuEThUinkS?=
 =?us-ascii?Q?LuO+Z8L7MY9mOXLLooc59w74WJqjmV/jKdiSF46NUQD80spd08FW2e6jt/nb?=
 =?us-ascii?Q?knqJr8RlIPW3LGOOR11r/CO3qoQI2nYb0e6pg5bVgUpyo+bRNHTfYqkjcYiv?=
 =?us-ascii?Q?bgyOttcSMGE3kRNse6vVMiSEGL+UC/iGZEclBGeVlZcpVq61niUPZOUCEzJG?=
 =?us-ascii?Q?7x8F4MMxdqsJWqwpidbTirIbwfXFAqXVRjsiPXB5CROiDbZwpOqXHFMrCQll?=
 =?us-ascii?Q?9/tC5DyN6XbYchiwqtijvR7XZ8WGZatMbohoj5ItxzT51X6MshsKee7axQf/?=
 =?us-ascii?Q?3PFndNUZQmAqs7saOo8nmOHL44CeRTtfIqu5Baa/1DuH0LZp7rA/HdC5DfL6?=
 =?us-ascii?Q?MaRrAiPtwYNQJCIFJqph7Yepouo/cXf2ZWr3cW1+am5yDdb+a1/Kx6NB70bG?=
 =?us-ascii?Q?erlqCXhAQzSo/zzSRVFCv+qA5uIBLy/xCF/ecPzKGgoc2S+E5OMEguzuFTy1?=
 =?us-ascii?Q?ejSq7tp1uUopbaNPDT5wP8kU6+8xfvgSpu9wQXw4Y1219XziTB3+t4Cj6XpK?=
 =?us-ascii?Q?BTj+WVSC7ivNugy3Do=3D?=
X-Microsoft-Antispam-Message-Info: OXn2bY5p05fG5hoiV28SsRloFQq/DhRSOKVjztwzfdqRYoOJmLyXew7NQpflUClCUK96W5HYXks3pcXwTY3buqo92ifRlqvrmG/zPur0bD7iQER5r2HaghpjYiTQhORDEJ/Qo2qaFm2lpC8TRFmmjmyXk4Nh/1LYOdyIbW06eLS24xu/3FwtsqTIAqDK8Sds
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;6:CVXMpLFbb3h8B7dAXOJ4yX/0lFA6aUi3L3gb7tDq2QYN+L9ALUbjJwwXQ9HmNBPBBEuwYxd8Ad+uGuJFz42d5KgMzCcp/I4GUyrm7aK9zZN2uX92OZcBFTRWurJLcfogQSfcxSkfKZacnfEgGji5wtXVBic1+dNxKxgT+GakmcOcpMAiYXunqaOhTLafHkdDb3BVhw8AAY5PC62dXNHoTkG5J1BGXhJON/NR8W+W61ubYLrcuASqhBnnDGP7oBBVtKKNu1/L53/wuMCoVnnW1s9p4Qf1UQnJnnp99MWw8GrkAp+V+L+3V/ERLrD9ABlQ9Jnvvn1KtvLhznXXVuQ3Wu2T7EdEeKGVB3rReAhBeB+cA4hvjI0HtPgynVzCMUfhAV7xppTRPU7MiJa0l+Vwkzwoxl5xFBuaC1JI9QH9oX9HBE0BxIGUlK0Rgtjorg1PQhDMw57z5ObBlHLHadYS3A==;5:HU7di7HzeuMZnvMj4KQ5Cvu/P2KWfmTxlUEkzM6H800a8q+KbQisBsMdcb/4y0PJfhXxKFLVf4ZzyCoIrKeNJZi0uVLtxGk7DDSUZCPnVbAmodfsy6vOiZtCT6DjWtoV1p18fTSnMeyJX2mOypA8b7Hke/78iD6mxDozNH+oLcs=;24:SPApu+vSyZGlNciqV0sjCbqc5z6ocfyOdGsA92W3isGtOS0ShMitkCPBiNU9K05fHuSwk1MHtSX+QpEwl84hk4Gi+VqCMCVKDKsA3PT9BlM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;7:xSStgD1YlP09T6camy8FkkvOZLX3xjrtjrumuzMlSYCdDJ52PpT86ylzPhVkKzvxJAbjiGoLl5x+4p15uYt1mc+VQk2XOPGcVl4Adl7LvVDXMb2n2Y6BfYifRcTqaskoCDAGl578e3Ietn5eEgw9LmMBYiVDcyqrUmzroc2V2pMVGwFkePQt3XXKabNv4WPCmzOH2foUJlAYm7lqrmPYfvZQWPFIOw31K41C9IgwVyc5JGP5/TcGadV6C38HH5nU;20:zhCAXs7TLGE8bz7+BOmzD4HvYeFW+KcJZX0yzTdn0PSZh1/Y86Y3HoJsCfY6TWPKlYNpaHLXyyYVKa4J/Vt747Hg4jWTIoR9oKwWZRysYd1mswWm1cbWSoVYh7mDYLTxnkZuW+sgqxB3wEbRKFsPnaDQDcfMj8XQYLH8VfuazCZ54aCJT+k2J4lsElcAAV7Ax55rh+186VWv8CGfPppXbr9RtgrXm0gxNFv/TDvGR1fNQpBNLInWcP58O/hwM/US
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 06:45:26.8425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7d0ab8-3171-4508-93cc-08d599f7a6e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0134
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
index 2c1a9f2..cdd67d1 100644
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
+		 * In case leaf B is avaialble, use leaf B to derive
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
