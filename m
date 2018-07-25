Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F436C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA7420843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA7420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGYWaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:30:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731248AbeGYWaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:30:15 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 461A4DC5;
        Wed, 25 Jul 2018 21:16:44 +0000 (UTC)
Date:   Wed, 25 Jul 2018 14:16:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaowuyun@wingtech.com" <zhaowuyun@wingtech.com>
Cc:     mgorman <mgorman@techsingularity.net>,
        minchan <minchan@kernel.org>, vinmenon <vinmenon@codeaurora.org>,
        mhocko <mhocko@suse.com>, hannes <hannes@cmpxchg.org>,
        "hillf.zj" <hillf.zj@alibaba-inc.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] [PATCH] mm: disable preemption before swapcache_free
Message-Id: <20180725141643.6d9ba86a9698bc2580836618@linux-foundation.org>
In-Reply-To: <2018072514375722198958@wingtech.com>
References: <2018072514375722198958@wingtech.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 14:37:58 +0800 "zhaowuyun@wingtech.com" <zhaowuyun@wingtech.com> wrote:

> From: zhaowuyun <zhaowuyun@wingtech.com>
>  
> issue is that there are two processes A and B, A is kworker/u16:8
> normal priority, B is AudioTrack, RT priority, they are on the
> same CPU 3.
>  
> The task A preempted by task B in the moment
> after __delete_from_swap_cache(page) and before swapcache_free(swap).
>  
> The task B does __read_swap_cache_async in the do {} while loop, it
> will never find the page from swapper_space because the page is removed
> by the task A, and it will never sucessfully in swapcache_prepare because
> the entry is EEXIST.
>  
> The task B then stuck in the loop infinitely because it is a RT task,
> no one can preempt it.
>  
> so need to disable preemption until the swapcache_free executed.

Yes, right, sorry, I must have merged cbab0e4eec299 in my sleep. 
cond_resched() is a no-op in the presence of realtime policy threads
and using to attempt to yield to a different thread it in this fashion
is broken.

Disabling preemption on the other side of the race should fix things,
but it's using a bandaid to plug the leakage from the earlier bandaid. 
The proper way to coordinate threads is to use a sleeping lock, such
as a mutex, or some other wait/wakeup mechanism.

And once that's done, we can hopefully eliminate the do loop from
__read_swap_cache_async().  That also services ENOMEM from
radix_tree_insert(), but __add_to_swap_cache() appears to handle that
OK and we shouldn't just loop around retrying the insert and the
radix_tree_preload() should ensure that radix_tree_insert() never fails
anyway.  Unless we're calling __read_swap_cache_async() with screwy
gfp_flags from somewhere.


