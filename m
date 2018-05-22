Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeEVQnM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:43:12 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:50626 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751404AbeEVQnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:43:03 -0400
Date: Tue, 22 May 2018 16:43:02 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Andrew Morton <akpm@linux-foundation.org>
cc: Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@kernel.org>,
        Greg Thelen <gthelen@google.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        Linux MM <linux-mm@kvack.org>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix race between kmem_cache destroy, create and
 deactivate
In-Reply-To: <20180521114227.233983ac7038a9f4bf5b7066@linux-foundation.org>
Message-ID: <0100016388bb8ade-de95df0e-6154-4ddc-98bb-ee33811cca85-000000@email.amazonses.com>
References: <20180521174116.171846-1-shakeelb@google.com> <20180521114227.233983ac7038a9f4bf5b7066@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.22-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018, Andrew Morton wrote:

> The patch seems depressingly complex.
>
> And a bit underdocumented...

Maybe separate out the bits that rename refcount to alias_count?

> > +	refcount_t refcount;
> > +	int alias_count;
>
> The semantic meaning of these two?  What locking protects alias_count?

slab_mutex

>
> >  	int object_size;
> >  	int align;
> >
> > diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> > index 3773e26c08c1..532d4b6f83ed 100644
> > --- a/include/linux/slub_def.h
> > +++ b/include/linux/slub_def.h
> > @@ -97,7 +97,8 @@ struct kmem_cache {
> >  	struct kmem_cache_order_objects max;
> >  	struct kmem_cache_order_objects min;
> >  	gfp_t allocflags;	/* gfp flags to use on each alloc */
> > -	int refcount;		/* Refcount for slab cache destroy */
> > +	refcount_t refcount;	/* Refcount for slab cache destroy */
> > +	int alias_count;	/* Number of root kmem caches merged */
>
> "merged" what with what in what manner?

That is a basic SLUB feature.
