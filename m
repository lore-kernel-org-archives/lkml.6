Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeBVKmU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:42:20 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53549 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeBVKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:42:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Sebor <msebor@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot/compressed/64: fix warning for 32-bit trampoline copy
Date: Thu, 22 Feb 2018 11:40:41 +0100
Message-Id: <20180222104101.2717185-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:nwtsDGuwVnHQeaBF/rZl7gABQXzM1b2vJfMPiRgofzqW0w2rzog
 sP+IswSU3DF1RKjGW+iBbAAXIRqGSQywqClDFAPvMeUhLxSWQnL5CIZC4Qb1HFeLLIEZ329
 djeM0KGJtg/ew5+0b1Kg2oRblPL+H0ar9jU3CmK2nmKC+mFWMrmMb3fwP0mPjeXqJNxfk/5
 i33n5urDquFH1qgqDuB1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T87I09TTYPE=:LwXMmkJMCYjpml/buLxBQ9
 YORWeLt2BSOJzptMII65IdK/ULCitgbKmN3mmXuseP4A7DXIhu9M3JGBbVJ3347BsOUBcv3eB
 uJ1fb6n8CEG0AXwU7NUYILeSOFKAI4M/pQCB7DgjOA7m2d4Q1BVmPzSI1iX94e8aS19d3DqJ+
 HG0Mg1P/yrHUL81tdqYSVAONR/3zMKV3fbzLzUgQboJZ/SJy4UCG2qGhDk5VvCfSbbHHBhBG5
 +Xn6mXmbmajKTqvd5ZtlnCn6bLWN50qOwEjmAUXDZ9/eOatSkVH5YLW0oC8tbeoCSpcbgND1a
 5W9lMJ2EHVAT6HboTmvZVnV/cijz978YmFT60lUQuzPvmyon6JBjpxx1A/CyHlPfi8I7LjABm
 gJ3jOASM4tjNg9YMLuJEGq21QVI8peUoQ58cOMtpj+ullklM/EKR1HDLDz+7JdA3BEQLHg74/
 wAgk7KchtMFQyQWyFNZFpoLrJh9AUgxyZkmlPZcsILNM34HnbiJNQsidDkk7oAy/mpJQl2sQ3
 bzFZbf5icKj4t0jz5rZc0WAuajZedXsVFINV5QzDa3ctx3kDs9VXM2gpulkClTpoijVzp8yKq
 eVtQVHO7ceXRQmmCIhduZRpltu1Wb0rvOfp4EdG5yXvdwWX+olTxGqPLz4DMixDYTo2vDQxwb
 cKrqK6kQIvXAisSqX54lj13gaawWDHqACG0wPmug+JAt1b067CptmyhyUmO31EBKzCFbPrZ1r
 qJUBOHL1mo0xcEn22JtRueLfa+GpgYAN3iqgqQ==
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

I assume what was intended here is to copy the trampoline itself rather than
the pointer to the trampoline.

Cc: Martin Sebor <msebor@gmail.com>
Fixes: b91993a87aff ("x86/boot/compressed/64: Prepare trampoline memory")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is a fairly new warning in gcc, it's possible that the code is
correct and the warning message got it wrong, please double-check this.

Was the 32-bit trampoline code in the 64-bit decompressor tested successfully?
---
 arch/x86/boot/compressed/pgtable_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index dad5da7b4c1a..35a0542fe397 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -60,7 +60,7 @@ struct paging_config paging_prepare(void)
 
 	/* Copy trampoline code in place */
 	memcpy(trampoline + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
-			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
+			trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
 
 	/*
 	 * Set up a new page table that will be used for switching from 4-
-- 
2.9.0
