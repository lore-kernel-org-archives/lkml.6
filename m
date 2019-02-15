Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49812C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209AD2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406146AbfBOO0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:26:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25661 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfBOO0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:26:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91274653C8;
        Fri, 15 Feb 2019 14:26:47 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-32.phx2.redhat.com [10.3.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 983525C5E0;
        Fri, 15 Feb 2019 14:26:46 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 2063855C4; Fri, 15 Feb 2019 12:26:43 -0200 (BRST)
Date:   Fri, 15 Feb 2019 12:26:43 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, namhyung@kernel.org, acme@kernel.org
Subject: Re: [PATCH v2 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190215142643.GC5784@redhat.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000010.2590505-1-songliubraving@fb.com>
 <20190215000010.2590505-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215000010.2590505-7-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 15 Feb 2019 14:26:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 14, 2019 at 04:00:09PM -0800, Song Liu escreveu:
> This patch enables perf-record to save btf information as headers to
> perf.data A new header type HEADER_BTF is introduced for this data.

Jiri,

	Wouldn't it be better for this HEADER_BTF to be introduced
already as an user space event, Song, see:

  tools/perf/util/event.h

and:

  tools/perf/util/event.c

perf_event__synthesize_cpu_map()

- Arnaldo

 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/header.c | 99 +++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/header.h |  1 +
>  2 files changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 2ae76a9d06f6..3f1562afe8e5 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1125,6 +1125,45 @@ static int write_bpf_prog_info(struct feat_fd *ff,
>  	return ret;
>  }
>  
> +static int write_btf(struct feat_fd *ff,
> +		     struct perf_evlist *evlist __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	struct rb_root *root;
> +	struct rb_node *next;
> +	u32 count = 0;
> +	int ret;
> +
> +	down_read(&env->bpf_info_lock);
> +
> +	root = &env->btfs;
> +	next = rb_first(root);
> +	while (next) {
> +		++count;
> +		next = rb_next(next);
> +	}
> +
> +	ret = do_write(ff, &count, sizeof(count));
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	next = rb_first(root);
> +	while (next) {
> +		struct btf_node *node;
> +
> +		node = rb_entry(next, struct btf_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		ret = do_write(ff, node,
> +			       sizeof(struct btf_node) + node->data_size);
> +		if (ret < 0)
> +			goto out;
> +	}
> +out:
> +	up_read(&env->bpf_info_lock);
> +	return ret;
> +}
> +
>  static int cpu_cache_level__sort(const void *a, const void *b)
>  {
>  	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
> @@ -1628,6 +1667,28 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
>  	up_read(&env->bpf_info_lock);
>  }
>  
> +static void print_btf(struct feat_fd *ff, FILE *fp)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	struct rb_root *root;
> +	struct rb_node *next;
> +
> +	down_read(&env->bpf_info_lock);
> +
> +	root = &env->btfs;
> +	next = rb_first(root);
> +
> +	while (next) {
> +		struct btf_node *node;
> +
> +		node = rb_entry(next, struct btf_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		fprintf(fp, "# bpf_prog_info of id %u\n", node->id);
> +	}
> +
> +	up_read(&env->bpf_info_lock);
> +}
> +
>  static void free_event_desc(struct perf_evsel *events)
>  {
>  	struct perf_evsel *evsel;
> @@ -2723,6 +2784,41 @@ static int process_bpf_prog_info(struct feat_fd *ff,
>  	return err;
>  }
>  
> +static int process_btf(struct feat_fd *ff, void *data __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	u32 count, i;
> +
> +	if (do_read_u32(ff, &count))
> +		return -1;
> +
> +	down_write(&env->bpf_info_lock);
> +
> +	for (i = 0; i < count; ++i) {
> +		struct btf_node btf_node;
> +		struct btf_node *node;
> +
> +		if (__do_read(ff, &btf_node, sizeof(struct btf_node)))
> +			return -1;
> +
> +		node = malloc(sizeof(struct btf_node) + btf_node.data_size);
> +		if (!node)
> +			return -1;
> +
> +		node->id = btf_node.id;
> +		node->data_size = btf_node.data_size;
> +
> +		if (__do_read(ff, node->data, btf_node.data_size)) {
> +			free(node);
> +			return -1;
> +		}
> +		perf_env__insert_btf(env, node);
> +	}
> +
> +	up_write(&env->bpf_info_lock);
> +	return 0;
> +}
> +
>  struct feature_ops {
>  	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
>  	void (*print)(struct feat_fd *ff, FILE *fp);
> @@ -2783,7 +2879,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
>  	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
>  	FEAT_OPR(CLOCKID,       clockid,        false),
> -	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false)
> +	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
> +	FEAT_OPR(BTF,           btf,            false)
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 0785c91b4c3a..ba51d8e43c53 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -40,6 +40,7 @@ enum {
>  	HEADER_MEM_TOPOLOGY,
>  	HEADER_CLOCKID,
>  	HEADER_BPF_PROG_INFO,
> +	HEADER_BTF,
>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> -- 
> 2.17.1
