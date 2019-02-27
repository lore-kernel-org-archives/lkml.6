Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F44C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7852133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfB0NV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:21:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0NV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:21:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9C1CACB2;
        Wed, 27 Feb 2019 13:21:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 458675C882;
        Wed, 27 Feb 2019 13:21:25 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:21:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v4 perf,bpf 06/15] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Message-ID: <20190227132123.GE18893@krava>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226002019.3748539-7-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 27 Feb 2019 13:21:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 04:20:10PM -0800, Song Liu wrote:
> bpf_prog_info contains information necessary to annotate bpf programs.
> This patch saves bpf_prog_info for bpf programs loaded in the system.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/bpf-event.c | 32 +++++++++++++-
>  tools/perf/util/bpf-event.h |  7 ++-
>  tools/perf/util/env.c       | 85 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/env.h       | 17 ++++++++
>  4 files changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index ff7ee149ec46..ce81b2c43a51 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -10,6 +10,7 @@
>  #include "debug.h"
>  #include "symbol.h"
>  #include "machine.h"
> +#include "env.h"
>  #include "session.h"
>  
>  #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
> @@ -54,17 +55,28 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  	struct bpf_event *bpf_event = &event->bpf_event;
>  	struct bpf_prog_info_linear *info_linear;
>  	struct perf_tool *tool = session->tool;
> +	struct bpf_prog_info_node *info_node;
>  	struct bpf_prog_info *info;
>  	struct btf *btf = NULL;
>  	bool has_btf = false;
> +	struct perf_env *env;
>  	u32 sub_prog_cnt, i;
>  	int err = 0;
>  	u64 arrays;
>  
> +	/*
> +	 * for perf-record and perf-report use header.env;
> +	 * otherwise, use global perf_env.
> +	 */
> +	env = session->data ? &session->header.env : &perf_env;
> +
>  	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
>  	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
>  	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
>  	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
> +	arrays |= 1UL << BPF_PROG_INFO_JITED_INSNS;
> +	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
> +	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
>  
>  	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
>  	if (IS_ERR_OR_NULL(info_linear)) {
> @@ -153,8 +165,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  						     machine, process);
>  	}
>  
> -	/* Synthesize PERF_RECORD_BPF_EVENT */
>  	if (opts->bpf_event) {
> +		/* Synthesize PERF_RECORD_BPF_EVENT */
>  		*bpf_event = (struct bpf_event){
>  			.header = {
>  				.type = PERF_RECORD_BPF_EVENT,
> @@ -167,6 +179,24 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
>  		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
>  		event->header.size += machine->id_hdr_size;
> +
> +		/* save bpf_prog_info to env */

why do we save this to perf_env in here? we just
synthesize the same data as event, so report and
top will read it and fill perf_env again, right?

could you please explain the whole flow of the
bpf events and its respective data in perf_env
and put it into the changelog

> +		info_node = malloc(sizeof(struct bpf_prog_info_node));
> +
> +		/*
> +		 * Do not bail out for !info_node, as we still want to
> +		 * call  perf_tool__process_synth_event()

well, we are out of memory, so I dont think perf_tool__process_synth_event
will get too far.. also the perf_env data would be inconsistent with what
you store as event.. how can that work?

thanks,
jirka

> +		 */
> +		if (info_node) {
> +			info_node->info_linear = info_linear;
> +			perf_env__insert_bpf_prog_info(env, info_node);
> +			info_linear = NULL;
> +		}
> +

SNIP
