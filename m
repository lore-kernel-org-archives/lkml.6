Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeBVLDB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:03:01 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39505 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753380AbeBVLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:03:00 -0500
X-Google-Smtp-Source: AH8x224aC08u4NCS1IhwJysiVHJ9CcvT6s7Ip0TL49VgE7MLxNrT7p3J77Oc8oyIyla1Hyji8NQhrg==
Date: Thu, 22 Feb 2018 14:02:52 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Martin Sebor <msebor@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed/64: fix warning for 32-bit
 trampoline copy
Message-ID: <20180222110252.ogmn3yf6ln5edc6t@node.shutemov.name>
References: <20180222104101.2717185-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222104101.2717185-1-arnd@arndb.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 11:40:41AM +0100, Arnd Bergmann wrote:
> gcc-8 warns that we copy TRAMPOLINE_32BIT_CODE_SIZE bytes from the pointer
> to the function into actual trampoline, when that pointer is only 8 bytes:
> 
> In file included from arch/x86/boot/compressed/pgtable_64.c:3:
> arch/x86/boot/compressed/pgtable_64.c: In function 'paging_prepare':
> arch/x86/boot/compressed/../string.h:18:23: error: '__builtin_memcpy' reading 96 bytes from a region of size 8 [-Werror=stringop-overflow=]
>  #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
>                        ^~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/boot/compressed/pgtable_64.c:62:2: note: in expansion of macro 'memcpy'
>   memcpy(trampoline + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
>   ^~~~~~
> 
> I assume what was intended here is to copy the trampoline itself rather than
> the pointer to the trampoline.
> 
> Cc: Martin Sebor <msebor@gmail.com>
> Fixes: b91993a87aff ("x86/boot/compressed/64: Prepare trampoline memory")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is a fairly new warning in gcc, it's possible that the code is
> correct and the warning message got it wrong, please double-check this.
> 
> Was the 32-bit trampoline code in the 64-bit decompressor tested successfully?

Yes, it was. Actually it tested on every boot of any 64-bit machine.

The fix is wrong and it breaks boot. The bug is in trampoline_32bit_src
declaration. Could you check if this helps with the warning:

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
 Kirill A. Shutemov
