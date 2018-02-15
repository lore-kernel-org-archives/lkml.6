Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164563AbeBOXUI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:20:08 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39093 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163785AbeBOXUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:20:06 -0500
X-Google-Smtp-Source: AH8x227hQTg3yl0XqWGnbVaMML7cWsIcXiFnF1anbEi97OO3b2sTP6qYE3tpkecr7C2fNyRWHnNQnA==
Date: Fri, 16 Feb 2018 00:19:58 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC tip/lkmm 08/10] EXP Remove understore from
 smp_mb__before_atomic() workings
Message-ID: <20180215231958.GA7422@andrea>
References: <20180209141832.GA17505@linux.vnet.ibm.com>
 <1518186031-17997-8-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180215223009.GA5460@andrea>
 <20180215224937.GD3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215224937.GD3617@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 02:49:37PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 15, 2018 at 11:30:09PM +0100, Andrea Parri wrote:
> > On Fri, Feb 09, 2018 at 06:20:29AM -0800, Paul E. McKenney wrote:
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > nit: s/understore/underscore  (a very understandable lapsus, BTW ;-)
> 
> ;-)
> 
> Will fix when squashing.
> 
> > According to the cover letter, patches 8-10 of this series are intended
> > to be squashed together;  it could be useful to add a description then:
> > the motivation for these changes might appear "trivial" today;  months/
> > years from now?  mmh, I can't put my finger on it ;-)
> 
> Assuming we keep these patches, agreed.  Something like this for the
> aggregated single commit, perhaps:
> 
> 	tools/memory-model: Convert underscores to hyphens
> 
> 	Typical cat-language code uses hyphens for word separators in
> 	identifiers, but several LKMM identifiers use underscores instead.
> 	This commit therefore converts the underscores in the .bell and
> 	.cat files for smp_mb__before_atomic(), smp_mb__after_atomic(),
> 	and smp_mb__after_spinlock() to hyphens.
> 
> > IMO,  this descrition should also mention why this solution "is the way
> > to go" (e.g., compare with the solution recently implemented by Akira).
> 
> You lost me here.  Or are you asking for a commit log similar to that
> provided by Akira for his forward-port of Alan's unrelated patch?  If
> so, please see above.

I was mainly thinking "but rb_dep...";  or you're also planning to
rename this annotation and, maybe, the "rb-dep" relation (in order
to avoid the conflict)?

  Andrea


> 
> 							Thanx, Paul
> 
> >   Andrea
> > 
> > 
> > > ---
> > >  tools/memory-model/linux-kernel.bell | 2 +-
> > >  tools/memory-model/linux-kernel.cat  | 2 +-
> > >  tools/memory-model/linux-kernel.def  | 2 +-
> > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> > > index b984bbda01a5..558bbef9e08a 100644
> > > --- a/tools/memory-model/linux-kernel.bell
> > > +++ b/tools/memory-model/linux-kernel.bell
> > > @@ -28,7 +28,7 @@ enum Barriers = 'wmb (*smp_wmb*) ||
> > >  		'rcu-lock (*rcu_read_lock*)  ||
> > >  		'rcu-unlock (*rcu_read_unlock*) ||
> > >  		'sync-rcu (*synchronize_rcu*) ||
> > > -		'before_atomic (*smp_mb__before_atomic*) ||
> > > +		'before-atomic (*smp_mb__before_atomic*) ||
> > >  		'after_atomic (*smp_mb__after_atomic*) ||
> > >  		'after_spinlock (*smp_mb__after_spinlock*)
> > >  instructions F[Barriers]
> > > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > > index babe2b3b0bb3..31c08a44c088 100644
> > > --- a/tools/memory-model/linux-kernel.cat
> > > +++ b/tools/memory-model/linux-kernel.cat
> > > @@ -29,7 +29,7 @@ let rb-dep = [R] ; fencerel(Rb_dep) ; [R]
> > >  let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
> > >  let wmb = [W] ; fencerel(Wmb) ; [W]
> > >  let mb = ([M] ; fencerel(Mb) ; [M]) |
> > > -	([M] ; fencerel(Before_atomic) ; [RMW] ; po? ; [M]) |
> > > +	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> > >  	([M] ; po? ; [RMW] ; fencerel(After_atomic) ; [M]) |
> > >  	([M] ; po? ; [LKW] ; fencerel(After_spinlock) ; [M])
> > >  let gp = po ; [Sync-rcu] ; po?
> > > diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> > > index a397387f77cc..ff4b756f4a44 100644
> > > --- a/tools/memory-model/linux-kernel.def
> > > +++ b/tools/memory-model/linux-kernel.def
> > > @@ -21,7 +21,7 @@ smp_mb() { __fence{mb} ; }
> > >  smp_rmb() { __fence{rmb} ; }
> > >  smp_wmb() { __fence{wmb} ; }
> > >  smp_read_barrier_depends() { __fence{rb_dep}; }
> > > -smp_mb__before_atomic() { __fence{before_atomic} ; }
> > > +smp_mb__before_atomic() { __fence{before-atomic} ; }
> > >  smp_mb__after_atomic() { __fence{after_atomic} ; }
> > >  smp_mb__after_spinlock() { __fence{after_spinlock} ; }
> > >  
> > > -- 
> > > 2.5.2
> > > 
> > 
> 
