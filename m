Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeCZOaW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:30:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751926AbeCZOaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:30:21 -0400
Date: Mon, 26 Mar 2018 22:30:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, prudo@linux.vnet.ibm.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        takahiro.akashi@linaro.org, ebiederm@xmission.com, dyoung@redhat.com,
        vgoyal@redhat.com
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-ID: <20180326143016.GE25740@localhost.localdomain>
References: <20180322033722.9279-1-bhe@redhat.com>
 <20180322033722.9279-2-bhe@redhat.com>
 <20180322152929.9b421af2f66cc819ad691207@linux-foundation.org>
 <20180323005845.GA25740@localhost.localdomain>
 <20180322190606.859a0f1c7e2d1b2958daeb9f@linux-foundation.org>
 <20180323031013.GB11150@localhost.localdomain>
 <20180323130620.7d60fc442463ed5c21898387@linux-foundation.org>
 <20180324133330.GD25740@localhost.localdomain>
 <20180324161343.GA58414@WeideMacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324161343.GA58414@WeideMacBook-Pro.local>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei Yang,

On 03/25/18 at 12:13am, Wei Yang wrote:
> On Sat, Mar 24, 2018 at 09:33:30PM +0800, Baoquan He wrote:
> >> 
> >> Yes.  That sounds perfectly acceptable.
> >> 
> >> It would be interesting to see what this approach looks like, if you
> >> have time to toss something together?
> >
> >OK, will make patches for reviewing. Thanks!
> 
> Hi, Baoquan, Andrew
> 
> I have come up with an implementation for top-down search the ram resources.
> Hope this would meet your need.

Thanks for telling and your effort. Glad to know
I am not the only buyer of walk_system_ram_res_rev. I am fine with other
ways to make it, people can compare them and know which one is better.
I am working to use the list_head instead, the doubly linked list way
as Andrew suggested. Andrew and other people can help make a choice. It
won't be long.

Thanks
Baoquan

> 
> From b36d50487f1d4e4d6a5103965a27101b3121e0ea Mon Sep 17 00:00:00 2001
> From: Wei Yang <richard.weiyang@gmail.com>
> Date: Sat, 24 Mar 2018 23:25:46 +0800
> Subject: [PATCH] kernel/resource: add walk_system_ram_res_rev()
> 
> As discussed on https://patchwork.kernel.org/patch/10300819/, this patch
> comes up with a variant implementation of walk_system_ram_res_rev(), which
> uses iteration instead of allocating array to store those resources.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  include/linux/ioport.h |   3 ++
>  kernel/resource.c      | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..473f1d9cb97e 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -277,6 +277,9 @@ extern int
>  walk_system_ram_res(u64 start, u64 end, void *arg,
>  		    int (*func)(struct resource *, void *));
>  extern int
> +walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +		    int (*func)(struct resource *, void *));
> +extern int
>  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>  		    void *arg, int (*func)(struct resource *, void *));
>  
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 769109f20fb7..ddf6b4c41498 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -73,6 +73,38 @@ static struct resource *next_resource(struct resource *p, bool sibling_only)
>  	return p->sibling;
>  }
>  
> +static struct resource *prev_resource(struct resource *p, bool sibling_only)
> +{
> +	struct resource *prev;
> +	if (NULL == iomem_resource.child)
> +		return NULL;
> +
> +	if (p == NULL) {
> +		prev = iomem_resource.child;
> +		while (prev->sibling)
> +			prev = prev->sibling;
> +	} else {
> +		if (p->parent->child == p) {
> +			return p->parent;
> +		}
> +
> +		for (prev = p->parent->child; prev->sibling != p;
> +			prev = prev->sibling) {}
> +	}
> +
> +	/* Caller wants to traverse through siblings only */
> +	if (sibling_only)
> +		return prev;
> +
> +	for (;prev->child;) {
> +		prev = prev->child;
> +
> +		while (prev->sibling)
> +			prev = prev->sibling;
> +	}
> +	return prev;
> +}
> +
>  static void *r_next(struct seq_file *m, void *v, loff_t *pos)
>  {
>  	struct resource *p = v;
> @@ -401,6 +433,47 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
>  	return 0;
>  }
>  
> +/*
> + * Finds the highest iomem resource existing within [res->start.res->end).
> + * The caller must specify res->start, res->end, res->flags, and optionally
> + * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
> + * This function walks the whole tree and not just first level children until
> + * and unless first_level_children_only is true.
> + */
> +static int find_prev_iomem_res(struct resource *res, unsigned long desc,
> +			       bool first_level_children_only)
> +{
> +	struct resource *p;
> +
> +	BUG_ON(!res);
> +	BUG_ON(res->start >= res->end);
> +
> +	read_lock(&resource_lock);
> +
> +	for (p = prev_resource(NULL, first_level_children_only); p;
> +		p = prev_resource(p, first_level_children_only)) {
> +		if ((p->flags & res->flags) != res->flags)
> +			continue;
> +		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
> +			continue;
> +		if (p->end < res->start) {
> +			p = NULL;
> +			break;
> +		}
> +		if ((p->end >= res->start) && (p->start < res->end))
> +			break;
> +	}
> +
> +	read_unlock(&resource_lock);
> +	if (!p)
> +		return -1;
> +	/* copy data */
> +	resource_clip(res, p->start, p->end);
> +	res->flags = p->flags;
> +	res->desc = p->desc;
> +	return 0;
> +}
> +
>  static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>  				 bool first_level_children_only,
>  				 void *arg,
> @@ -422,6 +495,27 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>  	return ret;
>  }
>  
> +static int __walk_iomem_res_rev_desc(struct resource *res, unsigned long desc,
> +				 bool first_level_children_only,
> +				 void *arg,
> +				 int (*func)(struct resource *, void *))
> +{
> +	u64 orig_start = res->start;
> +	int ret = -1;
> +
> +	while ((res->start < res->end) &&
> +	       !find_prev_iomem_res(res, desc, first_level_children_only)) {
> +		ret = (*func)(res, arg);
> +		if (ret)
> +			break;
> +
> +		res->end = res->start - 1;
> +		res->start = orig_start;
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * Walks through iomem resources and calls func() with matching resource
>   * ranges. This walks through whole tree and not just first level children.
> @@ -468,6 +562,25 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>  				     arg, func);
>  }
>  
> +/*
> + * This function, being a variant of walk_system_ram_res(), calls the @func
> + * callback against all memory ranges of type System RAM which are marked as
> + * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
> + * higher to lower.
> + */
> +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +				int (*func)(struct resource *, void *))
> +{
> +	struct resource res;
> +
> +	res.start = start;
> +	res.end = end;
> +	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +
> +	return __walk_iomem_res_rev_desc(&res, IORES_DESC_NONE, true,
> +				     arg, func);
> +}
> +
>  /*
>   * This function calls the @func callback against all memory ranges, which
>   * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
> -- 
> 2.15.1
> 
> 
> -- 
> Wei Yang
> Help you, Help me
