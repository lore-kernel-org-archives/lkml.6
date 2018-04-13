Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754078AbeDMJzA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:55:00 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36367 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeDMJy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:54:58 -0400
X-Google-Smtp-Source: AIpwx49OWjrHC80RsaIpB10mv4noNzqA/xID7WsmRfkswFjTxwXtCtfAMNmG3w1OjqpMpjpNAcNnjA==
Date: Fri, 13 Apr 2018 11:54:48 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] memory-model: fix cheat sheet typo
Message-ID: <20180413095448.GA10490@andrea>
References: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
 <20180409184258.GP3948@linux.vnet.ibm.com>
 <20180410203214.GA19606@linux.vnet.ibm.com>
 <8cbda122-6aa3-365b-fd09-52dca0644cbd@redhat.com>
 <20180410213434.GC3948@linux.vnet.ibm.com>
 <156ac07b-7393-449f-518a-6b1c2cff8efb@redhat.com>
 <20180412092303.GA6044@andrea>
 <eda463d8-aa4e-2e6b-9d1d-41a5a4eaa3a7@redhat.com>
 <20180412112155.GA9154@andrea>
 <20180412211836.GG3948@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412211836.GG3948@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 02:18:36PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 12, 2018 at 01:21:55PM +0200, Andrea Parri wrote:
> > 
> > The litmus test that first comes to my mind when I think of cumulativity
> > (at least, 'cumulativity' as intended in LKMM) is:
> > 
> >    WRC+pooncerelease+rmbonceonce+Once.litmus
> 
> Removing the "cumul-fence* ;" from "let prop" does cause this test to be
> allowed, so looks plausible.
> 
> > for 'propagation', I could mention:
> > 
> >    IRIW+mbonceonces+OnceOnce.litmus
> 
> And removing the "acyclic pb as propagation" causes this one to be allowed,
> so again plausible.
> 
> > (both tests are availabe in tools/memory-model/litmus-tests/). It would
> > be a nice to mention these properties in the test descriptions, indeed.
> 
> Please see below.

Matching what I had in mind ;) thanks!

  Andrea


> 
> 							Thanx, Paul
> 
> > You might find it useful to also visualize the 'valid' executions (with
> > the main events/relations) associated to each of these tests; for this,
> > 
> >    $ herd7 -conf linux-kernel.cfg litmus-tests/your-test.litmus \
> > 	-show all -gv
> > 
> > (assuming you have 'gv' installed).
> 
> ------------------------------------------------------------------------
> 
> commit 494f11d10dd7d86e4a381cbe79e77f04cb0cee04
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Thu Apr 12 14:15:57 2018 -0700
> 
>     EXP tools/memory-model: Flag "cumulativity" and "propagation" tests
>     
>     This commit flags WRC+pooncerelease+rmbonceonce+Once.litmus as being
>     forbidden by LKMM cumulativity and IRIW+mbonceonces+OnceOnce.litmus as
>     being forbidden by LKMM propagation.
>     
>     Suggested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
> index 50d5db9ea983..98a3716efa37 100644
> --- a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
> +++ b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
> @@ -7,7 +7,7 @@ C IRIW+mbonceonces+OnceOnce
>   * between each pairs of reads.  In other words, is smp_mb() sufficient to
>   * cause two different reading processes to agree on the order of a pair
>   * of writes, where each write is to a different variable by a different
> - * process?
> + * process?  This litmus test exercises LKMM's "propagation" rule.
>   *)
>  
>  {}
> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> index 6919909bbd0f..178941d2a51a 100644
> --- a/tools/memory-model/litmus-tests/README
> +++ b/tools/memory-model/litmus-tests/README
> @@ -23,7 +23,8 @@ IRIW+mbonceonces+OnceOnce.litmus
>  	between each pairs of reads.  In other words, is smp_mb()
>  	sufficient to cause two different reading processes to agree on
>  	the order of a pair of writes, where each write is to a different
> -	variable by a different process?
> +	variable by a different process?  This litmus test is an example
> +	that is forbidden by LKMM propagation.
>  
>  IRIW+poonceonces+OnceOnce.litmus
>  	Test of independent reads from independent writes with nothing
> @@ -121,6 +122,7 @@ WRC+poonceonces+Once.litmus
>  WRC+pooncerelease+rmbonceonce+Once.litmus
>  	These two are members of an extension of the MP litmus-test class
>  	in which the first write is moved to a separate process.
> +	The second is an example that is forbidden by LKMM cumulativity.
>  
>  Z6.0+pooncelock+pooncelock+pombonce.litmus
>  	Is the ordering provided by a spin_unlock() and a subsequent
> diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
> index 97fcbffde9a0..5bda4784eb34 100644
> --- a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
> +++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
> @@ -5,7 +5,8 @@ C WRC+pooncerelease+rmbonceonce+Once
>   *
>   * This litmus test is an extension of the message-passing pattern, where
>   * the first write is moved to a separate process.  Because it features
> - * a release and a read memory barrier, it should be forbidden.
> + * a release and a read memory barrier, it should be forbidden.  This
> + * litmus test exercises LKMM cumulativity.
>   *)
>  
>  {}
> 
