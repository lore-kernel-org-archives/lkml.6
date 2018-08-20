Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EB4C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E20E20779
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nL9TX9es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E20E20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeHUCcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:32:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37835 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeHUCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:32:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id b10-v6so9506568eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 16:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrtzVsVvH+VhN7407IKdVVxWTgT3dBE3qmij5YXhR1M=;
        b=nL9TX9esDsproKgB7JQwJ5g37dqByoGniexRzoVcmGSFqfKMAO9Fzq9c5N1LVqvm1y
         bTPif8GdcYAQQEZK6HJbYdR2solDkxXI5F8AwccgnJqd1BVpwfp0qiulEOifaDggXhu/
         vIuL4AUQQ5SjPqUmVqzgreuFfAWxATtOisarN4H/ixt43p97WgtqrKB4psgA7vwJQqzG
         kusO77CAuUHEVYKXmqAX7zKOpzXlx9FHszE4LaPN0xI3te64a/oB2CLVJQ45JlHT0Bza
         cFF6qT5p6RLyieDJwD0PJW0MBAGQwd03hkFvin05z7VVX6bc8kaFksrCVoItY9dNd5Uq
         JVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrtzVsVvH+VhN7407IKdVVxWTgT3dBE3qmij5YXhR1M=;
        b=MrdpD+rIWGB0+5VcpuHp13KCFkcmZ+JqNgS3RwMzfhPqebAlV641d+dbehQCUsIn4q
         elp4e3iZCeUmuuFkPhd8Tp497qqVkb8vHjGmfjGa+EcB0SevP07P5lN8StJId2yT0A+5
         HboihbDxN5iNHVvOPiTJb8wD5V9SAsQ+dfQjwBIF7Dpxk2gFSzHkpKh1hiVAOYaIXyBq
         7R+VjvGComIfk4oTIINEOT/jb/BPBl0kLL47nr++sychXFkRmx2kpkqgf5SuYHL81PbE
         dUDQ/xH6fbp9rgvpxCNzMyPQZ/dxB9aBXHxB6QzfkEi+2KMdR3jX8W0aW9yvvnewNKgG
         N6Yw==
X-Gm-Message-State: AOUpUlHChkWz1a303XYyaV2lsouRAethtsu+Hc8d4FdGdKX7OtgZRBDQ
        qbY6rFvFkRjrUADwgsbD3I/Nhw==
X-Google-Smtp-Source: AA+uWPySiO/ajvY0R5VC0XKGKIb+Xw4nCRI1WfWv+n2Kl3uaDXWPzcm25oKPEsqkBntxNAkD9O4HQQ==
X-Received: by 2002:a50:a392:: with SMTP id s18-v6mr59001928edb.271.1534806877157;
        Mon, 20 Aug 2018 16:14:37 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h8-v6sm6632738edi.68.2018.08.20.16.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 16:14:36 -0700 (PDT)
Message-ID: <1534806875.30457.28.camel@arista.com>
Subject: Re: [PATCHv3] lib/ratelimit: Lockless ratelimiting
From:   Dmitry Safonov <dima@arista.com>
To:     Petr Mladek <pmladek@suse.com>
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
Date:   Tue, 21 Aug 2018 00:14:35 +0100
In-Reply-To: <20180815151047.qgjam3t3ujyacmaf@pathway.suse.cz>
References: <20180703225628.25684-1-dima@arista.com>
         <20180815151047.qgjam3t3ujyacmaf@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr, thanks for review,

