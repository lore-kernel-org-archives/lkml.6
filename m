Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B6C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F342175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TPTYJCkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfA1Wpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:45:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34182 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1Wpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:45:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so20316535qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 14:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ma4gMd+9dw3VfggiKiIwCmxrdS3+NuicG/7QTIikafw=;
        b=TPTYJCkUhd6bgO13sc0uwD+Es+t+aRGKl+NaO029KYESxB6+O6CajTu6q6CviHuZuM
         WShcA7pwr22DZC0S4HMGrCywnTRVy4c0oZnNIcv1Dd6CrppZHE9CpseemkMeU/245MnH
         THoXvc8JHAb+5h52FQNDYC9tMXMByRjWmOJPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ma4gMd+9dw3VfggiKiIwCmxrdS3+NuicG/7QTIikafw=;
        b=BVVei0DOGj5T4Y1mp2ExuRqQYlqWBn5xcXdimMI3OuOSjMySRPwDhOm7eD/Q+FwIpv
         jqpXGBKsDXglexW7K7t9sJSH77wwaD+qLBYzWe8JM4RBkm82iOPRhChNn6ihN+8mbDe9
         fc6sU9xuQdExeTXek134UyD5npm9394KBfHn3hjv9rzHY8+mHyQJYO6qN92AJKu+cccD
         BELIrKnoMwYf0XasSBI5OOeoG/Ag4FDq8iQ0L2W5Lw19ygoIe//CSHXcTI4xoo1dPl/s
         Yp9e6V0M5l+xV6d/uaZO2NfyxK5nI+Lvsh91QUo41S/QQAnrBeHC2Wg3yTc2xiIE2X4z
         7YiA==
X-Gm-Message-State: AJcUukfKF491IMybPrczKrfj6lSEB1yaSwoj84vWxESa5lCW3n9705U7
        7+zb9q4jD15AKv7bnOLWJi+4+w==
X-Google-Smtp-Source: ALg8bN6F5olPmlLpiXIP9Hb57M5Qktvq1qbb/tHKjEiaMclG8cHMr3wbSBiP/lGhmaxZmszR5x2PcQ==
X-Received: by 2002:a0c:ae30:: with SMTP id y45mr21676404qvc.145.1548715529790;
        Mon, 28 Jan 2019 14:45:29 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id n8sm90742157qtk.91.2019.01.28.14.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 14:45:28 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:45:28 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 2/2] mm: add priority threshold to
 __purge_vmap_area_lazy()
Message-ID: <20190128224528.GB38107@google.com>
References: <20190124115648.9433-1-urezki@gmail.com>
 <20190124115648.9433-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124115648.9433-3-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:56:48PM +0100, Uladzislau Rezki (Sony) wrote:
> commit 763b218ddfaf ("mm: add preempt points into
> __purge_vmap_area_lazy()")
> 
> introduced some preempt points, one of those is making an
> allocation more prioritized over lazy free of vmap areas.
> 
> Prioritizing an allocation over freeing does not work well
> all the time, i.e. it should be rather a compromise.
> 
> 1) Number of lazy pages directly influence on busy list length
> thus on operations like: allocation, lookup, unmap, remove, etc.
> 
> 2) Under heavy stress of vmalloc subsystem i run into a situation
> when memory usage gets increased hitting out_of_memory -> panic
> state due to completely blocking of logic that frees vmap areas
> in the __purge_vmap_area_lazy() function.
> 
> Establish a threshold passing which the freeing is prioritized
> back over allocation creating a balance between each other.

I'm a bit concerned that this will introduce the latency back if vmap_lazy_nr
is greater than half of lazy_max_pages(). Which IIUC will be more likely if
the number of CPUs is large.

In fact, when vmap_lazy_nr is high, that's when the latency will be the worst
so one could say that that's when you *should* reschedule since the frees are
taking too long and hurting real-time tasks.

Could this be better solved by tweaking lazy_max_pages() such that purging is
more aggressive?

Another approach could be to detect the scenario you brought up (allocations
happening faster than free), somehow, and avoid a reschedule?

thanks,

 - Joel

> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index fb4fb5fcee74..abe83f885069 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -661,23 +661,27 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  	struct llist_node *valist;
>  	struct vmap_area *va;
>  	struct vmap_area *n_va;
> -	bool do_free = false;
> +	int resched_threshold;
>  
>  	lockdep_assert_held(&vmap_purge_lock);
>  
>  	valist = llist_del_all(&vmap_purge_list);
> +	if (unlikely(valist == NULL))
> +		return false;
> +
> +	/*
> +	 * TODO: to calculate a flush range without looping.
> +	 * The list can be up to lazy_max_pages() elements.
> +	 */
>  	llist_for_each_entry(va, valist, purge_list) {
>  		if (va->va_start < start)
>  			start = va->va_start;
>  		if (va->va_end > end)
>  			end = va->va_end;
> -		do_free = true;
>  	}
>  
> -	if (!do_free)
> -		return false;
> -
>  	flush_tlb_kernel_range(start, end);
> +	resched_threshold = (int) lazy_max_pages() << 1;
>  
>  	spin_lock(&vmap_area_lock);
>  	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
> @@ -685,7 +689,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  
>  		__free_vmap_area(va);
>  		atomic_sub(nr, &vmap_lazy_nr);
> -		cond_resched_lock(&vmap_area_lock);
> +
> +		if (atomic_read(&vmap_lazy_nr) < resched_threshold)
> +			cond_resched_lock(&vmap_area_lock);
>  	}
>  	spin_unlock(&vmap_area_lock);
>  	return true;
> -- 
> 2.11.0
> 
