Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEDFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BB6217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfBEUPz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:15:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfBEUPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:15:55 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D236BA4E8;
        Tue,  5 Feb 2019 20:15:53 +0000 (UTC)
Date:   Tue, 5 Feb 2019 12:15:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Abramov <st5pub@yandex.ru>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH 1/1] Lib: sort.c: replaced heap sort algorithm with
 introspective sort
Message-Id: <20190205121552.065ec259d28e6cd06bf7099c@linux-foundation.org>
In-Reply-To: <20190205182413.16202-1-st5pub@yandex.ru>
References: <20190205182413.16202-1-st5pub@yandex.ru>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Feb 2019 21:24:13 +0300 Andrey Abramov <st5pub@yandex.ru> wrote:

> Replaced heap sort algorithm with faster introspective sort algorithm.
> 
> Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
> ---
> v1: The introspective sort algorithm is faster the heap sort (for example on my machine on a 100MB of random data it was consistently almost twice faster) and it doesn't have the worst case, unlike qsort.

I guess faster is always better, but are there any known parts of the
kernel which actually care about the performance of sort()?

>
> ...
>
> --- a/lib/sort.c
> +++ b/lib/sort.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * A fast, small, non-recursive O(nlog n) sort for the Linux kernel
> + * A fast, recursive O(nlog n) sort for the Linux kernel

oops.  A good analysis of the maximum stack utilization is needed,
please.

>   * Jan 23 2005  Matt Mackall <mpm@selenic.com>
> + * Feb 5  2019  Andrey Abramov <st5pub@yandex.ru> (introspective sort)
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -48,33 +49,22 @@ static void generic_swap(void *a, void *b, int size)
>   * @num: number of elements
>   * @size: size of each element
>   * @cmp_func: pointer to comparison function
> - * @swap_func: pointer to swap function or NULL
> + * @swap_func: pointer to swap function
>   *
> - * This function does a heapsort on the given array. You may provide a
> - * swap_func function optimized to your element type.
> + * This function does a heapsort on the given array.
>   *
>   * Sorting time is O(n log n) both on average and worst-case. While
>   * qsort is about 20% faster on average, it suffers from exploitable
>   * O(n*n) worst-case behavior and extra memory requirements that make
>   * it less suitable for kernel use.
>   */
> -
> -void sort(void *base, size_t num, size_t size,
> +void heapsort(void *base, size_t num, size_t size,

static?

>  	  int (*cmp_func)(const void *, const void *),
>  	  void (*swap_func)(void *, void *, int size))
>  {
>  	/* pre-scale counters for performance */
>  	int i = (num/2 - 1) * size, n = num * size, c, r;
>  
> -	if (!swap_func) {
> -		if (size == 4 && alignment_ok(base, 4))
> -			swap_func = u32_swap;
> -		else if (size == 8 && alignment_ok(base, 8))
> -			swap_func = u64_swap;
> -		else
> -			swap_func = generic_swap;
> -	}
> -
>  	/* heapify */
>  	for ( ; i >= 0; i -= size) {
>  		for (r = i; r * 2 + size < n; r  = c) {
> @@ -103,4 +93,111 @@ void sort(void *base, size_t num, size_t size,
>  	}
>  }
>  
> +void introsort(void *base, size_t num, size_t size,

static?

> +	  int (*cmp_func)(const void *, const void *),
> +	  void (*swap_func)(void *, void *, int size),
> +	  unsigned int max_depth, unsigned int depth)
> +{
> +
> +	void *last = base + (num - 1) * size;
> +	void *pivot = base + ((num - 1) / 2) * size;
> +	void *i = base;
> +	void *j = last;

That's about 100 bytes per invokation.

> +	if (num <= 1)
> +		return;
> +
> +	/* switching to heapsort */

Please explain the reason for this in the comment.

> +	if (depth >= max_depth) {
> +		heapsort(base, num, size, cmp_func, swap_func);

Ditto.

> +		return;
> +	}
> +
> +	/* making pivot be the median of middle, first and last elements */

"Make"

(and why?)

> +	if ((cmp_func(pivot, base) >= 0 && cmp_func(base, last) >= 0)
> +		|| (cmp_func(last, base) >= 0 && cmp_func(base, pivot) >= 0)) {
> +		pivot = base;
> +	} else if ((cmp_func(pivot, last) >= 0 && cmp_func(last, base) >= 0)
> +		|| (cmp_func(base, last) >= 0 && cmp_func(last, pivot) >= 0)) {
> +		pivot = last;
> +	}
> +
> +	/* split array */
> +	while (true) {
> +		while (cmp_func(i, pivot) < 0 && i < last)
> +			i += size;
> +		while (cmp_func(j, pivot) > 0 && j > base)
> +			j -= size;
> +
> +		if (i >= j)
> +			break;
> +
> +		swap_func(i, j, size);
> +
> +		if (i == pivot)
> +			pivot = j;
> +		else if (j == pivot)
> +			pivot = i;
> +
> +		j -= size;
> +		i += size;
> +	}
> +
> +	/* continue for smaller parts */
> +	if (i < last)
> +		introsort(i, ((size_t)last - (size_t)i) / size + 1,
> +			size, cmp_func, swap_func, max_depth, depth + 1);
> +	if (base < j)
> +		introsort(base, ((size_t)j - (size_t)base) / size + 1,
> +			size, cmp_func, swap_func, max_depth, depth + 1);
> +}
> +
> +unsigned int log2_up(size_t val)

static?

> +{
> +	unsigned int log = 0;
> +	size_t current = 1;
> +
> +	unsigned int max_reachable_log = sizeof(val) * 8 - 1;
> +
> +	while (current < val) {
> +		current <<= 1;
> +		log++;
> +		if (log == max_reachable_log && current < val)
> +			return max_reachable_log + 1;
> +	}
> +
> +	return log;
> +}

Please add a comment explaining what this does.  Partly so that readers
(such as I) can understand why it can't utilize the existing log2().

> +
> +/**
> + * sort - sort an array of elements
> + * @base: pointer to data to sort
> + * @num: number of elements
> + * @size: size of each element
> + * @cmp_func: pointer to comparison function
> + * @swap_func: pointer to swap function or NULL
> + *
> + * This function does a introspective sort on the given array. You may provide a
> + * swap_func function optimized to your element type.
> + *
> + * The introspective sort use both qsort and heapsort,
> + * so it is faster than heapsort on average,

There's a non-ascii character after "heapsort".

> + * but it doesn't have the worst case unlike qsort

Unclear.  "like qsort"?

> + */
> +void sort(void *base, size_t num, size_t size,
> +	  int (*cmp_func)(const void *, const void *),
> +	  void (*swap_func)(void *, void *, int size))
> +{
> +	if (!swap_func) {
> +		if (size == 4 && alignment_ok(base, 4))
> +			swap_func = u32_swap;
> +		else if (size == 8 && alignment_ok(base, 8))
> +			swap_func = u64_swap;
> +		else
> +			swap_func = generic_swap;
> +	}
> +
> +	introsort(base, num, size, cmp_func, swap_func, log2_up(num) * 2, 1);
> +}
>  EXPORT_SYMBOL(sort);

