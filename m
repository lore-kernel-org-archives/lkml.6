Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD95DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E46208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tth4oRjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E46208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeGJJbB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:31:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933216AbeGJJa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k4Z1NMFWgaypliVfwqg9RgTi8T+W5UPeoyIsvH6Kssg=; b=Tth4oRjjxcRTMa0AeP/rE1xn8
        d2QdSeujp6LKm4zDh5dMoDCNSGKGDeGYL1ixudVy734S01qE/xkon2JnRlTAV74G6IwN11LB8cb3M
        0RBtRk7FoE/F92o84Wf7QWdeIFk18yeLCR+j90wFhaXCz0GSn04gfFDUG6iDT8g4bFT+3RY7yxFWh
        EBtbkMdrGqnPNcGfpEzz4U/2rK/ydIAqMwRmegREmQmoR9x/kQC7On/nJXOklCTJwP47wKfzclJ0M
        soQuLhknMMjvFDTE61oOig6gUTjMP6QVp9nZCXDuIStHghi9Iw8mAbyk9HOH9uGNkglDb08Mwa86h
        yIPhqYsaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcoyt-0003Sc-MT; Tue, 10 Jul 2018 09:30:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B79D203E575C; Tue, 10 Jul 2018 11:30:46 +0200 (CEST)
Date:   Tue, 10 Jul 2018 11:30:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/lockdep: Dump state of percpu_rwsem upon hung up.
Message-ID: <20180710093046.GE2476@hirez.programming.kicks-ass.net>
References: <1530945060-7507-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <201807071750.mmO8ZiJo%fengguang.wu@intel.com>
 <201807100610.w6A6Apv4020906@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807100610.w6A6Apv4020906@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 03:10:51PM +0900, Tetsuo Handa wrote:
> From 2642b4a1904259384f2018ea8df03ac49509c57a Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
> Date: Tue, 10 Jul 2018 15:01:20 +0900
> Subject: [PATCH] locking/rwsem: Convert the other sem->count to 'atomic_long_t'
> 
> Since "locking/rwsem: Convert sem->count to 'atomic_long_t'" forgot to
> convert "struct rw_semaphore"->count in linux/rwsem-spinlock.h which is
> used when CONFIG_RWSEM_GENERIC_SPINLOCK=y, trying to access it in MIPS
> architecture causes build error due to type mismatch.
> 
>   error: passing argument 1 of 'atomic_long_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   note: expected 'const atomic_long_t * {aka const struct <anonymous> *}' but argument is of type '__s32 * {aka int *}'
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 8ee62b1870be8e63 ("locking/rwsem: Convert sem->count to 'atomic_long_t'")
> Cc: stable <stable@vger.kernel.org> # v4.8+
> Cc: Jason Low <jason.low2@hpe.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  include/linux/rwsem-spinlock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rwsem-spinlock.h b/include/linux/rwsem-spinlock.h
> index e475683..1164965 100644
> --- a/include/linux/rwsem-spinlock.h
> +++ b/include/linux/rwsem-spinlock.h
> @@ -22,7 +22,7 @@
>   * - if wait_list is not empty, then there are processes waiting for the semaphore
>   */
>  struct rw_semaphore {
> -	__s32			count;
> +	atomic_long_t		count;

Uhhh... how does this even build? rwsem-spinlock.c doesn't use
atomic_long primitives to change count.

And the atomic_long count usage is completely private to rwsem-xadd.c,
nothing outside of that should use that field, ever.
