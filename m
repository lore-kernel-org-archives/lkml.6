Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D99C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5DB21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="HeWTx1sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5DB21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeI0XQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:16:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35265 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeI0XQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:16:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id w4-v6so3128676ljd.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TsgMWFXn3m35qaNjoqwTMCKgzvWTscGjOTl33QCd3aY=;
        b=HeWTx1sMz5p67YsVMACBy2VqqCPyFC1B4D81X6u7f6iybil4ecf6tDcD9TpP4qYpUd
         2e0JJeBp/+atxM3hjaTj6IfD2pUyDsWty93ZT5MDOt+MwFMfKE9FB+AhlB2ZVSNPTXtD
         ZG/3FODmU+qwkPVBxu0eCKTIAKs35IVa2PUwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TsgMWFXn3m35qaNjoqwTMCKgzvWTscGjOTl33QCd3aY=;
        b=meMwoy3H0o9CCSqSp6oWA7DZ3dOwM7bL9dVkuBldbchKV5L6789/GoxVUP7O3qgox5
         91ViLmnk4vhJEIFz2CFQ7/UJyawuYw/D6bsc7ZpOM1lHE0IaHcbXPSNfwohUGzgGQVX4
         wJHQZCHzGfSyeV5LS0+SnZSPKXfZKXJyjX3x5RH0b9ALdDliyd//N1xMjNABA5eGMneW
         bxz2OarVuNnpn0kcOrHibXHJhZI46d1MEcl2O1RKqb2tivY08ePYHvs7zAcuAikcQkN9
         KnXLSzWI+EoxDtoebZ6iFve6Jrj3BeQZqTU/hMdy7YWfZaqESf3f/cd58R0k58AlGTeZ
         EfzA==
X-Gm-Message-State: ABuFfojTCtMhiL4YdV4kGJo4LNs+3VVJD7hGU3OKx7goxDrmhYWZqWTH
        Fz+H04ZrQ/YFT0rXWhNw5W1AbaCD08o=
X-Google-Smtp-Source: ACcGV60kOCxI6FfuDCq3qv5Ox+GoLiK+tV1MtqcePzSfH5ERoxv0il+RX0IDLtuvC+r9dmTmo7fmrA==
X-Received: by 2002:a2e:2d2:: with SMTP id y79-v6mr8382600lje.100.1538067434185;
        Thu, 27 Sep 2018 09:57:14 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id q75-v6sm515217lfq.95.2018.09.27.09.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 09:57:13 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] powerpc: convert to generic builtin command line
Date:   Thu, 27 Sep 2018 19:57:09 +0300
Message-Id: <1538067429-6047-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Walker <danielwa@cisco.com>

This updates the powerpc code to use the CONFIG_GENERIC_CMDLINE
option.

[maksym.kokhan@globallogic.com: add strlcat to prom_init_check.sh
whitelist]
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 arch/powerpc/Kconfig                   | 23 +----------------------
 arch/powerpc/kernel/prom.c             |  4 ++++
 arch/powerpc/kernel/prom_init.c        |  8 ++++----
 arch/powerpc/kernel/prom_init_check.sh |  2 +-
 4 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a806692..f87906a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -172,6 +172,7 @@ config PPC
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_CMDLINE
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
@@ -787,28 +788,6 @@ config PPC_DENORMALISATION
 	  Add support for handling denormalisation of single precision
 	  values.  Useful for bare metal only.  If unsure say Y here.
 
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-
-config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyS0,9600 console=tty0 root=/dev/sda2"
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel. For these platforms, you can supply
-	  some command-line options at build time by entering them here.  In
-	  most cases you will need to specify the root device here.
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	depends on CMDLINE_BOOL
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-
 config EXTRA_TARGETS
 	string "Additional default image types"
 	help
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index c4d7078..f8c6e63 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -34,6 +34,7 @@
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <linux/cpu.h>
+#include <linux/cmdline.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -716,6 +717,9 @@ void __init early_init_devtree(void *params)
 	 */
 	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
 
+	/* append and prepend any arguments built into the kernel. */
+	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
+
 	/* Scan memory nodes and rebuild MEMBLOCKs */
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 9b38a2e..e9214c6 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/bitops.h>
+#include <linux/cmdline.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/page.h>
@@ -634,11 +635,10 @@ static void __init early_cmdline_parse(void)
 	p = prom_cmd_line;
 	if ((long)prom.chosen > 0)
 		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
-#ifdef CONFIG_CMDLINE
+
 	if (l <= 0 || p[0] == '\0') /* dbl check */
-		strlcpy(prom_cmd_line,
-			CONFIG_CMDLINE, sizeof(prom_cmd_line));
-#endif /* CONFIG_CMDLINE */
+		cmdline_add_builtin(prom_cmd_line, NULL, sizeof(prom_cmd_line));
+
 	prom_printf("command line: %s\n", prom_cmd_line);
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index acb6b92..b1d7ca1 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -18,7 +18,7 @@
 
 WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
-__secondary_hold_acknowledge __secondary_hold_spinloop __start
+__secondary_hold_acknowledge __secondary_hold_spinloop __start strlcat
 strcmp strcpy strlcpy strlen strncmp strstr kstrtobool logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
 __prom_init_toc_start __prom_init_toc_end btext_setup_display TOC."
-- 
2.7.4

