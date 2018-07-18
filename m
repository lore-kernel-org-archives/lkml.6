Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0557ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6426320850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6426320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbeGRPyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:54:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730998AbeGRPyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:54:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C045401EF07;
        Wed, 18 Jul 2018 15:15:42 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 273A9111E402;
        Wed, 18 Jul 2018 15:15:41 +0000 (UTC)
Subject: Re: [PATCH v2] locking/rwsem: Take read lock immediate if queue empty
 with no writer
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Mark Ray <mark.ray@hpe.com>,
        Joe Mario <jmario@redhat.com>,
        Scott Norton <scott.norton@hpe.com>
References: <1531506653-5244-1-git-send-email-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <cba9a488-76bd-6aa4-a9cf-2fe9f6da8e00@redhat.com>
Date:   Wed, 18 Jul 2018 11:15:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1531506653-5244-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 15:15:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 15:15:42 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 02:30 PM, Waiman Long wrote:
> It was discovered that a constant stream of readers might cause the
> count to go negative most of the time after an initial trigger by a
> writer even if no writer was present afterward. As a result, most of the
> readers would have to go through the slowpath reducing their performance.
>
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
>
> The issue was found in a customer site where they had an application
> that pounded on the pread64 syscalls heavily on an XFS filesystem. The
> application was run in a recent 4-socket boxes with a lot of CPUs. They
> saw significant spinlock contention in the rwsem_down_read_failed() call.
> With this patch applied, the system CPU usage went from 85% to 57%,
> and the spinlock contention in the pread64 syscalls was gone.
>
> v2: Add customer testing results and remove wording that may cause
>     confusion.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem-xadd.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> index 3064c50..bf0570e 100644
> --- a/kernel/locking/rwsem-xadd.c
> +++ b/kernel/locking/rwsem-xadd.c
> @@ -233,8 +233,19 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
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
>  
>  	/* we're now waiting on the lock, but no longer actively locking */

Ping!

Any comment on this one?

Cheers,
Longman

