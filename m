Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C38C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623B1204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623B1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeICMK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:10:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbeICMK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:10:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B67432636E;
        Mon,  3 Sep 2018 07:51:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id CD637A9E73;
        Mon,  3 Sep 2018 07:51:28 +0000 (UTC)
Date:   Mon, 3 Sep 2018 09:51:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 10/10] tools, perf, script: Implement --graph-function
Message-ID: <20180903075128.GE24575@krava>
References: <20180831220206.28351-1-andi@firstfloor.org>
 <20180831220206.28351-11-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831220206.28351-11-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 03 Sep 2018 07:51:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 03 Sep 2018 07:51:29 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 03:02:06PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a ftrace style --graph-function argument to perf script that allows
> to print itrace function calls only below a given function. This
> makes it easier to find the code of interest in a large trace.
> 
> % perf record -e intel_pt//k -a sleep 1
> % perf script --graph-function group_sched_in --call-trace
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])          group_sched_in
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])              event_sched_in.isra.107
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_event_set_state.part.71
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_time
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_disable
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_log_itrace_start
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_userpage
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          calc_timer_values
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_cpu
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          __x86_indirect_thunk_rax
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          arch_perf_update_userpage
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              __fentry__
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              using_native_sched_clock
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_stable
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_enable
>             perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])          group_sched_in
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])              __x86_indirect_thunk_rax
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])              event_sched_in.isra.107
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  perf_event_set_state.part.71
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                      perf_event_update_time
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  perf_pmu_disable
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  perf_log_itrace_start
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                      perf_event_update_userpage
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                          calc_timer_values
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              sched_clock_cpu
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                          __x86_indirect_thunk_rax
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                          arch_perf_update_userpage
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              __fentry__
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              using_native_sched_clock
>          swapper     0 [001] 194167.205660693: ([kernel.kallsyms])                              sched_clock_stable

nice, but I'm also getting a lot of these lines:

 instruction trace error type 1 cpu 0 pid 0 tid 0 ip 0xffffffffb3a017a0 code 6: Trace doesn't match instruction
 instruction trace error type 1 cpu 0 pid 0 tid 0 ip 0xffffffffb3a017a0 code 6: Trace doesn't match instruction
 instruction trace error type 1 cpu 0 pid 0 tid 0 ip 0xffffffffb3a017a0 code 6: Trace doesn't match instruction

any idea where are those comming from?

thanks,
jirka
