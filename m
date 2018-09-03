Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42311C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02FB20645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02FB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeICUEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:04:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:36763 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICUEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:04:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 08:44:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="80536882"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2018 08:44:08 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9ACEC301B65; Mon,  3 Sep 2018 08:44:08 -0700 (PDT)
Date:   Mon, 3 Sep 2018 08:44:08 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] tools, perf, script: Implement --graph-function
Message-ID: <20180903154408.GG27886@tassilo.jf.intel.com>
References: <20180831220206.28351-1-andi@firstfloor.org>
 <20180831220206.28351-11-andi@firstfloor.org>
 <20180903075128.GE24575@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903075128.GE24575@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 09:51:28AM +0200, Jiri Olsa wrote:
> On Fri, Aug 31, 2018 at 03:02:06PM -0700, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Add a ftrace style --graph-function argument to perf script that allows
> > to print itrace function calls only below a given function. This
> > makes it easier to find the code of interest in a large trace.
> > 
> > % perf record -e intel_pt//k -a sleep 1
> > % perf script --graph-function group_sched_in --call-trace
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])          group_sched_in
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])              event_sched_in.isra.107
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_event_set_state.part.71
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_time
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_disable
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_log_itrace_start
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_userpage
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          calc_timer_values
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_cpu
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          __x86_indirect_thunk_rax
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          arch_perf_update_userpage
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              __fentry__
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              using_native_sched_clock
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_stable
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_enable
> >             perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])          group_sched_in
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])              __x86_indirect_thunk_rax
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])              event_sched_in.isra.107
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  perf_event_set_state.part.71
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                      perf_event_update_time
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  perf_pmu_disable
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  perf_log_itrace_start
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                      perf_event_update_userpage
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                          calc_timer_values
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              sched_clock_cpu
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                          __x86_indirect_thunk_rax
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                          arch_perf_update_userpage
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              __fentry__
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              using_native_sched_clock
> >          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              sched_clock_stable
> 
> nice, but I'm also getting a lot of these lines:
> 
>  instruction trace error type 1 cpu 0 pid 0 tid 0 ip 0xffffffffb3a017a0 code 6: Trace doesn't match instruction
>  instruction trace error type 1 cpu 0 pid 0 tid 0 ip 0xffffffffb3a017a0 code 6: Trace doesn't match instruction
>  instruction trace error type 1 cpu 0 pid 0 tid 0 ip 0xffffffffb3a017a0 code 6: Trace doesn't match instruction
> 
> any idea where are those comming from?

PT decoder didn't see the same instructions as during the trace collection.

There are many reasons which can cause this, usually (but not always) some form of
self modifying code.  The Linux kernel does a lot of self modification these days,
which is a challenge for PT.

If you run the decoder as root it will decode from /proc/kcore, which helps, but
only if no jump label has changed state since the collection. 

The perf PT decoder tends to resync relatively quickly, so usually not too much
is lost.

-Andi

