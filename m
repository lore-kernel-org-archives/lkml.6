Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CCEC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3848F204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="feKXciKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3848F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeILVAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:00:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45620 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeILVAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=klwCCBL9B27IDSd7LFfhTFlf3iCGOFloIZx2/YJV4v8=; b=feKXciKDIWjlnctwqx5ZCTGcm
        22Wtq2zeqWF58maedutNDLtkmHamobUvfbgnWYbmr7ULoIsIl5a/h25wokJ76JIIYrzCUlKKue1bV
        T1gelbDSVXYh1Wm0uU0wMyDpaAN3WHQKBaf1ZNvuZCc+XQtKQ+a0N14krShMExD6Q4wIkzL59c7bk
        RZFsv7qI1d0fsNVNRYy7H7bpxvXucUp+RbdIAN6MNRF2qQLA1kp1P3BZUUadG8cEMZvErxR2W+8/a
        0R4Hk/VoTVHWzvgJalB2eORkBckAj3eAOW5wOeUPFWUVl989EB5c8uBoPbYVBZvzLKVeVZkyT9uvE
        MqPa9M/YQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g07U4-0003bm-RT; Wed, 12 Sep 2018 15:55:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D77E202C1A2D; Wed, 12 Sep 2018 17:55:14 +0200 (CEST)
Date:   Wed, 12 Sep 2018 17:55:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org,
        andrea.parri@amarulasolutions.com, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V3 11/27] csky: Atomic operations
Message-ID: <20180912155514.GV24082@hirez.programming.kicks-ass.net>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536757532.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536757532.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:24:45PM +0800, Guo Ren wrote:

> +#define ATOMIC_OP(op, c_op)						\
> +static inline void atomic_##op(int i, atomic_t *v)			\
> +{									\
> +	unsigned long tmp;						\
> +									\
> +	smp_mb();							\
> +	asm volatile (							\
> +	"1:	ldex.w		%0, (%2) \n"				\
> +	"	" #op "		%0, %1   \n"				\
> +	"	stex.w		%0, (%2) \n"				\
> +	"	bez		%0, 1b   \n"				\
> +		: "=&r" (tmp)						\
> +		: "r" (i), "r"(&v->counter)				\
> +		: "memory");						\
> +	smp_mb();							\
> +}

ATOMIC_OP doesn't need to imply any smp_mb()'s what so ever.

> +#define ATOMIC_OP_RETURN(op, c_op)					\
> +static inline int atomic_##op##_return(int i, atomic_t *v)		\
> +{									\
> +	unsigned long tmp, ret;						\
> +									\
> +	smp_mb();							\
> +	asm volatile (							\
> +	"1:	ldex.w		%0, (%3) \n"				\
> +	"	" #op "		%0, %2   \n"				\
> +	"	mov		%1, %0   \n"				\
> +	"	stex.w		%0, (%3) \n"				\
> +	"	bez		%0, 1b   \n"				\
> +		: "=&r" (tmp), "=&r" (ret)				\
> +		: "r" (i), "r"(&v->counter)				\
> +		: "memory");						\
> +	smp_mb();							\
> +									\
> +	return ret;							\
> +}
> +
> +#define ATOMIC_FETCH_OP(op, c_op)					\
> +static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> +{									\
> +	unsigned long tmp, ret;						\
> +									\
> +	smp_mb();							\
> +	asm volatile (							\
> +	"1:	ldex.w		%0, (%3) \n"				\
> +	"	mov		%1, %0   \n"				\
> +	"	" #op "		%0, %2   \n"				\
> +	"	stex.w		%0, (%3) \n"				\
> +	"	bez		%0, 1b   \n"				\
> +		: "=&r" (tmp), "=&r" (ret)				\
> +		: "r" (i), "r"(&v->counter)				\
> +		: "memory");						\
> +	smp_mb();							\
> +									\
> +	return ret;							\
> +}

For these you could generate _relaxed variants and not provide smp_mb()
inside them.

> +#else /* CONFIG_CPU_HAS_LDSTEX */
> +
> +#include <linux/irqflags.h>
> +

> +#define ATOMIC_OP(op, c_op)						\
> +static inline void atomic_##op(int i, atomic_t *v)			\
> +{									\
> +	unsigned long tmp, flags;					\
> +									\
> +	raw_local_irq_save(flags);					\
> +									\
> +	asm volatile (							\
> +	"	ldw		%0, (%2) \n"				\
> +	"	" #op "		%0, %1   \n"				\
> +	"	stw		%0, (%2) \n"				\
> +		: "=&r" (tmp)						\
> +		: "r" (i), "r"(&v->counter)				\
> +		: "memory");						\
> +									\
> +	raw_local_irq_restore(flags);					\
> +}

Is this really 'better' than the generic UP fallback implementation?





> diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
> new file mode 100644
> index 0000000..f1081bb
> --- /dev/null
> +++ b/arch/csky/include/asm/spinlock.h
> @@ -0,0 +1,286 @@
> +#ifndef __ASM_CSKY_SPINLOCK_H
> +#define __ASM_CSKY_SPINLOCK_H
> +
> +#include <linux/spinlock_types.h>
> +#include <asm/barrier.h>
> +
> +#ifdef CONFIG_QUEUED_RWLOCKS
> +
> +/*
> + * Ticket-based spin-locking.
> + */
> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	arch_spinlock_t lockval;
> +	u32 ticket_next = 1 << TICKET_NEXT;
> +	u32 *p = &lock->lock;
> +	u32 tmp;
> +
> +	smp_mb();

spin_lock() doesn't need smp_mb() before.

> +	asm volatile (
> +		"1:	ldex.w		%0, (%2) \n"
> +		"	mov		%1, %0	 \n"
> +		"	add		%0, %3	 \n"
> +		"	stex.w		%0, (%2) \n"
> +		"	bez		%0, 1b   \n"
> +		: "=&r" (tmp), "=&r" (lockval)
> +		: "r"(p), "r"(ticket_next)
> +		: "cc");
> +
> +	while (lockval.tickets.next != lockval.tickets.owner) {
> +		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
> +	}
> +
> +	smp_mb();
> +}
> +
> +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	u32 tmp, contended, res;
> +	u32 ticket_next = 1 << TICKET_NEXT;
> +	u32 *p = &lock->lock;
> +
> +	smp_mb();

idem.

> +	do {
> +		asm volatile (
> +		"	ldex.w		%0, (%3)   \n"
> +		"	movi		%2, 1	   \n"
> +		"	rotli		%1, %0, 16 \n"
> +		"	cmpne		%1, %0     \n"
> +		"	bt		1f         \n"
> +		"	movi		%2, 0	   \n"
> +		"	add		%0, %0, %4 \n"
> +		"	stex.w		%0, (%3)   \n"
> +		"1:				   \n"
> +		: "=&r" (res), "=&r" (tmp), "=&r" (contended)
> +		: "r"(p), "r"(ticket_next)
> +		: "cc");
> +	} while (!res);
> +
> +	if (!contended)
> +		smp_mb();
> +
> +	return !contended;
> +}
> +
> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	smp_mb();
> +	lock->tickets.owner++;
> +	smp_mb();

spin_unlock() doesn't need smp_mb() after.

> +}
> +
> +static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> +{
> +	return lock.tickets.owner == lock.tickets.next;
> +}
> +
> +static inline int arch_spin_is_locked(arch_spinlock_t *lock)
> +{
> +	return !arch_spin_value_unlocked(READ_ONCE(*lock));
> +}
> +
> +static inline int arch_spin_is_contended(arch_spinlock_t *lock)
> +{
> +	struct __raw_tickets tickets = READ_ONCE(lock->tickets);
> +	return (tickets.next - tickets.owner) > 1;
> +}
> +#define arch_spin_is_contended	arch_spin_is_contended
> +
> +#include <asm/qrwlock.h>
> +
> +/* See include/linux/spinlock.h */
> +#define smp_mb__after_spinlock()	smp_mb()
> +
> +#else /* CONFIG_QUEUED_RWLOCKS */
> +
> +/*
> + * Test-and-set spin-locking.
> + */

Why retain that?

same comments; it has far too many smp_mb()s in.

> +#endif /* CONFIG_QUEUED_RWLOCKS */
> +#endif /* __ASM_CSKY_SPINLOCK_H */
> diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
> new file mode 100644
> index 0000000..7e825c2
> --- /dev/null
> +++ b/arch/csky/include/asm/spinlock_types.h
> @@ -0,0 +1,35 @@
> +#ifndef __ASM_CSKY_SPINLOCK_TYPES_H
> +#define __ASM_CSKY_SPINLOCK_TYPES_H
> +
> +#ifndef __LINUX_SPINLOCK_TYPES_H
> +# error "please don't include this file directly"
> +#endif
> +
> +#define TICKET_NEXT	16
> +
> +typedef struct {
> +	union {
> +		u32 lock;
> +		struct __raw_tickets {
> +			/* little endian */
> +			u16 owner;
> +			u16 next;
> +		} tickets;
> +	};
> +} arch_spinlock_t;
> +
> +#define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
> +
> +#ifdef CONFIG_QUEUED_RWLOCKS
> +#include <asm-generic/qrwlock_types.h>
> +
> +#else /* CONFIG_NR_CPUS > 2 */
> +
> +typedef struct {
> +	u32 lock;
> +} arch_rwlock_t;
> +
> +#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
> +
> +#endif /* CONFIG_QUEUED_RWLOCKS */
> +#endif /* __ASM_CSKY_SPINLOCK_TYPES_H */
