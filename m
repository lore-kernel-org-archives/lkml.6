Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08060C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B272084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfBUQRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:17:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfBUQRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:17:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B5C20836;
        Thu, 21 Feb 2019 16:17:13 +0000 (UTC)
Date:   Thu, 21 Feb 2019 11:17:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, xdp-newbies@vger.kernel.org,
        Yonghong Song <yhs@fb.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RFC 3/5] sched/cpufreq: Fix incorrect RCU API usage
Message-ID: <20190221111712.72ba57e8@gandalf.local.home>
In-Reply-To: <20190221054942.132388-4-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
        <20190221054942.132388-4-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 00:49:40 -0500
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> Recently I added an RCU annotation check to rcu_assign_pointer(). All
> pointers assigned to RCU protected data are to be annotated with __rcu
> inorder to be able to use rcu_assign_pointer() similar to checks in
> other RCU APIs.
> 
> This resulted in a sparse error: kernel//sched/cpufreq.c:41:9: sparse:
> error: incompatible types in comparison expression (different address
> spaces)
> 
> Fix this by using the correct APIs for RCU accesses. This will
> potentially avoid any future bugs in the code. If it is felt that RCU
> protection is not needed here, then the rcu_assign_pointer call can be
> dropped and replaced with, say, WRITE_ONCE or smp_store_release. Or, may
> be we add a new API to do it. But calls rcu_assign_pointer seems an
> abuse of the RCU API unless RCU is being used.

This all looks broken, and this patch is papering over the issue, or
worse, hiding it.

> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/cpufreq.c | 8 ++++++--
>  kernel/sched/sched.h   | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> index 22bd8980f32f..c9aeb3bf5dc2 100644
> --- a/kernel/sched/cpufreq.c
> +++ b/kernel/sched/cpufreq.c
> @@ -7,7 +7,7 @@
>   */
>  #include "sched.h"
>  
> -DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
> +DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
>  
>  /**
>   * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
> @@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
>  	if (WARN_ON(!data || !func))
>  		return;
>  
> -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> +	rcu_read_lock();
> +	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
> +		rcu_read_unlock();
>  		return;
> +	}
> +	rcu_read_unlock();
>  
>  	data->func = func;
>  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);

An rcu_assign_pointer() is to update something that is going to be read
under rcu_read_lock() elsewhere. But updates to an rcu variable are not
protected by rcu_read_lock() (hence the "read" in the name). Adding
rcu_read_lock() above does nothing, but perhaps hides an issue.

Writes usually have something else that protects against races. Thus,
the above shouldn't be switched to using a rcu_dereference(), but
perhaps a rcu_dereference_protected(), with whatever is protecting
updates?

Which doing a bit of investigating, looks to be the rwsem
"policy->rwsem", where policy comes from:

	policy = cpufreq_cpu_get(cpu);

I would say the code as is, is not broken. But this patch isn't helping
anything.

-- Steve


> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d04530bf251f..2ab545d40381 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2166,7 +2166,7 @@ static inline u64 irq_time_read(int cpu)
>  #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
>  
>  #ifdef CONFIG_CPU_FREQ
> -DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
> +DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
>  
>  /**
>   * cpufreq_update_util - Take a note about CPU utilization changes.

