Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6DEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5BF2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406186AbfBOOl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:41:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfBOOly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:41:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59B39C0718BF;
        Fri, 15 Feb 2019 14:41:54 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-32.phx2.redhat.com [10.3.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEB191024949;
        Fri, 15 Feb 2019 14:41:50 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 8529B55C4; Fri, 15 Feb 2019 12:41:46 -0200 (BRST)
Date:   Fri, 15 Feb 2019 12:41:46 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v2 perf,bpf 11/11] perf, bpf: save information about
 short living bpf programs
Message-ID: <20190215144146.GF5784@redhat.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000045.2592135-1-songliubraving@fb.com>
 <20190215000045.2592135-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215000045.2592135-2-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 15 Feb 2019 14:41:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 14, 2019 at 04:00:45PM -0800, Song Liu escreveu:
> To annotate bpf programs in perf, it is necessary to save information in
> bpf_prog_info and btf. For short living bpf program, it is necessary to
> save these information before it is unloaded.
> 
> This patch saves these information in a separate thread. This thread
> creates its own evlist, that only tracks bpf events. This evlists uses
> ring buffer with very low watermark for lower latency. When bpf load
> events are received, this thread tries to gather information via sys_bpf
> and save it in perf_env.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/builtin-record.c |  13 ++++
>  tools/perf/builtin-top.c    |  12 ++++
>  tools/perf/util/bpf-event.c | 129 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/bpf-event.h |  22 ++++++
>  tools/perf/util/evlist.c    |  20 ++++++
>  tools/perf/util/evlist.h    |   2 +
>  6 files changed, 198 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 2355e0a9eda0..46abb44aaaab 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1106,6 +1106,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	struct perf_data *data = &rec->data;
>  	struct perf_session *session;
>  	bool disabled = false, draining = false;
> +	struct bpf_event_poll_args poll_args;
> +	bool bpf_thread_running = false;
>  	int fd;
>  
>  	atexit(record__sig_exit);
> @@ -1206,6 +1208,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		goto out_child;
>  	}
>  
> +	if (rec->opts.bpf_event) {
> +		poll_args.env = &session->header.env;
> +		poll_args.target = &rec->opts.target;
> +		poll_args.done = &done;
> +		if (bpf_event__start_polling_thread(&poll_args) == 0)
> +			bpf_thread_running = true;
> +	}
> +
>  	err = record__synthesize(rec, false);
>  	if (err < 0)
>  		goto out_child;
> @@ -1456,6 +1466,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  
>  out_delete_session:
>  	perf_session__delete(session);
> +
> +	if (bpf_thread_running)
> +		bpf_event__stop_polling_thread(&poll_args);
>  	return status;
>  }
>  
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 5271d7211b9c..2586ee081967 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1524,10 +1524,12 @@ int cmd_top(int argc, const char **argv)
>  			"number of thread to run event synthesize"),
>  	OPT_END()
>  	};
> +	struct bpf_event_poll_args poll_args;
>  	const char * const top_usage[] = {
>  		"perf top [<options>]",
>  		NULL
>  	};
> +	bool bpf_thread_running = false;
>  	int status = hists__init();
>  
>  	if (status < 0)
> @@ -1652,8 +1654,18 @@ int cmd_top(int argc, const char **argv)
>  		signal(SIGWINCH, winch_sig);
>  	}
>  
> +	if (top.record_opts.bpf_event) {
> +		poll_args.env = &perf_env;
> +		poll_args.target = target;
> +		poll_args.done = &done;
> +		if (bpf_event__start_polling_thread(&poll_args) == 0)
> +			bpf_thread_running = true;
> +	}
>  	status = __cmd_top(&top);
>  
> +	if (bpf_thread_running)
> +		bpf_event__stop_polling_thread(&poll_args);
> +
>  out_delete_evlist:
>  	perf_evlist__delete(top.evlist);
>  
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 4f347d61ed96..0caf137c515b 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -8,6 +8,7 @@
>  #include "machine.h"
>  #include "env.h"
>  #include "session.h"
> +#include "evlist.h"
>  
>  #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
>  
> @@ -316,3 +317,131 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
>  	free(event);
>  	return err;
>  }
> +
> +static void perf_env_add_bpf_info(struct perf_env *env, u32 id)
> +{
> +	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_prog_info_node *info_node;
> +	struct btf *btf = NULL;
> +	u64 arrays;
> +	u32 btf_id;
> +	int fd;
> +
> +	fd = bpf_prog_get_fd_by_id(id);
> +	if (fd < 0)
> +		return;
> +
> +	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
> +	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
> +	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
> +	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
> +	arrays |= 1UL << BPF_PROG_INFO_JITED_INSNS;
> +	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
> +	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
> +
> +	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
> +	if (IS_ERR_OR_NULL(info_linear)) {
> +		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
> +		goto out;
> +	}
> +
> +	btf_id = info_linear->info.btf_id;
> +
> +	info_node = malloc(sizeof(struct bpf_prog_info_node));
> +	if (info_node) {
> +		info_node->info_linear = info_linear;
> +		perf_env__insert_bpf_prog_info(env, info_node);
> +	} else
> +		free(info_linear);
> +
> +	if (btf_id == 0)
> +		goto out;
> +
> +	if (btf__get_from_id(btf_id, &btf)) {
> +		pr_debug("%s: failed to get BTF of id %u, aborting\n",
> +			 __func__, btf_id);
> +		goto out;
> +	}
> +	perf_fetch_btf(env, btf_id, btf);
> +
> +out:
> +	free(btf);
> +	close(fd);
> +}
> +
> +static void *bpf_poll_thread(void *arg)
> +{
> +	struct bpf_event_poll_args *args = arg;
> +	int i;
> +
> +	while (!*(args->done)) {
> +		perf_evlist__poll(args->evlist, 1000);
> +
> +		for (i = 0; i < args->evlist->nr_mmaps; i++) {
> +			struct perf_mmap *map = &args->evlist->mmap[i];
> +			union perf_event *event;
> +
> +			if (perf_mmap__read_init(map))
> +				continue;
> +			while ((event = perf_mmap__read_event(map)) != NULL) {
> +				pr_debug("processing vip event of type %d\n",
> +					 event->header.type);
> +				switch (event->header.type) {
> +				case PERF_RECORD_BPF_EVENT:
> +					if (event->bpf_event.type != PERF_BPF_EVENT_PROG_LOAD)
> +						break;
> +					perf_env_add_bpf_info(args->env, event->bpf_event.id);
> +					break;
> +				default:
> +					break;
> +				}
> +				perf_mmap__consume(map);
> +			}
> +			perf_mmap__read_done(map);
> +		}
> +	}
> +	return NULL;
> +}
> +
> +pthread_t poll_thread;
> +
> +int bpf_event__start_polling_thread(struct bpf_event_poll_args *args)
> +{
> +	struct perf_evsel *counter;
> +
> +	args->evlist = perf_evlist__new();
> +
> +	if (args->evlist == NULL)
> +		return -1;
> +
> +	if (perf_evlist__create_maps(args->evlist, args->target))
		goto out_delete_evlist;
> +
> +	if (perf_evlist__add_bpf_tracker(args->evlist))
		goto out_delete_evlist;
> +
> +	evlist__for_each_entry(args->evlist, counter) {
> +		if (perf_evsel__open(counter, args->evlist->cpus,
> +				     args->evlist->threads) < 0)
			goto out_delete_evlist;
> +	}
> +
> +	if (perf_evlist__mmap(args->evlist, UINT_MAX))
		goto out_delete_evlist;
> +
> +	evlist__for_each_entry(args->evlist, counter) {
> +		if (perf_evsel__enable(counter))
			goto out_delete_evlist;
> +	}
> +
> +	if (pthread_create(&poll_thread, NULL, bpf_poll_thread, args))
		goto out_delete_evlist;	
> +
> +	return 0;
out_delete_evlist:
	perf_evlist__delete(args->evlist);
	args->evlist = NULL;

	return -1;
> +}
> +
> +void bpf_event__stop_polling_thread(struct bpf_event_poll_args *args)
> +{
> +	pthread_join(poll_thread, NULL);
> +	perf_evlist__exit(args->evlist);
> +}
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index c4f0f1395ea5..61914827c1e3 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -12,12 +12,17 @@
>  #include <bpf/libbpf.h>
>  #include <linux/btf.h>
>  #include <linux/rbtree.h>
> +#include <pthread.h>
> +#include <api/fd/array.h>
>  #include "event.h"
>  
>  struct machine;
>  union perf_event;
> +struct perf_env;
>  struct perf_sample;
>  struct record_opts;
> +struct evlist;
> +struct target;
>  
>  struct bpf_prog_info_node {
>  	struct bpf_prog_info_linear	*info_linear;
> @@ -31,6 +36,13 @@ struct btf_node {
>  	char		data[];
>  };
>  
> +struct bpf_event_poll_args {
> +	struct perf_env		*env;
> +	struct perf_evlist	*evlist;
> +	struct target		*target;
> +	volatile int		*done;
> +};
> +
>  #ifdef HAVE_LIBBPF_SUPPORT
>  int machine__process_bpf_event(struct machine *machine, union perf_event *event,
>  			       struct perf_sample *sample);
> @@ -39,6 +51,8 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
>  				      perf_event__handler_t process,
>  				      struct machine *machine,
>  				      struct record_opts *opts);
> +int bpf_event__start_polling_thread(struct bpf_event_poll_args *args);
> +void bpf_event__stop_polling_thread(struct bpf_event_poll_args *args);
>  #else
>  static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
>  					     union perf_event *event __maybe_unused,
> @@ -54,5 +68,13 @@ static inline int perf_event__synthesize_bpf_events(struct perf_session *session
>  {
>  	return 0;
>  }
> +
> +static inline int bpf_event__start_polling_thread(struct bpf_event_poll_args *args __maybe_unused)
> +{
> +	return 0;
> +}
> +void bpf_event__stop_polling_thread(struct bpf_event_poll_args *args __maybe_unused)
> +{
> +}
>  #endif // HAVE_LIBBPF_SUPPORT
>  #endif
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 8c902276d4b4..612c079579ce 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -271,6 +271,26 @@ int perf_evlist__add_dummy(struct perf_evlist *evlist)
>  	return 0;
>  }
>  
> +int perf_evlist__add_bpf_tracker(struct perf_evlist *evlist)
> +{
> +	struct perf_event_attr attr = {
> +		.type	          = PERF_TYPE_SOFTWARE,
> +		.config           = PERF_COUNT_SW_DUMMY,
> +		.watermark        = 1,
> +		.bpf_event        = 1,
> +		.wakeup_watermark = 1,
> +		.size	   = sizeof(attr), /* to capture ABI version */
> +	};
> +	struct perf_evsel *evsel = perf_evsel__new_idx(&attr,
> +						       evlist->nr_entries);
> +
> +	if (evsel == NULL)
> +		return -ENOMEM;
> +
> +	perf_evlist__add(evlist, evsel);

You could use:

	struct perf_evlist *evlist = perf_evlist__new_dummy();
	if (evlist != NULL) {
		struct perf_evsel *evsel == perf_evlist__first(evlist);
		evsel->attr.bpf_event = evsel->attr.watermark = evsel->attr.wakeup_watermark = 1;
		return 0;
	}
	return -1;

Because in this case all you'll have in this evlist is the bpf tracker,
right? The add_bpf_tracker would be handy if we would want to have a
pre-existing evlist with some other events and wanted to add a bpf
tracker, no?

- Arnaldo

> +	return 0;
> +}
> +
>  static int perf_evlist__add_attrs(struct perf_evlist *evlist,
>  				  struct perf_event_attr *attrs, size_t nr_attrs)
>  {
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 868294491194..a2d22715188e 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -84,6 +84,8 @@ int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
>  
>  int perf_evlist__add_dummy(struct perf_evlist *evlist);
>  
> +int perf_evlist__add_bpf_tracker(struct perf_evlist *evlist);
> +
>  int perf_evlist__add_newtp(struct perf_evlist *evlist,
>  			   const char *sys, const char *name, void *handler);
>  
> -- 
> 2.17.1
