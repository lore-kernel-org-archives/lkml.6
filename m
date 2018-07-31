Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8A7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2C620857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mBq9S1Je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2C620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeGaMNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:13:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbeGaMNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EOdW7bkT/POcKKxc2PwBpR3+vv7jcE0QHd7PUCJke1s=; b=mBq9S1JeOGxj87aoQtOUL33UQ
        c437Om/BWjWaYuu2BXk+hMb4MNWQs/w2+BNlIpe8gxz1EqOOoqFqYKJJFBoRX7pZie6qZFQzSZZAd
        jg9Nb46ewFacW4fxgJw+elVdz4VoiKMuKozwQv/53TnJCXE4M8AR6oXn5gKNT5lGBTQVKOu2a1JTD
        KnZijurl4Um/dXUdF9Pqjby9YLhws0C++ZqSHqgXqrqCZbSX6qsxP4gBvD6nFaXK02RPHYa98wXdi
        rgBB2RsJO/xYoBGNl3viPmBrnX54XoHJAXaVu97szWqOo3isKudUyobdBBCfAUvlvb+W7nOGpI7ih
        f4cFRC0vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkRyg-0003a4-L0; Tue, 31 Jul 2018 10:34:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 841F02029901B; Tue, 31 Jul 2018 12:34:04 +0200 (CEST)
Date:   Tue, 31 Jul 2018 12:34:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jiada_wang@mentor.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] sched/debug: fix potential deadlock when write to
 sched_features
Message-ID: <20180731103404.GV2494@hirez.programming.kicks-ass.net>
References: <20180731092219.28908-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731092219.28908-1-jiada_wang@mentor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Leaving a lot of quoted crud for Viresh..

On Tue, Jul 31, 2018 at 06:22:19PM +0900, jiada_wang@mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> Following lockdep report can be triggered by write to
> /sys/kernel/debug/sched_features

Only if you're using this dt_cpufreq thing of course.. I wonder why this
hasn't been reported before.

