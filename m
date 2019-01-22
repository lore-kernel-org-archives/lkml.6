Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96D0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9483E21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DYpfu0JD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfAVPcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:32:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38488 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfAVPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:32:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id m17so6988776qki.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 07:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/fyipIllhCYij0+mgYcSprr3P3Cu0+j2IGNq3dx9N5w=;
        b=DYpfu0JDdTbigiHXUzGKX6UxgPq9V87234WJwDT662gZdp0XIqmelW0hwhX8HxgH4T
         79Ds4UAUD5IxUOM0n8cW7kfUZnqI31qMhncVp8KijZgwvlZYGIAro0ilh3fUm4QIpRik
         ZOZ96C2R8EyzFYEcyZ9+Ka0W9z50mFC2Xplis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/fyipIllhCYij0+mgYcSprr3P3Cu0+j2IGNq3dx9N5w=;
        b=ZdDQc6E92dfQk2aOyVLVJMavnpu4C6YggWi49b1IRdmirgfHKnecDINDbbPr+H5FBV
         ntTqVJ92sY71/ceL2D7UxDxSj8irktPAZt5WepD62fS3REPlkTF0wYEYX1jrAP49nnNN
         h12GYJMfv+NrrNHAbDnO2h0+0yOG1Tt5txeGyeA6bj3V1dJN7KLMsoHuGiIc8gtU8xWC
         wruqmppVJqRJ2IcZBnWmIesRrvwKmozOZTTh0kmkqtOZqScw9y7RLp9Ud6SaPfsy9cjP
         umczWqaS9MBIAQkuo9xQDUAIYAakDP1zMai41Aai3wFFEiHBzU6/qDkWJv8kRw+SzffN
         E8kg==
X-Gm-Message-State: AJcUukc444kSabufs16jna8JOCz/Hm7RD4GjxZtQy+H6GHLUK+h5wIjV
        wYYkJElERvZ7/khykVCYI+xoVg==
X-Google-Smtp-Source: ALg8bN4ylzwr9dGQl2vhVXGiSTCtPXX4T6HAercQ2qEiygvqL1iBZe0CUmKYyBjA1XumzIp4rm4vUg==
X-Received: by 2002:a37:5d06:: with SMTP id r6mr28719288qkb.229.1548171142462;
        Tue, 22 Jan 2019 07:32:22 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id v57sm73797530qtv.80.2019.01.22.07.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 07:32:20 -0800 (PST)
Date:   Tue, 22 Jan 2019 10:32:20 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
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
Message-ID: <20190122153220.GA191275@google.com>
References: <000000000000f7a28e057653dc6e@google.com>
 <20180920141058.4ed467594761e073606eafe2@linux-foundation.org>
 <CAHRSSEzX5HOUEQ6DgEF76OLGrwS1isWMdtvneBLOEEnwoMxVrA@mail.gmail.com>
 <CAEXW_YSot+3AMQ=jmDRowmqoOmQmujp9r8Dh18KJJN1EDmyHOw@mail.gmail.com>
 <20180921162110.e22d09a9e281d194db3c8359@linux-foundation.org>
 <4b0a5f8c-2be2-db38-a70d-8d497cb67665@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0a5f8c-2be2-db38-a70d-8d497cb67665@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 07:02:35PM +0900, Tetsuo Handa wrote:
> On 2018/09/22 8:21, Andrew Morton wrote:
> > On Thu, 20 Sep 2018 19:33:15 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> >> On Thu, Sep 20, 2018 at 5:12 PM Todd Kjos <tkjos@google.com> wrote:
> >>>
> >>> +Joel Fernandes
> >>>
> >>> On Thu, Sep 20, 2018 at 2:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>>>
> >>>>
> >>>> Thanks.  Let's cc the ashmem folks.
> >>>>
> >>
> >> This should be fixed by https://patchwork.kernel.org/patch/10572477/
> >>
> >> It has Neil Brown's Reviewed-by but looks like didn't yet appear in
> >> anyone's tree, could Greg take this patch?
> > 
> > All is well.  That went into mainline yesterday, with a cc:stable.
> > 
> 
> This problem was not fixed at all.

Why do you say so, are you able to reproduce the issue? If so, could you
share the splat?

Many splats involve issues to do with the inode lock class being the same for
files and directories, the above patch does fix those issues.

> Why do we need to call fallocate() synchronously with ashmem_mutex held?
> Why can't we call fallocate() asynchronously from WQ_MEM_RECLAIM workqueue
> context so that we can call fallocate() with ashmem_mutex not held?
> 
> I don't know how ashmem works, but as far as I can guess, offloading is
> possible as long as other operations which depend on the completion of
> fallocate() operation (e.g. read()/mmap(), querying/changing pinned status)
> wait for completion of asynchronous fallocate() operation (like a draft
> patch shown below is doing).

