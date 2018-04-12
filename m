Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDLJXP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:23:15 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45702 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeDLJXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:23:13 -0400
X-Google-Smtp-Source: AIpwx4+KUJ3R+BlPm4l+TfOzS5Z15OxiK5gkN3QZM6l6mg+DKwjjM4MgCTLdifqpxO5c8lJ8PHBb+w==
Date: Thu, 12 Apr 2018 11:23:03 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
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
Message-ID: <20180412092303.GA6044@andrea>
References: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
 <20180409184258.GP3948@linux.vnet.ibm.com>
 <20180410203214.GA19606@linux.vnet.ibm.com>
 <8cbda122-6aa3-365b-fd09-52dca0644cbd@redhat.com>
 <20180410213434.GC3948@linux.vnet.ibm.com>
 <156ac07b-7393-449f-518a-6b1c2cff8efb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156ac07b-7393-449f-518a-6b1c2cff8efb@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 01:15:58PM +0200, Paolo Bonzini wrote:
> On 10/04/2018 23:34, Paul E. McKenney wrote:
> > Glad it helps, and I have queued it for the next merge window.  Of course,
> > if a further improvement comes to mind, please do not keep it a secret.  ;-)
> 
> Yes, there are several changes that could be included:

Thank you for looking into this and for the suggestions.


> 
> - SV could be added to the prior operation case as well?  It should be
> symmetric

Seems reasonable to me.


> 
> - The *_relaxed() case also applies to void RMW

Indeed. *_relaxed() and void RMW do present some semantics differences
(c.f., e.g., 'Noreturn' in the definition of 'rmb' from the .cat file),
but the cheat sheet seems to be already 'cheating' here. ;-)


> 
> - smp_store_mb() is missing

Good point. In fact, we could add this to the model as well: following
Peter's remark/the generic implementation,

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 397e4e67e8c84..acf86f6f360a7 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -14,6 +14,7 @@ smp_store_release(X,V) { __store{release}(*X,V); }
 smp_load_acquire(X) __load{acquire}(*X)
 rcu_assign_pointer(X,V) { __store{release}(X,V); }
 rcu_dereference(X) __load{once}(X)
+smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
 
 // Fences
 smp_mb() { __fence{mb} ; }

... unless I'm missing something here: I'll send a patch with this.


> 
> - smp_rmb() orders prior reads fully against subsequent RMW because SV
> applies between the two parts of the RMW; likewise smp_wmb() orders prior
> RMW fully against subsequent writes

It could be argued that this ordering is the result of the combination
of two 'mechanisms' (barrier+SV/atomicity), and that it makes sense to
distinguish them... But either way would be fine for me.


> 
> 
> I am going submit these changes separately, but before doing that I can show
> also my rewrite of the cheat sheet.
> 
> The advantage is that, at least to me, it's clearer (and gets rid of
> "Self" :)).
> 
> The disadvantage is that it's much longer---almost twice the lines, even if
> you discount the splitting out of cumulative/propagating to a separate table
> (which in turn is because to me it's a different level of black magic).

Yeah, those 'Ordering is cumulative', 'Ordering propagates' could mean
different things to different readers... (and I'm not going to attempt
some snappy descriptions now). IMO, we may even omit such information;
this doc. does not certainly aim for completeness, after all. OTOH, we
ought to refrain from making this doc. an excuse to transform (what it
is really) high-school maths into some black magic. ;-) So once again,
thank you for your feedback!

  Andrea


> 
> ---------------------
> Memory operations are listed in this document as follows:
> 
> 	R:	Read portion of RMW
> 	W:	Write portion of RMW
> 	DR:	Dependent read (address dependency)
> 	DW:	Dependent write (address, data, or control dependency)
> 	RMW:	Atomic read-modify-write operation
> 	SV	Other accesses to the same variable
> 
> 
> Memory access operations order other memory operations against themselves as
> follows:
> 
>                                    Prior Operation   Subsequent Operation
>                                    ---------------   ---------------------
>                                    R  W  RMW  SV     R  W  DR  DW  RMW  SV
>                                    -  -  ---  --     -  -  --  --  ---  --
> Store, e.g., WRITE_ONCE()                      Y                         Y
> Load, e.g., READ_ONCE()                        Y            Y   Y        Y
> Unsuccessful RMW operation                     Y            Y   Y        Y
> *_relaxed() or void RMW operation              Y            Y   Y        Y
> rcu_dereference()                              Y            Y   Y        Y
> Successful *_acquire()                         Y      r  r  r   r    r   Y
> Successful *_release()             w  w    w   Y                         Y
> smp_store_mb()                     Y  Y    Y   Y      Y  Y   Y   Y   Y   Y
> Successful full non-void RMW       Y  Y    Y   Y      Y  Y   Y   Y   Y   Y
> 
> Key:	Y:	Memory operation provides ordering
> 	r:	Cannot move past the read portion of the *_acquire()
> 	w:	Cannot move past the write portion of the *_release()
> 
> 
> Memory barriers order prior memory operations against subsequent memory
> operations.  Two operations are ordered if both have non-empty cells in
> the following table:
> 
>                                    Prior Operation   Subsequent Operation
>                                    ---------------   --------------------
>                                    R  W  RMW         R  W  DR  DW  RMW
>                                    -  -  ---         -  -  --  --  ---
> smp_rmb()                          Y      r          Y      Y       Y
> smp_wmb()                             Y   Y             Y       Y   w
> smp_mb() & synchronize_rcu()       Y  Y   Y          Y  Y   Y   Y   Y
> smp_mb__before_atomic()            Y  Y   Y          a  a   a   a   Y
> smp_mb__after_atomic()             a  a   Y          Y  Y   Y   Y
> 
> 
> Key:	Y:	Barrier provides ordering
> 	r:	Barrier provides ordering against the read portion of RMW
> 	w:	Barrier provides ordering against the write portion of RMW
> 	a:	Barrier provides ordering given intervening RMW atomic operation
> 
> 
> Finally the following describes which operations provide cumulative and
> propagating fences:
> 
>                                      Cumulative         Propagates
>                                      ----------         ----------
> Store, e.g., WRITE_ONCE()
> Load, e.g., READ_ONCE()
> Unsuccessful RMW operation
> *_relaxed() or void RMW operation
> rcu_dereference()
> Successful *_acquire()
> Successful *_release()                   Y
> smp_store_mb()                           Y                  Y
> Successful full non-void RMW             Y                  Y
> smp_rmb()
> smp_wmb()
> smp_mb() & synchronize_rcu()             Y                  Y
> smp_mb__before_atomic()                  Y                  Y
> smp_mb__after_atomic()                   Y                  Y
> ----------
> 
> Perhaps you can see some obvious improvements.  Otherwise I'll send patches
> for the above issues.
> 
> Thanks,
> 
> Paolo
