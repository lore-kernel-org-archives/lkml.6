Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BAFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F5B26427
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F5B26427
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933499AbeFZRZD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:25:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:3961 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752344AbeFZRZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:25:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 10:24:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="53071751"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2018 10:24:59 -0700
Received: from [10.252.9.225] (abudanko-mobl.ccr.corp.intel.com [10.252.9.225])
        by linux.intel.com (Postfix) with ESMTP id 3E1ED58011E;
        Tue, 26 Jun 2018 10:24:55 -0700 (PDT)
Subject: Re: [RFC 1/4] perf: Move some access checks later in perf_event_open
To:     Tvrtko Ursulin <tursulin@ursulin.net>, linux-kernel@vger.kernel.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
 <20180626153642.5587-2-tvrtko.ursulin@linux.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Message-ID: <861aa316-fa18-4385-af84-0e9445f261d1@linux.intel.com>
Date:   Tue, 26 Jun 2018 20:24:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626153642.5587-2-tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26.06.2018 18:36, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> 
> To enable per-PMU access controls in a following patch first move all call
> sites of perf_paranoid_kernel() to after the event has been created.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> ---
>  kernel/events/core.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f490caca9aa4..12de95b0472e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10189,10 +10189,6 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>  			 */
>  			attr->branch_sample_type = mask;
>  		}
> -		/* privileged levels capture (kernel, hv): check permissions */
> -		if ((mask & PERF_SAMPLE_BRANCH_PERM_PLM)
> -		    && perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> -			return -EACCES;
>  	}
>  
>  	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
> @@ -10409,11 +10405,6 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (err)
>  		return err;
>  
> -	if (!attr.exclude_kernel) {
> -		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> -			return -EACCES;
> -	}
> -
>  	if (attr.namespaces) {
>  		if (!capable(CAP_SYS_ADMIN))
>  			return -EACCES;
> @@ -10427,11 +10418,6 @@ SYSCALL_DEFINE5(perf_event_open,
>  			return -EINVAL;
>  	}
>  
> -	/* Only privileged users can get physical addresses */
> -	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
> -	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> -
>  	/*
>  	 * In cgroup mode, the pid argument is used to pass the fd
>  	 * opened to the cgroup directory in cgroupfs. The cpu argument
> @@ -10501,6 +10487,28 @@ SYSCALL_DEFINE5(perf_event_open,
>  		goto err_cred;
>  	}
>  
> +	if (!attr.exclude_kernel) {
> +		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
> +			err = -EACCES;

I would separate this combined permissions check into a function e.g.
static bool perf_test_pmu_paranoid(const struct pmu *pmu, int *err) to avoid 
code duplication.

> +			goto err_alloc;
> +		}
> +	}
> +
> +	/* Only privileged users can get physical addresses */
> +	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
> +	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
> +		err = -EACCES;
> +		goto err_alloc;
> +	}
> +
> +	/* privileged levels capture (kernel, hv): check permissions */
> +	if ((attr.sample_type & PERF_SAMPLE_BRANCH_STACK) &&
> +	    (attr.branch_sample_type & PERF_SAMPLE_BRANCH_PERM_PLM) &&
> +	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
> +		err = -EACCES;
> +		goto err_alloc;
> +	}
> +
>  	if (is_sampling_event(event)) {
>  		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
>  			err = -EOPNOTSUPP;
> 
