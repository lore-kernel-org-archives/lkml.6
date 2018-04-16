Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeDPJPU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:15:20 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33957 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754113AbeDPJPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:15:19 -0400
X-Google-Smtp-Source: AIpwx48B5eVoldoIVgrZByBYaQ2rnpv/2OAG/mf+O0dzfbqqNleG+L7joxyb04OH9EqoLYMMKgZ7nw==
Date: Mon, 16 Apr 2018 12:15:14 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Ingo Molnar <mingo@kernel.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: instant reboot caused by 194a9749c73d650c0
Message-ID: <20180416091514.wqig3l4lrc72tyrs@node.shutemov.name>
References: <5ecfeb13-84e4-f1ef-bd30-391674b2050a@gmail.com>
 <20180416060709.mnzk7fb5y45dnpmg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416060709.mnzk7fb5y45dnpmg@gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 08:07:09AM +0200, Ingo Molnar wrote:
> 
> * Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
> > Hi Kirill
> > 
> > For some reason, my hosts instantly crash at boot time, with absolutely no log on console.
> > 
> > Bisection pointed to :
> > 
> > $ git bisect bad
> > 194a9749c73d650c0b1dfdee04fb0bdf0a888ba8 is the first bad commit
> > commit 194a9749c73d650c0b1dfdee04fb0bdf0a888ba8
> > Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Date:   Mon Mar 12 13:02:46 2018 +0300
> > 
> >     x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G
> 
> Could you please send your .config? These early boot problems are sometimes build 
> and Kconfig environment sensitive.
> 
> A high level description of your hardware and the distro you are using would also 
> be useful.

And how do you start the kernel? EFI? Legacy boot? kexec?

> 
> Kirill, I'm curious about this change:
> 
> -       /* Calculate address we are running at */
> -       call    1f
> -1:     popl    %edi
> -       subl    $1b, %edi
> +       /* Calculate address of paging_enabled() once we are executing in the 
> trampoline */
> +       leal    paging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
> 
> Here we change the calculation from a "discover where we are executing" method to 
> a calculation method (which is fundamentally more fragile) - why?

I guess, I tried to save one register -- %rdi is used for return from
trampoline.

But you're right there's no reason to do this and it may be more fragile.

Eric, could you check if the patch makes any difference?

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fca012baba19..395c122ef70b 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -562,7 +562,10 @@ ENTRY(trampoline_32bit_src)
 	movl	%eax, %cr4
 
 	/* Calculate address of paging_enabled() once we are executing in the trampoline */
-	leal	paging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
+	call	1f
+1:	popl	%eax
+	subl	$1b, %eax
+	leal	paging_enabled(%eax), %eax
 
 	/* Prepare the stack for far return to Long Mode */
 	pushl	$__KERNEL_CS
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 91f75638f6e6..6ff7e81b5628 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,7 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0x60
+#define TRAMPOLINE_32BIT_CODE_SIZE	0x70
 
 #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
 
-- 
 Kirill A. Shutemov
