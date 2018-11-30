Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1CBC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A642145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A642145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeK3Vaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:30:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeK3Vaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:30:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 686903001BF8;
        Fri, 30 Nov 2018 10:21:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.17])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0BA4560C61;
        Fri, 30 Nov 2018 10:21:55 +0000 (UTC)
Date:   Fri, 30 Nov 2018 11:21:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] perf evsel: Correct clock unit to nanosecond
Message-ID: <20181130102154.GA3617@krava>
References: <1543572365-11706-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543572365-11706-1-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 30 Nov 2018 10:21:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 06:06:05PM +0800, Leo Yan wrote:
> Since commit 0aa802a79469 ("perf stat: Get rid of extra clock display
> function"), the cpu and task clock unit has been changed from
> nanosecond value to millisecond value.  This introduces confusion for
> CPU run time statistics, we can see in below flow the clock value is
> scaled from nanosecond value to millisecond value; but this is
> contradiction with statistics type 'STAT_NSECS', which always takes
> clock as nanosecond unit.
> 
>   perf_stat__update_shadow_stats()
>     `-> count *= counter->scale;
>         update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
> 
> And when 'perf stat' calculates frequencies for cpu cycles and other
> events, it uses event count to divide clock and it expects divisor unit
> has nanosecond value, but actually the clock value has been scaled to
> millisecond value.  At the end we can exaggerate values in below output
> result (e.g. 500M/sec for context-switches, cycle is 1079636.500 GHz).
> 
>   # perf stat -- sleep 1
> 
>    Performance counter stats for 'sleep 1':
> 
>                 2.29 msec task-clock                #    0.002 CPUs utilized
>                    1      context-switches          #  500.000 M/sec
>                    1      cpu-migrations            #  500.000 M/sec
>                   53      page-faults               # 26500.000 M/sec
>            2,159,273      cycles                    # 1079636.500 GHz
>            1,281,566      instructions              #    0.59  insn per cycle
>              171,153      branches                  # 85576500.000 M/sec
>               17,870      branch-misses             #   10.44% of all branches
> 
> To fix this issue, this patch changes back clock unit to nanosecond
> level, as result we can see the correct frequency calculation:
> 
>   # perf stat -- sleep 1
> 
>    Performance counter stats for 'sleep 1':
> 
>            2,461,180 nsec task-clock                #    0.002 CPUs utilized
>                    1      context-switches          #    0.406 K/sec
>                    0      cpu-migrations            #    0.000 K/sec
>                   54      page-faults               #    0.022 M/sec
>            2,320,634      cycles                    #    0.943 GHz
>            1,284,442      instructions              #    0.55  insn per cycle
>              171,425      branches                  #   69.652 M/sec
>               17,970      branch-misses             #   10.48% of all branches
> 
> This patch has side effect for changing unit field for perf command.
> This is tested with below two cases: one is for normal output format and
> another is for cvs output format.
> 
> Before:
> 
>   # perf stat  -e cpu-clock,task-clock -C 0 sleep 3
> 
>    Performance counter stats for 'CPU(s) 0':
> 
>             3,003.50 msec cpu-clock                 #    1.000 CPUs utilized
>             3,003.50 msec task-clock                #    1.000 CPUs utilized
> 
>          3.003697880 seconds time elapsed
> 
> Now:
> 
>   # perf stat  -e cpu-clock,task-clock -C 0 sleep 3
> 
>    Performance counter stats for 'CPU(s) 0':
> 
>        3,003,684,880 nsec cpu-clock                 #    1.000 CPUs utilized
>        3,003,682,780 nsec task-clock                #    1.000 CPUs utilized
> 
>          3.003881982 seconds time elapsed
> 
> Before:
> 
>   # perf stat  -e cpu-clock,task-clock -C 0 -x, sleep 3
>   3003.64,msec,cpu-clock,3003644320,100.00,1.000,CPUs utilized
>   3003.64,msec,task-clock,3003643300,100.00,1.000,CPUs utilized
> 
> Now:
> 
>   # perf stat  -e cpu-clock,task-clock -C 0 -x, sleep 3
>   3003501460,nsec,cpu-clock,3003501660,100.00,1.000,CPUs utilized
>   3003499500,nsec,task-clock,3003499500,100.00,1.000,CPUs utilized
> 
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

there was fix for this recently, could you please check
if it's working for you:
  6e269c85dcea perf stat: Fix shadow stats for clock events

thanks,
jirka
