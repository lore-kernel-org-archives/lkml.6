Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75866C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4259F21773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfBQXGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:06:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfBQXGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:06:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EFF92F86ED;
        Sun, 17 Feb 2019 23:06:49 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0A06B261D0;
        Sun, 17 Feb 2019 23:06:46 +0000 (UTC)
Date:   Mon, 18 Feb 2019 00:06:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 perf,bpf 10/11] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190217230646.GL7443@krava>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-11-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215215354.3114006-11-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 17 Feb 2019 23:06:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:53:53PM -0800, Song Liu wrote:

SNIP

> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 52507435c464..6c363adc781a 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -25,12 +25,60 @@ static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
>  	return ret;
>  }
>  

please move PERF_BPF_EVENT_PROG_LOAD/PERF_BPF_EVENT_PROG_UNLOAD
handling code below into separate patch from the bpf disassembly
code

thanks,
jirka

> +static int machine__process_bpf_event_load(struct machine *machine __maybe_unused,
> +					   union perf_event *event,
> +					   struct perf_sample *sample __maybe_unused)
> +{
> +	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_prog_info_node *info_node;
> +	struct perf_env *env = machine->env;
> +	int id = event->bpf_event.id;
> +	unsigned int i;
> +
> +	/* perf-record, no need to handle bpf-event */
> +	if (env == NULL)
> +		return 0;
> +
> +	info_node = perf_env__find_bpf_prog_info(env, id);
> +	if (!info_node)
> +		return 0;
> +	info_linear = info_node->info_linear;
> +
> +	for (i = 0; i < info_linear->info.nr_jited_ksyms; i++) {
> +		u64 *addrs = (u64 *)(info_linear->info.jited_ksyms);
> +		u64 addr = addrs[i];
> +		struct map *map;
> +
> +		map = map_groups__find(&machine->kmaps, addr);
> +
> +		if (map) {
> +			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
> +			map->dso->bpf_prog.id = id;
> +			map->dso->bpf_prog.sub_id = i;
> +			map->dso->bpf_prog.env = env;
> +		}
> +	}
> +	return 0;
> +}
> +
>  int machine__process_bpf_event(struct machine *machine __maybe_unused,
>  			       union perf_event *event,
>  			       struct perf_sample *sample __maybe_unused)
>  {
>  	if (dump_trace)
>  		perf_event__fprintf_bpf_event(event, stdout);
> +
> +	switch (event->bpf_event.type) {
> +	case PERF_BPF_EVENT_PROG_LOAD:
> +		return machine__process_bpf_event_load(machine, event, sample);
> +
> +	case PERF_BPF_EVENT_PROG_UNLOAD:
> +		break;
> +	default:
> +		pr_debug("unexpected bpf_event type of %d\n",
> +			 event->bpf_event.type);
> +		break;
> +	}
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index b9ec394dc7c7..ab4a975b7e05 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -2,6 +2,10 @@
>  #ifndef __PERF_BPF_EVENT_H
>  #define __PERF_BPF_EVENT_H
>  
> +#include <bpf/bpf.h>
> +#include <bpf/btf.h>
> +#include <bpf/libbpf.h>
> +#include <linux/btf.h>
>  #include <linux/compiler.h>
>  #include <linux/rbtree.h>
>  #include "event.h"
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 62c8cf622607..1798192bf0f9 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -181,6 +181,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
>  	case DSO_BINARY_TYPE__KALLSYMS:
>  	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
>  	case DSO_BINARY_TYPE__JAVA_JIT:
> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
>  	case DSO_BINARY_TYPE__NOT_FOUND:
>  		ret = -1;
>  		break;
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 8c8a7abe809d..f20d319463f1 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -14,6 +14,8 @@
>  #include "namespaces.h"
>  #include "build-id.h"
>  
> +struct perf_env;
> +
>  enum dso_binary_type {
>  	DSO_BINARY_TYPE__KALLSYMS = 0,
>  	DSO_BINARY_TYPE__GUEST_KALLSYMS,
> @@ -34,6 +36,7 @@ enum dso_binary_type {
>  	DSO_BINARY_TYPE__KCORE,
>  	DSO_BINARY_TYPE__GUEST_KCORE,
>  	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> +	DSO_BINARY_TYPE__BPF_PROG_INFO,
>  	DSO_BINARY_TYPE__NOT_FOUND,
>  };
>  
> @@ -177,17 +180,25 @@ struct dso {
>  	struct auxtrace_cache *auxtrace_cache;
>  	int		 comp;
>  
> -	/* dso data file */
> -	struct {
> -		struct rb_root	 cache;
> -		int		 fd;
> -		int		 status;
> -		u32		 status_seen;
> -		size_t		 file_size;
> -		struct list_head open_entry;
> -		u64		 debug_frame_offset;
> -		u64		 eh_frame_hdr_offset;
> -	} data;
> +	union {
> +		/* dso data file */
> +		struct {
> +			struct rb_root	 cache;
> +			int		 fd;
> +			int		 status;
> +			u32		 status_seen;
> +			size_t		 file_size;
> +			struct list_head open_entry;
> +			u64		 debug_frame_offset;
> +			u64		 eh_frame_hdr_offset;
> +		} data;
> +		/* bpf prog information */
> +		struct {
> +			u32		id;
> +			u32		sub_id;
> +			struct perf_env	*env;
> +		} bpf_prog;
> +	};
>  
>  	union { /* Tool specific area */
>  		void	 *priv;
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 48efad6d0f90..33ae59e89da2 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1441,6 +1441,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
>  	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
>  		return true;
>  
> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
>  	case DSO_BINARY_TYPE__NOT_FOUND:
>  	default:
>  		return false;
> -- 
> 2.17.1
> 
