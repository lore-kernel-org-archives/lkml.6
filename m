Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeENLvz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:51:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753116AbeENLvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:51:54 -0400
Date: Mon, 14 May 2018 13:51:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: DEBUG_RWSEMS warning from thaw_super()
Message-ID: <20180514115149.GA8905@redhat.com>
References: <CAOQ4uxgxP-0OZzT866=RR5rGQZ89EOy-mFF50v_5Y644OrV7tA@mail.gmail.com>
 <20180513160404.GA19620@redhat.com>
 <20180514095022.nfp7vuepz4kfshni@quack2.suse.cz>
 <CAOQ4uxiKQDB-5iFztNz8wPECi5fKMPxEi5cxaKM_zRc9yeticQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiKQDB-5iFztNz8wPECi5fKMPxEi5cxaKM_zRc9yeticQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14, Amir Goldstein wrote:
>
> On Mon, May 14, 2018 at 12:50 PM, Jan Kara <jack@suse.cz> wrote:
> > On Sun 13-05-18 18:04:04, Oleg Nesterov wrote:
> >> On 05/13, Amir Goldstein wrote:
> >> >
> >> > Since kernel v4.17-rc1 and DEBUG_RWSEMS, I see the
> >> > warning below after filesystem freeze/thaw.
> >> >
> >> > This is a case where one process acquires a bunch of rwsem
> >> > and another process releases them.
> >> >
> >> > To convey this use case to lockdep, freeze_super() calls
> >> > lockdep_sb_freeze_release() on exit and thaw_super()
> >> > calls lockdep_sb_freeze_acquire() on entry.
> >>
> >> This was already discussed, but I forgot the result...
> >>
> >> So once again, why we can't simply update percpu_rwsem_acquire() ?
> >> Or we can check CONFIG_RWSEM_SPIN_ON_OWNER to match percpu_rwsem_release(),
> >> but CONFIG_DEBUG_RWSEMS explains the purpose better.
> >
> > Yeah, what you suggests seems reasonable to me. So feel free to add:
> >
> > Acked-by: Jan Kara <jack@suse.cz>
> >
>
> How about this version? A bit more prudent and also addresses the
> TODO in commit 55cc156505f2 ("percpu-rwsem: introduce
> percpu_rwsem_release() and percpu_rwsem_acquire()")

Well, to me this looks like unnecessary overcomplication...

In any case the patch looks technically wrong, afaics
rwsem_can_spin_on_owner() will crash if it hits owner == RWSEM_USER_OWNED.

Oleg.

> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index b1f37a89e368..323d5ba6a60d 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -127,13 +127,16 @@ extern void percpu_free_rwsem(struct
> percpu_rw_semaphore *);
>  #define percpu_rwsem_assert_held(sem)                          \
>         lockdep_assert_held(&(sem)->rw_sem)
> 
> +extern void percpu_rwsem_set_user_owned(struct percpu_rw_semaphore *sem);
> +extern void percpu_rwsem_set_owner(struct percpu_rw_semaphore *sem);
> +
>  static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
>                                         bool read, unsigned long ip)
>  {
>         lock_release(&sem->rw_sem.dep_map, 1, ip);
>  #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
>         if (!read)
> -               sem->rw_sem.owner = NULL;
> +               percpu_rwsem_set_user_owned(sem);
>  #endif
>  }
> 
> @@ -141,6 +144,10 @@ static inline void percpu_rwsem_acquire(struct
> percpu_rw_semaphore *sem,
>                                         bool read, unsigned long ip)
>  {
>         lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
> +#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
> +       if (!read)
> +               percpu_rwsem_set_owner(sem);
> +#endif
>  }
> 
>  #endif
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index 883cf1b92d90..afa65915541f 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -7,6 +7,8 @@
>  #include <linux/sched.h>
>  #include <linux/errno.h>
> 
> +#include "rwsem.h"
> +
>  int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
>                         const char *name, struct lock_class_key *rwsem_key)
>  {
> @@ -190,3 +192,17 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
>         rcu_sync_exit(&sem->rss);
>  }
>  EXPORT_SYMBOL_GPL(percpu_up_write);
> +
> +void percpu_rwsem_set_user_owned(struct percpu_rw_semaphore *sem)
> +{
> +       DEBUG_RWSEMS_WARN_ON(sem->rw_sem.owner != current);
> +       sem->rw_sem.owner = RWSEM_USER_OWNED;
> +}
> +EXPORT_SYMBOL_GPL(percpu_rwsem_set_user_owned);
> +
> +void percpu_rwsem_set_owner(struct percpu_rw_semaphore *sem)
> +{
> +       DEBUG_RWSEMS_WARN_ON(sem->rw_sem.owner != RWSEM_USER_OWNED);
> +       sem->rw_sem.owner = current;
> +}
> +EXPORT_SYMBOL_GPL(percpu_rwsem_set_user_owned);
> diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
> index a17cba8d94bb..f686596ec033 100644
> --- a/kernel/locking/rwsem.h
> +++ b/kernel/locking/rwsem.h
> @@ -11,10 +11,14 @@
>   *  2) RWSEM_READER_OWNED
>   *     - lock is currently or previously owned by readers (lock is free
>   *       or not set by owner yet)
> - *  3) Other non-zero value
> + *  3) RWSEM_USER_OWNED
> + *     - lock is currently owned by userspace (previously owned by writer
> + *       and should be handed over to a new writer before being freed)
> + *  4) Other non-zero value
>   *     - a writer owns the lock
>   */
>  #define RWSEM_READER_OWNED     ((struct task_struct *)1UL)
> +#define RWSEM_USER_OWNED       ((struct task_struct *)2UL)
> 
>  #ifdef CONFIG_DEBUG_RWSEMS
>  # define DEBUG_RWSEMS_WARN_ON(c)       DEBUG_LOCKS_WARN_ON(c)
