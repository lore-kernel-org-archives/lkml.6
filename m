Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeDQLmo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752254AbeDQLml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:42:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CD82183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
Message-ID: <1523965358.4779.25.camel@kernel.org>
Subject: Re: [PATCH] fasync: Fix deadlock between task-context and
 interrupt-context kill_fasync()
From: Jeff Layton <jlayton@kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>, bfields@fieldses.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com, longman@redhat.com,
        peterz@infradead.org, mingo@redhat.com
Date: Tue, 17 Apr 2018 07:42:38 -0400
In-Reply-To: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
References: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-05 at 14:58 +0300, Kirill Tkhai wrote:
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
> 
> Also, there is possible another deadlock (which I haven't observed):
> 
> [task 1]                            [task 2]
> f_getown()                          kill_fasync()
>  read_lock(&f_own->lock)             spin_lock_irqsave(&fa->fa_lock,)
>  <IRQ>                               send_sigio()                     write_lock_irq(&f_own->lock)
>   kill_fasync()                       read_lock(&fown->lock)
>    spin_lock_irqsave(&fa->fa_lock,)
> 
> Actually, we do not need exclusive fa->fa_lock in kill_fasync_rcu(),
> as it guarantees fa->fa_file->f_owner integrity only. It may seem,
> that it used to give a task a small possibility to receive two sequential
> signals, if there are two parallel kill_fasync() callers, and task
> handles the first signal fastly, but the behaviour won't become
> different, since there is exclusive sighand lock in do_send_sig_info().
> 
> The patch converts fa_lock into rwlock_t, and this fixes two above
> deadlocks, as rwlock is allowed to be taken from interrupt handler
> by qrwlock design.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> I used the following program for testing:
> 
> #include <unistd.h>
> #include <stdlib.h>
> #include <signal.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <stdio.h>
> 
> #ifndef F_SETSIG
> #define F_SETSIG 10
> #endif
> 
> void handler(int sig)
> {
> }
> 
> main()
> {
> 	unsigned int flags;
> 	int fd;
> 
> 	system("echo 8 > /proc/sys/kernel/random/read_wakeup_threshold");
> 	system("while :; do ls -R / > /dev/random 2>&1 ; echo 3 > /proc/sys/vm/drop_caches; done &");
> 
> 	if (signal(SIGINT, handler) < 0) {
> 		perror("Signal");
> 		exit(1);
> 	}
> 
> 	fd = open("/dev/random", O_RDWR);
> 	if (fd < 0) {
> 		perror("Can't open");
> 		exit(1);
> 	}
> 
> 	flags = FASYNC | fcntl(fd, F_GETFL);
> 	if (fcntl(fd, F_SETFL, flags) < 0) {
> 		perror("Setfl");
> 		exit(1);
> 	}
> 	if (fcntl(fd, F_SETOWN, getpid())) {
> 		perror("Setown");
> 		exit(1);
> 	}
> 	if (fcntl(fd, F_SETSIG, SIGINT)) {
> 		perror("Setsig");
> 		exit(1);
> 	}
> 
> 	while (1)
> 		sleep(100);
> }
> ---
>  fs/fcntl.c         |   15 +++++++--------
>  include/linux/fs.h |    2 +-
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 1e97f1fda90c..780161a11f9d 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -865,9 +865,9 @@ int fasync_remove_entry(struct file *filp, struct fasync_struct **fapp)
>  		if (fa->fa_file != filp)
>  			continue;
>  
> -		spin_lock_irq(&fa->fa_lock);
> +		write_lock_irq(&fa->fa_lock);
>  		fa->fa_file = NULL;
> -		spin_unlock_irq(&fa->fa_lock);
> +		write_unlock_irq(&fa->fa_lock);
>  
>  		*fp = fa->fa_next;
>  		call_rcu(&fa->fa_rcu, fasync_free_rcu);
> @@ -912,13 +912,13 @@ struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasy
>  		if (fa->fa_file != filp)
>  			continue;
>  
> -		spin_lock_irq(&fa->fa_lock);
> +		write_lock_irq(&fa->fa_lock);
>  		fa->fa_fd = fd;
> -		spin_unlock_irq(&fa->fa_lock);
> +		write_unlock_irq(&fa->fa_lock);
>  		goto out;
>  	}
>  
> -	spin_lock_init(&new->fa_lock);
> +	rwlock_init(&new->fa_lock);
>  	new->magic = FASYNC_MAGIC;
>  	new->fa_file = filp;
>  	new->fa_fd = fd;
> @@ -981,14 +981,13 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
>  {
>  	while (fa) {
>  		struct fown_struct *fown;
> -		unsigned long flags;
>  
>  		if (fa->magic != FASYNC_MAGIC) {
>  			printk(KERN_ERR "kill_fasync: bad magic number in "
>  			       "fasync_struct!\n");
>  			return;
>  		}
> -		spin_lock_irqsave(&fa->fa_lock, flags);
> +		read_lock(&fa->fa_lock);

Does this need to be read_lock_irq? Why is it ok to allow interrupts
here?

>  		if (fa->fa_file) {
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

I've no objection to the patch in principle, but I'm not as familiar
with the fasync code as others here.
-- 
Jeff Layton <jlayton@kernel.org>
