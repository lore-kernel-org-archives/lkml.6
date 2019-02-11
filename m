Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0150CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA1521B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfBKSLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:11:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:26467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfBKSLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:11:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 10:11:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="137744596"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2019 10:11:53 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E623030125E; Mon, 11 Feb 2019 10:11:53 -0800 (PST)
Date:   Mon, 11 Feb 2019 10:11:53 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lin Ming <ming.m.lin@intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@elte.hu>, He Zhe <zhe.he@windriver.com>
Subject: Re: [PATCH 4.9 137/137] perf: Add support for supplementary event
 registers
Message-ID: <20190211181153.GF16922@tassilo.jf.intel.com>
References: <20190211141811.964925535@linuxfoundation.org>
 <20190211141824.827389473@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211141824.827389473@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:20:18PM +0100, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Andi Kleen <ak@linux.intel.com>
> 
> commit a7e3ed1e470116c9d12c2f778431a481a6be8ab6 upstream.

The patch doesn't seem to match the commit log.

Did something got mixed up?

> Unfortunately this event requires programming a mask in a separate
> register. And worse this separate register is per core, not per
> CPU thread.
> 
> This patch:
> 
> - Teaches perf_events that OFFCORE_RESPONSE needs extra parameters.
>   The extra parameters are passed by user space in the
>   perf_event_attr::config1 field.
> 
> - Adds support to the Intel perf_event core to schedule per
>   core resources. This adds fairly generic infrastructure that
>   can be also used for other per core resources.
>   The basic code has is patterned after the similar AMD northbridge
>   constraints code.
> 
> Thanks to Stephane Eranian who pointed out some problems
> in the original version and suggested improvements.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> LKML-Reference: <1299119690-13991-2-git-send-email-ming.m.lin@intel.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> [ He Zhe: Fixes conflict caused by missing disable_counter_freeze which is
>  introduced since v4.20 af3bdb991a5cb. ]
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  arch/x86/events/intel/core.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3235,6 +3235,11 @@ static void free_excl_cntrs(int cpu)
>  
>  static void intel_pmu_cpu_dying(int cpu)
>  {
> +	fini_debug_store_on_cpu(cpu);
> +}
> +
> +static void intel_pmu_cpu_dead(int cpu)
> +{
>  	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
>  	struct intel_shared_regs *pc;
>  
> @@ -3246,8 +3251,6 @@ static void intel_pmu_cpu_dying(int cpu)
>  	}
>  
>  	free_excl_cntrs(cpu);
> -
> -	fini_debug_store_on_cpu(cpu);
>  }
>  
>  static void intel_pmu_sched_task(struct perf_event_context *ctx,
> @@ -3324,6 +3327,7 @@ static __initconst const struct x86_pmu
>  	.cpu_prepare		= intel_pmu_cpu_prepare,
>  	.cpu_starting		= intel_pmu_cpu_starting,
>  	.cpu_dying		= intel_pmu_cpu_dying,
> +	.cpu_dead		= intel_pmu_cpu_dead,
>  };
>  
>  static __initconst const struct x86_pmu intel_pmu = {
> @@ -3359,6 +3363,8 @@ static __initconst const struct x86_pmu
>  	.cpu_prepare		= intel_pmu_cpu_prepare,
>  	.cpu_starting		= intel_pmu_cpu_starting,
>  	.cpu_dying		= intel_pmu_cpu_dying,
> +	.cpu_dead		= intel_pmu_cpu_dead,
> +
>  	.guest_get_msrs		= intel_guest_get_msrs,
>  	.sched_task		= intel_pmu_sched_task,
>  };
> 
> 
