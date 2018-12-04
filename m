Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E945C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0194206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="UeP0nASm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0194206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeLDRXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:23:20 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:37788 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726042AbeLDRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:23:20 -0500
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB4HH5Sc024172;
        Tue, 4 Dec 2018 17:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=+Y8vfrb9ON7Anhk0x6Sd7QdwNwVHyZlFwRSTDTqOqqI=;
 b=UeP0nASmDfHfGeF49mE7leE0KOYpRWExciOgzlbTwScI/UARBjIWTNJZpdweuMg+YVjt
 1lL0o+7byPPDoLDLgJSRBvV8nQArY/qpAy4UIfYw5pql5JORMe4z/AYHpS69p3wPBpFM
 tFrXIYk4IKrmAkROzZxKepfvWMobgn92t3az7YgO0c77N/SdaTU9MiVbVph7dspXUtAU
 jKlCtTuUPhoZxqB3I+wYlpFOoEm7a6XjgD9U/nQ0BDe9Jrp2vxxAd0G+yeCNUu00FinL
 GsSg30lxDvt+5ceawdC0AqKwmy500cZqHzDhgbxmS1Ax3E+8zaDfQbUzZNy8FU0oQLxX Pg== 
Received: from prod-mail-ppoint4 (a96-6-114-87.deploy.static.akamaitechnologies.com [96.6.114.87] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2p5wc2r3sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Dec 2018 17:23:13 +0000
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.21/8.16.0.21) with SMTP id wB4HHHx3031957;
        Tue, 4 Dec 2018 12:23:11 -0500
Received: from prod-mail-relay15.akamai.com ([172.27.17.40])
        by prod-mail-ppoint4.akamai.com with ESMTP id 2p3phgf84c-1;
        Tue, 04 Dec 2018 12:23:10 -0500
Received: from [172.28.12.125] (bos-lpjec.kendall.corp.akamai.com [172.28.12.125])
        by prod-mail-relay15.akamai.com (Postfix) with ESMTP id 614F02009A;
        Tue,  4 Dec 2018 17:23:09 +0000 (GMT)
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181203110237.14787-1-rpenyaev@suse.de>
From:   Jason Baron <jbaron@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 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
 JeQ7iQ==
