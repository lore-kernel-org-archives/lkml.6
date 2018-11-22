Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECA3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4C920659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4C920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407748AbeKWIiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:38:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49108 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKWIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:38:13 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPwxs-0005Wq-0h; Thu, 22 Nov 2018 22:56:48 +0100
Date:   Thu, 22 Nov 2018 22:56:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@gmx.us>
cc:     akpm@linux-foundation.org, longman@redhat.com,
        yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] debugobjects: scale the static pool size
In-Reply-To: <20181121021157.3061-1-cai@gmx.us>
Message-ID: <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de>
References: <20181120232810.2503-1-cai@gmx.us> <20181121021157.3061-1-cai@gmx.us>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Qian Cai wrote:

Looking deeper at that.

> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 70935ed91125..140571aa483c 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -23,9 +23,81 @@
>  #define ODEBUG_HASH_BITS	14
>  #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
>  
> -#define ODEBUG_POOL_SIZE	1024
> +#define ODEBUG_DEFAULT_POOL	512
>  #define ODEBUG_POOL_MIN_LEVEL	256
>  
> +/*
> + * Some debug objects are allocated during the early boot. Enabling some options
> + * like timers or workqueue objects may increase the size required significantly
> + * with large number of CPUs. For example (as today, 20 Nov. 2018),
> + *
> + * No. CPUs x 2 (worker pool) objects:
> + *
> + * start_kernel
> + *   workqueue_init_early
> + *     init_worker_pool
> + *       init_timer_key
> + *         debug_object_init
> + *
> + * No. CPUs objects (CONFIG_HIGH_RES_TIMERS):
> + *
> + * sched_init
> + *   hrtick_rq_init
> + *     hrtimer_init
> + *
> + * CONFIG_DEBUG_OBJECTS_WORK:
> + * No. CPUs x 6 (workqueue) objects:
> + *
> + * workqueue_init_early
> + *   alloc_workqueue
> + *     __alloc_workqueue_key
> + *       alloc_and_link_pwqs
> + *         init_pwq
> + *
> + * Also, plus No. CPUs objects:
> + *
> + * perf_event_init
> + *    __init_srcu_struct
> + *      init_srcu_struct_fields
> + *        init_srcu_struct_nodes
> + *          __init_work

None of the things are actually used or required _BEFORE_
debug_objects_mem_init() is invoked.

The reason why the call is at this place in start_kernel() is
historical. It's because back in the days when debugobjects were added the
memory allocator was enabled way later than today. So we can just move the
debug_objects_mem_init() call right before sched_init() I think.

> + * Increase the number a bit more in case the implmentatins are changed in the
> + * future, as it is better to avoid OOM than spending a bit more kernel memory
> + * that will/can be freed.
> + *
> + * With all debug objects config options selected except the workqueue and the
> + * timers, kernel reports,
> + * 64-CPU:  ODEBUG: 4 of 4 active objects replaced
> + * 256-CPU: ODEBUG: 4 of 4 active objects replaced
> + *
> + * all the options except the workqueue:
> + * 64-CPU:  ODEBUG: 466 of 466 active objects replaced
> + * 256-CPU: ODEBUG: 1810 of 1810 active objects replaced
> + *
> + * all the options except the timers:
> + * 64-CPU:  ODEBUG: 652 of 652 active objects replaced
> + * 256-CPU: ODEBUG: 2572 of 2572 active objects replaced
> + *
> + * all the options:
> + * 64-CPU:  ODEBUG: 1114 of 1114 active objects replaced
> + * 256-CPU: ODEBUG: 4378 of 4378 active objects replaced
> + */
> +#ifdef CONFIG_DEBUG_OBJECTS_WORK
> +#define ODEBUG_WORK_PCPU_CNT	10
> +#else
> +#define ODEBUG_WORK_PCPU_CNT	0
> +#endif /* CONFIG_DEBUG_OBJECTS_WORK */
> +
> +#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
> +#define ODEBUG_TIMERS_PCPU_CNT	10
> +#else
> +#define ODEBUG_TIMERS_PCPU_CNT	0
> +#endif /* CONFIG_DEBUG_OBJECTS_TIMERS */

Btw, the scaling here is way off.

> +#define ODEBUG_POOL_SIZE	(ODEBUG_DEFAULT_POOL + CONFIG_NR_CPUS * \
> +				(ODEBUG_TIMERS_PCPU_CNT + ODEBUG_WORK_PCPU_CNT))

CONFIG_NR_CPUS	Pool size		Storage size

256		256512			4M
		
According to your list above it uses 4378 object for 256 CPUs. That's off
by an factor of ~58.

But we can spare all that and just move the init call.

Thanks,

	tglx

