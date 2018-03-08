Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755888AbeCHM6z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755256AbeCHM6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:58:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF79206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 8 Mar 2018 09:58:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 08/19] perf tools: Add mem2node object
Message-ID: <20180308125849.GA3701@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
 <20180307155020.32613-9-jolsa@kernel.org>
 <20180307192736.GS3701@kernel.org>
 <20180308110306.GB13693@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308110306.GB13693@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 08, 2018 at 12:03:07PM +0100, Jiri Olsa escreveu:
> On Wed, Mar 07, 2018 at 04:27:36PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > > diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
> > > new file mode 100644
> > > index 000000000000..6da8ddbb1182
> > > --- /dev/null
> > > +++ b/tools/perf/util/mem2node.c
> > > @@ -0,0 +1,129 @@
> > > +#include <errno.h>
> > > +#include <inttypes.h>
> > > +#include <linux/bitmap.h>
> > > +#include "mem2node.h"
> > > +#include "util.h"
> > > +
> > > +struct entry {
> > > +	struct rb_node	rb_node;
> > > +	u64	start;
> > > +	u64	end;
> > > +	u64	node;
> > > +};
> > 
> > Hey, this name is way too generic, please rename it to something more
> > descriptive
> 
> ok, will change
> 
> > 
> > > +
> > > +static void entry__insert(struct entry *entry, struct rb_root *root)
> > > +{
> > > +	struct rb_node **p = &root->rb_node;
> > > +	struct rb_node *parent = NULL;
> > > +	struct entry *e;
> > > +
> > > +	while (*p != NULL) {
> > > +		parent = *p;
> > > +		e = rb_entry(parent, struct entry, rb_node);
> > > +
> > > +		if (entry->start < e->start)
> > > +			p = &(*p)->rb_left;
> > > +		else
> > > +			p = &(*p)->rb_right;
> > > +	}
> > > +
> > > +	rb_link_node(&entry->rb_node, parent, p);
> > > +	rb_insert_color(&entry->rb_node, root);
> > > +}
> > > +
> > > +int mem2node__init(struct mem2node *map, struct perf_env *env)
> > > +{
> > > +	struct memory_node *n, *nodes = &env->memory_nodes[0];
> > > +	u64 bsize = env->memory_bsize;
> > > +	struct entry *entry;
> > > +	int i, j = 0, max = 0;
> > > +
> > > +	memset(map, 0x0, sizeof(*map));
> > > +	map->root = RB_ROOT;
> > > +
> > > +	for (i = 0; i < env->nr_memory_nodes; i++) {
> > > +		n = &nodes[i];
> > > +		max += bitmap_weight(n->set, n->size);
> > > +	}
> > > +
> > > +	entry = zalloc(sizeof(*entry) * max);
> > > +	if (!entry)
> > > +		return -ENOMEM;
> > 
> > Also this is not an 'entry', but max ones, please rename this variable
> > to 'entries'.
> 
> ok
> 
> 
> SNIP
> 
> > > +
> > > +			entry[j].start = start;
> > > +			entry[j].end   = start + bsize;
> > > +			entry[j].node  = n->node;
> > > +			RB_CLEAR_NODE(&entry[j].rb_node);
> > 
> > The previous four line could be done via the usual:
> > 
> > 			krava_entry__init(&entries[j], start, bsize, n->node);
> 
> ook
> 
> > 
> > > +			j++;
> > > +		}
> > > +	}
> > > +
> > > +	/* Cut unused entries, due to merging. */
> > > +	entry = realloc(entry, sizeof(*entry) * j);
> > > +	if (!entry)
> > > +		return -ENOMEM;
> > 
> > 
> > Humm, so you lose it when not able to cut it short? Why not:
> 
> just shortening the memory, because some entries merge together
> 
> 
> > 
> > 	nentries = realloc(entries, sizeof(entries[0) * j);
> > 	if (nentries)
> > 		entries = nentries;
> 
> I don't think we need nentries.. AFAIK realloc works ok over single variable

So:

1) you alloc entries with a max number of entries

2) you go on populating it

3) there are some left, lets shrink it:

	entries = realloc(entries, nr_entries * sizeof(entries[0]);

Here it will probably not fail, but you check it anyway, and that is
right, what happens if this returns NULL? entries gets set to NULL,
we lose the reference to the allocated memory and you return -ENOMEM,
right?

We end up leaking entries when what I'm suggesting you to do is to
not clobber entries with the return of realloc() (doing it this way most
of the time leads to bugs), but instead store it to a temp var
(nentries), and if it succeeds, then you know that you can
set nentries to entries and go ahead with your nicely shrunk block of
memory.

If it fails, then you continue with the original block of memory, that
continues to have what you just set up, etc.

Lemme look a third time to your original patch, I must be missing
something...

- Arnaldo
