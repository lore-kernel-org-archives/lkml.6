Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031899AbeBNW2F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:28:05 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38331 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNW2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:28:02 -0500
X-Google-Smtp-Source: AH8x225SOlVUUIVl4+wqeBaOhrEmY5UQ4wlnEUEYB4L263dOHu7Y100S3iCw6NY+uNwEXD0YHySZOw==
Date: Wed, 14 Feb 2018 23:27:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/entry/64: Fix CR3 restore order in paranoid_exit()
Message-ID: <20180214222757.zda2xvytzb7jjfyy@gmail.com>
References: <2b8ce3a31bcdfffa434269f4abf5d46816b75773.1518575248.git.jpoimboe@redhat.com>
 <9f6d258e-8191-9b57-4839-aa7c84e4c829@intel.com>
 <20180214073910.boevmg65upbk3vqb@gmail.com>
 <20180214161148.c4uxsmbwycsbcfh4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214161148.c4uxsmbwycsbcfh4@treble>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Dave was right, my patch was obviously bogus.  I couldn't figure out a
> real reproducer, so I made an artificial one (see below) and can confirm
> that your patch fixes it.
> 
> I would resubmit the patch, but now you're the author, so I'm not sure
> how that works with the SOB.

I'd just have made you the author of the oneliner fix, in fair payment for writing 
the changelog! ;-)

For anything larger and more complex we can do:

  Signed-off-by: Ingo Molnar <mingo@kernel.org>
  Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
  Signed-off-by: Ingo Molnar <mingo@kernel.org>

Which is technically an unusual but still correct 'SoB chain' describing the 
true route of the patch.

See for example these scheduler commits:

  8c0944cee7af: sched/deadline: Rename __dl_clear() to __dl_sub()
  07f06cb3b5f6: sched: Start stopper early
  7675104990ed: sched: Implement lockless wake-queues

In particular 7675104990ed is a good example:

  Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
  [tweaks, adjustments, comments, etc.]
  Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
  Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
  Acked-by: Thomas Gleixner <tglx@linutronix.de>
  Signed-off-by: Ingo Molnar <mingo@kernel.org>

With his developer hat on PeterZ sent out a first implementation which Davidlohr 
fixed, tested and signed off on - which PeterZ then applied with his maintainer 
hat on, which Thomas acked and I committed to the scheduler git tree.

It would require two commits (one of which could easily be a bisection-breaker) to 
express this in any other way.

But such chains are pretty rare and very much the exception: usually either the 
original author takes care of everything, or the secondary author makes so many 
changes that the secondary author becomes the primary author and the original 
author is credited via a copyright notice and/or a tag like:

  Originally-From: Ingo Molnar <mingo@kernel.org>

> Feel free to add my
> 
>   Reported-and-tested-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks and added!

BTW:

> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -325,6 +325,8 @@ syscall_return_via_sysret:
>  	 */
>  	SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
>  
> +	int3
> +
>  	popq	%rdi
>  	popq	%rsp
>  	USERGS_SYSRET64
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 3d9b2308e7fa..74fabcdf6c36 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -605,6 +605,8 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
>  		goto exit;
>  #endif
>  
> +	goto exit;

That's a very clever way to test such races!

Thanks,

	Ingo
