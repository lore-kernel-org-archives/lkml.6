Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4462DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B6721475
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B6721475
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbeHOSD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:03:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:35984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729381AbeHOSD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:03:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 672A8AD67;
        Wed, 15 Aug 2018 15:10:51 +0000 (UTC)
Date:   Wed, 15 Aug 2018 17:10:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCHv3] lib/ratelimit: Lockless ratelimiting
Message-ID: <20180815151047.qgjam3t3ujyacmaf@pathway.suse.cz>
References: <20180703225628.25684-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703225628.25684-1-dima@arista.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-07-03 23:56:28, Dmitry Safonov wrote:
> Currently ratelimit_state is protected with spin_lock. If the .lock is
> taken at the moment of ___ratelimit() call, the message is suppressed to
> make ratelimiting robust.
> 
> That results in the following issue issue:
>       CPU0                          CPU1
> ------------------           ------------------
> printk_ratelimit()           printk_ratelimit()
>         |                             |
>   try_spin_lock()              try_spin_lock()
>         |                             |
> time_is_before_jiffies()          return 0; // suppress
> 
> So, concurrent call of ___ratelimit() results in silently suppressing
> one of the messages, regardless if the limit is reached or not.
> And rc->missed is not increased in such case so the issue is covered
> from user.
> 
> Convert ratelimiting to use atomic counters and drop spin_lock.
> 
> Note: That might be unexpected, but with the first interval of messages
> storm one can print up to burst*2 messages. So, it doesn't guarantee
> that in *any* interval amount of messages is lesser than burst.
> But, that differs lightly from previous behavior where one can start
> burst=5 interval and print 4 messages on the last milliseconds of
> interval + new 5 messages from new interval (totally 9 messages in
> lesser than interval value):

I am still confused by this paragraph. Does this patch change the
behavior? What is the original and what is the new one, please?

>    msg0              msg1-msg4 msg0-msg4
>     |                     |       |
>     |                     |       |
>  |--o---------------------o-|-----o--------------------|--> (t)
>                           <------->
>                        Lesser than burst
> 
> Dropped dev/random patch since v1 version:
> lkml.kernel.org/r/<20180510125211.12583-1-dima@arista.com>
> 
> Dropped `name' in as it's unused in RATELIMIT_STATE_INIT()
> 
> diff --git a/lib/ratelimit.c b/lib/ratelimit.c
> index d01f47135239..d9b749d40108 100644
> --- a/lib/ratelimit.c
> +++ b/lib/ratelimit.c
> @@ -13,6 +13,18 @@
>  #include <linux/jiffies.h>
>  #include <linux/export.h>
>  
> +static void ratelimit_end_interval(struct ratelimit_state *rs, const char *func)
> +{
> +	rs->begin = jiffies;
> +
> +	if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
> +		unsigned int missed = atomic_xchg(&rs->missed, 0);
> +
> +		if (missed)
> +			pr_warn("%s: %u callbacks suppressed\n", func, missed);
> +	}
> +}
> +
>  /*
>   * __ratelimit - rate limiting
>   * @rs: ratelimit_state data
> @@ -27,45 +39,30 @@
>   */
>  int ___ratelimit(struct ratelimit_state *rs, const char *func)
>  {
> -	unsigned long flags;
> -	int ret;
> -
>  	if (!rs->interval)
>  		return 1;
>  
> -	/*
> -	 * If we contend on this state's lock then almost
> -	 * by definition we are too busy to print a message,
> -	 * in addition to the one that will be printed by
> -	 * the entity that is holding the lock already:
> -	 */
> -	if (!raw_spin_trylock_irqsave(&rs->lock, flags))
> +	if (unlikely(!rs->burst)) {
> +		atomic_add_unless(&rs->missed, 1, -1);
> +		if (time_is_before_jiffies(rs->begin + rs->interval))
> +			ratelimit_end_interval(rs, func);

This is racy. time_is_before_jiffies() might be valid on two
CPUs in parallel. They would both call ratelimit_end_interval().
This is not longer atomic context. Therefore one might get scheduled
and set rs->begin = jiffies seconds later. I am sure that there might
be more crazy scenarios.

> +
>  		return 0;
> +	}
>  
> -	if (!rs->begin)
> -		rs->begin = jiffies;
> +	if (atomic_add_unless(&rs->printed, 1, rs->burst))
> +		return 1;
>  
>  	if (time_is_before_jiffies(rs->begin + rs->interval)) {
> -		if (rs->missed) {
> -			if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
> -				printk_deferred(KERN_WARNING
> -						"%s: %d callbacks suppressed\n",
> -						func, rs->missed);
> -				rs->missed = 0;
> -			}
> -		}
> -		rs->begin   = jiffies;
> -		rs->printed = 0;
> -	}
> -	if (rs->burst && rs->burst > rs->printed) {
> -		rs->printed++;
> -		ret = 1;
> -	} else {
> -		rs->missed++;
> -		ret = 0;
> +		if (atomic_cmpxchg(&rs->printed, rs->burst, 0))
> +			ratelimit_end_interval(rs, func);
>  	}
> -	raw_spin_unlock_irqrestore(&rs->lock, flags);
>  
> -	return ret;
> +	if (atomic_add_unless(&rs->printed, 1, rs->burst))
> +		return 1;

The entire logic is complicated and hard to understand. Especially calling
ratelimit_end_interval() and atomic_add_unless(&rs->printed) twice.

> +	atomic_add_unless(&rs->missed, 1, -1);
> +
> +	return 0;
>  }


I wonder if the following code would do the job (not even compile tested!):

static void ratelimit_end_interval(struct ratelimit_state *rs, const char *func)
{
	rs->begin = jiffies;

	if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
		unsigned int missed = atomic_xchg(&rs->missed, 0);

		if (missed)
			pr_warn("%s: %u callbacks suppressed\n", func, missed);
	}

	atomic_xchg(&rs->printed, 0);
}

/*
 * __ratelimit - rate limiting
 * @rs: ratelimit_state data
 * @func: name of calling function
 *
 * This enforces a rate limit: not more than @rs->burst callbacks
 * in every @rs->interval
 *
 * RETURNS:
 * 0 means callbacks will be suppressed.
 * 1 means go ahead and do it.
 */
int ___ratelimit(struct ratelimit_state *rs, const char *func)
{
	unsigned long begin, old_begin = rs->begin;

	if (!rs->interval)
		return 1;

	if (time_is_before_jiffies(rs->begin + rs->interval) &&
	    cmpxchg(&rs->begin, begin, begin + rs->interval) == begin) {
		ratelimit_end_interval(rs, func);
	}

	if (atomic_add_unless(&rs->printed, 1, rs->burst))
		return 1;

	atomic_add_unless(&rs->missed, 1, -1);
	return 0;
}
EXPORT_SYMBOL(___ratelimit);


The main logic is the same as in the original code. Only one CPU is
able to reset the interval and counters (thanks to cmpxchg).
Every caller increases either "printed" or "missed" counter.

Best Regards,
Petr
