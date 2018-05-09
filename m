Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965161AbeEIPvz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:51:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40351 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935402AbeEIPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:51:54 -0400
X-Google-Smtp-Source: AB8JxZo1Zss5V6X/LtKxPEyGsd+XuWv6WTqYSLb8sqe1yM+m++8DYXLCOAoRhm1D3GlX0pTpx/9oQw==
Date: Wed, 9 May 2018 09:51:50 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 1/2] perf cs-etm: Support unknown_thread in
 cs_etm_auxtrace
Message-ID: <20180509155150.GC25559@xps15>
References: <1525839312-20544-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525839312-20544-1-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 12:15:11PM +0800, Leo Yan wrote:
> CoreSight doesn't allocate thread structure for unknown_thread in etm
> auxtrace, so unknown_thread is NULL pointer.  If the perf data doesn't
> contain valid tid and then cs_etm__mem_access() uses unknown_thread
> instead as thread handler, this results in segmentation fault when
> thread__find_addr_map() accesses thread handler.
> 
> This commit creates new thread data which is used by unknown_thread, so
> CoreSight tracing can roll back to use unknown_thread if perf data
> doesn't include valid thread info.  This commit also releases thread
> data for initialization failure case and for normal auxtrace free flow.

Hi Leo,

Arnaldo maintains the perf tools and he receives dozens of patches every day.
If his name is not the first one to appear on the "To:" list, it is unlikely
that his email filters will catch your patches.

Mathieu

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 6533b1a..69f21de 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -239,6 +239,7 @@ static void cs_etm__free(struct perf_session *session)
>  	for (i = 0; i < aux->num_cpu; i++)
>  		zfree(&aux->metadata[i]);
>  
> +	thread__zput(aux->unknown_thread);
>  	zfree(&aux->metadata);
>  	zfree(&aux);
>  }
> @@ -1355,6 +1356,23 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	etm->auxtrace.free = cs_etm__free;
>  	session->auxtrace = &etm->auxtrace;
>  
> +	etm->unknown_thread = thread__new(999999999, 999999999);
> +	if (!etm->unknown_thread)
> +		goto err_free_queues;
> +
> +	/*
> +	 * Initialize list node so that at thread__zput() we can avoid
> +	 * segmentation fault at list_del_init().
> +	 */
> +	INIT_LIST_HEAD(&etm->unknown_thread->node);
> +
> +	err = thread__set_comm(etm->unknown_thread, "unknown", 0);
> +	if (err)
> +		goto err_delete_thread;
> +
> +	if (thread__init_map_groups(etm->unknown_thread, etm->machine))
> +		goto err_delete_thread;
> +
>  	if (dump_trace) {
>  		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
>  		return 0;
> @@ -1369,16 +1387,18 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  
>  	err = cs_etm__synth_events(etm, session);
>  	if (err)
> -		goto err_free_queues;
> +		goto err_delete_thread;
>  
>  	err = auxtrace_queues__process_index(&etm->queues, session);
>  	if (err)
> -		goto err_free_queues;
> +		goto err_delete_thread;
>  
>  	etm->data_queued = etm->queues.populated;
>  
>  	return 0;
>  
> +err_delete_thread:
> +	thread__zput(etm->unknown_thread);
>  err_free_queues:
>  	auxtrace_queues__free(&etm->queues);
>  	session->auxtrace = NULL;
> -- 
> 2.7.4
> 
