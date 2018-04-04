Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeDDOjC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:39:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeDDOjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:39:01 -0400
Date: Wed, 4 Apr 2018 07:39:00 -0700
From: Matthew Wilcox <willy@infradead.org>
To: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Signal handling in a page fault handler
Message-ID: <20180404143900.GA1777@bombadil.infradead.org>
References: <20180402141058.GL13332@bombadil.infradead.org>
 <20180404093254.GC3881@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404093254.GC3881@phenom.ffwll.local>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 11:32:54AM +0200, Daniel Vetter wrote:
> So we've done some experiments for the case where the fault originated
> from kernel context (copy_to|from_user and friends). The fixup code seems
> to retry the copy once after the fault (in copy_user_handle_tail), if that
> fails again we get a short read/write. This might result in an -EFAULT,
> short read()/write() or anything else really, depending upon the syscall
> api.
> 
> Except in some code paths in gpu drivers where we convert anything into
> -ERESTARTSYS/EINTR if there's a signal pending it won't ever result in the
> syscall getting restarted (well except maybe short read/writes if
> userspace bothers with that).
> 
> So I guess gpu fault handlers indeed break the kernel's expectations, but
> then I think we're getting away with that because the inner workings of
> gpu memory objects is all heavily abstracted away by opengl/vulkan and
> friends.
> 
> I guess what we could do is try to only do killable sleeps if it's a
> kernel fault, but that means wiring a flag through all the callchains. Not
> pretty. Except when there's a magic set of functions that would convert
> all interruptible sleeps to killable ones only for us.

I actually have plans to allow mutex_lock_{interruptible,killable} to
return -EWOULDBLOCK if a flag is set.  So this doesn't seem entirely
unrelated.  Something like this perhaps:

 struct task_struct {
+	unsigned int sleep_state;
 };

 static noinline int __sched
-__mutex_lock_interruptible_slowpath(struct mutex *lock)
+__mutex_lock_slowpath(struct mutex *lock, long state)
 {
-	return __mutex_lock(lock, TASK_INTERRUPTIBLE, 0, NULL, _RET_IP_);
+	if (state == TASK_NOBLOCK)
+		return -EWOULDBLOCK;
+	return __mutex_lock(lock, state, 0, NULL, _RET_IP_);
 }

+int __sched mutex_lock_state(struct mutex *lock, long state)
+{
+	might_sleep();
+
+	if (__mutex_trylock_fast(lock))
+		return 0;
+
+	return __mutex_lock_slowpath(lock, state);
+}
+EXPORT_SYMBOL(mutex_lock_state);

Then the page fault handler can do something like:

	old_state = current->sleep_state;
	current->sleep_state = TASK_INTERRUPTIBLE;
	...
	current->sleep_state = old_state;


This has the page-fault-in-a-signal-handler problem.  I don't know if
there's a way to determine if we're already in a signal handler and use
a different sleep_state ...?
