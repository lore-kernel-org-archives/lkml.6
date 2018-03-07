Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbeCGT1m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:27:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753949AbeCGT1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:27:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD7E2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 16:27:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 08/19] perf tools: Add mem2node object
Message-ID: <20180307192736.GS3701@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
 <20180307155020.32613-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307155020.32613-9-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 04:50:09PM +0100, Jiri Olsa escreveu:
> Adding mem2node object to allow the easy lookup
> of the node for the physical address.
> 
> It has following interface:
> 
>   int  mem2node__init(struct mem2node *map, struct perf_env *env);
>   void mem2node__exit(struct mem2node *map);
>   int  mem2node__node(struct mem2node *map, u64 addr);
> 
> The mem2node__init initialize object from the perf data
> file MEM_TOPOLOGY feature data. Following calls to
> mem2node__node will return node number for given
> physical address. The mem2node__exit function frees
> the object.
> 
> Link: http://lkml.kernel.org/n/tip-qq7sohu774wxq154n3my037z@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/Build      |   1 +
>  tools/perf/util/mem2node.c | 129 +++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/mem2node.h |  19 +++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 tools/perf/util/mem2node.c
>  create mode 100644 tools/perf/util/mem2node.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index ea0a452550b0..8052373bcd6a 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -106,6 +106,7 @@ libperf-y += units.o
>  libperf-y += time-utils.o
>  libperf-y += expr-bison.o
>  libperf-y += branch.o
> +libperf-y += mem2node.o
>  
>  libperf-$(CONFIG_LIBBPF) += bpf-loader.o
>  libperf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
> diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
> new file mode 100644
> index 000000000000..6da8ddbb1182
> --- /dev/null
> +++ b/tools/perf/util/mem2node.c
> @@ -0,0 +1,129 @@
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <linux/bitmap.h>
> +#include "mem2node.h"
> +#include "util.h"
> +
> +struct entry {
> +	struct rb_node	rb_node;
> +	u64	start;
> +	u64	end;
> +	u64	node;
> +};

Hey, this name is way too generic, please rename it to something more
descriptive

> +
> +static void entry__insert(struct entry *entry, struct rb_root *root)
> +{
> +	struct rb_node **p = &root->rb_node;
> +	struct rb_node *parent = NULL;
> +	struct entry *e;
> +
> +	while (*p != NULL) {
> +		parent = *p;
> +		e = rb_entry(parent, struct entry, rb_node);
> +
> +		if (entry->start < e->start)
> +			p = &(*p)->rb_left;
> +		else
> +			p = &(*p)->rb_right;
> +	}
> +
> +	rb_link_node(&entry->rb_node, parent, p);
> +	rb_insert_color(&entry->rb_node, root);
> +}
> +
> +int mem2node__init(struct mem2node *map, struct perf_env *env)
> +{
> +	struct memory_node *n, *nodes = &env->memory_nodes[0];
> +	u64 bsize = env->memory_bsize;
> +	struct entry *entry;
> +	int i, j = 0, max = 0;
> +
> +	memset(map, 0x0, sizeof(*map));
> +	map->root = RB_ROOT;
> +
> +	for (i = 0; i < env->nr_memory_nodes; i++) {
> +		n = &nodes[i];
> +		max += bitmap_weight(n->set, n->size);
> +	}
> +
> +	entry = zalloc(sizeof(*entry) * max);
> +	if (!entry)
> +		return -ENOMEM;

Also this is not an 'entry', but max ones, please rename this variable
to 'entries'.

> +
> +	for (i = 0; i < env->nr_memory_nodes; i++) {
> +		u64 bit;
> +
> +		n = &nodes[i];
> +
> +		for (bit = 0; bit < n->size; bit++) {
> +			u64 start;
> +
> +			if (!test_bit(bit, n->set))
> +				continue;
> +
> +			start = bit * bsize;
> +
> +			/*
> +			 * Merge nearby areas, we walk in order
> +			 * through the bitmap, so no need to sort.
> +			 */
> +			if (j > 0) {
> +				struct entry *prev = &entry[j - 1];
> +
> +				if ((prev->end == start) &&
> +				    (prev->node == n->node)) {
> +					prev->end += bsize;
> +					continue;
> +				}
> +			}
> +
> +			entry[j].start = start;
> +			entry[j].end   = start + bsize;
> +			entry[j].node  = n->node;
> +			RB_CLEAR_NODE(&entry[j].rb_node);

The previous four line could be done via the usual:

			krava_entry__init(&entries[j], start, bsize, n->node);

> +			j++;
> +		}
> +	}
> +
> +	/* Cut unused entries, due to merging. */
> +	entry = realloc(entry, sizeof(*entry) * j);
> +	if (!entry)
> +		return -ENOMEM;


Humm, so you lose it when not able to cut it short? Why not:

	nentries = realloc(entries, sizeof(entries[0) * j);
	if (nentries)
		entries = nentries;

And if you couldn't cut it (however unlikely that is) just go on and use
what you have already.

> +
> +	for (i = 0; i < j; i++) {
> +		pr_debug("mem2node %03" PRIu64 " [0x%016" PRIx64 "-0x%016" PRIx64 "]\n",
> +			 entry[i].node, entry[i].start, entry[i].end);
> +
> +		entry__insert(&entry[i], &map->root);
> +	}
> +
> +	map->entry = entry;
> +	return 0;
> +}
> +
> +void mem2node__exit(struct mem2node *map)
> +{
> +	zfree(&map->entry);
> +}
> +
> +int mem2node__node(struct mem2node *map, u64 addr)
> +{
> +	struct rb_node **p, *parent = NULL;
> +	struct entry *entry;
> +
> +	p = &map->root.rb_node;
> +	while (*p != NULL) {
> +		parent = *p;
> +		entry = rb_entry(parent, struct entry, rb_node);
> +		if (addr < entry->start)
> +			p = &(*p)->rb_left;
> +		else if (addr >= entry->end)
> +			p = &(*p)->rb_right;
> +		else
> +			goto out;
> +	}
> +
> +	entry = NULL;
> +out:
> +	return entry ? (int) entry->node : -1;
> +}
> diff --git a/tools/perf/util/mem2node.h b/tools/perf/util/mem2node.h
> new file mode 100644
> index 000000000000..e27333755a2c
> --- /dev/null
> +++ b/tools/perf/util/mem2node.h
> @@ -0,0 +1,19 @@
> +#ifndef __MEM2NODE_H
> +#define __MEM2NODE_H
> +
> +#include <linux/rbtree.h>
> +#include "env.h"
> +
> +struct entry;
> +
> +struct mem2node {
> +	struct rb_root	 root;
> +	struct entry	*entry;
> +	int		 cnt;
> +};
> +
> +int  mem2node__init(struct mem2node *map, struct perf_env *env);
> +void mem2node__exit(struct mem2node *map);
> +int  mem2node__node(struct mem2node *map, u64 addr);
> +
> +#endif /* __MEM2NODE_H */
> -- 
> 2.13.6
