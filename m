Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE715C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF742159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="CAisdAFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF742159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeI0XPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:15:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45846 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0XPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:15:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id m80-v6so2709557lfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wePGE6ebuUMRF1UZ24scDXbz0jBXpRHjOqH5x1yjsjo=;
        b=CAisdAFK/21SPrX/wAhwfg92m5mHVqnzsdgokhkPeTnIdOjCtHRRe06LB72U5Zf41m
         1UT3enCJr4r18hXJgF2mteI2noqALJhwAbTFptBupEsZ4t8wmjuhmjWctWiOVbl2lCdJ
         8ts/uZ3RBEj3S8xy63rpnTzFTjhHiarqlGVJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wePGE6ebuUMRF1UZ24scDXbz0jBXpRHjOqH5x1yjsjo=;
        b=BdyUT6Amj1qEn8y+7YmtKWpr/MPtJizaRDOlxPNBVYvA0Ukt49IhZwvikbnlv5h7Qo
         sKwwdkEqY7p4tkYxwX5ryXG9xw8shbqylSQWCnJzTZTklibpW8IEDMNy8GMPCii6EYdw
         ExWS9N2GfU+xx4HQZ1kqUKbKcchbzrqQYM5VoQePVCfUktXyZleigbw7Gikc53fw+4/d
         oC4hucvsWf4NlykhJhMROMqXRA/t4U/lig+6S5abNqI5iz1boSbZIAocoyM7lVmwHmAs
         qIzsbP/tI16EAjLG7vqF4Shw2wDtzxSCwjOpFiSzQNqEXDuH8jRTai3Ou7XFDXWDDSGs
         628Q==
X-Gm-Message-State: ABuFfoj6HRQcN2trunldbPP4u2Hnsl0lNC0asHK+YJDAy6jxH+qly7qv
        m0gaj8l5OHJtq2s7XQS1h8eNAQ==
X-Google-Smtp-Source: ACcGV63xnfMnv1Ekr2odYzjsHosFJkNhC8GPFbcPJbzt4fGDydQqEVDK8w4v4iaJhLLAj4Z98Lkp+Q==
X-Received: by 2002:a19:974d:: with SMTP id z74-v6mr8398569lfd.17.1538067388007;
        Thu, 27 Sep 2018 09:56:28 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id u142-v6sm517933lff.14.2018.09.27.09.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 09:56:27 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] x86: convert to generic builtin command line
Date:   Thu, 27 Sep 2018 19:56:23 +0300
Message-Id: <1538067383-5881-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Walker <danielwa@cisco.com>

This updates the x86 code to use the CONFIG_GENERIC_CMDLINE
option.

Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 arch/x86/Kconfig        | 44 +-------------------------------------------
 arch/x86/kernel/setup.c | 19 +++----------------
 2 files changed, 4 insertions(+), 59 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be02..7821b23 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -96,6 +96,7 @@ config X86
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
 	select GENERIC_CLOCKEVENTS_MIN_ADJUST
 	select GENERIC_CMOS_UPDATE
+	select GENERIC_CMDLINE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
@@ -2327,49 +2328,6 @@ choice
 
 endchoice
 
-config CMDLINE_BOOL
-	bool "Built-in kernel command line"
-	---help---
-	  Allow for specifying boot arguments to the kernel at
-	  build time.  On some systems (e.g. embedded ones), it is
-	  necessary or convenient to provide some or all of the
-	  kernel boot arguments with the kernel itself (that is,
-	  to not rely on the boot loader to provide them.)
-
-	  To compile command line arguments into the kernel,
-	  set this option to 'Y', then fill in the
-	  boot arguments in CONFIG_CMDLINE.
-
-	  Systems with fully functional boot loaders (i.e. non-embedded)
-	  should leave this option set to 'N'.
-
-config CMDLINE
-	string "Built-in kernel command string"
-	depends on CMDLINE_BOOL
-	default ""
-	---help---
-	  Enter arguments here that should be compiled into the kernel
-	  image and used at boot time.  If the boot loader provides a
-	  command line at boot time, it is appended to this string to
-	  form the full kernel command line, when the system boots.
-
-	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
-	  change this behavior.
-
-	  In most cases, the command line (whether built-in or provided
-	  by the boot loader) should specify the device for the root
-	  file system.
-
-config CMDLINE_OVERRIDE
-	bool "Built-in command line overrides boot loader arguments"
-	depends on CMDLINE_BOOL
-	---help---
-	  Set this option to 'Y' to have the kernel ignore the boot loader
-	  command line, and use ONLY the built-in command line.
-
-	  This is used to work around broken boot loaders.  This should
-	  be set to 'N' under normal conditions.
-
 config MODIFY_LDT_SYSCALL
 	bool "Enable the LDT (local descriptor table)" if EXPERT
 	default y
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b4866ba..ee109f4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -51,6 +51,7 @@
 #include <linux/kvm_para.h>
 #include <linux/dma-contiguous.h>
 #include <xen/xen.h>
+#include <linux/cmdline.h>
 
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -221,9 +222,6 @@ unsigned long saved_video_mode;
 #define RAMDISK_LOAD_FLAG		0x4000
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
-#ifdef CONFIG_CMDLINE_BOOL
-static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
-#endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 struct edd edd;
@@ -934,20 +932,9 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = __pa_symbol(__bss_start);
 	bss_resource.end = __pa_symbol(__bss_stop)-1;
 
-#ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
-	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if (builtin_cmdline[0]) {
-		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
-#endif
-
+	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+
 	*cmdline_p = command_line;
 
 	/*
-- 
2.7.4

