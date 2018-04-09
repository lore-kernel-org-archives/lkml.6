Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeDIOWM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:22:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751367AbeDIOWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:22:11 -0400
Date: Mon, 9 Apr 2018 16:22:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] locking/rwsem: Add up_write_non_owner() for
 percpu_up_write()
Message-ID: <20180409142208.GA25893@redhat.com>
References: <1522852646-2196-1-git-send-email-longman@redhat.com>
 <20180409112013.GA23240@redhat.com>
 <38c89c59-5ff0-20df-2628-880db397006e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c89c59-5ff0-20df-2628-880db397006e@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09, Waiman Long wrote:
>
> On 04/09/2018 07:20 AM, Oleg Nesterov wrote:
> > Hmm. Can you look at lockdep_sb_freeze_release() and lockdep_sb_freeze_acquire()?
>
> These 2 functions are there to deal with the lockdep code.

Plus they clearly document why sem->owner check is not right when it comes
to super_block->s_writers[]. Not only freeze and thaw can be called by
different processes, we need to return to user-space with rwsem held for
writing.

> > At first glance, it would be much better to set sem->owner = current in
> > percpu_rwsem_acquire(), no?
>
> The primary purpose of the owner field is to enable optimistic spinning
> to improve locking performance. So it needs to be set during an
> up_write() call.

Unless, again, the "owner" has to do lockdep_sb_freeze_release() for any
reason.

And please note that percpu_rwsem_release() already clears rw_sem.owner.
It checks CONFIG_RWSEM_SPIN_ON_OWNER, but this is simply because
rw_semaphore->owner doesn't exist otherwise.

> My rwsem debug patch does use it also to check for consistency in the
> use of lock/unlock call. Anyway, I don't think it is right to set it
> again in percpu_rwsem_acquire() if there is no guarantee that the task
> that call percpu_rwsem_acquire will be the one that will do the unlock.

Hmm. Perhaps I missed something, but I think this should be true.

Of course, you need to check "if (!read)", but again, this is what
percpu_rwsem_release() already does.

> I am wondering if it makes sense to do optimistic spinning in the case
> of percpu_rwsem where the unlocker may be a different task.

Again, perhaps I missed something, but see above. percpu_rwsem does not
really differ from the regular rwsem, however its usage in sb->s_writers[]
differs.

Oleg.
