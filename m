Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355DFC41518
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECF52184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="d50Ovv6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAWP54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:57:56 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41207 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfAWP54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:57:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so1353221qkj.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TVahuUIm6+Oi8+rKguvJ6cZt9Hw5MKD5piU2jLdwJ04=;
        b=d50Ovv6mPPKg+/cnPcUfMO/LT6fX+1CBrJQxhtyyzSZuZiFDGFtWohnZdu2PZ8zpxa
         HMGk2xNANpInLTM+PyxORvCoBZ0Nsjs7s3yPRKFeT4rj3qPoT4WfUne/7li336VysiL0
         sF6rL8Ge9N3yJIU+kfZptR6256cr0cmrMvcNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TVahuUIm6+Oi8+rKguvJ6cZt9Hw5MKD5piU2jLdwJ04=;
        b=NiLsvNEAT/hSnjELg2Num3AdrAelyEIRHY2AmIAmIAQjozDe6Q6uuAnCdjKXvt3IB4
         9xLTQPcEiuab2C2MD7KQbc/Oq7uhkgWJ81EPwZuCWBbXClhYAysE32qKtH2Gwgk0NjCi
         0olviDITBJyY55IFG8lXKJjbZ75IMUR3P/sURjIQ0LyDLw9zUpvGBY0uY8hfCzJdQwpN
         P84LSxyCZKut9E3+sKeH2uQaM4nf+p5JpQeR2ncOoN1gzUi4Yy64v1UTd7k3BXyaETL0
         hnz1RsvombQ1kXht5NMi2XDPcqPm2uhpzYodTbPf09J4yRqxodIPwhOzdfN05343aRZ4
         HerA==
X-Gm-Message-State: AJcUukdkRpzK7+0Pk0MjWDC8fY8aC690EdKatGrKXvvaxHkLlNEsnlRQ
        SXXPqi6fLFipHEH0HQMpEKa84Q==
X-Google-Smtp-Source: ALg8bN65X3e+WWan8ued4AILV9F3eLxwMJcSReotSV9cJeKIjbteKm1329HpbVcoNiMKOP5RDXNNhw==
X-Received: by 2002:a37:6e43:: with SMTP id j64mr2107890qkc.278.1548259074283;
        Wed, 23 Jan 2019 07:57:54 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id f36sm59078568qtb.67.2019.01.23.07.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 07:57:52 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:57:51 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Todd Kjos <tkjos@google.com>,
        syzbot+a76129f18c89f3e2ddd4@syzkaller.appspotmail.com,
        ak@linux.intel.com, Johannes Weiner <hannes@cmpxchg.org>,
        jack@suse.cz, jrdr.linux@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: possible deadlock in __do_page_fault
Message-ID: <20190123155751.GA168927@google.com>
References: <4b0a5f8c-2be2-db38-a70d-8d497cb67665@I-love.SAKURA.ne.jp>
 <20190122153220.GA191275@google.com>
 <201901230201.x0N214eq043832@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201901230201.x0N214eq043832@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:01:04AM +0900, Tetsuo Handa wrote:
> Joel Fernandes wrote:
> > > Why do we need to call fallocate() synchronously with ashmem_mutex held?
> > > Why can't we call fallocate() asynchronously from WQ_MEM_RECLAIM workqueue
> > > context so that we can call fallocate() with ashmem_mutex not held?
> > > 
> > > I don't know how ashmem works, but as far as I can guess, offloading is
> > > possible as long as other operations which depend on the completion of
> > > fallocate() operation (e.g. read()/mmap(), querying/changing pinned status)
> > > wait for completion of asynchronous fallocate() operation (like a draft
> > > patch shown below is doing).
> > 
> > This adds a bit of complexity, I am worried if it will introduce more
> > bugs especially because ashmem is going away in the long term, in favor of
> > memfd - and if its worth adding more complexity / maintenance burden to it.
> 
> I don't care migrating to memfd. I care when bugs are fixed.

That's fair. I'm not a fan of bugs either. I was just making a point that -
we want to fix things while not introducing unwanted complexity and cause
more bugs. That said, thanks for the patch and trying to fix it.

