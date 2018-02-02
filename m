Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeBBO0z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:26:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbeBBO0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:26:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAB52178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 2 Feb 2018 11:26:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@intel.com
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, jolsa@kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH V5 12/17] perf evsel: expose
 perf_missing_features.write_backward
Message-ID: <20180202142638.GC26905@kernel.org>
References: <1516310792-208685-1-git-send-email-kan.liang@intel.com>
 <1516310792-208685-13-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516310792-208685-13-git-send-email-kan.liang@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 18, 2018 at 01:26:27PM -0800, kan.liang@intel.com escreveu:
> From: Kan Liang <kan.liang@intel.com>
> 
> perf top need it to handle overwrite fallback later.
> 
> Signed-off-by: Kan Liang <kan.liang@intel.com>
> ---
>  tools/perf/util/evsel.c | 5 +++++
>  tools/perf/util/evsel.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4eea3b4..1dd3700 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1670,6 +1670,11 @@ static bool ignore_missing_thread(struct perf_evsel *evsel,
>  	return true;
>  }
>  
> +bool is_write_backward_fail(void)
> +{
> +	return perf_missing_features.write_backward;
> +}
> +

Humm,  I think we better expose perf_missing_features, i.e. tools using

	if (perf_missing_features.write_backward)

looks more clear than:

	if (is_write_backward_fail())

This is minor, so I'm doing this myself, please holler if you disagree.

- Arnaldo

>  int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
>  		     struct thread_map *threads)
>  {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 846e416..1f46728 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -448,4 +448,6 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  
>  struct perf_env *perf_evsel__env(struct perf_evsel *evsel);
>  
> +bool is_write_backward_fail(void);
> +
>  #endif /* __PERF_EVSEL_H */
> -- 
> 2.5.5
