Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAB7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699112075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HLyuriLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699112075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeGRQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:55:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbeGRQzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J5HnQtSKLybUiWvJjcnTyYv3ba/wnfxzMcayHHdab1g=; b=HLyuriLZ3jqDAwnZhiLoQIt2K
        Qe7p/HnVYXsYBf0tt99i5hf9nHk7SXHPK9NoGV2DaKU6nLJmfkT7eoZmM/3Aa30CJAAq051VsWL+V
        +2qPUPew5TnVee2TmWaiUviMeIt1UXdVn7354xiaH37921SCDCYn1h2JOTgtj9QilkyDE+87ssq1j
        fyLi7rXYe+ig1+Ft+Idpw1+sMtF0NdJZULqMGiMECYyxXPNjsI1bgcuSQqn3J/Zs+zqwx7m5DmHxZ
        reC3Rr554vI/YN1EvUbC2u7fq9GjGL3YqiJ8exe1Mvyn3Z886u/38XOHm0z6kZBLDQGld7Fvjibnr
        nx7m8PBeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffp86-0000AC-Kg; Wed, 18 Jul 2018 16:16:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDF4020289330; Wed, 18 Jul 2018 18:16:39 +0200 (CEST)
Date:   Wed, 18 Jul 2018 18:16:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Mark Ray <mark.ray@hpe.com>,
        Joe Mario <jmario@redhat.com>,
        Scott Norton <scott.norton@hpe.com>
Subject: Re: [PATCH v2] locking/rwsem: Take read lock immediate if queue
 empty with no writer
Message-ID: <20180718161639.GT2494@hirez.programming.kicks-ass.net>
References: <1531506653-5244-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531506653-5244-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 02:30:53PM -0400, Waiman Long wrote:
> It was discovered that a constant stream of readers might cause the
> count to go negative most of the time after an initial trigger by a
> writer even if no writer was present afterward. As a result, most of the
> readers would have to go through the slowpath reducing their performance.

I'm slightly confused, what happens to trigger this?

(also, I'm forever confused by the whole BIAS scheme)

> To avoid that from happening, an additional check is added to detect
> the special case that the reader in the critical section is the only
> one in the wait queue and no writer is present. When that happens, it
> can just have the lock and return immediately without further action.
> Other incoming readers won't see a waiter is present and be forced
> into the slowpath.
> 
> The additional code is in the slowpath and so should not have an impact
> on rwsem performance. However, in the special case listed above, it may
> greatly improve performance.


> diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> index 3064c50..bf0570e 100644
> --- a/kernel/locking/rwsem-xadd.c
> +++ b/kernel/locking/rwsem-xadd.c
> @@ -233,8 +233,19 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,

your diff function thingy is busted, this is in fact
__rwsem_down_read_failed_common you're patching.

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
> +		 */
> +		if (unlikely(atomic_long_read(&sem->count) >= 0)) {
> +			raw_spin_unlock_irq(&sem->wait_lock);
> +			return sem;
> +		}
>  		adjustment += RWSEM_WAITING_BIAS;
> +	}
>  	list_add_tail(&waiter.list, &sem->wait_list);

So without this, we would add ourselves to the list and then immediately
call __rwsem_mark_wake() on ourselves and fall through the wait-loop, ow
what?