This adds a bit of complexity, I am worried if it will introduce more
bugs especially because ashmem is going away in the long term, in favor of
memfd - and if its worth adding more complexity / maintenance burden to it.

I am wondering if we can do this synchronously, without using a workqueue.
All you would need is a temporary list of areas to punch. In
ashmem_shrink_scan, you would create this list under mutex and then once you
release the mutex, you can go through this list and do the fallocate followed
by the wake up of waiters on the wait queue, right? If you can do it this
way, then it would be better IMO.

side note: these sort of splats are exactly the reason we're moving to memfd,
since the wrapper design of ashmem is prone to deadlocks. We fixed a lot of
deadlocks though but still.

thanks,

 - Joel


> ---
>  drivers/staging/android/ashmem.c | 50 ++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 90a8a9f1ac7d..1a890c43a10a 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -75,6 +75,17 @@ struct ashmem_range {
>  /* LRU list of unpinned pages, protected by ashmem_mutex */
>  static LIST_HEAD(ashmem_lru_list);
>  
> +static struct workqueue_struct *ashmem_wq;
> +static atomic_t ashmem_shrink_inflight = ATOMIC_INIT(0);
> +static DECLARE_WAIT_QUEUE_HEAD(ashmem_shrink_wait);
> +
> +struct ashmem_shrink_work {
> +	struct work_struct work;
> +	struct file *file;
> +	loff_t start;
> +	loff_t end;
> +};
> +
>  /*
>   * long lru_count - The count of pages on our LRU list.
>   *
> @@ -292,6 +303,7 @@ static ssize_t ashmem_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	int ret = 0;
>  
>  	mutex_lock(&ashmem_mutex);
> +	wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
>  
>  	/* If size is not set, or set to 0, always return EOF. */
>  	if (asma->size == 0)
> @@ -359,6 +371,7 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	int ret = 0;
>  
>  	mutex_lock(&ashmem_mutex);
> +	wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
>  
>  	/* user needs to SET_SIZE before mapping */
>  	if (!asma->size) {
> @@ -421,6 +434,19 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	return ret;
>  }
>  
> +static void ashmem_shrink_worker(struct work_struct *work)
> +{
> +	struct ashmem_shrink_work *w = container_of(work, typeof(*w), work);
> +
> +	w->file->f_op->fallocate(w->file,
> +				 FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +				 w->start, w->end - w->start);
> +	fput(w->file);
> +	kfree(w);
> +	if (atomic_dec_and_test(&ashmem_shrink_inflight))
> +		wake_up_all(&ashmem_shrink_wait);
> +}
> +
>  /*
>   * ashmem_shrink - our cache shrinker, called from mm/vmscan.c
>   *
> @@ -449,12 +475,18 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		return -1;
>  
>  	list_for_each_entry_safe(range, next, &ashmem_lru_list, lru) {
> -		loff_t start = range->pgstart * PAGE_SIZE;
> -		loff_t end = (range->pgend + 1) * PAGE_SIZE;
> +		struct ashmem_shrink_work *w = kzalloc(sizeof(*w), GFP_ATOMIC);
> +
> +		if (!w)
> +			break;
> +		INIT_WORK(&w->work, ashmem_shrink_worker);
> +		w->file = range->asma->file;
> +		get_file(w->file);
> +		w->start = range->pgstart * PAGE_SIZE;
> +		w->end = (range->pgend + 1) * PAGE_SIZE;
> +		atomic_inc(&ashmem_shrink_inflight);
> +		queue_work(ashmem_wq, &w->work);
>  
> -		range->asma->file->f_op->fallocate(range->asma->file,
> -				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -				start, end - start);
>  		range->purged = ASHMEM_WAS_PURGED;
>  		lru_del(range);
>  
> @@ -713,6 +745,7 @@ static int ashmem_pin_unpin(struct ashmem_area *asma, unsigned long cmd,
>  		return -EFAULT;
>  
>  	mutex_lock(&ashmem_mutex);
> +	wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
>  
>  	if (!asma->file)
>  		goto out_unlock;
> @@ -883,8 +916,15 @@ static int __init ashmem_init(void)
>  		goto out_free2;
>  	}
>  
> +	ashmem_wq = alloc_workqueue("ashmem_wq", WQ_MEM_RECLAIM, 0);
> +	if (!ashmem_wq) {
> +		pr_err("failed to create workqueue\n");
> +		goto out_demisc;
> +	}
> +
>  	ret = register_shrinker(&ashmem_shrinker);
>  	if (ret) {
> +		destroy_workqueue(ashmem_wq);
>  		pr_err("failed to register shrinker!\n");
>  		goto out_demisc;
>  	}
> -- 
> 2.17.1
