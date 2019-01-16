Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62006C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378E5205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394276AbfAPQrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:47:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52812 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394251AbfAPQrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:47:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65931A78;
        Wed, 16 Jan 2019 08:47:31 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E5853F5AF;
        Wed, 16 Jan 2019 08:47:29 -0800 (PST)
Date:   Wed, 16 Jan 2019 16:47:26 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        SRINIVAS <srinivas.eeda@oracle.com>
Subject: Re: [PATCH] locking/qspinlock: Add bug check for exceeding MAX_NODES
Message-ID: <20190116164725.GC1910@brain-police>
References: <1547589344-11504-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547589344-11504-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 04:55:44PM -0500, Waiman Long wrote:
> On some architectures, it is possible to have nested NMIs taking
> spinlocks nestedly. Even though the chance of having more than 4 nested
> spinlocks with contention is extremely small, there could still be a
> possibility that it may happen some days leading to system panic.
> 
> What we don't want is a silent corruption with system panic somewhere
> else. So add a BUG_ON() check to make sure that a system panic caused
> by this will show the correct root cause.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 8a8c3c2..f823221 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -412,6 +412,16 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	idx = node->count++;
>  	tail = encode_tail(smp_processor_id(), idx);
>  
> +	/*
> +	 * 4 nodes are allocated based on the assumption that there will
> +	 * not be nested NMIs taking spinlocks. That may not be true in
> +	 * some architectures even though the chance of needing more than
> +	 * 4 nodes will still be extremely unlikely. Adding a bug check
> +	 * here to make sure there won't be a silent corruption in case
> +	 * this condition happens.
> +	 */
> +	BUG_ON(idx >= MAX_NODES);
> +

Hmm, I really don't like the idea of putting a BUG_ON() on the spin_lock()
path. I'd prefer it if (a) we didn't add extra conditional code for the
common case and (b) didn't bring down the machine. Could we emit a
lockdep-style splat, instead?

Will
