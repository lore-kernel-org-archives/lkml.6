Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeCXSuH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 14:50:07 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:57948
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752731AbeCXSuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 14:50:02 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org, bp@suse.de,
        tony.luck@intel.com
Subject: [PATCH v3 2/8] efi: Decode IA32/X64 Processor Error Section
Date: Sat, 24 Mar 2018 13:49:34 -0500
Message-Id: <20180324184940.19762-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
References: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:404:13f::22) To MWHPR12MB1919.namprd12.prod.outlook.com
 (2603:10b6:300:114::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ad466c4-4fb4-4ff7-824a-08d591b80ba4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1919;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;3:Vdko4OxBDhU2o1/M5Yo/XRRVQXnxzkFqBd8983kAMULFc4lW2GbhJReTt3aYfboSSQrBazmznmcrq3A05QVQTojwJDmkJZi9xUSY8KH4+f1SJh+u4HhQm13KlBCpvOuWBUxJM7aRugZ+/3G6xkaRwJGJrkFbGrLyBuW0WXfH8agxtpRhtLMgNoW2LlCxOX3p7tYmqdlPDDWftUa3Ay5n816GHMft+pEiT9hGfWj1xPPWyrPqbMLwtDevBowa0yHy;25:vqM9V7qas8LobWfp/MfGonKjgFP5lx78CSN2lnpeMGfuG0LdxCsoqBlb2QTSBNFnUk0SJ+nHJ5dpt7JGJeVneJ5b1ses33jFpDzN5f4Dp15E+E+nSeBCKuPbegrfdAjJrAOpvYvkfyCJUFMloci1lhLcXT5AOSw70lnXn1ApcO4fGazOODyB2YdmyTx+6DA5TWkuyGQTaChkgtdDLGMG0AOrUC689zKv+Y94fxJ3Pl8Xt3GXW69yUjeTYHh9eoIyIbg9rajXoDN6szqCYFmEX7iKViudqdX81oe3Kf55srRwU64v6ox9fzq7AbAoMhoKe58p7+AxQKIkWN7bRDhlbg==;31:ZP73cMZrOY/2pXZIcDj57RXRctMlCY6IXNT7hvvZChJFU7TJduDx/7qIagYohmq4dAL1WD78KRcoFxxPGWTAtZwUMMXxC1OyugbOuw0UMpe7IxdXH8080ks3xelBUTi9fCg6bXbXMoKUiTjyzGGot5+nnJWWS52/aohUSoWjDwIpCbelgybPoUyEKB0037wLJsXK8iP88m1H2mB6jueJVifvvLdbjU2Usm//+3nkHjE=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1919:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;20:9RhRBZ/WPJmWth75clOtCKWpDFagHejICWH0hT3GXJWfegX/XoiGtSlWLL49slqxijyPMvRc+vyu2L5wUMYbAsOx66np3OMA/xT2df1KWufGzoUIWCJnpRDmjrrCnz0dXK6ShGFD3180yzFQqmL73plW9jmaXDbvoWQxUqb1/ihvqThLJPTEEmt0PCm1MPWr5lh5wY6KOx1HqYByFjM2RzM/N04vO19rSgmP8DUub4GoDUOc3o5WC4wiEmeeyRfMl7L/FBnlm5Y+PQXcidmKv3tKFO8ekGchjdlBvPrEh/ipB4cXo5u3iiMvnqkvlOdyebVOjFZFv8G+J2Fj4KudNAP6yetHFqDQJ189lleYJ9o473PGjtKlGE3v1788phPLMmNrNkenU7ApPVaQ7eiS6IdWPRNnQpasTiNvcuCfqG8MrYS4BoEgua4MQzLUKtNcdu3bpqtlM13MsoOpBTUKXy8d5nv3HO47S7QXsJpE6VkRsjvShwwV/9CpGxl13gRj;4:B4hoWjX2mg6oFsWWoHTTQzegFA8nd6+aCSwNTmkt6y7NFHdnDM1iJhnQQg1oYSdiEEDHAQlETdQWKbC5oWRERqO2AqjTvkZkY+BtYlkmFfAvTPICnzc4CilQnkHqE6290Cv9W8ZNIlnKEVzJgh/sKJYFsSoFxyUUdw1ewB+wz4fFzn3xhqvVUaBFm8dExEzi//GHp/3RL8XJEopfoxOgDR7B8z1G6dcDKjljLij/eiZviAp6l4OI0FypAB4JZeQM5H6z0hdXIm3qxs7B7K3wr37C/oSVKy8Ke5grRxbrRwmOovrmkrqDJGoeLs224B/G6YZgyKaCv/9A9IzFdCLFK/6xldkDMJx2tq92KR+Ppmg=
X-Microsoft-Antispam-PRVS: <MWHPR12MB19191398A491160325204397F8AF0@MWHPR12MB1919.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1919;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1919;
X-Forefront-PRVS: 0621E7E436
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(39380400002)(199004)(189003)(2351001)(2906002)(66066001)(36756003)(52116002)(316002)(4326008)(51416003)(25786009)(7696005)(53416004)(97736004)(5660300001)(106356001)(16586007)(76176011)(68736007)(11346002)(2616005)(386003)(956004)(7736002)(86362001)(47776003)(575784001)(305945005)(446003)(966005)(186003)(2361001)(48376002)(72206003)(53936002)(1076002)(6116002)(6306002)(3846002)(16526019)(26005)(6486002)(50466002)(105586002)(81156014)(6916009)(8676002)(478600001)(50226002)(8936002)(81166006)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1919;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1919;23:ATmkV9Vy3bLFy+xZrJei/j6JUnv8XcYS+uReo2hmR?=
 =?us-ascii?Q?QA2DUdGrGQlk7mPh4IYMWZgRxa6nWhgmflhKiBFqSp9DbGe8wPYsC8dHt0hF?=
 =?us-ascii?Q?A5CzZP9QXV5Snq0hZMQgj60mr9NEk2aKm1BVWClIAGTjmxqzH5ZsEWsPWMGC?=
 =?us-ascii?Q?VWC4G24lwZYqfLrq6Zamg+e/OL6IiKdJaQTp7IcqTm54dJnegZ7vO4rYGwX6?=
 =?us-ascii?Q?IVjlb7zut2VNw1wU/0BBKNUO7Qa7m8Qb8RSK6Se0coR6fX/0f3SJMr81mpig?=
 =?us-ascii?Q?6/Wsy0JYtu1HR7rjkqaCYJjyy+Ti2/UXKPoc8WWmX9DM2nx7gJ8IJifBG/7u?=
 =?us-ascii?Q?6WcR14R/VqNqnmgqzhqxQl1BSgiYInj7qSDs8yMXqVkgq1b+j8vVpUc9fykm?=
 =?us-ascii?Q?gwnzlHa5jlFsZaIGavUyBxRpfEokudhw8seYuBQetcpkZf+Q9VrKNEx010N4?=
 =?us-ascii?Q?rMBoY1CZQUFTj5o4gF2YC6WDI3msI/l4rk1f0yiNcV65YRdX6vImpnQ1PVkQ?=
 =?us-ascii?Q?p6gKfU5lWd1ghUUDrEKFHRRmJwHokNpUn5ufhdlIB00ZMi0qeUmWQis3iLq/?=
 =?us-ascii?Q?SPhDILqmuxg4cvutJYJSjB54jNg6aG08PzxEA5o6sRR8vgW9Ypqoe/pzq7Bz?=
 =?us-ascii?Q?5R7NFen1Rw8spSK1boygUqvwihHtSXbKO1XCBUHtbsplUpZH8Sl63LCKM6+j?=
 =?us-ascii?Q?18ynDOXLu8MhpxpGasNpKgCh0FOqVVLlwsSyPbQaGA+orPyuFD2kJKjKeIkc?=
 =?us-ascii?Q?N8Bh1DSDFczH7CIw3+BTf6yQUxk4T1DsE5YwBCjaWPIVehbWFJ3JdK3wN+QA?=
 =?us-ascii?Q?k6+5NJya8ZVydfUBQ8W4USY+tmYJHctLVrwGvqZjskUmi2mVuDOB06LXFYBu?=
 =?us-ascii?Q?Y4Ws2z3/or+v+L2bw/6SIaJJ2vdi2JiN4D9XuzWgVmsGPiJWJ0j6ajABo8ZV?=
 =?us-ascii?Q?ECfvdizqyrhgoIfvhgDkFMptcwahIRpslJpDKG6nLbLaQpENfN/89znFJWug?=
 =?us-ascii?Q?et6ZVJ5t2hX+BBkwM4CLSvmalZSy6wyJcoJxiH2MfaHYzvkwGlp+PE2itS0D?=
 =?us-ascii?Q?ucxSWkFFpf4uhN7tsb9UelmJHspe4Rvf8aTFTQ36hAxk+15NmGWC9qFIJhLq?=
 =?us-ascii?Q?8+JJIVlFv/OCOhYBrNS9qKinamdIp7V2uh0FeWE65BXyOVV6oIC0ebTbI4o9?=
 =?us-ascii?Q?ug/F0++OdIeXmEEyPUXzA1TpwjFhNL2dz3566Xx03wTjdBYXCSl0/SKOsGVA?=
 =?us-ascii?Q?qM0o/UsoYxIEXPG/uVAxA9fSBXkXGmZtDaRw+g+CasXqGhe39uyR3R3GUbvn?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: HW2rkpo5d41JR0C4DoKo+YWTMlp/VWAIQeJhbRnkAKsBRlaee55FZLsOhDGA+wZpWwzuFMQJma4mTvR/PqqyOuf8cJqw/71TWjvz/dHw/QuOyRQq8YQngyRAl4tcU567IP/+0g4Wk7ldOJ1qM137NWLHqk5J+b0EED1JiCJoGnnHdaodrC57KxNBV1UoQ99V
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;6:7rS8oPlPGlrM8TrOG/FQmBlG7v22MlfceWpplMT2ZYK8Vvqj/Q2Ns2Njp8XMT+qsfGS82oTo6a0jCJOGmQcYto0CDRvh+kAoqvza/p0xWc2rNn5FTsDKqtAvjHqhB/VkuR0NDVmKNZj3954o7DPAUSC+FIB9Yznl0aRpYkTQeIdKG6lFgeQTOZxtCRf/hLGZ07fry9Cu3CzjQ3U2VAiQ36APgX5b7jEqcmZbxgrOfRyBwNW3FKY3pCiwuQbCOWrxnXRBocOfV2amhKSy6SKUfB/qzAYi7KlRKoPrwq6LuWguwEDxXODGE5BB3jmZUx+Tvhvite98i3tXqdKBQMnvPPQodu0PtugTe0Yj/I38aAFF6ViGEpdXjVQ67bbpo3TzEpz+bJbbovkvQ1HwivBX4XuHWsWX3Rhbkmt/iGpfR8T0MXWrLCc94purKXTIzdKFUQjTal0AQTBj5xeeh5Dd8w==;5:uXmfcMg6ae09uTRhzz9Ak7QXhor4cbDC6mFSSsV5BnxAK6YKNtH81vg/U/XfYbfSNVicTA/w2/EPIPlqNW2azy4+CInDJLRvMMFZ5kS8kIvdtD0AF8Gtw9I+XU3HhEFoB6cNiroZLZKbOjT9QzSv3C84VWSj1Jqhq3WvIncz128=;24:fksKngMaPzvOA6hAMJr2+L/TfoTghnIgLSzzhKoib7mbNUJ/vnDs4Y8WIRQ7AJgYJUG+3qMdhtfdOSwoyq+9bQF7iafLXHaqdgOyfabzXXI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;7:adWPqDm653+VmAuKR8iF6nl6MdWdbVPRKJGA61r3HPa/SU0zyZcL8d+PE0mxOY11xEp7WcxavWB0uoqBD/Eo4I/NLO6ODeKfBdu61y57iumFeFVjRY7nqH9pIQ6TNA/MgbsXCnSsbaAqLEAZU0b0XPLBle5eq9Ok/yA1wmiO5IJISiyrp35vvtD8K1dwNGKkdrahgLaejRRVnlX1n8Rihfff+skw5j4n8/jWXQvJmD1FTDEZpA2qLT4PhxL+KtoG;20:rW+AEN5YnG+SFgpwQjvyakUMyuQrddYVISAZos4pw9DcpIJ+T2LUXjWVeGSLeD7p+4BRIFSJQWlJdqjG0+ALtJ/yRt+Fn8JC1kJ1zLg0haBKH7rN006qajltXhuqVQ1ChUQjixuEmzH/tj5ehsvUhZuyEwwdLKqwJqLFJevaTP8arQnSGI3fN5UEGys3qh10q+drco6qMx7aQKRhonYuJfRTc1NYENEh+RTTny6GODX8dJVN+eFONCLxQcUR9FIg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2018 18:49:58.7040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad466c4-4fb4-4ff7-824a-08d591b80ba4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1919
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

Based on UEFI 2.7 Table 252. Processor Error Record.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180226193904.20532-3-Yazen.Ghannam@amd.com

v2->v3:
* Fix table number in commit message.
* Don't print raw validation bits.

v1->v2:
* Change config option depends to "X86" instead of "X86_32 || X64_64".
* Remove extra newline in Makefile changes.
* Drop author copyright line.

 drivers/firmware/efi/Kconfig    |  5 +++++
 drivers/firmware/efi/Makefile   |  1 +
 drivers/firmware/efi/cper-x86.c | 23 +++++++++++++++++++++++
 drivers/firmware/efi/cper.c     | 10 ++++++++++
 include/linux/cper.h            |  2 ++
 5 files changed, 41 insertions(+)
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
index 000000000000..863f0cd2a0ff
--- /dev/null
+++ b/drivers/firmware/efi/cper-x86.c
@@ -0,0 +1,23 @@
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
