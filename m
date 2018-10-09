Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F613C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C1D204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C1D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJITew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:34:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36908 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbeJITew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:34:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CB887A9;
        Tue,  9 Oct 2018 05:18:11 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F22AA3F5B3;
        Tue,  9 Oct 2018 05:18:10 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 44E771AE0876; Tue,  9 Oct 2018 13:18:10 +0100 (BST)
Date:   Tue, 9 Oct 2018 13:18:10 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Lance Roy <ldr709@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 12/16] locking/mutex: Replace spin_is_locked() with
 lockdep
Message-ID: <20181009121809.GG6248@arm.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
 <20181003053902.6910-13-ldr709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003053902.6910-13-ldr709@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:38:58PM -0700, Lance Roy wrote:
> lockdep_assert_held() is better suited to checking locking requirements,
> since it won't get confused when someone else holds the lock. This is
> also a step towards possibly removing spin_is_locked().
> 
> Signed-off-by: Lance Roy <ldr709@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  kernel/locking/mutex-debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
> index 9aa713629387..771d4ca96dda 100644
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -36,7 +36,7 @@ void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
>  
>  void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
>  {
> -	SMP_DEBUG_LOCKS_WARN_ON(!spin_is_locked(&lock->wait_lock));
> +	lockdep_assert_held(&lock->wait_lock);
>  	DEBUG_LOCKS_WARN_ON(list_empty(&lock->wait_list));
>  	DEBUG_LOCKS_WARN_ON(waiter->magic != waiter);
>  	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
> @@ -51,7 +51,7 @@ void debug_mutex_free_waiter(struct mutex_waiter *waiter)
>  void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>  			    struct task_struct *task)
>  {
> -	SMP_DEBUG_LOCKS_WARN_ON(!spin_is_locked(&lock->wait_lock));
> +	lockdep_assert_held(&lock->wait_lock);

I think it's a good idea to replace debug usage of spin_is_locked() with
calls to lockdep, but I wonder whether that means that DEBUG_MUTEXES should
select LOCKDEP so that we don't lose coverage?

What do you think?

Will
