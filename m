Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969023AbeE3JNf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:13:35 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45852 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968885AbeE3JNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:13:22 -0400
X-Google-Smtp-Source: ADUXVKJljISaGv8L6q2/txAmgRiVDNfR/PRoMYtgbqHSqJAJ9ISR0vYFriJrU5mtyN6kryTHi7zXaw==
From: YaoJun <yaojun8558363@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: [PATCH 3/4] arm64/mm: migrate swapper_pg_dir
Date: Wed, 30 May 2018 17:12:58 +0800
Message-Id: <20180530091259.9386-4-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530091259.9386-1-yaojun8558363@gmail.com>
References: <20180530091259.9386-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make tramp_pg_dir and swapper_pg_dir adjacent. So we can migrate
them together.

Signed-off-by: YaoJun <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/entry.S       |  4 ++--
 arch/arm64/kernel/vmlinux.lds.S | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

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
index 0221aca6493d..a094156e05a4 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -219,15 +219,15 @@ SECTIONS
 	idmap_pg_dir = .;
 	. += IDMAP_DIR_SIZE;
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
-#endif
-
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	reserved_ttbr0 = .;
 	. += RESERVED_TTBR0_SIZE;
 #endif
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	tramp_pg_dir = .;
+	. += PAGE_SIZE;
+#endif
 	swapper_pg_dir = .;
 	. += SWAPPER_DIR_SIZE;
 	swapper_pg_end = .;
-- 
2.17.0
