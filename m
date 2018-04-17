Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDQOB5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:01:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeDQOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:01:55 -0400
Date: Tue, 17 Apr 2018 07:01:10 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, peterz@infradead.org,
        mingo@redhat.com
Subject: Re: [PATCH] fasync: Fix deadlock between task-context and
 interrupt-context kill_fasync()
Message-ID: <20180417140110.GB21954@bombadil.infradead.org>
References: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 02:58:06PM +0300, Kirill Tkhai wrote:
> I observed the following deadlock between them:
> 
> [task 1]                          [task 2]                         [task 3]
> kill_fasync()                     mm_update_next_owner()           copy_process()
>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>   send_sigio()                    <IRQ>                             ...
>    read_lock(&fown->lock)         kill_fasync()                     ...
>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
> 
> Task 1 can't acquire read locked tasklist_lock, since there is
> already task 3 expressed its wish to take the lock exclusive.
> Task 2 holds the read locked lock, but it can't take the spin lock.

I think the important question is to Peter ... why didn't lockdep catch this?

> -		spin_lock_irq(&fa->fa_lock);
> +		write_lock_irq(&fa->fa_lock);
>  		fa->fa_file = NULL;
> -		spin_unlock_irq(&fa->fa_lock);
> +		write_unlock_irq(&fa->fa_lock);
...
> -		spin_lock_irq(&fa->fa_lock);
> +		write_lock_irq(&fa->fa_lock);
>  		fa->fa_fd = fd;
> -		spin_unlock_irq(&fa->fa_lock);
> +		write_unlock_irq(&fa->fa_lock);

Do we really need a lock here?  If we convert each of these into WRITE_ONCE,
then 

...
> -		spin_lock_irqsave(&fa->fa_lock, flags);
> +		read_lock(&fa->fa_lock);
>  		if (fa->fa_file) {

file = READ_ONCE(fa->fa_file)

then we're not opening any new races, are we?

>  			fown = &fa->fa_file->f_owner;
>  			/* Don't send SIGURG to processes which have not set a
> @@ -997,7 +996,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
>  			if (!(sig == SIGURG && fown->signum == 0))
>  				send_sigio(fown, fa->fa_fd, band);
>  		}
> -		spin_unlock_irqrestore(&fa->fa_lock, flags);
> +		read_unlock(&fa->fa_lock);
>  		fa = rcu_dereference(fa->fa_next);
>  	}
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c6baf767619e..297e2dcd9dd2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1250,7 +1250,7 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
>  }
>  
>  struct fasync_struct {
> -	spinlock_t		fa_lock;
> +	rwlock_t		fa_lock;
>  	int			magic;
>  	int			fa_fd;
>  	struct fasync_struct	*fa_next; /* singly linked list */
> 
