Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C7EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9726120881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbfAaHgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:36:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfAaHgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:36:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0976E3E05;
        Thu, 31 Jan 2019 07:36:35 +0000 (UTC)
Received: from krava (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with SMTP id 326E86019F;
        Thu, 31 Jan 2019 07:36:32 +0000 (UTC)
Date:   Thu, 31 Jan 2019 08:36:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, eranian@google.com,
        vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Message-ID: <20190131073632.GB24233@krava>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130183648.GA24233@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 31 Jan 2019 07:36:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 07:36:48PM +0100, Jiri Olsa wrote:
> On Fri, Jan 25, 2019 at 12:16:27PM +0530, Ravi Bangoria wrote:
> 
> SNIP
> 
> > [ 1432.176374] general protection fault: 0000 [#1] SMP PTI         
> > [ 1432.182253] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.0.0-rc3-ravi-pfuzzer+ #1                                                                              
> > [ 1432.192088] Hardware name: IBM CPU PLANAR                                           -[8722xyz]-/00FL808, BIOS -[KOE162DUS-2.30]- 08/27/2018                          [264/488]
> > [ 1432.206120] RIP: 0010:perf_prepare_sample+0x8f/0x510                              
> > [ 1432.211679] Code: ff ff 41 f6 c4 01 0f 85 22 02 00 00 41 f6 c4 20 74 26 4d 85 e4 0f 88 0c 01 00 00 4c 89 f6 4c 89 ff e8 f5 fe ff ff 49 89 45 70 <48> 8b 00 8d 04 c5 08 00 00 0
> > 0 66 01 43 06 41 f7 c4 00 04 00 00 74                                           
> > [ 1432.232699] RSP: 0000:ffff95b3ff843a78 EFLAGS: 00010082                           
> > [ 1432.238548] RAX: 8d1217eb826cce00 RBX: ffff95b3ff843ad8 RCX: 000000000000001f
> > [ 1432.246536] RDX: 0000000000000000 RSI: 00000000355563e5 RDI: 0000000000000000
> > [ 1432.254522] RBP: ffff95b3ff843ab0 R08: ffffd016493f3b42 R09: 0000000000000000
> > [ 1432.262508] R10: ffff95b3ff843a08 R11: 0000000000000000 R12: 80000000000306e5
> > [ 1432.270495] R13: ffff95b3ff843bc0 R14: ffff95b3ff843b18 R15: ffff95b3f6b65800                                                                                                 
> > [ 1432.278483] FS:  0000000000000000(0000) GS:ffff95b3ff840000(0000) knlGS:0000000000000000
> > [ 1432.287539] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1432.293969] CR2: 000055bf7f768c90 CR3: 0000001fd220e005 CR4: 00000000000606e0
> > [ 1432.301956] Call Trace:                                                      
> > [ 1432.304697]  <IRQ>                                                                                                                                                            
> > [ 1432.306956]  ? intel_pmu_drain_bts_buffer+0x194/0x230                                                                                                                         
> > [ 1432.312615]  intel_pmu_drain_bts_buffer+0x160/0x230                                                                                                                           
> > [ 1432.318078]  ? tick_nohz_irq_exit+0x31/0x40                                                                                                                                   
> > [ 1432.322765]  ? smp_call_function_single_interrupt+0x48/0xe0
> > [ 1432.328993]  ? call_function_single_interrupt+0xf/0x20    
> > [ 1432.334745]  ? call_function_single_interrupt+0xa/0x20                                              
> > [ 1432.340501]  ? x86_schedule_events+0x1a0/0x2f0                                                                                                                                
> > [ 1432.345475]  ? x86_pmu_commit_txn+0xb4/0x100                                                                                                                                  
> > [ 1432.350258]  ? find_busiest_group+0x47/0x5d0                                                                                                                                  
> > [ 1432.355039]  ? perf_event_set_state.part.42+0x12/0x50                                                                                                                         
> > [ 1432.360694]  ? perf_mux_hrtimer_restart+0x40/0xb0                            
> > [ 1432.365960]  intel_pmu_disable_event+0xae/0x100                                                 
> > [ 1432.371031]  ? intel_pmu_disable_event+0xae/0x100                                                                                          
> > [ 1432.376297]  x86_pmu_stop+0x7a/0xb0                                          
> > [ 1432.380201]  x86_pmu_del+0x57/0x120                                                                                                                                           
> > [ 1432.384105]  event_sched_out.isra.101+0x83/0x180             
> > [ 1432.389272]  group_sched_out.part.103+0x57/0xe0                              
> > [ 1432.394343]  ctx_sched_out+0x188/0x240                                       
> > [ 1432.398539]  ctx_resched+0xa8/0xd0                                                                                    
> > [ 1432.402345]  __perf_event_enable+0x193/0x1e0                                      
> > [ 1432.407125]  event_function+0x8e/0xc0                                        
> > [ 1432.411222]  remote_function+0x41/0x50                                                                                                                                        
> > [ 1432.415418]  flush_smp_call_function_queue+0x68/0x100                                               
> > [ 1432.421071]  generic_smp_call_function_single_interrupt+0x13/0x30                                                                                                             
> > [ 1432.427893]  smp_call_function_single_interrupt+0x3e/0xe0                                                                                                                     
> > [ 1432.433936]  call_function_single_interrupt+0xf/0x20                                                                                                                          
> > [ 1432.440204]  </IRQ>                                                                                                                                                           
> 
> hi,
> I finaly managed to reproduced this one ;-)

