Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752741AbeBFAk7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:40:59 -0500
Received: from ozlabs.org ([103.22.144.67]:43107 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752264AbeBFAkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:40:51 -0500
Date: Tue, 6 Feb 2018 11:40:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will.deacon@arm.com>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20180206114048.6c8ced1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/arm64/kernel/entry.S

between commit:

  4bf3286d29f3 ("arm64: entry: Hook up entry trampoline to exception vectors")

from Linus' tree and commit:

  f1e3a12b6543 ("membarrier/arm64: Provide core serializing command")

from the tip tree.

I fixed it up (probably not completely - see below) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/entry.S
index b34e717d7597,5edde1c2e93e..000000000000
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@@ -324,21 -302,11 +324,25 @@@ alternative_else_nop_endi
  	ldp	x28, x29, [sp, #16 * 14]
  	ldr	lr, [sp, #S_LR]
  	add	sp, sp, #S_FRAME_SIZE		// restore sp
 +
 +	.if	\el == 0
 +alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 +	bne	4f
 +	msr	far_el1, x30
 +	tramp_alias	x30, tramp_exit_native
 +	br	x30
 +4:
 +	tramp_alias	x30, tramp_exit_compat
 +	br	x30
 +#endif
 +	.else
+ 	/*
+ 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on eret context synchronization
+ 	 * when returning from IPI handler, and when returning to user-space.
+ 	 */
 -	eret					// return to kernel
 +	eret
 +	.endif
  	.endm
  
  	.macro	irq_stack_entry
