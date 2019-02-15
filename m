Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA9EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040D42192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbfBOObC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:31:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbfBOObC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:31:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03ED3C0B2C7F;
        Fri, 15 Feb 2019 14:31:00 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-32.phx2.redhat.com [10.3.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4F5926E7C;
        Fri, 15 Feb 2019 14:30:59 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id D0E2C55C4; Fri, 15 Feb 2019 12:30:55 -0200 (BRST)
Date:   Fri, 15 Feb 2019 12:30:55 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v2 perf,bpf 07/11] perf, bpf: save btf in a rbtree in
 perf_env
Message-ID: <20190215143055.GE5784@redhat.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000010.2590505-1-songliubraving@fb.com>
 <20190215000010.2590505-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215000010.2590505-6-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 15 Feb 2019 14:31:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 14, 2019 at 04:00:08PM -0800, Song Liu escreveu:
> btf contains information necessary to annotate bpf programs. This patch
> saves btf for bpf programs loaded in the system.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/bpf-event.c | 22 +++++++++++++
>  tools/perf/util/bpf-event.h |  7 ++++
>  tools/perf/util/env.c       | 65 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/env.h       |  3 ++
>  4 files changed, 97 insertions(+)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index ead599bc4f4e..37a5b8134e00 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -30,6 +30,27 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
>  	return 0;
>  }
>  
> +static int perf_fetch_btf(struct perf_env *env, u32 btf_id, struct btf *btf)

Please use perf_env__fetch_bpf

> +{
> +	struct btf_node *node;
> +	u32 data_size;
> +	const void *data;
> +
> +	data = btf__get_raw_data(btf, &data_size);
> +
> +	node = malloc(data_size + sizeof(struct btf_node));
> +
> +	if (!node)
> +		return -1;
> +
> +	node->id = btf_id;
> +	node->data_size = data_size;
> +	memcpy(node->data, data, data_size);
> +
> +	perf_env__insert_btf(env, node);

Just like you did above :-)

> +	return 0;
> +}
> +
>  /*
>   * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
>   * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
> @@ -109,6 +130,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  			goto out;
>  		}
>  		has_btf = true;
> +		perf_fetch_btf(env, info->btf_id, btf);
>  	}
>  
>  	/* Synthesize PERF_RECORD_KSYMBOL */
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index 11e6730b6105..60ce24e4e5c6 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -20,6 +20,13 @@ struct bpf_prog_info_node {
>  	struct rb_node			rb_node;
>  };
>  
> +struct btf_node {
> +	struct rb_node	rb_node;
> +	u32		id;
> +	u32		data_size;
> +	char		data[];
> +};
> +
>  #ifdef HAVE_LIBBPF_SUPPORT
>  int machine__process_bpf_event(struct machine *machine, union perf_event *event,
>  			       struct perf_sample *sample);
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 665b6fe3c7b2..6f9e3d4b94bc 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -61,6 +61,57 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
>  	return node;
>  }
>  
> +void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
> +{
> +	struct rb_node *parent = NULL;
> +	__u32 btf_id = btf_node->id;
> +	struct btf_node *node;
> +	struct rb_node **p;
> +
> +	down_write(&env->bpf_info_lock);
> +	p = &env->btfs.rb_node;
> +
> +	while (*p != NULL) {
> +		parent = *p;
> +		node = rb_entry(parent, struct btf_node, rb_node);
> +		if (btf_id < node->id) {
> +			p = &(*p)->rb_left;
> +		} else if (btf_id > node->id) {
> +			p = &(*p)->rb_right;
> +		} else {
> +			pr_debug("duplicated btf %u\n", btf_id);

			goto out:

> +			up_write(&env->bpf_info_lock);
> +			return;
> +		}
> +	}
> +
> +	rb_link_node(&btf_node->rb_node, parent, p);
> +	rb_insert_color(&btf_node->rb_node, &env->btfs);
out:
> +	up_write(&env->bpf_info_lock);
> +}
> +
> +struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
> +{
> +	struct btf_node *node = NULL;
> +	struct rb_node *n;
> +
> +	down_read(&env->bpf_info_lock);
> +	n = env->btfs.rb_node;
> +
> +	while (n) {
> +		node = rb_entry(n, struct btf_node, rb_node);
> +		if (btf_id < node->id)
> +			n = n->rb_left;
> +		else if (btf_id > node->id)
> +			n = n->rb_right;
> +		else
> +			break;
> +	}
> +
> +	up_read(&env->bpf_info_lock);
> +	return node;
> +}
> +
>  /* purge data in bpf_prog_infos tree */
>  static void purge_bpf_info(struct perf_env *env)

The above should've been perf_env__purge_bpf()

>  {
> @@ -80,6 +131,19 @@ static void purge_bpf_info(struct perf_env *env)
>  		rb_erase_init(&node->rb_node, root);
>  		free(node);
>  	}
> +
> +	root = &env->btfs;
> +	next = rb_first(root);
> +
> +	while (next) {
> +		struct btf_node *node;
> +
> +		node = rb_entry(next, struct btf_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		rb_erase_init(&node->rb_node, root);
> +		free(node);
> +	}
> +
>  	up_write(&env->bpf_info_lock);
>  }
>  
> @@ -117,6 +181,7 @@ void perf_env__exit(struct perf_env *env)
>  static void init_bpf_rb_trees(struct perf_env *env)
>  {
>  	env->bpf_prog_infos = RB_ROOT;
> +	env->btfs = RB_ROOT;
>  	init_rwsem(&env->bpf_info_lock);
>  }
>  
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index a6d25e91bc98..f0c74255423c 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -74,6 +74,7 @@ struct perf_env {
>  	 */
>  	struct rw_semaphore	bpf_info_lock;
>  	struct rb_root		bpf_prog_infos;
> +	struct rb_root		btfs;
>  };
>  
>  extern struct perf_env perf_env;
> @@ -94,4 +95,6 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
>  				    struct bpf_prog_info_node *info_node);
>  struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
>  							__u32 prog_id);
> +void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
> +struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
>  #endif /* __PERF_ENV_H */
> -- 
> 2.17.1
