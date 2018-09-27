Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE8DC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660422152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="Tr5QfC4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660422152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeI0XQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:16:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40569 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeI0XQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:16:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id r83-v6so3102374ljr.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ftajp3MRZ0PhsPnNocPMO/7ah4Nv3Xl7uHwrfu4Kndc=;
        b=Tr5QfC4ulzLivT/RK6l9+szS4DC34X0yNF40LAwMEddez8neCYlpVfTFImS5MUem0I
         NEoiJWx4ZrsyGlgkd4e1058sqTfFtkrKShKuy6ou0DPu1HPRASOpI8VL3+FE1O6AR1Wh
         qSAvWrGNYwmaM+6NnwqrKJC6MtcDfAOq+EMt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ftajp3MRZ0PhsPnNocPMO/7ah4Nv3Xl7uHwrfu4Kndc=;
        b=X62qMtyRuoaPRITInppuWxv4SqF+wVbnzrjRD9PeXXhhcv5DS51gcd4bvOCjS7uxw2
         EM9lZ2PyjqTDYD4OA4tgEi2Mh0A71JlquDkeNd4afdarMj4/BIptZGm/JB+dNdDcrxWF
         t6HtoqEfAlOi/5pDCNd5POZmBpjvwpr0UAEgv1/9paCp+LSpdB4DkwBi4/szmHT6WmhY
         ihY5KXZpCTpzMvJ3nrOUbZoeOb3XOWvJceDN0UvCl2tKy7ExX8lThz/t5aA4rpn9BTrJ
         vI+8N23bp3FC6TIWs6pc/yEZYheCajBEdmOyRV9RnNY0ghNlRnGvDUlSTi946Lh3N+DU
         otuQ==
X-Gm-Message-State: ABuFfoiM++AupZMPsMfVsg94sxP28A8dtLcmaItpSsoQflIbqmeLiO6o
        tDq+bj01vMPEOBVca8Yw24Vkug==
X-Google-Smtp-Source: ACcGV61CFRLfuQnVjytuyfdLK7Dqawg1KXozpeQknNt/GMK8V5QHWU3pMO57V3qUzqNHtxVMJajRQA==
X-Received: by 2002:a2e:2942:: with SMTP id u63-v6mr8258880lje.28.1538067413445;
        Thu, 27 Sep 2018 09:56:53 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id i9-v6sm388653ljg.43.2018.09.27.09.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 09:56:52 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH 6/8] arm64: convert to generic builtin command line
Date:   Thu, 27 Sep 2018 19:56:48 +0300
Message-Id: <1538067408-5967-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Walker <danielwa@cisco.com>

This updates the arm64 code to use the CONFIG_GENERIC_CMDLINE
option.

Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 arch/arm64/Kconfig        | 17 +----------------
 arch/arm64/kernel/setup.c |  3 +++
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e9..e596414 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -166,6 +166,7 @@ config ARM64
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select GENERIC_CMDLINE
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -1231,22 +1232,6 @@ config ARM64_ACPI_PARKING_PROTOCOL
 	  protocol even if the corresponding data is present in the ACPI
 	  MADT table.
 
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	help
-	  Provide a set of default command-line options at build time by
-	  entering them here. As a minimum, you should specify the the
-	  root device (e.g. root=/dev/nfs).
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-
 config EFI_STUB
 	bool
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 5b4fac4..33b929b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -42,6 +42,7 @@
 #include <linux/psci.h>
 #include <linux/sched/task.h>
 #include <linux/mm.h>
+#include <linux/cmdline.h>
 
 #include <asm/acpi.h>
 #include <asm/fixmap.h>
@@ -295,6 +296,8 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_machine_fdt(__fdt_pointer);
 
+	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
+
 	parse_early_param();
 
 	/*
-- 
2.7.4

