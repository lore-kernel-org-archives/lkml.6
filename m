Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DDEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8E320659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8E320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeLELW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:22:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:58848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbeLELW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:22:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8368EAF89;
        Wed,  5 Dec 2018 11:22:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Dec 2018 12:22:25 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     paulmck@linux.ibm.com
Cc:     Jason Baron <jbaron@akamai.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
In-Reply-To: <20181204190206.GB4170@linux.ibm.com>
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <45bce871-edfd-c402-acde-2e57e80cc522@akamai.com>
 <20181204190206.GB4170@linux.ibm.com>
Message-ID: <5bca219db9546e863c667d51316c9b80@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-04 20:02, Paul E. McKenney wrote:
> On Tue, Dec 04, 2018 at 12:23:08PM -0500, Jason Baron wrote:
>> 
>> 
>> On 12/3/18 6:02 AM, Roman Penyaev wrote:
>> > Hi all,
>> >
>> > The goal of this patch is to reduce contention of ep_poll_callback() which
>> > can be called concurrently from different CPUs in case of high events
>> > rates and many fds per epoll.  Problem can be very well reproduced by
>> > generating events (write to pipe or eventfd) from many threads, while
>> > consumer thread does polling.  In other words this patch increases the
>> > bandwidth of events which can be delivered from sources to the poller by
>> > adding poll items in a lockless way to the list.
>> >
>> > The main change is in replacement of the spinlock with a rwlock, which is
>> > taken on read in ep_poll_callback(), and then by adding poll items to the
>> > tail of the list using xchg atomic instruction.  Write lock is taken
>> > everywhere else in order to stop list modifications and guarantee that list
>> > updates are fully completed (I assume that write side of a rwlock does not
>> > starve, it seems qrwlock implementation has these guarantees).
>> >
>> > The following are some microbenchmark results based on the test [1] which
>> > starts threads which generate N events each.  The test ends when all
>> > events are successfully fetched by the poller thread:
>> >
>> > spinlock
>> > ========
>> >
>> > threads       run time    events per ms
>> > -------       ---------   -------------
>> >       8         13191ms         6064/ms
>> >      16         30758ms         5201/ms
>> >      32         44315ms         7220/ms
>> >
>> > rwlock + xchg
>> > =============
>> >
>> > threads       run time    events per ms
>> > -------       ---------   -------------
>> >       8          8581ms         9323/ms
>> >      16         13800ms        11594/ms
>> >      32         24167ms        13240/ms
>> >
>> > According to the results bandwidth of delivered events is significantly
>> > increased, thus execution time is reduced.
>> >
>> > This is RFC because I did not run any benchmarks comparing current
>> > qrwlock and spinlock implementations (4.19 kernel), although I did
>> > not notice any epoll performance degradations in other benchmarks.
>> >
>> > Also I'm not quite sure where to put very special lockless variant
>> > of adding element to the list (list_add_tail_lockless() in this
>> > patch).  Seems keeping it locally is safer.
>> >
>> > [1] https://github.com/rouming/test-tools/blob/master/stress-epoll.c
>> >
>> > Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
>> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> > Cc: linux-fsdevel@vger.kernel.org
>> > Cc: linux-kernel@vger.kernel.org
>> > ---
>> >  fs/eventpoll.c | 107 +++++++++++++++++++++++++++++++------------------
>> >  1 file changed, 69 insertions(+), 38 deletions(-)
>> >
>> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> > index 42bbe6824b4b..89debda47aca 100644
>> > --- a/fs/eventpoll.c
>> > +++ b/fs/eventpoll.c
>> > @@ -50,10 +50,10 @@
>> >   *
>> >   * 1) epmutex (mutex)
>> >   * 2) ep->mtx (mutex)
>> > - * 3) ep->wq.lock (spinlock)
>> > + * 3) ep->lock (rwlock)
>> >   *
>> >   * The acquire order is the one listed above, from 1 to 3.
>> > - * We need a spinlock (ep->wq.lock) because we manipulate objects
>> > + * We need a rwlock (ep->lock) because we manipulate objects
>> >   * from inside the poll callback, that might be triggered from
>> >   * a wake_up() that in turn might be called from IRQ context.
>> >   * So we can't sleep inside the poll callback and hence we need
>> > @@ -85,7 +85,7 @@
>> >   * of epoll file descriptors, we use the current recursion depth as
>> >   * the lockdep subkey.
>> >   * It is possible to drop the "ep->mtx" and to use the global
>> > - * mutex "epmutex" (together with "ep->wq.lock") to have it working,
>> > + * mutex "epmutex" (together with "ep->lock") to have it working,
>> >   * but having "ep->mtx" will make the interface more scalable.
>> >   * Events that require holding "epmutex" are very rare, while for
>> >   * normal operations the epoll private "ep->mtx" will guarantee
>> > @@ -182,8 +182,6 @@ struct epitem {
>> >   * This structure is stored inside the "private_data" member of the file
>> >   * structure and represents the main data structure for the eventpoll
>> >   * interface.
>> > - *
>> > - * Access to it is protected by the lock inside wq.
>> >   */
>> >  struct eventpoll {
>> >  	/*
>> > @@ -203,13 +201,16 @@ struct eventpoll {
>> >  	/* List of ready file descriptors */
>> >  	struct list_head rdllist;
>> >
>> > +	/* Lock which protects rdllist and ovflist */
>> > +	rwlock_t lock;
>> > +
>> >  	/* RB tree root used to store monitored fd structs */
>> >  	struct rb_root_cached rbr;
>> >
>> >  	/*
>> >  	 * This is a single linked list that chains all the "struct epitem" that
>> >  	 * happened while transferring ready events to userspace w/out
>> > -	 * holding ->wq.lock.
>> > +	 * holding ->lock.
>> >  	 */
>> >  	struct epitem *ovflist;
>> >
>> > @@ -697,17 +698,17 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>> >  	 * because we want the "sproc" callback to be able to do it
>> >  	 * in a lockless way.
>> >  	 */
>> > -	spin_lock_irq(&ep->wq.lock);
>> > +	write_lock_irq(&ep->lock);
>> >  	list_splice_init(&ep->rdllist, &txlist);
>> >  	ep->ovflist = NULL;
>> > -	spin_unlock_irq(&ep->wq.lock);
>> > +	write_unlock_irq(&ep->lock);
>> >
>> >  	/*
>> >  	 * Now call the callback function.
>> >  	 */
>> >  	res = (*sproc)(ep, &txlist, priv);
>> >
>> > -	spin_lock_irq(&ep->wq.lock);
>> > +	write_lock_irq(&ep->lock);
>> >  	/*
>> >  	 * During the time we spent inside the "sproc" callback, some
>> >  	 * other events might have been queued by the poll callback.
>> > @@ -722,7 +723,8 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>> >  		 * contain them, and the list_splice() below takes care of them.
>> >  		 */
>> >  		if (!ep_is_linked(epi)) {
>> > -			list_add_tail(&epi->rdllink, &ep->rdllist);
>> > +			/* Reverse ->ovflist, events should be in FIFO */
>> > +			list_add(&epi->rdllink, &ep->rdllist);
>> >  			ep_pm_stay_awake(epi);
>> >  		}
>> >  	}
>> > @@ -745,11 +747,11 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>> >  		 * the ->poll() wait list (delayed after we release the lock).
>> >  		 */
>> >  		if (waitqueue_active(&ep->wq))
>> > -			wake_up_locked(&ep->wq);
>> > +			wake_up(&ep->wq);
>> >  		if (waitqueue_active(&ep->poll_wait))
>> >  			pwake++;
>> >  	}
>> > -	spin_unlock_irq(&ep->wq.lock);
>> > +	write_unlock_irq(&ep->lock);
>> >
>> >  	if (!ep_locked)
>> >  		mutex_unlock(&ep->mtx);
>> > @@ -789,10 +791,10 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
>> >
>> >  	rb_erase_cached(&epi->rbn, &ep->rbr);
>> >
>> > -	spin_lock_irq(&ep->wq.lock);
>> > +	write_lock_irq(&ep->lock);
>> >  	if (ep_is_linked(epi))
>> >  		list_del_init(&epi->rdllink);
>> > -	spin_unlock_irq(&ep->wq.lock);
>> > +	write_unlock_irq(&ep->lock);
>> >
>> >  	wakeup_source_unregister(ep_wakeup_source(epi));
>> >  	/*
>> > @@ -842,7 +844,7 @@ static void ep_free(struct eventpoll *ep)
>> >  	 * Walks through the whole tree by freeing each "struct epitem". At this
>> >  	 * point we are sure no poll callbacks will be lingering around, and also by
>> >  	 * holding "epmutex" we can be sure that no file cleanup code will hit
>> > -	 * us during this operation. So we can avoid the lock on "ep->wq.lock".
>> > +	 * us during this operation. So we can avoid the lock on "ep->lock".
>> >  	 * We do not need to lock ep->mtx, either, we only do it to prevent
>> >  	 * a lockdep warning.
>> >  	 */
>> > @@ -1023,6 +1025,7 @@ static int ep_alloc(struct eventpoll **pep)
>> >  		goto free_uid;
>> >
>> >  	mutex_init(&ep->mtx);
>> > +	rwlock_init(&ep->lock);
>> >  	init_waitqueue_head(&ep->wq);
>> >  	init_waitqueue_head(&ep->poll_wait);
>> >  	INIT_LIST_HEAD(&ep->rdllist);
>> > @@ -1112,10 +1115,38 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
>> >  }
>> >  #endif /* CONFIG_CHECKPOINT_RESTORE */
>> >
>> > +/*
>> > + * Adds a new entry to the tail of the list in a lockless way, i.e.
>> > + * multiple CPUs are allowed to call this function concurrently.
>> > + *
>> > + * Beware: it is necessary to prevent any other modifications of the
>> > + *         existing list until all changes are completed, in other words
>> > + *         concurrent list_add_tail_lockless() calls should be protected
>> > + *         with a read lock, where write lock acts as a barrier which
>> > + *         makes sure all list_add_tail_lockless() calls are fully
>> > + *         completed.
>> > + */
>> > +static inline void list_add_tail_lockless(struct list_head *new,
>> > +					  struct list_head *head)
>> > +{
>> > +	struct list_head *prev;
>> > +
>> > +	new->next = head;
>> > +	prev = xchg(&head->prev, new);
>> > +	prev->next = new;
>> > +	new->prev = prev;
>> > +}
>> > +
>> >  /*
>> >   * This is the callback that is passed to the wait queue wakeup
>> >   * mechanism. It is called by the stored file descriptors when they
>> >   * have events to report.
>> > + *
>> > + * This callback takes a read lock in order not to content with concurrent
>> > + * events from another file descriptors, thus all modifications to ->rdllist
>> > + * or ->ovflist are lockless.  Read lock is paired with the write lock from
>> > + * ep_scan_ready_list(), which stops all list modifications and guarantees
>> > + * that lists won't be corrupted.
>> >   */
>> >  static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
>> >  {
>> > @@ -1126,7 +1157,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>> >  	__poll_t pollflags = key_to_poll(key);
>> >  	int ewake = 0;
>> >
>> > -	spin_lock_irqsave(&ep->wq.lock, flags);
>> > +	read_lock_irqsave(&ep->lock, flags);
>> >
>> >  	ep_set_busy_poll_napi_id(epi);
>> >
>> > @@ -1156,8 +1187,8 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>> >  	 */
>> >  	if (unlikely(ep->ovflist != EP_UNACTIVE_PTR)) {
>> >  		if (epi->next == EP_UNACTIVE_PTR) {
>> > -			epi->next = ep->ovflist;
>> > -			ep->ovflist = epi;
>> > +			/* Atomically exchange tail */
>> > +			epi->next = xchg(&ep->ovflist, epi);
>> 
>> This also relies on the fact that the same epi can't be added to the
>> list in parallel, because the wait queue doing the wakeup will have 
>> the
>> wait_queue_head lock. That was a little confusing for me b/c we only 
>> had
>> the read_lock() above.
> 
> I missed this as well.
> 
> I was also concerned about "fly-by" wakeups where the to-be-awoken task
> never really goes to sleep, but it looks like tasks are unconditionally
> queued, which seems like it should avoid that problem.
> 
> Please do some testing with artificial delays in the lockless queuing
> code, for example, via udelay() or similar.  If there are races, this
> would help force them to happen.

Yep, that what I am doing right now, experimenting with different
polling scenarios and stressing with random delays.  Thanks.

--
Roman

