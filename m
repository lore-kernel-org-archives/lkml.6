Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeBVL3j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:29:39 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:52455 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753503AbeBVL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:29:37 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Sebor <msebor@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] x86/boot/compressed/64: fix warning for 32-bit trampoline copy
Date: Thu, 22 Feb 2018 12:28:05 +0100
Message-Id: <20180222112817.456380-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:0miO+JvCYxmnU7ays95Uyu+Zb2G384BClw1fW11r8Cz5KS0ekuj
 X4b73iu4bwA//ItCSyfbd+PWdTythF5oyMDku4jHJMH7tsLHllHOQrFKY5l9sLJs/LEQK1o
 q5YyvBWGFeTaLoM8kN/uv2tFvtpwZwut4eNI1dS9jG5JYqdG2Br8ghRXdd/PktoIXeD8QhF
 i6SSSRxJAt9LydcmcuhFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eAhfE1u7TiU=:yQ61loQUjLKNXmQl1+J1Kj
 tmZZY8Z+h62jzHDhZFFmAHr9jIZ5vupjuZs4XM5Rz+CLv0D1fqY7XS/+FnlZB1Yn5SV9YP5P3
 4aFm3hmXaCeaB76Y1U+ulVyf5pWvTN8KhX5oxVhadO7RbTYEOvaxK48n7LGZKpoBtlJu5oiFD
 WftWt5wOVNYDHQRX66OqH355iW4WLrcemGAISDzEVSjeKdBU7LM6VUfbILkk65SLGTQSZJtaT
 lxWEf+OFXWZm6KGnY8/bd7ajQHPsOBs0umE+j8slIqxe+P75PXtbt5dnDwjlNEAkCRUV3YbUf
 aE18gWtP5/Y1OeeHBlwB46CMW/LXEmRbiZ1oaxc1HWMTSsmGuxTYKXFLrwvQngGG1kWoMkMG4
 4XLmi99L7uNj/PwK4KPEhJWneHEqfA41vf+QxT4rmm8cMlkd3jAJ4x5IOuiRG82CECu+2Futb
 +2xRZOXQE0P5BeTXkJldrHz+bV/nW0pJPwtoj6F7ciJSujq9dKFg6izY9g4gZ2xvmkWNSEkFQ
 btCS4+uDEihlFlZoIfyR9C+5H9rNac5ngfK/2plcYQOUEhKoZOa2B0019DjwY53aeA0RqhNp3
 wInESRAwviFRcEMhMXfTiWUMmKv7yJbTrlI2WDJsLaEj7LbcE8Jof9DuKFXXtbrhG5+zWaK5C
 3Q++QlKB98E9lJTl1BL7DzviUVJHMvZYiPZLNzyJ5gqITvKBg9iOTrhQ3l3/bTC3V3hNUC3iP
 svzyIHfW1jFFbDtraONvsIu+/89w8mKsgZorBA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 warns that we copy TRAMPOLINE_32BIT_CODE_SIZE bytes from the pointer
to the function into actual trampoline, when that pointer is only 8 bytes:

In file included from arch/x86/boot/compressed/pgtable_64.c:3:
arch/x86/boot/compressed/pgtable_64.c: In function 'paging_prepare':
arch/x86/boot/compressed/../string.h:18:23: error: '__builtin_memcpy' reading 96 bytes from a region of size 8 [-Werror=stringop-overflow=]
 #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
                       ^~~~~~~~~~~~~~~~~~~~~~~
arch/x86/boot/compressed/pgtable_64.c:62:2: note: in expansion of macro 'memcpy'
  memcpy(trampoline + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
  ^~~~~~

It turns out that the declaration is incorrect here: trampoline_32bit_src
is defined as a function in arch/x86/boot/compressed/head_64.S, not a
pointer to a function. Fixing the prototype to match addresses the warning.

Cc: Martin Sebor <msebor@gmail.com>
Suggested-by: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Fixes: b91993a87aff ("x86/boot/compressed/64: Prepare trampoline memory")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix prototype rather than (incorrectly) change the user
---
 arch/x86/boot/compressed/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 6e0db2260147..5e0b1c4abef4 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -12,7 +12,7 @@
 
 #ifndef __ASSEMBLER__
 
-extern void (*trampoline_32bit_src)(void *return_ptr);
+extern void trampoline_32bit_src(void *return_ptr);
 
 #endif /* __ASSEMBLER__ */
 #endif /* BOOT_COMPRESSED_PAGETABLE_H */
-- 
2.9.0
