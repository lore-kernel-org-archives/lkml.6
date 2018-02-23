Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeBWI25 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:28:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeBWI2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:28:53 -0500
Date: Fri, 23 Feb 2018 00:27:26 -0800
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-fba407e1710ae4c558e1e2b55b5a55b2c07a596d@git.kernel.org>
Cc: tglx@linutronix.de, msebor@gmail.com, arnd@arndb.de, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        hpa@zytor.com, msebor@gmail.com, mingo@kernel.org, arnd@arndb.de,
        tglx@linutronix.de
In-Reply-To: <20180222112817.456380-1-arnd@arndb.de>
References: <20180222112817.456380-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot/compressed/64: Fix warning for 32-bit
 trampoline memcpy()
Git-Commit-ID: fba407e1710ae4c558e1e2b55b5a55b2c07a596d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fba407e1710ae4c558e1e2b55b5a55b2c07a596d
Gitweb:     https://git.kernel.org/tip/fba407e1710ae4c558e1e2b55b5a55b2c07a596d
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Thu, 22 Feb 2018 12:28:05 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:29:54 +0100

x86/boot/compressed/64: Fix warning for 32-bit trampoline memcpy()

GCC-8 warns that we copy TRAMPOLINE_32BIT_CODE_SIZE bytes from the pointer
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

Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Sebor <msebor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b91993a87aff ("x86/boot/compressed/64: Prepare trampoline memory")
Link: http://lkml.kernel.org/r/20180222112817.456380-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
