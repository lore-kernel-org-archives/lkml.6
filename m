Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeEOIvY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:51:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeEOIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:51:22 -0400
Date: Tue, 15 May 2018 10:51:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v2 2/2] locking/percpu-rwsem: Mark rwsem as
 non-spinnable in percpu_rwsem_release()
Message-ID: <20180515085111.GW12217@hirez.programming.kicks-ass.net>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
 <1526326267-22501-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526326267-22501-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 03:31:07PM -0400, Waiman Long wrote:
> The percpu_rwsem_release() is called when the ownership of the embedded
> rwsem is to be transferred to another task. The new owner, however, may
> take a while to get the ownership of the lock via percpu_rwsem_acquire().
> During that period, the rwsem is now marked as writer-owned with no
> optimistic spinning.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/percpu-rwsem.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index b1f37a8..dd37102 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -131,16 +131,16 @@ static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
>  					bool read, unsigned long ip)
>  {
>  	lock_release(&sem->rw_sem.dep_map, 1, ip);
> -#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
>  	if (!read)
> -		sem->rw_sem.owner = NULL;
> -#endif
> +		rwsem_set_writer_owned_nospin(&sem->rw_sem);
>  }
>  
>  static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
>  					bool read, unsigned long ip)
>  {
>  	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
> +	if (!read)
> +		rwsem_set_writer_owned(&sem->rw_sem, current);
>  }

So what's wrong with adding:

	if (!read)
		sem->rw_sem.owner = current;

?

Afaict the whole .owner=NULL thing in release already stops the spinners
dead, and the above 'fixes' the debug splat. And this avoids exposing
that horrible interface and keeps the mucking private to
rwsem/percpu_rwsem.
