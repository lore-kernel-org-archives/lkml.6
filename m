Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C81C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE082087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfARJw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:52:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfARJwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:52:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25EE5A091F;
        Fri, 18 Jan 2019 09:52:55 +0000 (UTC)
Received: from krava (unknown [10.40.205.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD08260BE8;
        Fri, 18 Jan 2019 09:52:52 +0000 (UTC)
Date:   Fri, 18 Jan 2019 10:52:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu,
        ak@linux.intel.com, kan.liang@intel.com, acme@redhat.com
Subject: Re: [PATCH] perf/core: fix perf_proc_update_handler() bug
Message-ID: <20190118095251.GB28346@krava>
References: <1547169436-6266-1-git-send-email-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547169436-6266-1-git-send-email-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 18 Jan 2019 09:52:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:17:16PM -0800, Stephane Eranian wrote:
> The perf_proc_update_handler() handles /proc/sys/kernel/perf_event_max_sample_rate
> syctl variable.  When the PMU IRQ handler timing monitoring is disabled, i.e,
> when /proc/sys/kernel/perf_cpu_time_max_percent is equal to 0 or 100,
> then no modification to sysctl_perf_event_sample_rate is allowed to prevent
> possible hang from wrong values.
> 
> The problem is that the test to prevent modification is made after the
> sysctl variable is modified in perf_proc_update_handler().
> 
> You get an error:
> 
> $ echo 10001 >/proc/sys/kernel/perf_event_max_sample_rate
> echo: write error: invalid argument
> 
> But the value is still modified causing all sorts of inconsistencies:
> 
> $ cat /proc/sys/kernel/perf_event_max_sample_rate
> 10001
> 
> This patch fixes the problem by moving the parsing of the value after
> the test.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/events/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3cd13a30f732..e5ede6918050 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -436,18 +436,18 @@ int perf_proc_update_handler(struct ctl_table *table, int write,
>  		void __user *buffer, size_t *lenp,
>  		loff_t *ppos)
>  {
> -	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> -
> -	if (ret || !write)
> -		return ret;
> -
> +	int ret;
> +	int perf_cpu = sysctl_perf_cpu_time_max_percent;
>  	/*
>  	 * If throttling is disabled don't allow the write:
>  	 */
> -	if (sysctl_perf_cpu_time_max_percent == 100 ||
> -	    sysctl_perf_cpu_time_max_percent == 0)
> +	if (write && (perf_cpu == 100 || perf_cpu == 0))
>  		return -EINVAL;
>  
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	if (ret || !write)
> +		return ret;
> +
>  	max_samples_per_tick = DIV_ROUND_UP(sysctl_perf_event_sample_rate, HZ);
>  	perf_sample_period_ns = NSEC_PER_SEC / sysctl_perf_event_sample_rate;
>  	update_perf_cpu_limits();
> -- 
> 2.7.4
> 
