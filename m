Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0C0ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09988208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09988208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeGMKQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:16:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60972 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbeGMKQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:16:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940B2ED1;
        Fri, 13 Jul 2018 03:02:15 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 654FC3F5AD;
        Fri, 13 Jul 2018 03:02:15 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 097031AE35DD; Fri, 13 Jul 2018 11:02:58 +0100 (BST)
Date:   Fri, 13 Jul 2018 11:02:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mark Ray <mark.ray@hpe.com>, Joe Mario <jmario@redhat.com>,
        Scott Norton <scott.norton@hpe.com>
Subject: Re: [PATCH] locking/rwsem: Take read lock immediate if empty queue
 with no writer
Message-ID: <20180713100257.GE32020@arm.com>
References: <1531247490-26852-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531247490-26852-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:31:30PM -0400, Waiman Long wrote:
> It was found that a constant stream of readers might cause the count to
> go negative most of the time after an initial trigger by a writer even
> if no writer was present afterward. As a result, most of the readers
> would have to go through the slowpath reducing their performance.
> 
> To avoid that from happening, an additional check is added to detect
> the special case that the reader in the critical section is the only
> one in the wait queue and no writer is present. When that happens, it
> can just have the lock and return immediately without further action.
> Other incoming readers won't see a waiter is present and be forced
> into the slowpath.
> 
> After the list_empty() calls, the CPU should have the lock cacheline
> anyway, so an additional semaphore count check shouldn't have any
> performance impact.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem-xadd.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

This looks ok to me, but it would be nice to include some performance
figures in the commit log. Do you have any? Phrases such as "shouldn't have
any performance impact" and "probably generate better code" don't fill me
with good feelings ;)

Will

> diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> index 3064c50..ef8a5f3 100644
> --- a/kernel/locking/rwsem-xadd.c
> +++ b/kernel/locking/rwsem-xadd.c
> @@ -233,8 +233,22 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>  	waiter.type = RWSEM_WAITING_FOR_READ;
>  
>  	raw_spin_lock_irq(&sem->wait_lock);
> -	if (list_empty(&sem->wait_list))
> +	if (list_empty(&sem->wait_list)) {
> +		/*
> +		 * In the unlikely event that the task is the only one in
> +		 * the wait queue and a writer isn't present, it can have
> +		 * the lock and return immediately without going through
> +		 * the remaining slowpath code.
> +		 *
> +		 * Count won't be 0, but allowing it will probably generate
> +		 * better code.
> +		 */
> +		if (unlikely(atomic_long_read(&sem->count) >= 0)) {
> +			raw_spin_unlock_irq(&sem->wait_lock);
> +			return sem;
> +		}
>  		adjustment += RWSEM_WAITING_BIAS;
> +	}
>  	list_add_tail(&waiter.list, &sem->wait_list);
>  
>  	/* we're now waiting on the lock, but no longer actively locking */
> -- 
> 1.8.3.1
> 
