Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeEOJA4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:00:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:52290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752162AbeEOJAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:00:54 -0400
Date: Tue, 15 May 2018 11:00:52 +0200
From: Jan Kara <jack@suse.cz>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v2 2/2] locking/percpu-rwsem: Mark rwsem as
 non-spinnable in percpu_rwsem_release()
Message-ID: <20180515090052.cvlt3e7ue6bm4c2c@quack2.suse.cz>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
 <1526326267-22501-3-git-send-email-longman@redhat.com>
 <20180515083525.GV12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515083525.GV12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-05-18 10:35:25, Peter Zijlstra wrote:
> On Mon, May 14, 2018 at 03:31:07PM -0400, Waiman Long wrote:
> > The percpu_rwsem_release() is called when the ownership of the embedded
> > rwsem is to be transferred to another task. The new owner, however, may
> > take a while to get the ownership of the lock via percpu_rwsem_acquire().
> > During that period, the rwsem is now marked as writer-owned with no
> > optimistic spinning.
> 
> This does not explain the problem sufficiently to even begin considering
> if the proposed solution is sensible.

So the original problem is following: There is percpu_rw_semaphore in
super_block which is used to implement filesystem freezing (actually three
of them but that's not really substantial here). This semaphore is acquired
for writing when a fs is frozen (i.e., in response to a syscall) and we
return to userspace with this semaphore held. Later someone else calls
another syscall to unfreeze the filesystem which drops the semaphore.

Now this behavior upsets lockdep and that's why we fool it by telling the
semaphore got released before returning to userspace (through
percpu_rwsem_release() helper) and similarly we tell lockdep we've got the
semaphore when an unfreeze syscall is called by percpu_rwsem_acquire(). Now
Amir has discovered that also rwsem debugging code gets confused by this
behavior and previously also someone noticed that rwsem spinning does not
make sense and can be broken by this behavior. So these patches from Waiman
try to fix up all these problems...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
