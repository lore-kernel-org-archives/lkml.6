Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42C6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685432083A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="QGXPRkbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685432083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbeI0XPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:15:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34781 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeI0XPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:15:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10-v6so2778190lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1ZtvMOGJsToSgvSbhwJ/XujEKDeVLIKZQiHjiv/8h2w=;
        b=QGXPRkbrM4Gcq6YL2w4E4imslU3LMY2Xky62wopOmQcT+fjJHqT5/DDeMtOFjrl1YL
         3oJTUtFAM4al3ddkxx2sinktXmwLxukjfxZvxtVzOV01Xoq8n0bkCJX39B7S2rEfKJms
         LAdXejePD4zYjHMuRJDnqvX6LuMUf+eIl+wlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ZtvMOGJsToSgvSbhwJ/XujEKDeVLIKZQiHjiv/8h2w=;
        b=W+7rivDaI0jfhDYe/9AKhn6g2/+DkEAzXD+6WdMoiW5ILOuYMWvQOSQdycTeQSp1N6
         +FlQ15taDh+JdutHVDnHpd9qU3LRXGXSEaely2AWTBNOCTrgefAGZyQnc5gN/gKAlQx8
         UKul9YXXIIx4vZtCaQwio0RplL2SDIDtbpws8929wv3WNxxcmzx/5huu2q9jBj628980
         Fz34sceQOikdQBxKvW0q/yiDFBBqkNjbCnaMeJui9Sl32Co6dKkVixnPo+YGhS+Na4h7
         KECTZlwUCtntdaWZjCyDHJKrNf1ERuAdTmc4s0O/jFVLALbRYZmfgGa6Vt871emPBvZ6
         Rudg==
X-Gm-Message-State: ABuFfohWfNyDI2S+Bzs/LeEp+fXSe0rEw/LA7NS73RhcYlTKh1zsN0ud
        z/QnDZe6yU0Y8Ux27rZ0y9L9sw==
X-Google-Smtp-Source: ACcGV62rx3Va3DssJnjt2oDsI/d5XkTUvwyYEBPt/cGGTl/a81o+NAa/Xg+1AkwSFyo9oB7affsQvA==
X-Received: by 2002:a19:2c86:: with SMTP id s128-v6mr1055916lfs.153.1538067398505;
        Thu, 27 Sep 2018 09:56:38 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id j9-v6sm507348ljh.40.2018.09.27.09.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 09:56:38 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH 5/8] arm: convert to generic builtin command line
Date:   Thu, 27 Sep 2018 19:56:33 +0300
Message-Id: <1538067393-5926-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Walker <danielwa@cisco.com>

This updates the arm 32bit code to use the CONFIG_GENERIC_CMDLINE
option.

Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 arch/arm/Kconfig              | 38 +-------------------------------------
 arch/arm/kernel/atags_parse.c | 14 ++++----------
 arch/arm/kernel/devtree.c     |  2 ++
 3 files changed, 7 insertions(+), 47 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a..a1dca346d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -38,6 +38,7 @@ config ARM
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_CMDLINE
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
@@ -1924,43 +1925,6 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 
 endchoice
 
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	help
-	  On some architectures (EBSA110 and CATS), there is currently no way
-	  for the boot loader to pass arguments to the kernel. For these
-	  architectures, you should supply some command-line options at build
-	  time by entering them here. As a minimum, you should specify the
-	  memory size and the root device (e.g., mem=64M root=/dev/nfs).
-
-choice
-	prompt "Kernel command line type" if CMDLINE != ""
-	default CMDLINE_FROM_BOOTLOADER
-	depends on ATAGS
-
-config CMDLINE_FROM_BOOTLOADER
-	bool "Use bootloader kernel arguments if available"
-	help
-	  Uses the command-line options passed by the boot loader. If
-	  the boot loader doesn't provide any, the default kernel command
-	  string provided in CMDLINE will be used.
-
-config CMDLINE_EXTEND
-	bool "Extend bootloader kernel arguments"
-	help
-	  The command-line arguments provided by the boot loader will be
-	  appended to the default kernel command string.
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-endchoice
-
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
 	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index c10a3e8..4cf1c5b 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -24,6 +24,7 @@
 #include <linux/root_dev.h>
 #include <linux/screen_info.h>
 #include <linux/memblock.h>
+#include <linux/cmdline.h>
 
 #include <asm/setup.h>
 #include <asm/system_info.h>
@@ -32,7 +33,7 @@
 
 #include "atags.h"
 
-static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
+static char default_command_line[COMMAND_LINE_SIZE] __initdata;
 
 #ifndef MEM_SIZE
 #define MEM_SIZE	(16*1024*1024)
@@ -124,16 +125,9 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
 
 static int __init parse_tag_cmdline(const struct tag *tag)
 {
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
 	strlcat(default_command_line, tag->u.cmdline.cmdline,
 		COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	pr_warn("Ignoring tag cmdline (using the default kernel command line)\n");
-#else
-	strlcpy(default_command_line, tag->u.cmdline.cmdline,
-		COMMAND_LINE_SIZE);
-#endif
+
 	return 0;
 }
 
@@ -228,7 +222,7 @@ setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 	}
 
 	/* parse_early_param needs a boot_command_line */
-	strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);
+	cmdline_add_builtin(boot_command_line, from, COMMAND_LINE_SIZE);
 
 	return mdesc;
 }
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index ecaa68d..85442b5 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -19,6 +19,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/smp.h>
+#include <linux/cmdline.h>
 
 #include <asm/cputype.h>
 #include <asm/setup.h>
@@ -258,6 +259,7 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 		mdesc->dt_fixup();
 
 	early_init_dt_scan_nodes();
+	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
 
 	/* Change machine number to match the mdesc we're using */
 	__machine_arch_type = mdesc->nr;
-- 
2.7.4

