Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A04ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F1B2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F1B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeGPNGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:06:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51746 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbeGPNGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:06:37 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ff2mc-00055m-KB; Mon, 16 Jul 2018 14:39:18 +0200
Date:   Mon, 16 Jul 2018 14:39:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/6] userns: Use refcount_t for reference counting
 instead atomic_t
Message-ID: <20180716123918.g7kkm5nivtk7ldlt@linutronix.de>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
 <20180703200141.28415-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703200141.28415-6-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 22:01:40 [+0200], To linux-kernel@vger.kernel.org wrote:
> refcount_t type and corresponding API should be used instead of atomic_t when
> the variable is used as a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free situations.

Ingo, Andrew: who of you two feels most comfortable to apply this one
(and 6/6 of this series, both `userns')? If none, who would you suggest?

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/sched/user.h | 5 +++--
>  kernel/user.c              | 8 ++++----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
> index 96fe289c4c6e..39ad98c09c58 100644
> --- a/include/linux/sched/user.h
> +++ b/include/linux/sched/user.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/uidgid.h>
>  #include <linux/atomic.h>
> +#include <linux/refcount.h>
>  #include <linux/ratelimit.h>
>  
>  struct key;
> @@ -12,7 +13,7 @@ struct key;
>   * Some day this will be a full-fledged user tracking system..
>   */
>  struct user_struct {
> -	atomic_t __count;	/* reference count */
> +	refcount_t __count;	/* reference count */
>  	atomic_t processes;	/* How many processes does this user have? */
>  	atomic_t sigpending;	/* How many pending signals does this user have? */
>  #ifdef CONFIG_FANOTIFY
> @@ -59,7 +60,7 @@ extern struct user_struct root_user;
>  extern struct user_struct * alloc_uid(kuid_t);
>  static inline struct user_struct *get_uid(struct user_struct *u)
>  {
> -	atomic_inc(&u->__count);
> +	refcount_inc(&u->__count);
>  	return u;
>  }
>  extern void free_uid(struct user_struct *);
> diff --git a/kernel/user.c b/kernel/user.c
> index 36288d840675..5f65ef195259 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -96,7 +96,7 @@ static DEFINE_SPINLOCK(uidhash_lock);
>  
>  /* root_user.__count is 1, for init task cred */
>  struct user_struct root_user = {
> -	.__count	= ATOMIC_INIT(1),
> +	.__count	= REFCOUNT_INIT(1),
>  	.processes	= ATOMIC_INIT(1),
>  	.sigpending	= ATOMIC_INIT(0),
>  	.locked_shm     = 0,
> @@ -123,7 +123,7 @@ static struct user_struct *uid_hash_find(kuid_t uid, struct hlist_head *hashent)
>  
>  	hlist_for_each_entry(user, hashent, uidhash_node) {
>  		if (uid_eq(user->uid, uid)) {
> -			atomic_inc(&user->__count);
> +			refcount_inc(&user->__count);
>  			return user;
>  		}
>  	}
> @@ -170,7 +170,7 @@ void free_uid(struct user_struct *up)
>  		return;
>  
>  	local_irq_save(flags);
> -	if (atomic_dec_and_lock(&up->__count, &uidhash_lock))
> +	if (refcount_dec_and_lock(&up->__count, &uidhash_lock))
>  		free_user(up, flags);
>  	else
>  		local_irq_restore(flags);
> @@ -191,7 +191,7 @@ struct user_struct *alloc_uid(kuid_t uid)
>  			goto out_unlock;
>  
>  		new->uid = uid;
> -		atomic_set(&new->__count, 1);
> +		refcount_set(&new->__count, 1);
>  		ratelimit_state_init(&new->ratelimit, HZ, 100);
>  		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
>  
> -- 
> 2.18.0

Sebastian
