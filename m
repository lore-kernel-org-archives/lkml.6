Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeDRUAL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 16:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751692AbeDRUAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 16:00:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9FB21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
Message-ID: <1524081607.8502.18.camel@kernel.org>
Subject: Re: [PATCH] fasync: Fix deadlock between task-context and
 interrupt-context kill_fasync()
From: Jeff Layton <jlayton@kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, peterz@infradead.org,
        mingo@redhat.com
Date: Wed, 18 Apr 2018 16:00:07 -0400
In-Reply-To: <3518b26a-2a81-1fb6-e01d-8d0b06eb0ad3@virtuozzo.com>
References: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
         <20180417140110.GB21954@bombadil.infradead.org>
         <3518b26a-2a81-1fb6-e01d-8d0b06eb0ad3@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 17:15 +0300, Kirill Tkhai wrote:
> On 17.04.2018 17:01, Matthew Wilcox wrote:
> > On Thu, Apr 05, 2018 at 02:58:06PM +0300, Kirill Tkhai wrote:
> > > I observed the following deadlock between them:
> > > 
> > > [task 1]                          [task 2]                         [task 3]
> > > kill_fasync()                     mm_update_next_owner()           copy_process()
> > >  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
> > >   send_sigio()                    <IRQ>                             ...
> > >    read_lock(&fown->lock)         kill_fasync()                     ...
> > >     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
> > > 
> > > Task 1 can't acquire read locked tasklist_lock, since there is
> > > already task 3 expressed its wish to take the lock exclusive.
> > > Task 2 holds the read locked lock, but it can't take the spin lock.
> > 
> > I think the important question is to Peter ... why didn't lockdep catch this?
> > 
> > > -		spin_lock_irq(&fa->fa_lock);
> > > +		write_lock_irq(&fa->fa_lock);
> > >  		fa->fa_file = NULL;
> > > -		spin_unlock_irq(&fa->fa_lock);
> > > +		write_unlock_irq(&fa->fa_lock);
> > 
> > ...
> > > -		spin_lock_irq(&fa->fa_lock);
> > > +		write_lock_irq(&fa->fa_lock);
> > >  		fa->fa_fd = fd;
> > > -		spin_unlock_irq(&fa->fa_lock);
> > > +		write_unlock_irq(&fa->fa_lock);
> > 
> > Do we really need a lock here?  If we convert each of these into WRITE_ONCE,
> 
> We want to pass specific fd to send_sigio(), not a random one. Also, we do want
> to dereference specific file in kill_fasync_rcu() without a danger it will be freed
> in parallel. So, since there is no rcu_read_lock() or another protection in readers
> of this data, we *can't* drop the lock.
> 

I think it's probably possible to do this with RCU.

You'd need to put the whole fasync structure under RCU, and we'd have
to stop resetting fa_fd in fasync_insert_entry, and just insert a new
one and delete the old when there was one like that. That'd be no big
deal though since we always allocate one and pass it in anyway.

We could also turn the nasty singly-linked list into a standard hlist
too, which would be nice.

Regardless...for now we should probably take this patch and do any
further work on the code from that point. I'll plan to pick up the
patch for now unless Al or Bruce want it.

> > then 
> > 
> > ...
> > > -		spin_lock_irqsave(&fa->fa_lock, flags);
> > > +		read_lock(&fa->fa_lock);
> > >  		if (fa->fa_file) {
> > 
> > file = READ_ONCE(fa->fa_file)
> > 
> > then we're not opening any new races, are we?
> > 
> > >  			fown = &fa->fa_file->f_owner;
> > >  			/* Don't send SIGURG to processes which have not set a
> > > @@ -997,7 +996,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
> > >  			if (!(sig == SIGURG && fown->signum == 0))
> > >  				send_sigio(fown, fa->fa_fd, band);
> > >  		}
> > > -		spin_unlock_irqrestore(&fa->fa_lock, flags);
> > > +		read_unlock(&fa->fa_lock);
> > >  		fa = rcu_dereference(fa->fa_next);
> > >  	}
> > >  }
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index c6baf767619e..297e2dcd9dd2 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1250,7 +1250,7 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
> > >  }
> > >  
> > >  struct fasync_struct {
> > > -	spinlock_t		fa_lock;
> > > +	rwlock_t		fa_lock;
> > >  	int			magic;
> > >  	int			fa_fd;
> > >  	struct fasync_struct	*fa_next; /* singly linked list */
> 
> Kirill
