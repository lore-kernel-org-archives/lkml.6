Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756747AbeDZPaI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:30:08 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33235 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756627AbeDZPaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:30:03 -0400
X-Google-Smtp-Source: AB8JxZqdbQel9QndiIDyN5U0e8cqGBF/a2miWOkRi4/hrD2fcRVKNAd8wOMyU2vWxqtghYT7fDRaqw==
Date: Thu, 26 Apr 2018 17:29:42 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, mhocko@suse.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, ebiederm@xmission.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 4/4] exit: Lockless iteration over task list in
 mm_update_next_owner()
Message-ID: <20180426152942.GA2737@andrea>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <152474046779.29458.5294808258041953930.stgit@localhost.localdomain>
 <20180426123542.GA819@andrea>
 <c21ad28c-cd23-2a75-6622-ba49c37137db@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c21ad28c-cd23-2a75-6622-ba49c37137db@virtuozzo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 04:52:39PM +0300, Kirill Tkhai wrote:
> On 26.04.2018 15:35, Andrea Parri wrote:

[...]

> > 
> > Mmh, it's possible that I am misunderstanding this statement but it does
> > not seem quite correct to me; a counter-example would be provided by the
> > test at "tools/memory-model/litmus-tests/SB+mbonceonces.litmus" (replace
> > either of the smp_mb() with the sequence:
> > 
> >    spin_lock(s); spin_unlock(s); spin_lock(s); spin_unlock(s); ).
> > 
> > BTW, your commit message suggests that your case would work with "imply
> > an smp_wmb()".  This implication should hold "w.r.t. current implementa-
> > tions".  We (LKMM people) discussed changes to the LKMM to make it hold
> > in LKMM but such changes are still in our TODO list as of today...
> 
> I'm not close to LKMM, so the test you referenced is not clear for me.

The test could be concisely described by:

   {initially: x=y=0; }

   Thread0	Thread1

   x = 1;	y = 1;
   MB		MB
   r0 = y;	r1 = x;

   Can r0,r1 be both 0 after joining?

The answer to the question is -No-; however, if you replaced any of the
MB with the locking sequence described above, then the answer is -Yes-:
full fences on both sides are required to forbid that state and this is
something that the locking sequences won't be able to provide (think at
the implementation of these primitives for powerpc, for example).


> Does LKMM show the real hardware behavior? Or there are added the most
> cases, and work is still in progress?

Very roughly speaking, LKMM is an "envelope" of the underlying hardware
memory models/architectures supported by the Linux kernel which in turn
may not coincide with the observable behavior on a given implementation
/processor of that architecture.  Also, LKMM doesn't aim to be a "tight"
envelope.  I'd refer to the documentation within "tools/memory-model/";
please let me know if I can provide further info.


> 
> In the patch I used the logic, that the below code:
> 
> 	x = A;
> 	spin_lock();
> 	spin_unlock();
> 	spin_lock();
> 	spin_unlock();
> 	y = B;
> 
> cannot reorder much than:
> 
> 	spin_lock();
> 	x = A;		<- this can't become visible later, that spin_unlock()
> 	spin_unlock();
> 	spin_lock();
> 	y = B;		<- this can't become visible earlier, than spin_lock()
> 	spin_unlock();
> 
> Is there a problem?

As mentioned in the previous email, if smp_wmb() is what you're looking
for then this should be fine (considering current implementations; LKMM
will likely be there soon...).

BTW, the behavior in question has been recently discussed on the list;
c.f., for example, the test "unlock-lock-write-ordering" described in:

  http://lkml.kernel.org/r/1519301990-11766-1-git-send-email-parri.andrea@gmail.com

as well as

  0123f4d76ca63b7b895f40089be0ce4809e392d8
  ("riscv/spinlock: Strengthen implementations with fences")

  Andrea


> 
> Kirill
