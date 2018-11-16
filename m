Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFF4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398D32089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398D32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389767AbeKPXs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:48:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbeKPXs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:48:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B2D5C057F21;
        Fri, 16 Nov 2018 13:36:00 +0000 (UTC)
Received: from krava (ovpn-204-218.brq.redhat.com [10.40.204.218])
        by smtp.corp.redhat.com (Postfix) with SMTP id 758B95C6A5;
        Fri, 16 Nov 2018 13:35:56 +0000 (UTC)
Date:   Fri, 16 Nov 2018 14:35:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com,
        tmricht@linux.vnet.ibm.com, anton@samba.org
Subject: Re: [PATCH] perf stat: Fix shadow stats for clock events
Message-ID: <20181116133555.GA30465@krava>
References: <20181115141745.GJ9600@krava>
 <20181116042843.24067-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116042843.24067-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 16 Nov 2018 13:36:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 09:58:43AM +0530, Ravi Bangoria wrote:
> Commit 0aa802a79469 ("perf stat: Get rid of extra clock display
> function") introduced scale and unit for clock events. Thus,
> perf_stat__update_shadow_stats() now saves scaled values of
> clock events in msecs, instead of original nsecs. But while
> calculating values of shadow stats we still consider clock
> event values in nsecs. This results in a wrong shadow stat
> values. Ex,
> 
>   # ./perf stat -e task-clock,cycles ls
>     <SNIP>
>               2.60 msec task-clock:u    #    0.877 CPUs utilized
>          2,430,564      cycles:u        # 1215282.000 GHz
> 
> Fix this by saving original nsec values for clock events in
> perf_stat__update_shadow_stats(). After patch:
> 
>   # ./perf stat -e task-clock,cycles ls
>     <SNIP>
>               3.14 msec task-clock:u    #    0.839 CPUs utilized
>          3,094,528      cycles:u        #    0.985 GHz
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Suggested-by: Jiri Olsa <jolsa@redhat.com>
> Fixes: 0aa802a79469 ("perf stat: Get rid of extra clock display function")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/stat-shadow.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index f0a8cec55c47..3c22c58b3e90 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -209,11 +209,12 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
>  				    int cpu, struct runtime_stat *st)
>  {
>  	int ctx = evsel_context(counter);
> +	u64 count_ns = count;
>  
>  	count *= counter->scale;
>  
>  	if (perf_evsel__is_clock(counter))
> -		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
> +		update_runtime_stat(st, STAT_NSECS, 0, cpu, count_ns);
>  	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
>  		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
>  	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
> -- 
> 2.17.1
> 
