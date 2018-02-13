Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964908AbeBMNTL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:19:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34568 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964808AbeBMNTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:19:10 -0500
Date: Tue, 13 Feb 2018 14:18:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andi Kleen <andi@firstfloor.org>
Cc: tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, jpoimboe@redhat.com,
        Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] x86/retpoline: Fix return buffer filling
Message-ID: <20180213131840.GD11572@pd.tnic>
References: <20180213000422.16916-1-andi@firstfloor.org>
 <20180213000422.16916-2-andi@firstfloor.org>
 <20180213112118.GB11572@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213112118.GB11572@pd.tnic>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 12:21:18PM +0100, Borislav Petkov wrote:
> On Mon, Feb 12, 2018 at 04:04:22PM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > An earlier patch moved the RSB filling out of line, ending
> > it with a return. This results in the return buffer filling
> > only giving 15 instead of 16 usable returns because
> > the return from fill_rsb already uses one up.
> 
> Or, we can get rid of the RET:
> 
> ---
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index 480edc3a5e03..359130ceaa64 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -91,7 +91,8 @@ GENERATE_THUNK(r15)
>  
>  ENTRY(__fill_rsb)
>  	STUFF_RSB RSB_FILL_LOOPS, %_ASM_SP
> -	ret
> +	pop %_ASM_BX
> +	jmp *%_ASM_BX

... and that's an indirect JMP too :-\

I guess we could use RET far which is, reportedly, not affected.
Something like that, but I need to make it build first:

---
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 788c4da7dda9..04642f549817 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -6,6 +6,7 @@
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
+#include <asm/segment.h>
 
 #ifdef __ASSEMBLY__
 
@@ -80,7 +81,7 @@
 /* This clobbers the BX register */
 .macro FILL_RETURN_BUFFER nr:req ftr:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE "", "call __clear_rsb", \ftr
+	ALTERNATIVE "", __stringify(push $__KERNEL_CS; call __clear_rsb), \ftr
 #endif
 .endm
 
@@ -156,7 +157,7 @@ static inline void vmexit_fill_RSB(void)
 {
 #ifdef CONFIG_RETPOLINE
 	alternative_input("",
-			  "call __fill_rsb",
+			  "push $__KERNEL_CS ; call __fill_rsb",
 			  X86_FEATURE_RETPOLINE,
 			  ASM_NO_INPUT_CLOBBER(_ASM_BX, "memory"));
 #endif
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 480edc3a5e03..961661233b34 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -91,7 +91,7 @@ GENERATE_THUNK(r15)
 
 ENTRY(__fill_rsb)
 	STUFF_RSB RSB_FILL_LOOPS, %_ASM_SP
-	ret
+	lret
 END(__fill_rsb)
 EXPORT_SYMBOL_GPL(__fill_rsb)
 
@@ -99,6 +99,6 @@ EXPORT_SYMBOL_GPL(__fill_rsb)
 
 ENTRY(__clear_rsb)
 	STUFF_RSB RSB_CLEAR_LOOPS, %_ASM_SP
-	ret
+	lret
 END(__clear_rsb)
 EXPORT_SYMBOL_GPL(__clear_rsb)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
