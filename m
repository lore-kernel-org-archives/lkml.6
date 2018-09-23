Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09B8C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE2B20989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE2B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbeIWWYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 18:24:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbeIWWYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 18:24:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B96D08830E;
        Sun, 23 Sep 2018 16:26:32 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id E0245271AF;
        Sun, 23 Sep 2018 16:26:30 +0000 (UTC)
Date:   Sun, 23 Sep 2018 18:26:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf/x86/intel: Export mem events only if there's PEBs
 support
Message-ID: <20180923162630.GA30923@krava>
References: <20180813154820.16991-1-jolsa@kernel.org>
 <20180827090624.GI24695@krava>
 <20180828081232.GI24124@hirez.programming.kicks-ass.net>
 <20180828081911.GC23727@krava>
 <20180906135748.GC9577@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906135748.GC9577@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 23 Sep 2018 16:26:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:57:48PM +0200, Jiri Olsa wrote:

SNIP

> > looks like it would ;-) will check and repost
> 
> new version attached.. Michael tested on several machines,
> but I couldn't find haswell with working tsx, to test
> that those events are displayed
> 
> thanks,
> jirka

ping

jirka

> 
> 
> ---
> Memory events depends on PEBs support and access to LDLAT msr,
> but we display them in /sys/devices/cpu/events even if the cpu
> does not provide those, like for KVM guests.
> 
> That brings the false assumption that those events should
> be available, while they fail event to open.
> 
> Separating the mem-* events attributes and merging them
> with cpu_events only if there's PEBs support detected.
> 
> We could also check if LDLAT msr is available, but the
> PEBs check seems to cover the need now.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/events/core.c       |  8 ++---
>  arch/x86/events/intel/core.c | 69 +++++++++++++++++++++++++++---------
>  2 files changed, 56 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 5f4829f10129..1a17004f6559 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1631,9 +1631,9 @@ __init struct attribute **merge_attr(struct attribute **a, struct attribute **b)
>  	struct attribute **new;
>  	int j, i;
>  
> -	for (j = 0; a[j]; j++)
> +	for (j = 0; a && a[j]; j++)
>  		;
> -	for (i = 0; b[i]; i++)
> +	for (i = 0; b && b[i]; i++)
>  		j++;
>  	j++;
>  
> @@ -1642,9 +1642,9 @@ __init struct attribute **merge_attr(struct attribute **a, struct attribute **b)
>  		return NULL;
>  
>  	j = 0;
> -	for (i = 0; a[i]; i++)
> +	for (i = 0; a && a[i]; i++)
>  		new[j++] = a[i];
> -	for (i = 0; b[i]; i++)
> +	for (i = 0; b && b[i]; i++)
>  		new[j++] = b[i];
>  	new[j] = NULL;
>  
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 035c37481f57..a10f80f697b7 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -242,7 +242,7 @@ EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
>  EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
>  EVENT_ATTR_STR(mem-stores,	mem_st_snb,	"event=0xcd,umask=0x2");
>  
> -static struct attribute *nhm_events_attrs[] = {
> +static struct attribute *nhm_mem_events_attrs[] = {
>  	EVENT_PTR(mem_ld_nhm),
>  	NULL,
>  };
> @@ -278,8 +278,6 @@ EVENT_ATTR_STR_HT(topdown-recovery-bubbles.scale, td_recovery_bubbles_scale,
>  	"4", "2");
>  
>  static struct attribute *snb_events_attrs[] = {
> -	EVENT_PTR(mem_ld_snb),
> -	EVENT_PTR(mem_st_snb),
>  	EVENT_PTR(td_slots_issued),
>  	EVENT_PTR(td_slots_retired),
>  	EVENT_PTR(td_fetch_bubbles),
> @@ -290,6 +288,12 @@ static struct attribute *snb_events_attrs[] = {
>  	NULL,
>  };
>  
> +static struct attribute *snb_mem_events_attrs[] = {
> +	EVENT_PTR(mem_ld_snb),
> +	EVENT_PTR(mem_st_snb),
> +	NULL,
> +};
> +
>  static struct event_constraint intel_hsw_event_constraints[] = {
>  	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
>  	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
> @@ -3764,8 +3768,6 @@ EVENT_ATTR_STR(cycles-t,	cycles_t,	"event=0x3c,in_tx=1");
>  EVENT_ATTR_STR(cycles-ct,	cycles_ct,	"event=0x3c,in_tx=1,in_tx_cp=1");
>  
>  static struct attribute *hsw_events_attrs[] = {
> -	EVENT_PTR(mem_ld_hsw),
> -	EVENT_PTR(mem_st_hsw),
>  	EVENT_PTR(td_slots_issued),
>  	EVENT_PTR(td_slots_retired),
>  	EVENT_PTR(td_fetch_bubbles),
> @@ -3776,6 +3778,12 @@ static struct attribute *hsw_events_attrs[] = {
>  	NULL
>  };
>  
> +static struct attribute *hsw_mem_events_attrs[] = {
> +	EVENT_PTR(mem_ld_hsw),
> +	EVENT_PTR(mem_st_hsw),
> +	NULL,
> +};
> +
>  static struct attribute *hsw_tsx_events_attrs[] = {
>  	EVENT_PTR(tx_start),
>  	EVENT_PTR(tx_commit),
> @@ -3792,13 +3800,6 @@ static struct attribute *hsw_tsx_events_attrs[] = {
>  	NULL
>  };
>  
> -static __init struct attribute **get_hsw_events_attrs(void)
> -{
> -	return boot_cpu_has(X86_FEATURE_RTM) ?
> -		merge_attr(hsw_events_attrs, hsw_tsx_events_attrs) :
> -		hsw_events_attrs;
> -}
> -
>  static ssize_t freeze_on_smi_show(struct device *cdev,
>  				  struct device_attribute *attr,
>  				  char *buf)
> @@ -3875,9 +3876,32 @@ static struct attribute *intel_pmu_attrs[] = {
>  	NULL,
>  };
>  
> +static __init struct attribute **
> +get_events_attrs(struct attribute **base,
> +		 struct attribute **mem,
> +		 struct attribute **tsx)
> +{
> +	struct attribute **attrs = base;
> +	struct attribute **old;
> +
> +	if (mem && x86_pmu.pebs)
> +		attrs = merge_attr(attrs, mem);
> +
> +	if (tsx && boot_cpu_has(X86_FEATURE_RTM)) {
> +		old = attrs;
> +		attrs = merge_attr(attrs, tsx);
> +		if (old != base)
> +			kfree(old);
> +	}
> +
> +	return attrs;
> +}
> +
>  __init int intel_pmu_init(void)
>  {
>  	struct attribute **extra_attr = NULL;
> +	struct attribute **mem_attr = NULL;
> +	struct attribute **tsx_attr = NULL;
>  	struct attribute **to_free = NULL;
>  	union cpuid10_edx edx;
>  	union cpuid10_eax eax;
> @@ -3986,7 +4010,7 @@ __init int intel_pmu_init(void)
>  		x86_pmu.enable_all = intel_pmu_nhm_enable_all;
>  		x86_pmu.extra_regs = intel_nehalem_extra_regs;
>  
> -		x86_pmu.cpu_events = nhm_events_attrs;
> +		mem_attr = nhm_mem_events_attrs;
>  
>  		/* UOPS_ISSUED.STALLED_CYCLES */
>  		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
> @@ -4112,7 +4136,7 @@ __init int intel_pmu_init(void)
>  		x86_pmu.extra_regs = intel_westmere_extra_regs;
>  		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
>  
> -		x86_pmu.cpu_events = nhm_events_attrs;
> +		mem_attr = nhm_mem_events_attrs;
>  
>  		/* UOPS_ISSUED.STALLED_CYCLES */
>  		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
> @@ -4152,6 +4176,7 @@ __init int intel_pmu_init(void)
>  		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
>  
>  		x86_pmu.cpu_events = snb_events_attrs;
> +		mem_attr = snb_mem_events_attrs;
>  
>  		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
>  		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
> @@ -4192,6 +4217,7 @@ __init int intel_pmu_init(void)
>  		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
>  
>  		x86_pmu.cpu_events = snb_events_attrs;
> +		mem_attr = snb_mem_events_attrs;
>  
>  		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
>  		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
> @@ -4226,10 +4252,12 @@ __init int intel_pmu_init(void)
>  
>  		x86_pmu.hw_config = hsw_hw_config;
>  		x86_pmu.get_event_constraints = hsw_get_event_constraints;
> -		x86_pmu.cpu_events = get_hsw_events_attrs();
> +		x86_pmu.cpu_events = hsw_events_attrs;
>  		x86_pmu.lbr_double_abort = true;
>  		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
>  			hsw_format_attr : nhm_format_attr;
> +		mem_attr = hsw_mem_events_attrs;
> +		tsx_attr = hsw_tsx_events_attrs;
>  		pr_cont("Haswell events, ");
>  		name = "haswell";
>  		break;
> @@ -4265,10 +4293,12 @@ __init int intel_pmu_init(void)
>  
>  		x86_pmu.hw_config = hsw_hw_config;
>  		x86_pmu.get_event_constraints = hsw_get_event_constraints;
> -		x86_pmu.cpu_events = get_hsw_events_attrs();
> +		x86_pmu.cpu_events = hsw_events_attrs;
>  		x86_pmu.limit_period = bdw_limit_period;
>  		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
>  			hsw_format_attr : nhm_format_attr;
> +		mem_attr = hsw_mem_events_attrs;
> +		tsx_attr = hsw_tsx_events_attrs;
>  		pr_cont("Broadwell events, ");
>  		name = "broadwell";
>  		break;
> @@ -4324,7 +4354,9 @@ __init int intel_pmu_init(void)
>  			hsw_format_attr : nhm_format_attr;
>  		extra_attr = merge_attr(extra_attr, skl_format_attr);
>  		to_free = extra_attr;
> -		x86_pmu.cpu_events = get_hsw_events_attrs();
> +		x86_pmu.cpu_events = hsw_events_attrs;
> +		mem_attr = hsw_mem_events_attrs;
> +		tsx_attr = hsw_tsx_events_attrs;
>  		intel_pmu_pebs_data_source_skl(
>  			boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X);
>  		pr_cont("Skylake events, ");
> @@ -4357,6 +4389,9 @@ __init int intel_pmu_init(void)
>  		WARN_ON(!x86_pmu.format_attrs);
>  	}
>  
> +	x86_pmu.cpu_events = get_events_attrs(x86_pmu.cpu_events,
> +					      mem_attr, tsx_attr);
> +
>  	if (x86_pmu.num_counters > INTEL_PMC_MAX_GENERIC) {
>  		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
>  		     x86_pmu.num_counters, INTEL_PMC_MAX_GENERIC);
> -- 
> 2.17.1
> 
