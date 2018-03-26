Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCZU6y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:58:54 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15164 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeCZU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:58:53 -0400
To: peterz@infradead.org
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bp@suse.de, rientjes@google.com, mhocko@suse.com, tglx@linutronix.de
Subject: Re: [PATCH] lockdep: Show address of "struct lockdep_map" at print_lock().
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1522059513-5461-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20180326160549.GL4043@hirez.programming.kicks-ass.net>
In-Reply-To: <20180326160549.GL4043@hirez.programming.kicks-ass.net>
Message-Id: <201803270558.HCA41032.tVFJOFOMOFLHSQ@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Tue, 27 Mar 2018 05:58:49 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Mon, Mar 26, 2018 at 07:18:33PM +0900, Tetsuo Handa wrote:
> > [  628.863629] 2 locks held by a.out/1165:
> > [  628.867533]  #0: [ffffa3b438472e48] (&mm->mmap_sem){++++}, at: __do_page_fault+0x16f/0x4d0
> > [  628.873570]  #1: [ffffa3b4f2c52ac0] (&mapping->i_mmap_rwsem){++++}, at: rmap_walk_file+0x1d9/0x2a0
> 
> Maybe change the string a little, because from the above it's not at all
> effident that the [] thing is the lock instance.
> 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 12a2805..7835233 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -556,9 +556,9 @@ static void print_lock(struct held_lock *hlock)
> >  		return;
> >  	}
> >  
> > +	printk(KERN_CONT "[%px]", hlock->instance);
> 
> And yeah, what Michal said, that wants to be %p, we're fine with the
> thing being hashed, all we want to do is equivalience, which can be done
> with hashed pinters too.
> 
> >  	print_lock_name(lock_classes + class_idx - 1);
> > -	printk(KERN_CONT ", at: [<%px>] %pS\n",
> > -		(void *)hlock->acquire_ip, (void *)hlock->acquire_ip);
> > +	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
> >  }
> 
> Otherwise no real objection to the patch.
> 

I see. What about plain

-	printk(KERN_CONT "[%px]", hlock->instance);
+	printk(KERN_CONT "%p", hlock->instance);

because we don't need to use [] ?

I'm trying to remove "[<%px>]" for hlock->acquire_ip field in order to
reduce amount of output, for debug_show_all_locks() prints a lot.
