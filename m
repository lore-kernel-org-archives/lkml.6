Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933208AbeBMBGF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:06:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933012AbeBMBGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:06:03 -0500
Date: Mon, 12 Feb 2018 19:06:02 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Andi Kleen <andi@firstfloor.org>
Cc: tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        bp@alien8.de, dwmw2@infradead.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] x86/retpoline: Fix return buffer filling
Message-ID: <20180213010601.a6vbrdealdngb6df@treble>
References: <20180213000422.16916-1-andi@firstfloor.org>
 <20180213000422.16916-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213000422.16916-2-andi@firstfloor.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 04:04:22PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> An earlier patch moved the RSB filling out of line, ending
> it with a return. This results in the return buffer filling
> only giving 15 instead of 16 usable returns because
> the return from fill_rsb already uses one up.
> 
> Since the kernel call chains can be quite deep that's
> somewhat dangerous and better avoided.
> 
> Always do one extra return buffer fill in the caller.
> I added a STUFF_ONE_RSB macro for this, and fixed
> up all the caller
> 
> An alternative would be to revert 1dde7415e999
> and just go back to the inline version.
> 
> Needs the earlier patch to avoid lots of bogus warnings
> from objtool, but even with that there is one left.
> 
> Fixes: 1dde7415e999 ("x86/retpoline: Simplify vmexit...")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Instead of patch 1/2, the alternatives need to be annotated like:

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index af0ca73abb23..4deeb869ab83 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -89,6 +89,7 @@
 .macro FILL_RETURN_BUFFER nr:req ftr:req
 #ifdef CONFIG_RETPOLINE
 	ALTERNATIVE "", "call __clear_rsb" , \ftr
+	ANNOTATE_NOSPEC_ALTERNATIVE
 	ALTERNATIVE "", "STUFF_ONE_RSB", \ftr
 #endif
 .endm
@@ -178,7 +179,7 @@ extern char __indirect_thunk_end[];
 static inline void vmexit_fill_RSB(void)
 {
 #ifdef CONFIG_RETPOLINE
-	alternative_input("",
+	alternative_input(ANNOTATE_NOSPEC_ALTERNATIVE,
 			  "call __fill_rsb;" STUFF_ONE_RSB,
 			  X86_FEATURE_RETPOLINE,
 			  ASM_NO_INPUT_CLOBBER(_ASM_BX, "memory"));
