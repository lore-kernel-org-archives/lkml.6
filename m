Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeC0PKe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:10:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:22290 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752342AbeC0PKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:10:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,367,1517904000";
   d="scan'208";a="215114295"
Message-ID: <1522163426.21176.24.camel@linux.intel.com>
Subject: Re: [tip:x86/urgent] x86/io: Define readq()/writeq() to use 64-bit
 type
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, sohil.mehta@intel.com,
        mitake@dcl.info.waseda.ac.jp, linux-tip-commits@vger.kernel.org
Date: Tue, 27 Mar 2018 18:10:26 +0300
In-Reply-To: <tip-0fc8483b698620ea3d8cc6635b54eccc613c23a3@git.kernel.org>
References: <20180119143322.16555-1-andriy.shevchenko@linux.intel.com>
         <tip-0fc8483b698620ea3d8cc6635b54eccc613c23a3@git.kernel.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-13 at 08:58 -0800, tip-bot for Andy Shevchenko wrote:
> Commit-ID:  0fc8483b698620ea3d8cc6635b54eccc613c23a3
> Gitweb:     https://git.kernel.org/tip/0fc8483b698620ea3d8cc6635b54ecc
> c613c23a3
> Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> AuthorDate: Fri, 19 Jan 2018 16:33:22 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 13 Feb 2018 17:14:41 +0100

As of today I don't see this in linux-next

% git tag --contains 0fc8483b69862
next-20180214
next-20180215
next-20180216

What happened to this change?

> 
> x86/io: Define readq()/writeq() to use 64-bit type
> 
> Since non atomic readq() and writeq() were added some of the drivers
> would like to use it in a manner of:
> 
>  #include <io-64-nonatomic-lo-hi.h>
> ...
>  pr_debug("Debug value of some register: %016llx\n", readq(addr));
> 
> However, lo_hi_readq() always returns __u64 data, while readq()
> on x86_64 defines it as unsigned long. and thus compiler warns
> about type mismatch, although they are both 64-bit on x86_64.
> 
> Convert readq() and writeq() on x86 to operate on deterministic
> 64-bit type. The most of architectures in the kernel already are using
> either unsigned long long, or u64 type for readq() / writeq().
> This change propagates consistency in that sense.
> 
> While this is not an issue per se, though if someone wants to address
> it,
> the anchor could be the commit
> 
>   797a796a13df ("asm-generic: architecture independent readq/writeq
> for 32bit environment")
> 
> where non-atomic variants had been introduced.
> 
> Note, there are only few users of above pattern and they will not be
> affected because they do cast returned value. The actual warning has
> been issued on not-yet-upstreamed code.
> 
> Potentially we might get a new warnings if some 64-bit only code
> assigns returned value to unsigned long type of variable. This is
> assumed to be addressed on case-by-case basis.
> 
> Reported-by: lkp <lkp@intel.com>
> Tested-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mehta, Sohil <sohil.mehta@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: http://lkml.kernel.org/r/20180119143322.16555-1-andriy.shevchenk
> o@linux.intel.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/include/asm/io.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 95e9486..365f5ba 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -94,10 +94,10 @@ build_mmio_write(__writel, "l", unsigned int, "r",
> )
>  
>  #ifdef CONFIG_X86_64
>  
> -build_mmio_read(readq, "q", unsigned long, "=r", :"memory")
> -build_mmio_read(__readq, "q", unsigned long, "=r", )
> -build_mmio_write(writeq, "q", unsigned long, "r", :"memory")
> -build_mmio_write(__writeq, "q", unsigned long, "r", )
> +build_mmio_read(readq, "q", unsigned long long, "=r", :"memory")
> +build_mmio_read(__readq, "q", unsigned long long, "=r", )
> +build_mmio_write(writeq, "q", unsigned long long, "r", :"memory")
> +build_mmio_write(__writeq, "q", unsigned long long, "r", )
>  
>  #define readq_relaxed(a)	__readq(a)
>  #define writeq_relaxed(v, a)	__writeq(v, a)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
