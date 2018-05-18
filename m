Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeERH7E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:59:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeERH7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:59:00 -0400
Date: Fri, 18 May 2018 09:58:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nadav Amit <namit@vmware.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, nadav.amit@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Message-ID: <20180518075853.GD12217@hirez.programming.kicks-ass.net>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517161402.78089-3-namit@vmware.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 09:13:58AM -0700, Nadav Amit wrote:
> +asm(".macro __BUG_FLAGS ins:req file:req line:req flags:req size:req\n"
> +    "1:\t \\ins\n\t"
> +    ".pushsection __bug_table,\"aw\"\n"
> +    "2:\t "__BUG_REL(1b)		"\t# bug_entry::bug_addr\n\t"
> +    __BUG_REL(\\file)			"\t# bug_entry::file\n\t"
> +    ".word \\line"			"\t# bug_entry::line\n\t"
> +    ".word \\flags"			"\t# bug_entry::flags\n\t"
> +    ".org 2b+\\size\n\t"
> +    ".popsection\n\t"
> +    ".endm");
> +
> +#define _BUG_FLAGS(ins, flags)                                          \
>  do {									\
> +	asm volatile("__BUG_FLAGS \"" ins "\" %c0 %c1 %c2 %c3"		\
> +		     : : "i" (__FILE__), "i" (__LINE__),                \
> +			 "i" (flags),                                   \
>  			 "i" (sizeof(struct bug_entry)));		\
>  } while (0)

This is an awesome hack, but is there really nothing we can do to make
it more readable? Esp, that global asm doing the macro definition is a
pain to read.

Also, can we pretty please used named operands in 'new' code?
