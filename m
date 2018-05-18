Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753672AbeERIlb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:41:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751966AbeERIl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:41:28 -0400
Date: Fri, 18 May 2018 10:41:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
Message-ID: <20180518084122.GA14307@redhat.com>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
 <1526420991-21213-2-git-send-email-longman@redhat.com>
 <20180516121947.GE20670@bombadil.infradead.org>
 <20180518070258.GA20971@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518070258.GA20971@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18, Ingo Molnar wrote:
>
>
> * Matthew Wilcox <willy@infradead.org> wrote:
>
> > This is confusingly written.  I think you mean ...
> >
> > 	if (!owner)
> > 		goto done;
> > 	if (!is_rwsem_owner_spinnable(owner)) {
> > 		ret = false;
> > 		goto done;
> > 	}
>
> Yes, that's cleaner. Waiman, mind sending a followup patch that cleans this up?

Or simply

	static inline bool owner_on_cpu(struct task_struct *owner)
	{
		return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
	}

	static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
	{
		struct task_struct *owner;
		bool ret = true;

		if (need_resched())
			return false;

		rcu_read_lock();
		owner = READ_ONCE(sem->owner);
		if (owner) {
			ret = is_rwsem_owner_spinnable(owner) &&
			      owner_on_cpu(owner);
		}
		rcu_read_unlock();
		return ret;
	}

note that rwsem_spin_on_owner() can use the new owner_on_cpu() helper too,

		if (need_resched() || !owner_on_cpu(owner)) {
			rcu_read_unlock();
			return false;
		}

looks a bit better than the current code:

		if (!owner->on_cpu || need_resched() ||
				vcpu_is_preempted(task_cpu(owner))) {
			rcu_read_unlock();
			return false;
		}

Oleg.
