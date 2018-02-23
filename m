Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933364AbeBWUF6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:05:58 -0500
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:12992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933285AbeBWUDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:03:54 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH 2/8] efi: Decode IA32/X64 Processor Error Section
Date: Fri, 23 Feb 2018 14:03:27 -0600
Message-Id: <20180223200333.6410-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR04CA0033.namprd04.prod.outlook.com (10.172.163.19) To
 BN6PR12MB1906.namprd12.prod.outlook.com (10.175.102.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7ef7b47-eea2-4776-9342-08d57af88f3f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1906;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;3:N6WQ6NAZI5mId+2RlstSGiZG7wYl/tst63+akDkwxmmzZ6ySmyafIuue1nCo86c6ZkZh/bMuUfyqthQAhCvZCn5kEvc9gkvBeZseY+7bT2sJcnF0/JLZTAmsnJCT7iSQt/dyy+41ciWBw5dnmS0Un9n5TkMyj8db9GLmheD7q4zuphVVdx85k6W+TspABptiz1mt/r29nDUcU/EDeScQ9uIX1b4ISRh872/nZ3SmKDrmA1NNAtfUPz3io2YF0MS2;25:jTb0Bwxo1CBYzdb4bjyFQ+QQi3TGSAJkzXz8W6z8KxRfyNSYe9Qd9sBk5ILrqaT95bFw9FIlwDvWRHNnzqnDIQGJTXG5B5eJBxb8s/4fBdBT8GRxF/kU8R8P2kKhPkHY0SanvjqYnC/DREHjVi1Mr5xT6MPHRk5MWZbgzDuylUjFty64csLNtzEr0wfa5qbi8PgTiBfjOk4UQ7U6oeAqi1piJF10hWmvlV1bdwZ0HePUKEO9IP6eD0xscfOKcFxUMghodd1Vq3o7/tnaJV2joWGPdKXZxsyoO6P5eMYLmgLWE+u1GZfKcd/O0F0bZFgG/hjOAYVvksBWGYqNuvvMIA==;31:QjVyJHbZU8D2HiHIiiyotfG4Mqu2wXJSmigP7OFe4o7HB2FabJd8wzhTskSUd76KXeFrPg/c21nfwyOijdRTIf4lEIOH5lVak1KSQJfqtAuEBRjcCaWjuNqN1VXtevU0HjzlBI0oItDyrdxl+o0O7QEGnB75YqoRmqz/MWcywuJaaR7DR6hIBUgMrovjWjXTcGbN5MGlEAuvQRtWKONjPEI792pF1EnceX6ObG6nE6E=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1906:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:JzxMqMMPp/0b2Aq/eE9vfPMuNpMZllxZo4ccAnt9o5Jig06Ae9hHzzNHxv3Y7z5AP4zJKfkCeuIg/qD5Xv71sJAkI1QIfrwtd79ba+7etgr5jbDvX+ZxwxeBkQJ2wXPv6HvIxPnkEgq7vO6v/OKJW06EJAQQNZWWYOxKM9UZM34tLKL3h1dW5z+g3SKA75Jfk99/RPrOmnEIxnYRvHTPOOmtH1uXbaQCRKvtaGzr/hcxXSWtqiaTHHFn3O2QmP+uxEsVFGqXqFJA/ufHyB/iUWGaOlhB22NklgcyUczYfFiu0xAErYNwBoDnU4phTYAoHInQE4rhMsdFphh+LK3Lxn3qJyHkYB52C7bFPKhlxRwkz7WICjbwr4YW3vO507+H6C0WXSha9oV7gaTsbEkHghaSxDgD/e7txHpC0S8V+QX+RfZgacEVsOHWs3Lp0GMyR08BJbTdQeN8aSkxs7YyaQl7JB9/IGkA3NjJS2QrnI3or2ewH0HhrFexdsj5okBz;4:sJS7ZIB5HPk24ZrxCgZPqyiJt37XKoVeXHU5yCD3V/chba39MTwMoUcnfX4UAVRF+7rQu5vF8jwbAIhZhQffr1p0+ncIs+AmJkrXCWftvUoul/EyEQrDjPaOGoOyfIFb6X226wZPQdbWbGdsM94frluM9gGKapUdY3Lfg2hQePrP/2ScMsuRNRIjpuvpJeYEAUwNlcttWAiCJZggH04QwTRijWCfmdlZrd4Ut+tk7rThIiAts79PC3BNYewfE30poeE272Crj08iJiKx3uA1qDrJWLkRUT99v2mi5n/JjMWVOSDXqzRtU6z9rsUQKYVZY3fBM7AvO+wQbplEn4kf8A==
X-Microsoft-Antispam-PRVS: <BN6PR12MB190686C85081EE27443D2AD1F8CC0@BN6PR12MB1906.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1906;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1906;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(39380400002)(346002)(396003)(189003)(199004)(386003)(50226002)(8676002)(478600001)(8936002)(81166006)(81156014)(106356001)(26005)(4326008)(76176011)(2361001)(53416004)(51416003)(72206003)(2351001)(68736007)(2950100002)(6116002)(6916009)(6666003)(316002)(16586007)(66066001)(25786009)(1076002)(2906002)(3846002)(47776003)(5660300001)(305945005)(7736002)(97736004)(105586002)(48376002)(7696005)(52116002)(36756003)(16526019)(186003)(53936002)(50466002)(86362001)(575784001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1906;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1906;23:4MEWGKQMOdO5jArl4idaDl901GH2k+wKhp0D/fXKn?=
 =?us-ascii?Q?+B9xQxEL9yPTtv9K3yhMiKzfzdJyVwK3783ectpBMlPjU5RwNVy9DW0HI7CF?=
 =?us-ascii?Q?DVFH1X5UOah0I7F3zSNzwwbL4068jF2aj65g/0BncHq6RnWE6S4FyJfPwUt+?=
 =?us-ascii?Q?z8S/ePxlnF4Ozpb2XyG7HZMHNQhYj5kekggam0S8gPzKPU4IswcQk8vwgzPf?=
 =?us-ascii?Q?Az1ykPezTaPfPG7gUua3ykKKcX7O1/UctIWfUHoBtJ99VhpioFhQAEn5bbau?=
 =?us-ascii?Q?A0K60nDRuteVf/2Wn71GsFvMXVNJdiuLyOTftvPvjvrf51zLH+w0kZGpSyh0?=
 =?us-ascii?Q?NiFontPei+ZlapqHbl7Q91Ez6vYn2xXY3a9T9u6KwrIKOnqhtruSLe5XOEOg?=
 =?us-ascii?Q?Gps3wGzddZBAIwIpybF45s+ONgn91XcOrd5I8QvGy3MMBIHDbrtr/dmxAMNw?=
 =?us-ascii?Q?X0GFgNOMEziRzB9mk3+QuOqasEnyTihL7zMju2OavANXfXU1cQRUmwD+gK6A?=
 =?us-ascii?Q?DhKZJbjwci+UDPFOknRYs39VBNucTuhAV01XoxKabmzEcOWz9E+wyr4LYSkt?=
 =?us-ascii?Q?SRVJrKE4mTJZyjEvEimKJChI50WLqD2QV0LzloISaAuLZcDbZpzzTrSSN59q?=
 =?us-ascii?Q?U/WIHRYZrfhG+Fx+qC80/Ddoq7FbgijmqvgLlw//e1S9QC3ky8ywQ2ULbfJM?=
 =?us-ascii?Q?u/X0d+t/dy0w6aWTnoHxY9uCaxRqb+mODAis6jiseb3X4hqU7JdQ91mI3n+g?=
 =?us-ascii?Q?+KSLBoSY9QYXaT8h/0O9FLQG5qJE1gK00B2cXETO+/wqVo95fEk5s5Pt1cew?=
 =?us-ascii?Q?ifDHB2xKPx81GaPMZPXOieQUnAAOIFMwB4jwm+sRnfQjpkaoa4SnO1HiLfgd?=
 =?us-ascii?Q?E/53tzgiF12G3j8MGIFxaoougCaEAozQKzg1woggOxrefdVLDRKWgjpbKXfe?=
 =?us-ascii?Q?p7IvBO3hvFFr3ECdE8ibvemJsEqtS44yrH6qthKT0ClzGFIEZ19Q5kwWD4sL?=
 =?us-ascii?Q?Kr816qlyUfYuTRPpsjrg90kVHRkxs0PQwcBVkepiym0LzZb6kCjBM7F6RTlc?=
 =?us-ascii?Q?k0zoZgsnSsT5zGVGmmUKr+rMsSAjKgnm7LB+MJVtDcMydsy1RJ3rpwyRov6x?=
 =?us-ascii?Q?My6mrrxVNu2V6Eiv/i0aQPWSCnGwzRP90hl9U8wIfv77X++TcoQviXFbM1Me?=
 =?us-ascii?Q?5motVet1wqlnd4WKup0XTcaip/fD4eEp2LI?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;6:QBA2B1qeXhuvXP7WUwoWX1GA4DxV7FEbsuffRrqKFWccGIZ5Ic9hp8MDX3mTHxwMocXbUXYv/H9VW1zlj6FgeD4pB0aR9DTpi4IlRHRnfdsXOEKN2hcjVjvEDKvDbNxvKgzAEIwRmuYR83Q++TOGI42eW9QOchJm3WjdFytkoyf2DLgOlYVkAirFyAX9ltGWU8BbeUAzbKwerNtbUV/luN/2bh5/vzPQOXwHUXGoK0HqijGnB9uSSaC5mPuUBaaq06XmeuWexB20rrIhr7g1+Su+jkw65z6GPZTo2YLPnQaYrynDcy+IfHusZ1I6z8ihFlAch7Wp3ZWguPTm5Btwy5hFwWYw6bTSpGTlwM+ILBI=;5:CzLP9L2T5V+Qs7bY5q3ImQKCBBSYE9WyX70VpgGmeM/uCWNy/iQ9jzKU6tEg8ZPMvzCniP7lboJZHIMEM0/n7cMiE3gMAs9adqMkWPCG6O8vYOsS5RlRiFSKCKNv74m0SidVgCrbhszYFDMM8WHfRIeB8HcS3qlHCjnj58+iRKc=;24:pvtFmWtQGWuHp75WI9MUY5KaC/cqNoKbaPjwwMdmdA+GvBXn50Ue7z1Eh4JcrCYPSyEKIer+Dl03QrtbQS/XNqC+kE4dQQmGqtxPrlC73Dw=;7:CGVP2C4S3oAaB7d7V+ERZXfeKxMVKAAF9P9xJE6CgfL8O3iFZK6beUP4k/XwXzCG5qcQIfuPC4rnLDIi0fN3w0rkxD0VKcKnaQQQf8XX+96tCABuWcBgZCqdESqc5GXP/h7uxZ6S80O4uegUvHPYUTWCORZ686G3c5X+4r2oGii5KOT4JIjtyB9RffvngRX5VfH0faykfVyxZxFzCtK5wM/lfzoeawF4UFLkdhBeKb3OZjoi70Ff/+eOGlfaVYNb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:1MJG5E2Z/sS8lTnOpKYS3uscgxVNUKvN3A/Kq43HnWLcLmUM5JdN0V8unhAbB3IRU14COMOTDJhETuxCUHMxCNiur9d/eOfyBb+mIw9uYC61lwRn/XfPgAzGT/bSQVuvmSirhdnN59zDwTMD0lrp/em4PZmob6PU7kfi7yigoFarOyAVmTjjC70sdYlF3cP7GmJhBah8LOME0FzUfHF/mZF17mRlgagkiNL0M/SR7ZNOWPaqh69ebI2Pa4eRTe/B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 20:03:50.3610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ef7b47-eea2-4776-9342-08d57af88f3f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
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

Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/firmware/efi/Kconfig    |  5 +++++
 drivers/firmware/efi/Makefile   |  2 ++
 drivers/firmware/efi/cper-x86.c | 26 ++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c     | 10 ++++++++++
 include/linux/cper.h            |  2 ++
 5 files changed, 45 insertions(+)
 create mode 100644 drivers/firmware/efi/cper-x86.c

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 3098410abad8..8b684147835d 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -174,6 +174,11 @@ config UEFI_CPER_ARM
 	depends on UEFI_CPER && ( ARM || ARM64 )
 	default y
 
+config UEFI_CPER_X86
+	bool
+	depends on UEFI_CPER && ( X86_32 || X86_64 )
+	default y
+
 config EFI_DEV_PATH_PARSER
 	bool
 	depends on ACPI
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index cb805374f4bc..7cf8d75ebe51 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -31,3 +31,5 @@ obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
+
+obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
new file mode 100644
index 000000000000..b50ee3cdf637
--- /dev/null
+++ b/drivers/firmware/efi/cper-x86.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018, Advanced Micro Devices, Inc.
+// Copyright (C) 2018, Yazen Ghannam <yazen.ghannam@amd.com>
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
