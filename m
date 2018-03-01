Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033066AbeCARH0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:07:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53465 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032742AbeCARHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:07:24 -0500
X-Google-Smtp-Source: AG47ELuFRc3GCARtUaW//N3W0hwIzhfJ+PJ8z4Icdlc0zQeHda762WQ20K1Fz3Ro1YNx5WHiqIl0xg==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc: Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kasan, arm64: clean up KASAN_SHADOW_SCALE_SHIFT usage
Date: Thu,  1 Mar 2018 18:07:12 +0100
Message-Id: <44281e784702443f06edb837ec672984783a9621.1519923749.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up patch to the series I sent recently that cleans up
KASAN_SHADOW_SCALE_SHIFT usage (which value was hardcoded and scattered
all over the code). This fixes the one place that I forgot to fix.

The change is purely aesthetical, instead of hardcoding the value for
KASAN_SHADOW_SCALE_SHIFT in arch/arm64/Makefile, an appropriate variable
is declared and used.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b481b4a7c011..4bb18aee4846 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -97,12 +97,14 @@ else
 TEXT_OFFSET := 0x00080000
 endif
 
-# KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - 3)) - (1 << 61)
+# KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
+#				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
 # in 32-bit arithmetic
+KASAN_SHADOW_SCALE_SHIFT := 3
 KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
-			(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
-			+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - 3)) \
-			- (1 << (64 - 32 - 3)) )) )
+	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
+	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
+	- (1 << (64 - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) )) )
 
 export	TEXT_OFFSET GZFLAGS
 
-- 
2.16.2.395.g2e18187dfd-goog