On Wed, 2018-08-15 at 17:10 +0200, Petr Mladek wrote:
> On Tue 2018-07-03 23:56:28, Dmitry Safonov wrote:
> > Currently ratelimit_state is protected with spin_lock. If the .lock
> > is
> > taken at the moment of ___ratelimit() call, the message is
> > suppressed to
> > make ratelimiting robust.
> > 
> > That results in the following issue issue:
> >       CPU0                          CPU1
> > ------------------           ------------------
> > printk_ratelimit()           printk_ratelimit()
> >         |                             |
> >   try_spin_lock()              try_spin_lock()
> >         |                             |
> > time_is_before_jiffies()          return 0; // suppress
> > 
> > So, concurrent call of ___ratelimit() results in silently
> > suppressing
> > one of the messages, regardless if the limit is reached or not.
> > And rc->missed is not increased in such case so the issue is
> > covered
> > from user.
> > 
> > Convert ratelimiting to use atomic counters and drop spin_lock.
> > 
> > Note: That might be unexpected, but with the first interval of
> > messages
> > storm one can print up to burst*2 messages. So, it doesn't
> > guarantee
> > that in *any* interval amount of messages is lesser than burst.
> > But, that differs lightly from previous behavior where one can
> > start
> > burst=5 interval and print 4 messages on the last milliseconds of
> > interval + new 5 messages from new interval (totally 9 messages in
> > lesser than interval value):
> 
> I am still confused by this paragraph. Does this patch change the
> behavior? What is the original and what is the new one, please?

Yeah, I could be a bit cleaner about the change.
Originally more than `burst` messages could be printed if the previous
period hasn't ended:

> 
> >    msg0              msg1-msg4 msg0-msg4
> >     |                     |       |
> >     |                     |       |
> >  |--o---------------------o-|-----o--------------------|--> (t)
> >                           <------->
> >                        Lesser than burst

But now, because I check:
+       if (atomic_add_unless(&rs->printed, 1, rs->burst))
+               return 1;

*before* checking the end of interval, the maximum number of messages
in the peak will be the same, burst*2 (burst*2 - 1 in original).
Why do I check it before the end of interval?
I thought it would be a nice optimization, making atomic_add_unless()
the only called function on the fast-path (when we haven't hit the
limit yet). If you want, I can move it into a separate patch..

