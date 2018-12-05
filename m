Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3EF206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3EF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeLEKVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:21:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbeLEKVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:21:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5E5B8553D;
        Wed,  5 Dec 2018 10:21:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id B4BCB19C7D;
        Wed,  5 Dec 2018 10:21:41 +0000 (UTC)
Date:   Wed, 5 Dec 2018 11:21:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf vendor events intel: Fix Load_Miss_Real_Latency on
 SKL/SKX
Message-ID: <20181205102140.GC2950@krava>
References: <20181120050635.4215-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120050635.4215-1-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 05 Dec 2018 10:21:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:06:35PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Fix incorrect event names for the Load_Miss_Real_Latency metric for
> Skylake and Skylake Server.
> 
> Fixes https://github.com/andikleen/pmu-tools/issues/158

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Before:
> 
> % perf stat -M Load_Miss_Real_Latency true
> event syntax error: '..ss.pending,mem_load_retired.l1_miss_ps,mem_load_retired.fb_hit_ps}:W'
>                                   \___ parser error
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -M, --metrics <metric/metric group list>
>                           monitor specified metrics or metric groups (separated by ,)
> 
> After:
> 
> % perf stat -M Load_Miss_Real_Latency true
> 
>  Performance counter stats for 'true':
> 
>            279,204      l1d_pend_miss.pending     #     14.0 Load_Miss_Real_Latency
>              4,784      mem_load_uops_retired.l1_miss
>             15,188      mem_load_uops_retired.hit_lfb
> 
>        0.000899640 seconds time elapsed
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json  | 2 +-
>  tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> index 36c903faed0b..71e9737f4614 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> @@ -73,7 +73,7 @@
>      },
>      {
>          "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
> -        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS_PS + MEM_LOAD_RETIRED.FB_HIT_PS )",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
>          "MetricGroup": "Memory_Bound;Memory_Lat",
>          "MetricName": "Load_Miss_Real_Latency"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> index 36c903faed0b..71e9737f4614 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> @@ -73,7 +73,7 @@
>      },
>      {
>          "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
> -        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS_PS + MEM_LOAD_RETIRED.FB_HIT_PS )",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
>          "MetricGroup": "Memory_Bound;Memory_Lat",
>          "MetricName": "Load_Miss_Real_Latency"
>      },
> -- 
> 2.17.2
> 
