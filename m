Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeEHRBd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:01:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51095 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbeEHRBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:01:31 -0400
X-Google-Smtp-Source: AB8JxZptWSmg3ZLOiJASqcDtaynsDRoaFsTMTSkO/kd5EKLL5NhqYQbVuEm3b1pW/dOt5Fi4nL1v1iXPbmoOSKbvP6E=
MIME-Version: 1.0
In-Reply-To: <1525360703-26159-1-git-send-email-leo.yan@linaro.org>
References: <1525360703-26159-1-git-send-email-leo.yan@linaro.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 8 May 2018 11:01:30 -0600
Message-ID: <CANLsYky4QatoCv_4k1r8eb4Rjugx9g2YZLG1dtHKJy9AsHtCSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf cs-etm: Support unknown_thread in cs_etm_auxtrace
To: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 May 2018 at 09:18, Leo Yan <leo.yan@linaro.org> wrote:
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
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 6533b1a..417302c 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -239,6 +239,7 @@ static void cs_etm__free(struct perf_session *session)
>         for (i = 0; i < aux->num_cpu; i++)
>                 zfree(&aux->metadata[i]);
>
> +       thread__zput(aux->unknown_thread);
>         zfree(&aux->metadata);
>         zfree(&aux);
>  }
> @@ -266,6 +267,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
>         if (!thread) {
>                 if (cpumode != PERF_RECORD_MISC_KERNEL)
>                         return -EINVAL;
> +

Extra line, please remove.

With this change:

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>                 thread = etmq->etm->unknown_thread;
>         }
>
> @@ -1355,6 +1357,23 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>         etm->auxtrace.free = cs_etm__free;
>         session->auxtrace = &etm->auxtrace;
>
> +       etm->unknown_thread = thread__new(999999999, 999999999);
> +       if (!etm->unknown_thread)
> +               goto err_free_queues;
> +
> +       /*
> +        * Initialize list node so that at thread__zput() we can avoid
> +        * segmentation fault at list_del_init().
> +        */
> +       INIT_LIST_HEAD(&etm->unknown_thread->node);
> +
> +       err = thread__set_comm(etm->unknown_thread, "unknown", 0);
> +       if (err)
> +               goto err_delete_thread;
> +
> +       if (thread__init_map_groups(etm->unknown_thread, etm->machine))
> +               goto err_delete_thread;
> +
>         if (dump_trace) {
>                 cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
>                 return 0;
> @@ -1369,16 +1388,18 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>
>         err = cs_etm__synth_events(etm, session);
>         if (err)
> -               goto err_free_queues;
> +               goto err_delete_thread;
>
>         err = auxtrace_queues__process_index(&etm->queues, session);
>         if (err)
> -               goto err_free_queues;
> +               goto err_delete_thread;
>
>         etm->data_queued = etm->queues.populated;
>
>         return 0;
>
> +err_delete_thread:
> +       thread__zput(etm->unknown_thread);
>  err_free_queues:
>         auxtrace_queues__free(&etm->queues);
>         session->auxtrace = NULL;
> --
> 2.7.4
>