> > 
> > Dropped dev/random patch since v1 version:
> > lkml.kernel.org/r/<20180510125211.12583-1-dima@arista.com>
> > 
> > Dropped `name' in as it's unused in RATELIMIT_STATE_INIT()
> > 
> > diff --git a/lib/ratelimit.c b/lib/ratelimit.c
> > index d01f47135239..d9b749d40108 100644
> > --- a/lib/ratelimit.c
> > +++ b/lib/ratelimit.c
> > @@ -13,6 +13,18 @@
> >  #include <linux/jiffies.h>
> >  #include <linux/export.h>
> >  
> > +static void ratelimit_end_interval(struct ratelimit_state *rs,
> > const char *func)
> > +{
> > +	rs->begin = jiffies;
> > +
> > +	if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
> > +		unsigned int missed = atomic_xchg(&rs->missed, 0);
> > +
> > +		if (missed)
> > +			pr_warn("%s: %u callbacks suppressed\n",
> > func, missed);
> > +	}
> > +}
> > +
> >  /*
> >   * __ratelimit - rate limiting
> >   * @rs: ratelimit_state data
> > @@ -27,45 +39,30 @@
> >   */
> >  int ___ratelimit(struct ratelimit_state *rs, const char *func)
> >  {
> > -	unsigned long flags;
> > -	int ret;
> > -
> >  	if (!rs->interval)
> >  		return 1;
> >  
> > -	/*
> > -	 * If we contend on this state's lock then almost
> > -	 * by definition we are too busy to print a message,
> > -	 * in addition to the one that will be printed by
> > -	 * the entity that is holding the lock already:
> > -	 */
> > -	if (!raw_spin_trylock_irqsave(&rs->lock, flags))
> > +	if (unlikely(!rs->burst)) {
> > +		atomic_add_unless(&rs->missed, 1, -1);
> > +		if (time_is_before_jiffies(rs->begin + rs-
> > >interval))
> > +			ratelimit_end_interval(rs, func);
> 
> This is racy. time_is_before_jiffies() might be valid on two
> CPUs in parallel. They would both call ratelimit_end_interval().
> This is not longer atomic context. Therefore one might get scheduled
> and set rs->begin = jiffies seconds later. I am sure that there might
> be more crazy scenarios.

That's the case with rs->burst == 0.
So, in this situation all the messages will be suppressed.
And the only reason to call ratelimit_end_interval() is to update the
start time and number of messages not printed.
I didn't want to add any complexion for this case - the worst will be
the count of messages suppressed will be imprecise for rs->burst == 0
case. Not a big deal, huh?

> 
> > +
> >  		return 0;
> > +	}
> >  
> > -	if (!rs->begin)
> > -		rs->begin = jiffies;
> > +	if (atomic_add_unless(&rs->printed, 1, rs->burst))
> > +		return 1;
> >  
> >  	if (time_is_before_jiffies(rs->begin + rs->interval)) {
> > -		if (rs->missed) {
> > -			if (!(rs->flags &
> > RATELIMIT_MSG_ON_RELEASE)) {
> > -				printk_deferred(KERN_WARNING
> > -						"%s: %d callbacks
> > suppressed\n",
> > -						func, rs->missed);
> > -				rs->missed = 0;
> > -			}
> > -		}
> > -		rs->begin   = jiffies;
> > -		rs->printed = 0;
> > -	}
> > -	if (rs->burst && rs->burst > rs->printed) {
> > -		rs->printed++;
> > -		ret = 1;
> > -	} else {
> > -		rs->missed++;
> > -		ret = 0;
> > +		if (atomic_cmpxchg(&rs->printed, rs->burst, 0))
> > +			ratelimit_end_interval(rs, func);
> >  	}
> > -	raw_spin_unlock_irqrestore(&rs->lock, flags);
> >  
> > -	return ret;
> > +	if (atomic_add_unless(&rs->printed, 1, rs->burst))
> > +		return 1;
> 
> The entire logic is complicated and hard to understand. Especially
> calling
> ratelimit_end_interval() and atomic_add_unless(&rs->printed) twice.

Probably, I've described the reasons above.. I may add a comment or
drop the first atomic_add_unless(), but I would prefer still keep it
there, having only one check for fast-path.

> 
> > +	atomic_add_unless(&rs->missed, 1, -1);
> > +
> > +	return 0;
> >  }
> 
> 
> I wonder if the following code would do the job (not even compile
> tested!):
> 
> static void ratelimit_end_interval(struct ratelimit_state *rs, const
> char *func)
> {
> 	rs->begin = jiffies;
> 
> 	if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
> 		unsigned int missed = atomic_xchg(&rs->missed, 0);
> 
> 		if (missed)
> 			pr_warn("%s: %u callbacks suppressed\n", func,
> missed);
> 	}
> 
> 	atomic_xchg(&rs->printed, 0);
> }
> 
> /*
>  * __ratelimit - rate limiting
>  * @rs: ratelimit_state data
>  * @func: name of calling function
>  *
>  * This enforces a rate limit: not more than @rs->burst callbacks
>  * in every @rs->interval
>  *
>  * RETURNS:
>  * 0 means callbacks will be suppressed.
>  * 1 means go ahead and do it.
>  */
> int ___ratelimit(struct ratelimit_state *rs, const char *func)
> {
> 	unsigned long begin, old_begin = rs->begin;
> 
> 	if (!rs->interval)
> 		return 1;
> 
> 	if (time_is_before_jiffies(rs->begin + rs->interval) &&
> 	    cmpxchg(&rs->begin, begin, begin + rs->interval) == begin) 

Probably, cmpxchg(&rs->begin, begin, jiffies)?
Otherwise hitting it later will be buggy.
Also `begin` might be uninitialized? (if cmpxchg() fails)

> {
> 		ratelimit_end_interval(rs, func);
> 	}
> 
> 	if (atomic_add_unless(&rs->printed, 1, rs->burst))
> 		return 1;
> 
> 	atomic_add_unless(&rs->missed, 1, -1);
> 	return 0;
> }
> EXPORT_SYMBOL(___ratelimit);
> 
> 
> The main logic is the same as in the original code. Only one CPU is
> able to reset the interval and counters (thanks to cmpxchg).
> Every caller increases either "printed" or "missed" counter.

Do we care about fast-path argument I did above?

-- 
Thanks,
             Dmitry
