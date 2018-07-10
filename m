Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38027C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC40420877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC40420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932949AbeGJJTy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:19:54 -0400
Received: from foss.arm.com ([217.140.101.70]:43374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751289AbeGJJTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:19:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1707B80D;
        Tue, 10 Jul 2018 02:19:53 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC2DF3F318;
        Tue, 10 Jul 2018 02:19:52 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 94DFF1AE53F1; Tue, 10 Jul 2018 10:20:34 +0100 (BST)
Date:   Tue, 10 Jul 2018 10:20:34 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] locking/lockdep: Dump state of percpu_rwsem upon hung up.
Message-ID: <20180710092034.GA29846@arm.com>
References: <1530945060-7507-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <201807071750.mmO8ZiJo%fengguang.wu@intel.com>
 <201807100610.w6A6Apv4020906@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807100610.w6A6Apv4020906@www262.sakura.ne.jp>
User-Agent: Mutt/1.5.23 (2014-03-12)
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

Hmm, how come you don't have to update kernel/locking/rwsem-spinlock.c
as well? I see stuff such as:

	sem->count += woken;

in there.

Will
