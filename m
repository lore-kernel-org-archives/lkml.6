Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ECEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BCC21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BCC21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeHTSaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:30:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbeHTSaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:30:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 855037721E;
        Mon, 20 Aug 2018 15:14:04 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27E6F2026D66;
        Mon, 20 Aug 2018 15:14:04 +0000 (UTC)
Subject: Re: [PATCH] locking: Remove an insn from spin and write locks
To:     Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180820150652.29482-1-willy@infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f24a32be-6a4f-0df8-4289-14adc1046f50@redhat.com>
Date:   Mon, 20 Aug 2018 11:14:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180820150652.29482-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 20 Aug 2018 15:14:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 20 Aug 2018 15:14:04 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 11:06 AM, Matthew Wilcox wrote:
> Both spin locks and write locks currently do:
>
>  f0 0f b1 17             lock cmpxchg %edx,(%rdi)
>  85 c0                   test   %eax,%eax
>  75 05                   jne    [slowpath]
>
> This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
> appropriately.  Peter pointed out that using atomic_try_cmpxchg()
> will let the compiler know this is true.  Comparing before/after
> disassemblies show the only effect is to remove this insn.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  include/asm-generic/qrwlock.h   | 6 +++---
>  include/asm-generic/qspinlock.h | 9 +++++----
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> index 0f7062bd55e5..9a1beb7ad0de 100644
> --- a/include/asm-generic/qrwlock.h
> +++ b/include/asm-generic/qrwlock.h
> @@ -71,8 +71,7 @@ static inline int queued_write_trylock(struct qrwlock *lock)
>  	if (unlikely(cnts))
>  		return 0;
>  
> -	return likely(atomic_cmpxchg_acquire(&lock->cnts,
> -					     cnts, cnts | _QW_LOCKED) == cnts);
> +	return likely(atomic_try_cmpxchg(&lock->cnts, &cnts, _QW_LOCKED));
>  }
>  /**
>   * queued_read_lock - acquire read lock of a queue rwlock
> @@ -96,8 +95,9 @@ static inline void queued_read_lock(struct qrwlock *lock)
>   */
>  static inline void queued_write_lock(struct qrwlock *lock)
>  {
> +	u32 cnts = 0;
>  	/* Optimize for the unfair lock case where the fair flag is 0. */
> -	if (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0)
> +	if (atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
>  		return;
>  
>  	queued_write_lock_slowpath(lock);
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
> index 95263e943fcc..d125f0c0b3d9 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -68,8 +68,10 @@ int queued_spin_is_contended(const struct qspinlock *lock)
>   */
>  static __always_inline int queued_spin_trylock(struct qspinlock *lock)
>  {
> +	u32 val = 0;
> +
>  	if (!atomic_read(&lock->val) &&
> -	   (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
> +	    (atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)))

Should you keep the _acquire suffix?

>  		return 1;
>  	return 0;
>  }
> @@ -82,10 +84,9 @@ extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>   */
>  static __always_inline void queued_spin_lock(struct qspinlock *lock)
>  {
> -	u32 val;
> +	u32 val = 0;
>  
> -	val = atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL);
> -	if (likely(val == 0))
> +	if (likely(atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)))
>  		return;
>  	queued_spin_lock_slowpath(lock, val);
>  }

Ditto.

BTW, qspinlock and qrwlock are now also used by AArch64, mips and sparc.
Have you tried to see what the effect will be for those architecture?

-Longman

