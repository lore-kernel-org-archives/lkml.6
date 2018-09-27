Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FE3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF072152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="BBtRrEkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF072152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeI0XQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:16:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47000 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeI0XQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:16:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so3068103ljj.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yAdmjlABFkyv+QF9qUSIDC249XTUAlUrKbFPBFHCP0w=;
        b=BBtRrEkhY8xITOAqAoEUOEPnMXLJNY+lKsxOAkVAmU0bXEfdSVECsG9sbonRWnRgk2
         1wbb3c5AvRzcfqh4yCLgdpR/eDePjdjDTJh9SDt83Etf6iLYGmHzxYVpQWQE8aS88wc6
         ot0uQ98vZI1KQRp0qAF3ZrL1GhyuxrxQuVg4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yAdmjlABFkyv+QF9qUSIDC249XTUAlUrKbFPBFHCP0w=;
        b=ipNeVv+htulB1NubP7iPRsw2H24Imk5FY24vpczRS4CKr/uZwizoVC0XnBIW1fsnn9
         mIT9kPKgx/4DGQHFeo5BAIIDcRY0BSaphKoa33uL2fsX/KotMcThoda+poak9YLu9frf
         fCLAmNZw4RNYXYw3F3tFDYbpOyRXk3fMMS1kGEy7VoTuLfafh/cZL6r913t3eaxc2cFc
         QiANtFQcGJ+WrM11nRp36ZsAtXKcaO3jhEualDJIC9HR6l2pHaJ16QIIf/9YFGwQU+Pj
         mBW9q2zSAaKKMloZeBodKEA5rP4uXAkBlw1mBBfsNbc3eoQv/7PNAgMkTi3jVU1LjWX/
         7H0A==
X-Gm-Message-State: ABuFfohzz+/QKTgFQFAgcLW4fodLgaL0zRbzvr4F2xLVasdK1MOK3K8A
        CctPh7SuEVp0mIhkZk4eqKM3PQ==
X-Google-Smtp-Source: ACcGV61CiICCVPMarvsnNxFI+W0nPc6sF3ekulqzLWVpQvlh1fkNKz9055S9AdQyMaCyEq99NcUcGA==
X-Received: by 2002:a2e:54b:: with SMTP id 72-v6mr8929875ljf.152.1538067422895;
        Thu, 27 Sep 2018 09:57:02 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id 3-v6sm512811ljs.69.2018.09.27.09.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 09:57:02 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] mips: convert to generic builtin command line
Date:   Thu, 27 Sep 2018 19:56:57 +0300
Message-Id: <1538067417-6007-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Walker <danielwa@cisco.com>

This updates the mips code to use the CONFIG_GENERIC_CMDLINE
option.

[maksym.kokhan@globallogic.com: remove new mips arch-specific
command line implementation]
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 arch/mips/Kconfig        | 24 +-----------------------
 arch/mips/Kconfig.debug  | 47 -----------------------------------------------
 arch/mips/kernel/setup.c | 41 +++--------------------------------------
 3 files changed, 4 insertions(+), 108 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3551199..642e31b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -78,6 +78,7 @@ config MIPS
 	select RTC_LIB if !MACH_LOONGSON64
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
+	select GENERIC_CMDLINE
 
 menu "Machine selection"
 
@@ -2942,29 +2943,6 @@ choice
 		  if you don't intend to always append a DTB.
 endchoice
 
-choice
-	prompt "Kernel command line type" if !CMDLINE_OVERRIDE
-	default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATH79 && !MACH_INGENIC && \
-					 !MIPS_MALTA && \
-					 !CAVIUM_OCTEON_SOC
-	default MIPS_CMDLINE_FROM_BOOTLOADER
-
-	config MIPS_CMDLINE_FROM_DTB
-		depends on USE_OF
-		bool "Dtb kernel arguments if available"
-
-	config MIPS_CMDLINE_DTB_EXTEND
-		depends on USE_OF
-		bool "Extend dtb kernel arguments with bootloader arguments"
-
-	config MIPS_CMDLINE_FROM_BOOTLOADER
-		bool "Bootloader kernel arguments if available"
-
-	config MIPS_CMDLINE_BUILTIN_EXTEND
-		depends on CMDLINE_BOOL
-		bool "Extend builtin kernel arguments with bootloader arguments"
-endchoice
-
 endmenu
 
 config LOCKDEP_SUPPORT
diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 0c86b2a..bcf11c2 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -30,53 +30,6 @@ config EARLY_PRINTK_8250
 config USE_GENERIC_EARLY_PRINTK_8250
 	bool
 
-config CMDLINE_BOOL
-	bool "Built-in kernel command line"
-	default n
-	help
-	  For most systems, it is firmware or second stage bootloader that
-	  by default specifies the kernel command line options.  However,
-	  it might be necessary or advantageous to either override the
-	  default kernel command line or add a few extra options to it.
-	  For such cases, this option allows you to hardcode your own
-	  command line options directly into the kernel.  For that, you
-	  should choose 'Y' here, and fill in the extra boot arguments
-	  in CONFIG_CMDLINE.
-
-	  The built-in options will be concatenated to the default command
-	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
-	  command line will be ignored and replaced by the built-in string.
-
-	  Most MIPS systems will normally expect 'N' here and rely upon
-	  the command line from the firmware or the second-stage bootloader.
-
-config CMDLINE
-	string "Default kernel command string"
-	depends on CMDLINE_BOOL
-	default ""
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel.  For these platforms, and for the cases
-	  when you want to add some extra options to the command line or ignore
-	  the default command line, you can supply some command-line options at
-	  build time by entering them here.  In other cases you can specify
-	  kernel args so that you don't have to set them up in board prom
-	  initialization routines.
-
-	  For more information, see the CMDLINE_BOOL and CMDLINE_OVERRIDE
-	  options.
-
-config CMDLINE_OVERRIDE
-	bool "Built-in command line overrides firmware arguments"
-	default n
-	depends on CMDLINE_BOOL
-	help
-	  By setting this option to 'Y' you will have your kernel ignore
-	  command line arguments from firmware or second stage bootloader.
-	  Instead, the built-in command line will be used exclusively.
-
-	  Normally, you will choose 'N' here.
-
 config SB1XXX_CORELIS
 	bool "Corelis Debugger"
 	depends on SIBYTE_SB1xxx_SOC
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c71d1eb..60638dd 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -28,6 +28,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/decompress/generic.h>
 #include <linux/of_fdt.h>
+#include <linux/cmdline.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -68,10 +69,6 @@ struct boot_mem_map boot_mem_map;
 static char __initdata command_line[COMMAND_LINE_SIZE];
 char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
 
-#ifdef CONFIG_CMDLINE_BOOL
-static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
-#endif
-
 /*
  * mips_io_port_base is the begin of the address space to which x86 style
  * I/O ports are mapped.
@@ -835,45 +832,11 @@ static void __init request_crashkernel(struct resource *res)
 }
 #endif /* !defined(CONFIG_KEXEC)  */
 
-#define USE_PROM_CMDLINE	IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
-#define USE_DTB_CMDLINE		IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
-#define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND)
-#define BUILTIN_EXTEND_WITH_PROM	\
-	IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND)
-
 static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
 
-#if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
-	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
-	    (USE_DTB_CMDLINE && !boot_command_line[0]))
-		strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
-
-	if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
-		if (boot_command_line[0])
-			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
-	}
-
-#if defined(CONFIG_CMDLINE_BOOL)
-	if (builtin_cmdline[0]) {
-		if (boot_command_line[0])
-			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-		strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-
-	if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
-		if (boot_command_line[0])
-			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
-#endif
-
 	/* call board setup routine */
 	plat_mem_setup();
 
@@ -893,6 +856,8 @@ static void __init arch_mem_init(char **cmdline_p)
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
 
+	cmdline_add_builtin(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
-- 
2.7.4

