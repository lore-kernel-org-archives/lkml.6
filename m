Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74DDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DE42184D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeLRLPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:15:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55616 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeLRLPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:15:01 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gZDKZ-0007GC-F5; Tue, 18 Dec 2018 12:14:31 +0100
Date:   Tue, 18 Dec 2018 12:14:31 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zhe.he@windriver.com
Cc:     acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Message-ID: <20181218111431.7vr7rhvr5t7xb5i2@linutronix.de>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-18 18:30:33 [+0800], zhe.he@windriver.com wrote:
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3398,13 +3398,16 @@ ssize_t intel_event_sysfs_show(char *page, u64 config)
>  	return x86_event_sysfs_show(page, config, event);
>  }
>  
> -struct intel_shared_regs *allocate_shared_regs(int cpu)
> +void allocate_shared_regs(struct intel_shared_regs **pregs, int cpu)
>  {
> -	struct intel_shared_regs *regs;
> +	struct intel_shared_regs *regs = *pregs;
>  	int i;
>  
> -	regs = kzalloc_node(sizeof(struct intel_shared_regs),
> -			    GFP_KERNEL, cpu_to_node(cpu));
> +	if (regs)
> +		memset(regs, 0, sizeof(struct intel_shared_regs));
> +	else
> +		regs = *pregs = kzalloc_node(sizeof(struct intel_shared_regs),
> +					     GFP_KERNEL, cpu_to_node(cpu));
>  	if (regs) {
>  		/*
>  		 * initialize the locks to keep lockdep happy

void allocate_shared_regs(int cpu)
{
	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
        struct intel_shared_regs *regs = puc->shared_regs;
        int i;

	if (!regs)
		regs = kmalloc_node(sizeof(struct intel_shared_regs),
                            GFP_KERNEL, cpu_to_node(cpu));
        if (!regs)
		return;
	memset(regs, 0, sizeof(struct intel_shared_regs));
        for (i = 0; i < EXTRA_REG_MAX; i++)
        	raw_spin_lock_init(&regs->regs[i].lock);

        return regs;
}


> @@ -3414,20 +3417,21 @@ struct intel_shared_regs *allocate_shared_regs(int cpu)
>  
>  		regs->core_id = -1;
>  	}
> -	return regs;
>  }
>  
> -static struct intel_excl_cntrs *allocate_excl_cntrs(int cpu)
> +static void allocate_excl_cntrs(struct intel_excl_cntrs **pc, int cpu)
>  {
> -	struct intel_excl_cntrs *c;
> +	struct intel_excl_cntrs *c = *pc;
>  
> -	c = kzalloc_node(sizeof(struct intel_excl_cntrs),
> -			 GFP_KERNEL, cpu_to_node(cpu));
> +	if (c)
> +		memset(c, 0, sizeof(struct intel_excl_cntrs));
> +	else
> +		c = *pc = kzalloc_node(sizeof(struct intel_excl_cntrs),
> +				       GFP_KERNEL, cpu_to_node(cpu));
>  	if (c) {
>  		raw_spin_lock_init(&c->lock);
>  		c->core_id = -1;
>  	}
> -	return c;
>  }

static void allocate_excl_cntrs(int cpu)
{
	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
	struct intel_excl_cntrs *c = cpuc->excl_cntrs;
	
	if (!c)
		c = kmalloc_node(sizeof(struct intel_excl_cntrs),
			 GFP_KERNEL, cpu_to_node(cpu));
	if (!c)
		return;
	memset(c, 0, sizeof(struct intel_excl_cntrs));
	raw_spin_lock_init(&c->lock);
	c->core_id = -1;
	cpuc->excl_cntrs = c;
}


>  static void intel_pmu_cpu_dying(int cpu)
>  {
> -	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
> -	struct intel_shared_regs *pc;
> -
> -	pc = cpuc->shared_regs;
> -	if (pc) {
> -		if (pc->core_id == -1 || --pc->refcnt == 0)

I think ->refcnt member can go, too. It is only incremented now for no
reason now.

> -			kfree(pc);
> -		cpuc->shared_regs = NULL;
> -	}
> -
> -	free_excl_cntrs(cpu);
> -
>  	fini_debug_store_on_cpu(cpu);
>  
>  	if (x86_pmu.counter_freezing)

Sebastian
