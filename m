Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbeDDQAG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751990AbeDDQAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:00:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF3521707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 12:00:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] ring-buffer: Add set/clear_current_oom_origin() during
 allocations
Message-ID: <20180404120002.6561a5bc@gandalf.local.home>
In-Reply-To: <20180404115310.6c69e7b9@gandalf.local.home>
References: <20180404115310.6c69e7b9@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 11:53:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -1162,35 +1163,60 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>  static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
>  {
>  	struct buffer_page *bpage, *tmp;
> +	bool user_thread = current->mm != NULL;
> +	gfp_t mflags;
>  	long i;
>  
> -	/* Check if the available memory is there first */
> +	/*
> +	 * Check if the available memory is there first.
> +	 * Note, si_mem_available() only gives us a rough estimate of available
> +	 * memory. It may not be accurate. But we don't care, we just want
> +	 * to prevent doing any allocation when it is obvious that it is
> +	 * not going to succeed.
> +	 */

In case you are wondering how I tested this, I simply added:

#if 0
>  	i = si_mem_available();
>  	if (i < nr_pages)
>  		return -ENOMEM;
#endif

for the tests. Note, without this, I tried to allocate all memory
(bisecting it with allocations that failed and allocations that
succeeded), and couldn't trigger an OOM :-/

Of course, this was on x86_64, where I'm sure I could allocate
any memory, and probably would have had more luck with a 32bit kernel
using higmem.

-- Steve

>  
> +	/*
> +	 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
> +	 * gracefully without invoking oom-killer and the system is not
> +	 * destabilized.
> +	 */
> +	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
> +
> +	/*
> +	 * If a user thread allocates too much, and si_mem_available()
> +	 * reports there's enough memory, even though there is not.
> +	 * Make sure the OOM killer kills this thread. This can happen
> +	 * even with RETRY_MAYFAIL because another task may be doing
> +	 * an allocation after this task has taken all memory.
> +	 * This is the task the OOM killer needs to take out during this
> +	 * loop, even if it was triggered by an allocation somewhere else.
> +	 */
> +	if (user_thread)
> +		set_current_oom_origin();
>  	for (i = 0; i < nr_pages; i++) {
>  		struct page *page;
> -		/*
> -		 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
> -		 * gracefully without invoking oom-killer and the system is not
> -		 * destabilized.
> -		 */
> +
>  		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
> -				    GFP_KERNEL | __GFP_RETRY_MAYFAIL,
> -				    cpu_to_node(cpu));
> +				    mflags, cpu_to_node(cpu));
>  		if (!bpage)
>  			goto free_pages;
>  
>  		list_add(&bpage->list, pages);
>  
> -		page = alloc_pages_node(cpu_to_node(cpu),
> -					GFP_KERNEL | __GFP_RETRY_MAYFAIL, 0);
> +		page = alloc_pages_node(cpu_to_node(cpu), mflags, 0);
>  		if (!page)
>  			goto free_pages;
>  		bpage->page = page_address(page);
>  		rb_init_page(bpage->page);
> +
> +		if (user_thread && fatal_signal_pending(current))
> +			goto free_pages;
>  	}
> +	if (user_thread)
> +		clear_current_oom_origin();
>  
>  	return 0;
>  
> @@ -1199,6 +1225,8 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
>  		list_del_init(&bpage->list);
>  		free_buffer_page(bpage);
>  	}
> +	if (user_thread)
> +		clear_current_oom_origin();
>  
>  	return -ENOMEM;
>  }
