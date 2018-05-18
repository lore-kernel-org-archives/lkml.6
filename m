Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeERJk6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:40:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44095 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeERJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:40:56 -0400
X-Google-Smtp-Source: AB8JxZoMhenQVUBUrEUyGlh5ktIRcpuA3MfmovVYSaafORLpqeWVaWc58SfBHtPQtPfOkRV5L/NQHw==
Date: Fri, 18 May 2018 11:40:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
Message-ID: <20180518094052.GA26150@gmail.com>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
 <1526420991-21213-2-git-send-email-longman@redhat.com>
 <20180516121947.GE20670@bombadil.infradead.org>
 <20180518070258.GA20971@gmail.com>
 <20180518084122.GA14307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518084122.GA14307@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@redhat.com> wrote:

> On 05/18, Ingo Molnar wrote:
> >
> >
> > * Matthew Wilcox <willy@infradead.org> wrote:
> >
> > > This is confusingly written.  I think you mean ...
> > >
> > > 	if (!owner)
> > > 		goto done;
> > > 	if (!is_rwsem_owner_spinnable(owner)) {
> > > 		ret = false;
> > > 		goto done;
> > > 	}
> >
> > Yes, that's cleaner. Waiman, mind sending a followup patch that cleans this up?
> 
> Or simply
> 
> 	static inline bool owner_on_cpu(struct task_struct *owner)
> 	{
> 		return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
> 	}
> 
> 	static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> 	{
> 		struct task_struct *owner;
> 		bool ret = true;
> 
> 		if (need_resched())
> 			return false;
> 
> 		rcu_read_lock();
> 		owner = READ_ONCE(sem->owner);
> 		if (owner) {
> 			ret = is_rwsem_owner_spinnable(owner) &&
> 			      owner_on_cpu(owner);
> 		}
> 		rcu_read_unlock();
> 		return ret;
> 	}
> 
> note that rwsem_spin_on_owner() can use the new owner_on_cpu() helper too,
> 
> 		if (need_resched() || !owner_on_cpu(owner)) {
> 			rcu_read_unlock();
> 			return false;
> 		}
> 
> looks a bit better than the current code:
> 
> 		if (!owner->on_cpu || need_resched() ||
> 				vcpu_is_preempted(task_cpu(owner))) {
> 			rcu_read_unlock();
> 			return false;
> 		}
> 
> Oleg.

That looks good to me too - mind sending a patch on top of latest -tip?

Thanks,

	Ingo
