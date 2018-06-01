Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeFAIJX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:09:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43867 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeFAIJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:09:12 -0400
X-Google-Smtp-Source: ADUXVKIEDLKVaGPnXNt+ceO98EeWvINAmeEX1w1sM9fCrj9aRpL0MhrVdc/gV1UMQBsb7BolCHSEPA==
From: Jun Yao <yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        greg@kroah.com
Subject: [PATCH 3/4] arm64/mm: make tramp_pg_dir and swapper_pg_dir adjacent
Date: Fri,  1 Jun 2018 16:09:03 +0800
Message-Id: <20180601080903.11868-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To defense KSMA, we need to migrate tramp_pg_dir and swapper_pg_dir
together. Make them adjacent to avoid modifying tramp_(un)map_kernel.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/entry.S       | 4 ++--
 arch/arm64/kernel/vmlinux.lds.S | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ec2ee720e33e..b35425feaf56 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1004,7 +1004,7 @@ __ni_sys_trace:
 
 	.macro tramp_map_kernel, tmp
 	mrs	\tmp, ttbr1_el1
-	add	\tmp, \tmp, #(PAGE_SIZE + RESERVED_TTBR0_SIZE)
+	add	\tmp, \tmp, #(PAGE_SIZE)
 	bic	\tmp, \tmp, #USER_ASID_FLAG
 	msr	ttbr1_el1, \tmp
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
@@ -1023,7 +1023,7 @@ alternative_else_nop_endif
 
 	.macro tramp_unmap_kernel, tmp
 	mrs	\tmp, ttbr1_el1
-	sub	\tmp, \tmp, #(PAGE_SIZE + RESERVED_TTBR0_SIZE)
+	sub	\tmp, \tmp, #(PAGE_SIZE)
 	orr	\tmp, \tmp, #USER_ASID_FLAG
 	msr	ttbr1_el1, \tmp
 	/*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 605d1b60469c..3c72e6dec890 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -219,15 +219,16 @@ SECTIONS
 	idmap_pg_dir = .;
 	. += IDMAP_DIR_SIZE;
 
+#ifdef CONFIG_ARM64_SW_TTBR0_PAN
+	reserved_ttbr0 = .;
+	. += RESERVED_TTBR0_SIZE;
+#endif
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	tramp_pg_dir = .;
 	. += PAGE_SIZE;
 #endif
 
-#ifdef CONFIG_ARM64_SW_TTBR0_PAN
-	reserved_ttbr0 = .;
-	. += RESERVED_TTBR0_SIZE;
-#endif
 	swapper_pg_dir = .;
 	. += SWAPPER_DIR_SIZE;
 	swapper_pg_end = .;
-- 
2.17.0
