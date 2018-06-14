Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 98211C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E33F208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E33F208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755452AbeFNULr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754806AbeFNULp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:11:45 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E716B208CB;
        Thu, 14 Jun 2018 20:11:43 +0000 (UTC)
Date:   Thu, 14 Jun 2018 16:11:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v4 4/5] sched/core: Prevent race condition between
 cpuset and __sched_setscheduler()
Message-ID: <20180614161142.69f186a6@gandalf.local.home>
In-Reply-To: <20180613121711.5018-5-juri.lelli@redhat.com>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
        <20180613121711.5018-5-juri.lelli@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 14:17:10 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> +/**
> + * cpuset_lock - Grab the cpuset_mutex from another subsysytem
> + */
> +int cpuset_lock(void)
> +{
> +	return mutex_trylock(&cpuset_mutex);
> +}
> +
> +/**
> + * cpuset_unlock - Release the cpuset_mutex from another subsysytem
> + */
> +void cpuset_unlock(void)
> +{
> +	mutex_unlock(&cpuset_mutex);
> +}
> +
>  /**
>   * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
>   * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ca788f74259d..a5b0c6c25b44 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4218,6 +4218,14 @@ static int __sched_setscheduler(struct task_struct *p,
>  		if (attr->sched_flags & SCHED_FLAG_SUGOV)
>  			return -EINVAL;
>  
> +		/*
> +		 * Make sure we don't race with the cpuset subsystem where root
> +		 * domains can be rebuilt or modified while operations like DL
> +		 * admission checks are carried out.
> +		 */
> +		if (!cpuset_lock())
> +			return -EBUSY;
> +

How important is this for being a trylock? Reason I am asking is that
it is making my deadline test fail to get the resources. What my test
does is to create a bunch of threads, and they try to get the deadline
resources as they are created. This happens in parallel. Thus, when one
gets the cpuset_lock, the others are hitting this and returning -EBUSY.
At first I thought I was over committing somehow but after adding a
trace_printk() in cpuset_lock(), and this fail case it became obvious
to what was happening:

   deadline_test-1376  [004]   107.179693: sys_enter_sched_setattr: pid: 0x00000000, uattr: 0x7f017fceeed0, flags: 0x00000000
   deadline_test-1376  [004]   107.179697: bputs:                cpuset_lock: cpuset_mutex trylock
   deadline_test-1377  [003]   107.179763: sys_exit_futex:       0x0
   deadline_test-1377  [003]   107.179767: sys_enter_sched_setattr: pid: 0x00000000, uattr: 0x7f017f4eded0, flags: 0x00000000
   deadline_test-1377  [003]   107.179771: bputs:                cpuset_lock: cpuset_mutex trylock
   deadline_test-1377  [003]   107.179771: bputs:                __sched_setscheduler: cpuset_lock
   deadline_test-1377  [003]   107.179773: sys_exit_sched_setattr: 0xfffffffffffffff0

-- Steve

>  		retval = security_task_setscheduler(p);
>  		if (retval)
>  			return retval;

