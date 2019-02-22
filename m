Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C58DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0691120675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfBVS27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:28:59 -0500
Received: from foss.arm.com ([217.140.101.70]:38698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfBVS27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:28:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8879D80D;
        Fri, 22 Feb 2019 10:28:58 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 55DB33F5C1;
        Fri, 22 Feb 2019 10:28:57 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] kasan: prevent recursive instrumentation
Date:   Fri, 22 Feb 2019 18:28:51 +0000
Message-Id: <20190222182851.21174-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_KASAN is selected, <linux/kasan-checks.h> defines the
prototypes for kasan_check_{read,write}(), rather than inline stubs.

This is the case even when it is included by files which are not
instrumented by KASAN. Where helpers (e.g. the atomics) are instrumented
with explicit calls to kasan_check_{read,write}(), this results in files
being unexpectedly instrumented.

This is problematic as it can result in instrumentation in files which
cannot safely call these functions, such as within the EFI stub:

[mark@lakrids:~/src/linux]% usekorg 8.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -j64 -s
drivers/firmware/efi/libstub/arm-stub.stub.o: In function `atomic_set':
/home/mark/src/linux/./include/asm-generic/atomic-instrumented.h:44: undefined reference to `__efistub_kasan_check_write'
/home/mark/src/linux/./include/asm-generic/atomic-instrumented.h:44:(.init.text+0xa0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__efistub_kasan_check_write'
Makefile:1021: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Let's avoid this by ensuring that uninstrumented files are given the
same stub definition of these functions used for !KASAN builds. So that
the stub defintions don't conflict with the real definitions in
(uninstrumented) common KASAN code, the real definitions are prefixed
with underscores, and called from unprefixed macros.

Any compiler-generated instrumentation uses separate
__asan_{load,store}_*() entry points, and is not affected by this
change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kasan-checks.h | 8 +++++---
 mm/kasan/common.c            | 8 ++++----
 scripts/Makefile.kasan       | 2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

Hi,

Assuming the KASAN folk are happy with this, I'd like this to be queued in the
tip tree, where the arm64 instrumented atomics are already queued.

Thanks,
Mark.

diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index d314150658a4..6cf4b41a5393 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -2,9 +2,11 @@
 #ifndef _LINUX_KASAN_CHECKS_H
 #define _LINUX_KASAN_CHECKS_H
 
-#ifdef CONFIG_KASAN
-void kasan_check_read(const volatile void *p, unsigned int size);
-void kasan_check_write(const volatile void *p, unsigned int size);
+#if defined(CONFIG_KASAN) && !defined (KASAN_NOSANITIZE)
+void __kasan_check_read(const volatile void *p, unsigned int size);
+#define kasan_check_read __kasan_check_read
+void __kasan_check_write(const volatile void *p, unsigned int size);
+#define kasan_check_write __kasan_check_write
 #else
 static inline void kasan_check_read(const volatile void *p, unsigned int size)
 { }
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 73c9cbfdedf4..630e32838adb 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -95,17 +95,17 @@ void kasan_disable_current(void)
 	current->kasan_depth--;
 }
 
-void kasan_check_read(const volatile void *p, unsigned int size)
+void __kasan_check_read(const volatile void *p, unsigned int size)
 {
 	check_memory_region((unsigned long)p, size, false, _RET_IP_);
 }
-EXPORT_SYMBOL(kasan_check_read);
+EXPORT_SYMBOL(__kasan_check_read);
 
-void kasan_check_write(const volatile void *p, unsigned int size)
+void __kasan_check_write(const volatile void *p, unsigned int size)
 {
 	check_memory_region((unsigned long)p, size, true, _RET_IP_);
 }
-EXPORT_SYMBOL(kasan_check_write);
+EXPORT_SYMBOL(__kasan_check_write);
 
 #undef memset
 void *memset(void *addr, int c, size_t len)
diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 25c259df8ffa..c475a8ac776c 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -52,5 +52,5 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
 endif # CONFIG_KASAN_SW_TAGS
 
 ifdef CONFIG_KASAN
-CFLAGS_KASAN_NOSANITIZE := -fno-builtin
+CFLAGS_KASAN_NOSANITIZE := -fno-builtin -DKASAN_NOSANITIZE
 endif
-- 
2.11.0

