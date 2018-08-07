Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B03C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FB52170F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FB52170F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeHHIMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:12:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeHHIMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:12:53 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 497A2C057F84;
        Wed,  8 Aug 2018 05:54:52 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-75.phx2.redhat.com [10.3.116.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8708F308BDA4;
        Wed,  8 Aug 2018 05:54:44 +0000 (UTC)
Subject: Re: [PATCH v3] locking/rwsem: Exit read lock slowpath if queue empty
 & no writer
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <1532459425-19204-1-git-send-email-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <55866c24-ff40-22cb-1390-6c9055bd2cb7@redhat.com>
Date:   Tue, 7 Aug 2018 19:29:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1532459425-19204-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 08 Aug 2018 05:54:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 03:10 PM, Waiman Long wrote:
> It was discovered that a constant stream of readers with occassional
> writers pounding on a rwsem may cause many of the readers to enter the
> slowpath unnecessarily thus increasing latency and lowering performance.
>
> In the current code, a reader entering the slowpath critical section
> will unconditionally set the WAITING_BIAS, if not set yet, and clear
> its active count even if no one is in the wait queue and no writer
> is present. This causes some incoming readers to observe the presence
> of waiters in the wait queue and hence have to go into the slowpath
> themselves.
>
> With sufficient numbers of readers and a relatively short lock hold time,
> the WAITING_BIAS may be repeatedly turned on and off and a substantial
> portion of the readers will go into the slowpath sustaining a rather
> long queue in the wait queue spinlock and repeated WAITING_BIAS on/off
> cycle until the logjam is broken opportunistically.
>
> To avoid this situation from happening, an additional check is added to
> detect the special case that the reader in the critical section is the
> only one in the wait queue and no writer is present. When that happens,
> it can just exit the slowpath and return immediately as its active count
> has already been set in the lock.  Other incoming readers won't observe
> the presence of waiters and so will not be forced into the slowpath.
>
> The issue was found in a customer site where they had an application
> that pounded on the pread64 syscalls heavily on an XFS filesystem. The
> application was run in a recent 4-socket boxes with a lot of CPUs. They
> saw significant spinlock contention in the rwsem_down_read_failed() call.
> With this patch applied, the system CPU usage went down from 85% to 57%,
> and the spinlock contention in the pread64 syscalls was gone.
>
> v3: Revise the commit log and comment again.
> v2: Add customer testing results and remove wording that may cause
>     confusion.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem-xadd.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> index 3064c50..01fcb80 100644
> --- a/kernel/locking/rwsem-xadd.c
> +++ b/kernel/locking/rwsem-xadd.c
> @@ -233,8 +233,19 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>  	waiter.type = RWSEM_WAITING_FOR_READ;
>  
>  	raw_spin_lock_irq(&sem->wait_lock);
> -	if (list_empty(&sem->wait_list))
> +	if (list_empty(&sem->wait_list)) {
> +		/*
> +		 * In case the wait queue is empty and the lock isn't owned
> +		 * by a writer, this reader can exit the slowpath and return
> +		 * immediately as its RWSEM_ACTIVE_READ_BIAS has already
> +		 * been set in the count.
> +		 */
> +		if (atomic_long_read(&sem->count) >= 0) {
> +			raw_spin_unlock_irq(&sem->wait_lock);
> +			return sem;
> +		}
>  		adjustment += RWSEM_WAITING_BIAS;
> +	}
>  	list_add_tail(&waiter.list, &sem->wait_list);
>  
>  	/* we're now waiting on the lock, but no longer actively locking */

Will this patch be eligible to go into 4.19 or 4.20?

Thanks,
Longman

