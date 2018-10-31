Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3807A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3807A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeJaTd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:33:56 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:36343 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727852AbeJaTd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:33:56 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9VAaaN0095832;
        Wed, 31 Oct 2018 18:36:36 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 31 Oct 2018
 18:35:39 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>
CC:     <arnd@arndb.de>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <greentime@andestech.com>,
        <alankao@andestech.com>, <vincentc@andestech.com>,
        <zong@andestech.com>, <deanbo422@gmail.com>
Subject: [RFC 1/2] RISC-V: An infrastructure to add vendor-specific code.
Date:   Wed, 31 Oct 2018 18:35:29 +0800
Message-ID: <1540982130-28248-2-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
References: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9VAaaN0095832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  RISC-V permits each vendor to develop respective extension ISA based on
RISC-V standard ISA. This means that these vendor-specific features may be
compatible to their compiler and CPU. Therefore, each vendor may be
considered a sub-architecture of RISC-V. Currently, vendors do not have the
appropriate examples to add these specific features to the kernel. In this
commit, we propose an infrastructure that vendor can easily hook their
specific features into kernel. This infrastructure is developed based on
the following 3 ideas:

1. Keep code readable
     All vendors use the same condition to control the flow of program in
   RISC-V generic port instead of vendor-defined kernel configuration.

2. Vendor can easily add features without considering other vendors.

3. Even if the CPU vendor in kernel configuration does not match the CPU
   vendor on platform, the kernel still can work.

This infrastructure can be divided into 3 parts as below.

A. Folder structure
     We consider each vendor as a sub-architecture of RISC-V. Hence, we
   plane to centralize vendor-dependent code, including source file and
   header file, into respective folder which is located at
   arch/riscv/<vendor>. Like the general architecture, the header files
   are located in arch/riscv/<vendor>/include/asm and
   arch/riscv/<vendor>/include/uapi.

B. Include vendor's file at compile time
   B.1 Vendor's Kconfig
         Vendor can define the needed kernel configuration here. For
       this infrastructure to work properly, user needs to define the
       macro CONFIG_VENDOR_ID and CONFIG_VENDOR_FOLDER_NAME as JEDEC
       manufacturer ID and the name of the vendor folder in this Kconfig.
   B.2 Vendor's source file
         The folder name of the selected vendor is recorded in macro
       CONFIG_VENDOR_FOLDER_NAME. To ensure that compiler only compiles the
       code of the selected vendor, it is only include the Makefile placed
       in CONFIG_VENDOR_FOLDER_NAME.
   B.3 Vendor's header file
         The searching order of vendor's folder is prior to riscv generic
       folder. This design enables vendors to replace the riscv
       generic header file with self-defined header file. Nevertheless,
       vendor can still include the contents of riscv generic header file
       by "include_next".
         The vendor-hook.h is the only exception that cannot be replaced
       because other vendors define their specific function as a dummy
       function here for linkage.

C. Check compatibility in run time
     To avoid kernel panic by incompatible CPU, the compatibility check
   is needed before entering vendor-specific function. We think the
   compatibility check here only needs to ensure that the vendor can safely
   call self-checking mechanism. Hence, the macro
   CHECK_VENDOR_XEXT_ISA_COMPATIBLE which is used to check compatibility
   only compares the vendor's JEDEC manufacturer ID with the content of csr
   $mvendorid.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/Kconfig                              |   49 +++++++++++++++++++++++
 arch/riscv/Makefile                             |    6 +++
 arch/riscv/include/asm/sbi.h                    |    5 ++
 arch/riscv/include/asm/vendor-hook.h            |   13 ++++++
 arch/riscv/kernel/cpufeature.c                  |    5 ++
 arch/riscv/kernel/setup.c                       |    6 ++-
 arch/riscv/vendor-nds/Kconfig                   |   29 +++++++++++++
 arch/riscv/vendor-nds/Makefile                  |    1 +
 arch/riscv/vendor-nds/include/asm/vendor-hook.h |    8 ++++
 arch/riscv/vendor-nds/setup.c                   |    9 ++++
 10 files changed, 130 insertions(+), 1 deletions(-)
 create mode 100644 arch/riscv/include/asm/vendor-hook.h
 create mode 100644 arch/riscv/vendor-nds/Kconfig
 create mode 100644 arch/riscv/vendor-nds/Makefile
 create mode 100644 arch/riscv/vendor-nds/include/asm/vendor-hook.h
 create mode 100644 arch/riscv/vendor-nds/setup.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b008b34..a54a115 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -209,6 +209,55 @@ config RISCV_BASE_PMU
 
 endmenu
 
