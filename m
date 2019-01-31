Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE0CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C4B218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbfAaI1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:27:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfAaI1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:27:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB55E804EC;
        Thu, 31 Jan 2019 08:27:14 +0000 (UTC)
Received: from krava (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1EFFB5C207;
        Thu, 31 Jan 2019 08:27:11 +0000 (UTC)
Date:   Thu, 31 Jan 2019 09:27:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, eranian@google.com,
        vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Message-ID: <20190131082711.GC24233@krava>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130183648.GA24233@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 31 Jan 2019 08:27:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 07:36:48PM +0100, Jiri Olsa wrote:

SNIP

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 280a72b3a553..22ec63a0782e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4969,6 +4969,26 @@ static void __perf_event_period(struct perf_event *event,
>  	}
>  }
>  
> +static int check_period(struct perf_event *event, u64 value)
> +{
> +	u64 sample_period_attr = event->attr.sample_period;
> +	u64 sample_period_hw   = event->hw.sample_period;
> +	int ret;
> +
> +	if (event->attr.freq) {
> +		event->attr.sample_freq = value;
> +	} else {
> +		event->attr.sample_period = value;
> +		event->hw.sample_period = value;
> +	}

hm, I think we need to check the period without changing the event,
because we don't disable pmu, so it might get picked up by bts code

will check

jirka

> +
> +	ret = event->pmu->check_period(event);
> +
> +	event->attr.sample_period = sample_period_attr;
> +	event->hw.sample_period   = sample_period_hw;
> +	return ret;
> +}
> +
>  static int perf_event_period(struct perf_event *event, u64 __user *arg)
>  {
>  	u64 value;
> @@ -4985,6 +5005,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
>  	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
>  		return -EINVAL;
>  
> +	if (check_period(event, value))
> +		return -EINVAL;
> +
>  	event_function_call(event, __perf_event_period, &value);
>  
>  	return 0;
> @@ -9601,6 +9624,11 @@ static int perf_pmu_nop_int(struct pmu *pmu)
>  	return 0;
>  }
>  
> +static int perf_event_nop_int(struct perf_event *event)
> +{
> +	return 0;
> +}
> +
>  static DEFINE_PER_CPU(unsigned int, nop_txn_flags);
>  
>  static void perf_pmu_start_txn(struct pmu *pmu, unsigned int flags)
> @@ -9901,6 +9929,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>  		pmu->pmu_disable = perf_pmu_nop_void;
>  	}
>  
> +	if (!pmu->check_period)
> +		pmu->check_period = perf_event_nop_int;
> +
>  	if (!pmu->event_idx)
>  		pmu->event_idx = perf_event_idx_default;
>  
> -- 
> 2.17.2
> 
