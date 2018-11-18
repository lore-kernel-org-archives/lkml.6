Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24604C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC5A20817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC5A20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeKSEma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:42:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36910 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeKSEma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:42:30 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gORhF-0003HB-Bj; Sun, 18 Nov 2018 19:21:25 +0100
Date:   Sun, 18 Nov 2018 19:21:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@gmx.us>
cc:     akpm@linux-foundation.org, longman@redhat.com,
        yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugobjects: add a new Kconfig for POOL_SIZE
In-Reply-To: <20181118082255.1275-1-cai@gmx.us>
Message-ID: <alpine.DEB.2.21.1811181919170.9459@nanos.tec.linutronix.de>
References: <20181118082255.1275-1-cai@gmx.us>
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

Qian,

On Sun, 18 Nov 2018, Qian Cai wrote:

> The current value of ODEBUG_POOL_SIZE is not big enough for large memory
> systems with timer or/and workqueue objects because during the early
> boot, timer objects needs at least the size equals to
> 
> No. CPUs x 2 (worker pool)
> 
> start_kernel
>   workqueue_init_early
>     init_worker_pool
>       init_timer_key
>         debug_object_init
> 
> puls, No. CPUs
> 
> start_kernel
>   sched_init
>     hrtimer_init
>      debug_object_init
> 
> Then, workqueue objects requires even more,
> 
> No. CPUs x 2 (worker pool) x 6 (workqueue)
> 
> start_kernel
>   workqueue_init_early
>     __alloc_workqueue_key
>       alloc_workqueue
>         init_pwq
>           debug_object_init
> 
> plus, No, CPUs x 2 (worker pool)
> 
> start_kernel
>   perf_event_init
>     __init_srcu_struct
>       init_srcu_struct_fields
>         __init_work
>           debug_object_init
> 
> As the results, systems have 60+ CPUs with both timer and workqueue
> objects enabled could trigger "ODEBUG: Out of memory. ODEBUG disabled".
> 
> Hence, add a new Kconfig option so users could adjust ODEBUG_POOL_SIZE
> accordingly if either timer or workqueue objects are selected.

why do we need a config option, when the required number can be deduced
already from the active CONFIG_DEBUG_OBJECTS_* and NR_CPUS?

Thanks,

	tglx
