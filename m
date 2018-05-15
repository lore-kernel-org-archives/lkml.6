Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeEOIgD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:36:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50345 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeEOIgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:36:01 -0400
X-Google-Smtp-Source: AB8JxZoXnTjDtBs+Dj/PtlJkifFGQHQ2/lq/NnXBmqMQ5XWZevttNUBQ9r1oFL19tG7corxoHwJm/g==
Date: Tue, 15 May 2018 10:35:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        will.deacon@arm.com, mark.rutland@arm.com,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180515083556.GA30420@gmail.com>
References: <20180505083635.622xmcvb42dw5xxh@gmail.com>
 <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509073327.GE12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> And if we're going to do codegen, we might as well all generate this
> anyway, so all this mucking about is a complete waste of time.

I'm not yet convinced that it will be cleaner, but can be convinced in principle, 
but meanwhile the existing code is arguably butt-ugly and bloaty.

Regarding these cleanups, we had this before:

 /* atomic_add_return_relaxed */
 #ifndef atomic_add_return_relaxed
 #define  atomic_add_return_relaxed	atomic_add_return
 #define  atomic_add_return_acquire	atomic_add_return
 #define  atomic_add_return_release	atomic_add_return

 #else /* atomic_add_return_relaxed */

 #ifndef atomic_add_return_acquire
 #define  atomic_add_return_acquire(...)					\
	__atomic_op_acquire(atomic_add_return, __VA_ARGS__)
 #endif

 #ifndef atomic_add_return_release
 #define  atomic_add_return_release(...)					\
	__atomic_op_release(atomic_add_return, __VA_ARGS__)
 #endif

 #ifndef atomic_add_return
 #define  atomic_add_return(...)						\
	__atomic_op_fence(atomic_add_return, __VA_ARGS__)
 #endif
 #endif /* atomic_add_return_relaxed */

Which is 23 lines per definition.

Now we have this much more compact definition:

 #ifndef atomic_add_return_relaxed
 # define atomic_add_return_relaxed		atomic_add_return
 # define atomic_add_return_acquire		atomic_add_return
 # define atomic_add_return_release		atomic_add_return
 #else
 # ifndef atomic_add_return
 #  define atomic_add_return(...)		__op_fence(atomic_add_return, __VA_ARGS__)
 #  define atomic_add_return_acquire(...)	__op_acquire(atomic_add_return, __VA_ARGS__)
 #  define atomic_add_return_release(...)	__op_release(atomic_add_return, __VA_ARGS__)
 # endif
 #endif

Which is just _half_ the linecount.

Automated code generation might improve this some more, but the net effect on the 
core <linux/atomic.h> code right now is 373 lines removed:

  include/linux/atomic.h | 1109 ++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------
  1 file changed, 368 insertions(+), 741 deletions(-)

... <linux/atomic.h> shrunk to just 709 lines.

The x86/include/asm/atomic64_64.h file got smaller as well due to the cleanups:

  arch/x86/include/asm/atomic64_64.h | 216 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------
  1 file changed, 97 insertions(+), 119 deletions(-)

So unless you can clean this up and shrink this even more, these changes are 
obviously justified on their own.

Thanks,

	Ingo
