Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934106AbeE1Uvn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:51:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33828 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeE1Uvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:51:40 -0400
X-Google-Smtp-Source: AB8JxZrQmqPcroApS6r7FQuh/FIoxPBjXwIfwvS53HN5IbwscoATvbh9n9rFCBROm1+MRBUwoP+7yA==
Date: Mon, 28 May 2018 13:51:38 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: Re: [PATCH v3 1/2] rtmutex: allow specifying a subclass for nested
 locking
Message-ID: <20180528205138.GA189841@joelaf.mtv.corp.google.com>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
 <20180524135240.10881-1-peda@axentia.se>
 <20180524135240.10881-2-peda@axentia.se>
 <20180528051936.GA205298@joelaf.mtv.corp.google.com>
 <20180528071751.GT12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528071751.GT12180@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 09:17:51AM +0200, Peter Zijlstra wrote:
> On Sun, May 27, 2018 at 10:19:36PM -0700, Joel Fernandes wrote:
> 
> > > +static inline void __rt_mutex_lock(struct rt_mutex *lock, unsigned int subclass)
> > > +{
> > > +	might_sleep();
> > > +
> > > +	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
> > > +	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
> > > +}
> > > +
> > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > +/**
> > > + * rt_mutex_lock_nested - lock a rt_mutex
> > 
> > This ifdef seems consistent with other nested locking primitives, but its
> > kind of confusing.
> > 
> > The Kconfig.debug for DEBUG_LOCK_ALLOC says:
> > 
> > config DEBUG_LOCK_ALLOC
> > 	bool "Lock debugging: detect incorrect freeing of live locks"
> > 	[...]
> > 	help
> > 	 This feature will check whether any held lock (spinlock, rwlock,
> > 	 mutex or rwsem) is incorrectly freed by the kernel, via any of the
> > 	 memory-freeing routines (kfree(), kmem_cache_free(), free_pages(),
> > 	 vfree(), etc.), whether a live lock is incorrectly reinitialized via
> > 	 spin_lock_init()/mutex_init()/etc., or whether there is any lock
> > 	 held during task exit.
> > 
> > Shouldn't this ideally be ifdef'd under PROVE_LOCKING for this and other
> > locking primitives? Any idea what's the reason? I know PROVE_LOCKING selects
> > DEBUG_LOCK_ALLOC but still..
> 
> No, the reason is that DEBUG_LOCK_ALLOC needs the lockdep hooks to know
> which locks are held, so it can warn when we try and free a held one.
> PROVE_LOCKING builds upon that.
> 
> The the locking primitives should key off of DEBUG_LOCK_ALLOC for
> introducing the hooks.

Got it, thanks for the clarification Peter!

Regards,

 -Joel