> > I am wondering if we can do this synchronously, without using a workqueue.
> > All you would need is a temporary list of areas to punch. In
> > ashmem_shrink_scan, you would create this list under mutex and then once you
> > release the mutex, you can go through this list and do the fallocate followed
> > by the wake up of waiters on the wait queue, right? If you can do it this
> > way, then it would be better IMO.
> 
> Are you sure that none of locks held before doing GFP_KERNEL allocation
> interferes lock dependency used by fallocate() ? If yes, we can do without a
> workqueue context (like a draft patch shown below). Since I don't understand
> what locks are potentially involved, I offloaded to a clean workqueue context.

fallocate acquires inode locks. So there is a lock dependency between
- memory reclaim (fake lock)
- inode locks.

This dependency is there whether we have your patch or not. I am not aware of
any other locks that are held other than these. But you could also just use
lockdep to dump all held locks at that point to confirm.

> Anyway, I need your checks regarding whether this approach is waiting for
> completion at all locations which need to wait for completion.

I think you are waiting in unwanted locations. The only location you need to
wait in is ashmem_pin_unpin.

So, to my eyes all that is needed to fix this bug is:

1. Delete the range from the ashmem_lru_list
2. Release the ashmem_mutex
3. fallocate the range.
4. Do the completion so that any waiting pin/unpin can proceed.

Could you clarify why you feel you need to wait for completion at those other
locations?

Note that once a range is unpinned, it is open sesame and userspace cannot
really expect consistent data from such range till it is pinned again.

Thanks!

 - Joel


> ---
>  drivers/staging/android/ashmem.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 90a8a9f1ac7d..6a267563cb66 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -75,6 +75,9 @@ struct ashmem_range {
>  /* LRU list of unpinned pages, protected by ashmem_mutex */
>  static LIST_HEAD(ashmem_lru_list);
>  
> +static atomic_t ashmem_shrink_inflight = ATOMIC_INIT(0);
> +static DECLARE_WAIT_QUEUE_HEAD(ashmem_shrink_wait);
> +
>  /*
>   * long lru_count - The count of pages on our LRU list.
>   *
> @@ -292,6 +295,7 @@ static ssize_t ashmem_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	int ret = 0;
>  
>  	mutex_lock(&ashmem_mutex);
> +	wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
>  
>  	/* If size is not set, or set to 0, always return EOF. */
>  	if (asma->size == 0)
> @@ -359,6 +363,7 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	int ret = 0;
>  
>  	mutex_lock(&ashmem_mutex);
> +	wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
>  
>  	/* user needs to SET_SIZE before mapping */
>  	if (!asma->size) {
> @@ -438,7 +443,6 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  static unsigned long
>  ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  {
> -	struct ashmem_range *range, *next;
>  	unsigned long freed = 0;
>  
>  	/* We might recurse into filesystem code, so bail out if necessary */
> @@ -448,17 +452,27 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	if (!mutex_trylock(&ashmem_mutex))
>  		return -1;
>  
> -	list_for_each_entry_safe(range, next, &ashmem_lru_list, lru) {
> +	while (!list_empty(&ashmem_lru_list)) {
> +		struct ashmem_range *range =
> +			list_first_entry(&ashmem_lru_list, typeof(*range), lru);
>  		loff_t start = range->pgstart * PAGE_SIZE;
>  		loff_t end = (range->pgend + 1) * PAGE_SIZE;
> +		struct file *f = range->asma->file;
>  
> -		range->asma->file->f_op->fallocate(range->asma->file,
> -				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -				start, end - start);
> +		get_file(f);
> +		atomic_inc(&ashmem_shrink_inflight);
>  		range->purged = ASHMEM_WAS_PURGED;
>  		lru_del(range);
>  
>  		freed += range_size(range);
> +		mutex_unlock(&ashmem_mutex);
> +		f->f_op->fallocate(f,
> +				   FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +				   start, end - start);
> +		fput(f);
> +		if (atomic_dec_and_test(&ashmem_shrink_inflight))
> +			wake_up_all(&ashmem_shrink_wait);
> +		mutex_lock(&ashmem_mutex);
>  		if (--sc->nr_to_scan <= 0)
>  			break;
>  	}
> @@ -713,6 +727,7 @@ static int ashmem_pin_unpin(struct ashmem_area *asma, unsigned long cmd,
>  		return -EFAULT;
>  
>  	mutex_lock(&ashmem_mutex);
> +	wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
>  
>  	if (!asma->file)
>  		goto out_unlock;
> -- 
> 2.17.1
