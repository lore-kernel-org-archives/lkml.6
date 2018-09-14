Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42AAC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7F320853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7F320853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeINMBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:01:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:57436 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeINMBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:01:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 23:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="90387046"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2018 23:47:53 -0700
Received: from [10.125.251.160] (abudanko-mobl.ccr.corp.intel.com [10.125.251.160])
        by linux.intel.com (Postfix) with ESMTP id EF7CE58053F;
        Thu, 13 Sep 2018 23:47:50 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel/lbr: Optimize context switches for LBR
To:     linux-kernel-owner@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
References: <1536869331-63561-1-git-send-email-kan.liang@linux.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <dec78c67-0631-c4a7-95e1-4b931ce9ecd7@linux.intel.com>
Date:   Fri, 14 Sep 2018 09:47:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536869331-63561-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13.09.2018 23:08, linux-kernel-owner@vger.kernel.org wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> LBR can bring big overhead when the benchmark has high context switches.
> For example, a sub benchmark of Dacapo, avrora.
> 
> Baseline: java -jar dacapo-9.12-MR1-bach.jar avrora -n 20
> With LBR: perf record --branch-filter any,u -- java -jar
> dacapo-9.12-MR1-bach.jar avrora -n 20
> 
> Baseline (ms)    With LBR (ms)    Overhead
> 6508		 19831		  205%
> 
> In principle the LBRs need to be flushed between threads. So does
> current code.

IMHO, ideally, LBRs stack would be preserved and restored when 
switching between execution stacks. That would allow implementing 
per-thread statistical call graph view in Perf tools, fully based 
on HW capabilities. It could be advantageous for some cases, in 
comparison with traditional dwarf based call graph. 

To me virtualization looks similar to e.g. HW performance counters 
whose values are switched back and forth from perf_event object
on context switches. But this is surely bigger effort.

Thanks,
Alexey

> 
> However in practice the LBRs clear very quickly when any code runs,
> so it is unlikely to be a functional problem of LBR use for sampling
> if there is a small leak shortly after each context switch.
> It is mainly a security issue that we don't want to leak anything to an
> attacker.
> 
> Different threads in a process already must trust each other so we can
> safely leak in this case without opening security holes.
> 
> When switching to kernel threads (such as the common switch to idle
> case) which also share the same mm and are guaranteed to not be
> attackers.
> 
> For those cases, resetting the LBRs can be safely avoid.
> Checking ctx_id, only resetting the LBRs when switching to a different
> user process.
> 
> With the patch,
> Baseline (ms)    With LBR (ms)    Overhead
> 6508		 10350            59%
> 
> Reported-by: Sandhya Viswanathan <sandhya.viswanathan@intel.com>
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/lbr.c  | 16 ++++++++++++++--
>  arch/x86/events/perf_event.h |  1 +
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index f3e006b..26344c4 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -444,9 +444,21 @@ void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
>  	 * are not tagged with an identifier, we need to wipe the LBR, even for
>  	 * per-cpu events. You simply cannot resolve the branches from the old
>  	 * address space.
> +	 * We don't need to wipe the LBR for a kernel thread which share the
> +	 * same mm with previous user thread.
>  	 */
> -	if (sched_in)
> -		intel_pmu_lbr_reset();
> +	if (!current || !current->mm)
> +		return;
> +	if (sched_in) {
> +		/*
> +		 * Only flush when switching to user threads
> +		 * and mm context changed
> +		 */
> +		if (current->mm->context.ctx_id != cpuc->last_ctx_id)
> +			intel_pmu_lbr_reset();
> +	} else {
> +		cpuc->last_ctx_id = current->mm->context.ctx_id;
> +	}
>  }
>  
>  static inline bool branch_user_callstack(unsigned br_sel)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 1562863..3aa3379 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -217,6 +217,7 @@ struct cpu_hw_events {
>  	u64				br_sel;
>  	struct x86_perf_task_context	*last_task_ctx;
>  	int				last_log_id;
> +	u64				last_ctx_id;
>  
>  	/*
>  	 * Intel host/guest exclude bits
> 
