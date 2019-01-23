Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058EBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CFB20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfAWJXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:23:47 -0500
Received: from foss.arm.com ([217.140.101.70]:37922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfAWJXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:23:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF447A78;
        Wed, 23 Jan 2019 01:23:46 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E82063F5C1;
        Wed, 23 Jan 2019 01:23:43 -0800 (PST)
Date:   Wed, 23 Jan 2019 09:23:40 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        SRINIVAS <srinivas.eeda@oracle.com>
Subject: Re: [PATCH v2 2/4] locking/qspinlock_stat: Track the no MCS node
 available case
Message-ID: <20190123092339.GD15019@brain-police>
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
 <1548215351-18896-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548215351-18896-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:49:09PM -0500, Waiman Long wrote:
> Track the number of slowpath locking operations that are being done
> without any MCS node available as well renaming lock_index[123] to make
> them more descriptive.
> 
> Using these stat counters is one way to find out if a code path is
> being exercised.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock.c      |  3 ++-
>  kernel/locking/qspinlock_stat.h | 21 +++++++++++++++------
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 0875053..21ee51b 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -422,6 +422,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	 * simple enough.
>  	 */
>  	if (unlikely(idx >= MAX_NODES)) {
> +		qstat_inc(qstat_lock_no_node, true);
>  		while (!queued_spin_trylock(lock))
>  			cpu_relax();
>  		goto release;
> @@ -432,7 +433,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	/*
>  	 * Keep counts of non-zero index values:
>  	 */
> -	qstat_inc(qstat_lock_idx1 + idx - 1, idx);
> +	qstat_inc(qstat_lock_use_node2 + idx - 1, idx);
>  
>  	/*
>  	 * Ensure that we increment the head node->count before initialising
> diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
> index 42d3d8d..31728f6 100644
> --- a/kernel/locking/qspinlock_stat.h
> +++ b/kernel/locking/qspinlock_stat.h
> @@ -30,6 +30,13 @@
>   *   pv_wait_node	- # of vCPU wait's at a non-head queue node
>   *   lock_pending	- # of locking operations via pending code
>   *   lock_slowpath	- # of locking operations via MCS lock queue
> + *   lock_use_node2	- # of locking operations that use 2nd percpu node
> + *   lock_use_node3	- # of locking operations that use 3rd percpu node
> + *   lock_use_node4	- # of locking operations that use 4th percpu node
> + *   lock_no_node	- # of locking operations without using percpu node
> + *
> + * Subtraccting lock_use_node[234] from lock_slowpath will give you
> + * lock_use_node1.

Typo: "subtraccting"

Will
