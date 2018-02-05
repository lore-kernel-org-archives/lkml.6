Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeBEL6r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:58:47 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50270 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeBEL6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:58:40 -0500
X-Google-Smtp-Source: AH8x224aWPTI+L1/7QnMj3WvoGISsMiUj2emwxYGKUFTIjrfan46RUo6ZcSaJU8lso1jVkEH8gLr8A==
Date: Mon, 5 Feb 2018 12:58:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
Message-ID: <20180205115836.otnviqbae3pxjk5g@gmail.com>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> +	/*
> +	 * Sanitize extra registers of values that a speculation attack
> +	 * might want to exploit. In the CONFIG_FRAME_POINTER=y case,
> +	 * the expectation is that %ebp will be clobbered before it
> +	 * could be used.
> +	 */
> +	.macro CLEAR_EXTRA_REGS_NOSPEC
> +	xorq %r15, %r15
> +	xorq %r14, %r14
> +	xorq %r13, %r13
> +	xorq %r12, %r12
> +	xorl %ebx, %ebx
> +#ifndef CONFIG_FRAME_POINTER
> +	xorl %ebp, %ebp
> +#endif

BTW., is there any reason behind the order of the clearing of these registers? 
This ordering seems rather random:

 - The canonical register order is: RBX, RBP, R12, R13, R14, R15, which is also 
   their push-order on the stack.

 - The CLEAR_EXTRA_REGS_NOSPEC order appears to be the reverse order (pop-order), 
   but with RBX and RBP reversed.

So since this is a 'push side' primitive I'd use the regular (push-) ordering 
instead:

	.macro CLEAR_EXTRA_REGS_NOSPEC
	xorl %ebx, %ebx
	xorl %ebp, %ebp
	xorq %r12, %r12
	xorq %r13, %r13
	xorq %r14, %r14
	xorq %r15, %r15

It obviously doesn't matter to correctness - only to readability.

There's also a (very) small micro-optimization argument in favor of the regular 
order: the earlier registers are more likely to be utilized by C functions, so the 
sooner we clear them, the less potential interaction these clearing instructions 
are going to have with any later use.

Thanks,

	Ingo
