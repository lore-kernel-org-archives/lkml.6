Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A676C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF922098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MgW7QDLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF922098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeHXUuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:50:17 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:16515 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbeHXUuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1535130883; x=1566666883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=muLPBMtXjlwz3T4wXPsZyBmyRm60ptwBB6zFTAxCqtk=;
  b=MgW7QDLIq5f1Wj4MmWUOGRLDVSMqcJtoys1gc3WxNVZ0kOYIj+37HpsI
   R5TKuPALorxg41KaSVj0v0wTE7CgskgEq55LrBpBPVrHwKDfY2WUJXAFx
   2LbQzc5QD2buQs1egJhTp28wGgqI3ExaglJiKN99TYvos1cQ5NsNOBBWT
   Y=;
X-IronPort-AV: E=Sophos;i="5.53,283,1531785600"; 
   d="scan'208";a="359041114"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Aug 2018 17:14:42 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w7OHEeo2062109
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 24 Aug 2018 17:14:41 GMT
Received: from EX13D07UWA001.ant.amazon.com (10.43.160.145) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 24 Aug 2018 17:14:41 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D07UWA001.ant.amazon.com (10.43.160.145) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 24 Aug 2018 17:14:40 +0000
Received: from localhost (10.88.104.49) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 24 Aug 2018 17:14:40 +0000
Date:   Fri, 24 Aug 2018 10:14:39 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>,
        "Frank van der Linden" <fllinden@amazon.com>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
Message-ID: <20180824171439.GA12587@u40b0340c692b58f6553c.ant.amazon.com>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
 <d28bca3a-196d-1520-35cf-bec1e1872d34@oracle.com>
 <1f2d5ab0-2322-56b7-3544-3cf733a22dd8@kernel.dk>
 <2f83f994-2734-17b2-3c74-b6869ba18184@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f83f994-2734-17b2-3c74-b6869ba18184@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the Frank and Anchal, as this part of the thread is not copying them.

Just a minor comment at the bottom.

