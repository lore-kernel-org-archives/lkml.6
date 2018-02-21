Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933260AbeBUKc4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:32:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbeBUKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:32:53 -0500
Date: Wed, 21 Feb 2018 11:32:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH V4 1/5] perf/x86/intel: Fix event update for auto-reload
Message-ID: <20180221103247.GL25181@hirez.programming.kicks-ass.net>
References: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
 <1518474035-21006-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518474035-21006-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 02:20:31PM -0800, kan.liang@linux.intel.com wrote:
> @@ -1389,8 +1456,22 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
>  
>  	ds->pebs_index = ds->pebs_buffer_base;
>  
> -	if (unlikely(base >= top))
> +	if (unlikely(base >= top)) {
> +		/*
> +		 * The drain_pebs() could be called twice in a short period
> +		 * for auto-reload event in pmu::read(). There are no
> +		 * overflows have happened in between.
> +		 * It needs to call intel_pmu_save_and_restart_reload() to
> +		 * update the event->count for this case.
> +		 */
> +		for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled,
> +				 x86_pmu.max_pebs_events) {
> +			event = cpuc->events[bit];
> +			if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
> +				intel_pmu_save_and_restart_reload(event, 0);
> +		}
>  		return;
> +	}
>  
>  	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
>  		struct pebs_record_nhm *p = at;

Is there a reason you didn't do intel_pmu_drain_pebs_core() ?


--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1435,8 +1435,11 @@ static void intel_pmu_drain_pebs_core(st
 		return;
 
 	n = top - at;
-	if (n <= 0)
+	if (n <= 0) {
+		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
+			intel_pmu_save_and_restart_reload(event, 0);
 		return;
+	}
 
 	__intel_pmu_pebs_event(event, iregs, at, top, 0, n);
 }
