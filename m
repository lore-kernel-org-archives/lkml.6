Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4077C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876F42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8biaPt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876F42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeLLMIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:08:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36710 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeLLMIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:08:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so17469220wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpF7vbnOFsXhLrb4aTwEuYmizpZRsEcIFhJoxX7Cs2o=;
        b=Z8biaPt4td1tZc4rFJfg5u+kcQeHJxmOj+0bpU2FUhXcVrcwMwQ+Z/VWXUZpuG7Fz0
         FyOgBxVPZ6UgFD0hwLl6aahH5yjG6/0bJEHloJgovFvE9Z9U82m9u6bwyWxXGKS71AZQ
         nfXDEyU15zJ7PocPMx5y7kri9hH5pRFzBzgaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpF7vbnOFsXhLrb4aTwEuYmizpZRsEcIFhJoxX7Cs2o=;
        b=bqebiPucxGF5dxSd34D5RH6aI/J9EfdrE+b7Gw02xQbzpBo9jyIGuGGqu0hncMLnKN
         dZFjENx3JPrMiFjt9QzbLIpXSNHakzg6zFBF129wK9JHlLhpxNbXFIlaxyF5bZugnJ29
         243DOfYymdxLpf1eiBgS0fOhhEKGJPdQzAoSB8r8M4znIEvT6xtJOITeKVfCi/ysqEZD
         ocH7bLhpnnh4sAEIgZWJeIJRU18aSBi5xnpV9YBiA7VdjaGkJBG0WPSv9dabsvSOoQOi
         3JK55dwqqURb2gVHVMEEIRZbUzzZvTQxslNAdzAihwXgvnVNsUJMt99YEtwnmiiosfym
         s+7Q==
X-Gm-Message-State: AA+aEWa7rjwb7WQK5OUukE1zCAMfafL1gTfNiiruL3KKUnRpvD55A2Nz
        F+TSREHC3vSJY8KcRLLY2SCinw==
X-Google-Smtp-Source: AFSGD/UCEBxqYi4ONoNgEGm95A5ReDGM5HlbiZVyIxlX+NdIQvn3Dt9nGmDG2LmE6rsJrjxKbCvQAA==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr18380673wrw.113.1544616528752;
        Wed, 12 Dec 2018 04:08:48 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:1db:abd7:f798:3277])
        by smtp.gmail.com with ESMTPSA id j8sm4748531wmd.0.2018.12.12.04.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 04:08:47 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ramana.Radhakrishnan@arm.com, linux-hardened@lists.openwall.com,
        keescook@chromium.org, labbott@fedoraproject.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3] arm64: enable per-task stack canaries
Date:   Wed, 12 Dec 2018 13:08:44 +0100
Message-Id: <20181212120844.19268-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the use of per-task stack canary values if GCC has
support for emitting the stack canary reference relative to the
value of sp_el0, which holds the task struct pointer in the arm64
kernel.

The $(eval) extends KBUILD_CFLAGS at the moment the make rule is
applied, which means asm-offsets.o (which we rely on for the offset
value) is built without the arguments, and everything built afterwards
has the options set.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v3: add all 3 options to the Kconfig cc-option check, to avoid relying on
    implementation defined logic in the compiler regarding which options
    need to appear together.

 arch/arm64/Kconfig                      |  7 +++++++
 arch/arm64/Makefile                     | 10 ++++++++++
 arch/arm64/include/asm/stackprotector.h |  3 ++-
 arch/arm64/kernel/asm-offsets.c         |  3 +++
 arch/arm64/kernel/process.c             |  2 +-
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab0330e3a..e355946cde97 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1272,6 +1272,13 @@ config RANDOMIZE_MODULE_REGION_FULL
 	  a limited range that contains the [_stext, _etext] interval of the
 	  core kernel, so branch relocations are always in range.
 
+config CC_HAVE_STACKPROTECTOR_SYSREG
+	def_bool $(cc-option,-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=0)
+
+config STACKPROTECTOR_PER_TASK
+	def_bool y
+	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6cb9fc7e9382..79d927542322 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -56,6 +56,16 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
+prepare: stack_protector_prepare
+stack_protector_prepare: prepare0
+	$(eval KBUILD_CFLAGS += -mstack-protector-guard=sysreg		  \
+				-mstack-protector-guard-reg=sp_el0	  \
+				-mstack-protector-guard-offset=$(shell	  \
+			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
+					include/generated/asm-offsets.h))
+endif
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
index 58d15be11c4d..5884a2b02827 100644
--- a/arch/arm64/include/asm/stackprotector.h
+++ b/arch/arm64/include/asm/stackprotector.h
@@ -34,7 +34,8 @@ static __always_inline void boot_init_stack_canary(void)
 	canary &= CANARY_MASK;
 
 	current->stack_canary = canary;
-	__stack_chk_guard = current->stack_canary;
+	if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
+		__stack_chk_guard = current->stack_canary;
 }
 
 #endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 323aeb5f2fe6..65b8afc84466 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -46,6 +46,9 @@ int main(void)
   DEFINE(TSK_TI_TTBR0,		offsetof(struct task_struct, thread_info.ttbr0));
 #endif
   DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
+#ifdef CONFIG_STACKPROTECTOR
+  DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
+#endif
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index d9a4c2d6dd8b..8a2d68f04e0d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -59,7 +59,7 @@
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
 
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
-- 
2.19.2

s
