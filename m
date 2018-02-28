Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeB1NTS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:19:18 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53866 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeB1NTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:19:17 -0500
X-Google-Smtp-Source: AH8x224VVzWGyg9ijrp/yaPG9Kq3RCiv29WrEYvyk8g4hRROgIE/Y67ThGVFp5/Z2i2QksavpBH44Q==
Date: Wed, 28 Feb 2018 16:19:05 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/5] x86/boot/compressed/64: Find a place for 32-bit
 trampoline
Message-ID: <20180228131905.ypzjmaqg3zjke2ud@node.shutemov.name>
References: <20180227154217.69347-1-kirill.shutemov@linux.intel.com>
 <20180227154217.69347-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227154217.69347-3-kirill.shutemov@linux.intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 06:42:14PM +0300, Kirill A. Shutemov wrote:
> If a bootloader enables 64-bit mode with 4-level paging, we might need to
> switch over to 5-level paging. The switching requires the disabling of
> paging, which works fine if kernel itself is loaded below 4G.
> 
> But if the bootloader puts the kernel above 4G (not sure if anybody does
> this), we would lose control as soon as paging is disabled, because the
> code becomes unreachable to the CPU.
> 
> To handle the situation, we need a trampoline in lower memory that would
> take care of switching on 5-level paging.
> 
> This patch finds a spot in low memory for a trampoline.
> 
> The heuristic is based on code in reserve_bios_regions().
> 
> We find the end of low memory based on BIOS and EBDA start addresses.
> The trampoline is put just before end of low memory. It's mimic approach
> taken to allocate memory for realtime trampoline.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Tested-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/boot/compressed/misc.c       |  4 ++++
>  arch/x86/boot/compressed/pgtable.h    | 11 +++++++++++
>  arch/x86/boot/compressed/pgtable_64.c | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/pgtable.h
> 
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index b50c42455e25..e58409667b13 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -14,6 +14,7 @@
>  
>  #include "misc.h"
>  #include "error.h"
> +#include "pgtable.h"
>  #include "../string.h"
>  #include "../voffset.h"
>  
> @@ -372,6 +373,9 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  	debug_putaddr(output_len);
>  	debug_putaddr(kernel_total_size);
>  
> +	/* Report address of 32-bit trampoline */
> +	debug_putaddr(trampoline_32bit);
> +
>  	/*
>  	 * The memory hole needed for the kernel is the larger of either
>  	 * the entire decompressed kernel plus relocation table, or the

0-day found problem with the patch on 32-bit config.

Here's fixup:

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index e58409667b13..8e4b55dd5df9 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -373,8 +373,10 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	debug_putaddr(output_len);
 	debug_putaddr(kernel_total_size);
 
+#ifdef CONFIG_X86_64
 	/* Report address of 32-bit trampoline */
 	debug_putaddr(trampoline_32bit);
+#endif
 
 	/*
 	 * The memory hole needed for the kernel is the larger of either
-- 
 Kirill A. Shutemov
