Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164284AbeBOWFt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:05:49 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36488 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163005AbeBOWFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:05:48 -0500
X-Google-Smtp-Source: AH8x226+kwnQYEWVxzO/8vc5O6x1P8NVBtJflZ9pG50LnA8H6q3CtrP+4PNvnJNWB2v+Kvl3IpQ56w==
Date: Thu, 15 Feb 2018 23:05:39 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: Trial of conflict resolution of Alan's patch
Message-ID: <20180215220539.GA5363@andrea>
References: <fa35db31-7a73-4865-1505-5378dcb2a0f8@gmail.com>
 <Pine.LNX.4.44L0.1802151246190.1286-100000@iolanthe.rowland.org>
 <20180215192914.GA3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215192914.GA3617@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 11:29:14AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 15, 2018 at 12:51:56PM -0500, Alan Stern wrote:
> > On Fri, 16 Feb 2018, Akira Yokosawa wrote:
> > 
> > > So, I attempted to rebase the patch to current (somewhat old) master of
> > > https://github.com/aparri/memory-model. Why? Because the lkmm branch
> > > in Paul's -rcu tree doesn't have linux-kernel-hardware.cat.
> > > 
> > > However, after this change, Z6.0+pooncelock+pooncelock+pombonce still
> > > has the result "Sometimes". I must have done something wrong in the
> > > conflict resolution.
> > > 
> > > Note: I have almost no idea what this patch is doing. I'm just hoping
> > > to give a starting point of a discussion.
> > 
> > Yes, that litmus test gives "Sometimes" both with and without the 
> > patch.  But consider instead this slightly changed version of that 
> > test, in which P2 reads Z instead of writing it:
> > 
> > C Z6.0-variant
> > 
> > {}
> > 
> > P0(int *x, int *y, spinlock_t *mylock)
> > {
> > 	spin_lock(mylock);
> > 	WRITE_ONCE(*x, 1);
> > 	WRITE_ONCE(*y, 1);
> > 	spin_unlock(mylock);
> > }
> > 
> > P1(int *y, int *z, spinlock_t *mylock)
> > {
> > 	int r0;
> > 
> > 	spin_lock(mylock);
> > 	r0 = READ_ONCE(*y);
> > 	WRITE_ONCE(*z, 1);
> > 	spin_unlock(mylock);
> > }
> > 
> > P2(int *x, int *z)
> > {
> > 	int r1;
> > 	int r2;
> > 
> > 	r2 = READ_ONCE(*z);
> > 	smp_mb();
> > 	r1 = READ_ONCE(*x);
> > }
> > 
> > exists (1:r0=1 /\ 2:r2=1 /\ 2:r1=0)
> > 
> > Without the patch, this test gives "Sometimes"; with the patch it gives 
> > "Never".  That is what I thought Paul was talking about originally.  
> > 
> > Sorry if my misunderstanding caused too much confusion for other 
> > people.
> 
> Ah, I did indeed get confused.  I have changed the "Result:" for
> Z6.0+pooncelock+pooncelock+pombonce.litmus back to "Never", as in
> the patch below (which I merged into the patch adding all the
> comments).
> 
> I have added the above test as ISA2+pooncelock+pooncelock+pombonce.litmus,
> with the Result: of Sometimes with you (Alan) as author and with your
> Signed-off-by -- please let me know if you would prefer some other
> approach.
> 
> Please change the Result: when sending the proposed patch.  Or please let
> me know if you would like me to apply the forward-port that Akira sent,
> in which case I will add the Result: change to that patch.  Or for that
> matter, Akira might repost his forward-port of your patch with this change.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit b2950420e1154131c0667f1ac58666bad3a06a69
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Thu Feb 15 10:35:25 2018 -0800
> 
>     fixup! EXP litmus_tests:  Add comments explaining tests' purposes
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> index fad47258a3e3..95890669859b 100644
> --- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> +++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> @@ -1,7 +1,7 @@
>  C Z6.0+pooncelock+pooncelock+pombonce
>  
>  (*
> - * Result: Never
> + * Result: Somtimes

nit: s/Somtimes/Sometimes

  Andrea


>   *
>   * This example demonstrates that a pair of accesses made by different
>   * processes each while holding a given lock will not necessarily be
> 
