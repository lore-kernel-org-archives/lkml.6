Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7F3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E21B21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfAWJed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:34:33 -0500
Received: from foss.arm.com ([217.140.101.70]:38106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfAWJed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:34:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB60DA78;
        Wed, 23 Jan 2019 01:34:32 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA2173F5C1;
        Wed, 23 Jan 2019 01:34:29 -0800 (PST)
Date:   Wed, 23 Jan 2019 09:34:25 +0000
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
Subject: Re: [PATCH v2 1/4] locking/qspinlock: Handle > 4 slowpath nesting
 levels
Message-ID: <20190123093424.GE15019@brain-police>
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
 <1548215351-18896-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548215351-18896-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:49:08PM -0500, Waiman Long wrote:
> Four queue nodes per cpu are allocated to enable up to 4 nesting levels
> using the per-cpu nodes. Nested NMIs are possible in some architectures.
> Still it is very unlikely that we will ever hit more than 4 nested
> levels with contention in the slowpath.
> 
> When that rare condition happens, however, it is likely that the system
> will hang or crash shortly after that. It is not good and we need to
> handle this exception case.
> 
> This is done by spinning directly on the lock using repeated trylock.
> This alternative code path should only be used when there is nested
> NMIs. Assuming that the locks used by those NMI handlers will not be
> heavily contended, a simple TAS locking should work out.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 8a8c3c2..0875053 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -412,6 +412,21 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	idx = node->count++;
>  	tail = encode_tail(smp_processor_id(), idx);

Does the compiler generate better code if we move the tail assignment
further down, closer to the xchg_tail() call?

> +	/*
> +	 * 4 nodes are allocated based on the assumption that there will
> +	 * not be nested NMIs taking spinlocks. That may not be true in
> +	 * some architectures even though the chance of needing more than
> +	 * 4 nodes will still be extremely unlikely. When that happens,
> +	 * we fall back to spinning on the lock directly without using
> +	 * any MCS node. This is not the most elegant solution, but is
> +	 * simple enough.
> +	 */
> +	if (unlikely(idx >= MAX_NODES)) {
> +		while (!queued_spin_trylock(lock))
> +			cpu_relax();
> +		goto release;
> +	}

Acked-by: Will Deacon <will.deacon@arm.com>

Will
