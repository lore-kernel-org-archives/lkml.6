Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeDER2P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:28:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeDER2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:28:14 -0400
Date: Thu, 5 Apr 2018 19:28:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 10/10] locking/qspinlock: Elide back-to-back RELEASE
 operations with smp_wmb()
Message-ID: <20180405172808.GG4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-11-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522947547-24081-11-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 05:59:07PM +0100, Will Deacon wrote:
> @@ -340,12 +341,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		goto release;
>  
>  	/*
> +	 * Ensure that the initialisation of @node is complete before we
> +	 * publish the updated tail and potentially link @node into the
> +	 * waitqueue.
> +	 */
> +	smp_wmb();

Maybe an explicit note to where the matching barrier lives..
