Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeBZTlK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:41:10 -0500
Received: from mail-by2nam03on0052.outbound.protection.outlook.com ([104.47.42.52]:25040
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751881AbeBZTj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:39:27 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH v2 2/8] efi: Decode IA32/X64 Processor Error Section
Date: Mon, 26 Feb 2018 13:38:58 -0600
Message-Id: <20180226193904.20532-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To MWHPR12MB1917.namprd12.prod.outlook.com
 (2603:10b6:300:114::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4da3cc0-f8c9-4061-6fba-08d57d50a4db
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:cvHaNUBLfRH4/xR63NKPXY1x6dkYKHuZqB7mSckjnG4NWSGeV/D0fW8f/feVw+9sW/HZCPCEOtKhJFPvoYYkhDgxHEzylZVN1pQdywOrm7hTzM/eYvIVTJgoZHUhqJwu8NP3Offy1aHF2o4Orjel2MfBAR/bXEdiApVmqklI0cbIzjACvqIafb53av1PhJ5WNegvxRtZ+puG/uvfSZ0OH2EQY6M1c6LmSectT7zluHp1rZbPUOVAInU3bX/0cN4i;25:1E+1ZHjCQhUdm7sF5Bbtsdzozc9sQ3ZcRNyp6uyYJoWCOEfApXsV5n36I2Cn7+UYkQ3t1vVaeO5W3e+15sBYY0xJV1vQ4CjWLsQt0C/W9Dylexyr2mB2S3NkCN4K1Dv5yi0PFMjw4w1NRaAxvqr4zgzXe647sLeKgWh7iGb5xUT0LXFhXzvhIAsgwgPip9Jp6M0GlrmDmTRDYN+aO5PwN+zM//iy56aPlgCxp1HMJx4PVwgThjX9P52KMdZYGj3W1WuUjgZAmm9occ/3hGexTc4BdZnjZT1JxRzelVnfNW4Ko4pqfg3KXfOdusK+saSYzo2RiH0b9F3N959lK62oaQ==;31:jmChgkntZchhFxbOUagbc5TWPvnki5qHHKkYLlPrxvOZ+hEX0Af3LCBDIkSZ6Nwgs0znjEF1GFzdX/zWGTYCHEZ+BKhAIDHo0OjM38I6nSebNuAzhYfks0wYSsmjaw3CF77gE1s4Y46tN72MXZdxEhjiI0vdGpNJlavsxdZk5rTcQXwzDOF9GwwVQFgT7h6T3B+NTDM1PiH47Q87G0rJIGv+m6SW+S3wOAM/lRUBWUw=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:W48AyPJRKPykCFjhzpYbwjQO7AIZCJvs8akly/ieDAXT+RuP7DL4eBjsWiyhr7Qgloz7AMtiwZxuuWVnK9t/VUqbPj9TD0UAPwKo288czFLYyXydvVvDic4aZc4lv63rWCbmdNH6+dCPQ4GiIH9/0pBgIr7rvdDckq8x7Vdyp+59YjigUkEvL3JAo484BXfSaYzFphbTk3LOStZWA8BmfoM3HKwmO7imxnPCHZV3qzaGO4ueUioJ9t2JhJ23VzNPDmfbQzzJ2POdT9pdCvbX2tErGwFb2QbWXGwW4QcQTRjsyk4URp/wBPFqea4vwzgR3Ysl1uUPfl5I6kLrNnIjcEInovPqCSont895VfwuLsUYpG4OrSvdg+EpCamdLrw8M3gmO3MPoUfrBfxrNnqLI+fYh87VsuC4CIXtmFGaQv53qSc08EHyRF63WuGaG9kbh5/pvCHRBJQg96BJQDK9C+lIaMuOiOybsZwDWmPfjAIJHAqWqSp6lejbCTbKtkvK;4:eaztrjvLIy+/IqmX+s1YfSvg4kx7UYMu/EvPa1fR7fACb7Vp4cfIL/OugFsOHirXqx1oNj0OKI2TxChl4ZBxgJTNJasV/1K8d3HE6LHgUP1uZ6blbawFA+FaTNrWy9/pwv/1/7LZVHO7p43bYNOWzQQynHqwYsOCeQFkwGpJmOnLC1k5+xoTzEsJBoh5l7Vp7Tnox9FVrEQvSuSNwW6RjpBjgVmsC4owUcD7VWTD3B2U7kIipcSgCJLZ1Q2YTHSF39P5+CSNNQ2pFfqjaTh5Hd7zDhhyIJtkNK6kUs79fKem4T/SUxh2nupVTAfFQlPejRYz9aee+FC5GCEvUnzjbA==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1917273CE051E252179FA255F8C10@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(72206003)(2351001)(105586002)(386003)(16526019)(478600001)(575784001)(86362001)(25786009)(50466002)(6486002)(97736004)(36756003)(48376002)(53416004)(66066001)(106356001)(68736007)(51416003)(50226002)(47776003)(7736002)(305945005)(3846002)(6116002)(53936002)(6666003)(2950100002)(6916009)(76176011)(5660300001)(1076002)(8936002)(52116002)(7696005)(2906002)(6306002)(2361001)(8676002)(316002)(81156014)(81166006)(26005)(186003)(4326008)(16586007)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:YefoBJVDxkJut7xG4ISa+4E2yh+HYJ6zKWOl3UNI5?=
 =?us-ascii?Q?QBD4ls8KyuKiVvD7rK9M7d4snXRsTzl1vdO6h/xzkmeXeP3Odi9yR4cs7apd?=
 =?us-ascii?Q?l/kwvLli/DxEGUEGF0y5KBxJhTVbXvZgE/rsI5EiRqrFEy3ZSCnBTFk2u1HV?=
 =?us-ascii?Q?2OcJWddi1GX5P7v/mo9IwwZd68mCxmhX7n3dBRbxnd8j5GWmFnjXY6kodwVh?=
 =?us-ascii?Q?jpvI1RIKcFufmMm7elFM5MoTd0J77BUheKt0/8oJX38naZDNr+SWL+Yydfqa?=
 =?us-ascii?Q?6/kXOZnyTco4oimwyVoKpr5FvL0RGiqauBy8C2SO9KITM0Nf1vW4T+P0ok2H?=
 =?us-ascii?Q?E38uXlR2NWAD7b7HRPUSHD7+VGGBoDvGhGEvaiOuuuCfm71vEpxxiTfSy005?=
 =?us-ascii?Q?vXw84qcw2IYRyNREba8jgtOlxLCWmCB4p8S/5japqNI4CgCl3Kzf9ZTrSr32?=
 =?us-ascii?Q?MkOG8p/kjolNLrzhCSOxciQdeLVktxKBVlMyXAutoWVdSiwyxSwqoUw74YOi?=
 =?us-ascii?Q?tYo/NJ04DCrOqHy+l50A3aeTO39o3Ev6UdKA/gcv+O0s/NCC0obpzfwy5Bl2?=
 =?us-ascii?Q?aYTw6CM77d39vw5nd8i3hwru1cRg6rZuIfE8z80gxG3lRYZQovG6PI7vVOIp?=
 =?us-ascii?Q?Xdvtuk//RqKbGVikxUjbyt/jrX9Ebc+nnIKkJj/2A/ZQN6+Sy0aOW5g2JaC4?=
 =?us-ascii?Q?z6+t4eb4fwaneAJfxIUsPcpTyoFjDlg8oM6jpdyY1C7roOftuFx1iSHhJXQA?=
 =?us-ascii?Q?eUBAxLu7JhL6/vMfPAfEqPCJuvwp/VB3smuZCaZ4ISmWKo9dB3ISq2YG7Jzn?=
 =?us-ascii?Q?qU+/MY1jVUQ4pIlZu7AhRy1wIQlEub/wsXqesFaUGISLFoCDQowsdxQNDqrr?=
 =?us-ascii?Q?FSECuSpsnLU818MgOCDm31Q3Y6C63pXQoEtq27Ydr4p8zx92JjqnGcDAXMb7?=
 =?us-ascii?Q?hno6WUuarBq66RFa6vc/FXf2OVzostElpEHADLRhUbafQNTq+nivAzCwAB8L?=
 =?us-ascii?Q?Mk47Jta7cHe/h8YIj21I2RePW9V2Fvz9ncVWz8N6TIyo0gZausXc7cfd9lEp?=
 =?us-ascii?Q?Eblzx7RhSK/Ow+nAeW4lKDJsXr0OfOappID1ZgvdqjYefB2tgO857bbF2I9D?=
 =?us-ascii?Q?sHRNBbLznhaulT+YQn1beL+eMLe3CO5luu9lu6beTeG4gL9F3z0aLCYGmTNF?=
 =?us-ascii?Q?u5liJMPuXv8dw1dnZ1c75gCGNk82bByvOs4+4IPjVWAiEMW8N9oIbL5J1c4l?=
 =?us-ascii?Q?KaX56M25GpkYau8flo=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:JgAkRZavnIJubrOlkYmwmaPFwhPhjrivaFNsoOygtBn2hERDlS7AFuPU2vhOW6dtlSged2BuU52yGLAe4Jp65rvIy+LxTD+u8M37XfPW2hvCJLdwHz7eP2J12yikNxyj3OiovJvGrcijjECbpjCxQvi4enWGLDpVRZzDqo858GBi0C0tifP4pVBrNNk2UCr7JmaUvXs0xB84zjny813YW1nwbNeqQNAXz09TIdNXfvKQJ0BsLTbpgTNZ0QV/ubduHwY9wizrhWQtOGrK1RhkKBbBbEQUgSyPjMsTH++K+XVGhH/PL+KRpZObWab5XQX6nRN95XdN5NdjhaqjuW/TFTvZ6s6MnfWko8eTVRNss5Y=;5:rC/lGP1Hxsl5XqbVMmc5eVqvbqK3aToKnuvlkCwaCjkfpW9j/alJR8SFDyqSnxcVfoPwBsesZOgsO3GnHRB6JZBF+xx0nCeANP1Z9BEdcuEEl5YI5bcZ6McIo0duPLLPNrERotN00i3RGLwUkimYMFfXqliuq7zF1p1G2Qd+wV4=;24:p2J0OAzpmwzcK/P4BEAWw/mgmmhibHWseriscXPWZBCr1XoD1wkBu/g2hsZRv6JPIzxNEDmfNHxiKOd6Q4mlYf1cWlPpQfrRy6ZMwLDoNeA=;7:NJ1hVC0miXkbZV6jvAqG4wBqyngAh+MdRhU5v72wMLZYhFGTEiPTSMzY8MQ8egpNCXXetwEK7c3rJ+h2B9hEH8bfwIMv22ocGIchcXWTaMAx9ud5k8k0QdLXyjh0D3oAnkuWy/heFhBz6JQrKy18yiMoxyWC61lbRA0G0V4QhXXKf11A5VLd2IDV/sjUsVmfwswe/rNa/WbSbQO2Bx6Q+jZoOD3kPqJUoylSLY5Z1o3q2qxtLXFcRI1Kc/0ybrHT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:vsjXfsl3Gjnyrzyd01GQk9gvoaTlalBDsNfaYumpLmXC846tRjvVebgNOh9qEhp9w4cViOB3uY8v4zZGrwDa3vk2pDXFXMe2AymhAc2vTqmDQceCRPOp7Dg2chdMVXK286WPNgSznBoWjL9/wz34Ro9lhi+UidhQHdJQQUHhfUheZSd5kGelxHUwp6DgLkrtXgLAVVMw6DwA0yqlZWUUtG4nFLSaFW9DycFqrmK2qN+dHwtoH39kYxNN2W6KjS7G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 19:39:24.8399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4da3cc0-f8c9-4061-6fba-08d57d50a4db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Recognize the IA32/X64 Processor Error Section.

Do the section decoding in a new "cper-x86.c" file and add this to the
Makefile depending on a new "UEFI_CPER_X86" config option.

Print the Local APIC ID and CPUID info from the Processor Error Record.

The "Processor Error Info" and "Processor Context" fields will be
decoded in following patches.

Based on UEFI 2.7 Table 255. Processor Error Record.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180223200333.6410-3-Yazen.Ghannam@amd.com

v1->v2:
* Change config option depends to "X86" instead of "X86_32 || X64_64".
* Remove extra newline in Makefile changes.
* Drop author copyright line.

 drivers/firmware/efi/Kconfig    |  5 +++++
 drivers/firmware/efi/Makefile   |  1 +
 drivers/firmware/efi/cper-x86.c | 25 +++++++++++++++++++++++++
 drivers/firmware/efi/cper.c     | 10 ++++++++++
 include/linux/cper.h            |  2 ++
 5 files changed, 43 insertions(+)
 create mode 100644 drivers/firmware/efi/cper-x86.c

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 3098410abad8..781a4a337557 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -174,6 +174,11 @@ config UEFI_CPER_ARM
 	depends on UEFI_CPER && ( ARM || ARM64 )
 	default y
 
+config UEFI_CPER_X86
+	bool
+	depends on UEFI_CPER && X86
+	default y
+
 config EFI_DEV_PATH_PARSER
 	bool
 	depends on ACPI
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index cb805374f4bc..5f9f5039de50 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
+obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
new file mode 100644
index 000000000000..9da0d981178f
--- /dev/null
+++ b/drivers/firmware/efi/cper-x86.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018, Advanced Micro Devices, Inc.
+
+#include <linux/cper.h>
+
+/*
+ * We don't need a "CPER_IA" prefix since these are all locally defined.
+ * This will save us a lot of line space.
+ */
+#define VALID_LAPIC_ID			BIT_ULL(0)
+#define VALID_CPUID_INFO		BIT_ULL(1)
+
+void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
+{
+	printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
+
+	if (proc->validation_bits & VALID_LAPIC_ID)
+		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
+
+	if (proc->validation_bits & VALID_CPUID_INFO) {
+		printk("%sCPUID Info:\n", pfx);
+		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
+			       sizeof(proc->cpuid), 0);
+	}
+}
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index c165933ebf38..5a59b582c9aa 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -469,6 +469,16 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_proc_arm(newpfx, arm_err);
 		else
 			goto err_section_too_small;
+#endif
+#if defined(CONFIG_UEFI_CPER_X86)
+	} else if (guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
+		struct cper_sec_proc_ia *ia_err = acpi_hest_get_payload(gdata);
+
+		printk("%ssection_type: IA32/X64 processor error\n", newpfx);
+		if (gdata->error_data_length >= sizeof(*ia_err))
+			cper_print_proc_ia(newpfx, ia_err);
+		else
+			goto err_section_too_small;
 #endif
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 4b5f8459b403..9c703a0abe6e 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -551,5 +551,7 @@ const char *cper_mem_err_unpack(struct trace_seq *,
 				struct cper_mem_err_compact *);
 void cper_print_proc_arm(const char *pfx,
 			 const struct cper_sec_proc_arm *proc);
+void cper_print_proc_ia(const char *pfx,
+			const struct cper_sec_proc_ia *proc);
 
 #endif
-- 
2.14.1