ugh.. and fuzzer managed to reproduce it again even with the patch below :-\
there's some other way the event could become bts with callchain

jirka

> 
> also I found reproducer for crash on my server, now I'm running
> the fuzzer to see if it cures it as well.. so far so good ;-)
> 
> the crash happens when I create 'almost bts' event with:
>   event = branch-instructions:up
>   sample_period = 2
>   sample_type = CALLCHAIN
> 
> after I open the event I change the sample_period via ioctl to '1',
> which will make the event 'full bts', but no bts checks are performed
> so the bts drain crashes
> 
> the patch adds check_eriod pmu callback.. I need to check if there's
> better way to do this, but so far it fixes the crash for me
> 
> if you guys could check this patch, that'd be great
> 
> thanks,
> jirka
> 
> 
> ---
>  arch/x86/events/core.c       |  6 ++++++
>  arch/x86/events/intel/core.c |  9 +++++++++
>  arch/x86/events/perf_event.h |  2 ++
>  include/linux/perf_event.h   |  5 +++++
>  kernel/events/core.c         | 31 +++++++++++++++++++++++++++++++
>  5 files changed, 53 insertions(+)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 374a19712e20..e5db4fad517e 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2278,6 +2278,11 @@ void perf_check_microcode(void)
>  		x86_pmu.check_microcode();
>  }
>  
> +static int x86_pmu_check_period(struct perf_event *event)
> +{
> +	return x86_pmu.check_period ? x86_pmu.check_period(event) : 0;
> +}
> +
>  static struct pmu pmu = {
>  	.pmu_enable		= x86_pmu_enable,
>  	.pmu_disable		= x86_pmu_disable,
> @@ -2302,6 +2307,7 @@ static struct pmu pmu = {
>  	.event_idx		= x86_pmu_event_idx,
>  	.sched_task		= x86_pmu_sched_task,
>  	.task_ctx_size          = sizeof(struct x86_perf_task_context),
> +	.check_period		= x86_pmu_check_period,
>  };
>  
>  void arch_perf_update_userpage(struct perf_event *event,
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 40e12cfc87f6..125930e328c8 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3584,6 +3584,11 @@ static void intel_pmu_sched_task(struct perf_event_context *ctx,
>  	intel_pmu_lbr_sched_task(ctx, sched_in);
>  }
>  
> +static int intel_pmu_check_period(struct perf_event *event)
> +{
> +	return intel_pmu_has_bts(event) ? -EINVAL : 0;
> +}
> +
>  PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
>  
>  PMU_FORMAT_ATTR(ldlat, "config1:0-15");
> @@ -3663,6 +3668,8 @@ static __initconst const struct x86_pmu core_pmu = {
>  	.cpu_prepare		= intel_pmu_cpu_prepare,
>  	.cpu_starting		= intel_pmu_cpu_starting,
>  	.cpu_dying		= intel_pmu_cpu_dying,
> +
> +	.check_period		= intel_pmu_check_period,
>  };
>  
>  static struct attribute *intel_pmu_attrs[];
> @@ -3705,6 +3712,8 @@ static __initconst const struct x86_pmu intel_pmu = {
>  	.cpu_dying		= intel_pmu_cpu_dying,
>  	.guest_get_msrs		= intel_guest_get_msrs,
>  	.sched_task		= intel_pmu_sched_task,
> +
> +	.check_period		= intel_pmu_check_period,
>  };
>  
>  static __init void intel_clovertown_quirk(void)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 78d7b7031bfc..170b58d48710 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -646,6 +646,8 @@ struct x86_pmu {
>  	 * Intel host/guest support (KVM)
>  	 */
>  	struct perf_guest_switch_msr *(*guest_get_msrs)(int *nr);
> +
> +	int (*check_period) (struct perf_event *event);
>  };
>  
>  struct x86_perf_task_context {
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index a79e59fc3b7d..749a5c3110e2 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -447,6 +447,11 @@ struct pmu {
>  	 * Filter events for PMU-specific reasons.
>  	 */
>  	int (*filter_match)		(struct perf_event *event); /* optional */
> +
> +	/*
> +	 * Check period for PERF_EVENT_IOC_PERIOD ioctl.
> +	 */
> +	int (*check_period)		(struct perf_event *event); /* optional */
>  };
>  
>  enum perf_addr_filter_action_t {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 280a72b3a553..22ec63a0782e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4969,6 +4969,26 @@ static void __perf_event_period(struct perf_event *event,
>  	}
>  }
>  
> +static int check_period(struct perf_event *event, u64 value)
> +{
> +	u64 sample_period_attr = event->attr.sample_period;
> +	u64 sample_period_hw   = event->hw.sample_period;
> +	int ret;
> +
> +	if (event->attr.freq) {
> +		event->attr.sample_freq = value;
> +	} else {
> +		event->attr.sample_period = value;
> +		event->hw.sample_period = value;
> +	}
> +
> +	ret = event->pmu->check_period(event);
> +
> +	event->attr.sample_period = sample_period_attr;
> +	event->hw.sample_period   = sample_period_hw;
> +	return ret;
> +}
> +
>  static int perf_event_period(struct perf_event *event, u64 __user *arg)
>  {
>  	u64 value;
> @@ -4985,6 +5005,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
>  	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
>  		return -EINVAL;
>  
> +	if (check_period(event, value))
> +		return -EINVAL;
> +
>  	event_function_call(event, __perf_event_period, &value);
>  
>  	return 0;
> @@ -9601,6 +9624,11 @@ static int perf_pmu_nop_int(struct pmu *pmu)
>  	return 0;
>  }
>  
> +static int perf_event_nop_int(struct perf_event *event)
> +{
> +	return 0;
> +}
> +
>  static DEFINE_PER_CPU(unsigned int, nop_txn_flags);
>  
>  static void perf_pmu_start_txn(struct pmu *pmu, unsigned int flags)
> @@ -9901,6 +9929,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>  		pmu->pmu_disable = perf_pmu_nop_void;
>  	}
>  
> +	if (!pmu->check_period)
> +		pmu->check_period = perf_event_nop_int;
> +
>  	if (!pmu->event_idx)
>  		pmu->event_idx = perf_event_idx_default;
>  
> -- 
> 2.17.2
> 
