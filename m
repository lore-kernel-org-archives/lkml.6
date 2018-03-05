Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCEOeQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:34:16 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44213 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbeCEOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:34:10 -0500
X-Google-Smtp-Source: AG47ELu7pMyjFLI0ZyLskSSPlF2UL8GCpN2OioCrkbgwBXQDXg3dFS+labAejARzLToeqF2MAGX8nA==
From: Anders Roxell <anders.roxell@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@armlinux.org.uk, arnd@arndb.de,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3] arch/arm/Kconfig: default ARM_MODULE_PLTS to 'y'
Date: Mon,  5 Mar 2018 15:34:05 +0100
Message-Id: <20180305143405.12187-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing multi_v7_defconfig with config fragments that makes the
kernel size to grow. The kernel fails to load simple modules, as
reported by kselftest:

[   34.107620] test_printf: section 4 reloc 2 sym 'memset': relocation
28 out of range (0xbf046044 -> 0xc109f720)
selftests: printf.sh [FAIL]

The problem that is seen when enabling too much in the kernel without
enabling ARM_MODULE_PLTS, is that the top of the kernel gets out of
reach from the bottom of the module area.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7e3d53575486..6831f2d4ee75 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1701,6 +1701,7 @@ config ARCH_WANT_GENERAL_HUGETLB
 config ARM_MODULE_PLTS
 	bool "Use PLTs to allow module memory to spill over into vmalloc area"
 	depends on MODULES
+	default y
 	help
 	  Allocate PLTs when loading modules so that jumps and calls whose
 	  targets are too far away for their relative offsets to be encoded
@@ -1711,7 +1712,8 @@ config ARM_MODULE_PLTS
 	  rounding up to page size, the actual memory footprint is usually
 	  the same.
 
-	  Say y if you are getting out of memory errors while loading modules
+	  Disabling this is usually safe for small single-platform
+	  configurations. If unsure, say y.
 
 source "mm/Kconfig"
 
-- 
2.11.0