+choice
+	prompt "non-standard extension ISA"
+	default PURE_STANDARD_EXTENSION_ISA
+	help
+	  Select a CPU IP vendor used on the target platform. The features
+          of the extension ISA from selected vendor will be enabled.
+
+	  If you just need RISCV standard ISA, please select 'none'
+
+config RISCV_NDS
+	bool "AndeStar RISC-V ISA support"
+	select SUPPORT_X_EXTENSION_ISA
+	help
+	  Say Y here if you plan to run kernel on the AndeStar RISC-V CPU
+	  and use some of the specific features provided by the AndeStar RISC-V
+	  CPU such as cctl and non-cache coherent agent support.
+
+	  If the CPU used by the target platform is an AndeStar RISC-V CPU but you
+	  don't know what to do here, say Y.
+
+config PURE_STANDARD_EXTENSION_ISA
+	bool "none"
+
+endchoice
+config SUPPORT_X_EXTENSION_ISA
+	bool
+	depends on !PURE_STANDARD_EXTENSION_ISA
+	default n
+	help
+          The statement 'Y' means vendor-provided extension ISA is enabled in
+	  kerenl.
+
+config VENDOR_FOLDER_NAME
+	string
+	depends on SUPPORT_X_EXTENSION_ISA
+        help
+	  The name of the vendor folder in ./arch/riscv. Makefile will use
+          CONFIG_VENDOR_FOLDER_NAME to search the required header file.
+
+config VENDOR_ID
+	hex
+	depends on SUPPORT_X_EXTENSION_ISA
+        help
+	  The JEDEC manufacturer ID of CPU IP vendor. This will be used to
+	  check the compatibility between the kernel and the platform by
+	  comparing $mvendorid and CONFIG_VENDOR_ID.
+
+source "arch/riscv/vendor-nds/Kconfig"
+
 endmenu
 
 menu "Kernel type"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 61ec424..8616aa9 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -80,6 +80,12 @@ head-y := arch/riscv/kernel/head.o
 
 core-y += arch/riscv/kernel/ arch/riscv/mm/
 
+ifeq ($(CONFIG_SUPPORT_X_EXTENSION_ISA),y)
+riscv-vendor-name := $(CONFIG_VENDOR_FOLDER_NAME:"%"=%)
+LINUXINCLUDE := -I$(srctree)/arch/riscv/$(riscv-vendor-name)/include $(LINUXINCLUDE)
+core-$(CONFIG_RISCV_NDS) += arch/riscv/$(riscv-vendor-name)/
+endif
+
 libs-y += arch/riscv/lib/
 
 all: vmlinux
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index b6bb10b..5e1abf6 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -25,6 +25,7 @@
 #define SBI_REMOTE_SFENCE_VMA 6
 #define SBI_REMOTE_SFENCE_VMA_ASID 7
 #define SBI_SHUTDOWN 8
+#define SBI_GET_MVENDOR_ID 10
 
 #define SBI_CALL(which, arg0, arg1, arg2) ({			\
 	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
@@ -97,4 +98,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 	SBI_CALL_1(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask);
 }
 
+static inline unsigned long sbi_get_mvendorid(void)
+{
+	return SBI_CALL_0(SBI_GET_MVENDOR_ID);
+}
 #endif
