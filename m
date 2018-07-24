Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0499C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9693F20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9693F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbeGXWCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:02:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388651AbeGXWCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:02:08 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A940D9D;
        Tue, 24 Jul 2018 20:53:51 +0000 (UTC)
Date:   Tue, 24 Jul 2018 13:53:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Salman Qazi <sqazi@google.com>, Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Alain Trinh <nullptr@google.com>
Subject: Re: [PATCH] RFC: clear 1G pages with streaming stores on x86
Message-Id: <20180724135350.91a90f4f8742ec59c42721c3@linux-foundation.org>
In-Reply-To: <20180724204639.26934-1-cannonmatthews@google.com>
References: <20180724204639.26934-1-cannonmatthews@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 13:46:39 -0700 Cannon Matthews <cannonmatthews@google.com> wrote:

> Reimplement clear_gigantic_page() to clear gigabytes pages using the
> non-temporal streaming store instructions that bypass the cache
> (movnti), since an entire 1GiB region will not fit in the cache anyway.
> 
> ...
> 
> Tested:
> 	Time to `mlock()` a 512GiB region on broadwell CPU
> 				AVG time (s)	% imp.	ms/page
> 	clear_page_erms		133.584		-	261
> 	clear_page_nt		34.154		74.43%	67

A gigantic improvement!

> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -56,6 +56,9 @@ static inline void clear_page(void *page)
> 
>  void copy_page(void *to, void *from);
> 
> +#define __HAVE_ARCH_CLEAR_GIGANTIC_PAGE
> +void __clear_page_nt(void *page, u64 page_size);

Nit: the modern way is

#ifndef __clear_page_nt
void __clear_page_nt(void *page, u64 page_size);
#define __clear_page_nt __clear_page_nt
#endif

Not sure why, really.  I guess it avoids adding two symbols and 
having to remember and maintain the relationship between them.

> --- /dev/null
> +++ b/arch/x86/lib/clear_gigantic_page.c
> @@ -0,0 +1,30 @@
> +#include <asm/page.h>
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> +#define PAGES_BETWEEN_RESCHED 64
> +void clear_gigantic_page(struct page *page,
> +				unsigned long addr,
> +				unsigned int pages_per_huge_page)
> +{
> +	int i;
> +	void *dest = page_to_virt(page);
> +	int resched_count = 0;
> +
> +	BUG_ON(pages_per_huge_page % PAGES_BETWEEN_RESCHED != 0);
> +	BUG_ON(!dest);
> +
> +	might_sleep();

cond_resched() already does might_sleep() - it doesn't seem needed here.

> +	for (i = 0; i < pages_per_huge_page; i += PAGES_BETWEEN_RESCHED) {
> +		__clear_page_nt(dest + (i * PAGE_SIZE),
> +				PAGES_BETWEEN_RESCHED * PAGE_SIZE);
> +		resched_count += cond_resched();
> +	}
> +	/* __clear_page_nt requrires and `sfence` barrier. */
> +	wmb();
> +	pr_debug("clear_gigantic_page: rescheduled %d times\n", resched_count);
> +}
> +#endif