On Fri, Aug 24, 2018 at 08:58:09AM -0600, Jens Axboe wrote:
> On 8/24/18 8:40 AM, Jens Axboe wrote:
> > On 8/23/18 8:06 PM, jianchao.wang wrote:
> >> Hi Jens
> >>
> >> On 08/23/2018 11:42 PM, Jens Axboe wrote:
> >>>> -
> >>>> -	__set_current_state(TASK_RUNNING);
> >>>> -	remove_wait_queue(&rqw->wait, &wait);
> >>>> +	wbt_init_wait(&wait, &data);
> >>>> +	prepare_to_wait_exclusive(&rqw->wait, &wait,
> >>>> +			TASK_UNINTERRUPTIBLE);
> >>>> +	if (lock) {
> >>>> +		spin_unlock_irq(lock);
> >>>> +		io_schedule();
> >>>> +		spin_lock_irq(lock);
> >>>> +	} else
> >>>> +		io_schedule();
> >>> Aren't we still missing a get-token attempt after adding to the
> >>> waitqueue? For the case where someone frees the token after your initial
> >>> check, but before you add yourself to the waitqueue.
> >>
> >> I used to think about this.
> >> However, there is a very tricky scenario here:
> >> We will try get the wbt budget in wbt_wake_function.
> >> After add a task into the wait queue, wbt_wake_function has been able to
> >> be invoked for this task. If we get the wbt budget after prepare_to_wait_exclusive,
> >> we may get wbt budget twice.
> > 
> > Ah yes good point. But without it, you've got another race that will
> > potentially put you to sleep forever.
> > 
> > How about something like the below? That should take care of both
> > situations. Totally untested.
> 
> Slightly better/cleaner one below. Still totally untested.
> 
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 84507d3e9a98..bc13544943ff 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -123,16 +123,11 @@ static void rwb_wake_all(struct rq_wb *rwb)
>  	}
>  }
>  
> -static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
> +static void wbt_rqw_done(struct rq_wb *rwb, struct rq_wait *rqw,
> +			 enum wbt_flags wb_acct)
>  {
> -	struct rq_wb *rwb = RQWB(rqos);
> -	struct rq_wait *rqw;
>  	int inflight, limit;
>  
> -	if (!(wb_acct & WBT_TRACKED))
> -		return;
> -
> -	rqw = get_rq_wait(rwb, wb_acct);
>  	inflight = atomic_dec_return(&rqw->inflight);
>  
>  	/*
> @@ -166,8 +161,21 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
>  		int diff = limit - inflight;
>  
>  		if (!inflight || diff >= rwb->wb_background / 2)
> -			wake_up(&rqw->wait);
> +			wake_up_all(&rqw->wait);
>  	}
> +
> +}
> +
> +static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
> +{
> +	struct rq_wb *rwb = RQWB(rqos);
> +	struct rq_wait *rqw;
> +
> +	if (!(wb_acct & WBT_TRACKED))
> +		return;
> +
> +	rqw = get_rq_wait(rwb, wb_acct);
> +	wbt_rqw_done(rwb, rqw, wb_acct);
>  }
>  
>  /*
> @@ -481,6 +489,32 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
>  	return limit;
>  }
>  
> +struct wbt_wait_data {
> +	struct task_struct *curr;
> +	struct rq_wb *rwb;
> +	struct rq_wait *rqw;
> +	unsigned long rw;
> +	bool got_token;
> +};
> +
> +static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mode,
> +			     int wake_flags, void *key)
> +{
> +	struct wbt_wait_data *data = curr->private;
> +
> +	/*
> +	 * If we fail to get a budget, return -1 to interrupt the wake up
> +	 * loop in __wake_up_common.
> +	 */
> +	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
> +		return -1;
> +
> +	data->got_token = true;
> +	wake_up_process(data->curr);
> +	list_del_init(&curr->entry);
> +	return 1;
> +}
> +
>  /*
>   * Block if we will exceed our limit, or if we are currently waiting for
>   * the timer to kick off queuing again.
> @@ -491,31 +525,44 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>  	__acquires(lock)
>  {
>  	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
> -	DECLARE_WAITQUEUE(wait, current);
> +	struct wbt_wait_data data = {
> +		.curr = current,
> +		.rwb = rwb,
> +		.rqw = rqw,
> +		.rw = rw,
> +	};
> +	struct wait_queue_entry wait = {
> +		.func		= wbt_wake_function,
> +		.private	= &data,
> +		.entry		= LIST_HEAD_INIT(wait.entry),
> +	};
>  	bool has_sleeper;
>  
>  	has_sleeper = wq_has_sleeper(&rqw->wait);
>  	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>  		return;
>  
> -	add_wait_queue_exclusive(&rqw->wait, &wait);
> -	do {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +	prepare_to_wait_exclusive(&rqw->wait, &wait, TASK_UNINTERRUPTIBLE);
>  
> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> -			break;
> +	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
> +		finish_wait(&rqw->wait, &wait);
>  
> -		if (lock) {
> -			spin_unlock_irq(lock);
> -			io_schedule();
> -			spin_lock_irq(lock);
> -		} else
> -			io_schedule();
> -		has_sleeper = false;
> -	} while (1);
> -
> -	__set_current_state(TASK_RUNNING);
> -	remove_wait_queue(&rqw->wait, &wait);
> +		/*
> +		 * We raced with wbt_wake_function() getting a token, which
> +		 * means we now have two. Put ours and wake anyone else
> +		 * potentially waiting for one.
> +		 */
> +		if (data.got_token)
> +			wbt_rqw_done(rwb, rqw, wb_acct);
> +		return;
> +	}
> +
> +	if (lock) {
> +		spin_unlock_irq(lock);
> +		io_schedule();
> +		spin_lock_irq(lock);
> +	} else
> +		io_schedule();

Nitpick but, shouldn't this look like:

+	if (lock) {
+		spin_unlock_irq(lock);
+		io_schedule();
+		spin_lock_irq(lock);
+	} else {
+		io_schedule();
+	}


And another random though, it would be good to have some sort of tracing of this.

>  }
>  
>  static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
> 
> -- 
> Jens Axboe
> 
> 

-- 
All the best,
Eduardo Valentin