diff --git a/arch/riscv/include/asm/vendor-hook.h b/arch/riscv/include/asm/vendor-hook.h
new file mode 100644
index 0000000..fbf0f1f
--- /dev/null
+++ b/arch/riscv/include/asm/vendor-hook.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 Andes Technology Corporation */
+#include <linux/string.h>
+
+#define CHECK_VENDOR_XEXT_ISA_COMPATIBLE			\
+	((IS_ENABLED(CONFIG_SUPPORT_X_EXTENSION_ISA)) &&	\
+	(mvendorid == CONFIG_VENDOR_ID))
+
+extern unsigned long mvendorid;
+
+#ifndef SETUP_VENDOR_EXTENSION
+#define setup_vendor_extension(x) do {} while (0)
+#endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 17011a8..2794cae 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -20,8 +20,10 @@
 #include <linux/of.h>
 #include <asm/processor.h>
 #include <asm/hwcap.h>
+#include <asm/sbi.h>
 
 unsigned long elf_hwcap __read_mostly;
+unsigned long mvendorid;
 
 void riscv_fill_hwcap(void)
 {
@@ -58,4 +60,7 @@ void riscv_fill_hwcap(void)
 		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
 
 	pr_info("elf_hwcap is 0x%lx", elf_hwcap);
+
+	mvendorid = sbi_get_mvendorid();
+
 }
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index b2d26d9..2dcfb21 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -38,6 +38,7 @@
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
+#include <asm/vendor-hook.h>
 
 #ifdef CONFIG_EARLY_PRINTK
 static void sbi_console_write(struct console *co, const char *buf,
@@ -228,7 +229,6 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 	unflatten_device_tree();
 	swiotlb_init(1);
-
 #ifdef CONFIG_SMP
 	setup_smp();
 #endif
@@ -238,5 +238,9 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	riscv_fill_hwcap();
+
+	if (CHECK_VENDOR_XEXT_ISA_COMPATIBLE)
+		setup_vendor_extension();
+
 }
 
diff --git a/arch/riscv/vendor-nds/Kconfig b/arch/riscv/vendor-nds/Kconfig
new file mode 100644
index 0000000..19fd485
--- /dev/null
+++ b/arch/riscv/vendor-nds/Kconfig
@@ -0,0 +1,29 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+config VENDOR_FOLDER_NAME
+	string
+	depends on RISCV_NDS
+        default 'vendor-nds'
+
+config VENDOR_ID
+	hex
+	depends on RISCV_NDS
+        default 0x31e
+
+config DMA_NONCOHERENT_OPS
+	bool "support DMA consistent memory without cache coherency agent"
+	def_bool y
+	depends on RISCV_NDS
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	help
+	  Say Y here if the cache coherent agent is unsupported.
+	  For some AndeStar RISC-V CPU, the MSB of physical address is used to
+	  disable the cachebility of this address if the cache coherent agent
+	  is unspported. To make this feature work, DMA_NONCOHERENT_OPS shall be
+	  Y to enable needed address translation.
+
+	  Say N here If cache coherent agent is supported.
+
diff --git a/arch/riscv/vendor-nds/Makefile b/arch/riscv/vendor-nds/Makefile
new file mode 100644
index 0000000..392275e
--- /dev/null
+++ b/arch/riscv/vendor-nds/Makefile
@@ -0,0 +1 @@
+obj-y += cache.o noncoherent_dma.o setup.o
diff --git a/arch/riscv/vendor-nds/include/asm/vendor-hook.h b/arch/riscv/vendor-nds/include/asm/vendor-hook.h
new file mode 100644
index 0000000..2876c24
--- /dev/null
+++ b/arch/riscv/vendor-nds/include/asm/vendor-hook.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 Andes Technology Corporation */
+#ifdef CONFIG_SUPPORT_X_EXTENSION_ISA
+#define SETUP_VENDOR_EXTENSION
+extern void setup_vendor_extension(void);
+#endif
+
+#include_next <asm/vendor-hook.h>
diff --git a/arch/riscv/vendor-nds/setup.c b/arch/riscv/vendor-nds/setup.c
new file mode 100644
index 0000000..5ceed1b
--- /dev/null
+++ b/arch/riscv/vendor-nds/setup.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Andes Technology Corporation
+#include <linux/init.h>
+#include <asm/vendor-hook.h>
+bool riscv_nds_compat_platform;
+void __init setup_vendor_extension(void)
+{
+	riscv_nds_compat_platform = true;
+}
-- 
1.7.1

