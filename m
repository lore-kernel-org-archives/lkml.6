Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeDTQtg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:49:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:50977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbeDTQtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:49:32 -0400
Message-ID: <1524242934.5239.1.camel@gmx.de>
Subject: Re: [PATCH 2/2] rtmutex: Reduce top-waiter blocking on a lock
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc: tglx@linutronix.de, mingo@kernel.org, longman@redhat.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbues@suse.de>
Date: Fri, 20 Apr 2018 18:48:54 +0200
In-Reply-To: <20180420155028.GO4064@hirez.programming.kicks-ass.net>
References: <20180410162750.8290-1-dave@stgolabs.net>
         <20180410162750.8290-2-dave@stgolabs.net>
         <20180420155028.GO4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:uD3i+FCVnloLhP3sxVPdWD+FvV7jWAuwQ4dpOCXY8qT1ec6nQy8
 LThpfedPBiocYwTsYaqkhef+qDZdWAvEBbmxFgWMXs9z64cV3e1HL9TOj3NNhWAuOk2O/YO
 eWN9TRzibYlk+76p/j9oR+lsTbofNX+HbMkVW8Ih+xkxO974d/pYjhud9/ub2ORRPel30P/
 c6Ry05Bj1Qc9tjnm3bh9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0pVnDyrWdh8=:WJF+DIKVN7/k5OQz8P79kT
 6XM6cNjDvWLJ6sDR3xItzEH79mtxmituPnHIB617GnVeDMrtLfIUtvxoDH+3IAS06/e+tstNw
 oI3ehQYQkk2MB8HbJ9x8yK7oXlzmgTwr7D3BBpMHh5a07iQjDXVc+D9b5NXHGNF4tAIhpUPP2
 JK32XDmU0jqYOqNmWzEt8P7UrM6VXvymFNe8864q9g47C4luW8OZEEomk7shAxApTMAV83gHc
 tKrvGYGr2Wakcp7SC5JJZRylILtROKq/dxPxYGfW79I7I9Bjx6PVKbAU+e2ur4BcVaHGiIgLS
 r149wsB3ieBB2MXPcIfdqm8PRMLpjOQZ8uxYwTUkAe70V+FSwT9ChPH8590A6ajWPXluIpZHS
 1u7jWMqJQNfiR1TZcdSL8U1X/P+OYNf6CC8uuTwBoM0XHmMfKAO+kauZDnN/542qkBaJfHXn3
 2xAEulfwJfrBKVtLUp6VdwV23W1E4pra0v6Xi/a/WuVD7Dd4shoIiodDGUyjZUm/KWcq6Fw6k
 /FFgGcpAGT8fFYRwKKi7HR7sstI9b5qSGg1wZpLcfjGUvUqAKN/KTGcyvSbqgLTzQiE5dNdXH
 zngxK3PG9OgK+eSWemaIquh6beUyFa4gqldCMYoVXK4VLxHo2sQrzrgQ5kmB5lvlzA+J+hOQx
 3L0FyV5bcHfDzq4sV36FATOmCvu6mvOZQ7gbRSVNHU04ZokiI++zVBJ7SvtocOpunfs5bsYbQ
 QSRonadVB+uHPLZclGx9LIMCaaxZPbzUpp4irPdlYADiftnW64S5eEg3VCkMShcXXH9JkEm8c
 er9jbQPMYQTkDhU2rIiRIriVoTEvsKhD+kVVzRKWtZof79/Ksg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-20 at 17:50 +0200, Peter Zijlstra wrote:
> On Tue, Apr 10, 2018 at 09:27:50AM -0700, Davidlohr Bueso wrote:
> > By applying well known spin-on-lock-owner techniques, we can avoid the
> > blocking overhead during the process of when the task is trying to take
> > the rtmutex. The idea is that as long as the owner is running, there is a
> > fair chance it'll release the lock soon, and thus a task trying to acquire
> > the rtmutex will better off spinning instead of blocking immediately after
> > the fastpath. This is similar to what we use for other locks, borrowed
> > from -rt. The main difference (due to the obvious realtime constraints)
> > is that top-waiter spinning must account for any new higher priority waiter,
> > and therefore cannot steal the lock and avoid any pi-dance. As such there
> > will be at most only one spinner waiter upon contended lock.
> > 
> > Conditions to stop spinning and block are simple:
> > 
> > (1) Upon need_resched()
> > (2) Current lock owner blocks
> > (3) The top-waiter has changed while spinning.
> > 
> > The unlock side remains unchanged as wake_up_process can safely deal with
> > calls where the task is not actually blocked (TASK_NORMAL). As such, there
> > is only unnecessary overhead dealing with the wake_q, but this allows us not
> > to miss any wakeups between the spinning step and the unlocking side.
> > 
> > Passes running the pi_stress program with increasing thread-group counts.
> 
> Is this similar to what we have in RT (which, IIRC, has an optimistic
> spinning implementation as well)?

For the RT spinlock replacement, the top waiter can spin.

> ISTR there being some contention over the exact semantics of (3) many
> years ago. IIRC the question was if an equal priority task was allowed
> to steal; because lock stealing can lead to fairness issues. One would
> expect two FIFO-50 tasks to be 'fair' wrt lock acquisition and not
> starve one another.
> 
> Therefore I think we only allowed higher prio tasks to steal and kept
> FIFO order for equal prioty tasks.

Yup, lateral steal is expressly forbidden for RT classes.

+#define STEAL_NORMAL  0
+#define STEAL_LATERAL 1
+
+static inline int
+rt_mutex_steal(struct rt_mutex *lock, struct rt_mutex_waiter *waiter, int mode)
+{
+       struct rt_mutex_waiter *top_waiter = rt_mutex_top_waiter(lock);
+
+       if (waiter == top_waiter || rt_mutex_waiter_less(waiter, top_waiter))
+               return 1;
+
+       /*
+        * Note that RT tasks are excluded from lateral-steals
+        * to prevent the introduction of an unbounded latency.
+        */
+       if (mode == STEAL_NORMAL || rt_task(waiter->task))
+               return 0;
+
+       return rt_mutex_waiter_equal(waiter, top_waiter);
+}
+