Message-ID: <45bce871-edfd-c402-acde-2e57e80cc522@akamai.com>
Date:   Tue, 4 Dec 2018 12:23:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203110237.14787-1-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040148
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812040148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/18 6:02 AM, Roman Penyaev wrote:
> Hi all,
> 
> The goal of this patch is to reduce contention of ep_poll_callback() which
> can be called concurrently from different CPUs in case of high events
> rates and many fds per epoll.  Problem can be very well reproduced by
> generating events (write to pipe or eventfd) from many threads, while
> consumer thread does polling.  In other words this patch increases the
> bandwidth of events which can be delivered from sources to the poller by
> adding poll items in a lockless way to the list.
> 
> The main change is in replacement of the spinlock with a rwlock, which is
> taken on read in ep_poll_callback(), and then by adding poll items to the
> tail of the list using xchg atomic instruction.  Write lock is taken
> everywhere else in order to stop list modifications and guarantee that list
> updates are fully completed (I assume that write side of a rwlock does not
> starve, it seems qrwlock implementation has these guarantees).
> 
> The following are some microbenchmark results based on the test [1] which
> starts threads which generate N events each.  The test ends when all
> events are successfully fetched by the poller thread:
> 
> spinlock
> ========
> 
> threads       run time    events per ms
> -------       ---------   -------------
>       8         13191ms         6064/ms
>      16         30758ms         5201/ms
>      32         44315ms         7220/ms
> 
> rwlock + xchg
> =============
> 
> threads       run time    events per ms
> -------       ---------   -------------
>       8          8581ms         9323/ms
>      16         13800ms        11594/ms
>      32         24167ms        13240/ms
> 
> According to the results bandwidth of delivered events is significantly
> increased, thus execution time is reduced.
> 
> This is RFC because I did not run any benchmarks comparing current
> qrwlock and spinlock implementations (4.19 kernel), although I did
> not notice any epoll performance degradations in other benchmarks.
> 
> Also I'm not quite sure where to put very special lockless variant
> of adding element to the list (list_add_tail_lockless() in this
> patch).  Seems keeping it locally is safer.
> 
> [1] https://github.com/rouming/test-tools/blob/master/stress-epoll.c
> 
> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/eventpoll.c | 107 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 69 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 42bbe6824b4b..89debda47aca 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -50,10 +50,10 @@
>   *
>   * 1) epmutex (mutex)
>   * 2) ep->mtx (mutex)
> - * 3) ep->wq.lock (spinlock)
> + * 3) ep->lock (rwlock)
>   *
>   * The acquire order is the one listed above, from 1 to 3.
> - * We need a spinlock (ep->wq.lock) because we manipulate objects
> + * We need a rwlock (ep->lock) because we manipulate objects
>   * from inside the poll callback, that might be triggered from
>   * a wake_up() that in turn might be called from IRQ context.
>   * So we can't sleep inside the poll callback and hence we need
> @@ -85,7 +85,7 @@
>   * of epoll file descriptors, we use the current recursion depth as
>   * the lockdep subkey.
>   * It is possible to drop the "ep->mtx" and to use the global
> - * mutex "epmutex" (together with "ep->wq.lock") to have it working,
> + * mutex "epmutex" (together with "ep->lock") to have it working,
>   * but having "ep->mtx" will make the interface more scalable.
>   * Events that require holding "epmutex" are very rare, while for
>   * normal operations the epoll private "ep->mtx" will guarantee
> @@ -182,8 +182,6 @@ struct epitem {
>   * This structure is stored inside the "private_data" member of the file
>   * structure and represents the main data structure for the eventpoll
>   * interface.
> - *
> - * Access to it is protected by the lock inside wq.
>   */
>  struct eventpoll {
>  	/*
> @@ -203,13 +201,16 @@ struct eventpoll {
>  	/* List of ready file descriptors */
>  	struct list_head rdllist;
>  
> +	/* Lock which protects rdllist and ovflist */
> +	rwlock_t lock;
> +
>  	/* RB tree root used to store monitored fd structs */
>  	struct rb_root_cached rbr;
>  
>  	/*
>  	 * This is a single linked list that chains all the "struct epitem" that
>  	 * happened while transferring ready events to userspace w/out
> -	 * holding ->wq.lock.
> +	 * holding ->lock.
>  	 */
>  	struct epitem *ovflist;
>  
> @@ -697,17 +698,17 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>  	 * because we want the "sproc" callback to be able to do it
>  	 * in a lockless way.
>  	 */
> -	spin_lock_irq(&ep->wq.lock);
> +	write_lock_irq(&ep->lock);
>  	list_splice_init(&ep->rdllist, &txlist);
>  	ep->ovflist = NULL;
> -	spin_unlock_irq(&ep->wq.lock);
> +	write_unlock_irq(&ep->lock);
>  
>  	/*
>  	 * Now call the callback function.
>  	 */
>  	res = (*sproc)(ep, &txlist, priv);
>  
> -	spin_lock_irq(&ep->wq.lock);
> +	write_lock_irq(&ep->lock);
>  	/*
>  	 * During the time we spent inside the "sproc" callback, some
>  	 * other events might have been queued by the poll callback.
> @@ -722,7 +723,8 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>  		 * contain them, and the list_splice() below takes care of them.
>  		 */
>  		if (!ep_is_linked(epi)) {
> -			list_add_tail(&epi->rdllink, &ep->rdllist);
> +			/* Reverse ->ovflist, events should be in FIFO */
> +			list_add(&epi->rdllink, &ep->rdllist);
>  			ep_pm_stay_awake(epi);
>  		}
>  	}
> @@ -745,11 +747,11 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>  		 * the ->poll() wait list (delayed after we release the lock).
>  		 */
>  		if (waitqueue_active(&ep->wq))
> -			wake_up_locked(&ep->wq);
> +			wake_up(&ep->wq);
>  		if (waitqueue_active(&ep->poll_wait))
>  			pwake++;
>  	}
> -	spin_unlock_irq(&ep->wq.lock);
> +	write_unlock_irq(&ep->lock);
>  
>  	if (!ep_locked)
>  		mutex_unlock(&ep->mtx);
> @@ -789,10 +791,10 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
>  
>  	rb_erase_cached(&epi->rbn, &ep->rbr);
>  
> -	spin_lock_irq(&ep->wq.lock);
> +	write_lock_irq(&ep->lock);
>  	if (ep_is_linked(epi))
>  		list_del_init(&epi->rdllink);
> -	spin_unlock_irq(&ep->wq.lock);
> +	write_unlock_irq(&ep->lock);
>  
>  	wakeup_source_unregister(ep_wakeup_source(epi));
>  	/*
> @@ -842,7 +844,7 @@ static void ep_free(struct eventpoll *ep)
>  	 * Walks through the whole tree by freeing each "struct epitem". At this
>  	 * point we are sure no poll callbacks will be lingering around, and also by
>  	 * holding "epmutex" we can be sure that no file cleanup code will hit
> -	 * us during this operation. So we can avoid the lock on "ep->wq.lock".
> +	 * us during this operation. So we can avoid the lock on "ep->lock".
>  	 * We do not need to lock ep->mtx, either, we only do it to prevent
>  	 * a lockdep warning.
>  	 */
> @@ -1023,6 +1025,7 @@ static int ep_alloc(struct eventpoll **pep)
>  		goto free_uid;
>  
>  	mutex_init(&ep->mtx);
> +	rwlock_init(&ep->lock);
>  	init_waitqueue_head(&ep->wq);
>  	init_waitqueue_head(&ep->poll_wait);
>  	INIT_LIST_HEAD(&ep->rdllist);
> @@ -1112,10 +1115,38 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
>  }
>  #endif /* CONFIG_CHECKPOINT_RESTORE */
>  
> +/*
> + * Adds a new entry to the tail of the list in a lockless way, i.e.
> + * multiple CPUs are allowed to call this function concurrently.
> + *
> + * Beware: it is necessary to prevent any other modifications of the
> + *         existing list until all changes are completed, in other words
> + *         concurrent list_add_tail_lockless() calls should be protected
> + *         with a read lock, where write lock acts as a barrier which
> + *         makes sure all list_add_tail_lockless() calls are fully
> + *         completed.
> + */
> +static inline void list_add_tail_lockless(struct list_head *new,
> +					  struct list_head *head)
> +{
> +	struct list_head *prev;
> +
> +	new->next = head;
> +	prev = xchg(&head->prev, new);
> +	prev->next = new;
> +	new->prev = prev;
> +}
> +
>  /*
>   * This is the callback that is passed to the wait queue wakeup
>   * mechanism. It is called by the stored file descriptors when they
>   * have events to report.
> + *
> + * This callback takes a read lock in order not to content with concurrent
> + * events from another file descriptors, thus all modifications to ->rdllist
> + * or ->ovflist are lockless.  Read lock is paired with the write lock from
> + * ep_scan_ready_list(), which stops all list modifications and guarantees
> + * that lists won't be corrupted.
>   */
>  static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
>  {
> @@ -1126,7 +1157,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>  	__poll_t pollflags = key_to_poll(key);
>  	int ewake = 0;
>  
> -	spin_lock_irqsave(&ep->wq.lock, flags);
> +	read_lock_irqsave(&ep->lock, flags);
>  
>  	ep_set_busy_poll_napi_id(epi);
>  
> @@ -1156,8 +1187,8 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>  	 */
>  	if (unlikely(ep->ovflist != EP_UNACTIVE_PTR)) {
>  		if (epi->next == EP_UNACTIVE_PTR) {
> -			epi->next = ep->ovflist;
> -			ep->ovflist = epi;
> +			/* Atomically exchange tail */
> +			epi->next = xchg(&ep->ovflist, epi);

This also relies on the fact that the same epi can't be added to the
list in parallel, because the wait queue doing the wakeup will have the
wait_queue_head lock. That was a little confusing for me b/c we only had
the read_lock() above.

>  			if (epi->ws) {
>  				/*
>  				 * Activate ep->ws since epi->ws may get
> @@ -1172,7 +1203,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>  
>  	/* If this file is already in the ready list we exit soon */
>  	if (!ep_is_linked(epi)) {
> -		list_add_tail(&epi->rdllink, &ep->rdllist);
> +		list_add_tail_lockless(&epi->rdllink, &ep->rdllist);
>  		ep_pm_stay_awake_rcu(epi);
>  	}

same for this.

>  
> @@ -1197,13 +1228,13 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>  				break;
>  			}
>  		}
> -		wake_up_locked(&ep->wq);
> +		wake_up(&ep->wq);

why the switch here to the locked() variant? Shouldn't the 'reader'
side, in this case which takes the rwlock for write see all updates in a
coherent state at this point?

>  	}
>  	if (waitqueue_active(&ep->poll_wait))
>  		pwake++;
>  
>  out_unlock:
> -	spin_unlock_irqrestore(&ep->wq.lock, flags);
> +	read_unlock_irqrestore(&ep->lock, flags);
>  
>  	/* We have to call this outside the lock */
>  	if (pwake)
> @@ -1489,7 +1520,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
>  		goto error_remove_epi;
>  
>  	/* We have to drop the new item inside our item list to keep track of it */
> -	spin_lock_irq(&ep->wq.lock);
> +	write_lock_irq(&ep->lock);
>  
>  	/* record NAPI ID of new item if present */
>  	ep_set_busy_poll_napi_id(epi);
> @@ -1501,12 +1532,12 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
>  
>  		/* Notify waiting tasks that events are available */
>  		if (waitqueue_active(&ep->wq))
> -			wake_up_locked(&ep->wq);
> +			wake_up(&ep->wq);

is this necessary to switch as well? Is this to make lockdep happy?
Looks like there are few more conversions too below...

Thanks,

-Jason



>  		if (waitqueue_active(&ep->poll_wait))
>  			pwake++;
>  	}
>  
> -	spin_unlock_irq(&ep->wq.lock);
> +	write_unlock_irq(&ep->lock);
>  
>  	atomic_long_inc(&ep->user->epoll_watches);
>  
> @@ -1532,10 +1563,10 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
>  	 * list, since that is used/cleaned only inside a section bound by "mtx".
>  	 * And ep_insert() is called with "mtx" held.
>  	 */
> -	spin_lock_irq(&ep->wq.lock);
> +	write_lock_irq(&ep->lock);
>  	if (ep_is_linked(epi))
>  		list_del_init(&epi->rdllink);
> -	spin_unlock_irq(&ep->wq.lock);
> +	write_unlock_irq(&ep->lock);
>  
>  	wakeup_source_unregister(ep_wakeup_source(epi));
>  
> @@ -1579,9 +1610,9 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
>  	 * 1) Flush epi changes above to other CPUs.  This ensures
>  	 *    we do not miss events from ep_poll_callback if an
>  	 *    event occurs immediately after we call f_op->poll().
> -	 *    We need this because we did not take ep->wq.lock while
> +	 *    We need this because we did not take ep->lock while
>  	 *    changing epi above (but ep_poll_callback does take
> -	 *    ep->wq.lock).
> +	 *    ep->lock).
>  	 *
>  	 * 2) We also need to ensure we do not miss _past_ events
>  	 *    when calling f_op->poll().  This barrier also
> @@ -1600,18 +1631,18 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
>  	 * list, push it inside.
>  	 */
>  	if (ep_item_poll(epi, &pt, 1)) {
> -		spin_lock_irq(&ep->wq.lock);
> +		write_lock_irq(&ep->lock);
>  		if (!ep_is_linked(epi)) {
>  			list_add_tail(&epi->rdllink, &ep->rdllist);
>  			ep_pm_stay_awake(epi);
>  
>  			/* Notify waiting tasks that events are available */
>  			if (waitqueue_active(&ep->wq))
> -				wake_up_locked(&ep->wq);
> +				wake_up(&ep->wq);
>  			if (waitqueue_active(&ep->poll_wait))
>  				pwake++;
>  		}
> -		spin_unlock_irq(&ep->wq.lock);
> +		write_unlock_irq(&ep->lock);
>  	}
>  
>  	/* We have to call this outside the lock */
> @@ -1764,7 +1795,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  		 * caller specified a non blocking operation.
>  		 */
>  		timed_out = 1;
> -		spin_lock_irq(&ep->wq.lock);
> +		write_lock_irq(&ep->lock);
>  		goto check_events;
>  	}
>  
> @@ -1773,7 +1804,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  	if (!ep_events_available(ep))
>  		ep_busy_loop(ep, timed_out);
>  
> -	spin_lock_irq(&ep->wq.lock);
> +	write_lock_irq(&ep->lock);
>  
>  	if (!ep_events_available(ep)) {
>  		/*
> @@ -1789,7 +1820,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  		 * ep_poll_callback() when events will become available.
>  		 */
>  		init_waitqueue_entry(&wait, current);
> -		__add_wait_queue_exclusive(&ep->wq, &wait);
> +		add_wait_queue_exclusive(&ep->wq, &wait);
>  
>  		for (;;) {
>  			/*
> @@ -1815,21 +1846,21 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  				break;
>  			}
>  
> -			spin_unlock_irq(&ep->wq.lock);
> +			write_unlock_irq(&ep->lock);
>  			if (!schedule_hrtimeout_range(to, slack, HRTIMER_MODE_ABS))
>  				timed_out = 1;
>  
> -			spin_lock_irq(&ep->wq.lock);
> +			write_lock_irq(&ep->lock);
>  		}
>  
> -		__remove_wait_queue(&ep->wq, &wait);
> +		remove_wait_queue(&ep->wq, &wait);
>  		__set_current_state(TASK_RUNNING);
>  	}
>  check_events:
>  	/* Is it worth to try to dig for events ? */
>  	eavail = ep_events_available(ep);
>  
> -	spin_unlock_irq(&ep->wq.lock);
> +	write_unlock_irq(&ep->lock);
>  
>  	/*
>  	 * Try to transfer events to user space. In case we get 0 events and
> 