> [   43.094116] ======================================================
> [   43.100345] WARNING: possible circular locking dependency detected
> [   43.106581] 4.18.0-rc6-00152-gcd3f77d74ac3-dirty #18 Not tainted
> [   43.112635] ------------------------------------------------------
> [   43.118864] sh/3358 is trying to acquire lock:
> [   43.123351] 000000004ad3989d (cpu_hotplug_lock.rw_sem){++++}, at: static_key_enable+0x14/0x30
> [   43.132008]
> [   43.132008] but task is already holding lock:
> [   43.137893] 00000000c1b31a88 (&sb->s_type->i_mutex_key#3){+.+.}, at: sched_feat_write+0x160/0x428
> [   43.146886]
> [   43.146886] which lock already depends on the new lock.
> [   43.146886]
> [   43.155136]
> [   43.155136] the existing dependency chain (in reverse order) is:
> [   43.162681]
> [   43.162681] -> #3 (&sb->s_type->i_mutex_key#3){+.+.}:
> [   43.169314]        lock_acquire+0xb8/0x148
> [   43.173462]        down_write+0xac/0x140
> [   43.177430]        start_creating+0x5c/0x168
> [   43.181743]        debugfs_create_dir+0x18/0x220
> [   43.186414]        opp_debug_register+0x8c/0x120
> [   43.191077]        _add_opp_dev+0x104/0x1f8
> [   43.195306]        dev_pm_opp_get_opp_table+0x174/0x340
> [   43.200581]        _of_add_opp_table_v2+0x110/0x760
> [   43.205508]        dev_pm_opp_of_add_table+0x5c/0x240
> [   43.210609]        dev_pm_opp_of_cpumask_add_table+0x5c/0x100
> [   43.216409]        cpufreq_init+0x160/0x430
> [   43.220634]        cpufreq_online+0x1cc/0xe30
> [   43.225033]        cpufreq_add_dev+0x78/0x198
> [   43.229439]        subsys_interface_register+0x168/0x270
> [   43.234803]        cpufreq_register_driver+0x1c8/0x278
> [   43.239990]        dt_cpufreq_probe+0xdc/0x1b8
> [   43.244482]        platform_drv_probe+0xb4/0x168
> [   43.249145]        driver_probe_device+0x318/0x4b0
> [   43.253982]        __device_attach_driver+0xfc/0x1f0
> [   43.258994]        bus_for_each_drv+0xf8/0x180
> [   43.263480]        __device_attach+0x164/0x200
> [   43.267968]        device_initial_probe+0x10/0x18
> [   43.272716]        bus_probe_device+0x110/0x178
> [   43.277298]        device_add+0x6d8/0x908
> [   43.281351]        platform_device_add+0x138/0x3d8
> [   43.286191]        platform_device_register_full+0x1cc/0x1f8
> [   43.291910]        cpufreq_dt_platdev_init+0x174/0x1bc
> [   43.297102]        do_one_initcall+0xb8/0x310
> [   43.301508]        kernel_init_freeable+0x4b8/0x56c
> [   43.306433]        kernel_init+0x10/0x138
> [   43.310485]        ret_from_fork+0x10/0x18
> [   43.314616]
> [   43.314616] -> #2 (opp_table_lock){+.+.}:
> [   43.320189]        lock_acquire+0xb8/0x148
> [   43.324329]        __mutex_lock+0x104/0xf50
> [   43.328557]        mutex_lock_nested+0x1c/0x28
> [   43.333047]        _of_add_opp_table_v2+0xb4/0x760
> [   43.337886]        dev_pm_opp_of_add_table+0x5c/0x240
> [   43.342988]        dev_pm_opp_of_cpumask_add_table+0x5c/0x100
> [   43.348786]        cpufreq_init+0x160/0x430
> [   43.353011]        cpufreq_online+0x1cc/0xe30
> [   43.357410]        cpufreq_add_dev+0x78/0x198
> [   43.361811]        subsys_interface_register+0x168/0x270
> [   43.367175]        cpufreq_register_driver+0x1c8/0x278
> [   43.372362]        dt_cpufreq_probe+0xdc/0x1b8
> [   43.376852]        platform_drv_probe+0xb4/0x168
> [   43.381515]        driver_probe_device+0x318/0x4b0
> [   43.386352]        __device_attach_driver+0xfc/0x1f0
> [   43.391363]        bus_for_each_drv+0xf8/0x180
> [   43.395850]        __device_attach+0x164/0x200
> [   43.400338]        device_initial_probe+0x10/0x18
> [   43.405088]        bus_probe_device+0x110/0x178
> [   43.409665]        device_add+0x6d8/0x908
> [   43.413718]        platform_device_add+0x138/0x3d8
> [   43.418559]        platform_device_register_full+0x1cc/0x1f8
> [   43.424270]        cpufreq_dt_platdev_init+0x174/0x1bc
> [   43.429457]        do_one_initcall+0xb8/0x310
> [   43.433857]        kernel_init_freeable+0x4b8/0x56c
> [   43.438782]        kernel_init+0x10/0x138
> [   43.442834]        ret_from_fork+0x10/0x18
> [   43.446965]
> [   43.446965] -> #1 (subsys mutex#6){+.+.}:
> [   43.452545]        lock_acquire+0xb8/0x148
> [   43.456684]        __mutex_lock+0x104/0xf50
> [   43.460911]        mutex_lock_nested+0x1c/0x28
> [   43.465400]        subsys_interface_register+0xd8/0x270
> [   43.470677]        cpufreq_register_driver+0x1c8/0x278
> [   43.475864]        dt_cpufreq_probe+0xdc/0x1b8
> [   43.480354]        platform_drv_probe+0xb4/0x168
> [   43.485017]        driver_probe_device+0x318/0x4b0
> [   43.489854]        __device_attach_driver+0xfc/0x1f0
> [   43.494865]        bus_for_each_drv+0xf8/0x180
> [   43.499352]        __device_attach+0x164/0x200
> [   43.503840]        device_initial_probe+0x10/0x18
> [   43.508589]        bus_probe_device+0x110/0x178
> [   43.513166]        device_add+0x6d8/0x908
> [   43.517218]        platform_device_add+0x138/0x3d8
> [   43.522058]        platform_device_register_full+0x1cc/0x1f8
> [   43.527768]        cpufreq_dt_platdev_init+0x174/0x1bc
> [   43.532955]        do_one_initcall+0xb8/0x310
> [   43.537356]        kernel_init_freeable+0x4b8/0x56c
> [   43.542281]        kernel_init+0x10/0x138
> [   43.546333]        ret_from_fork+0x10/0x18
> [   43.550464]
> [   43.550464] -> #0 (cpu_hotplug_lock.rw_sem){++++}:
> [   43.556822]        __lock_acquire+0x203c/0x21d0
> [   43.561397]        lock_acquire+0xb8/0x148
> [   43.565543]        cpus_read_lock+0x58/0x1c8
> [   43.569857]        static_key_enable+0x14/0x30
> [   43.574347]        sched_feat_write+0x314/0x428
> [   43.578924]        full_proxy_write+0xa0/0x138
> [   43.583415]        __vfs_write+0xd8/0x388
> [   43.587465]        vfs_write+0xdc/0x318
> [   43.591340]        ksys_write+0xb4/0x138
> [   43.595302]        sys_write+0xc/0x18
> [   43.599004]        __sys_trace_return+0x0/0x4
> [   43.603397]
> [   43.603397] other info that might help us debug this:
> [   43.603397]
> [   43.611473] Chain exists of:
> [   43.611473]   cpu_hotplug_lock.rw_sem --> opp_table_lock --> &sb->s_type->i_mutex_key#3
> [   43.611473]
> [   43.623971]  Possible unsafe locking scenario:
> [   43.623971]
> [   43.629943]        CPU0                    CPU1
> [   43.634510]        ----                    ----
> [   43.639077]   lock(&sb->s_type->i_mutex_key#3);
> [   43.643667]                                lock(opp_table_lock);
> [   43.649733]                                lock(&sb->s_type->i_mutex_key#3);
> [   43.656854]   lock(cpu_hotplug_lock.rw_sem);
> [   43.661175]
> [   43.661175]  *** DEADLOCK ***
> [   43.661175]
> [   43.667157] 2 locks held by sh/3358:
> [   43.670765]  #0: 00000000a8c4b363 (sb_writers#10){.+.+}, at: vfs_write+0x238/0x318
> [   43.678444]  #1: 00000000c1b31a88 (&sb->s_type->i_mutex_key#3){+.+.}, at: sched_feat_write+0x160/0x428
> [   43.687872]
> [   43.687872] stack backtrace:
> [   43.692284] CPU: 5 PID: 3358 Comm: sh Not tainted 4.18.0-rc6-00152-gcd3f77d74ac3-dirty #18
> [   43.700616] Hardware name: Renesas H3ULCB Kingfisher board based on r8a7795 ES2.0+ (DT)
> [   43.708684] Call trace:
> [   43.711169]  dump_backtrace+0x0/0x288
> [   43.714873]  show_stack+0x14/0x20
> [   43.718226]  dump_stack+0x13c/0x1ac
> [   43.721754]  print_circular_bug.isra.10+0x270/0x438
> [   43.726679]  check_prev_add.constprop.16+0x4dc/0xb98
> [   43.731690]  __lock_acquire+0x203c/0x21d0
> [   43.735740]  lock_acquire+0xb8/0x148
> [   43.739357]  cpus_read_lock+0x58/0x1c8
> [   43.743147]  static_key_enable+0x14/0x30
> [   43.747112]  sched_feat_write+0x314/0x428
> [   43.751163]  full_proxy_write+0xa0/0x138
> [   43.755125]  __vfs_write+0xd8/0x388
> [   43.758651]  vfs_write+0xdc/0x318
> [   43.762001]  ksys_write+0xb4/0x138
> [   43.765438]  sys_write+0xc/0x18
> [   43.768615]  __sys_trace_return+0x0/0x4
> 
> This is because load of cpufreq_dt module firstly acquires
> cpu_hotplug_lock.rw_sem lock, then in cpufreq_init, it holds
> &sb->s_type->i_mutex_key lock.
> 
> But write to /sys/kernel/debug/sched_features, cpu_hotplug_lock.rw_sem lock
> depends on &sb->s_type->i_mutex_key lock.
> 
> This patch by reversing the lock acquisition order when write to
> sched_features, this way cpu_hotplug_lock.rw_sem no longer depends on
> &sb->s_type->i_mutex_key.
> 
> Cc: George G. Davis <george_davis@mentor.com>
> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  kernel/sched/debug.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index e593b4118578..deefa9569bcf 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -87,21 +87,21 @@ struct static_key sched_feat_keys[__SCHED_FEAT_NR] = {
>  
>  #undef SCHED_FEAT
>  
> -static void sched_feat_disable(int i)
> +static void sched_feat_disable_cpuslocked(int i)
>  {
> -	static_key_disable(&sched_feat_keys[i]);
> +	static_key_disable_cpuslocked(&sched_feat_keys[i]);
>  }
>  
> -static void sched_feat_enable(int i)
> +static void sched_feat_enable_cpuslocked(int i)
>  {
> -	static_key_enable(&sched_feat_keys[i]);
> +	static_key_enable_cpuslocked(&sched_feat_keys[i]);
>  }
>  #else
> -static void sched_feat_disable(int i) { };
> -static void sched_feat_enable(int i) { };
> +static void sched_feat_disable_cpuslocked(int i) { };
> +static void sched_feat_enable_cpuslocked(int i) { };
>  #endif /* HAVE_JUMP_LABEL */
>  
> -static int sched_feat_set(char *cmp)
> +static int sched_feat_set_cpuslocked(char *cmp)
>  {
>  	int i;
>  	int neg = 0;
> @@ -115,10 +115,10 @@ static int sched_feat_set(char *cmp)
>  		if (strcmp(cmp, sched_feat_names[i]) == 0) {
>  			if (neg) {
>  				sysctl_sched_features &= ~(1UL << i);
> -				sched_feat_disable(i);
> +				sched_feat_disable_cpuslocked(i);
>  			} else {
>  				sysctl_sched_features |= (1UL << i);
> -				sched_feat_enable(i);
> +				sched_feat_enable_cpuslocked(i);
>  			}
>  			break;
>  		}
> @@ -147,9 +147,11 @@ sched_feat_write(struct file *filp, const char __user *ubuf,
>  
>  	/* Ensure the static_key remains in a consistent state */
>  	inode = file_inode(filp);
> +	cpus_read_lock();
>  	inode_lock(inode);
> -	i = sched_feat_set(cmp);
> +	i = sched_feat_set_cpuslocked(cmp);
>  	inode_unlock(inode);
> +	cpus_read_unlock();
>  	if (i == __SCHED_FEAT_NR)
>  		return -EINVAL;
>  

I don't much care for all the _cpuslocked renaming done, but otherwise I
suppose this is the easiest fix.

Note however that this doesn't apply, you're missing that match_string()
patch. Please use tip/sched/core or something.
